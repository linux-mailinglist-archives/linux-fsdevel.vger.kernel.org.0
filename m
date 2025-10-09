Return-Path: <linux-fsdevel+bounces-63633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F5ABC7DC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 10:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4578D3519E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 08:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81122D193C;
	Thu,  9 Oct 2025 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E55vTmMQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770372D23A3
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 07:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996789; cv=none; b=DkpdSIwzRAuGygcLbO8Jx8/8Byv5G2AL/qgHvVteZnCxWYOY33//wv0Dcxzh4SXCL+hSqlbilduHA1FwvNKmQfe+5BKu9DcCxXeERqxGYob00TSgdsWzFnx+4ASPWYDVtf60LFbWxCm3IvdoXEh2yAXYskyYDdgDZGOuVVndDaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996789; c=relaxed/simple;
	bh=JAU4oetIKsiFFQoxD4BOLbL092tRs1Y5zrd0wB8hP3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcMHTIlzmT9+OD+NyQ1Dg5t1z7/+2iprwNICOzhcvkFpv1AUze//2jIU29OSfNcxEyog07gyV3FR5+xVlQ1h9U5r2UaKnYQTv0EJJWUeMcDzJgiHD1qy1FcW9ckc1FUYw+OYVxs4jsj1KA1QRRECn/v66V9pE8mL33UM7vOFpbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E55vTmMQ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b463f986f80so140387166b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 00:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996785; x=1760601585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BImMKCDjo8UcgLF4QMJ2SKqY3V/e7t3G8DgvFQjtsv4=;
        b=E55vTmMQPuIsBWpR+wSLdHpUA7OJu+0uKgWLiQNF7rZ53zbtjoDnxV2lDTzB98VXPs
         PmpMv1T+jJCUb0JKHj88embadcVYrbbICu5CdZWG/sa7KKeeHGTw8i5qx1j0JVeq2w2k
         qP76iVEv3J5a8CzP1VQJzd7AoIHyt+hCzYdmXhyAIi9fkjVhuzdUm8qap8UGoiCY0YD/
         cMZk0Joo8VFVz1XRUEgMZaFVWsIf7+6olS82P7R8EsbLGiqrnfLbK4RYvy0ceXHBlOhv
         a5XRmPQcERwzNZ5AZTbprOCXLAa31uQhgT96YekXlD0932f7tL+XC7IQ/wLfR2ovJqyI
         8veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996785; x=1760601585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BImMKCDjo8UcgLF4QMJ2SKqY3V/e7t3G8DgvFQjtsv4=;
        b=fQKVxDkbSVaH0g2ytoSrszwhNRNKu/R1VPaD4Ea/HzgZLPJw7XexRxt7RMYfm2zdK2
         KoEy5/kwbqSfvGgoEQsp1IqJxnTOjCFfE8FBZ69CGCuTDzEinIJ53pALSDs4I3MlbUr1
         LGG9l6XwuEvpGKzoP35jO5PmLOQzAZiN9ZYbyGkO7rmDig5wiazEARzrUa/BzerpaCvI
         mJJtcQMiFSmapLCZtX00WJKlhXykpWQ5d1vnkkxbNXzQH4GByqwhlFNF6rgQZOY4xqMR
         mMGF6htsBhkaeOW1zNNbmHBaN0BVsumilo8JCdqUltxg9ZYvWnO2AnKvp2gUcWDjnxBv
         3GEg==
X-Forwarded-Encrypted: i=1; AJvYcCXAQlXDIXwZgVhhiRX+NNOcr2RTiop+FBOhNse22ay/PHd+Zg2tn8x/6sFReKwtod+WrB6dNlYGH8nSlrFZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzFWh6YLRBYVEZHRA0R4+WcO/UEeH7Wv5FsaAYcx0m3aCUC/CF4
	JMs8Y+MvnZBIdBiYQ72rl/tw7ytke0qj7/UL6+QHLzVJk86bueY+hXg6
X-Gm-Gg: ASbGncsECFmcWNVO+8ewuaKu45eisHziSKXaYUtu/k7yI7LSzdLhy6RU6BQruTAnhZe
	MTm+EIEkGfgvwNWiz5uBnBW6RtuP8SBnXGIs5fmROVcH70/LR3s8XpraFSHt67+nVpJz8XvB9TN
	6xvfeRVorOi2BqvQWEULyX9BGohAvPMU2M26t1O8klL9JLtWgfSY0Ss+9jOtbQ0pMSUmm2imGmT
	b/Wt1mZ2jw1BAqB0Ck02JgCDIUrzLcnB0q0SnbrtWEGgEhl/lu4xByADHcMjl99Wnof31dUcXlc
	gDddUx+tDjoc/RBdWzWwqLJjsvqhnrLoo6pezC78+/jSBaxLJPlICpEoIda1H8qWa0IkYJfh+FQ
	+alLxNgaqUoR25PO0ObvX98yI1RLtBCY1KKMvv+z188m+FC+C+ykvhlwVxs/ph+bMV+vw4weyLF
	1gcsM973e8At3jdca+jPMHrA==
