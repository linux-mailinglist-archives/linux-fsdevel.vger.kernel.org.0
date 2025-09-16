Return-Path: <linux-fsdevel+bounces-61748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AB6B598B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88FF37A2694
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BC8326D50;
	Tue, 16 Sep 2025 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C21u3d19"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0BF353354
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031200; cv=none; b=uNf4w5xTcNbSK/doPwmzWM21/orC2/jxTobdcc9zv1sDTfNlCUVk71k5EloULNqalxq6+S2NfhVulY7vY/MVRnLDUsfumoOkwgTfaHSypIETy41esmMI7RiHr6i0ns5lX6ypoj39jCLZd0xSqzoHwPY8DS355p0/2fTuc97tz6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031200; c=relaxed/simple;
	bh=c+jscvVcjHEiu8psO35s6FUxxWLk6N1H5PVjaYHBuTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJlBqnzHg7Dvjab8+o9kvraA+9OKzW4dn/Z5Pb7h7MpTh5pOh/NkVfvhGPw6/IdD5yXCp/04sXOj16dk3LQ8WASKxLlinY4VWR1GsdYbbXp620M8preBT8JuvDWGbewjVXIf6SmOsrHorpiyK/L6JV/xx2iuodmc7wAMRMNKcTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C21u3d19; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so34513095e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031197; x=1758635997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vENfTvsqrFJ9tJyBfgLNz2mb8wc8do/WZvddYLx/2MM=;
        b=C21u3d19x1DjsYLGY77AgVuGFJpc7Ig4fo4Ohm8jKWcl7iOvflvcwoJ48taJ4+fHLm
         tIdGWj1Za+IZGy/XPSuZty/tFmcdO9gKYqRvPzDG4iT2AAFWgiYbCa6zQVL1QjjdchTX
         /dAhqFk775dJjUo5Dobt1zHOXXoUVZkJ6hLgIjZTBWg4ztB+8AewMjOpnzltJlilhwHl
         0gfsMylQ001Vy1z2qGg6/HapEPCjePhuPj9OUpeXne4xp/jB1hdJ5OPPtc1GkVR/1UT0
         tvLara7/TZ0N5t5aa12RyY3LEr0f/nlndfwk7+cSe1jJmoGd4KvUQAVdffshf5o07KGd
         CYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031197; x=1758635997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vENfTvsqrFJ9tJyBfgLNz2mb8wc8do/WZvddYLx/2MM=;
        b=NRIR387ZWNt3AyQLrRHtnBeb50FUNhDWFs42LsuSFMRnYA7WN48HckPhPiDC1HceVB
         SkktMhbyhwBEVrr2wrX06D5OAtdlzBJ28uOisZ9evAQ/rFuqY5jn6YCEFWaHke0nPT26
         +9qRAz4OzB6YNPCqedxs7WGgNl/NnBfub/+aMjVYxmG2tHPZHD0eIutyTwFjZzX6t9YW
         hkQV81pd0ppUikXDPZgyBYn1RwfshoHn17epUDYeup0yosAEFvD6tDlyQydosSxwzSXC
         s4pfp27UnwRsRJosh09iaSt2aPm0a8ZNip5ZvGlA45LR+wY8k1TOK6Xb01tWcmYlzKL1
         TBhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPBDLnbAmcBigxzCbbgSZfAToSf1aDVrDJ4XpQw5IQC0gDaAUkl/Qtoy7KkUezUa7/X8KLI/7M6aXj2mEq@vger.kernel.org
X-Gm-Message-State: AOJu0YykyBIPYn4Xu4a2SS9hqYFE1jyd6awCzQuYlwr0wdpXY6ezhkTz
	RS83vTYufJzjMWlyKntPkxV3FErCizNtZvGJeSpwAmGmjtYeAjCcUunm
