Return-Path: <linux-fsdevel+bounces-48647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58564AB1B24
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 19:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D345080A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 17:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EF7238D2B;
	Fri,  9 May 2025 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVre9uNT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A164A18DB01;
	Fri,  9 May 2025 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810041; cv=none; b=RVtGMEy4XqyucNOnfm680MhhVxuZ4YLLSJGoJ0y57hDUfVE8AJMgOa53kLs9xgj6iybdoMR50m5MT1Zs77okEqpzXd3ZzqBeJrTlyttxWrZuxzFfj5xE74wEfJLOB9yGiFgZqoC1mLBDOEvFWqRQgxpviYUZamJg9vuMdZzm6Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810041; c=relaxed/simple;
	bh=iPkQ+ecjDOtXEZ3Zpsc2iAj7hmoA21GF7Dx7dVZUYjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fp5hhRtCHYTC7K+H05GKTJEQlDzG9kFmQLtc0+pr3v3VRCcrSAOEKTP8r/2H025l8O1rXS+JSJTDuKHpHBvd2ohZG4UNnJsVkL1TzKG74QoDgfE/riTpFrZG0ntmt/psb4HoHADB+nF3aoKdZf/fHRmdHQTgA/oPc75eeVtvT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVre9uNT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so25956095e9.3;
        Fri, 09 May 2025 10:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746810038; x=1747414838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAVKoix/cndXPJw98uEZedanCP215D5wDUnhJjpQjGM=;
        b=bVre9uNT8nfVrtiVrNUIuW63ddqFTWrbfSka7k4caHfVdI02RW7HGRrG8YLE5McByU
         8hGGmzpSQi4ZSoWS7eIjNPWj9Kmm6buzXZJ6Jwc1wsMy12Sm691kEMMnb0GDwzufuWvH
         4q5zpzxUwCCsXlQMPZHUtt3NWp16K+WlUrKoqc36Qx83jHSUeYd1QfbAnjGn77e7UfRp
         4pHNT6VpVBDBwYVAvd3IIUTQOLx9UFcmrNMJvhiC1AGRdQWmbH0kkiKBswloY5ZXiTge
         AgyjO/ka6TvOeIxWM7jxmB75iyJcLhuklhm+Ol/Dqq2Pxa9ZTpufTU5Q6rM1UbGD0jx0
         Ix/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746810038; x=1747414838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAVKoix/cndXPJw98uEZedanCP215D5wDUnhJjpQjGM=;
        b=bhIsR4Q6JEYYIsBQWZhgsvzUg5hGdDs05+LzwCxdVD22q9IiR3Bf7ZlmR6SFdvtraA
         8PIIyvcSq/axxKNeMFyNnyMq/VYFhpuBQ6W8fWI2EEE7C+eWGkHONarF9xvTEti2oflL
         AR5h2qs0o8aVm7i0rwBLqeRTrQTBGjy1eDDVDDQ9pOC6h3JM+XneU+sM2f9u2BoWiM2J
         aG/3vtY4irRoe5WnGPxaJIc3YzWN/mjRzH4c8QdqpLCncNTEx9B5qbwUqS7+l9CinKgO
         QjSymMfNXtoLh2awSYyOqnqs22KeNvu+8LcN9eCyUYAmUBwgbx2LT9xxLlyEBLVH8SA1
         kJ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWInurnC+RlWHK7OQpYlfm8GEuFVuAlcRkWn8OfD/o752nVlBuvGpm0QrLgBQm36NP4Yk84gU6ZsR6sAlZEGg==@vger.kernel.org, AJvYcCWUHl6x+GxO65V5ZHczjszFL0N1e6ugrteITNp9ExxquM5YKvrHC6DMEs1bvR0sW4GVcXDImhhg@vger.kernel.org
X-Gm-Message-State: AOJu0YzBZR+9Sz/koeT80H+jK2uyipGsQDIsb0A/8qxKDi1iuKJAJnuX
	LDzUqqQkzNcLliPkSvRAvbJobFf7szHropbTqWJnlYMe5+XUryvx
X-Gm-Gg: ASbGncuHTU1SejTYXy7Z4MaiYU5onnwl3ulyo1zmKSm6lY2gKjcxXH2DryHQ7PwX1jz
	bglLmuY4KWFs5Z4w1sX886vX11BshOo2eEooA9Z0FQ369RCjr81jbzkp4q6SyicMhkuSlbzlUco
	HeyCrWw2CatCBgJBiVQ0LMMrATLXutq0Bdci5nJO4Kr6kCbclTxNmrEJVu0T5HeQVbxHP9fXtGe
	s1tVkaCpEUoyzNNuisnOxPqLbwOfFLPP6glB6bQyvHYY/2MTIdWguEBOsdGWntQ/f3GCtt2Ht8/
	BixrQe9Ngdw54AQ1Olh+SXV7EON/FD7PrLCsA/vwhjo67cMB/53/EDtJ6fEBRywCFDE+4gfm3WJ
	fPM1bjiMiB7c7I9YBJ3hUYRfAGSlyU51DnhdgNSvPfmdNcdeS
X-Google-Smtp-Source: AGHT+IGNFnkbzgtBaeriOgL6J6+3z6Dx+GvTBMqJFMEXrMybGif0JeyppcT1BLcbmOlnGoegr78Buw==
X-Received: by 2002:a05:600c:3e08:b0:442:dcdc:41c8 with SMTP id 5b1f17b1804b1-442dcdc420amr1087285e9.19.1746810037615;
        Fri, 09 May 2025 10:00:37 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3b7d2bsm78469245e9.36.2025.05.09.10.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 10:00:37 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] open_by_handle: add a test for connectable file handles
Date: Fri,  9 May 2025 19:00:33 +0200
Message-Id: <20250509170033.538130-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509170033.538130-1-amir73il@gmail.com>
References: <20250509170033.538130-1-amir73il@gmail.com>
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
 tests/generic/777.out |  5 ++++
 2 files changed, 75 insertions(+)
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
index 00000000..c0617681
--- /dev/null
+++ b/tests/generic/777.out
@@ -0,0 +1,5 @@
+QA output created by 777
+test_file_handles after cycle mount
+test_file_handles after rename parent
+test_file_handles after rename grandparent
+test_file_handles after move to new parent
-- 
2.34.1


