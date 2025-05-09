Return-Path: <linux-fsdevel+bounces-48649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C04AB1B3D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 19:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC2B189C77B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 17:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2A523816F;
	Fri,  9 May 2025 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIxkQsK8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0162356C9;
	Fri,  9 May 2025 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810304; cv=none; b=FxhqkRN8xdGUMHUwmlozUqVQjMtVWYVctKYyXtZKGZiJg1CfJzAoFLUAzOBPHpeYr7CunVkC5ExR1iLld0ZygDe6agdScxgJSpCzNly1efYThUb8fLiHy23lYC6bNIMuUu26cLYr/zMmfUtHZInbK8I8cCzS+cyB/PgtP+YpGVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810304; c=relaxed/simple;
	bh=8tW+WuS1p5FHuL3ccTwj5DVOuzBg2D5n++L5sVCUNWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VblDKRGHHD+gkqyQ7zGtD0lTmmww6nLR4394F+Kt5AfjIAu3Wo9UFVAtl67fPZISRjc+SMCbaHBbPxRHpJvKt0xtYmAPRZI1EiXG9+F5Ivx95GtlX6EuZsfKVCs0wXGlaytPFiY/FUmQ2F24+BvHBcz/LE1VkjkHN3puC4DewR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIxkQsK8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a0b291093fso2164253f8f.0;
        Fri, 09 May 2025 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746810300; x=1747415100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mqSUkN2e/EmFg95ho5ANyLZCoYV4Bj2CBTrvqkkXVwc=;
        b=PIxkQsK8vIWdoad9mZYOu0mbd+z4xV8d2jn4Z+Q44EofG4KFSvSU2SDM9f8IuS21wz
         qV54hTT6J6rWht9IxvZOVj58PLMQkqjgDd5q0GNLfXpqHsODo7lwhSt8VlOyhdDQ1Q6q
         tLNRgpoUtTm3yUE+vnrxbfRn/OTYIF5e5FidkV0d1B3S2dgriO8KPseApd3DIhLfWTtN
         AlCu0D/0NA2cc7GGUHV3HiP2K+XeFCETxn6ndPAObHvNzAqEQQNsH0uxqEmfNtuj+Lyn
         FtipLr8oFfimwoS9gyozX9U/bHhpS2EJK1RdfRRQoECgC9n4V9tm2EnWRubXB054UWDQ
         wAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746810300; x=1747415100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqSUkN2e/EmFg95ho5ANyLZCoYV4Bj2CBTrvqkkXVwc=;
        b=nyPtmmVz/O5q4KJ/L8Mg9pD+lhcvxi+JaMZVd4dN4NRwA+hDJHV3BzZsZ9X6/p1mss
         3LfRxVDgWdXk/d8eT5B/niN9bG7vC0HWSyE5NHrioKonT9j482DQkSTm8CB072oKUHew
         gf6LmMo0jXpeNNlY8LOaFXLLpwiHBoaDjzZPqmTJVx69RZK2hH8A6ZFLEJZRnUAIXkZ6
         2FiI0vQVQTRIo09iRUdLqrLNTPWw2nbAOAz8A9NW6XcmwxpGgOhPon8AalZkQaoPnt9o
         dvjkOds9lvbya5HMp0+jt0rILKFLdNMShUDJgd5dEVArRj6TL8SHJtW3E9CaBMdjbHJf
         j0BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjvYAZrP67r0gHjxIZlMcqCbYq2AhsNkuXpE71dmsEnyDxuhHmLj8BYY0ULaOXEVEzWxenFUMD@vger.kernel.org, AJvYcCVNRuLgDMxWay9jhcDcFaZ/5zwjmYCHIfPUgaL+yCw0h/mHTfiqqe5Aapotfp1Oc3rZj644QiYA8a2BAvZsUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzjzsGYQZhCyU/anteFjGsJaxqPeJqddLb/JlM/osaqOEYiTy6
	8z0euHTZwlQe68nQL52lyohz71IrLyVyjxOF6JksiX3OpgiocZUB
