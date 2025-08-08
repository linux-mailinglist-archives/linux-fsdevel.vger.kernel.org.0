Return-Path: <linux-fsdevel+bounces-57133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600EEB1EEE9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7A9622B15
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 19:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B3A2882CF;
	Fri,  8 Aug 2025 19:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rwi8hDZU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1B2882AC
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754681543; cv=none; b=QeLaq9/Pi2HgvLL75//pUCsFMc/4Zkcf0EycqdrveinwSTqfnIbqobkvdtYFop3n28iDWv6122TNj0iPbi388vqgW+wQegFum79Ren7bVaolgwonunaj+tGOmVxdqenWhGwXK9fgFvABoLZJrHihPXf2mKzkXVHoYB6PRnEHaPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754681543; c=relaxed/simple;
	bh=rd0gHPs9r3n1uqaeogh6lISRfiKMIbMIwGCvZPqFvjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QWJ8ePgYM1D/o8O4irXcERYmkFFDAgv15jHp5ugBC/bpNcmJG7OFJjWK/GQOKu5BKDIrainpJCRVKk056pkn+sDRkUs20Ef9R/OYjxIriD8FblGdWVw3m4kvR49V8f8Rozt3ncZzueBxXWrR5SBHFYWTdDofGfjW9dAUQHWRGt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rwi8hDZU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754681540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4DY1Hu90O7055hYQlq+ozgQX5TkAPtJWGsG/dYblQRY=;
	b=Rwi8hDZUXb8hKN1FxkNPOre6NxASH3e8pPmEeVU4DJtZY99Z60k61BahEDSd9E/oMQh0F1
	JTlnTLTV4CKnviFg//ETsTx8vnEUia4WXQqjOrLCCRhOMS+BM+yqTv7orveNIk+3hEtBEj
	pFyNv2f4TGM6Xldf6kVm1Zhu97KZig8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-w0d9AoMiPYWjKzu5N-JItA-1; Fri, 08 Aug 2025 15:32:18 -0400
X-MC-Unique: w0d9AoMiPYWjKzu5N-JItA-1
X-Mimecast-MFC-AGG-ID: w0d9AoMiPYWjKzu5N-JItA_1754681538
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-458f710f364so16659935e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 12:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754681537; x=1755286337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DY1Hu90O7055hYQlq+ozgQX5TkAPtJWGsG/dYblQRY=;
        b=V9bUly7435J3FqvfNMLl+CNz2Vll5AyKHlsxkJVb3wdSnuJxEnLTiq9j+PRFYqH72b
         lMqfjBToeQKfJ2VRPpr+YDYxFXCT7Bx46ZST9VOY2gGHRTQfrx67PFIRGJwHiX5xlfSl
         EumBGxtY665o8rfGO1XBj0qDTZzL6ZzUtrTbN37GHw8IC2gRqzsRyup83m0jkz6ExMZq
         jMbZq2kqamx6HvUEU7z/htY/9bjHXfIEglJdbIdMydkocW4FzbDYeJO97vLNGJeEiaBh
         OCgfKvpIdLWtvSblYlEV9UdBHzhu+bMIlTbC5ibqcPDuulr3VVCW/4PzJwFEoVpL4ygG
         XWbg==
X-Forwarded-Encrypted: i=1; AJvYcCUdMEfunBm2EeNEPGgw8McFB1QOxlzPdLQkVO7KpCpjXTL/V+jvgt0Y629WX1raeuK023RodP71MMAERpfp@vger.kernel.org
X-Gm-Message-State: AOJu0YyGuRRDD9A9NezRJ1z2ShfUjQMhZWSamRItro0H00IiM6l0KUm1
	38lGGjm6Tk537LsbAmmhwJR/2B2p1L/igcayxJssbiNoLIZhyYdw7DTSlBCFH2PuBQrFIT/UEnT
	5MsGdJ7cPdZbhsztw4GWUEMofLLRioHD/w5E7D4o35hSnjzVx94JzpHvouFrUBFqffA==
