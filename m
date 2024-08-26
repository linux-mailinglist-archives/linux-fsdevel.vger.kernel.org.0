Return-Path: <linux-fsdevel+bounces-27243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0292195FB8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 23:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E142B231AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5154119AA4E;
	Mon, 26 Aug 2024 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNyWsufv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4415A1991C6
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707206; cv=none; b=eiumwduBiJ9FL0Z57BTcHWj/dK8ptKs7V0j85n7ssxxWXOliKNiHPsyhFswWRG4HacgJ+Bwz874FEQTaP7PNvuKvy9nq1Bz92sM+Sr0ZB1RV8/OEmX0p/SyssXcKa/yewuB/pFMhiIXzp0eQvuR4LS4D4afeoEROQinRkWPgqzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707206; c=relaxed/simple;
	bh=UWKsRqn8KEexlFybvj1D8QiH7e2TeVsMe7AUmeAODaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Db746ilimZiynqEv7HDa4sty9tj1mHMuS9gbAIiuH8iy7gCAHDFItoWHj9JqQDwQeYhyvv+UWwsbJRoUkk/UD2+d1sLpcsLVef5vqDFRo94S+OgQ8RPEAICdw0474Qz6HXKnGDSVhXSi8tLurp0UMwQ4Sp3mkNBIJ7tVAj8YdTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNyWsufv; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e03caab48a2so3693703276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724707204; x=1725312004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOZ2xVfOWbanp17fZvu+t8asvkce+rrQYJ7+TXN5jw8=;
        b=jNyWsufvqEDUFQwKN+rU7SE/b0fGP96nmxVQ7NsxHUi0gXUknmc6hvioyHNVRBAGb0
         Y1f75Ydk+JZnJ1M8eAYKM7uurqY3ty5lLKGWqQXcrMssBK0pxII+Tin6x5zuquCPwQCH
         iThfNg4bbNiogLbBXglnikYGU7opwVVjdRJQQfiMWU9afBafE7zZtS0WhQr7kZupOnAc
         2150BdhHUjkiRuMPg8fxIcNzGPkm7ee9o4/CpB1z0/J444ick/VSDULpCnVIu0LadfMe
         WBTgfAAwYyu4Ad/Dmul4E1uLor9Bxu6b6ioe+QHKAID7JlhZXlXDHvEsbheun1StHfEl
         iPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724707204; x=1725312004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOZ2xVfOWbanp17fZvu+t8asvkce+rrQYJ7+TXN5jw8=;
        b=vF/20Ge99JW4ATOStCJGqJsaWSBLAL+AdDUtrNBqyJkZTQH9oXWgQ9M+Xk9EjVH8QS
         6jn+slWmDjFvkh7HIt0hlZGuHut4DxbyGEja6OhTnaQoWVUvMC8z2GQGRWP5S7gOncoO
         TInxCLR0iwhTCKqEQDpIjGI/VZ3e9XXNQxcTEbdoLHtTWPURgkj6a90kk4C9vEOhN29S
         3X0JNqCpndfULBnZQTqFmEcnVIQz4AIQ2XPbvhQ3sv6Q8bpEl9lPtlIV1SYmerM0Vj+k
         m7wJMFmjLFcISNZjpAcsdY3hDZW8cu3yKAz9tXcEQf1aQUXJfSwus22HCtE+lWVXgAtl
         rpoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZyACgBoEajjCQZd+lkdXo+PrncIO6BVvvNs2JYCQf7GRk0id0MImTvtXdacrjhNgkerl3hVun+7sTL5zk@vger.kernel.org
X-Gm-Message-State: AOJu0Yybz0E8HPff9yxyjgBDpRXuHWWt+cVrjBjrW3SHYy7erhavMsx1
	dpwC+bw+1MYFCqBq5eTsSBqE7JUDEYTrXdciRl6U1D9geCDW/yKe
X-Google-Smtp-Source: AGHT+IHuj2sp6wA6WmhnqpJHbsz4oVFoWHVSsn2F1zVor1aCpmP+bEgCwOFfvRZh5Q4Enwhyq7nYmg==
X-Received: by 2002:a05:6902:1689:b0:e05:f632:3ef3 with SMTP id 3f1490d57ef6-e1a2987e615mr917882276.23.1724707204190;
        Mon, 26 Aug 2024 14:20:04 -0700 (PDT)
Received: from localhost (fwdproxy-nha-115.fbsv.net. [2a03:2880:25ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e43fc98sm2232320276.11.2024.08.26.14.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 14:20:03 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 2/7] fuse: refactor finished writeback stats updates into helper function
Date: Mon, 26 Aug 2024 14:19:03 -0700
Message-ID: <20240826211908.75190-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240826211908.75190-1-joannelkoong@gmail.com>
References: <20240826211908.75190-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the logic for updating the bdi and page stats for a finished
writeback into a separate helper function, where it can be called from
both fuse_writepage_finish() and fuse_writepage_add() (in the case
where there is already an auxiliary write request for the page).

No functional changes added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Suggested by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/file.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 63fd5fc6872e..320fa26b23e8 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1769,19 +1769,25 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 	kfree(wpa);
 }
 
+static void fuse_writepage_finish_stat(struct inode *inode, struct page *page)
+{
+	struct backing_dev_info *bdi = inode_to_bdi(inode);
+
+	dec_wb_stat(&bdi->wb, WB_WRITEBACK);
+	dec_node_page_state(page, NR_WRITEBACK_TEMP);
+	wb_writeout_inc(&bdi->wb);
+}
+
 static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 {
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 	struct inode *inode = wpa->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	struct backing_dev_info *bdi = inode_to_bdi(inode);
 	int i;
 
-	for (i = 0; i < ap->num_pages; i++) {
-		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
-		dec_node_page_state(ap->pages[i], NR_WRITEBACK_TEMP);
-		wb_writeout_inc(&bdi->wb);
-	}
+	for (i = 0; i < ap->num_pages; i++)
+		fuse_writepage_finish_stat(inode, ap->pages[i]);
+
 	wake_up(&fi->page_waitq);
 }
 
@@ -2203,11 +2209,7 @@ static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
 	spin_unlock(&fi->lock);
 
 	if (tmp) {
-		struct backing_dev_info *bdi = inode_to_bdi(new_wpa->inode);
-
-		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
-		dec_node_page_state(new_ap->pages[0], NR_WRITEBACK_TEMP);
-		wb_writeout_inc(&bdi->wb);
+		fuse_writepage_finish_stat(new_wpa->inode, new_ap->pages[0]);
 		fuse_writepage_free(new_wpa);
 	}
 
-- 
2.43.5


