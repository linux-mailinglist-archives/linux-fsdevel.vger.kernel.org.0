Return-Path: <linux-fsdevel+bounces-46076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64729A82402
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 13:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43F9F445B00
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 11:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CF125DAE4;
	Wed,  9 Apr 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXHtTxZZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0962253E4;
	Wed,  9 Apr 2025 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199552; cv=none; b=qS5kYeWA1zDQCYM3ALG0u35igNWluDR0ZgjlNEQULLXqJQ1073OTXEFH/5cNtqzmP1irFVWj/qbLa6ODXtqnN5bdXSGDQk92fCKAuv5RsdKKwVqOjnm5znD1ub6EO7LJnc5JPjRMaMfFL40ebjNmGleX3eegfkpOR/ix/+CkjlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199552; c=relaxed/simple;
	bh=ygESd33qiScuVxyChUjjAcLNy4/vLGhH1b5w55FaXKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hJ9K7rVPF3I/bFko6yiqndLEOw4nt1+sQnyvzsBp4FBTktAKBFUKasxZotbCvbiBqRWrtKag3oN2ZnoIdz3eu9z4A/Ji1Rk12W8/BqrrNjkSQ++2hi0iTt2/Io2BqRL8QzZzWQtytaC0Ok7aXx/vSwu2+M+Nj30Xze08izy4cDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXHtTxZZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so70160885e9.3;
        Wed, 09 Apr 2025 04:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744199548; x=1744804348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6wjh/nu+r2sCU54t8zingNxQ096FNrWAeu6JbBkdb0=;
        b=AXHtTxZZKvzcsTh5t2x4sytkNR688TaiqepmaQPCAzzo2OY4pMDSYv+wJ/tl/f3SWV
         //0+vhxy0lBdjIJiP79LlwWCr+ZJM2uuLXDbTUmpFZvuc4pPsOdlhcTruKY1INtTZgd1
         BKq6/vm67RJkc9SBEMJ4nJUiYAEappJkONk2+Y9H9WZJBmNJxetVwADkSE+O2/2ipJV5
         dIHLLe/66Zz4sRhtaRd4kydGeqKKoH6ffcrQM0czYqC+MdCgiHsI90UQB6ayY6zsjtZC
         QhUT82T2NpEZBsahagKIXwnFr4fF5XlPuFpUR5mRBw6LJjMylY8YVwZH3VzQwnkav96N
         /7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744199548; x=1744804348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6wjh/nu+r2sCU54t8zingNxQ096FNrWAeu6JbBkdb0=;
        b=KWWQQZFEjBI5ra+uvGoJB/bS1HF7ZCqko40vVzOV+qoIYLfstGD8E9UrhjTwJTQViN
         gN4lEnj/FatX/gBh5wqWjkEnT4ryeJ5JC5TK6hYihUqVQK8ifk08Q8Ep/SCQFIslKcka
         TNfGgdcDJXo/Zu5vnoQKz7MtU8lG02fgcsfPrMAE/6Ci4Op79s7i5T2K83Yx6WaRFuA7
         Oa6xjrSwI5nLgKLGKHI3JDeKj8FdTdFb071vo6nYtXmCKm0m/DHIhCBN/N7k2KJWeB/P
         mgAmB58nU9LckfLvaQKWO08E/Jq2HZyOcLUIjZY5prKQXQ9gnebVoL7hfIGQv3zAPGES
         B13Q==
X-Forwarded-Encrypted: i=1; AJvYcCVO8Ux7NCzWikcRBP/HRcbo+cL84P8DjE2V4nGFOt/wLsZVK88wvcFoqcLHIzd1xoMsLvcnyXa3@vger.kernel.org, AJvYcCWRIcS3yJqzUHqtg8MivH0DJo9/uyODVyP+Mrkp8wwaRjRzZ1Xk0OwRgccDqzaNvzparE1NkdklXciYM4YO0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlGz5ahb0hdOWTIwivzrlu4u4y71BMtS1oX7+fv+rcpumdE9Zw
	zaw2v7LMajwKgb8YUQXnDQIs0qrekG1/MN/F6yG09dyB4aBqV8HKdpXUvlLd
