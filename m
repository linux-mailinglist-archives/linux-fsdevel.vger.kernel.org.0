Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101973E3B84
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 18:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhHHQ0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 12:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231882AbhHHQZg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:25:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC3B6610A1;
        Sun,  8 Aug 2021 16:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628439917;
        bh=s8/pegOQ7RYOq+lh3ThWZRo1NRJOC4wAYqGAubgRpOU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jvq5yzqR6RoEecl4y1TjillgIF7I6qPa74Gyb7EtLccaqf3UZZeDSACwA5V9YcoEM
         +0nDO8hc3r1SW4TEQzWPXRkwesbSyw+Tp6lRiTI9pOMSSoaXB3YY+TEAi5DSvdeJfn
         oSuaQ+hG8uRvT3ByMfTCH0Dfbyx8RQBKfp9pWCOVYY8Tvi1Gp82FIqIlJsk5jAGFSE
         kq29jYqwhS+AD9rFH//ptfRxG3SAKEvSWxWq2Br4+Vwo9L6m+a3n+d/HlC5mAsfCET
         BNC71n1V9DRYoFe0DnjEv2ZqNOoJpCawE4648iyrsqLn4a2m4twkzZpY9jCqLVn7AY
         2RTQoRtOuv9rg==
Received: by pali.im (Postfix)
        id 6E27613DC; Sun,  8 Aug 2021 18:25:17 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 10/20] befs: Allow to use native UTF-8 mode
Date:   Sun,  8 Aug 2021 18:24:43 +0200
Message-Id: <20210808162453.1653-11-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210808162453.1653-1-pali@kernel.org>
References: <20210808162453.1653-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

befs driver already has a code which avoids usage of NLS when befs_sb->nls
is not set.

But befs_fill_super() always set befs_sb->nls, so activating native UTF-8
is not possible.

Fix it by not setting befs_sb->nls when iocharset is set to utf8. So now
after this cgange mount option iocharset=utf8 activates usage of native
UTF-8 code path in befs driver.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/befs/linuxvfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 963da3e9ab5d..000f946b92b6 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -770,6 +770,7 @@ static int befs_show_options(struct seq_file *m, struct dentry *root)
 {
 	struct befs_sb_info *befs_sb = BEFS_SB(root->d_sb);
 	struct befs_mount_options *opts = &befs_sb->mount_opts;
+	struct nls_table *nls = befs_sb->nls;
 
 	if (!uid_eq(opts->uid, GLOBAL_ROOT_UID))
 		seq_printf(m, ",uid=%u",
@@ -777,8 +778,10 @@ static int befs_show_options(struct seq_file *m, struct dentry *root)
 	if (!gid_eq(opts->gid, GLOBAL_ROOT_GID))
 		seq_printf(m, ",gid=%u",
 			   from_kgid_munged(&init_user_ns, opts->gid));
-	if (opts->iocharset)
-		seq_printf(m, ",iocharset=%s", opts->iocharset);
+	if (nls)
+		seq_printf(m, ",iocharset=%s", nls->charset);
+	else
+		seq_puts(m, ",iocharset=utf8");
 	if (opts->debug)
 		seq_puts(m, ",debug");
 	return 0;
@@ -908,8 +911,10 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
 		goto unacquire_priv_sbp;
 	}
 
+	if (strcmp(opt.iocharset ? opt.iocharset : CONFIG_NLS_DEFAULT, "utf8") == 0) {
+		befs_debug(sb, "Using native UTF-8 without nls");
 	/* load nls library */
-	if (befs_sb->mount_opts.iocharset) {
+	} else if (befs_sb->mount_opts.iocharset) {
 		befs_debug(sb, "Loading nls: %s",
 			   befs_sb->mount_opts.iocharset);
 		befs_sb->nls = load_nls(befs_sb->mount_opts.iocharset);
-- 
2.20.1

