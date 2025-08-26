Return-Path: <linux-fsdevel+bounces-59252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4470B36E59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB845E6CD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A687321F53;
	Tue, 26 Aug 2025 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xhEuwrqL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119AA3568E1
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222881; cv=none; b=EM7V6xUkzA1sJ6hNYVjFpzH+8HKRWglbV0r1p1UY7JOjn1Skvi07doCdICT/54Hw/nJ4T1G47cmwka4oYKcprr0/IpYq1iN8H45bkGw6C1BQQgHBpUXWW292GWPs9lWVPw+jd6iPml5F2XhcVGoLj81OpImWfD65UixE9RtqcF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222881; c=relaxed/simple;
	bh=6dnduwz2qT/zsskC7epU9otttNGxq+N4PxJFoWXJBUw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPSCIbQKBC3lokNjP5mLqQ+/bX6b2tbrIe2lQpXHB9/erK7rJ1gqiCzsu+tFQhf0culZxsHS7eUmtY7uGVwKimXJe0xfoVOsP9X9sVbQRf1MLWCcDYubxRYA4O+zPjDwpEz2kQH+N3dRMU1JrUg/Pj9hkUSLEheQmX5kxBDpNxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xhEuwrqL; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e96e5a3b3b3so453136276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222878; x=1756827678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOjvmn46ZQoy8RoAMfUo3jX2UJkpyHzSOm/HJR2z+vw=;
        b=xhEuwrqLkcNIW0HGzHalnj46MA5cS47Ou4R7wQlDNWBfhipWLvRF2jPJBejbqbQ3Oz
         6GrT9LqjTnDJ/A5+jNuWkXj5j9A0rcg1NvR51yKNeytDpBi5MpthpbeU1AUWaiKZ49DP
         ITvGBFHTX13o7KjaYSJ+hBdYFrbs8RYfkbinHkLlIwFIzEypF1bnaqHXurmWXsRMNYlX
         npeFXFVF/tBbmTdlBss+FCDqJEEY1vFVA7OAECSP7YsVxINy916zF68pZ4Gj0C2ZpjC7
         6xPDtdsxytRiM6ex0ZUaU9vj8anwiGqG0NlT4oJHD73mKn7XnHCrXF/mMlsOF46CJGyN
         HsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222878; x=1756827678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOjvmn46ZQoy8RoAMfUo3jX2UJkpyHzSOm/HJR2z+vw=;
        b=kMuejDDOBJ549GfQT1g7PVQXtghoEXlTQIyTGuPjQWJ6cEx98p5ZGS6/QYDJfg4m8g
         A1aQtRIs5UzEjvzkTXiBYd30xXR2T2YNM9x6HW52eAKIJ7fKKoLCpmDC321JtU1L94u1
         +rR54g7yv4NclVGMGRcELhF92yATKE50/OUIQn3bvYykutU+CANrWPqLk9BRHlRwZr0k
         j+fmVAYaGAy3wmjFc2M1XSYAXglTAMwO5mEhmT2XZ1Qft2yogwBPrPPWZIx/UYznWLn9
         rPKG5wi1JBHWlGEbKsUnLAay8gT4duxc4F7lhptpK4CuQYLfkQnrWkkhwK77U8ozoAz6
         JXpg==
X-Gm-Message-State: AOJu0YyPmrajKzGzXMD6lSYZJP+XM5RKkZ3LOxm9DONhQwZy+g/93xbD
	dhXUNmKxwVrXCnGuTkTRhRC1POOymsnkQ8LxO2ED66TULgJ6fP0C1Qo6IM/3HybiPdA+PiW2oyj
	3dsYI
X-Gm-Gg: ASbGnctfUKMn5wzzrhqk+CUH5kcx2rYpI4vw5jjjPFc4fU5vf0IXj6P1QfNbEogzCkj
	eKg3PSWw6/eJQrWNCBvdPyGuIx39sS529n2Kxe26trqGPth6+uOGaQbcbRvzKurG3w6GzFjOPWS
	uQFT0NS3pbb5BnTzbfNqDJshUd1aXMIylRRhY/QM6MdfbUSA2MEAsBm2L09uoR9wJp6VGoBbS6M
	vogLkFh/OcqB1UfCljPrWR7PoHt7HxrG6MC4PH50QedujoT6Bg72qOhJTJ6ThxcD0PPH/YicQHD
	EAOqJqvqtxiZ0iA1vg7Tet5ziiP6Dfn6Pk0HyBQH8Kbxlhc6ZMGEfR2VirRynFU3YuAcOGwO0Kc
	2XXb2HDPR0p8R0n46jgdAdFGyAsdE/I0n8odvf7nyVkOL9QoJF5LzsB96s+0+cIgpcA4SCQ==
