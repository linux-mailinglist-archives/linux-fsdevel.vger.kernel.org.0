Return-Path: <linux-fsdevel+bounces-56408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0355B17156
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7906A7A9057
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B6A239E86;
	Thu, 31 Jul 2025 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlSCoFXO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E8C208CA;
	Thu, 31 Jul 2025 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753965372; cv=none; b=isVDyiZF+gnQLRJythA7O2urGJXz0OPSyLXZ4RrPNFcDcPTMcrtYns1gPPu3ztAB/Wvu9ecOtuex9PfX5TAoM5S6m9XK80lYOtm3fh6abSBTr6CqKkLkY5hTfkM9tSX8qKgF2x57rpfMQea8Pi+QvZm3pTjyJbmDFHCuzcy//vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753965372; c=relaxed/simple;
	bh=2sKQ7zGiP1fWhhQs9dtMi8Y2XcZPKOcGmEE/KwYWB4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXU0EEa7ZVDqkFqkyBcskUR+1SbpgK4cAPExDiSH+nhjbXKI9P2naoCj+KpTPNCMIfwtZka9RDmTlQH4Mi1F8v6TJSdBI/zKT//UgphWxlTLyon3zYUraY2J0iM2pWz83+GjUAl4UeCy7DNeN6D2B+L1HsbUohQ80MRBQpdcnLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlSCoFXO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-769a21bd4d5so344507b3a.0;
        Thu, 31 Jul 2025 05:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753965370; x=1754570170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siK6qYT/BzYO6bFUr8CySnhWmI/+PQjMjfrdUUdh684=;
        b=UlSCoFXOFdnmBWqSAmXrBdIYLkk4AZEj8kKPrUQM7sXCyGD+1ybiQM3tdKCXnToVc/
         t9naon9G7b59/xPZsDkvX6SACwZM+zStvHuwmyzBwf6THXaZre3IMavDj/rr1n77JPx5
         61iSvAZBs9xdOG5vncS0DCabSIAM6LnfutcNbVkDN7Qp2pSbRRSwe46ECtrOKMTkTjxG
         aaQAX4WPgrMakbVa10GQsQ2PtDipJjrDPKUOh66t/0U1zWv7UyiU1kHaMOsmO4Iqhett
         omQzY9B67vX4uF5I1jtbLxXJlTco12gKM/ub45vDGXyecfYM98X5trvkigCpKIBWe1gH
         FZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753965370; x=1754570170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siK6qYT/BzYO6bFUr8CySnhWmI/+PQjMjfrdUUdh684=;
        b=uHg63AfOyQMJThK/7n7DAXlVv5U9kSCNWX8pDgwpso8zuP9cGW32m+VglGaiDEQkRQ
         0xP1T/mooQ/+ghAxaOuoXAt88lPvjf88GllcyW8AiooUo0A54m/860Fj0Fc4+Vx7sZ0q
         i2PQQJJAhtXcZ5DQq05cmIvBFtVp954g8UyM6T+lxPcoSz7bXssO2oMTF4qxRC5cXONn
         3oel9KMxH8UOzSuGZRs7WK8PtQqolm0OqmCjt0/sofm0F3lKpaDfIEVHVIE2mezhjFL2
         c4pAUPP+tteNUpVvpJBqcNNGrnpytncHBkTqtJeshvs92AAGDgBThIJzueBDSNeDq4Mh
         iKMQ==
X-Gm-Message-State: AOJu0YzgWpqYpRWLRXvkv60kALweWUvHXY+soD8fvzqyedXOLUxqC61s
	l16koUwULMD+s/52nVZ5A6A6Bfjfd84y/buftClQk2UhqmSzEPPBD8lvyLJCkMkt
X-Gm-Gg: ASbGnct7aWQXaH2jV4NiLWLnkynLlxK5k5nDGidkX+6RuwUyHB9rvPNmkNv/k0KJmUQ
	tuif31xKd7L3hyLDYEijGgNLZCd6dSBUzyRoLhfihZBGq7HBSMIEeSn94RgelqTe7YBEHQ7akOm
	sGySfZ5Bw5xU504LgzgPsaS/V2hu7hZj4Y74467rrndGJSkXpYrjCKoUr9GD+IcEauNq1tF76hl
	9L3JjRsqO5xAqCVf+P+NSS/lB6jSyX3bb96KdAzXwsjou/SQ6aAUP83xdWED+XzpTdC72OzsIJQ
	R/fn81nwkEG7rzdw+CwDn+b+Ftiz9cFJvtWnqVjyQmyb8qu+wsB+8z+whJvvWmmSeNR+0q2Ei3C
	i7aCShEEnrqZFybc5YNqZ7G0biYJJ
