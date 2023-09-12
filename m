Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F81279DC79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 01:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjILXKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 19:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjILXKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 19:10:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953B510CC;
        Tue, 12 Sep 2023 16:10:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA9CC433C8;
        Tue, 12 Sep 2023 23:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694560216;
        bh=dVRCZDK8DSlFJ9jnRgRxeb2XZcMpY6ZOdlAdaUwhl48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFzGwyecGXS56F800Ca7q1tykUOaVEPYUylQr4vUEgEecfaprcQiU5YwvBk3S+Ne3
         13iRrQMO2Wt76YWbmKC3Mah7+hanT5YsLPWY9PjggLBP4h6/2exdee1sUYkV1AgBr6
         f0ARFt24C6PCB2j98GZCP0cWcajQPmnhCk3xYC1TtfSVED3uuBnwxnl6GkhHX53OVa
         QBeLVPmhcjYgWyHF/NjXZFZlnfb2dZeBAS+LGQ+wR5Y/daTV8VL8OLKnancF0gZbNY
         rxZYJ8ypXeaM9W+J9U7Ptik5EbJQSJha47WpsBDFeYlD+6UOZQHYWRbz7ILTZkt2ou
         HKYRIbTn8YH/A==
Date:   Tue, 12 Sep 2023 16:10:14 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: have setattr_copy handle multigrain timestamps
 appropriately
Message-ID: <20230912231014.GA795188@dev-arch.thelio-3990X>
References: <20230830-kdevops-v1-1-ef2be57755dd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830-kdevops-v1-1-ef2be57755dd@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeff,

