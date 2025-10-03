Return-Path: <linux-fsdevel+bounces-63351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 851DBBB6628
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 11:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2579719E66CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 09:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C172DEA7A;
	Fri,  3 Oct 2025 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aA1Iu6rX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D05D2DCBEB
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759484124; cv=none; b=U0QUA4iWHs9DK+Q9CG10WSnTxvO26Dk9obUIldmXyZAxOSj3htcgj4REZutBHZLGYhhkLwnE7BjToKG2VimbuyMHF2eMNfA+cDGVlkzL6yKA72c/+o5dWfnEUbF6mMmOrMXerowcc68an2wcX4ckSznUL5HXGPi8cogL862gRfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759484124; c=relaxed/simple;
	bh=4dypLPu6DNf9DAMNJyF5UXwIvayiqJK8XG4EG3pgjZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e/IXjreLVia3/JH4pAwyw+8RprIolG1fFVprmAr8X1MxD+pgHutavbwix6aHn1lXOilN4pUiOe+osQGp+yuZHwdNicIBU817z5qMlEGh5ntaa4dE/c1m8Vs0Tv6Mgr2ud7xReaRe+OgV4ayYRgGDbfifo/guvWgqPyl2/7SSk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aA1Iu6rX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759484121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GpNh9Npv8ACuKwnSClKnKFFRR5xgF6p+DJW3Gcbr8Pk=;
	b=aA1Iu6rXsXIxeM/lbfEpPHURq8rZWBdM9/S2MePv/d6tyPrKyll43biWMhxGxSjE39TtUI
	4bnoKhHq/8GyeZxqBXTve7BWx3R+s4Z9EozkX7gV1RIpPe1esuslP2HejDrcoyktY3t/be
	heLdV7ibSxtIsol3VYJXGCknhauAi4A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-GFzRUYXQNB-4EAQGnosfMw-1; Fri, 03 Oct 2025 05:35:20 -0400
X-MC-Unique: GFzRUYXQNB-4EAQGnosfMw-1
X-Mimecast-MFC-AGG-ID: GFzRUYXQNB-4EAQGnosfMw_1759484119
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e3ef2dd66so11561105e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 02:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759484118; x=1760088918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpNh9Npv8ACuKwnSClKnKFFRR5xgF6p+DJW3Gcbr8Pk=;
        b=EkIOR3wnmrfJ11GjYYG7h7bXTYDrotCYRpA4el4ZmSIQKitcIgujLKxB7vhkf0oFT9
         K6V7w9oVzFQhrD/TWU8k4UmEiKj6/b/blxBzm6/cE8BPWhk3uFIcefAvABH+nmmOc54A
         cufhemplDjfeI7WurGLtEIIe9jx8bZ5+7LNphTGP8d5EC4M+voIYiCCXYb9idlbLGjfZ
         zMj4SxEz0rxEMsM3oTx1gwE4+8iYvc6LvvdnUbBess+5eyouefESI2viYkiV19l0RDD1
         UuwjphGf1jS53ka0gn85A6mgnPQX5fUpdkXX/7ARFxGADU6I4HgI+XlyZiUT3nhgqUjk
         YL/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSwNe8ilT0vo5E9Yz7kausCwksL2tnLpnzN0tEyvBo0Q0YAYjK6Go+YFYMR+2HOXdLYCc0RrUQ9XwlpY3z@vger.kernel.org
X-Gm-Message-State: AOJu0YzusXDEAR6GpvAL4DBg0YMCPLjTCtbei7lwGORkuxtXggOnSAh0
	3wAAjYIkSuYOrlCs753oSMXraf3JJq33kYRi8owcV3QnWALnayZos91kC0JEuMK3GVrjhUVX6NM
	Odyvsunli2BVKicmHdz0qhe6y+o50atsU5b9BgyxBrTs3hIy9qBj/nP9pqYJD0DSZofUxyobBFw
	==
X-Gm-Gg: ASbGncvqlDXUND6ftv66y6u/olZTq62hz973Jik1GHeCTeNdYFt6BEBtzB7f+noLmFr
	FmkDH4tiz82VCOZLFJQ1lhPxmNwaNb02toXUSpwsDEaNbF+lFGOrSNe249vePgNFd0S392zUho+
	ZVa8zVN0QmWJGiHI3nhTWDpTGgAw/S5xzxEz6+h2WNxmFVy75YaSd72/i5NpnkSajOvRSBWGvze
	IFQF5oiG12Jo7cR9OXe4EtPY5J+R7oEqBUDClqLoVmM/+zRPeCDV9VBZrl9Z2IJuBsJN8E2VbPj
	557dS9Q/PSBvEst0uRNIfXAPxHX/2de8kFPYPw9g6nraz+tccKFqKiDwdAa4pJ4Xy4qcTWb3
