Return-Path: <linux-fsdevel+bounces-18882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F60E8BDD90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 10:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404BB1F256B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 08:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C7514D6F6;
	Tue,  7 May 2024 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WegJBcKW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8BD14D2B6;
	Tue,  7 May 2024 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715072158; cv=none; b=WZlXrecdmLq6vWI+T2TfLF5KfHn4lbTdVgsVxSPE/NLMLtLyVNvgKg3KNaYD8wQE3fDRRW2Vi6UtLpPKGx7jHYtPZtJrrPa36DKb4/5s09GBDxFVWgVI+gqjClVX/O6OgAQYrO+tQmKDn42BvKmn8kfbOvvpsSNof+gtvIBW2BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715072158; c=relaxed/simple;
	bh=jFcnH9HqLEggeqAB2KGmVQnYPco7e2fsq97konYOI6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTyFqPzjf2bu2Ncw3iFmKCIuIBhxLTgxipwG2vCb3A5X0e7h5mm6T4osaGcFs+6CzmA7Fpb46r2cQbZtdkOECvH/tc7tUGRd2yrCMwlIcupU58MxA0FTyuIZOnzFWFURl9+nGcJ9HrvrNWcQt2xzwgXpgJ8hhLLLUncJkOzUXfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WegJBcKW; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d8b519e438so2326931a12.1;
        Tue, 07 May 2024 01:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715072156; x=1715676956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e57mtgQJCyrMor2wdEaqG/4Lmj2DaZNgeRnrm29BCyg=;
        b=WegJBcKW8Zcpl0wCdtgI4dcHSS27HrU6dXC0V7mn95HF8JHwRLcONl6tHF0cZyRUIC
         ttfcTvthPy1XsfRyYNUbWdVxBuPsR1Qa0TOktsDSmgabqDdX1akVUQVwHmOlO409u6kX
         QwwyTWXD9x+rSmqVM7ZszESll/qqbi6PW79ckwF1LBhmoFsjZZsWR52xcnzVr53Cdl23
         FU+/OKPbVWPYeQzBj8PU2qjBDLggCaUmDLD/v5Xj96C9k/2jiFPpqe/XlDfAaNkmAdVQ
         ++Jwrv83r/YI7GyJEyk6SbQbiFPzzksKpWSZGMNUgqst+v25mcx8SHsQkszf19PTloTy
         qsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715072156; x=1715676956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e57mtgQJCyrMor2wdEaqG/4Lmj2DaZNgeRnrm29BCyg=;
        b=k/ACvZ1tB/L/4lRzl/DX+T33lb2qFQJSYyQyleGSOOgxSzWO8gbfD/vDhVYbWePeK9
         S6KrFjHMmL2Ap74D4ca2ueBjT7EUPwtKcHdel3WLQ4NZKfSgtBZ12v3ImM1RTloF1P5I
         gTrrs2QupCFcT1hixWBZZLK9VslYEFDVcjM7fjPKFCs9lUN09ibti9sJpNSn83P8KtAd
         f/cvjrspGkDCC1E60IVjqaWd6s90ZN0++bw435fXn6YZl1yygKoXF2QXawiwvAy0HKei
         NHQTMu8TnxzgJ0WcepS4MN7+uDy3Nii4eP0i1oRkl5Z3PcPNCjJkylhZbN5e2jz+ZWwu
         U3Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVZr/zVakVDzjukqEYI8b4zHMNa6Y/CZsWDPaZfhYkt/qEr4NJZ7WLrQ2pd4WbLuEIQ4R81FeNFGl2LWNvRBzBc39/lrSKCTwgfGw9x5Q==
X-Gm-Message-State: AOJu0Yy3SGwYRmuzO2XcIF/mDeF7hIrYvYSCzfGUE6iUltqw+RVHkmAO
	LedNL8HnhjkKxg1hvDRIKrxUql71ixwkMiXLV3VLTP8tx0fn+53MeGFeqjGK
X-Google-Smtp-Source: AGHT+IEKmuXZ4GNt61aztBB3VJKUSvUF74Re7ukD6WMb3WTHQLEpNms985ob09t25CnALiwpgOvv1A==
X-Received: by 2002:a05:6a20:9f9a:b0:1af:93b0:f007 with SMTP id mm26-20020a056a209f9a00b001af93b0f007mr8846151pzb.1.1715072155903;
        Tue, 07 May 2024 01:55:55 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.81.176])
        by smtp.gmail.com with ESMTPSA id kg3-20020a170903060300b001ed53267795sm7262030plb.152.2024.05.07.01.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 01:55:55 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCHv2 1/2] iomap: Fix iomap_adjust_read_range for plen calculation
Date: Tue,  7 May 2024 14:25:42 +0530
Message-ID: <a32e5f9a4fcfdb99077300c4020ed7ae61d6e0f9.1715067055.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715067055.git.ritesh.list@gmail.com>
References: <cover.1715067055.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the extent spans the block that contains i_size, we need to handle
both halves separately so that we properly zero data in the page cache
for blocks that are entirely outside of i_size. But this is needed only
when i_size is within the current folio under processing.
"orig_pos + length > isize" can be true for all folios if the mapped
extent length is greater than the folio size. That is making plen to
break for every folio instead of only the last folio.

So use orig_plen for checking if "orig_pos + orig_plen > isize".

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4e8e41c8b3c0..9f79c82d1f73 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -241,6 +241,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	unsigned block_size = (1 << block_bits);
 	size_t poff = offset_in_folio(folio, *pos);
 	size_t plen = min_t(loff_t, folio_size(folio) - poff, length);
+	size_t orig_plen = plen;
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;

@@ -277,7 +278,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	 * handle both halves separately so that we properly zero data in the
 	 * page cache for blocks that are entirely outside of i_size.
 	 */
-	if (orig_pos <= isize && orig_pos + length > isize) {
+	if (orig_pos <= isize && orig_pos + orig_plen > isize) {
 		unsigned end = offset_in_folio(folio, isize - 1) >> block_bits;

 		if (first <= end && last > end)
--
2.44.0


