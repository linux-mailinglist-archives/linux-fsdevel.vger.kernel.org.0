Return-Path: <linux-fsdevel+bounces-59282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E034B36ECC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62C81B284D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6026E374266;
	Tue, 26 Aug 2025 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XpDFxbyd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1237289D
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222922; cv=none; b=I2ypIdm48FwCk+Sr2y/8/bsrVNVFUdSVSmMlbiFC5biLSy3cojJGRLoiXS+tPD8VZ4bcEwAta2iCqq8aSzQUljIpjta9qAEBYkVitQniXqR3NvytDAdGBnMxmGWCyMQsPLLgQSYiu/n+RBgtluqq/8+vq+xnF9wcvNi3lbwlBpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222922; c=relaxed/simple;
	bh=x/P8Cjn6xKiJXGrsigp8xgvpHvnh9KytdZNfO6zYuv0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+8U0lyQYEUvdI9VmQF/yA2ILQwqhEsRKb12ICn69zEwfcGZxz55qCXCSdn68cuP7b2138L3v+iMHU97dLRGkn/nrYMgF/RGL6+jQaTy4Ps29h71GM/EHrYIILoa1jKXJpEhVPOzj2bDPjKMQl7iRJT2FdP2tsMZaCDV+z57qgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XpDFxbyd; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e9530e59512so2690644276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222919; x=1756827719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/81j1YCnOxnHbfolqn0xMe1+eHodvsQacYEmtt2fzCc=;
        b=XpDFxbydrlhfwIQZOvJptQv2w8AH3/msxiKTOjc1/O/lOLxZnUAIPigzuikFjpSNua
         V9Hkg1XTyRcrazMvJAIdiWt2QT3LKu/45WdvMzmjnAALqin58+au/2YKZe66JUK+JVOS
         nVRy5oLUtxl4SUknXsK7SXozPKHISUBw67zthjZj/IVKv+ZO+WdN6oF02oAo9z4VMkaY
         wGA/MjD0Iflq6RMnl+enAzzbJd3oWf01bAShtK3Qudrs3VSMLwTT6YiqtSBcvMg2NXm1
         BTQEgiE9LnR+ZSlH4lh4Joy017AXkYjWKeMmki7V3wh6T3Tuw593bhtHKzpu089d6t7j
         BDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222919; x=1756827719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/81j1YCnOxnHbfolqn0xMe1+eHodvsQacYEmtt2fzCc=;
        b=Y9T71wm8qze9jGCjICsxDnhi1IcAYx32utbHRofnUVhHDUU1ZxBy4J6M5Zswdv1f9d
         drUHF+bW/ZlGrEleBhDxF0m8qnHOfQYNKfkOsABmJHdicne1CAKBJd4DrhxAikhfLdWq
         0bIl0LneRLl5OU3o87E3kqYEEF24yPYU5b1h1EDYd/s8R6PYer1u54OmFr/+X9B6atWL
         IWMPCOVc4m929yexkkR8Hp8WT6MWPu23aZfpoHw2KeGqFkjluhJnZvce0j1+PL+WvJdT
         T1bh7ScQ5KYg2AcVyek8cjOgfuXjA3PCqaeClmAnJ3XA4ZxsMmJbia4edQPS1+0J5edx
         71jA==
X-Gm-Message-State: AOJu0YxP8QuSy8SZGNuszs8ZIlmYSsoJ9FZWwU/Va+qS61h+QykuDhiU
	NWHhISshvDmuv0NIOwfwDXM0taZIXUkEkXIIiIhTs0j3OS1PoWbGGPy4rJi9IUzoQA+cQmpcNJo
	lOVe+
