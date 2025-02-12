Return-Path: <linux-fsdevel+bounces-41606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D525EA32E21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 19:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CB93A9012
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 18:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C71625D537;
	Wed, 12 Feb 2025 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM32x8Gh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAEA209663;
	Wed, 12 Feb 2025 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383513; cv=none; b=BGkSfGENnjnpCYx2f44t5ClvLriwn6lPA4ZeygJ2ZcrhPC9+pSIyahXTWaP+ADrEkesni69KCP4mymlAv86jD8GawexXNN6BdhOEnbrj9Y6ewFWYqU5PagsPhfpQKT8016/UQVQ87+Dks9Guvf9mj93z5cH6KRbu48EHsx27Qzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383513; c=relaxed/simple;
	bh=Of13pDR+rL3ar+5qGlO0YmqRQidYlw4xUlGWqH3VbmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJctmviw4B68OBGDo/fjUi6nNlgd/IFW6+7cvhKdy3iEx/D5dIppZzvMC8YtnjduitiTZQTpuc2Bssr8A3dznKtCUjTP0laKa4eBkr/lkpWGYNoFWZtZqEAENk8Jv7UeTrMXS8z0XnH/CNp78dNHZxNtf0F1rYPuuMP9EEtOVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kM32x8Gh; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7ee6f54faso217551066b.2;
        Wed, 12 Feb 2025 10:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739383506; x=1739988306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X4EDivi/bFQR16bT1xbYv6bkoYZTOkcBw6NU7fKWHRs=;
        b=kM32x8GhC5YoNvFUGkBhpVHK6i+picMAcEL77hvuyjvhoemLgzlvuXCFqi+p7FNhYe
         TfK5zR9gyxmsZV1iElzcfiyvIxg3wxAJemyrXs1/TqnexvkA1fcWWgF+RdR0FpW4V0/2
         mXyT3n/F7NqZPDk6T1puzXWD7SS7hK14UCGvW6ErbVoPU4CDmqGIDijpOHTZx+PA/caQ
         631ze/lGy4GFQxiZ8guYrWBEJE9QqtPOEJ5/LtI13oTQkBiyDJKvMT55OJCndLNHGWWZ
         o1MO4I4agURH+PtZWHnsspqs5wQHRbjB2IY5G7yrd+t81Z8asQo0kv69njfzlYRi0Jdo
         qXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739383506; x=1739988306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4EDivi/bFQR16bT1xbYv6bkoYZTOkcBw6NU7fKWHRs=;
        b=CHctzsi3oTglKrWYJdhlheYxlWvGTEU1Q3+m5KFLM78vHOlEidMK+W8mKAqrRePgx/
         59jvpUQX61rnsAB6a4Y4O3IjlJpSluZFj1+rEKLh/w9klvaGI/Ci2+aPcpA+xIcoC9j4
         v2F6tVb+Aq3QVKH/hXNI34i6tW1hfgKy7osba4G5tp0x5n0tOKR/NC4glLVrrHOnpNC2
         rycnUg/8oSKIS1mIkeAG7hE03/0FliG+u1XdoyaX4UM2ljTAPlmh+HL697hTzbOWBNGp
         H7/yC3bObCvwdPTQiJlk80sXFuEF4sCwxgMVEe1bQTifQmN8MZf5jBtq3H1LIJEKJyEk
         7KdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfUsLLo3H3uSz9O9fS5ZqWxnhIhjVZ6Is3KjMbUDMICDjHXEW7xEnuneSEcDC1M24sd1suCFx5cEdc5bsb@vger.kernel.org, AJvYcCVryUuzTeflD55UVWHVRhf404naIg4obz1O3sAaVcD/X6A+vK9CAnCW2oDfTWeQLN26t7EuMUWAJ9iaZs5P@vger.kernel.org
X-Gm-Message-State: AOJu0YzCUjPXYaSWHXfsm9UzAfvUfkoP1Na0iDPsXILYLuyIwtR65gDw
	gJDNtduT/ZpG0qYJQ3mstPl7B0wV03IqfNicK9C6CKwZiK0so7ot
