Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A944C4E1C8B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Mar 2022 17:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbiCTQ2I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Mar 2022 12:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiCTQ2H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:28:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6781E19BFE3;
        Sun, 20 Mar 2022 09:26:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FA22B80E50;
        Sun, 20 Mar 2022 16:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C16C340E9;
        Sun, 20 Mar 2022 16:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647793601;
        bh=vRLeqo0sF0b8wjVTss0xPtrmuKURf7SPqtOYIKGR4dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ibyoK0aX4MHfRfk9qT/3ejFcQNT6P2oWIC/ZG0dRmLGwCFa4LDyzf5FWeGyNU/Igr
         ScmQ4H5vyzUdVPX+ABu73npV/8cZ5xsgI+U9NOnQVCmqzukP8a6ft3cfqaPHwiMDaL
         vZDqHSQ2X9dz9Holvhwd+fMe2/k1BU2N78ADMXutrPHE+BC3xnrAWnPnfFdjqsh68V
         es6tPYTJdpqD20IksdCT8NyZYwclgRANgNoGiTRLCOX2r2bg5lU/LfhG87ePOQjfvs
         Ci8TVGHKfpCEy1M2X7nxj3JCyNj3SdUe38oseN70F9WCmxoC3P9O1CDlSNBMYN4MR7
         /S6PXylmgy/ZA==
Date:   Sun, 20 Mar 2022 09:26:41 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Guo Xuenan <guoxuenan@huawei.com>
Cc:     willy@infradead.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        houtao1@huawei.com, fangwei1@huawei.com,
        hsiangkao@linux.alibaba.com
Subject: Re: [PATCH] iomap: fix an infinite loop in iomap_fiemap
Message-ID: <20220320162641.GB8182@magnolia>
References: <20220315065745.3441989-1-guoxuenan@huawei.com>
 <20220317220511.GA8182@magnolia>
 <165cff82-6210-9acf-c104-b6cae5d2a92e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <165cff82-6210-9acf-c104-b6cae5d2a92e@huawei.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 18, 2022 at 03:21:23PM +0800, Guo Xuenan wrote:
> Hi Darrick,
> 
> 在 2022/3/18 6:05, Darrick J. Wong wrote:
> > On Tue, Mar 15, 2022 at 02:57:45PM +0800, Guo Xuenan wrote:
> > > when get fiemap starting from MAX_LFS_FILESIZE, (maxbytes - *len) < start
> > > will always true , then *len set zero. because of start offset is byhond
> > > file size, for erofs filesystem it will always return iomap.length with
> > > zero,iomap iterate will be infinite loop.
> > > 
> > > In order to avoid this situation, it is better to calculate the actual
> > > mapping length at first. If the len is 0, there is no need to continue
> > > the operation.
> > > 
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 7 PID: 905 at fs/iomap/iter.c:35 iomap_iter+0x97f/0xc70
> > > Modules linked in: xfs erofs
> > > CPU: 7 PID: 905 Comm: iomap Tainted: G        W         5.17.0-rc8 #27
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> > > RIP: 0010:iomap_iter+0x97f/0xc70
> > > Code: 85 a1 fc ff ff e8 71 be 9c ff 0f 1f 44 00 00 e9 92 fc ff ff e8 62 be 9c ff 0f 0b b8 fb ff ff ff e9 fc f8 ff ff e8 51 be 9c ff <0f> 0b e9 2b fc ff ff e8 45 be 9c ff 0f 0b e9 e1 fb ff ff e8 39 be
> > > RSP: 0018:ffff888060a37ab0 EFLAGS: 00010293
> > > RAX: 0000000000000000 RBX: ffff888060a37bb0 RCX: 0000000000000000
> > > RDX: ffff88807e19a900 RSI: ffffffff81a7da7f RDI: ffff888060a37be0
> > > RBP: 7fffffffffffffff R08: 0000000000000000 R09: ffff888060a37c20
> > > R10: ffff888060a37c67 R11: ffffed100c146f8c R12: 7fffffffffffffff
> > > R13: 0000000000000000 R14: ffff888060a37bd8 R15: ffff888060a37c20
> > > FS:  00007fd3cca01540(0000) GS:ffff888108780000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000000020010820 CR3: 0000000054b92000 CR4: 00000000000006e0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >   <TASK>
> > >   iomap_fiemap+0x1c9/0x2f0
> > >   erofs_fiemap+0x64/0x90 [erofs]
> > >   do_vfs_ioctl+0x40d/0x12e0
> > >   __x64_sys_ioctl+0xaa/0x1c0
> > >   do_syscall_64+0x35/0x80
> > >   entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >   </TASK>
> > > ---[ end trace 0000000000000000 ]---
> > > watchdog: BUG: soft lockup - CPU#7 stuck for 26s! [iomap:905]
> > > 
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> > > ---
> > >   fs/ioctl.c | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > > index 1ed097e94af2..7f70e90766ed 100644
> > > --- a/fs/ioctl.c
> > > +++ b/fs/ioctl.c
> > > @@ -171,8 +171,6 @@ int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
> > >   	u32 incompat_flags;
> > >   	int ret = 0;
> > > -	if (*len == 0)
> > > -		return -EINVAL;
> > >   	if (start > maxbytes)
> > >   		return -EFBIG;
> > > @@ -182,6 +180,9 @@ int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
> > >   	if (*len > maxbytes || (maxbytes - *len) < start)
> > >   		*len = maxbytes - start;
> > > +	if (*len == 0)
> > > +		return -EINVAL;
> > Looks fine to me (and I don't even really mind pulling this in) but this
> > isn't a patch to fs/iomap/ -- doesn't the same issue potentially affect
> > the fiemap implementations that do not use iomap?
> > 
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > 
> > --D
> 
> Thanks Darrick, you're right,there is something wrong with my statement. In
> a strict sense, this modification here does not belong to fs/iomap, i can
> change it to fs/vfs in v2 :) I have looked into the code of those
> filesystem(btrfs,ext4,f2fs,nilfs2,ntfs3..) which don't use iomap, and did
> some test. when start=0x7fffffffffffffff, and len = 0; btrfs: while len==0,
> return -EINVAL directly; ext4: ext4_get_es_cache->ext4_fiemap_check_ranges,
> return -EFBIG; f2fs: return -EFBIG; nilfs2: while len==0, do nothing and
> return 0; ntfs3: return -EFBIG directly; so, as far as i can see, just
> return -EINVAL earlyier in fiemap_prep has no side effect.

It's dangerous for patch reviewers to think more about patches. :)

But-- thinking further, why do we return EINVAL for a query length of
zero?  Why doesn't FIEMAP set fi_extents_mapped = 0 and return
immediately?

Oh, right, because the documentation (a) doesn't say much about return
codes and (b) the current implementation returns *some* error code
(EINVAL or EFBIG), so now people probably expect that.

That said ... I think "File too large" is a more appropriate message
than "Invalid argument" for when we truncated the request to maxbytes
but then ended up with a zero-length request.

Does changing the check at the top of the function to:

	if (*len == 0)
		return -EINVAL;
	if (start >= maxbytes)
		return -EFBIG;

Cover this infinite loop case?

(Admittedly, it is Sunday morning and the parts of my brain that handle
integer rollover issues are still asleep.)

--D

> 
> Thanks.
> 
> > > +
> > >   	supported_flags |= FIEMAP_FLAG_SYNC;
> > >   	supported_flags &= FIEMAP_FLAGS_COMPAT;
> > >   	incompat_flags = fieinfo->fi_flags & ~supported_flags;
> > > -- 
> > > 2.22.0
> > > 
> > .
