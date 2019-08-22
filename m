Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDFDA98ACC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 07:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfHVFRD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 01:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729050AbfHVFRD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 01:17:03 -0400
Received: from zzz.localdomain (unknown [67.218.105.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F83B21848;
        Thu, 22 Aug 2019 05:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566451022;
        bh=yzhaukcaSnL+omUgwfIeGfqDRR+hnWkwJeBkb+A7NYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aSKbDNVhKd27nMAHowOYVdU6WAz2q5R41mh4QzA0oPuEKuv/0cELUDt1irTEMU8H6
         KOpUB4xMcZ4lv+IeurXOcF67FIBQSborUCE8ZB9Nb8dpUe2Kiqwmtf5clAGkAJ0Pmo
         ZhL3kZjwguJbeN6/mbJwgRGyQZ70PxjCGAzYQJQw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     syzkaller-bugs@googlegroups.com,
        syzbot+7d6a57304857423318a5@syzkaller.appspotmail.com,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH] vfs: set fs_context::user_ns for reconfigure
Date:   Wed, 21 Aug 2019 22:16:33 -0700
Message-Id: <20190822051633.12980-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <0000000000007bc3a0058e460627@google.com>
References: <0000000000007bc3a0058e460627@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

fs_context::user_ns is used by fuse_parse_param(), even during remount,
so it needs to be set to the existing value for reconfigure.

Reproducer:

	#include <fcntl.h>
	#include <sys/mount.h>

	int main()
	{
		char opts[128];
		int fd = open("/dev/fuse", O_RDWR);

		sprintf(opts, "fd=%d,rootmode=040000,user_id=0,group_id=0", fd);
		mkdir("mnt", 0777);
		mount("foo",  "mnt", "fuse.foo", 0, opts);
		mount("foo", "mnt", "fuse.foo", MS_REMOUNT, opts);
	}

Crash:
	BUG: kernel NULL pointer dereference, address: 0000000000000000
	#PF: supervisor read access in kernel mode
	#PF: error_code(0x0000) - not-present page
	PGD 0 P4D 0
	Oops: 0000 [#1] SMP
	CPU: 0 PID: 129 Comm: syz_make_kuid Not tainted 5.3.0-rc5-next-20190821 #3
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-20181126_142135-anatol 04/01/2014
	RIP: 0010:map_id_range_down+0xb/0xc0 kernel/user_namespace.c:291
	[...]
	Call Trace:
	 map_id_down kernel/user_namespace.c:312 [inline]
	 make_kuid+0xe/0x10 kernel/user_namespace.c:389
	 fuse_parse_param+0x116/0x210 fs/fuse/inode.c:523
	 vfs_parse_fs_param+0xdb/0x1b0 fs/fs_context.c:145
	 vfs_parse_fs_string+0x6a/0xa0 fs/fs_context.c:188
	 generic_parse_monolithic+0x85/0xc0 fs/fs_context.c:228
	 parse_monolithic_mount_data+0x1b/0x20 fs/fs_context.c:708
	 do_remount fs/namespace.c:2525 [inline]
	 do_mount+0x39a/0xa60 fs/namespace.c:3107
	 ksys_mount+0x7d/0xd0 fs/namespace.c:3325
	 __do_sys_mount fs/namespace.c:3339 [inline]
	 __se_sys_mount fs/namespace.c:3336 [inline]
	 __x64_sys_mount+0x20/0x30 fs/namespace.c:3336
	 do_syscall_64+0x4a/0x1a0 arch/x86/entry/common.c:290
	 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Reported-by: syzbot+7d6a57304857423318a5@syzkaller.appspotmail.com
Fixes: 408cbe695350 ("vfs: Convert fuse to use the new mount API")
Cc: David Howells <dhowells@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/fs_context.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index cc61d305dc4b..44c4174b250a 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -279,10 +279,8 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
 		fc->user_ns = get_user_ns(reference->d_sb->s_user_ns);
 		break;
 	case FS_CONTEXT_FOR_RECONFIGURE:
-		/* We don't pin any namespaces as the superblock's
-		 * subscriptions cannot be changed at this point.
-		 */
 		atomic_inc(&reference->d_sb->s_active);
+		fc->user_ns = get_user_ns(reference->d_sb->s_user_ns);
 		fc->root = dget(reference);
 		break;
 	}
-- 
2.22.1

