Return-Path: <linux-fsdevel+bounces-17783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B68B38B22C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC6DB29332
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C5714A4D7;
	Thu, 25 Apr 2024 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8l61sdi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292DC149C5F;
	Thu, 25 Apr 2024 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051764; cv=none; b=dBfohxq3HhA9mkPqImUyREH+Ht/1nQtgUPUf+RAzFlyVUt6uu4aSDaYBAgtIF2qDpcl8ygezlH9pVZpflB8hoS2IVTaqOnZtax8/XPGjKL1S7GIZ+IZBjBhYZ8QwruZNJbaJgAvOHfLT5B9+HmnOgiotutQ2NdjteQoKhWDRnqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051764; c=relaxed/simple;
	bh=1EVVSYodaYczteQL7YgaNHwjZuwuhwLauk68UaTQcTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SwfgU9Dy+V/Nks6pQjt2d93+jZqSyX7HjBYcy1r9IbXvzcLlmxQgmXMD9bJ2IKQ8Q14/q7UiheDpkFapVoIYQCLSX47FduRvG1eCt5ifBYGq9UBw6TVk/MoRiTbRNC+HBLXce3h4dlMEJ/f1lkwFS7zBkQ5cfQkIgz5LWuBgPJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8l61sdi; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ece8991654so965002b3a.3;
        Thu, 25 Apr 2024 06:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714051761; x=1714656561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8wacH0Zdla+UG4oItfWBesuc5mnqKDfIZULU83MhBU=;
        b=S8l61sdiwDfpbYF1B1gbZmF6fb4Ms+OTkZT3ZPb0prqe+B+kbAwm4EtVwU2Mv5LJKy
         1w9vFmkT2ph6gY3Erb4FgN/9QowFX2WnDTbc8tfiggx2x7fRYF87ngQVdTxF3C3NA1ZG
         dF9PUL13AFGNLHuR4UtvCR6+URukon4MbpoWjsju5rAnuYnfAs2luKWb+PQFkg+HhzSa
         Gy3Av9cFl0pgAGKEOtbEMS3lzZKBLpXPW7Q2GMmgHgSuF3zDjluH7M18hjU1/Ku+aAjw
         ohNE+JDlZ6HbahznEnaGZo1RZ6qh8QZBovUaQmD9hUd7NSzOzpFLBYyN/1Kot/4AF9AY
         AnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714051761; x=1714656561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8wacH0Zdla+UG4oItfWBesuc5mnqKDfIZULU83MhBU=;
        b=Wso3EpUBedILcbOFfv6HPuSWmdFBRHqfB4tjexi+4ZFXELw2LGtgkckEl5gBl/DpTH
         LE0tyambmTsUf+uXxAQOnQcfluGMZECShCVow8KB9o5WWi+LfUn/1+OaynyFfFboDg6+
         C6Q1p1scxRvJp/wKFgWRqBH4odpsyG5TS69qDobKnwtxRoOKyTfCs2e89VbjN0s1Wcyg
         PpCJ2e12Mq3Ii/N2ZXKGR6z6KeiVuhBw+E9Cs/gEIUy8dliZRg1kVzcFOo81UsW5NJwW
         nuA2ok1lcTOA5naPvlkrpfYhk2LZSdZdE/rvo48jE4fx3nx5yE1888qQypTv1cSVqqKR
         3APQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQA2O/ztR20Abz1GRnWIvTgPL8GWGJk41ZOVHqx79l+uByxMF4Sbb187CCs4lwXjgrsdY76BZTCpy0CsLmXbxysuZs7RrKoXTI
X-Gm-Message-State: AOJu0YxORNzgQL/afL80hUXyio2707xKaN2swV9DE0Ur4TLOhKvd7xtU
	q12KOA/1r5n5CQP8X1NYPcPQaPG9jxq8T9J7h8A3i2SGaDbOO1wWP55xC+C6
X-Google-Smtp-Source: AGHT+IE8DSouLugBHHToHn+jclSG03lwZRDwAQKWB4GajIqxXia+Ra4kvLmuyZ+Yn02D5NDn/3sfPQ==
X-Received: by 2002:a05:6a00:4b04:b0:6e7:29dd:84db with SMTP id kq4-20020a056a004b0400b006e729dd84dbmr7904590pfb.31.1714051761550;
        Thu, 25 Apr 2024 06:29:21 -0700 (PDT)
Received: from dw-tp.in.ibm.com ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id s15-20020a62e70f000000b006f260fb17e5sm9764518pfh.141.2024.04.25.06.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:29:21 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [RFCv3 5/7] iomap: Fix iomap_adjust_read_range for plen calculation
Date: Thu, 25 Apr 2024 18:58:49 +0530
Message-ID: <deb8991ce9aa1850b82471cf3e76cd8fdc1a9e92.1714046808.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714046808.git.ritesh.list@gmail.com>
References: <cover.1714046808.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the extent spans the block that contains the i_size, we need to
handle both halves separately but only when the i_size is within the
current folio under processing.
"orig_pos + length > isize" can be true for all folios if the mapped
extent length is greater than the folio size. That is making plen to
break for every folio instead of only the last folio.

So use orig_plen for checking if "orig_pos + orig_plen > isize".

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>
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


