Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D53B6F03B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 11:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbjD0Jv0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 05:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243306AbjD0JvV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:51:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6EA4483;
        Thu, 27 Apr 2023 02:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74B5463B9C;
        Thu, 27 Apr 2023 09:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43E0C433D2;
        Thu, 27 Apr 2023 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682589077;
        bh=OKqC/Fnsu1vsusVxdSXuCgCvwxyUCqw4izqcT+HNaXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hAeaNsUlLsGE6JMyqcbDRHusNAJCTXy7GhM0ol00rJtWeNKG023/SBrlPWeP+n9/C
         l18lgbscTr5KK3s5jScZKOXqaxr+4epdOWPQwfeE0T4We84Vb5aIp2kdExOo0UwWmn
         aPZJrVIQsdmz6aHQywpL9ZU8K1OlvFAPwFM4g2cKFCumkf9G/7mffElH2yxOHNlcNN
         l6OEWQjoGs6gl97UrUIyx9Y+wRSRYIu+HGRtxaFv3NDeEHV3ReZavAHuG3TikufKSI
         2TAM+VtWJ3LRvz6AKHuQIZgH8wl7EMM200WwUclIfuajnhYnSbTu9Rn5AA5o2SHd4P
         Yh5hH1sRL+LHg==
Date:   Thu, 27 Apr 2023 11:51:11 +0200
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
Message-ID: <20230427-rebel-vergibt-99cf6a7838a2@brauner>
References: <20230424151104.175456-1-jlayton@kernel.org>
 <20230424151104.175456-2-jlayton@kernel.org>
 <20230426-bahnanlagen-ausmusterung-4877cbf40d4c@brauner>
 <03e91ee4c56829995c08f4f8fb1052d3c6cc40c4.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03e91ee4c56829995c08f4f8fb1052d3c6cc40c4.camel@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 26, 2023 at 05:48:38AM -0400, Jeff Layton wrote:
> On Wed, 2023-04-26 at 09:07 +0200, Christian Brauner wrote:
> > On Mon, Apr 24, 2023 at 11:11:02AM -0400, Jeff Layton wrote:
> > > The VFS always uses coarse-grained timestamp updates for filling out the
> > > ctime and mtime after a change. This has the benefit of allowing
> > > filesystems to optimize away a lot metaupdates, to around once per
> > > jiffy, even when a file is under heavy writes.
> > > 
> > > Unfortunately, this has always been an issue when we're exporting via
> > > NFSv3, which relies on timestamps to validate caches. Even with NFSv4, a
> > > lot of exported filesystems don't properly support a change attribute
> > > and are subject to the same problems with timestamp granularity. Other
> > > applications have similar issues (e.g backup applications).
> > > 
> > > Switching to always using fine-grained timestamps would improve the
> > > situation for NFS, but that becomes rather expensive, as the underlying
> > > filesystem will have to log a lot more metadata updates.
> > > 
> > > What we need is a way to only use fine-grained timestamps when they are
> > > being actively queried:
> > > 
> > > Whenever the mtime changes, the ctime must also change since we're
> > > changing the metadata. When a superblock has a s_time_gran >1, we can
> > > use the lowest-order bit of the inode->i_ctime as a flag to indicate
> > > that the value has been queried. Then on the next write, we'll fetch a
> > > fine-grained timestamp instead of the usual coarse-grained one.
> > > 
> > > We could enable this for any filesystem that has a s_time_gran >1, but
> > > for now, this patch adds a new SB_MULTIGRAIN_TS flag to allow filesystems
> > > to opt-in to this behavior.
> > 
> > Hm, the patch raises the flag in s_flags. Please at least move this to
> > s_iflags as SB_I_MULTIGRAIN and treat this as an internal flag. There's
> > no need to give the impression that this will become a mount option.
> > 
> > Also, this looks like it's a filesystem property not a superblock
> > property as the granularity isn't changeable. So shouldn't this be an
> > FS_* flag instead?
> 
> It could be a per-sb thing if there was some filesystem that wanted to
> do that, but I'm hoping that most will not want to do that.

Yeah, I'd really hope this isn't an sb thing.

> 
> My initial patches for this actually did use a FS_* flag, but I figured

Oh, I might've just missed that.

> that was one more pointer to chase when you wanted to check the flag.

Hm, unless you have reasons to think that it would be noticable in terms
of perf I'd rather do the correct thing and have it be an FS_* flag.