X-Gm-Gg: ASbGncuJ1owShGMwYs7WM5C6sgnTNlveCX46AJ1yzwj1m+mNK1z+hTchRdI26XmljOO
	uxzCu6iEXJlNP1FE6P6/NKaKGotAGx4//sxl8G8XlLX/9oE/oeuRjmZsQthawAK1R5o0ppQAaqa
	mDTUYPERroYP3NsqFq/eiwzrwRTOnTZRZOtaZ8UxZhXxiINpBp6STPAOUYt+0n9v+deer3Bpsgy
	a+oI2OdsnMwHReC+DEefaIKx0V0yf9yZqF9Wnhxgrb/CxqzlWpLz+/d1CtYnrGzyyuRRC+Hhj94
	EqCV9BLB17sb2QW7EocsnD+vRwMIoiijkwZxTcEaq88EZUmrV/IUwvZtYTaXKP2ibK/+2GvJWKj
	HWlCfYknQj6FZDwAASsSyMWmzRXX0QT7u/iYjnL4VdrC9ZY0Ol+S3C+TJ8+cEPICsKRmYow==
X-Google-Smtp-Source: AGHT+IEx9ifdcnJ6mvofN7F5PBW8h5lKAWe/5eS/sDxKyvd2J9YLXqDlzGvcoCWaDdRAub5TwP+68Q==
X-Received: by 2002:a05:6902:20ca:b0:e95:1ce2:5c77 with SMTP id 3f1490d57ef6-e951ce25df7mr19070918276.47.1756222919410;
        Tue, 26 Aug 2025 08:41:59 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96dbdb8453sm850596276.20.2025.08.26.08.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:58 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 48/54] fs: remove some spurious I_FREEING references in inode.c
Date: Tue, 26 Aug 2025 11:39:48 -0400
Message-ID: <da562975b6a07b1cc8341a6374ca82cd453d986c.1756222465.git.josef@toxicpanda.com>
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

Now that we have the i_count reference count rules set so that we only
go into these evict paths with a 0 count, update the sanity checks to
check that instead of I_FREEING.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index eb74f7b5e967..da38c9fbb9a7 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -858,7 +858,7 @@ void clear_inode(struct inode *inode)
 	 */
 	xa_unlock_irq(&inode->i_data.i_pages);
 	BUG_ON(!list_empty(&inode->i_data.i_private_list));
-	BUG_ON(!(inode->i_state & I_FREEING));
+	BUG_ON(icount_read(inode) != 0);
 	BUG_ON(inode->i_state & I_CLEAR);
 	BUG_ON(!list_empty(&inode->i_wb_list));
 	/* don't need i_lock here, no concurrent mods to i_state */
@@ -871,19 +871,19 @@ EXPORT_SYMBOL(clear_inode);
  * to. We remove any pages still attached to the inode and wait for any IO that
  * is still in progress before finally destroying the inode.
  *
- * An inode must already be marked I_FREEING so that we avoid the inode being
+ * An inode must already have an i_count of 0 so that we avoid the inode being
  * moved back onto lists if we race with other code that manipulates the lists
  * (e.g. writeback_single_inode). The caller is responsible for setting this.
  *
  * An inode must already be removed from the LRU list before being evicted from
- * the cache. This should occur atomically with setting the I_FREEING state
- * flag, so no inodes here should ever be on the LRU when being evicted.
+ * the cache. This should always be the case as the LRU list holds an i_count
+ * reference on the inode, and we only evict inodes with an i_count of 0.
  */
 static void evict(struct inode *inode)
 {
 	const struct super_operations *op = inode->i_sb->s_op;
 
-	BUG_ON(!(inode->i_state & I_FREEING));
+	BUG_ON(icount_read(inode) != 0);
 	BUG_ON(!list_empty(&inode->i_lru));
 
 	if (!list_empty(&inode->i_io_list))
@@ -897,8 +897,8 @@ static void evict(struct inode *inode)
 	/*
 	 * Wait for flusher thread to be done with the inode so that filesystem
 	 * does not start destroying it while writeback is still running. Since
-	 * the inode has I_FREEING set, flusher thread won't start new work on
-	 * the inode.  We just have to wait for running writeback to finish.
+	 * the inode has a 0 i_count, flusher thread won't start new work on the
+	 * inode.  We just have to wait for running writeback to finish.
 	 */
 	inode_wait_for_writeback(inode);
 	spin_unlock(&inode->i_lock);
-- 
2.49.0


