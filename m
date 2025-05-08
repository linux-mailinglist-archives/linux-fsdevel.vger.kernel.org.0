Return-Path: <linux-fsdevel+bounces-48516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2347AB04EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 22:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470A65233FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 20:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4452212FA0;
	Thu,  8 May 2025 20:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfZMq1Zs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2B4B1E72;
	Thu,  8 May 2025 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746737464; cv=none; b=kFWx+AdjVOGogZQQeLo745z0GYK9RG+lr07yMjqUxVUS2nVH0W41HRurxvx6TzqKLvzvcR+Wpz14C9wTzZmX6iLbvOnx0LNuoY625fsXefVqV5ISm6RxFN4ioztEiQ99WhwNNW6Y6GdjARailkpHmfXb9f2UQNuRB7twTJmGoMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746737464; c=relaxed/simple;
	bh=qhyrbR0eVUh0DJSa3k/gNVCkLP9sreuJqWLhJokDCzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUd6unmGucEc3HNsAka3k1hKtmr1rxRSepPIb9NHpejqe09yP4kfY8ICI/MKIdRGOcgUsDmKRbtOmScdWKdsvJYBACeVHpMds8BnMuOMRa0YqdBiPqPj8Sno2ztDLhfeFnH6sjDys/pJqmogSC5YKEuDCoaNaEvvkscM1bG2Nc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfZMq1Zs; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7411f65811cso1025722b3a.1;
        Thu, 08 May 2025 13:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746737461; x=1747342261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fuNn4qXCymqY8mGLnT4Ald580/wR1S81yyedMtxxNt4=;
        b=ZfZMq1ZsQ42K+p3jmoRum3BOlkkKp9VZZ3u6cP2I1198ftsuoFnR2qKlIP1zqGr25T
         cwOT55k7RkTADFpS5MKe2VpXiVfbsjpFFj1/0VyRFc1gvSELPNsN/GEg8HuTtMllUGUz
         XToySoeKpeNXlEo7zx2qHf8Dru4N8kaX+NmPLCSyvmzQj6p1not3Rj8TKPuxB/BtzVaN
         Dzyrs4XTeNxsTYqmCT90gCYQcG4l4Lu77dy0JuajBW89PZyh4JxmGW3jg9Zj7H++9RVS
         XhE9LitBjV0MRpImRMl1ppkEnDtivXTuKTlINsue4+BKzl/4pDafZWupS7M4Rctt29pf
         f4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746737461; x=1747342261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuNn4qXCymqY8mGLnT4Ald580/wR1S81yyedMtxxNt4=;
        b=wf7Rb54K8yexRJcNCoBA6wm66z8QRWkRzX8Nf9sswUqSqI5cnU/n9m837vlBl2uhUM
         5SAO/b0904XkDbhJPsrH0oBiJqPsf/GyqnToclcjJmN98tkwAYBlxDVH+2cCPaKSctKK
         vN6KgLekR392z8TBRpW+SYfT6nVWhGbuu/azsZf6/pM6PtEeNBQy9qhS5ssTRn8JIGQ8
         YKjUAJ1uFu6HhBULNsa1rMvTAKhPje5iHGm1vZyP2EdlG0OmdFqYM3IJSkooa3Fmpa8/
         w8SxPPq/kqG6+ZpxKLMRmKZy/rABjsG1u4+uMEJcE9nyrxtiHvZY3xW/0GcFWy5ob3mk
         SNCg==
X-Forwarded-Encrypted: i=1; AJvYcCV3z7rnKczu34LxQ3aj1Qozw/nD81eZREbQ4omcO85O0ZbwVBBY0IjgQm8u3MvTCiO9DVdJwq3iJ4EmsL7S@vger.kernel.org
X-Gm-Message-State: AOJu0YxB66Jp5UxXIamodW6tQKIJDgi2CebTZGUjkjIwGa4lxBDFuWer
	If5EcHj6tkdxZdJgb5SoE2EpSm0AUfNc/an8yEb2OZKa5BgvPCkc9Bj5Fg==
