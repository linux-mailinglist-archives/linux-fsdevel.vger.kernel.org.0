Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E33287C52
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 21:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgJHTQu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 15:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729883AbgJHTQt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:16:49 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 868C021789;
        Thu,  8 Oct 2020 19:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602184608;
        bh=lexhJREGzh+/V1ER4S2AHbrxdRthtEv6r0KJwlclks0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKGAlpbG4OOoEJ39yOZrI0Ynhku9gSvjjvr3ZOqu0wyOMpdNnsWm2vKqewWp6GWdI
         mXQvmSp84eTaMtPevuVefKdF/knNC4TkPArkM1ZVcOuBcOFvL1UHFq53AwuiaeAl47
         hbrrO6ioBdX0157aAcfbyMzkPVkmx92CEZyaJUgw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot+05139c4039d0679e19ff@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: reject CASEFOLD inode flag without casefold feature
Date:   Thu,  8 Oct 2020 12:15:22 -0700
Message-Id: <20201008191522.1948889-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
In-Reply-To: <00000000000085be6f05b12a1366@google.com>
References: <00000000000085be6f05b12a1366@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

syzbot reported:

    general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
    KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
    CPU: 0 PID: 6860 Comm: syz-executor835 Not tainted 5.9.0-rc8-syzkaller #0
    Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
    RIP: 0010:utf8_casefold+0x43/0x1b0 fs/unicode/utf8-core.c:107
    [...]
    Call Trace:
     f2fs_init_casefolded_name fs/f2fs/dir.c:85 [inline]
     __f2fs_setup_filename fs/f2fs/dir.c:118 [inline]
     f2fs_prepare_lookup+0x3bf/0x640 fs/f2fs/dir.c:163
     f2fs_lookup+0x10d/0x920 fs/f2fs/namei.c:494
     __lookup_hash+0x115/0x240 fs/namei.c:1445
     filename_create+0x14b/0x630 fs/namei.c:3467
     user_path_create fs/namei.c:3524 [inline]
     do_mkdirat+0x56/0x310 fs/namei.c:3664
     do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
     entry_SYSCALL_64_after_hwframe+0x44/0xa9
    [...]

The problem is that an inode has F2FS_CASEFOLD_FL set, but the
filesystem doesn't have the casefold feature flag set, and therefore
super_block::s_encoding is NULL.

Fix this by making sanity_check_inode() reject inodes that have
F2FS_CASEFOLD_FL when the filesystem doesn't have the casefold feature.

Reported-by: syzbot+05139c4039d0679e19ff@syzkaller.appspotmail.com
Fixes: 2c2eb7a300cd ("f2fs: Support case-insensitive file name lookups")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 2ed935c13aed..d5664bc7d6c6 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -287,6 +287,13 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
+	if ((fi->i_flags & F2FS_CASEFOLD_FL) && !f2fs_sb_has_casefold(sbi)) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_warn(sbi, "%s: inode (ino=%lx) has casefold flag, but casefold feature is off",
+			  __func__, inode->i_ino);
+		return false;
+	}
+
 	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_compression(sbi) &&
 			fi->i_flags & F2FS_COMPR_FL &&
 			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,

base-commit: db40330b0de9a9d9939178f48cd5fc5e3fab14de
-- 
2.28.0.1011.ga647a8990f-goog

