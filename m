Return-Path: <linux-fsdevel+bounces-62476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D545CB94395
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 06:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC182E26F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 04:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D7A27F736;
	Tue, 23 Sep 2025 04:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dthun77Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B02027B32D
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 04:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601328; cv=none; b=tlp6c4I3n95wWf20yhN2bMQ3Tf1C4Ep3Qxubmt2tIpOGE0QdIKAqLPZZlYRYALQyxcecgdiAdbQH7+IEQGPeYbXFA7KNEAwvkBn8IP3raUv0eG6Ue62okwSg4cZHyx2UO8KL9NBTI0wZb/eMVoKmED8UmuLAhdP8oItcQpSXQEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601328; c=relaxed/simple;
	bh=dah8ZhgBCCglBmK2Z+eAcnLpuYOrh31bu+S3be/sAjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUVsyKoIKkdZM9qfMuNHwrMHm9OyHn3dbB6ErutDxOCQfCitnbwGws0fvB9buVyp0I82xrzjdnhPPWO18BnkxXR1ub4vt67GFfO4OFBouYGdVtW5xO7KWVLD52bX3QMHXI3b9gagnDWbcwA4ZfgRYmafbeA8YYbxkERsaEWGwNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dthun77Q; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77d94c6562fso5134502b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 21:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758601327; x=1759206127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/cHPlIzPABEuPSPErkXxAEb1eyYlTFw7Bjb++zcmu4=;
        b=Dthun77QjAYBxbl7NhtATWcR2H8zHpjyWXjQibe0AzQnD+rSBfC+Z+fHczVXfWM1Dc
         9npSnr5b5cbDUA/h7UNUQPRaMrYf6FigI0C9sRGwszLyBtnuDYhJ7/k82HvpDmmZhqzx
         mVo3fzgR1HsTwnswcBZVl/h7MBvbIL6EGU3ir3AqxIoyte7Nq7jWN8ZwS5eD7XVdPxO8
         K9CVImy1MJpsDrwU4CnBteC3H0kkh2K6oxoFwpMw2Vu2i+tC5927K+WXw9TPBxzaIDFI
         NJUIrqRVQoKseQuszuyI6KeguRZj2SJjDYg4Z/LtI4MMcGETda8vJu7Huh5TNvA/i/jN
         4q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601327; x=1759206127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/cHPlIzPABEuPSPErkXxAEb1eyYlTFw7Bjb++zcmu4=;
        b=DUoe6qYoc4cIBXNhLClYi9hrgeA9vdOZd0qp00NnLt2/SV2qu9Qs6m51Av/Em45AY5
         WvcB0174HeuINyht+G3689n6ssm/JrkSRBRosZ5gxCMaYZjTJH8cxpyphph8GYeTk8Pl
         6fIgjjbqW/XWUE5VlLMNSUzjaHrP6wsRbIJZ4yrZY+RXSD0zX0g+S3atdOjA+Y4UcOUS
         C29z+N/hy85KfKE43MnBsEIC6laATd2Z7GKHZwj9rbfPE9lkiSsQVvjN5uJHMa/IylNr
         4OyqgQVZZnoqhw3rsb/BcYvFyrCls7kr2JGqkKQp4BnbtRYWKsgUmjYZRYio8e9eea89
         +SLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8wlBlKXx7tyUEphn1Yx+BrqhFNrU8bs3Oxa/Ok7xrCXvQQ2/GBd1ybl/CKotmhHjOuKgboMsZzATABxrY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Rjji6xwqv57MC4GWC/L/Tpbo4U6FKjSiuH1HFc5hmncFWoG0
	mVk8ms1cUuvPNsotpdzONs/9A3MNiebbSstj9WQ6mwQGYTZPGuGC9+Bh
X-Gm-Gg: ASbGncsnyhwssl4eubRpPiYBOOLgCh++kgFLK6ifBZ92XPioH2nKgM3bEbKj9l4EzcJ
	tAZYcFlmzrNQxxvqrjqzNo+gph4P5oLgAZ/dXYV/zaNmEwjNZP1sp0fivrjaFCZIa5df4upbR2K
	FBcM90tTY3QdWJk68mgEKnMMBLPb/itX8xZPR+Dyp9z7aikOmx7HXk18Uat9eJoklIUZQYja4Tb
	icJA3br/8qyC+uLlb3j68A77L/S01p0neyN0SRzSOuZ50IWPNQ32q5TACnT4y8/XCgVn4Xj0eXK
	miLGE+iS8tWvbl/V+iekc4YmdAaC7ww7PMDwTQH+4mJJnZsBR71GfxwbsdLkLcY3JVWA7/FgSE9
	WGBE3BDOoei3Xcp+HnPeSeEIZDkl5YCFR/Q==
X-Google-Smtp-Source: AGHT+IHZAQls+5hMZhGCN0G3+29ESb1NDuuB+LUQQRQtRCIeNRAgRN5oig1MawJfpWsB1afMgMFY0g==
X-Received: by 2002:a05:6a00:893:b0:77f:1d7a:b97f with SMTP id d2e1a72fcca58-77f53ad04c6mr1449286b3a.28.1758601326763;
        Mon, 22 Sep 2025 21:22:06 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77d8c3adfd4sm13316513b3a.82.2025.09.22.21.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 21:22:06 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	kernel@pankajraghav.com
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v5 2/4] iomap: move iter revert case out of the unwritten branch
Date: Tue, 23 Sep 2025 12:21:56 +0800
Message-ID: <20250923042158.1196568-3-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250923042158.1196568-1-alexjlzheng@tencent.com>
References: <20250923042158.1196568-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

The commit e1f453d4336d ("iomap: do some small logical cleanup in
buffered write") merged iomap_write_failed() and iov_iter_revert()
into the branch with written == 0. Because, at the time,
iomap_write_end() could never return a partial write length.

In the subsequent patch, iomap_write_end() will be modified to allow
to return block-aligned partial write length (partial write length
here is relative to the folio-sized write), which violated the above
patch's assumption.

This patch moves it back out to prepare for the subsequent patches.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ee1b2cd8a4b4..e130db3b761e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1019,6 +1019,11 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 
 		if (old_size < pos)
 			pagecache_isize_extended(iter->inode, old_size, pos);
+		if (written < bytes)
+			iomap_write_failed(iter->inode, pos + written,
+					   bytes - written);
+		if (unlikely(copied != written))
+			iov_iter_revert(i, copied - written);
 
 		cond_resched();
 		if (unlikely(written == 0)) {
@@ -1028,9 +1033,6 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 			 * halfway through, might be a race with munmap,
 			 * might be severe memory pressure.
 			 */
-			iomap_write_failed(iter->inode, pos, bytes);
-			iov_iter_revert(i, copied);
-
 			if (chunk > PAGE_SIZE)
 				chunk /= 2;
 			if (copied) {
-- 
2.49.0


