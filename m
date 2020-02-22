Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD22168C1A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 03:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgBVCxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 21:53:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39780 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgBVCxV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 21:53:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id j15so1942830pgm.6;
        Fri, 21 Feb 2020 18:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:mime-version:content-id
         :content-transfer-encoding:date:message-id;
        bh=1z3f7gh3j3fiE9rxrLEGvbLwXZxMRaYP+Krq85jjut4=;
        b=RdjFKa2eqcHE2qFULKSeJKJD7/sUHxMrIbepGCayNC+KlpE/nZ0Y4erVMGUzjZtNyp
         wUZl/NKRODUdqAcrQ+/OF9ZGdokdWJGBkVNrHcn4FpfG4k2NSbGP9JeX/yN5YSajOdcT
         SmkP5tMaXsx6kI776CgQbc/SdDogwqoWJxlFwbtrVgKNr0pfVdlGB6OFmsqzQqH/dh0Q
         zK9xsKqqqVfDkcnrLMjPMZM+gMdHBQo2AfjbR9keiuZ0kbTVzczZPBhuqaisM3NhLhHQ
         69VdXdIxXp0z83EAVTlYKRitY/CFuofrqftPc7U2L3gMNSEI+0Zk50T5UN62TM61X0US
         EZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:mime-version:content-id
         :content-transfer-encoding:date:message-id;
        bh=1z3f7gh3j3fiE9rxrLEGvbLwXZxMRaYP+Krq85jjut4=;
        b=dwTwKSIvRIHiCBu27RT045tE+283p/VFlH4IKhJxkMFD72YTpKG5lzFO2gK/3d5Ibt
         gZ3Z1EeD1D/qxuYBoVyjESCZLvl/6CIuWSqgkq69j0WoOiSs/C/K6+4ynW4qbpMXZ9xh
         ubV5RLe8s53rv8RhrbghXapA+MZp3OkOo6nmLyXXzXCz8DBnxluSVSmm1v7p2hlwoTnz
         JUHM7LQw+65xd/nhWIYgSm3I9eM7p4FU0niQFbVZDv8QBdIxuy5hT94D9Em5v74cfuLh
         bj6m8OlajF92PLfI6JVCbCuLbBsDsSczScwKKGwZSad/MvjkdQSU3+TkfBfId412KDV/
         HDeg==
X-Gm-Message-State: APjAAAV/oJJX04SPb0GhVI47KTWYKXnZFle6oVaVLES1IJl5MsiWE0/t
        TFM5XIui5LUDI+F815NicPM=
X-Google-Smtp-Source: APXvYqxGaVdn4M5Qf2jOiy8BCFwhdLzhcNuSH0lNYhyWKKX14hrEopge6ocfz43X/P9p3lQzkCWDrQ==
X-Received: by 2002:a63:f450:: with SMTP id p16mr18107136pgk.211.1582339998864;
        Fri, 21 Feb 2020 18:53:18 -0800 (PST)
