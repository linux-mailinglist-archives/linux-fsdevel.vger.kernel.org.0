Return-Path: <linux-fsdevel+bounces-58745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2108B311D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 10:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E821CC6EC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 08:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D4C2EBB89;
	Fri, 22 Aug 2025 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MMgFtaoU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E401927CB0A
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851181; cv=none; b=U0hY1JyfLDaeE///SQwcSu+jTht9Rhqr3/4LgPWXgP5efpSWSUe5vfFOY80OfNvvYBjv6gOYv+rFpphHHAADLaq1oVmvQfc20C2e4T0lrELgC5Px5eFtTkKdFB+PCREkTeWKIvGaI+pk1cdWMR1m6/BGItlLQbLHS2Efp7Mvios=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851181; c=relaxed/simple;
	bh=3Y7pt99HGaa7ArnnUwqQ7vjbh1bOmBAGpcnzoKd5MYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z+7PHuCBntajbomd7I5uRv2R0dfJ5cXhmYJPFubhVaYuJ8D68V4dUs0wf+7iSYf7PGS0JcLtAI4M/0tAyrufF1+0mKuQS9uuOF3Z3VC+IXbAS9U+bOYbgGvyxZ6T54uDSw8piJfUQLVqmtdzLkAXOY22GP1/kBGXJplPKJkO6Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MMgFtaoU; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e87031323aso217353685a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 01:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755851177; x=1756455977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ox9fNV0dmc12yYwQJgBEIVF6B4bp0ZnRQ4q5/+iuAzU=;
        b=MMgFtaoUFingLICaeC3qsvgTJhvjRW1AKtIkw83fYOsqoHoCdBkXKUflETkAhekV9O
         YsIc7iW+kGGcC6+78E3n9TQPn15G9ImgGoyqx67d4LiaFeGdSpMLMG4kTf+fXWLTztOu
         4ZMD1V/8OR2K4w9O0ThZjG7ZnRCi1yH5lJ8zsx4R4QX+vM/U8Dbvz/oSRQr+ipXGW4Gx
         gxmJCxs+2QOsN5uQSamDhrge5KaqAt9a4pePgR4Qqgeiexf7LfwG55Y7JhylG8jYokXu
         AAHhYE37QKZsGSWBJOH8y08qRkiMXyYnUZP2bNPmp2hczI+Nrg2z2jmSjyA9cLQ3fFNL
         vpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755851177; x=1756455977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ox9fNV0dmc12yYwQJgBEIVF6B4bp0ZnRQ4q5/+iuAzU=;
        b=HCFeljjdcWcSkOIOJIOXxAJvzxioxdANVHoM8Ay84NEyYcY6QDaQ0pzfqY0NC63NSU
         rtMXwLFej5eulM9jyz7m48vCSXaO0ep0/AeBy0+h1W7x++7sUgYqH5iNFIZfLsHHRLUZ
         A+5c17g+9UEanc1NUTDzvr9aBnXuEEUFFdNZkjRFTKexw1Ti9eOHfcJvlfCHTbOhS/mZ
         E79n01tzdHaikuRShadRMIKU9WS9nbuKmPQ6Ge9FXI6O18h+bpJIGzSHzWI0+S3++urw
         0UTMSKETuWcofY3Pyk2nE3UusoAsOm9YJG/+tDwQ0yC0kKlVn1mr3r/Cf4oqJeL+uAf0
         qAyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNXuknVfpG310UxQjoInsiYUwZP11guVWFlYzG+wsHl2Vt3LcavgPTDdXfRBBihXDbqVasD9Pjb+wn0kjN@vger.kernel.org
X-Gm-Message-State: AOJu0YwvbcTP2RbXKsG2BY2baI5+3lDRLc2o2zzyigaE3yJ66VyMPk4r
	+2ZIFlkeOIjgcf/TTSGjEdLFwqyjr/MsMbJY6u+SD/3MiyzIAz5tByyF2vtj+qSm3QdPOgHymrd
	s2hb9
X-Gm-Gg: ASbGncuCgpwtBqNTP1yjPWSlP94yc+Z90CNAtekXbJyAhSWdeux8TtO3M6GjivWjLgw
	hRGiOljWAq5vsnoVrr2GgXUXYxcm7P8gpyeGwysN0fTWJC8Qf8HgL1tU+vjFnDtHiNNJ5wYEini
	JR+UwbIrJv1J56eemXOVlsMi+KJONZiW8Ra471zAytNkbIY8CRQUfh9ebGeqz0ZIfihd3J7YvFZ
	6U5MpUtlcKlbcB2PlueWcdJlnjNi+LdXQeOpeFMdJAtAEhfbtMewFTVnwc4Sb0vOOFBoRnrNwFB
	32Jebiftc4lR6tFrpyst826ZBHC1yuiz5aYDwoDcHpxqk78bLqK/SBOsBjYGq7AKl8PfHt1jUpk
	dPKfrIU+92Nz/4AHXKZS+zyk6ICcZGR0CdyCzM23YHxtTYEBwT2Le6bxMGX4=
X-Google-Smtp-Source: AGHT+IHzishO1R6hzkVbz5CN/NEks268S4RTP6J//EZTRKNtZrnibnc35ncixCIvJiWDrXp5Euygxg==
X-Received: by 2002:a05:620a:294b:b0:7e6:9c7f:baa9 with SMTP id af79cd13be357-7ea10f88ebemr262093685a.16.1755851176675;
        Fri, 22 Aug 2025 01:26:16 -0700 (PDT)
Received: from localhost.localdomain ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e191a42sm1293893185a.54.2025.08.22.01.26.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 Aug 2025 01:26:16 -0700 (PDT)
From: Fengnan Chang <changfengnan@bytedance.com>
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH] iomap: allow iomap using the per-cpu bio cache
Date: Fri, 22 Aug 2025 16:26:06 +0800
Message-Id: <20250822082606.66375-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When use io_uring with direct IO, we could use per-cpu bio cache
from bio_alloc_bioset, So pass IOCB_ALLOC_CACHE flag to alloc
bio helper.

Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 fs/iomap/direct-io.c  | 6 ++++++
 include/linux/iomap.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 6f25d4cfea9f..85cc092a4004 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -341,6 +341,9 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
 		return -EINVAL;
 
+	if (iter->flags & IOMAP_ALLOC_CACHE)
+		bio_opf |= REQ_ALLOC_CACHE;
+
 	if (dio->flags & IOMAP_DIO_WRITE) {
 		bio_opf |= REQ_OP_WRITE;
 
@@ -636,6 +639,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
+	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
+		iomi.flags |= IOMAP_ALLOC_CACHE;
+
 	if (iov_iter_rw(iter) == READ) {
 		/* reads can always complete inline */
 		dio->flags |= IOMAP_DIO_INLINE_COMP;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 73dceabc21c8..6cba9b1753ca 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -196,6 +196,7 @@ struct iomap_write_ops {
 #endif /* CONFIG_FS_DAX */
 #define IOMAP_ATOMIC		(1 << 9) /* torn-write protection */
 #define IOMAP_DONTCACHE		(1 << 10)
+#define IOMAP_ALLOC_CACHE	(1 << 11)
 
 struct iomap_ops {
 	/*
-- 
2.20.1


