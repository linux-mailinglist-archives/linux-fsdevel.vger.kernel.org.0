Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E55B110F748
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 06:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfLCFaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 00:30:01 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:40994 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfLCFaB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:30:01 -0500
Received: by mail-pg1-f201.google.com with SMTP id r30so1115202pgm.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2019 21:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SKopphcDjR+C8byCotTV/kP/OOGE6F+qZoYa7dy8TaI=;
        b=PhG1tb4EUlJTLrsIgeOUG6n/d2gykJpAcCNqX0XoGWcJjh09xcbY7OmEdsU8fBLsvI
         Dc6hD4yTiaecnn+HOa33txArhA3FEz9p7SbXL6AVM4lvYssOI9Rz8SIumz1szw23AQy2
         N1H6A2Hv0gqKzA13MsfMtWA1denRxrgbhRKfAEO99StgJmOFHiO9VXiP3de4BP5amTX0
         78kmATQiM550/bbusceaVCDirtAy1j2LqnVQFP7Ucl18KYh/+/8D2nsnviMjr+NF/ezW
         aAxyXkZs8uW94urU2i939aNGWu5WT+W8jYKqi8R8nXmfZm0QW+mHMHn3bgmwZ++Ew6lq
         BGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SKopphcDjR+C8byCotTV/kP/OOGE6F+qZoYa7dy8TaI=;
        b=QXeh2XEU3UK/ncFywJIDRjm02sk2beKW8A/RruTz38VYBHUtz0ezo9d3U/k0AQ38Wr
         cazFV55r3QJ6Vizk9y0h7yDkbT8kcDcK+UlL/6KBCipJrPUrZsZeEJby4Y+KsudjT9Cl
         OdLB5lKIY6QWpn1vmPxfIncT5BalXtAJJDxU4Uw1YZiBEOXTYfcq41cBPL4loADM8kBl
         m4ysJJm7ImjWbi3qAHHQQ+GwyE8yebzkdLUG5mss1QOgANDbUJGypWGql7ONapeCdDYA
         JkEk3gnyGn3+h1/qAYXbYgLBz+3Hi6/c2zO5sHmFZKdGv7scjB99uCCnxFHq64CXEEFW
         XFmA==
X-Gm-Message-State: APjAAAU5mvWXY2tDpv1siA52CHKH372wsB0qUzj1C3HXIDc5clShf8b/
        TREhMToNFJWfiPsST+p6//yC4iB2yOM=
X-Google-Smtp-Source: APXvYqwnj3zyHxzVceMWXZJbshnY8esMJCmi+1fxQJHiWmpQ+ncmSuVcCoQ8M5s1R3xodQ4hbyAQx9LE/ns=
X-Received: by 2002:a63:cb50:: with SMTP id m16mr3461680pgi.425.1575351000175;
 Mon, 02 Dec 2019 21:30:00 -0800 (PST)
Date:   Mon,  2 Dec 2019 21:29:56 -0800
Message-Id: <20191203052956.67232-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH] f2fs-tools: Casefolded Encryption support
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds support for casefolded and encrypted directories.
Fsck cannot check the hashes of such directories because it would
require access to the encryption key to generate the siphash

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fsck/fsck.c        | 4 ++++
 fsck/mount.c       | 6 ------
 mkfs/f2fs_format.c | 4 ----
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 2ae3bd5..ebbdf44 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1290,6 +1290,10 @@ static int f2fs_check_hash_code(int encoding, int casefolded,
 			struct f2fs_dir_entry *dentry,
 			const unsigned char *name, u32 len, int enc_name)
 {
+	/* Casefolded Encrypted names require a key to compute siphash */
+	if (enc_name && casefolded)
+		return 0;
+
 	f2fs_hash_t hash_code = f2fs_dentry_hash(encoding, casefolded, name, len);
 	/* fix hash_code made by old buggy code */
 	if (dentry->hash_code != hash_code) {
diff --git a/fsck/mount.c b/fsck/mount.c
index 4814dfe..3286899 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2965,12 +2965,6 @@ static int tune_sb_features(struct f2fs_sb_info *sbi)
 	int sb_changed = 0;
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 
-	if (c.feature & cpu_to_le32(F2FS_FEATURE_ENCRYPT) &&
-		c.feature & cpu_to_le32(F2FS_FEATURE_CASEFOLD)) {
-		ERR_MSG("ERROR: Cannot set both encrypt and casefold. Skipping.\n");
-		return -1;
-	}
-
 	if (!(sb->feature & cpu_to_le32(F2FS_FEATURE_ENCRYPT)) &&
 			c.feature & cpu_to_le32(F2FS_FEATURE_ENCRYPT)) {
 		sb->feature |= cpu_to_le32(F2FS_FEATURE_ENCRYPT);
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 9402619..0bfe963 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -517,10 +517,6 @@ static int f2fs_prepare_super_block(void)
 	memcpy(sb->init_version, c.version, VERSION_LEN);
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_CASEFOLD)) {
-		if (c.feature & cpu_to_le32(F2FS_FEATURE_ENCRYPT)) {
-			MSG(0, "\tError: Casefolding and encryption are not compatible\n");
-			return -1;
-		}
 		set_sb(s_encoding, c.s_encoding);
 		set_sb(s_encoding_flags, c.s_encoding_flags);
 	}
-- 
2.24.0.393.g34dc348eaf-goog

