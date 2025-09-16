Return-Path: <linux-fsdevel+bounces-61750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77087B598CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8796E4E23A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A55A36299C;
	Tue, 16 Sep 2025 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxR8ybYu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4704F35FC0F
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031208; cv=none; b=AGhdzGBuzpW2UJRPaWIwkyYPRipsEih0XLb3qTWEJ9ScSrcwE1DbNIG7UnlHG3XrcZwecGNV4fmzmWVSE9o/zv+yeglF2NHLuo3gzhpyP7VQ8bG/Qm9KPmSCtGU7XUsw+6V0Dq8uaDPEfVcxAeKsvuUZRNrV77PjzHmY6tRDZZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031208; c=relaxed/simple;
	bh=9uB5tIoSu0Ihqwy/dzzpF33dCVQXqPEjiR4jiBdlE6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZ1RepqQKI5rE9E8ghgDC+62fDvsD4LEmNOqMo/YqMO8SiGNz+Kjh/qYR+viKuHfrqMWLBGEKeHyRabv5Iua10iUPExcPVqGZXJPUUDJH4/K62BeEgjT8FZGQQZz5AIlPQtQfLnUycWu2ru/F1xt8noMvhePdGxJTx6JR9uwWZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxR8ybYu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso55138975e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031204; x=1758636004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jXBWCescUObzsT6Su0exTy7Btg138NHvbE5HLT4Jeo=;
        b=lxR8ybYuXYa9qNaTZ+hqKLsxR/u6BY6zzV/gtp4yDl4JzRW+ztA7qdJaNySrU8LmcZ
         +FSmJWBbnjLDWgyo81qjnG8LLkp49YRNdYlJqvcNLp1+zhsno83coVbLSowVmYzeurvP
         XsYd6YlG2dkp1qWYP1If5nmE0BPIBxlP6+3WVOfS6fWAMuJASV8e6HHvYe6qc7kxCtMz
         5HAaBdC8JUnGb9Wy/Tj8Fc6l2KcFMwegRHdlBFMG2gPhJIngXhaUXjdOvXzJA8ybaSYe
         J3/HVLwK1FojmIoSbCzAg99/Fl9poOSdGL8rtQSt6SG5a0ebPl6+1AKIxIWjjcXLmRom
         jeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031204; x=1758636004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jXBWCescUObzsT6Su0exTy7Btg138NHvbE5HLT4Jeo=;
        b=vu3zUoQ+u5EU4ItBcZ5SY70s4/fSI0x4zbwsUSKfIgLkbBYJrH6C35EiZL0WA5Onv9
         eD6+bQoePGlc1vZ6TVfSSEa4meFK8CheMCBqSq/k9UZe6ysv4hQf86kr3CLAWTudCSBl
         R2nM1XgAbevho/BvSYTG84Rjtnq+ZLo6e61FkOS9g05yTEp4bOoP6p/9N6dUQzMkPaUN
         dvv8dVajxvH2sy3Y5ZLFOxeHy+h66jexzFy4tiSR740AWOduUfVlbaFz82nsa9dlqvGb
         nA74AEWHNDHpbXbZ+3ao1L90gj2jiQBMMraw0YPM6R3imbIeAFbR68ZU0wR+QuZVIIuP
         DFCg==
X-Forwarded-Encrypted: i=1; AJvYcCXhTz/4O27hWK8TfEmOErTgSpA/zfg8BFRFocuTVT1Vgpf/az1kHO1y7E79bIWDPB5LRjKaHbWMxYC++Vrb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Ov4s+V2GRCowLdKVdL7F5bEIdwvowzOkUvCKKi0SRmrM4iyg
	dzCreLw/7JKKfnEjdgkZnu7F6BD6fwePHoPLu4qmZR/D1sIa5UiEe6Fv
X-Gm-Gg: ASbGncuVyrXRmRN7FxeKj1g6/cApqk4HDGv4FHt/lCIflEiUcRnTOJJMg7CBBDGjF3Y
	fJt5fMw2r6fXfXKeW98Vf+SllutB/KTeaxMfBuda86Vk+SrxAFGfJFQ36aCfCNxl8t/5MlDJPrs
	dhjcNghdaVj82CqrNM9+3EjKuMGHx41iWc8jwqGoenGp4MtDp6H5BLVYB+cIZv3cbsjgSwTPH11
	h/0uWSstNYpiZArZU933UX5dTzUbbZk4zsryWoiiWWUaQKY0rSP+ZuXSTaNr1+R5r+UAH5SCg8O
	SY8zHtsOWIEMXN/l5JJO7nqHgfiY0O1g2Fzkv88PTGEUk9szqLRS2pWNGu1gTTEZekTYoToh4D1
	aJ4Ax2S3A+WdEdUm2xUWGVQVA4dS6kqScnak/8o138Y7Kg2lQSPtiDBb8i8YhH+/tgs7P9peZ
