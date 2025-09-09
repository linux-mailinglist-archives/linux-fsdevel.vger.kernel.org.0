Return-Path: <linux-fsdevel+bounces-60635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4E4B4A74A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 11:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC464173DBB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 09:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D00129E0F6;
	Tue,  9 Sep 2025 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zdz5dtNn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BA1285CBB;
	Tue,  9 Sep 2025 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409259; cv=none; b=pxQ0Vosl9QjgfUxx2qxl+Bdz0PYIey1iKpGsezkN0+qQRb9fsCoHIHymMS8bC7m64HWZuaXOGVez0XKZJpQL9mUHpvrOQ8fSeMlkl9jKn1UyNdsGVHV+Hl40+GGgDIHXWolRe3c6OhKvmKMzg6oVPJugtMjTs/cWSO5Vu0o+mQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409259; c=relaxed/simple;
	bh=BdTaArvmGkBuLGGtyHfh2TGj+o6P+9OkZp4zyvMpLBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1NE7MuLZanIt6yCoaqA+VJzPMjWRMpmiZw2WvyiwV4QMENUUqbYWjTdV+7kpeAIEyBfAA9+2XorpJuYSc9u/z6bc/StXggfgQ1iGOsinKlmlGo32S2/USZDOrVKzd2U35cHVyAR+Cyh9N/fiqyltgRIz01zjUt1OSiaI5z5Jsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zdz5dtNn; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e249a4d605so4286908f8f.3;
        Tue, 09 Sep 2025 02:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409255; x=1758014055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAkwWZPKx/h0WObhLl7ADVXI+izd4bElBlrOtR29tis=;
        b=Zdz5dtNngt7ffWhvoHBA3G2siboG5B5ABZl7ESFWxxFarVaJKP/Yw+1epdAmn82EiG
         hWlMLwqdgTcARzVJtMcSR+GNgvUVrOV/jdwlCytmWohRP/UWZ6kSLcZquJ+gX557bQ+w
         7SRPxhmneJ5+Pe7wZJBzQLG6KHiHEWVjTnmT7FFrKETLq0+GmWqrlrJhHE9Jbp+/F9Cd
         EtM9VbuzfJbw4LEhzaStZicqIWy9E/JWt/y87ifec2bpZ/MC6qFd7rGkt0/MOx7s7I1u
         42M816DJ3JuRa2rm30BsICP/Vj8+1brj3gnx8yxH2xExCQiXlJAuqcKEAgvMW+kDbDy+
         HWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409255; x=1758014055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAkwWZPKx/h0WObhLl7ADVXI+izd4bElBlrOtR29tis=;
        b=XvrMZHpTTN3pu7Vv/cXCC9ZOx9cjg/9ykT1qA/Y5ah4fJivC+LmLm5Wqvm6ylB3TuN
         0vLBs9cXuChW7RwVPK4anuPih7XP+Dt2lAlDLkQf9Asq5giwWF1d7/B1yNEd7ZpzkWsa
         /6KwAvgOTiYP34rJR/OSRAw6clcakLRNPLg3KzlmqNlmpNgSumEhAfm8Ys6Gc/xS4HaS
         ncpH5xBCi7BoQFX+HLuxWURvoT0hbqCGYoSo9jL0m/YH/D/105jFnPs4nMIkZ0CzBBBN
         XBp7Qq1yaM6H3aN+f1qA63kf5dSb6PMj9sLtbt92EgN8zIzSPRK1QuNO0Mml9E5xSCSo
         d5lA==
X-Forwarded-Encrypted: i=1; AJvYcCUEK9O3Uu76zHwj4s5Q31kcdnNoi3eZ1a1tWTzZlLjrwjwPJakrfWSxlSPdjbzKgmkZVdJ4e60VGPwYepTg@vger.kernel.org, AJvYcCUIO+wN3yCVy+DTalFrELskLD1MepMVhKLy6xOElCJHFV28l5c4S0nSylbwQjx7eNoiziSzKJZZ2SHi+7++kw==@vger.kernel.org, AJvYcCUeHMGNBFFlEp0Txhc1HFonobyUIFamOAsGaFTrBHZAwE73nmrycPKMOzQRTLOfJMcNzc6sdAFR5xfBBQ==@vger.kernel.org, AJvYcCUgk501/4jGyAmP93BQHyTYW02gZ9m6N447/G60waUumcI7lK7pRa1QCQxokuwc/66ZKD1ksXdURPoM@vger.kernel.org, AJvYcCW7v/VmFmJmM3rXkdFfvO4MY4sd+hJd0x9akdJpaXsmgoWXf7gZk/PKrNfQAiT8IX9Dw8xOVHjzjACiOA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi0j7g7Y0OROzB7wbdFi3+fB3D7TLhc5kFmt+A4DbD8xENgF5j
	qwcmjDlEoQIVRJgOJvg1OxA+5ylnq4g5O/ahNeogY0RdCsBanaTaRRiF
