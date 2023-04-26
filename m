Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25566EEF17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 09:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbjDZHSZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 03:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbjDZHSU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F523A84;
        Wed, 26 Apr 2023 00:17:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9169662B5F;
        Wed, 26 Apr 2023 07:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95666C433EF;
        Wed, 26 Apr 2023 07:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682492868;
        bh=2o6kaGsCFO97KPH7lPad22AOk5j+21G5SxH089QMJIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dNtuA6Zwr2oC++Hau2Eev6ellEt8Arrfgv2YyDVHEkR2gFZuwQ/Yig3nYyNE3h8FW
         juPQH+WF6aUh/Cfijao/pYEmv8x5xgELnE8uzJsxMB9lQf6O0DNO47ZqIvwWSEG5UA
         3eTP+oL6u2BAG93O++dZpkXCidaUifWDg1UzIg4hPJs7Mx7ZFr9SJf4I68q7ip1PTm
         qIyO6+94cKoYMEbeoaPxNrXk+qB9Z6jrUNGw2Gu8pXpH0re151vMOLCGEgI55mZxbN
         jfzt0KZXKVUH/tvji8A8XfmRgjFgUim8D5FS8/pmdHnlsVMTkJ10vT6Net2usqKU6T
         Yr9mxEp05W9Rg==
Date:   Wed, 26 Apr 2023 09:07:41 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fs: add infrastructure for multigrain inode
 i_m/ctime
Message-ID: <20230426-bahnanlagen-ausmusterung-4877cbf40d4c@brauner>
References: <20230424151104.175456-1-jlayton@kernel.org>
 <20230424151104.175456-2-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230424151104.175456-2-jlayton@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 11:11:02AM -0400, Jeff Layton wrote:
> The VFS always uses coarse-grained timestamp updates for filling out the
> ctime and mtime after a change. This has the benefit of allowing
> filesystems to optimize away a lot metaupdates, to around once per
> jiffy, even when a file is under heavy writes.
> 
> Unfortunately, this has always been an issue when we're exporting via
> NFSv3, which relies on timestamps to validate caches. Even with NFSv4, a
> lot of exported filesystems don't properly support a change attribute
> and are subject to the same problems with timestamp granularity. Other
> applications have similar issues (e.g backup applications).
> 
> Switching to always using fine-grained timestamps would improve the
> situation for NFS, but that becomes rather expensive, as the underlying
> filesystem will have to log a lot more metadata updates.
> 
> What we need is a way to only use fine-grained timestamps when they are
> being actively queried:
> 
> Whenever the mtime changes, the ctime must also change since we're
> changing the metadata. When a superblock has a s_time_gran >1, we can
> use the lowest-order bit of the inode->i_ctime as a flag to indicate
> that the value has been queried. Then on the next write, we'll fetch a
> fine-grained timestamp instead of the usual coarse-grained one.
> 
> We could enable this for any filesystem that has a s_time_gran >1, but
> for now, this patch adds a new SB_MULTIGRAIN_TS flag to allow filesystems
> to opt-in to this behavior.

Hm, the patch raises the flag in s_flags. Please at least move this to
s_iflags as SB_I_MULTIGRAIN and treat this as an internal flag. There's
no need to give the impression that this will become a mount option.

Also, this looks like it's a filesystem property not a superblock
property as the granularity isn't changeable. So shouldn't this be an
FS_* flag instead?