X-Gm-Gg: ASbGncvRK1vLft9lnWW6DE3UKw7KWSLQeLOW7nGLVDCqOMPFDWI1CYjA3lSu2hKTR3z
	Sh3drUIyw+BfMuPTAbmmRAYNMV6IzOo2STpB1BczcOjKmbll4/NII5zp+E1hfp8eAQ8OR4bZjMv
	vSHbQ+NcRRRb4l9N5Wp+xSU0bbDye6qVGdlt+e0t3vmTA3Ez44bZlBKG0z0cGoS1DURbq7g20p1
	rr1g5z1rgvY8/klqaOpDnFeYKeLwjFq3Hsya2raQmScofLAMY20y5JRK69P4Ls469xHe8l1gj9n
	3JQSHqw1GOqawmEv0IpbAxmXVoTB0VCmXW18aRm6QwkF6w==
X-Received: by 2002:a05:600c:1988:b0:456:214f:f78d with SMTP id 5b1f17b1804b1-459f4f0f55bmr33822055e9.22.1754681537335;
        Fri, 08 Aug 2025 12:32:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4Zzp0+e8x86fu4vkp2zl133cRaxb2jV1ttAjta9TTzPN3gXe0PibXkLKt2GjRw6aWnewDbg==
X-Received: by 2002:a05:600c:1988:b0:456:214f:f78d with SMTP id 5b1f17b1804b1-459f4f0f55bmr33821805e9.22.1754681536917;
        Fri, 08 Aug 2025 12:32:16 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5869cccsm164906135e9.17.2025.08.08.12.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:32:15 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Fri, 08 Aug 2025 21:31:58 +0200
Subject: [PATCH 3/3] xfs: test quota's project ID on special files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-xattrat-syscall-v1-3-6a09c4f37f10@kernel.org>
References: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
In-Reply-To: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>, 
 Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4286; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=JD0ZSorQ60c/tMR/lOTbqcoU/0PVcdELTNmMcs0rJ7M=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMqYF7FViWNvIkifo6s3Npn1Hz4jnjZxTQ3eLxI+b5
 zt7y2p+fukoZWEQ42KQFVNkWSetNTWpSCr/iEGNPMwcViaQIQxcnAIwkTfPGBn+f+J2+3uDyXPH
 a1udjV7H2LL+X92rfUxulsSJqSFlu74UMDLM9tvkIrfvc/3r775Lz/JNfHV2JYMahzcfo6PifKa
 PhZXsAGntRho=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

With addition of file_getattr() and file_setattr(), xfs_quota now can
set project ID on filesystem inodes behind special files. Previously,
quota reporting didn't count inodes of special files created before
project initialization. Only new inodes had project ID set.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 tests/xfs/2000     | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/2000.out | 17 ++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/tests/xfs/2000 b/tests/xfs/2000
new file mode 100755
index 000000000000..26a0093c1da1
--- /dev/null
+++ b/tests/xfs/2000
@@ -0,0 +1,77 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Red Hat.  All Rights Reserved.
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
+_wants_kernel_commit xxxxxxxxxxx \
+	"xfs: allow setting file attributes on special files"
+_wants_git_commit xfsprogs xxxxxxxxxxx \
+	"xfs_quota: utilize file_setattr to set prjid on special files"
+
+# Modify as appropriate.
+_require_scratch
+_require_xfs_quota
+_require_test_program "af_unix"
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
+	-c "report -inN -p" $SCRATCH_DEV
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "project -Cp $projectdir $id" $SCRATCH_DEV | filter_quota
+
+# Let's check that we can recreate the project (flags were cleared out)
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "limit -p isoft=20 ihard=20 $id " $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "report -inN -p" $SCRATCH_DEV
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "project -Cp $projectdir $id" $SCRATCH_DEV | filter_quota
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/2000.out b/tests/xfs/2000.out
new file mode 100644
index 000000000000..dd3918f1376d
--- /dev/null
+++ b/tests/xfs/2000.out
@@ -0,0 +1,17 @@
+QA output created by 2000
+Setting up project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
+Checking project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
+#0                   3          0          0     00 [--------]
+#42                  8         20         20     00 [--------]
+
+Clearing project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
+Setting up project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
+#0                   3          0          0     00 [--------]
+#42                  8         20         20     00 [--------]
+
+Clearing project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).

-- 
2.49.0


