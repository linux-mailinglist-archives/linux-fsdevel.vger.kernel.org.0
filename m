Return-Path: <linux-fsdevel+bounces-58655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41812B3066E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BA7600A61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B6B38CF98;
	Thu, 21 Aug 2025 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="fLhSWod+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13AF38C5F6
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807645; cv=none; b=K8Gc0TXdWOWtRz5il6TaUtkSwIwcN3xhkZxT6UmAt7H05XtZW5rijrV+FqAa8F/7DaO4aH4PX6iY2uIkHUfpQu8ADZvTwr0RfYdy4iP+G30qfYjC9zAp8l6jzGQqSHgK6KCGHYO7SHNcoMIiTrSkZwc44LEijZeN6NBRGiH5N9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807645; c=relaxed/simple;
	bh=Kg4HyI9QpVcllETBw5mmbw49cjWo/i+7w3jN/b+fpXI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urx6TGNCNMJef+wmf19a73o8wWTdVmCwzMlY0cRoO1BJEGhsHm8BKCtMRj2/RRA0hgP4koK97JR62b7JFUtoDUQRK4OWcBKBG9rZd0hYcucewzFgXBobsKUN6sR2qg3U3/spTdx1n7ac2LnsiXw5/9TIrdZW50DdolC1AOf/zoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=fLhSWod+; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d60528734so12406327b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807642; x=1756412442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6vlOFADLX5mw52k/m7fuDkR4/0v4QldE+cL7IA9Qp0=;
        b=fLhSWod+pQMoyGzM3hk9LBm4L4ngCrAN9KmjeLb00BIqvIqbedRyP1Nt2qCIbl3RzQ
         DJd2/8Ij92Ppe46a6hMYU8d2OLkRRVDfN5Y0rsNfadrltY1MPVP/ruxdohH5IqjKDndA
         +eg2lx1VJK/LEToVAFUMEe/0p1WqUb1Z54TaNJkarRNcvE3bGPuQRaV12wI6rlecTBMh
         TEzBaqiQJBFxR7q2BCj41/uDz2z02RkS2V2zRAESnnnoUSO6gv4SAOrkvLt5r7R4qJQl
         bGDGhQhNJgLtYiNrsxgR4/k94JMZo+hGzQjRt+Dy20p0WSZocjHOq+B8DUjKSSEUblhn
         Mi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807642; x=1756412442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6vlOFADLX5mw52k/m7fuDkR4/0v4QldE+cL7IA9Qp0=;
        b=VhBR1Tkkr3WtUQpUnFDj2wWgW1XmzCJh7Ka/fotXq6XLIS4i5OCK6fzqpn4G96jPnq
         9zgn9hBsHBcN9NdlrUUSruTMLTSCaZcNDE/3/NrAIdQq6FyRPklEfijxMMbAQtMKRMl/
         o+QSFPJqgC5xD3x2y29E6+/InMiasGbczpRVH7H3cS6EpnOuF9l+4n7HTl2vn203yRRd
         gpXfkMlCDvJuFQYvbBxM9k9XqxcKUK0T71tMyCytZ+XeabaO/gfXvIy7K48fW4alEZgl
         PC4JhYRpT9XrVOx9jvx2Z/0pGJdPRMWCAxRHCo6rKxoTryyoyvdMLznBNpBLqf0fIccv
         VgGw==
X-Gm-Message-State: AOJu0YySbWyU3nq4gnjVgxtKqPpQkE1Ca/wt8v4iOC9NzQJRsv2NuGwb
	Pq7rbcSzNbv7na108DVBfn/jtxM3ruLPbBkWhdhUIlFv+OdWK0Rdk4o0za/2scJZXkoWYbi88Nh
	QVIRREh4+kQ==
X-Gm-Gg: ASbGncvVvtGdpv+ZMSNOEAQKusmA6CAdH3yy2br6obmwD8zSqNuHvajYzhLLzroqpJK
	GkzdV55s2Ui+guO9gMyppaD86pSYmsrSCkPIE6SGnaf5yQfjV/7g3a0sBvv1Y++9TfgMNanc1Zk
	xf964OA251oaMzlFdE4oK0qxp8fueYHug8lLhD8ZfmjAaGtdjWW73zJ7mCt0StuN3XlKvqm9pZ8
	xtF/t/kkjD5ITGiFibSgFF57Qu5eP0K+w/jlO0h8Nb9tn8RWhJnyUEmIAMhgn8sbDboYk5YfcJd
	WS/hw/n5CPlqZQ+s/KNZXMnhfqAudG9Y2Q3d+4S/IrJqvhWZLUdDmYXUIKCjQrpznoBL6G5JaQ5
	azx2oBeqjBpEenAfLiW3Uhp/jwb9sT7AKwvQdCpLYzBL26Au3Wh11j47hGAc=
X-Google-Smtp-Source: AGHT+IEaCpm4qmdeQmTjz+kVkgMRNomqyiidl3fTCdzZLNucs5oGAQlKaflKfo8a3BN1zA6M3Ppw9A==
X-Received: by 2002:a05:690c:688c:b0:71a:323a:b297 with SMTP id 00721157ae682-71fdc2f10e1mr5550167b3.7.1755807642271;
        Thu, 21 Aug 2025 13:20:42 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5f52b9fdedbsm53508d50.5.2025.08.21.13.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:41 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 18/50] fs: disallow 0 reference count inodes
Date: Thu, 21 Aug 2025 16:18:29 -0400
Message-ID: <6f4fb1baddecbdab4231c6094bbb05a98bbb7365.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
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
 fs/inode.c | 53 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index de0ec791f9a3..b4145ddbaf8e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -614,7 +614,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 
 	if (inode->i_state & (I_FREEING | I_WILL_FREE))
 		return;
-	if (atomic_read(&inode->i_count))
+	if (atomic_read(&inode->i_count) != 1)
 		return;
 	if (inode->__i_nlink == 0)
 		return;
@@ -1966,28 +1966,11 @@ EXPORT_SYMBOL(generic_delete_inode);
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
@@ -2009,8 +1992,29 @@ static void iput_final(struct inode *inode, bool skip_lru)
 	evict(inode);
 }
 
+static bool maybe_add_lru(struct inode *inode, bool skip_lru)
+{
+	const struct super_operations *op = inode->i_sb->s_op;
+	struct super_block *sb = inode->i_sb;
+	bool drop = false;
+
+	if (op->drop_inode)
+		drop = op->drop_inode(inode);
+	else
+		drop = generic_drop_inode(inode);
+
+	if (!drop && !skip_lru &&
+	    !(inode->i_state & I_DONTCACHE) &&
+	    (sb->s_flags & SB_ACTIVE))
+		__inode_add_lru(inode, true);
+
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
@@ -2026,8 +2030,17 @@ static void __iput(struct inode *inode, bool skip_lru)
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
 	if (atomic_dec_and_test(&inode->i_count))
-		iput_final(inode, skip_lru);
+		iput_final(inode, drop);
 	else
 		spin_unlock(&inode->i_lock);
 
-- 
2.49.0