X-Gm-Gg: ASbGnctULpJXV5PttJ1mIAxOa/Fi8AQkvi4G0Ko8srQSkewyJxjJIGFyGSZyLPxK/qU
	Tb3LON1qPNeOnofKP1KunYTJzTsuOfEN5o/gMxqCHeUkvBD+JqSO28laVYp6mhAXu1optWV2bW+
	rNvBHQ0QnF/NEULpya5OziVf453ZdAqVOcE/Z6dnKxF656d6zDaPEYavUiqNiUa1x227EfWrfGk
	zDyEfbK0I7mBW7vjYP+1SuRSF/sgqQlWFw+4uZ3TdOmfKJG44use1g/MVD5eBTlH1D44pFfc5BV
	jFaWY5sdk5w3JfgONvKilF7raaqdjVHUKUoWB6I+QPJwz4Qg18qBDogRegrZgXmi9PePvzmKczy
	Wi+kytRRxsviBjfrAqPGJTYc150QbXHjAq3c8fA==
X-Google-Smtp-Source: AGHT+IGSHvQRpcyScWvopVlTgV8BNEm0pDp9ltDuZKynvfwB5OPlM1MHWlCOB67AD0cm7FPg8YjvIg==
X-Received: by 2002:a05:6000:1789:b0:3a0:8c01:d463 with SMTP id ffacd0b85a97d-3a1f6a1b3a7mr3063898f8f.9.1746810300189;
        Fri, 09 May 2025 10:05:00 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2ce36sm3813080f8f.71.2025.05.09.10.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 10:04:59 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH RESEND v2 2/2] open_by_handle: add a test for connectable file handles
Date: Fri,  9 May 2025 19:04:56 +0200
Message-Id: <20250509170456.538501-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a variant of generic/477 with connectable file handles.
This test uses load and store of file handles from a temp file to test
decoding connectable file handles after cycle mount and after renames.

Decoding connectable file handles after being moved to a new parent
is expected to fail on some filesystems, but not on filesystems that
do not really get unmounted in mount cycle like tmpfs, so skip this test.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/generic/777     | 70 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/777.out |  4 +++
 2 files changed, 74 insertions(+)
 create mode 100755 tests/generic/777
 create mode 100644 tests/generic/777.out

diff --git a/tests/generic/777 b/tests/generic/777
new file mode 100755
index 00000000..d8d33e55
--- /dev/null
+++ b/tests/generic/777
@@ -0,0 +1,70 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2018-2025 CTERA Networks. All Rights Reserved.
+#
+# FS QA Test No. 777
+#
+# Check open by connectable file handle after cycle mount.
+#
+# This is a variant of test 477 with connectable file handles.
+# This test uses load and store of file handles from a temp file to test
+# decoding file handles after cycle mount and after directory renames.
+# Decoding connectable file handles after being moved to a new parent
+# is expected to fail on some filesystems, but not on filesystems that
+# do not really get unmounted in mount cycle like tmpfs, so skip this test.
+#
+. ./common/preamble
+_begin_fstest auto quick exportfs
+
+# Import common functions.
+. ./common/filter
+
+
+# Modify as appropriate.
+_require_test
+# Require connectable file handles support
+_require_open_by_handle -N
+
+NUMFILES=10
+testroot=$TEST_DIR/$seq-dir
+testdir=$testroot/testdir
+
+# Create test dir and test files, encode connectable file handles and store to tmp file
+create_test_files()
+{
+	rm -rf $testdir
+	mkdir -p $testdir
+	$here/src/open_by_handle -N -cwp -o $tmp.handles_file $testdir $NUMFILES
+}
+
+# Decode connectable file handles loaded from tmp file
+test_file_handles()
+{
+	local opt=$1
+	local when=$2
+
+	echo test_file_handles after $when
+	$here/src/open_by_handle $opt -i $tmp.handles_file $TEST_DIR $NUMFILES
+}
+
+# Decode file handles of files/dir after cycle mount
+create_test_files
+_test_cycle_mount
+test_file_handles -rp "cycle mount"
+
+# Decode file handles of files/dir after rename of parent and cycle mount
+create_test_files $testdir
+rm -rf $testdir.renamed
+mv $testdir $testdir.renamed/
+_test_cycle_mount
+test_file_handles -rp "rename parent"
+
+# Decode file handles of files/dir after rename of grandparent and cycle mount
+create_test_files $testdir
+rm -rf $testroot.renamed
+mv $testroot $testroot.renamed/
+_test_cycle_mount
+test_file_handles -rp "rename grandparent"
+
+status=0
+exit
diff --git a/tests/generic/777.out b/tests/generic/777.out
new file mode 100644
index 00000000..f2dd33c3
--- /dev/null
+++ b/tests/generic/777.out
@@ -0,0 +1,4 @@
+QA output created by 777
+test_file_handles after cycle mount
+test_file_handles after rename parent
+test_file_handles after rename grandparent
-- 
2.34.1