Received: from jromail.nowhere (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id f8sm4177843pfn.2.2020.02.21.18.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 18:53:18 -0800 (PST)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1j5Kuq-0001Hn-LV ; Sat, 22 Feb 2020 11:53:16 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
To:     jack@suse.com, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: ext2, possible circular locking dependency detected
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4945.1582339996.1@jrobl>
Content-Transfer-Encoding: quoted-printable
Date:   Sat, 22 Feb 2020 11:53:16 +0900
Message-ID: <4946.1582339996@jrobl>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello ext2 maintainers,

During my local fs stress test, I've encounter this.
Is it false positive?
Otherwise, I've made a small patch to stop reclaming recursively into FS
from ext2_xattr_set().  Please consider taking this.

Once I've considered about whether it should be done in VFS layer or
not.  I mean, every i_op->brabra() calls in VFS should be surrounded by
memalloc_nofs_{save,restore}(), by a macro or something.  But I am
afraid it may introduce unnecesary overheads, especially when FS code
doesn't allocate memory.  So it is better to do it in real FS
operations.


J. R. Okajima

----------------------------------------
WARNING: possible circular locking dependency detected
5.6.0-rc2aufsD+ #165 Tainted: G        W
------------------------------------------------------
kswapd0/94 is trying to acquire lock:
ffff91f670bd7610 (sb_internal#2){.+.+}, at: ext2_evict_inode+0x7e/0x130

but task is already holding lock:
ffffffff8ca901e0 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x5/0x30

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (fs_reclaim){+.+.}:
       fs_reclaim_acquire.part.98+0x29/0x30
       __kmalloc+0x44/0x320
       ext2_xattr_set+0xe7/0x880
       __vfs_setxattr+0x66/0x80
       __vfs_setxattr_noperm+0x67/0x1a0
       vfs_setxattr+0x81/0xa0
       setxattr+0x13b/0x1c0
       path_setxattr+0xbe/0xe0
       __x64_sys_setxattr+0x27/0x30
       do_syscall_64+0x54/0x1f0
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&ei->xattr_sem#2){++++}:
       down_write+0x3d/0x70
       ext2_xattr_delete_inode+0x26/0x200
       ext2_evict_inode+0xc2/0x130
       evict+0xd0/0x1a0
       vfs_rmdir+0x15c/0x180
       do_rmdir+0x1c6/0x220
       do_syscall_64+0x54/0x1f0
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (sb_internal#2){.+.+}:
       __lock_acquire+0xd30/0x1540
       lock_acquire+0x90/0x170
       __sb_start_write+0x135/0x220
       ext2_evict_inode+0x7e/0x130
       evict+0xd0/0x1a0
       __dentry_kill+0xdc/0x180
       shrink_dentry_list+0xdd/0x200
       prune_dcache_sb+0x52/0x70
       super_cache_scan+0xf3/0x1a0
       do_shrink_slab+0x143/0x3a0
       shrink_slab+0x22c/0x2c0
       shrink_node+0x16c/0x670
       balance_pgdat+0x2cc/0x530
       kswapd+0xad/0x470
       kthread+0x11d/0x140
       ret_from_fork+0x24/0x50

other info that might help us debug this:

Chain exists of:
  sb_internal#2 --> &ei->xattr_sem#2 --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&ei->xattr_sem#2);
                               lock(fs_reclaim);
  lock(sb_internal#2);

 *** DEADLOCK ***

3 locks held by kswapd0/94:
 #0: ffffffff8ca901e0 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x5/0x3=
0
 #1: ffffffff8ca81bc8 (shrinker_rwsem){++++}, at: shrink_slab+0x135/0x2c0
 #2: ffff91f670bd70d8 (&type->s_umount_key#45){++++}, at: trylock_super+0x=
16/0x50

stack backtrace:
CPU: 4 PID: 94 Comm: kswapd0 Tainted: G        W         5.6.0-rc2aufsD+ #=
165
Hardware name: System manufacturer System Product Name/ROG STRIX H370-I GA=
MING, BIOS 2418 06/04/2019
Call Trace:
 dump_stack+0x71/0xa0
 check_noncircular+0x172/0x190
 __lock_acquire+0xd30/0x1540
 lock_acquire+0x90/0x170
 ? ext2_evict_inode+0x7e/0x130
 __sb_start_write+0x135/0x220
 ? ext2_evict_inode+0x7e/0x130
 ? shrink_dentry_list+0x24/0x200
 ext2_evict_inode+0x7e/0x130
 evict+0xd0/0x1a0
 __dentry_kill+0xdc/0x180
 shrink_dentry_list+0xdd/0x200
 prune_dcache_sb+0x52/0x70
 super_cache_scan+0xf3/0x1a0
 do_shrink_slab+0x143/0x3a0
 shrink_slab+0x22c/0x2c0
 shrink_node+0x16c/0x670
 balance_pgdat+0x2cc/0x530
 kswapd+0xad/0x470
 ? finish_wait+0x80/0x80
 ? balance_pgdat+0x530/0x530
 kthread+0x11d/0x140
 ? kthread_park+0x80/0x80
 ret_from_fork+0x24/0x50
----------------------------------------
a small patch

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 0456bc990b5e..85463fddbc17 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -61,6 +61,7 @@
 #include <linux/quotaops.h>
 #include <linux/rwsem.h>
 #include <linux/security.h>
+#include <linux/sched/mm.h>
 #include "ext2.h"
 #include "xattr.h"
 #include "acl.h"
@@ -413,6 +414,7 @@ ext2_xattr_set(struct inode *inode, int name_index, co=
nst char *name,
 	size_t name_len, free, min_offs =3D sb->s_blocksize;
 	int not_found =3D 1, error;
 	char *end;
+	unsigned int nofs_flag;
 	=

 	/*
 	 * header -- Points either into bh, or to a temporarily
@@ -532,7 +534,9 @@ ext2_xattr_set(struct inode *inode, int name_index, co=
nst char *name,
 =

 			unlock_buffer(bh);
 			ea_bdebug(bh, "cloning");
+			nofs_flag =3D memalloc_nofs_save();
 			header =3D kmemdup(HDR(bh), bh->b_size, GFP_KERNEL);
+			memalloc_nofs_restore(nofs_flag);
 			error =3D -ENOMEM;
 			if (header =3D=3D NULL)
 				goto cleanup;
@@ -545,7 +549,9 @@ ext2_xattr_set(struct inode *inode, int name_index, co=
nst char *name,
 		}
 	} else {
 		/* Allocate a buffer where we construct the new block. */
+		nofs_flag =3D memalloc_nofs_save();
 		header =3D kzalloc(sb->s_blocksize, GFP_KERNEL);
+		memalloc_nofs_restore(nofs_flag);
 		error =3D -ENOMEM;
 		if (header =3D=3D NULL)
 			goto cleanup;
