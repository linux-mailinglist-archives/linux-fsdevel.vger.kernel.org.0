Return-Path: <linux-fsdevel+bounces-21682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8E0907EBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 00:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F181C21943
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 22:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A8614BF92;
	Thu, 13 Jun 2024 22:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bD4VJB6q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7828714B091
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317116; cv=none; b=Infi6lgKOd5vuhorcpfp7dD3gYhTF19QJEsEe4plA6Smcy3YBidL29wlyMGg+w3HP4NU5o5RSocGdGaCnzQuXyUxd8ueIcoGCEZqktkGsjy9+T9kbey1P4cGywT7nqQWlLYi3OpNsy8W6SNPD4ZXvt8CM6S3euFUSfvHXGLJJh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317116; c=relaxed/simple;
	bh=CssM57cUhLIsxQmArXR8ImI0sIHlvaAqlupSra9Xp2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=la2IKsb0Hy7VTvedy83pTDxxQsCmA7e6PbmThEXMPGQAsCzzX0CJFVV2emcgt7CS6CIhGJGoRoj0SVf9hD1dF2ewlAHtjZlu8EMpycKS3mLyy17pPH8YY2FkiQj6SIVxdbVyYyS13gDXLIeBo5PrhATKL1RI8nO/vTGAoxgXhVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bD4VJB6q; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-193.bstnma.fios.verizon.net [173.48.115.193])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45DMIQIO008360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 18:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1718317108; bh=clq9l63/IeD7KNqYI85evXaOeOupvwaMZGAqKpr1ipo=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=bD4VJB6qmRCw/ZFtzeFNu6BuEVebbs6Q5VPrOCwKC1zSD25BM64GVdWrLVqKmN1DC
	 LJgnjABwlGikuk/ddIiJ/+i/2ZyLRn4gmcy4fHwSpgjtAFSyOJW0lw+V2gCyckzKfc
	 pIT0PX1c7GM4vZbKC6IQptYZOVQRV1JorMA1jfBwxkYoizuFnuVbibNtAwTszXjxQq
	 BEgR85nv6Yxi+NApAQ+AR6KksZ0GYYRr+qJkxXWaESDT/aYjw1r1aUkBRVr/Q0LAh0
	 LWaHShsiRlbBP7N6K4PUUxso+l2xkOrxvWt2XIUzhcdp6rnw6inY1reXd6G/7qXOex
	 TGYDEcQUUaRtQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 8F84515C0579; Thu, 13 Jun 2024 18:18:26 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/2] generic/269, generic/475: disable io_uring to prevent umount EBUSY flakes
Date: Thu, 13 Jun 2024 18:18:09 -0400
Message-ID: <20240613221810.803463-1-tytso@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613215639.GE1906022@mit.edu>
References: <20240613215639.GE1906022@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is an I/O uring bug which can hold on to file references after
the userspace program exits.  This is causing tests which run fsstress
and then try to unmount the file system to fail in a flaky fashion.
Since the point of these tests is not to test io_uring, and io_uring
has remained buggy since August 2023, let's fix the problem by
disabling io_uring in fsstress for these tests.

We can add a new test which specifically (and reliably) tests for this
io_uring bug.

See the link below for more details.

Link: https://lore.kernel.org/fstests/20230831151837.qexyqjgvrllqaz26@zlang-mailbox/
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/269 | 3 +++
 tests/generic/475 | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tests/generic/269 b/tests/generic/269
index 29f453735..9be7ea9aa 100755
--- a/tests/generic/269
+++ b/tests/generic/269
@@ -13,6 +13,9 @@ _begin_fstest auto rw prealloc ioctl enospc stress
 . ./common/filter
 # Disable all sync operations to get higher load
 FSSTRESS_AVOID="$FSSTRESS_AVOID -ffsync=0 -fsync=0 -ffdatasync=0"
+# io_uring is buggy and causes "fsstress; umount" EBUSY test flakes
+FSSTRESS_AVOID="$FSSTRESS_AVOID -f uring_read=0 -f uring_write=0"
+
 _workout()
 {
 	echo ""
diff --git a/tests/generic/475 b/tests/generic/475
index abd6e89a1..3e9200771 100755
--- a/tests/generic/475
+++ b/tests/generic/475
@@ -45,6 +45,9 @@ _require_metadata_journaling $SCRATCH_DEV
 _dmerror_init
 _dmerror_mount
 
+# io_uring is buggy and causes "fsstress; umount" EBUSY test flakes
+FSSTRESS_AVOID="$FSSTRESS_AVOID -f uring_read=0 -f uring_write=0"
+
 while _soak_loop_running $((50 * TIME_FACTOR)); do
 	($FSSTRESS_PROG $FSSTRESS_AVOID -d $SCRATCH_MNT -n 999999 -p $((LOAD_FACTOR * 4)) >> $seqres.full &) \
 		> /dev/null 2>&1
-- 
2.43.0


