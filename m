Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30CC4115B97
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2019 09:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfLGI3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Dec 2019 03:29:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:33762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfLGI3n (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Dec 2019 03:29:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30919217BA;
        Sat,  7 Dec 2019 08:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575707382;
        bh=Tvys5XoKMMcFheCqtrB4mDdcAKthNCvO1SSzfwCfWBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mG2nXwcFU2cdNbK1+GGju2NsFu7hcmON3UMSeTGZBepB4YW+gRRZqsGJS1J9Bia7B
         lJeNmInqoGRTz5SNz67uo2B3mqB+b8fEK95rPbd0bCGjkTpvBEm44h/JBAxPBfeexr
         9RVg0e0BRFwQGYTQgYToajw9fSCYCI9O8G7auz9k=
Date:   Sat, 7 Dec 2019 09:29:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     rafael@kernel.org, dhowells@redhat.com, matthewgarrett@google.com,
        jmorris@namei.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: Return -EPERM when locked down
Message-ID: <20191207082939.GA204524@kroah.com>
References: <20191206225909.46721-1-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206225909.46721-1-eric.snowberg@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 06, 2019 at 05:59:09PM -0500, Eric Snowberg wrote:
> When lockdown is enabled, debugfs_is_locked_down returns 1. It will then
> trigger the following:
> 
> WARNING: CPU: 48 PID: 3747
> CPU: 48 PID: 3743 Comm: bash Not tainted 5.4.0-1946.x86_64 #1
> Hardware name: Oracle Corporation ORACLE SERVER X7-2/ASM, MB, X7-2, BIOS 41060400 05/20/2019
> RIP: 0010:do_dentry_open+0x343/0x3a0
> Code: 00 40 08 00 45 31 ff 48 c7 43 28 40 5b e7 89 e9 02 ff ff ff 48 8b 53 28 4c 8b 72 70 4d 85 f6 0f 84 10 fe ff ff e9 f5 fd ff ff <0f> 0b 41 bf ea ff ff ff e9 3b ff ff ff 41 bf e6 ff ff ff e9 b4 fe
> RSP: 0018:ffffb8740dde7ca0 EFLAGS: 00010202
> RAX: ffffffff89e88a40 RBX: ffff928c8e6b6f00 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff928dbfd97778 RDI: ffff9285cff685c0
> RBP: ffffb8740dde7cc8 R08: 0000000000000821 R09: 0000000000000030
> R10: 0000000000000057 R11: ffffb8740dde7a98 R12: ffff926ec781c900
> R13: ffff928c8e6b6f10 R14: ffffffff8936e190 R15: 0000000000000001
> FS:  00007f45f6777740(0000) GS:ffff928dbfd80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff95e0d5d8 CR3: 0000001ece562006 CR4: 00000000007606e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  vfs_open+0x2d/0x30
>  path_openat+0x2d4/0x1680
>  ? tty_mode_ioctl+0x298/0x4c0
>  do_filp_open+0x93/0x100
>  ? strncpy_from_user+0x57/0x1b0
>  ? __alloc_fd+0x46/0x150
>  do_sys_open+0x182/0x230
>  __x64_sys_openat+0x20/0x30
>  do_syscall_64+0x60/0x1b0
>  entry_SYSCALL_64_after_hwframe+0x170/0x1d5
> RIP: 0033:0x7f45f5e5ce02
> Code: 25 00 00 41 00 3d 00 00 41 00 74 4c 48 8d 05 25 59 2d 00 8b 00 85 c0 75 6d 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff 0f 87 a2 00 00 00 48 8b 4c 24 28 64 48 33 0c 25
> RSP: 002b:00007fff95e0d2e0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 0000561178c069b0 RCX: 00007f45f5e5ce02
> RDX: 0000000000000241 RSI: 0000561178c08800 RDI: 00000000ffffff9c
> RBP: 00007fff95e0d3e0 R08: 0000000000000020 R09: 0000000000000005
> R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000003 R14: 0000000000000001 R15: 0000561178c08800
> 
> Change the return type to int and return -EPERM when lockdown is enabled
> to remove the warning above.

Ugh, looks like no one ever even tested this?  :(

> Fixes: 5496197f9b08 ("debugfs: Restrict debugfs when the kernel is locked down")
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  fs/debugfs/file.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index dede25247b81..f31698f9b586 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -142,7 +142,7 @@ EXPORT_SYMBOL_GPL(debugfs_file_put);
>   * We also need to exclude any file that has ways to write or alter it as root
>   * can bypass the permissions check.
>   */
> -static bool debugfs_is_locked_down(struct inode *inode,
> +static int debugfs_is_locked_down(struct inode *inode,
>  				   struct file *filp,
>  				   const struct file_operations *real_fops)
>  {
> @@ -151,9 +151,12 @@ static bool debugfs_is_locked_down(struct inode *inode,
>  	    !real_fops->unlocked_ioctl &&
>  	    !real_fops->compat_ioctl &&
>  	    !real_fops->mmap)
> -		return false;
> +		return 0;
>  
> -	return security_locked_down(LOCKDOWN_DEBUGFS);
> +	if (security_locked_down(LOCKDOWN_DEBUGFS))
> +		return -EPERM;
> +
> +	return 0;
>  }

If you could make the change suggested for the name of the function,
I'll be glad to queue it up.

thanks,

greg k-h