X-Gm-Gg: ASbGnctbJDPWzMu/MfbYM1hrjxBOkv3kBMTKDT4brNcPGxt6okYRxHFJa7jKu3uqy6j
	05SBbpTx/vt6pblPTsm/imvrAF9hexOpmvF64IYowP28q8TvbFp1hdBYPOm+7T7vbzr074O8Cv9
	5ehUkHBfUivy2l5lrJsxBLEdGPm2BdfNLJIGL3uc1JYpKJ+59vbcwjUuF8DMf/eWiSR8N/Aj7+S
	yynzlsTNBwqRoSxSbfgTv+7yL7Q8c9uftDTsD9Kbh5crjXFOybUJOXdSz4OgqCOfBy39fTIndcG
	YUz5djA4skb2b/xoBsFatt6i86nj2E/S1y0NYVaoJr8Hy6CNJgGUezZs05itGnZmcUslG3eqF3Y
	njx+j/c8TrjL8/Dtlzo/SndVHGWfU6zClD/swNtiVPMi3ClP/E31gIdpFmd+uWQ+SvwoIG4HE
X-Google-Smtp-Source: AGHT+IGywKOeZnJ30E7Ud2DvguwBt7x+jM+ZimZarnO2UYCjYh4k81VYRu4VVnkSvPh9Eqb3iEJtqg==
X-Received: by 2002:a05:600c:5254:b0:45f:284b:1d89 with SMTP id 5b1f17b1804b1-45f2a4f8bafmr97604315e9.25.1758031196860;
        Tue, 16 Sep 2025 06:59:56 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.06.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:59:56 -0700 (PDT)
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
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 09/12] f2fs: use the new ->i_state accessors
Date: Tue, 16 Sep 2025 15:58:57 +0200
Message-ID: <20250916135900.2170346-10-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916135900.2170346-1-mjguzik@gmail.com>
References: <20250916135900.2170346-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/f2fs/data.c  | 2 +-
 fs/f2fs/inode.c | 2 +-
 fs/f2fs/namei.c | 4 ++--
 fs/f2fs/super.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7961e0ddfca3..9cc22322ce7f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4241,7 +4241,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 
 	if (map.m_flags & F2FS_MAP_NEW)
 		iomap->flags |= IOMAP_F_NEW;
-	if ((inode->i_state & I_DIRTY_DATASYNC) ||
+	if ((inode_state_read_once(inode) & I_DIRTY_DATASYNC) ||
 	    offset + length > i_size_read(inode))
 		iomap->flags |= IOMAP_F_DIRTY;
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 8c4eafe9ffac..f1cda1900658 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -569,7 +569,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read_once(inode) & I_NEW)) {
 		if (is_meta_ino(sbi, ino)) {
 			f2fs_err(sbi, "inaccessible inode: %lu, run fsck to repair", ino);
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b882771e4699..7d977b80bae5 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -844,7 +844,7 @@ static int __f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 		f2fs_i_links_write(inode, false);
 
 		spin_lock(&inode->i_lock);
-		inode->i_state |= I_LINKABLE;
+		inode_state_add(inode, I_LINKABLE);
 		spin_unlock(&inode->i_lock);
 	} else {
 		if (file)
@@ -1057,7 +1057,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			goto put_out_dir;
 
 		spin_lock(&whiteout->i_lock);
-		whiteout->i_state &= ~I_LINKABLE;
+		inode_state_del(whiteout, I_LINKABLE);
 		spin_unlock(&whiteout->i_lock);
 
 		iput(whiteout);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2045642cfe3b..d8db9a4084fa 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1747,7 +1747,7 @@ static int f2fs_drop_inode(struct inode *inode)
 	 *    - f2fs_gc -> iput -> evict
 	 *       - inode_wait_for_writeback(inode)
 	 */
-	if ((!inode_unhashed(inode) && inode->i_state & I_SYNC)) {
+	if ((!inode_unhashed(inode) && inode_state_read(inode) & I_SYNC)) {
 		if (!inode->i_nlink && !is_bad_inode(inode)) {
 			/* to avoid evict_inode call simultaneously */
 			__iget(inode);
-- 
2.43.0


