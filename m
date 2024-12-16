Return-Path: <linux-fsdevel+bounces-37488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCBE9F3120
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 14:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F67A1672A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 13:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790B22054E6;
	Mon, 16 Dec 2024 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBjH+BKT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6DD148FF2;
	Mon, 16 Dec 2024 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734354373; cv=none; b=MaFBcj7k5bJeQKne9Uz6atOyr05GMUOl7AwkPZV4ARXydKqmmw88ACjEGYrO4IjeOMVKK7DgDzQh+gGhe/peHbzFL5JvgiWViiyMSC1B+2qF9QkixH6RtND3UOINeqVvaFfEH7vysi+7eZn3/8wnfd+VsXad2HvEEg/vVF+Zaec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734354373; c=relaxed/simple;
	bh=G/EQEYbUfUgX/9g/yHsd/XHy/gtv4Foso0ip+uBh+w0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LYmngaRBkmJ+qaOLyRl56fYnWEBwbVHgae/qpZMFl0ykS441XcG3Sh14FlWut2i+YxBAJEqOSR8JzGheNe2jLx5ulXw0Uh2arXMCAHJeOvGj0nLU7rp5VM5bEdl9p375Z46wyrXr0/SNUrlafcS63v6bOEc8Qhm+y4vd7IyG/zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBjH+BKT; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-728f1e66418so3368827b3a.2;
        Mon, 16 Dec 2024 05:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734354371; x=1734959171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1SX+7nbs2g55Edy9flsjRts3hUfytEg5mqt0hNP8CQw=;
        b=DBjH+BKTj4cJCTcr4+PYy8+BUB0eVbdKA28MLk4V8Fxhe6HL+0shyy5KZUWIZlbD0N
         XwsIBWemaOcLeXAGaGdxYbb6sa+9iy69GPvRY8Cq6OudNeovbod3coM5aY0lL379NRbp
         djZL5E3wWRNn41Z8NH5rk2S20Jptn2kGr8fLSAYKUc/uipTAmogaYxA2TklEyTd2o6rl
         UDLyBM7LLBk4ALYpnIfX4Y9wz/nFsNsV3DEVnkmdNmkfcyKPVZj+rYvCZ4RlbMueZSnq
         s6yfKY4PPf8gyDx9okKdMzmi+uKiYTkwv+AeQAzLJCxltJEdJSQ7eOJ5WadL1ECg718I
         di7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734354371; x=1734959171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SX+7nbs2g55Edy9flsjRts3hUfytEg5mqt0hNP8CQw=;
        b=BXpmrDof8SRculMPbRb8cb1YN000GuBEQNPUI5LF1TjMwf9NxJaGr71i1wV4mFG9xn
         LbuSgkuXpYETthVMokgFYhQFzcOYyqroz0Xaz4cBN7r5hDk32qc9ybQKgeyd5RFO7zPe
         lbBAnd3EEwM65DsBZ/CvU32fhMYF2hmnFPwvQOTnyK2YJIK8B9i1LrZJ0r67uuWXgDsK
         sV0oANcaJA6kIZTu1iwN8MXIFtjhl+pS5wqTWsLHO0oRcSIB6UzxvQs9Ex5Ry8zdj+5H
         j+hk/mtHK53AtFtzfqHXuy37HAer0PilQi1garikGdyHLFAjtbSCBO8aQBOf0WA7ZcZV
         PxFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhrClCt1pEB+tYh9a2WMtaZ6/qOF6p64xmzfL5IQ+IqmnrPDKNjyDW4EWIt5NrEmLPpHHyrdOPdIe3@vger.kernel.org, AJvYcCWzXGimmHs+ZbzZOgvPoDoJN37Cf62q5jyBcqk0LQjaPgB3JRrKqX35+rTXiGWTAgRjBo2iH9NgQ6U5wGju@vger.kernel.org, AJvYcCXfLyRmT7jZeox+N4H0TnUYXcnJpk1Eicu/5wJk1weKEeSFWWFenR9Qzm1LpgrmPph5nwJ77UdZgNfDdrM8@vger.kernel.org
X-Gm-Message-State: AOJu0YylwYjSwEP38sqVGfrCCZyrkU08l1YiNUXDQ9XkqhFwUTDvOJys
	05aGwo0BFS6K6TXP3r0FMeiS6/eD1EFmtQCBNvzf1mRRVuNWUJZR