X-Gm-Gg: ASbGncvQXfdH41Tsens9RHzkPl7Bme60jpd34kfEzp8l4SxFnORaxPjjAHNCNGGg1HA
	pGBS1skNojN4AdeJgNkSJIWGB8afTFSxr5VW5e2vQiFpDfyv4T6IcHbS4Md+0C6iKReAUpbe74G
	LxGtnuacDB0xuUnT7QxZynGv7viNVOuPXu4cjzxw0hwaGr/U4tmFkjs0pNScNZbYCO/p2cUxOzO
	vos7J085ivee6roMRZ3RE83nTIMOEbDZi9PKNLAhZ5Iw1Ghga/k2mAYKmpaKG4ZGX3kgsUOrFGQ
	nrF8084DgEEDQOBmOma/kbs6eBvXbqeHEA==
X-Google-Smtp-Source: AGHT+IHk6BtqCf+F+HoIKAHTyaJNhAzqoRU0O199U9D6YmO5ew3SrAKvUEFPToji4YCZjdEUUKurYg==
X-Received: by 2002:a05:6402:5285:b0:5dc:7374:261d with SMTP id 4fb4d7f45d1cf-5dec9d2c146mr354358a12.7.1739383506058;
        Wed, 12 Feb 2025 10:05:06 -0800 (PST)
Received: from f.. (cst-prg-94-109.cust.vodafone.cz. [46.135.94.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de5142ba50sm9904796a12.11.2025.02.12.10.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 10:05:05 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: inline new_inode_pseudo() and de-staticize alloc_inode()
Date: Wed, 12 Feb 2025 19:04:59 +0100
Message-ID: <20250212180459.1022983-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The former is a no-op wrapper with the same argument.

I left it in place to not lose the information who needs it -- one day
"pseudo" inodes may start differing from what alloc_inode() returns.

In the meantime no point taking a detour.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c         | 29 ++++++++++++-----------------
 include/linux/fs.h |  6 +++++-
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 5587aabdaa5e..6e251e43bf70 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -327,7 +327,17 @@ static void i_callback(struct rcu_head *head)
 		free_inode_nonrcu(inode);
 }
 
-static struct inode *alloc_inode(struct super_block *sb)
+/**
+ *	alloc_inode 	- obtain an inode
+ *	@sb: superblock
+ *
+ *	Allocates a new inode for given superblock.
+ *	Inode wont be chained in superblock s_inodes list
+ *	This means :
+ *	- fs can't be unmount
+ *	- quotas, fsnotify, writeback can't work
+ */
+struct inode *alloc_inode(struct super_block *sb)
 {
 	const struct super_operations *ops = sb->s_op;
 	struct inode *inode;
@@ -1159,21 +1169,6 @@ unsigned int get_next_ino(void)
 }
 EXPORT_SYMBOL(get_next_ino);
 
-/**
- *	new_inode_pseudo 	- obtain an inode
- *	@sb: superblock
- *
- *	Allocates a new inode for given superblock.
- *	Inode wont be chained in superblock s_inodes list
- *	This means :
- *	- fs can't be unmount
- *	- quotas, fsnotify, writeback can't work
- */
-struct inode *new_inode_pseudo(struct super_block *sb)
-{
-	return alloc_inode(sb);
-}
-
 /**
  *	new_inode 	- obtain an inode
  *	@sb: superblock
@@ -1190,7 +1185,7 @@ struct inode *new_inode(struct super_block *sb)
 {
 	struct inode *inode;
 
-	inode = new_inode_pseudo(sb);
+	inode = alloc_inode(sb);
 	if (inode)
 		inode_sb_list_add(inode);
 	return inode;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 640949116cf9..ac5d699e3aab 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3287,7 +3287,11 @@ static inline void __iget(struct inode *inode)
 extern void iget_failed(struct inode *);
 extern void clear_inode(struct inode *);
 extern void __destroy_inode(struct inode *);
-extern struct inode *new_inode_pseudo(struct super_block *sb);
+struct inode *alloc_inode(struct super_block *sb);
+static inline struct inode *new_inode_pseudo(struct super_block *sb)
+{
+	return alloc_inode(sb);
+}
 extern struct inode *new_inode(struct super_block *sb);
 extern void free_inode_nonrcu(struct inode *inode);
 extern int setattr_should_drop_suidgid(struct mnt_idmap *, struct inode *);
-- 
2.43.0


