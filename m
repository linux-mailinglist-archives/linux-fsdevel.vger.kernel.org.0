Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187F0656333
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 15:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiLZOWu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 09:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiLZOWj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:22:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E336387;
        Mon, 26 Dec 2022 06:22:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24AA1B80D41;
        Mon, 26 Dec 2022 14:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C373CC433D2;
        Mon, 26 Dec 2022 14:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672064529;
        bh=7SbfW9t2WEOzR8seGOYlZoIpmGQJDZj+robHHxNPvMg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eN/lw5DnxdvYfY0ODuXLEVKk8TMiNQffzO157TNdgCyeYz3E1NQeWT+hcL+xZUwli
         7SaS/CIG27kC5rvFtpnF69r70+2rhebnA/a8xvi6+a6ET8vR3BlMzqv+nd79m4Ctk5
         HluUDpyMZ/J5cqCFLcLt005Koh/fhIIR1w+zSYRYBAFX2LeYqEqktySGVlYvhbiTeF
         8qgaOW5dCRQkxY1QtcIyHGzT9NubIRCv3O2rPBzyhOLN2rbzxWVeKrAuX03CQzt6Qh
         Py1b9O3qYmaPBWcXE3fFmfng/+yEamTujxOXSUaKLvSHoolgw/axd9uTisp+6frJ3S
         SOqSEAybfSZCg==
Received: by pali.im (Postfix)
        id 7E7D49D7; Mon, 26 Dec 2022 15:22:09 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Anton Altaparmakov <anton@tuxera.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Dave Kleikamp <shaggy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Kari Argillander <kari.argillander@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH v2 08/18] befs: Allow to use native UTF-8 mode
Date:   Mon, 26 Dec 2022 15:21:40 +0100
Message-Id: <20221226142150.13324-9-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221226142150.13324-1-pali@kernel.org>
References: <20221226142150.13324-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 fs/befs/linuxvfs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 8d2954e3afd6..e5400123d33f 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -769,6 +769,7 @@ static int befs_show_options(struct seq_file *m, struct dentry *root)
 {
 	struct befs_sb_info *befs_sb = BEFS_SB(root->d_sb);
 	struct befs_mount_options *opts = &befs_sb->mount_opts;
+	struct nls_table *nls = befs_sb->nls;
 
 	if (!uid_eq(opts->uid, GLOBAL_ROOT_UID))
 		seq_printf(m, ",uid=%u",
@@ -776,8 +777,10 @@ static int befs_show_options(struct seq_file *m, struct dentry *root)
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
@@ -815,6 +818,7 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
 	const unsigned long sb_block = 0;
 	const off_t x86_sb_off = 512;
 	int blocksize;
+	const char *p;
 
 	sb->s_fs_info = kzalloc(sizeof(*befs_sb), GFP_KERNEL);
 	if (sb->s_fs_info == NULL)
@@ -907,8 +911,11 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
 		goto unacquire_priv_sbp;
 	}
 
+	p = befs_sb->mount_opts.iocharset ? befs_sb->mount_opts.iocharset : CONFIG_NLS_DEFAULT;
+	if (strcmp(p, "utf8") == 0) {
+		befs_debug(sb, "Using native UTF-8 without nls");
 	/* load nls library */
-	if (befs_sb->mount_opts.iocharset) {
+	} else if (befs_sb->mount_opts.iocharset) {
 		befs_debug(sb, "Loading nls: %s",
 			   befs_sb->mount_opts.iocharset);
 		befs_sb->nls = load_nls(befs_sb->mount_opts.iocharset);
-- 
2.20.1

