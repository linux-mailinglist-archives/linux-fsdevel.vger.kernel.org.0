Return-Path: <linux-fsdevel+bounces-60690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411C5B50110
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 17:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE83916503B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 15:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51196352FD3;
	Tue,  9 Sep 2025 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpcgTUG8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4146B352079
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431568; cv=none; b=c0fQyVOBLFUuYb4Lu65LAydHR1iqD1szZS/BOHm0jOEY4z4dqLAfMc5vtdjlq2IsRyC44ncDM8MOZH6PXqD4R7+imUw4nhwATzrlzXGvXAMnuKCl/nkwhN6EZB1lWllH3ccPUoMoHsVDvVfRiguHGWwFRwxul1QUUncbN0SsSnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431568; c=relaxed/simple;
	bh=4dypLPu6DNf9DAMNJyF5UXwIvayiqJK8XG4EG3pgjZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sSGJZpEYUADzVTmqV4lXZeWhy/Gm+ceEM5rem/QKiOVcgJ+yNTiUgb12iOvzzvlccwbp4wB964H56nikhfUdINfIb/xSdnq2869vkV7sDsgMSmlhi7j4RSFgfTswVMC4WytXPK/KxpmawVAayVA7PgIY5VZLnOVv2OhwK4anGV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VpcgTUG8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757431566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GpNh9Npv8ACuKwnSClKnKFFRR5xgF6p+DJW3Gcbr8Pk=;
	b=VpcgTUG8F0w2uKzyhruLbhsKNRh9Keye9XTVQ16D/u783GevJMdMvVZ3Upf7qtWqNwcMd7
	iPP0wodUovt6Hn0wdW4E4UbVITpVM3ZcX/nS80nsX8bRrMXvYVwqqkFnIAa+HFdA9/XYSy
	e7NGOC7dKzNnG/fdibDcbF/58iplHSQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-VlTvki6tPPuzyb0WP3aAgg-1; Tue, 09 Sep 2025 11:26:05 -0400
X-MC-Unique: VlTvki6tPPuzyb0WP3aAgg-1
X-Mimecast-MFC-AGG-ID: VlTvki6tPPuzyb0WP3aAgg_1757431563
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e50783dda8so1971804f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 08:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431563; x=1758036363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpNh9Npv8ACuKwnSClKnKFFRR5xgF6p+DJW3Gcbr8Pk=;
        b=lCXGfRg9u83auO892IxfKBb3j07ZvW1oSmuCdCljlyeHKD4CCAVrNmc0sBZI8Bbezf
         C1S2IYTaNn45o3MRO3A6Q3qss6LUdJwpdPOVH6loh1zQQRB33qfOFXFb0+dzT6SGpK5A
         IcGi6cK31Ap8krGAKLTMSskT497hHoaQbtWT4mmybyLkNzpWH43I1iVAZ2yFZCB39SEl
         v5AStH8T9hEEGg+kidUKFvitCvv+/LAPD5C15HIFt8+lB8fmaC5IyNf0sEJ0fvwJSIS+
         2rDX3ON1PNuYgj3lZw//DeFcmSMaIw+XABWAJ/JMj0wC4c50g7HONRE5NmLCCiSdnsz+
         S+aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkBzf1KRjnuCY6j324aTALUTqikqru2XqPSsWE51ZzUFfCW3yI8BD/yq9B8ymwXadIVv3PDMSwzPzXyN5i@vger.kernel.org
X-Gm-Message-State: AOJu0YxvBG37L4W5HQj/DY3RYXx1XRL8FqTmy2E5uiH4js5sfEyeMXdt
	a/V/orkC6b3pvtozaAiJCiaorjV8ppiRESPSbtlUkzdUeGhu6ZjxTpNtqp8vePCjnjUOx7VGOkU
	sulzxCXZXQp9577ZZSUbA+ou941HimSzz04mJVubyzssquDPZUL+lXnefv28MAYA6mg==
X-Gm-Gg: ASbGncua78H+OKR4X9Il5lwUJF4SOVD7YVya64571l3HNZj6szDpaJrNEUX5uqLNECC
	lwDKD/5QcBi8ZT32L8go7ppKpoQ2tP7XIxE8fbIq4PxJ3G/+6aKjgw6J5CjSxm8BGNhdQED3c+A
	19GZzOxusbOPr/WgO8Qdc1J72u2sSUywXam1vbMzPRgRpQjhlq1SSZdMhBUQNZ+tCgqFvsWxfKT
	wLSjPxktXXR7c8RlegyCKkzoN/jt3a6HJrWoqsZf/32l9L7RSI9TydyMr0BtVhX9Jk8XCfJZWle
	SYX8zz9rWvTyGDdogsAdDsED3ytb1e/jtHa0QlQ=
X-Received: by 2002:a05:6000:26c6:b0:3e7:4701:d1a3 with SMTP id ffacd0b85a97d-3e74701d5bamr8119814f8f.38.1757431563383;
        Tue, 09 Sep 2025 08:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+0/mzhErgMtuLp43Q9Ly+zDslZ5No/VC0mdy3h84qXsoOBvnDTW5JxZPf6YxuKLf2h/pD1Q==
X-Received: by 2002:a05:6000:26c6:b0:3e7:4701:d1a3 with SMTP id ffacd0b85a97d-3e74701d5bamr8119795f8f.38.1757431562945;
        Tue, 09 Sep 2025 08:26:02 -0700 (PDT)
Received: from [127.0.0.2] ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9a6ecfafsm348550005e9.21.2025.09.09.08.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:26:02 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Tue, 09 Sep 2025 17:25:58 +0200
Subject: [PATCH v3 3/3] xfs: test quota's project ID on special files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-xattrat-syscall-v3-3-9ba483144789@kernel.org>
References: <20250909-xattrat-syscall-v3-0-9ba483144789@kernel.org>
In-Reply-To: <20250909-xattrat-syscall-v3-0-9ba483144789@kernel.org>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>, 
 Andrey Albershteyn <aalbersh@redhat.com>, 
 "Darrick J. Wong" <djwong@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4010; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=NFXZJCDM6gddTTqUPtjzyqiRjXXUpTibfg7JUhy4vGI=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMg64swfpLLyvd6I3zdRwn2GD1S7PJbOmrdx6ILud5
 +ra3A6h+aUdpSwMYlwMsmKKLOuktaYmFUnlHzGokYeZw8oEMoSBi1MAJhK0gOEP961fy42mbrda
 ob87ee28AtVu9vPll16dz2v+aBEcuoNLmJHhW0/xh+lz3fI2HDz59rvTYf8pry1eZxqVf7P9rja
 vlukoOwA7WEnr
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


