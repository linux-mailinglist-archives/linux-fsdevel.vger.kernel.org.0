Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF0F1A41EB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 05:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfHaDMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 23:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:32880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbfHaDMc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 23:12:32 -0400
Received: from zzz.localdomain (h184-61-154-48.mdsnwi.dsl.dynamic.tds.net [184.61.154.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFE2423697;
        Sat, 31 Aug 2019 03:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567221151;
        bh=sqqG5YjX2TxT/FleCqXlEinau5fUXCvji7e76c8RrL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S77Rr5Y6pqlh/CDOKIZJ7a7bDgTMnRzF152GPLYO1FC7MIqeUVFkpI7fmaoK+TQXP
         jAmfHCDrQn0iNx7DmZ1g6H4THs0+4916ByO/Si0ay0USfBVlY57MBhhfvYBLelbOqK
         ardXEe1xdOnvCkAENcgR4jTHWiv4NLeRtxnNyef8=
Date:   Fri, 30 Aug 2019 22:12:28 -0500
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     syzkaller-bugs@googlegroups.com,
        syzbot+7d6a57304857423318a5@syzkaller.appspotmail.com,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] vfs: set fs_context::user_ns for reconfigure
Message-ID: <20190831031228.GE22191@zzz.localdomain>
Mail-Followup-To: Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+7d6a57304857423318a5@syzkaller.appspotmail.com,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <0000000000007bc3a0058e460627@google.com>
 <20190822051633.12980-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822051633.12980-1-ebiggers@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 21, 2019 at 10:16:33PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> fs_context::user_ns is used by fuse_parse_param(), even during remount,
> so it needs to be set to the existing value for reconfigure.
> 
> Reproducer:
> 
> 	#include <fcntl.h>
> 	#include <sys/mount.h>
> 
> 	int main()
> 	{
> 		char opts[128];
> 		int fd = open("/dev/fuse", O_RDWR);
> 
> 		sprintf(opts, "fd=%d,rootmode=040000,user_id=0,group_id=0", fd);
> 		mkdir("mnt", 0777);
> 		mount("foo",  "mnt", "fuse.foo", 0, opts);
> 		mount("foo", "mnt", "fuse.foo", MS_REMOUNT, opts);
> 	}
> 
> Crash:
> 	BUG: kernel NULL pointer dereference, address: 0000000000000000
> 	#PF: supervisor read access in kernel mode
> 	#PF: error_code(0x0000) - not-present page
> 	PGD 0 P4D 0
> 	Oops: 0000 [#1] SMP
> 	CPU: 0 PID: 129 Comm: syz_make_kuid Not tainted 5.3.0-rc5-next-20190821 #3
> 	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-20181126_142135-anatol 04/01/2014
> 	RIP: 0010:map_id_range_down+0xb/0xc0 kernel/user_namespace.c:291
> 	[...]
> 	Call Trace:
> 	 map_id_down kernel/user_namespace.c:312 [inline]
> 	 make_kuid+0xe/0x10 kernel/user_namespace.c:389
> 	 fuse_parse_param+0x116/0x210 fs/fuse/inode.c:523
> 	 vfs_parse_fs_param+0xdb/0x1b0 fs/fs_context.c:145
> 	 vfs_parse_fs_string+0x6a/0xa0 fs/fs_context.c:188
> 	 generic_parse_monolithic+0x85/0xc0 fs/fs_context.c:228
> 	 parse_monolithic_mount_data+0x1b/0x20 fs/fs_context.c:708
> 	 do_remount fs/namespace.c:2525 [inline]
> 	 do_mount+0x39a/0xa60 fs/namespace.c:3107
> 	 ksys_mount+0x7d/0xd0 fs/namespace.c:3325
> 	 __do_sys_mount fs/namespace.c:3339 [inline]
> 	 __se_sys_mount fs/namespace.c:3336 [inline]
> 	 __x64_sys_mount+0x20/0x30 fs/namespace.c:3336
> 	 do_syscall_64+0x4a/0x1a0 arch/x86/entry/common.c:290
> 	 entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Reported-by: syzbot+7d6a57304857423318a5@syzkaller.appspotmail.com
> Fixes: 408cbe695350 ("vfs: Convert fuse to use the new mount API")
> Cc: David Howells <dhowells@redhat.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/fs_context.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index cc61d305dc4b..44c4174b250a 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -279,10 +279,8 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
>  		fc->user_ns = get_user_ns(reference->d_sb->s_user_ns);
>  		break;
>  	case FS_CONTEXT_FOR_RECONFIGURE:
> -		/* We don't pin any namespaces as the superblock's
> -		 * subscriptions cannot be changed at this point.
> -		 */
>  		atomic_inc(&reference->d_sb->s_active);
> +		fc->user_ns = get_user_ns(reference->d_sb->s_user_ns);
>  		fc->root = dget(reference);
>  		break;
>  	}
> -- 
> 2.22.1

Ping.