X-Google-Smtp-Source: AGHT+IENbCwcvaxD9DGquoigQ8tdDndKKU4pj4q2EF42sPm/388Ywdvf1nQR/63uusvC/5TSS5tPxg==
X-Received: by 2002:a17:907:3daa:b0:b46:31be:e8f0 with SMTP id a640c23a62f3a-b50a9c5b3c8mr785496066b.3.1759996784546;
        Thu, 09 Oct 2025 00:59:44 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.00.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:59:43 -0700 (PDT)
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
Subject: [PATCH v7 03/14] fs: provide accessors for ->i_state
Date: Thu,  9 Oct 2025 09:59:17 +0200
Message-ID: <20251009075929.1203950-4-mjguzik@gmail.com>
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

Open-coded accesses prevent asserting they are done correctly. One
obvious aspect is locking, but significantly more can checked. For
example it can be detected when the code is clearing flags which are
already missing, or is setting flags when it is illegal (e.g., I_FREEING
when ->i_count > 0).

In order to keep things manageable this patchset merely gets the thing
off the ground with only lockdep checks baked in.

Current consumers can be trivially converted.

Suppose flags I_A and I_B are to be handled.

If ->i_lock is held, then:

state = inode->i_state  	=> state = inode_state_read(inode)
inode->i_state |= (I_A | I_B) 	=> inode_state_set(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B) 	=> inode_state_clear(inode, I_A | I_B)
inode->i_state = I_A | I_B	=> inode_state_assign(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally:

state = inode->i_state  	=> state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B) 	=> inode_state_set_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B) 	=> inode_state_clear_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B	=> inode_state_assign_raw(inode, I_A | I_B)

The "_once" vs "_raw" discrepancy stems from the read variant differing
by READ_ONCE as opposed to just lockdep checks.

Finally, if you want to atomically clear flags and set new ones, the
following:

state = inode->i_state;
state &= ~I_A;
state |= I_B;
inode->i_state = state;

turns into:

inode_state_replace(inode, I_A, I_B);

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 78 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b35014ba681b..909eb1e68637 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -759,7 +759,7 @@ enum inode_state_bits {
 	/* reserved wait address bit 3 */
 };
 
-enum inode_state_flags_t {
+enum inode_state_flags_enum {
 	I_NEW			= (1U << __I_NEW),
 	I_SYNC			= (1U << __I_SYNC),
 	I_LRU_ISOLATING         = (1U << __I_LRU_ISOLATING),
@@ -843,7 +843,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	enum inode_state_flags_t	i_state;
+	enum inode_state_flags_enum i_state;
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
@@ -902,6 +902,80 @@ struct inode {
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
+/*
+ * i_state handling
+ *
+ * We hide all of it behind helpers so that we can validate consumers.
+ */
+static inline enum inode_state_flags_enum inode_state_read_once(struct inode *inode)
+{
+	return READ_ONCE(inode->i_state);
+}
+
+static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
+{
+	lockdep_assert_held(&inode->i_lock);
+	return inode->i_state;
+}
+
+static inline void inode_state_set_raw(struct inode *inode,
+				       enum inode_state_flags_enum flags)
+{
+	WRITE_ONCE(inode->i_state, inode->i_state | flags);
+}
+
+static inline void inode_state_set(struct inode *inode,
+				   enum inode_state_flags_enum flags)
+{
+	lockdep_assert_held(&inode->i_lock);
+	inode_state_set_raw(inode, flags);
+}
+
+static inline void inode_state_clear_raw(struct inode *inode,
+					 enum inode_state_flags_enum flags)
+{
+	WRITE_ONCE(inode->i_state, inode->i_state & ~flags);
+}
+
+static inline void inode_state_clear(struct inode *inode,
+				     enum inode_state_flags_enum flags)
+{
+	lockdep_assert_held(&inode->i_lock);
+	inode_state_clear_raw(inode, flags);
+}
+
+static inline void inode_state_assign_raw(struct inode *inode,
+					  enum inode_state_flags_enum flags)
+{
+	WRITE_ONCE(inode->i_state, flags);
+}
+
+static inline void inode_state_assign(struct inode *inode,
+				      enum inode_state_flags_enum flags)
+{
+	lockdep_assert_held(&inode->i_lock);
+	inode_state_assign_raw(inode, flags);
+}
+
+static inline void inode_state_replace_raw(struct inode *inode,
+					   enum inode_state_flags_enum clearflags,
+					   enum inode_state_flags_enum setflags)
+{
+	enum inode_state_flags_enum flags;
+	flags = inode->i_state;
+	flags &= ~clearflags;
+	flags |= setflags;
+	inode_state_assign_raw(inode, flags);
+}
+
+static inline void inode_state_replace(struct inode *inode,
+				       enum inode_state_flags_enum clearflags,
+				       enum inode_state_flags_enum setflags)
+{
+	lockdep_assert_held(&inode->i_lock);
+	inode_state_replace_raw(inode, clearflags, setflags);
+}
+
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
 {
 	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
-- 
2.34.1


