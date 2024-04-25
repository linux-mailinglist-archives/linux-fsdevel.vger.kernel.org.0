Return-Path: <linux-fsdevel+bounces-17778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5CB8B22AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE8B1C20ED6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B22B149DF0;
	Thu, 25 Apr 2024 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVzfIR7j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654E8149C5E;
	Thu, 25 Apr 2024 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051747; cv=none; b=dxE0LItxz0XS0mZl02e2NPR6F6EbVOV8GqYv97lFOW3OhD1v/P7FUmpNH2JIK0b+9Lr0x9euYPDrUqZFp9INXvh52O275X6vDNw5CPzpFj4zad4629eqLqKDljQT2CXM4GTuIcS9OL2bwOC2Z2bOHu0WrCZmOb+ZrQSMboad3bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051747; c=relaxed/simple;
	bh=uiHICPxxlQncNpNDMTYxWAUZ0mlWGqTwB6pyor2Rmyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h92WfA0xq9LT7M2diX6CMvOml34hNlzIo8tQcRK/Q0QLjjjV2Qs9VfbjmvHv/jhVBxre4Tnp3pYcoRYbA5z7Y33O69ORdHl6GodWiiwECZV07p3HivvwwxyxJv7EslqMIt1mMGLr/qizbn0ODQodbd48wfcxGjekfdS8qjjE8ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVzfIR7j; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed01c63657so940995b3a.2;
        Thu, 25 Apr 2024 06:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714051745; x=1714656545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UCgihl5wDkiRpuPvuLFf7PaBJvQfp9jeIXSIObyAuh8=;
        b=iVzfIR7j4Ef29CQolddtpjXKLursKmPsJPboy6yquJs8yO8+ibRhSMFKQ98KNE8P1c
         G5QLOcHici46Jgr8RzQscU3xE/n3pv4KmInHa0ItCMu3sMMi5Wo75aHMit82dnXr12ch
         9zD5V4a/w/43hpyigmprUUsqOlJqBxjDrczlVhrsPLj0AU6olWnjUc4wmdUSAF6jIVB5
         lluU3gmclsfDlw2rUyTKorcXygQhOPq3ntbzReDBZPai7QIW+jTHQ9Stlu3uKcH2Lzp2
         z+x81x/r++5bv4BGpvSrc/Mgb/5pn/755908eg+4O6lPc2DxzZjGaHugkSqUsjqooY/r
         D6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714051745; x=1714656545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCgihl5wDkiRpuPvuLFf7PaBJvQfp9jeIXSIObyAuh8=;
        b=heM92IXjJpzqQP90ExnQl8/jRYV0G0JQwBDoxTxhSWsvWPr2nhF/suOL/uVyrMCJ8J
         dIjVbREOTPgL/HPp3Y7QetqWdzl1MX5Kc7iVe6UPvtVyPP34R+/Z+1TRaTl8R7EPEurK
         4QzpOSifIiZOk+0lpfJHxGjh4mpUGBvo3MUUyiiXJ78cvRDDg4XDLiRMMsclM1K0tafU
         HlbLM/RSH1xf06DzxAbDunxYc2KGfgExA889Y9QMdAXnBV0+Itaf0YPv7vVor9r82UPQ
         ih2ykQx69f1MvEwc/AghEshCofSn2418yGO02mMkS+ddqGPml51kOg8AxNbgBa/08cRB
         Xz7w==
X-Forwarded-Encrypted: i=1; AJvYcCXGzHv7PdPLFgh1Q3ZsSbrixiG7eKeb/PgmML+ks71zt+1gCBLvOY/KryhppQaULFVlKKDMWgJiNO5Y52AGJn3OiY+t9b9XDTA4
X-Gm-Message-State: AOJu0YxaKJ3jzEA94ToTE4/UVr16rJuT0rWtKoJXI1bBCWByWliUfM1D
	yuWkeSQRe+JP9yPAEc7P4BQf0bTy1Ykf6ILr9kAaNlaBc6KmEDJYuIGi+JYe
X-Google-Smtp-Source: AGHT+IHe9AHrh3Uhb48MeOGdjr052LB6gqZaOXhYect+YF/jMAjmvhmizZNSqbPcF55odjQEnPz+Mw==
X-Received: by 2002:a05:6a00:4b48:b0:6ea:7981:d40b with SMTP id kr8-20020a056a004b4800b006ea7981d40bmr5759153pfb.16.1714051744711;
        Thu, 25 Apr 2024 06:29:04 -0700 (PDT)
Received: from dw-tp.in.ibm.com ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id s15-20020a62e70f000000b006f260fb17e5sm9764518pfh.141.2024.04.25.06.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:29:03 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [RFCv3 0/7] ext2 iomap changes and iomap improvements
Date: Thu, 25 Apr 2024 18:58:44 +0530
Message-ID: <cover.1714046808.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

Here is a RFCv3 which implements ext2 iomap changes and I have also included
some iomap improvements along with implementing BH_Boundary fix within iomap.

Posting this more as an update (before conference/call) to the current work
since it has survived few runs of xfstests -

Patch 1-4 implements ext2 regular file buffered I/O to use iomap APIs.
Patch 5 & 6 are iomap improvements which me and Ojaswin noticed during code reviews.
Patch 7 optimizes the data access patterns for filesystems with indirect block
mappings. Thanks to Matthew Wilcox for pointing the problem and providing a
rough solution to BH_Boundary problem within iomap (which this patch is based
on).

Please note that I would still like to work on following aspects before
thinking of merging any of these -

1. Look into how dir handling for ext2 should be handled. Since ext2 uses page
   cache for that, can we directly use iomap? Do we need any other iomap ops for
   implementing dir handling? Basically either a PoC or some theoretical
   understanding of how we should handle dir for ext2.

2. Integrate Patch 4 within Patch-2. Kept it separate for review.

3. Test patch 5 & 6 separately before thinking of getting those merged. The
   changes look ok to me and I would like those to be reviewed. But I hope to
   get more testing done on those patches individually, because those are not
   dependent on this series.

4. Patch 7 is an early RFC to get an idea on whether it is taking the right
   direction or not. If this looks ok, then I can polish the series, carefully
   review at any missed corner cases (hopefully I have covered all),
   work on other points in this todo list and do more testing before posting
   another version.

5. Write few fstests to excercise the paths more for the overall series.

Ritesh Harjani (IBM) (7):
  ext2: Remove comment related to journal handle
  ext2: Convert ext2 regular file buffered I/O to use iomap
  ext2: Enable large folio support
  ext2: Implement seq counter for validating cached iomap
  iomap: Fix iomap_adjust_read_range for plen calculation
  iomap: Optimize iomap_read_folio
  iomap: Optimize data access patterns for filesystems with indirect mappings

 fs/ext2/balloc.c       |   1 +
 fs/ext2/ext2.h         |   6 ++
 fs/ext2/file.c         |  20 +++++-
 fs/ext2/inode.c        | 126 +++++++++++++++++++++++++++++++++++---
 fs/ext2/super.c        |   2 +-
 fs/iomap/buffered-io.c | 135 ++++++++++++++++++++++++++++++++---------
 6 files changed, 248 insertions(+), 42 deletions(-)

--
2.44.0