X-Gm-Gg: ASbGncut8u2F7s8/qZJyZjFECQKsE82a6TiwFs/aALpa72ASzPiVl8/UubaKnzoC+y8
	0TvCwYEgl+D5MGZNHhjRyBLYqvlKlQfk7Bop1iGqQiGlmnSrUg48gVqDGNcRIpWzHLCQta9MDPt
	/03eoidSQoAZj1X/W4RLAa1/D3TRFvPl39Tf0J/RecsrbA1nirUp4T+7f9TSj+kJep7BAtOOEER
	iUDU8SdzNqUxo8pg07spsFn9nDp2FEkyhZ+6i6ynjswGiL5ut4y+MkWc/xXuhyx7iWHllHJzYkQ
	Y4U5pQQoivBbrlE=
X-Google-Smtp-Source: AGHT+IH+pBcjAJH0pqyQxgHVWhxXpenm4h4zuwazwELyxvBmztTQq6aG1CctSDjXMJu15RpcJqatHg==
X-Received: by 2002:a05:6a20:1591:b0:1db:ebf4:2cb8 with SMTP id adf61e73a8af0-1e1dfe30c95mr16521282637.38.1734354371141;
        Mon, 16 Dec 2024 05:06:11 -0800 (PST)
Received: from localhost.localdomain ([180.101.244.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad5ad0sm4651803b3a.56.2024.12.16.05.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 05:06:10 -0800 (PST)
From: Tianxiang Peng <luminosity1999@gmail.com>
X-Google-Original-From: Tianxiang Peng <txpeng@tencent.com>
To: chandan.babu@oracle.com,
	djwong@kernel.org,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	brauner@kernel.org,
	dchinner@redhat.com
Cc: Tianxiang Peng <txpeng@tencent.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	allexjlzheng@tencent.com,
	flyingpeng@tencent.com
Subject: [PATCH 0/2] xfs: make cluster size tunnable for sparse allocation
Date: Mon, 16 Dec 2024 21:05:47 +0800
Message-ID: <20241216130551.811305-1-txpeng@tencent.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series makes inode cluster size a tunnable parameter in
mkfs.xfs when sparse allocation is enabled, and also makes xfs use
inode cluster size directly from the superblock read in rather than
recalculate itself and verify.

Under extreme fragmentation situations, even inode sparse allocation
may fail with current default inode cluster size i.e. 8192 bytes. Such
situations may come from the PUNCH_HOLE fallocation which is used by
some applications, for example MySQL innodb page compression. With xfs
of 4K blocksize, MySQL may write out 16K buffer with direct I/O(which
immediately triggers block allocation) then try to compress the 16K
buffer to <4K. If the compression succeeds, MySQL will punch out the
latter 12K, leave only the first 4K allocated:
	after write 16k buffer: OOOO
	after punch latter 12K: OXXX
where O means page with block allocated, X means page without.

Such feature saves disk space(the 12K freed by punching can be used
by others), but also makes the filesystem much more fragmented.
Considering xfs has no automatic defragmentation mechanism, in the
most extreme cases, there will be only 1-3 physically continuous
blocks finally avaliable.

For data block allocation, such fragmentation is not a problem, as
physical continuation is not always required. But inode chunk
allocation requires so. Even for sparse allocation, physical
continuation has also to be guaranteed in a way. Currently this
value is calculated from a scaled inode cluster size. In xfs, inodes
are manipulated(e.g. read in, logged, written back) in cluster, and
the size of that cluster is just the inode cluster size. Sparse
allocation unit currently is calculated from that:
	(inode size / MIN_INODE_SIZE) * inode cluster size
		-> sparse allocation aligmnet
			-> sparse allocation unit
For example, under default mkfs configuration(i.e. crc and sparse
allocation enabled, 4K blocksize), inode size is 512 bytes(2 times
of MIN_INODE_SIZE=256 bytes), then sparse allocation unit will be
2 * current inode cluster size(8192 bytes) = 16384 bytes, that is
4 blocks. As we mentioned above, under extreme fragmentation, the
filesystem may be full of 1-3 physically continuous blocks but can
never find one of 4, so even sparese allocation will also fail. If
we know application will easily create such fragmentation, then we
had better have a way to loose sparse allocation requirement manually.

This patch series achieves that by making the source of sparse
allocation unit, inode cluster size a tunnable parameter. When
sparse allocation enabled, make that size tunnable in mkfs. As xfs
itself currently recalculate and verify related value, change xfs
behavior to directly using the value provided by superblock read in.

Tianxiang Peng (2):
  xfs: calculate cluster_size_raw from sb when sparse alloc enabled
  mkfs: make cluster size tunnable when sparse alloc enabled

 fs/xfs/libxfs/xfs_ialloc.c | 35 ++++++++++++++++++++++-------------
 fs/xfs/xfs_mount.c         | 12 ++++++------
 mkfs/xfs_mkfs.c            | 34 +++++++++++++++++++++++++++++-----
 3 files changed, 57 insertions(+), 24 deletions(-)

-- 
2.43.5


