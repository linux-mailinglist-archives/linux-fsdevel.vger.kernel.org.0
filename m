Return-Path: <linux-fsdevel+bounces-39892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09488A19C32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6CE1887CA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10BA1F5F6;
	Thu, 23 Jan 2025 01:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns0lgyG0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCBD1E4A6
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 01:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737595691; cv=none; b=sfVpdP3KoZYFsLj2BGQAw4A1llPjnQv5NgARtDLZ2dR8sW2Fx+Vvfrtc7Su4EfhOfbLT0IIhvBer5SuZaRXEPvWeY+jHwszbs0PiF35T8akRohW5YCE6eihaD5uouvjj1BKhXewPKIskPshu/44qryx0BK7HBuJaw2O9EgoIT7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737595691; c=relaxed/simple;
	bh=4Or1lduqRvyKs9TlgGhpc3YHaHcSPJlZUyere2Wzmoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2tORM8l86Oj9eEIr9vVEIHAljhzdLr6XJYQGhbrfRVWPaPb3rFfOICTuRCMbxO9J4BcFSD6l1hzB5/VfOC4IC6DrL4vsNzqNwI/CSh/lMVXrIlqJblMqr4tfConXXcrBkrofn9tGH59iNaWNtIhkOMZAftobmURdpPR3wJlQXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ns0lgyG0; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e461015fbd4so576250276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 17:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737595689; x=1738200489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kB4b67jfZmlM8Rvsdn93TfXAGMq28D3tw1SIamV3Ug=;
        b=Ns0lgyG07ahctoSOGtJa8GppoY7Xx264MF28UR+7BYero1r3pfaORUYOL4aHCLWbLA
         ved7ILUakN74GeO2xCcwlJRK7WCr7M7OUSHP/TD0TSI1UZyz2aldqazXxda9Pw4t/A8y
         3+55o0JYSmLlH0zZVHRuBnn0w3E78gC/Ucty8RLAxuSouFoQb4sSzkOABuMPEZsv2YQR
         mO7eCvtl08sg08vMKw06GoniJNTofNFmu8o20cbIz0qz9930RXm5M8ylt4Z2jEIK7n6Q
         1k+6RxsOCxpTct4AVgkMEf1+Oy6OeBNXHp3nLg+5fsk4pxfjzXw/gDlpr7FX01qIY3Zp
         +Sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737595689; x=1738200489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kB4b67jfZmlM8Rvsdn93TfXAGMq28D3tw1SIamV3Ug=;
        b=tnPUnON/TVbVcursE0MzgxszLMLotlUedpzt9KF63Y1AI+Gk+t0qFqzGv4E+rSwJG/
         TmWGSJnjoCwdoOyM+qT0QMqXJlco95Ou52Hnw+PoZxcsx3M51ClELDKAIVH+HZsRA3Qi
         Oq7LsXNkyoGBm8Cheys+t8Nq57/3cn1jaFVNWtoUy8wB+h6nJmVBrWrvTUGuJCDh9Eda
         nxNRK7ax3hZLpDtohoJ7zvEC9g0Af+eM7p1mGOXilEEaXZ5mia+hZjv3tHihGkUc5QP9
         /Q+JlWWqebhPEPrdoiWc/RZDA5HZrnjigVcqEJ7vtf3HKh6pnXtT3Tu/NSpqdhUSBqMS
         +AVg==
X-Forwarded-Encrypted: i=1; AJvYcCUGU9bswH27yJTQGhtq9BIfIe3/fBNGQQd3dB2n1/06PXhD36A9twhuj+ZhgyYRADlvyYAb903w50nUwNhF@vger.kernel.org
X-Gm-Message-State: AOJu0YwLLAm95pQ5GrNX0iqGbMs0H5IKXfsx9fAIEWf3DrxKuB7FepKy
	24ryCPHPtxmfnbEfrfbCmni3BjMrHnV5/hkt90LNY6fA4TUt8e2m
X-Gm-Gg: ASbGncsbR9wK8PYh/+KTeEAx8yNSgg/7RFlSH1w8l2tXT4+HJKaFcFXQQVmio1RmWHA
	tu8poQXfiJwWgIgSurf/zT9qSCf55TU9G5nyK5AYhtKWNtyA+LM5fW/LK/79ggehF/E8yCre6Un
	O8Xy7p8hbkax4QbaYc03MjqzGGL7EIydWDnVS39ajpOkojEuWD7MJZta2wIBNPQfPh42v2EKRDI
	HycwbcP9kc8WCKTy3qatCCbzugbr+iT5H4VVPq89OfGUbGhIZL27faRpahIwvl/kxyN3+Hb+2zl
	WbA=
X-Google-Smtp-Source: AGHT+IFbTCK+jUCC34el8Q4xH7M5zEnF1jmwiIPbsKeZMgFDkGntV2+y8l0aeA0BUUwbgxUMjfLQMg==
X-Received: by 2002:a05:690c:9a07:b0:6ef:64e8:c708 with SMTP id 00721157ae682-6f6eb680cd2mr182986027b3.17.1737595688967;
        Wed, 22 Jan 2025 17:28:08 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:7f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e63ab38fsm22486657b3.25.2025.01.22.17.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 17:28:08 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	jlayton@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v4 03/10] fuse: refactor fuse_fill_write_pages()
Date: Wed, 22 Jan 2025 17:24:41 -0800
Message-ID: <20250123012448.2479372-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250123012448.2479372-1-joannelkoong@gmail.com>
References: <20250123012448.2479372-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the logic in fuse_fill_write_pages() for copying out write
data. This will make the future change for supporting large folios for
writes easier. No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/file.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7d92a5479998..71b243b32f0a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1217,21 +1217,21 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 	struct fuse_args_pages *ap = &ia->ap;
 	struct fuse_conn *fc = get_fuse_conn(mapping->host);
 	unsigned offset = pos & (PAGE_SIZE - 1);
-	unsigned int nr_pages = 0;
 	size_t count = 0;
+	unsigned int num;
 	int err;
 
+	num = min(iov_iter_count(ii), fc->max_write);
+	num = min(num, max_pages << PAGE_SHIFT);
+
 	ap->args.in_pages = true;
 	ap->descs[0].offset = offset;
 
-	do {
+	while (num) {
 		size_t tmp;
 		struct folio *folio;
 		pgoff_t index = pos >> PAGE_SHIFT;
-		size_t bytes = min_t(size_t, PAGE_SIZE - offset,
-				     iov_iter_count(ii));
-
-		bytes = min_t(size_t, bytes, fc->max_write - count);
+		unsigned int bytes = min(PAGE_SIZE - offset, num);
 
  again:
 		err = -EFAULT;
@@ -1261,10 +1261,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		ap->folios[ap->num_folios] = folio;
 		ap->descs[ap->num_folios].length = tmp;
 		ap->num_folios++;
-		nr_pages++;
 
 		count += tmp;
 		pos += tmp;
+		num -= tmp;
 		offset += tmp;
 		if (offset == PAGE_SIZE)
 			offset = 0;
@@ -1281,8 +1281,9 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		}
 		if (!fc->big_writes)
 			break;
-	} while (iov_iter_count(ii) && count < fc->max_write &&
-		 nr_pages < max_pages && offset == 0);
+		if (offset != 0)
+			break;
+	}
 
 	return count > 0 ? count : err;
 }
-- 
2.43.5