X-Received: by 2002:a05:600c:3e86:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-46e70c9bfc4mr17218285e9.11.1759484117793;
        Fri, 03 Oct 2025 02:35:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHaVK2zkQzqZL+45iS+eowvlr1TZYdXk2TM+UdvH8rZKcjeAYKqZl5Bkkez7g33XvcXMDW1g==
X-Received: by 2002:a05:600c:3e86:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-46e70c9bfc4mr17218095e9.11.1759484117313;
        Fri, 03 Oct 2025 02:35:17 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a020a3sm121695005e9.10.2025.10.03.02.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:35:16 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Fri, 03 Oct 2025 11:32:46 +0200
Subject: [PATCH v4 3/3] xfs: test quota's project ID on special files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-xattrat-syscall-v4-3-1cfe6411c05f@kernel.org>
References: <20251003-xattrat-syscall-v4-0-1cfe6411c05f@kernel.org>
In-Reply-To: <20251003-xattrat-syscall-v4-0-1cfe6411c05f@kernel.org>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>, 
 Andrey Albershteyn <aalbersh@redhat.com>, 
 "Darrick J. Wong" <djwong@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4010; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=NFXZJCDM6gddTTqUPtjzyqiRjXXUpTibfg7JUhy4vGI=;
 b=kA0DAAoWRqfqGKwz4QgByyZiAGjfmNGjEfRawp+TuEJCq7YK7NXEttgOFnnnI1oUi99RCp/hT
 Yh1BAAWCgAdFiEErhsqlWJyGm/EMHwfRqfqGKwz4QgFAmjfmNEACgkQRqfqGKwz4Qh9xwD+Nm5y
 0G9xcswpBLFUaAWc9n3mCZRuVoP0DyYJ85y/y54A/0d7ACTsygBK/TxnCKuH2DYoGTH5aol4X5z
 KDx/agcYH
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

With addition of file_getattr() and file_setattr(), xfs_quota now can
set project ID on filesystem inodes behind special files. Previously,
quota reporting didn't count inodes of special files created before
project initialization. Only new inodes had project ID set.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/xfs/2000     | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/2000.out | 15 +++++++++++
 2 files changed, 88 insertions(+)

diff --git a/tests/xfs/2000 b/tests/xfs/2000
new file mode 100755
index 000000000000..413022dd5d8a
--- /dev/null
+++ b/tests/xfs/2000
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Red Hat.  All Rights Reserved.
+#
+# FS QA Test No. 2000
+#
+# Test that XFS can set quota project ID on special files
+#
+. ./common/preamble
+_begin_fstest auto quota
+
+# Import common functions.
+. ./common/quota
+. ./common/filter
+
+# Modify as appropriate.
+_require_scratch
+_require_xfs_quota
+_require_test_program "af_unix"
+_require_test_program "file_attr"
+_require_symlinks
+_require_mknod
+
+_scratch_mkfs >>$seqres.full 2>&1
+_qmount_option "pquota"
+_scratch_mount
+
+create_af_unix () {
+	$here/src/af_unix $* || echo af_unix failed
+}
+
+filter_quota() {
+	_filter_quota | sed "s~$tmp.projects~PROJECTS_FILE~"
+}
+
+projectdir=$SCRATCH_MNT/prj
+id=42
+
+mkdir $projectdir
+mkfifo $projectdir/fifo
+mknod $projectdir/chardev c 1 1
+mknod $projectdir/blockdev b 1 1
+create_af_unix $projectdir/socket
+touch $projectdir/foo
+ln -s $projectdir/foo $projectdir/symlink
+touch $projectdir/bar
+ln -s $projectdir/bar $projectdir/broken-symlink
+rm -f $projectdir/bar
+
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "limit -p isoft=20 ihard=20 $id " $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "project -cp $projectdir $id" $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "report -inN -p" $SCRATCH_DEV | _filter_project_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "project -Cp $projectdir $id" $SCRATCH_DEV | filter_quota
+
+# Let's check that we can recreate the project (flags were cleared out)
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "limit -p isoft=20 ihard=20 $id " $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "report -inN -p" $SCRATCH_DEV | _filter_project_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "project -Cp $projectdir $id" $SCRATCH_DEV | filter_quota
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/2000.out b/tests/xfs/2000.out
new file mode 100644
index 000000000000..e53ceb959775
--- /dev/null
+++ b/tests/xfs/2000.out
@@ -0,0 +1,15 @@
+QA output created by 2000
+Setting up project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
+Checking project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
+#42 8 20 20 00 [--------]
+
+Clearing project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
+Setting up project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
+#42 8 20 20 00 [--------]
+
+Clearing project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).

-- 
2.50.1


