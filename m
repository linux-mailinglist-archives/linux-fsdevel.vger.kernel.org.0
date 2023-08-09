Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219EA775D72
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 13:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjHILhi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 07:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbjHILhh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:37:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C2EE3
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 04:37:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3032263578
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 11:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A193DC433CC;
        Wed,  9 Aug 2023 11:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691581056;
        bh=FJoooeg67aJXJ8sAVmKmUGj9XYVpvc9JajYCjM5Bi7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nrzJgK9G81CHt7hGXMFo5ihY80acXwrKdKHgIKVPWAQbJjH468Az5Wnc6YkmJvfiW
         PnbOBOfth+0IqNCdMzVP2PSa62X1vQWb3loqsYgkkNFMI/k/ucmeAC5BFMIAa5xZeP
         V68HUgZR5F6Xxa59UXj/Bt2Z7/Z8bi3+svuDOToxUyy+WFRE8PYL/+BCd9z7AsuY30
         vSZDM7R2rjgm1ohWWQtCRNfH4K/MysnbMUTbTuoVnxCTGFQrb2DbfCY0epFfM6gIuW
         jS4Gox3BHI61SrCp8PHjUaSuDiSox1gc71h3tppcVJ+Rnhr5PsxxiPkFTQlu9ESj29
         97nn65CCuUs8w==
Date:   Wed, 9 Aug 2023 13:37:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH vfs.tmpfs 1/5] xattr: simple_xattr_set() return old_xattr
 to be freed
Message-ID: <20230809-freuden-genom-9a00d6e5158d@brauner>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
 <158c6585-2aa7-d4aa-90ff-f7c3f8fe407c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <158c6585-2aa7-d4aa-90ff-f7c3f8fe407c@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:30:59PM -0700, Hugh Dickins wrote:
> tmpfs wants to support limited user extended attributes, but kernfs
> (or cgroupfs, the only kernfs with KERNFS_ROOT_SUPPORT_USER_XATTR)
> already supports user extended attributes through simple xattrs: but
> limited by a policy (128KiB per inode) too liberal to be used on tmpfs.
> 
> To allow a different limiting policy for tmpfs, without affecting the
> policy for kernfs, change simple_xattr_set() to return the replaced or
> removed xattr (if any), leaving the caller to update their accounting
> then free the xattr (by simple_xattr_free(), renamed from the static
> free_simple_xattr()).
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---

Seems good enough,
Reviewed-by: Christian Brauner <brauner@kernel.org>