On Wed, Aug 30, 2023 at 02:28:43PM -0400, Jeff Layton wrote:
> The setattr codepath is still using coarse-grained timestamps, even on
> multigrain filesystems. To fix this, we need to fetch the timestamp for
> ctime updates later, at the point where the assignment occurs in
> setattr_copy.
> 
> On a multigrain inode, ignore the ia_ctime in the attrs, and always
> update the ctime to the current clock value. Update the atime and mtime
> with the same value (if needed) unless they are being set to other
> specific values, a'la utimes().
> 
> Note that we don't want to do this universally however, as some
> filesystems (e.g. most networked fs) want to do an explicit update
> elsewhere before updating the local inode.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/attr.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index a8ae5f6d9b16..8ba330e6a582 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -275,6 +275,42 @@ int inode_newsize_ok(const struct inode *inode, loff_t offset)
>  }
>  EXPORT_SYMBOL(inode_newsize_ok);
>  
> +/**
> + * setattr_copy_mgtime - update timestamps for mgtime inodes
> + * @inode: inode timestamps to be updated
> + * @attr: attrs for the update
> + *
> + * With multigrain timestamps, we need to take more care to prevent races
> + * when updating the ctime. Always update the ctime to the very latest
> + * using the standard mechanism, and use that to populate the atime and
> + * mtime appropriately (unless we're setting those to specific values).
> + */
> +static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
> +{
> +	unsigned int ia_valid = attr->ia_valid;
> +	struct timespec64 now;
> +
> +	/*
> +	 * If the ctime isn't being updated then nothing else should be
> +	 * either.
> +	 */
> +	if (!(ia_valid & ATTR_CTIME)) {
> +		WARN_ON_ONCE(ia_valid & (ATTR_ATIME|ATTR_MTIME));
> +		return;
> +	}

After this change in -next as commit d6f106662147 ("fs: have
setattr_copy handle multigrain timestamps appropriately"), I see the
following warning on all of my machines when starting my containers with
podman/docker:

[    0.000000] Linux version 6.6.0-rc1-00001-gd6f106662147 (nathan@dev-arch.thelio-3990X) (x86_64-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41) #1 SMP PREEMPT_DYNAMIC Tue Sep 12 16:01:41 MST 2023
...
[   91.484884] ------------[ cut here ]------------
[   91.484889] WARNING: CPU: 2 PID: 721 at fs/attr.c:298 setattr_copy+0x106/0x1b0
[   91.484920] Modules linked in:
[   91.484923] CPU: 2 PID: 721 Comm: podman Not tainted 6.6.0-rc1-00001-gd6f106662147 #1 33e7e76d587862399371bcd9c318a44e2ec9ced1
[   91.484927] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[   91.484930] RIP: 0010:setattr_copy+0x106/0x1b0
[   91.484933] Code: 44 0f 44 f8 48 8b 43 28 66 44 89 3b 48 8b 40 28 f6 40 08 40 0f 84 59 ff ff ff 45 8b 2c 24 41 f6 c5 40 75 49 41 83 e5 30 74 94 <0f> 0b eb 90 48 8b 43 28 41 8b 54 24 0c 4c 89 f7 48 8b b0 90 04 00
[   91.484934] RSP: 0018:ffffc90003d8f778 EFLAGS: 00010206
[   91.484940] RAX: ffffffff9bb407c0 RBX: ffff888102ae44f8 RCX: ffff8881127ad0c0
[   91.484941] RDX: ffffc90003d8f900 RSI: ffff888102ae44f8 RDI: ffffffff9bb346a0
[   91.484942] RBP: ffffc90003d8f7a0 R08: ffff888101017300 R09: ffff888102ae44f8
[   91.484943] R10: 000000006500ee8f R11: 000000000cf2ee13 R12: ffffc90003d8f900
[   91.484943] R13: 0000000000000030 R14: ffffffff9bb346a0 R15: 0000000000000000
[   91.484946] FS:  00007f155effd6c0(0000) GS:ffff88846fc80000(0000) knlGS:0000000000000000
[   91.484947] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   91.484948] CR2: 00007f155dffbd58 CR3: 000000010694a000 CR4: 0000000000350ee0
[   91.484950] Call Trace:
[   91.484951]  <TASK>
[   91.484952]  ? setattr_copy+0x106/0x1b0
[   91.484956]  ? __warn+0x81/0x130
[   91.484969]  ? setattr_copy+0x106/0x1b0
[   91.484971]  ? report_bug+0x171/0x1a0
[   91.484987]  ? handle_bug+0x3c/0x80
[   91.484991]  ? exc_invalid_op+0x17/0x70
[   91.484992]  ? asm_exc_invalid_op+0x1a/0x20
[   91.485007]  ? setattr_copy+0x106/0x1b0
[   91.485009]  btrfs_setattr+0x3d0/0x830
[   91.485021]  ? btrfs_setattr+0x3ea/0x830
[   91.485023]  notify_change+0x1f5/0x4b0
[   91.485028]  ? ovl_set_timestamps.isra.0+0x7d/0xa0
[   91.485033]  ovl_set_timestamps.isra.0+0x7d/0xa0
[   91.485040]  ovl_set_attr.part.0+0x9f/0xb0
[   91.485043]  ovl_copy_up_metadata+0xb1/0x210
[   91.485046]  ? ovl_mkdir_real+0x32/0xc0
[   91.485048]  ovl_copy_up_one+0x6ab/0x14f0
[   91.485050]  ? btrfs_search_slot+0x8c8/0xd00
[   91.485056]  ? xa_load+0x8c/0xe0
[   91.485063]  ovl_copy_up_flags+0xcf/0x100
[   91.485067]  ovl_do_remove+0xa5/0x500
[   91.485068]  ? inode_permission+0xde/0x190
[   91.485075]  ? __pfx_bpf_lsm_inode_permission+0x10/0x10
[   91.485081]  ? security_inode_permission+0x3e/0x60
[   91.485090]  vfs_unlink+0x112/0x280
[   91.485094]  do_unlinkat+0x14b/0x320
[   91.485096]  __x64_sys_unlinkat+0x37/0x70
[   91.485098]  do_syscall_64+0x60/0x90
[   91.485100]  ? syscall_exit_to_user_mode+0x2b/0x40
[   91.485104]  ? do_syscall_64+0x6c/0x90
[   91.485106]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   91.485108] RIP: 0033:0x55d4e18b04ee
[   91.485112] Code: 48 83 ec 38 e8 13 00 00 00 48 83 c4 38 5d c3 cc cc cc cc cc cc cc cc cc cc cc cc cc 49 89 f2 48 89 fa 48 89 ce 48 89 df 0f 05 <48> 3d 01 f0 ff ff 76 15 48 f7 d8 48 89 c1 48 c7 c0 ff ff ff ff 48
[   91.485113] RSP: 002b:000000c0003874a0 EFLAGS: 00000212 ORIG_RAX: 0000000000000107
[   91.485114] RAX: ffffffffffffffda RBX: 000000000000000a RCX: 000055d4e18b04ee
[   91.485115] RDX: 0000000000000000 RSI: 000000c00027e1c0 RDI: 000000000000000a
[   91.485116] RBP: 000000c0003874e0 R08: 0000000000000000 R09: 0000000000000000
[   91.485116] R10: 0000000000000000 R11: 0000000000000212 R12: 000000000000001c
[   91.485117] R13: 000000c000100800 R14: 000000c0000061a0 R15: 000000c0002f0060
[   91.485119]  </TASK>
[   91.485119] ---[ end trace 0000000000000000 ]---

Is this expected?

Cheers,
Nathan