X-Gm-Gg: ASbGncvkh45gFR3oFhWF45OqQcLry3I/7H50joSf82sswU7wVoOKKQ7HbuXsWUxkFnX
	buIqItowiXr1v0x1RD1oiDDdTH87CY7pokTqLKra0sVqKCXqv7mjBIXE06PO1vlCFxDUJVfeTr3
	kjzsTNj49p6HHbDI9XHSl2UlkXt6LN3EVrIRt0mTisJqa2MUoQ8qC3K7QDSX59yoF2sZljCLbu5
	AAyG99uu3J4vg/V9xY1P3bsJHwKi0/FOdldvVN7WNZQsafVaostUd/mDQp0AOI8eCMIIYO8b2BR
	TVhSZ5G7VffvOxc+rkP4iQwxe71SsqQvpZo3KMTRrM59k2vEN2o+2daOdPTLGSletMl10oKr5n/
	toYJl+WjAMpYk1Ln0Z/ykyt9lclUeUTK5LoSejw==
X-Google-Smtp-Source: AGHT+IE9kXa0WUnlU2syJlD9y6uKfF//w/hH5pkZrL3sJhouEV7EQDgCKxx2sPCYfH2HN919PpRGsA==
X-Received: by 2002:a05:600c:5787:b0:43c:f5fe:5c26 with SMTP id 5b1f17b1804b1-43f1eda3d63mr18257915e9.4.1744199548344;
        Wed, 09 Apr 2025 04:52:28 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d069sm17786815e9.17.2025.04.09.04.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 04:52:27 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] open_by_handle: add a test for connectable file handles
Date: Wed,  9 Apr 2025 13:52:20 +0200
Message-Id: <20250409115220.1911467-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409115220.1911467-1-amir73il@gmail.com>
References: <20250409115220.1911467-1-amir73il@gmail.com>
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
is expected to fail.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/generic/777     | 79 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/777.out | 15 ++++++++
 2 files changed, 94 insertions(+)
 create mode 100755 tests/generic/777
 create mode 100644 tests/generic/777.out

diff --git a/tests/generic/777 b/tests/generic/777
new file mode 100755
index 00000000..52a461c3
--- /dev/null
+++ b/tests/generic/777
@@ -0,0 +1,79 @@
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
+# is expected to fail.
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
+# Decode file handles of files/dir after move to new parent and cycle mount
+# This is expected to fail because the conectable file handle encodes the
+# old parent.
+create_test_files $testdir
+rm -rf $testdir.new
+mkdir -p $testdir.new
+mv $testdir/* $testdir.new/
+_test_cycle_mount
+test_file_handles -r "move to new parent" | _filter_test_dir
+
+status=0
+exit
diff --git a/tests/generic/777.out b/tests/generic/777.out
new file mode 100644
index 00000000..648c480c
--- /dev/null
+++ b/tests/generic/777.out
@@ -0,0 +1,15 @@
+QA output created by 777
+test_file_handles after cycle mount
+test_file_handles after rename parent
+test_file_handles after rename grandparent
+test_file_handles after move to new parent
+open_by_handle(TEST_DIR/file000000) returned 116 incorrectly on a linked file!
+open_by_handle(TEST_DIR/file000001) returned 116 incorrectly on a linked file!
+open_by_handle(TEST_DIR/file000002) returned 116 incorrectly on a linked file!
+open_by_handle(TEST_DIR/file000003) returned 116 incorrectly on a linked file!
+open_by_handle(TEST_DIR/file000004) returned 116 incorrectly on a linked file!
+open_by_handle(TEST_DIR/file000005) returned 116 incorrectly on a linked file!
+open_by_handle(TEST_DIR/file000006) returned 116 incorrectly on a linked file!
+open_by_handle(TEST_DIR/file000007) returned 116 incorrectly on a linked file!
+open_by_handle(TEST_DIR/file000008) returned 116 incorrectly on a linked file!
+open_by_handle(TEST_DIR/file000009) returned 116 incorrectly on a linked file!
-- 
2.34.1