X-Gm-Gg: ASbGncts4FefoXaRG2WZzpmTYZnKQPQcK2FagHbV14/F5eHy09sR0LAjzmoTU9/r3wc
	T/TL6S5T84VG+E0cQPKFlwAmmrRkBis1ATsWsrDHPfLPBrW60ZifEKKHXWTiDqKtmKVmBbTMnhu
	oBNEX/VG3KK0NM9mXSjexMbeUhpy02kalZ9DwSiKh8D5TuMCaNEzShX/s284T2ZWl+NjbjVU2JZ
	3JwPE05XOxlxd/uMGOiFAzOY6jBn115yDto0Z7wtFLtj3VZGCshp+33nPTBfKI8e7ckuYIHFBDF
	WJROs/cXEBcshhq32kHf6LqS3N6Io9h1nrFfQOZ6e20A71YQ46CQMX8Q63fZYhjzCBqt3Su3SAX
	OcTrMA6JVB2FqbzAW3P0U7EmgNe+k32ikgKsCKajO
X-Google-Smtp-Source: AGHT+IHFR5glDC7pT0pDvmRqpKg6rH7YeMgcZQ374nE01iyhNYdctYhtZjBoNSHdXlfL7T1OlO5Mow==
X-Received: by 2002:a05:6000:248a:b0:3e4:f194:2887 with SMTP id ffacd0b85a97d-3e6462583c1mr7538835f8f.30.1757409254879;
        Tue, 09 Sep 2025 02:14:14 -0700 (PDT)
Received: from f.. (cst-prg-84-152.cust.vodafone.cz. [46.135.84.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bff6esm1810784f8f.13.2025.09.09.02.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:14:14 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 05/10] ext4: use the new ->i_state accessors
Date: Tue,  9 Sep 2025 11:13:39 +0200
Message-ID: <20250909091344.1299099-6-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909091344.1299099-1-mjguzik@gmail.com>
References: <20250909091344.1299099-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/ext4/inode.c  | 10 +++++-----
 fs/ext4/orphan.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ed54c4d0f2f9..55d87fa1c5af 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -425,7 +425,7 @@ void ext4_check_map_extents_env(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) ||
 	    IS_NOQUOTA(inode) || IS_VERITY(inode) ||
 	    is_special_ino(inode->i_sb, inode->i_ino) ||
-	    (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) ||
+	    (inode_state_read_unlocked(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) ||
 	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
 	    ext4_verity_in_progress(inode))
 		return;
@@ -3473,7 +3473,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 	/* Any metadata buffers to write? */
 	if (!list_empty(&inode->i_mapping->i_private_list))
 		return true;
-	return inode->i_state & I_DIRTY_DATASYNC;
+	return inode_state_read_unlocked(inode) & I_DIRTY_DATASYNC;
 }
 
 static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
@@ -4581,7 +4581,7 @@ int ext4_truncate(struct inode *inode)
 	 * or it's a completely new inode. In those cases we might not
 	 * have i_rwsem locked because it's not necessary.
 	 */
-	if (!(inode->i_state & (I_NEW|I_FREEING)))
+	if (!(inode_state_read_unlocked(inode) & (I_NEW|I_FREEING)))
 		WARN_ON(!inode_is_locked(inode));
 	trace_ext4_truncate_enter(inode);
 
@@ -5239,7 +5239,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read_unlocked(inode) & I_NEW)) {
 		ret = check_igot_inode(inode, flags, function, line);
 		if (ret) {
 			iput(inode);
@@ -5570,7 +5570,7 @@ static void __ext4_update_other_inode_time(struct super_block *sb,
 	if (inode_is_dirtytime_only(inode)) {
 		struct ext4_inode_info	*ei = EXT4_I(inode);
 
-		inode->i_state &= ~I_DIRTY_TIME;
+		inode_state_del(inode, I_DIRTY_TIME);
 		spin_unlock(&inode->i_lock);
 
 		spin_lock(&ei->i_raw_lock);
diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 7c7f792ad6ab..70444810bd7a 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -107,7 +107,7 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal || is_bad_inode(inode))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode_state_read_unlocked(inode) & (I_NEW | I_FREEING)) &&
 		     !inode_is_locked(inode));
 	/*
 	 * Inode orphaned in orphan file or in orphan list?
@@ -236,7 +236,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal && !(sbi->s_mount_state & EXT4_ORPHAN_FS))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode_state_read_unlocked(inode) & (I_NEW | I_FREEING)) &&
 		     !inode_is_locked(inode));
 	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE))
 		return ext4_orphan_file_del(handle, inode);
-- 
2.43.0