X-Google-Smtp-Source: AGHT+IHwPsVwzVQ+3BwThlohyBuVsh7mtJyWbIwjAmCzyS+IiOJcg7GYx0sFvI9t/faLf/pLubt0LQ==
X-Received: by 2002:a05:600c:190f:b0:45b:4282:7b60 with SMTP id 5b1f17b1804b1-460614f9f91mr11287815e9.34.1758031204161;
        Tue, 16 Sep 2025 07:00:04 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.07.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:00:03 -0700 (PDT)
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
Subject: [PATCH v4 11/12] overlayfs: use the new ->i_state accessors
Date: Tue, 16 Sep 2025 15:58:59 +0200
Message-ID: <20250916135900.2170346-12-mjguzik@gmail.com>
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
 fs/overlayfs/dir.c   |  2 +-
 fs/overlayfs/inode.c |  6 +++---
 fs/overlayfs/util.c  | 10 +++++-----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 70b8687dc45e..eb3419c25dfc 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -659,7 +659,7 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
 		goto out_drop_write;
 
 	spin_lock(&inode->i_lock);
-	inode->i_state |= I_CREATING;
+	inode_state_add(inode, I_CREATING);
 	spin_unlock(&inode->i_lock);
 
 	inode_init_owner(&nop_mnt_idmap, inode, dentry->d_parent->d_inode, mode);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index ecb9f2019395..3f7ef3dae5e5 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -1149,7 +1149,7 @@ struct inode *ovl_get_trap_inode(struct super_block *sb, struct dentry *dir)
 	if (!trap)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(trap->i_state & I_NEW)) {
+	if (!(inode_state_read_once(trap) & I_NEW)) {
 		/* Conflicting layer roots? */
 		iput(trap);
 		return ERR_PTR(-ELOOP);
@@ -1240,7 +1240,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
 		inode = ovl_iget5(sb, oip->newinode, key);
 		if (!inode)
 			goto out_err;
-		if (!(inode->i_state & I_NEW)) {
+		if (!(inode_state_read_once(inode) & I_NEW)) {
 			/*
 			 * Verify that the underlying files stored in the inode
 			 * match those in the dentry.
@@ -1299,7 +1299,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
 	if (upperdentry)
 		ovl_check_protattr(inode, upperdentry);
 
-	if (inode->i_state & I_NEW)
+	if (inode_state_read_once(inode) & I_NEW)
 		unlock_new_inode(inode);
 out:
 	return inode;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index a33115e7384c..cfc7a7b00fba 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1019,8 +1019,8 @@ bool ovl_inuse_trylock(struct dentry *dentry)
 	bool locked = false;
 
 	spin_lock(&inode->i_lock);
-	if (!(inode->i_state & I_OVL_INUSE)) {
-		inode->i_state |= I_OVL_INUSE;
+	if (!(inode_state_read(inode) & I_OVL_INUSE)) {
+		inode_state_add(inode, I_OVL_INUSE);
 		locked = true;
 	}
 	spin_unlock(&inode->i_lock);
@@ -1034,8 +1034,8 @@ void ovl_inuse_unlock(struct dentry *dentry)
 		struct inode *inode = d_inode(dentry);
 
 		spin_lock(&inode->i_lock);
-		WARN_ON(!(inode->i_state & I_OVL_INUSE));
-		inode->i_state &= ~I_OVL_INUSE;
+		WARN_ON(!(inode_state_read(inode) & I_OVL_INUSE));
+		inode_state_del(inode, I_OVL_INUSE);
 		spin_unlock(&inode->i_lock);
 	}
 }
@@ -1046,7 +1046,7 @@ bool ovl_is_inuse(struct dentry *dentry)
 	bool inuse;
 
 	spin_lock(&inode->i_lock);
-	inuse = (inode->i_state & I_OVL_INUSE);
+	inuse = (inode_state_read(inode) & I_OVL_INUSE);
 	spin_unlock(&inode->i_lock);
 
 	return inuse;
-- 
2.43.0


