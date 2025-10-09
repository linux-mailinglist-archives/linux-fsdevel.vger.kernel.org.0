Return-Path: <linux-fsdevel+bounces-63638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B0CBC7E30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 10:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79D13E62D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 08:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C940B2E0B77;
	Thu,  9 Oct 2025 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf6GuUdU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDB82D9EDF
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996800; cv=none; b=lLzXbtHiEIMCoCifjQrqlR17zn41WYLNTlnBwy8P8QUqP5Y53i/8GGC3ShBa8j5vq2sUY/i3RervY66gn0n4FkxJ+1+cJfRjp5uPIYa6860uv17Utbaoa+0Okm+276IqEJVTdbvS8mjGVSmnKgjLVjxXVREdBs4cT+kAxK+rtb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996800; c=relaxed/simple;
	bh=QVMfbOgdcHUC8MA0FXNAvsLx1wDWQy6WIvHpfH+dzno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfI1phqYLVki4t79cTSAkD1JLfk4qJms3agOZmbDcoAJr9iezbdZ4kqsVH8TOiFaBNN02FNmpQ+BrOzMnENrVhUnI/2rVw7XjL25JbQ/szE/Kqnwtns2GrXfiFSmGalG/Z1jCuLIWWp3h3aTGAwiEMb3Ae3D3DFCCRTXX3trmZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uf6GuUdU; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3da3b34950so103117166b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 00:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996795; x=1760601595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIPlImYUmrVBYfxz+HlFQqCPCvc3ID3O+4ctjIKepMc=;
        b=Uf6GuUdU5qGcyXY/QE0xsvc54ppyyNy+WjunZiiid9wZoBoElQZtYJhTqfkdGsZ/Dw
         UOPCKCzEjlofEbYCIUeVQ7UGhPL5ZOTIKVqK8IEywi9Qw2A6b7E2zU76IaRm/F+2jYz9
         ISQRvZARuGcwOvQOCvRAxj8EBFu52MKxUw9K2fkR9Bvm0Ryt/dc7WWgqEiGemOvCbCQV
         Vpr9uf6Rx78KsW953fmxOg95jKHx3sEvASdCnIFwVw0HesGxeTSCrQrESsvm1FyGJDu1
         8xSEeEEUTtfg6bKph0Kq3YSkzGdNGmpXa/Gxp89Mf6xlMss0vBudN7iH1xiGByi+FtcT
         gpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996795; x=1760601595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIPlImYUmrVBYfxz+HlFQqCPCvc3ID3O+4ctjIKepMc=;
        b=vZvk9V+d+k41SihWIkG/Sx1I43TdLcJtaxRvl9uwA8/rxpwVT/55X0t7yfWltW0fXH
         8K8/nr4V+bE990vzxxJ1HP+sp2q1DiL29r+pAsub/fNVJ/5RRN7sZ3UqQgpMkqgHAi/H
         hQPjqeW8inD9ZWg4Ize4S+6kDsrCCa+4XCmGDBWaIfIWCWUaldD+occzNXfyxX+f2Tr1
         DdoWVaNDzRNsn2MFsOM8MBWg+mEoBUYEJKpwkPTCWmEQFJapYqwYaypNugijoMv93LFR
         hxezXMm2O8f7qstCXgAtZSVdWth6UbLPINZ015Uo2NeGaoN3ucADPi9w7Mu8/41jAueW
         oIYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5ZIQrRwIw70HQ2nDOltoOx4sd9c1uRppGcc9sfcDDNrTw/LLs/9p140l+vzzZI7fb/HtEFtkAENmJRUPP@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe+t7yn4sD7funjtp23+pCloZD8P41fN2Q+00lFQdzxNfQRL+R
	PqXS09XDlCVvfIZDbblgPJo0nPpxpLO418Nq8hETABCHMDj4PdIjpeVX
X-Gm-Gg: ASbGncugOlk+X1StGr/9ArNFDyyZYjImU35Y9MR1jY2ilmhI1zvTuABaMMetobouj70
	lPuiedn03MVuIuVxHindv3atSBwt9Twjvu251hPpvioZBbXOvn+VkMjPqTMrSTWkvMTzRKh5e9E
	fRXBnOLChYD5Hb8ZV/ThHt+eR2n1uIb7vhbSIKOAuGYNjFwjZGjKPgUjvoC/KTV5oMHVLETXm0t
	xqtZxAL0D+L+xldenJytrEQlR7sY2qomd/W4L8HT9f4sVByIqfKHy0HYL/OcZUbnDiIJjy4Njmh
	QAVP7W/9I3UFrZ2X9ayZcoasyN3EZVVT/abMxKBya8Zufb8gFO5+DQKx1Ffqo6le4OZUNTYlEV2
	YtHvcVq3wH6ZrInFUuUIHSXAAUy47nPbfEQQZ3puKFyTcj6w6QOrYxQhxvkp9StIDPbaElOrlZy
	OS9iORcGzcVYhApS/fen2WfA==
X-Google-Smtp-Source: AGHT+IFNrrAwL3X54wIwGninQDRe5HCAzI3hX5RakrOFeGNwzcDRNVEDhJxmZSvdgNTCtAirMAoMEA==
X-Received: by 2002:a17:907:5c8:b0:b40:b6a9:f70f with SMTP id a640c23a62f3a-b50a9c5b352mr706189766b.4.1759996794568;
        Thu, 09 Oct 2025 00:59:54 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.00.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:59:54 -0700 (PDT)
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
Subject: [PATCH v7 09/14] f2fs: use the new ->i_state accessors
Date: Thu,  9 Oct 2025 09:59:23 +0200
Message-ID: <20251009075929.1203950-10-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009075929.1203950-1-mjguzik@gmail.com>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
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

cheat sheet:

If ->i_lock is held, then:

state = inode->i_state          => state = inode_state_read(inode)
inode->i_state |= (I_A | I_B)   => inode_state_set(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_clear(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_assign(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally:

state = inode->i_state          => state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B)   => inode_state_set_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_clear_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_assign_raw(inode, I_A | I_B)

 fs/f2fs/data.c  | 2 +-
 fs/f2fs/inode.c | 2 +-
 fs/f2fs/namei.c | 4 ++--
 fs/f2fs/super.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ef38e62cda8f..c5319864e4ff 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4222,7 +4222,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 
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
index b882771e4699..af40282a6948 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -844,7 +844,7 @@ static int __f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 		f2fs_i_links_write(inode, false);
 
 		spin_lock(&inode->i_lock);
-		inode->i_state |= I_LINKABLE;
+		inode_state_set(inode, I_LINKABLE);
 		spin_unlock(&inode->i_lock);
 	} else {
 		if (file)
@@ -1057,7 +1057,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			goto put_out_dir;
 
 		spin_lock(&whiteout->i_lock);
-		whiteout->i_state &= ~I_LINKABLE;
+		inode_state_clear(whiteout, I_LINKABLE);
 		spin_unlock(&whiteout->i_lock);
 
 		iput(whiteout);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fd8e7b0b2166..8806a1f221cf 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1798,7 +1798,7 @@ static int f2fs_drop_inode(struct inode *inode)
 	 *    - f2fs_gc -> iput -> evict
 	 *       - inode_wait_for_writeback(inode)
 	 */
-	if ((!inode_unhashed(inode) && inode->i_state & I_SYNC)) {
+	if ((!inode_unhashed(inode) && inode_state_read(inode) & I_SYNC)) {
 		if (!inode->i_nlink && !is_bad_inode(inode)) {
 			/* to avoid evict_inode call simultaneously */
 			__iget(inode);
-- 
2.34.1