X-Google-Smtp-Source: AGHT+IHjy02xFArT4HymvONwq8PTP5mJd+hT33JQXK8hVkPzy0Sr0tU6f8DlT2klpiBKvU8Ml+Fjsg==
X-Received: by 2002:a05:6a00:3a15:b0:732:2484:e0ce with SMTP id d2e1a72fcca58-76ab309af3cmr9212790b3a.17.1753965369474;
        Thu, 31 Jul 2025 05:36:09 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd0e78sm1510625b3a.99.2025.07.31.05.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:36:08 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	"Darrick J . Wong" <djwong@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 2/2] generic: Add integrity tests for O_DSYNC and RWF_DSYNC writes
Date: Thu, 31 Jul 2025 18:05:55 +0530
Message-ID: <9b2427b42e8716c359a36624fd6363f71583941b.1753964363.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <28abb8a0c4031ce07b475bf9026eedc23892868b.1753964363.git.ritesh.list@gmail.com>
References: <28abb8a0c4031ce07b475bf9026eedc23892868b.1753964363.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test verifies the data & required metadata (e.g. inode i_size for extending
writes) integrity when using O_DSYNC and RWF_DSYNC during writes operations,
across buffered-io, aio-dio and dio, in the event of a sudden filesystem
shutdown after write completion.

Man page of open says that -
O_DSYNC provides synchronized I/O data integrity completion, meaning
write operations will flush data to the underlying hardware, but will
only flush metadata updates that are required to allow a subsequent read
operation to complete successfully.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tests/generic/737     | 30 +++++++++++++++++++++++++++++-
 tests/generic/737.out | 21 +++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/tests/generic/737 b/tests/generic/737
index 99ca1f39..0f27c82b 100755
--- a/tests/generic/737
+++ b/tests/generic/737
@@ -4,7 +4,8 @@
 #
 # FS QA Test No. 737
 #
-# Integrity test for O_SYNC with buff-io, dio, aio-dio with sudden shutdown.
+# Integrity test for O_[D]SYNC and/or RWF_DSYNC with buff-io, dio, aio-dio with
+# sudden shutdown.
 # Based on a testcase reported by Gao Xiang <hsiangkao@linux.alibaba.com>
 #

@@ -21,6 +22,15 @@ _require_aiodio aio-dio-write-verify
 _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount

+echo "T-0: Create a 1M file using buff-io & RWF_DSYNC"
+$XFS_IO_PROG -f -c "pwrite -V 1 -D -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t1 > /dev/null 2>&1
+echo "T-0: Shutdown the fs suddenly"
+_scratch_shutdown
+echo "T-0: Cycle mount"
+_scratch_cycle_mount
+echo "T-0: File contents after cycle mount"
+_hexdump $SCRATCH_MNT/testfile.t1
+
 echo "T-1: Create a 1M file using buff-io & O_SYNC"
 $XFS_IO_PROG -fs -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t1 > /dev/null 2>&1
 echo "T-1: Shutdown the fs suddenly"
@@ -48,5 +58,23 @@ _scratch_cycle_mount
 echo "T-3: File contents after cycle mount"
 _hexdump $SCRATCH_MNT/testfile.t3

+echo "T-4: Create a 1M file using DIO & RWF_DSYNC"
+$XFS_IO_PROG -fdc "pwrite -V 1 -S 0x5a -D 0 1M" $SCRATCH_MNT/testfile.t4 > /dev/null 2>&1
+echo "T-4: Shutdown the fs suddenly"
+_scratch_shutdown
+echo "T-4: Cycle mount"
+_scratch_cycle_mount
+echo "T-4: File contents after cycle mount"
+_hexdump $SCRATCH_MNT/testfile.t4
+
+echo "T-5: Create a 1M file using AIO-DIO & O_DSYNC"
+$AIO_TEST -a size=1048576 -D -N $SCRATCH_MNT/testfile.t5 > /dev/null 2>&1
+echo "T-5: Shutdown the fs suddenly"
+_scratch_shutdown
+echo "T-5: Cycle mount"
+_scratch_cycle_mount
+echo "T-5: File contents after cycle mount"
+_hexdump $SCRATCH_MNT/testfile.t5
+
 status=0
 exit
diff --git a/tests/generic/737.out b/tests/generic/737.out
index efe6ff1f..2bafeefa 100644
--- a/tests/generic/737.out
+++ b/tests/generic/737.out
@@ -1,4 +1,11 @@
 QA output created by 737
+T-0: Create a 1M file using buff-io & RWF_DSYNC
+T-0: Shutdown the fs suddenly
+T-0: Cycle mount
+T-0: File contents after cycle mount
+000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
+*
+100000
 T-1: Create a 1M file using buff-io & O_SYNC
 T-1: Shutdown the fs suddenly
 T-1: Cycle mount
@@ -20,3 +27,17 @@ T-3: File contents after cycle mount
 000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
 *
 100000
+T-4: Create a 1M file using DIO & RWF_DSYNC
+T-4: Shutdown the fs suddenly
+T-4: Cycle mount
+T-4: File contents after cycle mount
+000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
+*
+100000
+T-5: Create a 1M file using AIO-DIO & O_DSYNC
+T-5: Shutdown the fs suddenly
+T-5: Cycle mount
+T-5: File contents after cycle mount
+000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
+*
+100000
--
2.49.0


