Return-Path: <linux-fsdevel+bounces-61954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21736B809E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 17:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4CC621BDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDA033AE8B;
	Wed, 17 Sep 2025 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DNNQqBqh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4003030C0E0
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123408; cv=none; b=UQ8FkINMZ2lAhtiRvmRi4dCc0IqQGxffEfHkg1tSxTw5cTtV/Z+zQuH13xvWuffeXCkZ77IsL2SLbcvCQfxZPZSdt3fv1sa1UpjPQe12E6Jk4i29IiYaTG1oBZ5ASWf6r9fdMGLPkULFBF0yfKVlmdNJsX5cBa25s572NzE/RJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123408; c=relaxed/simple;
	bh=naA4RqzDfx1g/AEbG7TvoN6iOGRTBF6ERPg1ybfJwR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VzdsD2s2HY4B5T/vvHRL3G+HlWA9JluKn0ZmOvEK1FpBaeDumm8P48v1GYaHjo+ciCwm9yswlkr8a2r3NRxT9hKNqguqceG20nXBvnSm3TSEDZfteNQsHol5/Q4MbNqkdw/clowWMfhCjtc6Lcxv8Wj5vYyLexanw5jG31RNJNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DNNQqBqh; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b149efbed4eso394608066b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758123404; x=1758728204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uOdyIgVKQVbcfZmIBDqiw6XRB+lRYJ/AtJANCJAzYnU=;
        b=DNNQqBqhL+C0CfYd2ixEo6vJvA3SHfW0UqQGehmgTEiqhO7B7bh7w9CTU8ZzpOb9+a
         C5X4d0lugaWscQy68aFRU56d1tHaWwDszv459fzYCPJ9IA/nie9pK0yJxsN3ZIXlRhnY
         sYoS/kCz4Y6ybAgcFj9hGLfBKC0EW45CmOqkjxsOmyeVUn06gMmyGvZ+dXlN/xllq4Qr
         FOlxpcNgOiB+U5Bvt4uZ1Htz40WossGm4kwO84hnnoJE/mZ3V0yhb6Rskp9XNFG9X8fW
         hMYmLsdCfPpN2VWkuAkfebLcwTkTeJNN3EKoN2B4sZMQJYTGqzdpAkCe2UBzsU5z5BrB
         kZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123404; x=1758728204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOdyIgVKQVbcfZmIBDqiw6XRB+lRYJ/AtJANCJAzYnU=;
        b=NVSlmzcLRJaftnMOgLW7rOODH5/D5yS82wYNc+1cRWHbYecR4m+fY01GRcMrbjNvd+
         NmbqTrLWNbqbDvAJkxT/YgiPhAcs0ODlAFF3IcGcagSheeLeF6Qf5N60EGd6KyWMabak
         fcMMw9NCUTJMctmDj0eIhHd+pHhDI3CTo8CcryIfqfy7Jth/m0o+jLXC7s/+4tE3XhIJ
         oV9x/Q1SAUgI0VRcW26ReXs7B1U0Lr1d8ylqY8hgSKfNOOMVUjcqcw7Q3wiWB4R3f3yF
         goobleS7ZnkCQ4bgBoGCDIcMdiN3pJihJZebx66nqhQdhtvt7gvFRwYnl0mmwyoZNdRB
         b0LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhv8cLfy5YtiTFCVG/Y1r3Gs0xRUW/zOnSw5XGLkC8X2D+Y5O/WVi6+YX9ASHVXD54MhaXLDqeWxdIpt1X@vger.kernel.org
X-Gm-Message-State: AOJu0YyWbEtkdBk3i7CpAcNMSse0YNjaZA6xr57HXOfmP5eGid5565og
	2RR64u9OtLaw21hs3DDyf5sIxeqmAWJhPJunPoelZ5wL+qWRHjjR4gJS6BBvYlL3Lzs=
X-Gm-Gg: ASbGncubJZ2pT4qcusTNK7e/PSxXXsVt/NvRdcC6wVvHYLNVSVlxeqMuguziIlwuAEJ
	kjGBG+wEnBJnDoFeoAF5HWJYJFGJLE9JDDprssr9ykZQUJmFMvDLkTnvSRjcep6bRXqTkBCf9kc
	p1aZOhzlP2qUUM1lVQf/UWDfv87Pu32BjnydhJySO9hTV6gsJHOAeiuhS3f9FNYvzYLniy/IfUW
	Wksm1M6JxHkYHgLJ2HtyFyMUWx3ulj2g0YO2cUer9ffiEFcfC2bhNF6R2l4qDTGE5BQgLB/3yWk
	8cxOWsSIH6BA5YnwgZnd/gQsE7CVsagkpr7NlAF3tE4QCw7XqqkzgOrI3IurQL0A7AcOOtpPtGC
	FG9h0ic3y0feSXm3jVLlTdq7gTDwCgZYcMOZ6oTWxLewlnsUmPuR4mz1Xl0SkYB4eN7qOmrt6pe
	2EeAUluJ+Dl7sEuDMAgXQ3EPjt0KCHHHcPFA==
