Return-Path: <linux-fsdevel+bounces-51389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12636AD6605
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 05:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01CBF1BC209C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 03:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843761F5858;
	Thu, 12 Jun 2025 03:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="G2qoPIw9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940AA1DED64;
	Thu, 12 Jun 2025 03:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749697919; cv=none; b=CRkSgSXUNOqNZ5tpNgCCW2Hh4qOyUzjLLP9aQ/AgHA7l6SBsDoMaUt3+/eW+rdKbUzueqrZiRah8lmuslAHKlFlK+s5VzRiAsBpPhhvEADbkLVL0Lrw/hpnYtT40o28n8BQOtb+E0NvkGungXQg9CelJ3w8+AMyfkGjN3Jz9O6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749697919; c=relaxed/simple;
	bh=2w43J+m2hsaks2tLaoIL10DfG73jTspv9LtChcqcql4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLw4wl462MsiFGUBgeBIKguB9EKbVo+Kc1thT85QKgMpuzyB2PEnExhQF/QsPCaVY+CIoswPPF+1+lHhTh7R3qs4Jx6r2cRvlYbUH6uU+aLlyDNN6S+nDHo1bbqykrZ5oOH90PJIXjNasak5FR3XJGZa47El3Xm/dGbbkjtiCfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=G2qoPIw9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0adqSNDtsBX0j00vNqOcKAkGx/v7h4xPEQ5BScXZvAg=; b=G2qoPIw9s1QOzZwgU53XmGFB7I
	+lLCohdQAoBUT5k3ZxdNfEud/bkhe33PJqLYVf2fKz1xLfbXMGkGvrL6+p0tQ//1vvakLqBx++oJc
	EEewwD5eKbBehUa3R893UiaStteUR11luY6LIhvscewbUoT/Ta3tHAg48+zFBO5xIWyDeDfiYBnFq
	SzJKetSORl6hqVOaS6V+BHSxk+ZJCrpM/HUYsHNX/D/Q1C3hpL6b4eS5PIn3zy92tbBf2ZkXuDUN0
	Vwr8/Cr3ke36Sgxp1BZzWCPx5jZ6A5aJGyiupN1Ia4p5A3z6w/4XOo7bUeFf0sQC6niXp84EXaA3e
	pCFHIw5Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPYM7-00000009gfF-3GiZ;
	Thu, 12 Jun 2025 03:11:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Subject: [PATCH 10/10] tpm: don't bother with removal of files in directory we'll be removing
Date: Thu, 12 Jun 2025 04:11:54 +0100
Message-ID: <20250612031154.2308915-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612031154.2308915-1-viro@zeniv.linux.org.uk>
References: <20250612030951.GC1647736@ZenIV>
 <20250612031154.2308915-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

FWIW, there is a reliable indication of removal - ->i_nlink going to 0 ;-)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/char/tpm/eventlog/common.c | 46 ++++++++----------------------
 include/linux/tpm.h                |  2 +-
 2 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/drivers/char/tpm/eventlog/common.c b/drivers/char/tpm/eventlog/common.c
index 4c0bbba64ee5..691813d2a5a2 100644
--- a/drivers/char/tpm/eventlog/common.c
+++ b/drivers/char/tpm/eventlog/common.c
@@ -32,7 +32,7 @@ static int tpm_bios_measurements_open(struct inode *inode,
 	struct tpm_chip *chip;
 
 	inode_lock(inode);
-	if (!inode->i_private) {
+	if (!inode->i_nlink) {
 		inode_unlock(inode);
 		return -ENODEV;
 	}
@@ -105,7 +105,7 @@ static int tpm_read_log(struct tpm_chip *chip)
 void tpm_bios_log_setup(struct tpm_chip *chip)
 {
 	const char *name = dev_name(&chip->dev);
-	unsigned int cnt;
+	struct dentry *dentry;
 	int log_version;
 	int rc = 0;
 
@@ -117,14 +117,12 @@ void tpm_bios_log_setup(struct tpm_chip *chip)
 		return;
 	log_version = rc;
 
-	cnt = 0;
-	chip->bios_dir[cnt] = securityfs_create_dir(name, NULL);
+	chip->bios_dir = securityfs_create_dir(name, NULL);
 	/* NOTE: securityfs_create_dir can return ENODEV if securityfs is
 	 * compiled out. The caller should ignore the ENODEV return code.
 	 */
-	if (IS_ERR(chip->bios_dir[cnt]))
-		goto err;
-	cnt++;
+	if (IS_ERR(chip->bios_dir))
+		return;
 
 	chip->bin_log_seqops.chip = chip;
 	if (log_version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
@@ -135,14 +133,13 @@ void tpm_bios_log_setup(struct tpm_chip *chip)
 			&tpm1_binary_b_measurements_seqops;
 
 
-	chip->bios_dir[cnt] =
+	dentry =
 	    securityfs_create_file("binary_bios_measurements",
-				   0440, chip->bios_dir[0],
+				   0440, chip->bios_dir,
 				   (void *)&chip->bin_log_seqops,
 				   &tpm_bios_measurements_ops);
-	if (IS_ERR(chip->bios_dir[cnt]))
+	if (IS_ERR(dentry))
 		goto err;
-	cnt++;
 
 	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
 
@@ -150,42 +147,23 @@ void tpm_bios_log_setup(struct tpm_chip *chip)
 		chip->ascii_log_seqops.seqops =
 			&tpm1_ascii_b_measurements_seqops;
 
-		chip->bios_dir[cnt] =
+		dentry =
 			securityfs_create_file("ascii_bios_measurements",
-					       0440, chip->bios_dir[0],
+					       0440, chip->bios_dir,
 					       (void *)&chip->ascii_log_seqops,
 					       &tpm_bios_measurements_ops);
-		if (IS_ERR(chip->bios_dir[cnt]))
+		if (IS_ERR(dentry))
 			goto err;
-		cnt++;
 	}
 
 	return;
 
 err:
-	chip->bios_dir[cnt] = NULL;
 	tpm_bios_log_teardown(chip);
 	return;
 }
 
 void tpm_bios_log_teardown(struct tpm_chip *chip)
 {
-	int i;
-	struct inode *inode;
-
-	/* securityfs_remove currently doesn't take care of handling sync
-	 * between removal and opening of pseudo files. To handle this, a
-	 * workaround is added by making i_private = NULL here during removal
-	 * and to check it during open(), both within inode_lock()/unlock().
-	 * This design ensures that open() either safely gets kref or fails.
-	 */
-	for (i = (TPM_NUM_EVENT_LOG_FILES - 1); i >= 0; i--) {
-		if (chip->bios_dir[i]) {
-			inode = d_inode(chip->bios_dir[i]);
-			inode_lock(inode);
-			inode->i_private = NULL;
-			inode_unlock(inode);
-			securityfs_remove(chip->bios_dir[i]);
-		}
-	}
+	securityfs_remove(chip->bios_dir);
 }
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index a3d8305e88a5..9894c104dc93 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -182,7 +182,7 @@ struct tpm_chip {
 	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
 	bool duration_adjusted;
 
-	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
+	struct dentry *bios_dir;
 
 	const struct attribute_group *groups[3 + TPM_MAX_HASHES];
 	unsigned int groups_cnt;
-- 
2.39.5


