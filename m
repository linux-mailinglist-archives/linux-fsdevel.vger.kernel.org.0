Return-Path: <linux-fsdevel+bounces-57226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC86B1F996
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 12:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA887AD075
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742A5252287;
	Sun, 10 Aug 2025 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbqLftXl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848D0248F4B;
	Sun, 10 Aug 2025 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754820963; cv=none; b=OKeZUqSc1vBkEjHavgbDWJp1zuePyaBq89tPZ4pPd+wLwwNGMMK3EjMF3A7/Fuu9aTaH1BQ3EYmMit4pkype6Qr51vbrsCodf1oA+UqvDB/8Zcu741PYyrBtUkpbiOTz1GVYtMPKQBzQGIGSPQ9t2jeJOlpQdz2umy+AULer5dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754820963; c=relaxed/simple;
	bh=wb+bp7KgUnZ8vSUBcRKx3kcq2artvUGLOXWnk7mvfjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hek2Hu8KoFe7StfYfJFS8i2tXpCp+/IEJ2HXChjifSF6kGWtJy41T25uRQcTokbA6a8F/zyVLLyc8dSMyB4ZqtCPgaTq8+qDjqMtqIY5irbbwBRwlGLz8y/QX+oHIi9F4LSs9rU3Qy6nLPbhrRVnRf4MmNxjz2sUcWoiw3r147E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbqLftXl; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-31ecd40352fso3007968a91.2;
        Sun, 10 Aug 2025 03:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754820962; x=1755425762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5cRw3nes6F1//c4vHntcd1HcPwQ6bE8lShJAHSAbo8=;
        b=YbqLftXlFVsQPh7BsA4so/TfRKLTUtRblji/LkLvFmu5WVc1+9A1rpU/NDv74f4Vir
         t6XstLw6wIHUjl13dn6MCfqpSZFaepcFrm1glARdex8xKbWFH9ghDOGo7ZvynMxm99mu
         3sJGlK2ZCp90kQ78W5CshpB3jQRE4DA4+3n3jj72EBcnuGN+FAWzaSGxtmA0oc/I7JS4
         4BAhdmK64E7w8b8ytOJcrPlQuz/fx7Jjeyo8yOwKz+BbXzCjiSfOStZtEH8DOz/GpYYJ
         nOnmezhlMW6yWxVVqbUL0+oU/s7/Lob/6WRxdCkm/z2rZdoB7W/Q9w3c8FthpAtnRxrI
         bBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754820962; x=1755425762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5cRw3nes6F1//c4vHntcd1HcPwQ6bE8lShJAHSAbo8=;
        b=wmwGngJs7zuRTtnfhhhcTLjqBj5OHdiY7gS5GTF9R4bMvYXZy+Aaje4MPNigNW4Nkg
         Y7whbOMrMjcUTQ7ata4lVYhfCo2wsNuKs0SLQ/sYktDynEEskeTRYe8qKuwqankhhwi/
         J4BdhSDOwM+PWHJnbSoyIXMnxM5ruTtXM5IyaW0Id8AkXFGOr/PtAZkuNkIeJg+SLRKS
         wpOHXA1jQ+SEovOICBd5WRdw65nX8HeNsdMiZpYjqs9R/E3vSlkClFa3MJ1CmtoY+55i
         xUZo+InIVtprpxUy9Pv8c0OMHb/wem/Ro2VWBenOMOahrqtqATPW93kkzNTT4kki44Ks
         wa+A==
X-Forwarded-Encrypted: i=1; AJvYcCVIlfft7HPbt33KssGH74m7QXIM/bD9GMZidiOgpTF62eeE15SuhgQp0GnElpHsc1UloMUp3HfGimrLCeot@vger.kernel.org, AJvYcCViaH5V8G8srWpFuvptypu/nynbRDhliP4qXZIfRmBoICxu+jcgZO/Oj1YO8HXhM6dAwLir1DB81IBehys0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1xEKARthV+a/AT37EZDiq/h9sx/oU8wo1eLCeBwlRBv6Z6yQB
	xAK0ZJb76yFoSfMO5A4A6FWFaREYoEvAOLbJ/LPNt/JPJ3o/whJxITCSjUeuxx5m
X-Gm-Gg: ASbGnctbVxF3VLH5rvWw1ppO8xYWogvK25b+h3+biJzWhIit3vkfI6qbKJ9zQ4nGYO/
	d9u/GGSbnwFHG+DLFclodYIdq43KCVGBz3WL9qTAspi+Ovtgv0XqP2qcuJROoCg6NXNAxgi4yPI
	Qb6lw2TlcMTKvtnwxeKBRFRFcet54d4kS0cVMVoXgkj0QDv37Q1mBrwQewLsDU6G70XG0Z9jC8i
	asZR9DQHloD5Qwo7pRFEzEihmOaXZivh8x52aC6eCft+XGhQsxvVsT+yTqhxtLXZM/weNB8iOdI
	jdbagbmBHUM/pn0pFXGCHWxw9KA0xRL62APob99zCV7NqwtMoAf510rRY7/22ymNP68vIjs4pAL
	92+1zq2/m9BMSNW1Vyi90fDAc9VLDzAc5uwA=
X-Google-Smtp-Source: AGHT+IFeEfO31R0TMLg4Yws2ieVAGTbmuCabmHxLHcKYeWQwwtzv4fcUw1w2ovhqNdrRsUTxPNU51A==
X-Received: by 2002:a17:90b:1c08:b0:31a:bc78:7fe1 with SMTP id 98e67ed59e1d1-32183b3f11fmr15915269a91.18.1754820961697;
        Sun, 10 Aug 2025 03:16:01 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161259329sm11923432a91.17.2025.08.10.03.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 03:16:01 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v2 2/4] iomap: move iter revert case out of the unwritten branch
Date: Sun, 10 Aug 2025 18:15:52 +0800
Message-ID: <20250810101554.257060-3-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250810101554.257060-1-alexjlzheng@tencent.com>
References: <20250810101554.257060-1-alexjlzheng@tencent.com>
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
index 934458850ddb..641034f621c1 100644
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


