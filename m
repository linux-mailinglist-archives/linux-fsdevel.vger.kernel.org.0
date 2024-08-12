Return-Path: <linux-fsdevel+bounces-25656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C20B94E94B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 11:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E69F1C21E11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 09:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8931816C854;
	Mon, 12 Aug 2024 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aprRsHPU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B765016C6BD
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453687; cv=none; b=pwHew9zipsEEq7WENVDtkn6iAmQezM7w5VYbdM2Co60R0lRyxK08CrQG+5b0rnzDMH4xfPEaLgJns9iqsoMassAuNu73imtOPRNqJIpcG9V7K9qKfMIsATE3X5D17CacZsBBLnfMYbsL6+utFyxhn8vIqwNuEKt52pzkVYznV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453687; c=relaxed/simple;
	bh=ae1KlNZSNjFNCH/6eecsVihdFSlqIJ/2wQK1QYnxWBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nw0/0trmCzgFyjgdVpo1Cl50lm+3kG/heQ+REigGdLUeSRr2vX2m5qOSPOsic+/O0CtuYk3MyC+y2cmJ1oQfT7aYoQWjdw5LIT2AApoPy8r/P0ksx6MBb9U9Al5IrpKuchXRPWuwbQ1QPD1oaZ2S3aQ+o1gh+CUdA2sbd+h0/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aprRsHPU; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb64529a36so2711064a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 02:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723453685; x=1724058485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0LiO8dQ1g5fPQRJ0suQCC7XgalqK+L1zAcHqDZziAys=;
        b=aprRsHPUv0qM3p4rQg0bACvO8iX5Yrv8yY05fo02Cf004PC+WsSop3RVioAYQYm9zi
         fOBL4KTzF7HMPhrJ2DvfompENl0MJKubg12JIrANc+Qbw37XCvgrchoh8yAGNCATY/NJ
         S3SIRHF+XNMA75bt/NRIRyQdl0BBoBfdyPxXd0WQFaKhFTy2XrSpV8A/zLdU0vkm1c39
         ylKvX50TJYdquRtyZ/zsaU7UYbfQtNgef1Lr4LBjOzSgTmpx3KEckrQwuC/DRMbq0+66
         mD54MSfSeCNvO3QDOVGswgaV/JHGs30YDWFpQc3gxMJZcnOIhlCIyqwLnYolZm1hu0pD
         PSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723453685; x=1724058485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LiO8dQ1g5fPQRJ0suQCC7XgalqK+L1zAcHqDZziAys=;
        b=h+eu7C1Y1esgx82OCXQwJF/yezN0Wr73dtNVsSBlW+ypN2eQLRCxwTrXiFEjxMdxMD
         mGd8vwB9Qcb8Ixqyf6diNSTiR1GplkD0lX7bBZzvW9LAmC8qsmY4bEMNdXbDtXIFmTWy
         u2/2zJndZIJVcGKot6fPfjsYDp/kbWLsTj+YjgEPT6cqyERLaCY4v6NkGtJCMcFKBr4u
         VScdVBJKzkJpdKsdYEgWcM7YR98a3e46acl66R5rTnpFHoK+WQoqo6/9Er8v/9taVEA0
         osjk8XGK+PZJ21Ks0FIEbFIWpLA8BsBMDIZR0Idn4D6RjM3/xS5SmUd6G4XjWJzLKezF
         aOow==
X-Gm-Message-State: AOJu0Yyk6PBVtNHE5PEJqxYPYjVDySZdID8Y8XGt1uc7ZexZk7xJfYqL
	G1oMOvNzI6o8g3ZCB0+5AqjZl1aXqZLvUnQ5LsApMLDX3fxiXedz
X-Google-Smtp-Source: AGHT+IFI9laxSXjiPpiTGL0ll309p+skRhFj/DIDV/fMC4xOYIpEh8VoE/ldvERI9ijgPDHfSoTAfg==
X-Received: by 2002:a17:90a:d812:b0:2c9:6ad9:b75b with SMTP id 98e67ed59e1d1-2d1e806a0d7mr5692400a91.40.1723453684818;
        Mon, 12 Aug 2024 02:08:04 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fce6cfc1sm4450262a91.6.2024.08.12.02.08.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2024 02:08:04 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	david@fromorbit.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 0/2] mm: Add readahead support for IOCB_NOWAIT
Date: Mon, 12 Aug 2024 17:05:23 +0800
Message-Id: <20240812090525.80299-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have use cases where we want to trigger readahead in preadv2(2) with
RWF_NOWAIT set [0].

Readahead support was originally added for IOCB_NOWAIT in commit
2e85abf053b9 ("mm: allow read-ahead with IOCB_NOWAIT set"). However, this
behavior was modified in commit efa8480a8316 ("fs: RWF_NOWAIT should imply
IOCB_NOIO") due to concerns about potential blocking during memory
reclamation.

To prevent blocking on memory reclamation, we can utilize
memalloc_nowait_{save,restore} to ensure non-blocking behavior. By
restoring the original behavior, we can allow preadv2(IOCB_NOWAIT) to read
data directly from disk if it's not already in the page cache.

Changes:
- fs: Add a new flag RWF_IOWAIT for preadv2(2)
  https://lore.kernel.org/linux-fsdevel/20240804080251.21239-1-laoar.shao@gmail.com/ [0]

Yafang Shao (2):
  mm: Add memalloc_nowait_{save,restore}
  mm: allow read-ahead with IOCB_NOWAIT set

 include/linux/fs.h       |  1 -
 include/linux/sched/mm.h | 30 ++++++++++++++++++++++++++++++
 mm/filemap.c             |  6 ++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.43.5