X-Google-Smtp-Source: AGHT+IGMRHdj1slwV4bLVyYkD0N4kZa7TBulRZA4XTeW2hkIidh5BryId4F+eQgbBdrZ5RTvgJ82Ng==
X-Received: by 2002:a17:907:3d86:b0:afe:fb5a:6428 with SMTP id a640c23a62f3a-b1bb559b7d7mr302200966b.22.1758123404446;
        Wed, 17 Sep 2025 08:36:44 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f055a00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f05:5a00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b19a4c2d3cfsm235212866b.26.2025.09.17.08.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:36:42 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: add might_sleep() annotation to iput() and more
Date: Wed, 17 Sep 2025 17:36:31 +0200
Message-ID: <20250917153632.2228828-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When iput() drops the reference counter to zero, it may sleep via
inode_wait_for_writeback().  This happens rarely because it's usually
the dcache which evicts inodes, but really iput() should only ever be
called in contexts where sleeping is allowed.  This annotation allows
finding buggy callers.

Additionally, this patch annotates a few low-level functions that can
call iput() conditionally.

Cc: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
For discussion of a loosely-related Ceph deadlock bug, see:
 https://lore.kernel.org/ceph-devel/CAKPOu+-xr+nQuzfjtQCgZCqPtec=8uQiz29H5+5AeFzTbp=1rw@mail.gmail.com/T/
 https://lore.kernel.org/ceph-devel/CAGudoHF0+JfqxB_fQxeo7Pbadjq7UA1JFH4QmfFS1hDHunNmtw@mail.gmail.com/T/
---
 fs/inode.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index fc2edb5a4dbe..ec9339024ac3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1279,6 +1279,8 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	struct hlist_head *head = inode_hashtable + hash(inode->i_sb, hashval);
 	struct inode *old;
 
+	might_sleep();
+
 again:
 	spin_lock(&inode_hash_lock);
 	old = find_inode(inode->i_sb, head, test, data, true);
@@ -1382,6 +1384,8 @@ struct inode *iget5_locked_rcu(struct super_block *sb, unsigned long hashval,
 	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
 	struct inode *inode, *new;
 
+	might_sleep();
+
 again:
 	inode = find_inode(sb, head, test, data, false);
 	if (inode) {
@@ -1422,6 +1426,9 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 {
 	struct hlist_head *head = inode_hashtable + hash(sb, ino);
 	struct inode *inode;
+
+	might_sleep();
+
 again:
 	inode = find_inode_fast(sb, head, ino, false);
 	if (inode) {
@@ -1605,6 +1612,9 @@ struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
 		int (*test)(struct inode *, void *), void *data)
 {
 	struct inode *inode;
+
+	might_sleep();
+
 again:
 	inode = ilookup5_nowait(sb, hashval, test, data);
 	if (inode) {
@@ -1630,6 +1640,9 @@ struct inode *ilookup(struct super_block *sb, unsigned long ino)
 {
 	struct hlist_head *head = inode_hashtable + hash(sb, ino);
 	struct inode *inode;
+
+	might_sleep();
+
 again:
 	inode = find_inode_fast(sb, head, ino, false);
 
@@ -1780,6 +1793,8 @@ int insert_inode_locked(struct inode *inode)
 	ino_t ino = inode->i_ino;
 	struct hlist_head *head = inode_hashtable + hash(sb, ino);
 
+	might_sleep();
+
 	while (1) {
 		struct inode *old = NULL;
 		spin_lock(&inode_hash_lock);
@@ -1826,6 +1841,8 @@ int insert_inode_locked4(struct inode *inode, unsigned long hashval,
 {
 	struct inode *old;
 
+	might_sleep();
+
 	inode->i_state |= I_CREATING;
 	old = inode_insert5(inode, hashval, test, NULL, data);
 
@@ -1908,6 +1925,7 @@ static void iput_final(struct inode *inode)
  */
 void iput(struct inode *inode)
 {
+	might_sleep();
 	if (unlikely(!inode))
 		return;
 
-- 
2.47.3


