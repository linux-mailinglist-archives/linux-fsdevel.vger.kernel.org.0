Return-Path: <linux-fsdevel+bounces-57196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D15B1F85E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 06:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1393BE6C6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 04:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C7B1EDA0F;
	Sun, 10 Aug 2025 04:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTbd7z+i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9311A1E835B;
	Sun, 10 Aug 2025 04:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754801299; cv=none; b=CzdAYcenqfbx+cRQqTTj8YNPvaFr7rx9NOeIp0wQ5FFtgsjMSa6+18/tuLsW1VZT602htgmsbXXA9OhiBm9FOp4zUNm8X9QDMW9vvqGpuF8eMsEzsXMu2lt53q8G9uc3pUZr7mRerC7Os2mJSEVryc20HjnkQqPCPcYUmcpOcSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754801299; c=relaxed/simple;
	bh=+COAkwCs1KD7GqOfft6DRF+hbnsITzRJaq1MWI/QGIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4UQF7b8PZUJrlofHftBtg+RBevcvoGRi6rhZ8XLB3CGGZF0AezlIPrRugm0bzXWvf8XOTSYQ8AG0z+x7E7H6pc7QcsQgIkbRmelzi93ptSqdiVEs2NZ4yWt+VqLzYOTouKhTq4V/woYAn0fTbjgPXA/afGQyrGcPoLF8sVO738=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTbd7z+i; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b46d905cb67so82689a12.1;
        Sat, 09 Aug 2025 21:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754801296; x=1755406096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NU5gUJ4PcGEpBiDai+Q9Xvwy3qursE+cF81RNZO19U=;
        b=UTbd7z+ib4KlphyJXGyWG6ind+uUpeYRivATBLyhBa91OCFlclbnhypF6WBQO0k+dB
         qQqokl4hn/V5gvCaUNQSASzfkWN0S3iarR7agtznWTFMVbsbpcA2xxkeQVizj+Ka06qq
         EK7Aa+r7L1s7Zk9YxVNfD3FvSxdbx/kmLwtl6czyc8r/7jzdsZDttdg5Rh8nem+2HaZq
         N62PnV6xEK1Ppa9uVQX5WOr+9Iakw1n3qxUeGh6+HSg2/rj/48Q+oYFFbJbkDfANYtmn
         T9J86Uv95O3yJ89u1GG+5Ibql+6l7v2f/EzYRtV6nfiJaLPbZckOkxgM4MN6TbgDiGQP
         npbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754801296; x=1755406096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NU5gUJ4PcGEpBiDai+Q9Xvwy3qursE+cF81RNZO19U=;
        b=jst4u8TAd/AzRpkc0fDZJYtQRC1qV2x+nFF9QaeXr27FAreTi5SEOrc+1iMXx3e7xI
         cMck7D1CCl3Q/3me/szm3FjdqdSDcSt3x6/q5qMgwCxMBe02SHuawuDzQW0fZIDbvkYS
         lMZRSmdJlQHqQPn1jHshpRG8+mfRd2iN+QNSunEqWe5QKIb4ppE1COk7jZCmRAZ3v3v7
         0iAwhhDMExshKhX4uxLvzoqUgGqByFqDoSbav0K2Ic3wTL9fPGo8JHwCgSzMqpAtGP+b
         E688JT7vgrmmt/kbteh07ADeq17ILIk+uWgME9xVILLg6XlY/3upd53m4W1Sr7OVHvQw
         HpAg==
X-Forwarded-Encrypted: i=1; AJvYcCUKfOCt6vDx4WZaN1WZgXA5yn8Rbs2Kz53f0gsvlJ+hNH2fyZCm7nDIzwbmwB5S0fJCWO3vO1OljV9dYWL9@vger.kernel.org, AJvYcCVPHl3jXQNJOBdvLdZHSr19oa7qerDoR4QM5AoI8opc7+cD/gSYbogF2SNt3YLG/eOXuV+xCm2u4Ugk1lNP@vger.kernel.org
X-Gm-Message-State: AOJu0YxOzPkHrrcmSgD+/xF+DhBfLIQcYZWA2CgHaMvpi6seTh8K7/Rx
	hDmdAhap5hYlLfhXvGemx41NEbUUJ3cNxji/7356q8+xqjVu0TybxX2074K3Rkva
X-Gm-Gg: ASbGncuImvok8Jes+GYWVxsMw3D7YtXVkGTKRaQuKcwsqki82Ljx15a0dDoHapHiPUu
	7CYU+M2HF6uJIOHuZ2/uQuBmyBnxx2Oaxvjqb/G7q1Ozzc1sEBXw8uiQSEb1JU8q4dfDhGykmNy
	t41hFYXkNfVejgCaUQH0hkGX/zXS2q2aAyj6R5tvsruuwBQPtwZ79XfjGBX8nfBci8ttiOoA7u0
	CAjOyU2N7K13UHZOqUpjVrO72vOkHq9/rLmvazTNcrn0c1Qavepqy51X8BDtvyJc/Z31pfjYWu9
	WqaRMVVEy57k+bRhuTaTOklHvNNZmVFReUrDeX+WKGgIzC32SqcQyzjtUDP0Nvp0plvy6ChyhLh
	AWOf3akRQFefJ7j09uFQ9hp9EtYk6WsWby40=
X-Google-Smtp-Source: AGHT+IHI0VUAtzBvKJyOeyURiyoBDIlWI9Z4gbYjKrA1BpB8h+EhK7nk0xn063LCq3b6ObcoIfhtLQ==
X-Received: by 2002:a17:902:db0b:b0:240:5c75:4d48 with SMTP id d9443c01a7336-242c2e30a30mr133570725ad.25.1754801295536;
        Sat, 09 Aug 2025 21:48:15 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976f53sm244113645ad.113.2025.08.09.21.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 21:48:15 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 2/4] iomap: move iter revert case out of the unwritten branch
Date: Sun, 10 Aug 2025 12:48:04 +0800
Message-ID: <20250810044806.3433783-3-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250810044806.3433783-1-alexjlzheng@tencent.com>
References: <20250810044806.3433783-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

This reverts commit e1f453d4336d ("iomap: do some small logical
cleanup in buffered write"), for preparetion for the next patches
which allow iomap_write_end() return a partial write length.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 27fa93ca8675..df801220f4b3 100644
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