X-Google-Smtp-Source: AGHT+IFmbiTjt/bWW0MQRszMVOeUPuSn5IU4QnxuxDXuxPmyIrj4BMhw9mjI5WmiUj6YsTAUM8QvlQ==
X-Received: by 2002:a05:6902:4111:b0:e93:38c1:1fa4 with SMTP id 3f1490d57ef6-e951c2ca5b7mr16610661276.1.1756222877763;
        Tue, 26 Aug 2025 08:41:17 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e952c358904sm3307604276.24.2025.08.26.08.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:16 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 20/54] fs: disallow 0 reference count inodes
Date: Tue, 26 Aug 2025 11:39:20 -0400
Message-ID: <df5eb3f393bd0e7cbae103c204363f709c219678.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we take a full reference for inodes on the LRU, move the logic
to add the inode to the LRU to before we drop our last reference. This
allows us to ensure that if the inode has a reference count it can be
used, and we no longer hold onto inodes that have a 0 reference count.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 61 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9001f809add0..d1668f7fb73e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -598,7 +598,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 
 	if (inode->i_state & (I_FREEING | I_WILL_FREE))
 		return;
-	if (icount_read(inode))
+	if (icount_read(inode) != 1)
 		return;
 	if (inode->__i_nlink == 0)
 		return;
@@ -1950,28 +1950,11 @@ EXPORT_SYMBOL(generic_delete_inode);
  * in cache if fs is alive, sync and evict if fs is
  * shutting down.
  */
-static void iput_final(struct inode *inode, bool skip_lru)
+static void iput_final(struct inode *inode, bool drop)
 {
-	struct super_block *sb = inode->i_sb;
-	const struct super_operations *op = inode->i_sb->s_op;
 	unsigned long state;
-	int drop;
 
 	WARN_ON(inode->i_state & I_NEW);
-
-	if (op->drop_inode)
-		drop = op->drop_inode(inode);
-	else
-		drop = generic_drop_inode(inode);
-
-	if (!drop && !skip_lru &&
-	    !(inode->i_state & I_DONTCACHE) &&
-	    (sb->s_flags & SB_ACTIVE)) {
-		__inode_add_lru(inode, true);
-		spin_unlock(&inode->i_lock);
-		return;
-	}
-
 	WARN_ON(!list_empty(&inode->i_lru));
 
 	state = inode->i_state;
@@ -1993,8 +1976,37 @@ static void iput_final(struct inode *inode, bool skip_lru)
 	evict(inode);
 }
 
+static bool maybe_add_lru(struct inode *inode, bool skip_lru)
+{
+	const struct super_operations *op = inode->i_sb->s_op;
+	const struct super_block *sb = inode->i_sb;
+	bool drop = false;
+
+	if (op->drop_inode)
+		drop = op->drop_inode(inode);
+	else
+		drop = generic_drop_inode(inode);
+
+	if (drop)
+		return drop;
+
+	if (skip_lru)
+		return drop;
+
+	if (inode->i_state & I_DONTCACHE)
+		return drop;
+
+	if (!(sb->s_flags & SB_ACTIVE))
+		return drop;
+
+	__inode_add_lru(inode, true);
+	return drop;
+}
+
 static void __iput(struct inode *inode, bool skip_lru)
 {
+	bool drop;
+
 	if (!inode)
 		return;
 	BUG_ON(inode->i_state & I_CLEAR);
@@ -2010,9 +2022,18 @@ static void __iput(struct inode *inode, bool skip_lru)
 	}
 
 	spin_lock(&inode->i_lock);
+
+	/*
+	 * If we want to keep the inode around on an LRU we will grab a ref to
+	 * the inode when we add it to the LRU list, so we can safely drop the
+	 * callers reference after this. If we didn't add the inode to the LRU
+	 * then the refcount will still be 1 and we can do the final iput.
+	 */
+	drop = maybe_add_lru(inode, skip_lru);
+
 	if (atomic_dec_and_test(&inode->i_count)) {
 		/* iput_final() drops i_lock */
-		iput_final(inode, skip_lru);
+		iput_final(inode, drop);
 	} else {
 		spin_unlock(&inode->i_lock);
 	}
-- 
2.49.0