X-Gm-Gg: ASbGncuQfL94WCO9o0x6BP5Lf/h8VxoLDEmEXVpnXZ2oJOVwtz3BUjVT0cjvOpfiZ4U
	G/hLGTp41XCSt5XtVUCbFH8dBbU+enrH3/oHUieHJL53Dk2axFL814D3GqMS2EcdYVVsNXvnq+J
	Amy0QOw2D9dnkJebtbW+l8h2bD0G+KwJZiZ6qvdW1OYqSRZKC2YSXmknTjxuaOzTLHrQgEb1N9G
	O07+8GuPsaK/75xRlr6D+V1df9rY/NVRvtgu37ICye0uyioyT1hRPaPHZ+mNfLaSQxuIvx+8XIO
	los62T4VPkT0Hvpcqc5Lv52ntYNTyzP4EVHM1tVvlLsIeQs=
X-Google-Smtp-Source: AGHT+IHggmq7fFqftQDEg8jUgpd6oJYXi/ZiGKQijd62x2x+HlU4oJGWCyKLY6oDs21wzxqowTtfQQ==
X-Received: by 2002:a05:6a21:3293:b0:1f5:9208:3ad6 with SMTP id adf61e73a8af0-215abce7aacmr846084637.41.1746737460800;
        Thu, 08 May 2025 13:51:00 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a97de2sm463763b3a.175.2025.05.08.13.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 13:51:00 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 0/7] ext4: Add multi-fsblock atomic write support with bigalloc
Date: Fri,  9 May 2025 02:20:30 +0530
Message-ID: <cover.1746734745.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v3 of multi-fsblock atomic write support using bigalloc. This has
started looking into much better shape now. The major chunk of the design
changes has been kept in Patch-4 & 5.

This series can now be carefully reviewed, as all the error handling related
code paths should be properly taken care of.

v2 -> v3:
=========
1. Improved error handling at several places.
2. Further fixed some worst case journal credits estimation.
3. Added better checks in the slow path allocation loop for atomic writes.

v3 testing so far:
===============
- This has survived "quick" & "auto" group testing with bigalloc on x86 and Power.
- We have also tested atomic write related tests using fio and some data integrity
  tests with sudden power off during writes on scsi_debug module.
  (Will clean up these tests and try to post them out soon!)

Appreciate any review comments / feedback!


v1 -> v2:
==========
1. Handled review comments from Ojaswin to optimize the ext4_map_block() calls
   in ext4_iomap_alloc().
2. Fixed the journal credits calculation for both:
	- during block allocation in ext4_iomap_alloc()
	- during dio completion in ->end_io callback.
   Earlier we were starting multiple txns in ->end_io callback for unwritten to
   written conversion. But since in case of atomic writes, we want a single jbd2
   txn, hence made the necessary changes there.
[v2]: https://lore.kernel.org/linux-ext4/cover.1745987268.git.ritesh.list@gmail.com/

Ritesh Harjani (IBM) (7):
  ext4: Document an edge case for overwrites
  ext4: Check if inode uses extents in ext4_inode_can_atomic_write()
  ext4: Make ext4_meta_trans_blocks() non-static for later use
  ext4: Add support for EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS
  ext4: Add multi-fsblock atomic write support with bigalloc
  ext4: Enable support for ext4 multi-fsblock atomic write using bigalloc
  ext4: Add atomic block write documentation

 .../filesystems/ext4/atomic_writes.rst        | 208 +++++++++++++
 Documentation/filesystems/ext4/overview.rst   |   1 +
 fs/ext4/ext4.h                                |  26 +-
 fs/ext4/extents.c                             |  99 ++++++
 fs/ext4/file.c                                |   7 +-
 fs/ext4/inode.c                               | 291 ++++++++++++++++--
 fs/ext4/super.c                               |   7 +-
 7 files changed, 614 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/filesystems/ext4/atomic_writes.rst

--
2.49.0


