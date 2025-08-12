Return-Path: <linux-fsdevel+bounces-57494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7025B222B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 11:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6DB17D879
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE7C2E92DC;
	Tue, 12 Aug 2025 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU3IFSEc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE3F2DF3F8;
	Tue, 12 Aug 2025 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990158; cv=none; b=Qu9APN2Fi4xfFgOw5FJdaWEFpAzC+9al09t1nsuROzjOINZxY6dWjEhlzci/R0PjmrKF/KSMLmkYls2u9RxnFf2w8vRneqS08Rg1DIPA8OUe/4dK2SI+FO6YB3JR1Cn22uphzItfogEeumRF08ggae3XbjYI4EGjlxh286qpivE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990158; c=relaxed/simple;
	bh=i+rdKmNLLqGvwTHxeA8bz7QFUciPCdRQTOlJcDYX+3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnyLBoy5+wG6kd1WTEIEU/s5cDdD1AxZFR5CVg6BEis42um0j/qd+HCs/VGx4uT95OA5naWV9efTcTJ6VqCwc7zV/2YdfeWzBiYvXPBhJw2W2Kkcuklx48nUat1o+NlQ7EIWpQMH4KAKsTXuVFPWk1eQS9q4aZWkfAEF9gF+Leg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZU3IFSEc; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76b36e6b9ddso4434493b3a.1;
        Tue, 12 Aug 2025 02:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754990157; x=1755594957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fM1B2JsbtQYQeIjPqUgcbjG7nDJGVMQTVHa4+Nz/+SE=;
        b=ZU3IFSEcKYNdKtdt1xQFOOfKNib8IGV+wKz7OHjwX/rmy2P8f1nsfG659X1Yvursl9
         AkfPp3Wxo4e5/1fB7s9VChlNKUYLNJJq2tcyMLOqfQ6lCW+E+drJG2UXco0ecPM6nAMY
         KKqB3iO4szHIB4NxyRLykKHvl3Ok/8VaB2Zdq+Ar/XtKObavUhtjF7a4++JSqtIRiDRT
         hKeS/x54nWTQxHDkh55qUf1LlZD/ESnR7ttZJ/PQCGoG2Xs3ARrrj9so9cdLqfkmc3ck
         TT0zaOo4dVrslkKPk1XD0BF1yd7jSVb6aLefWt1I47DGW5VTUj2t6SDaYuZRibzjmylW
         kOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990157; x=1755594957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fM1B2JsbtQYQeIjPqUgcbjG7nDJGVMQTVHa4+Nz/+SE=;
        b=vCjIK3jjLVuEsNv/F3IkUJqH8MCnC8OQ5F+IqoiT6iXSzE40itPjSMKOG6PoRHoUnn
         6klyfr5sCjUNNj2R1lqhhrp1Qep9hHT46yAQqRvtHZeFwmjYBBuMY6Dt6ItZQ6XVEYfm
         raSAuuKhJkE5v+6arBVih76q2JCj38+ts4WezYMJvjxIDtOwOppM0kf0pFpuf3g8xn4x
         Co84C9CG9XsSvmZVC9HhbY4g+tC28nq6GImEJVXc9uyaBsdEnJMeCVx5EvQhSOYs0iPm
         Iz9s7DFZFBlM9OFQO6r18ZpFETbwTJ3uSCc4PTZildemZ2gaYdFfsqcO/DUdtbjauLev
         +2gA==
X-Forwarded-Encrypted: i=1; AJvYcCV97OOOl95waeV+UpvfXRx6r34Etv+6LtRVR8GidmRx7UUeulljCcKOZjEeLsbWrucXb7U11CrdeWCoWwGg@vger.kernel.org, AJvYcCW+9gKD13mIRWSRSQ1HNwEIVpehP/6hXhvp5fPN7EMZg8rI7WSUavbE8WCJfEJRWPiywMpS/9q5xb+V3KDC@vger.kernel.org
X-Gm-Message-State: AOJu0YyluYN6nteu8OanSYLcMXMXpoujMMGSuNTRPchFJ1Kw0mbfg2V4
	5coKQlcem2zu+tPnat9UYp+ybchVgeWvjmc4ssguttLQk2PPJ/WWbW24
X-Gm-Gg: ASbGncuLzvXDuzK+pALdYCKosI8TzykaseKrsYFYLvKA8XOyU4BIi0u075dOYc2dOd7
	1Tl48yv/skH+w0xGHCh8V0W7yZbZCVUtCd5287WOI/pNbKFiWPIBVJuOO4vR3kAwS8prUGXEAyi
	Au2ZY6x35LDcUZmh8mWCeuFeerw+XLk6H2aVPGH9R/oRKSEwIpqTCdBKxaEHAzDW78RTFOOeb2S
	Ngwigy48hw0Lctz3mUGDnssoSBmQWtwLB0Lz+g48D/Mn1k5bx6KWsWiqBZr9e++kLzasznFYBCH
	MorYHY7MM39h48WSvoTyHeFztyTX60psAORgKicnqYcE/MP2g1UEyOI6F9J7eCkp6Ba8MflB/0X
	4KWdevpjuxIM/14n6EYGyAE/TjvxQHfErH18=
X-Google-Smtp-Source: AGHT+IE6NUwbN/7w4nwB3d9QPsqO258Ijpe4rqyfO7Yo6QszO2IAXWOBFHzbNXsUmvQYSZzC7Ix+Lg==
X-Received: by 2002:a17:902:c949:b0:23f:ed09:f7b with SMTP id d9443c01a7336-242fc365389mr40438495ad.48.1754990156646;
        Tue, 12 Aug 2025 02:15:56 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f1efe8sm291670665ad.69.2025.08.12.02.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:15:56 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v3 2/4] iomap: move iter revert case out of the unwritten branch
Date: Tue, 12 Aug 2025 17:15:36 +0800
Message-ID: <20250812091538.2004295-3-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812091538.2004295-1-alexjlzheng@tencent.com>
References: <20250812091538.2004295-1-alexjlzheng@tencent.com>
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
index 0c38333933c6..109c3bad6ccf 100644
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


