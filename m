Return-Path: <linux-fsdevel+bounces-59397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4BAB3865B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DD89845F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 15:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D416530F931;
	Wed, 27 Aug 2025 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZoAl2W3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC1727D77D
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307788; cv=none; b=P5ActPpG3wMNyjsQVib+Pt55yrDKx3bTyoIuNoevRNvDluP3DsqZrOSbQOU5SmQdzBP64x7I8c2OKNpDMHNwBgBV+ZOHnXDqHZT8EqutmcktJQH3GxgEdWyZsy+ShGnxkISiNoc4ZJJiVVPuoQSJz1nm0ZFnZE1lJywo2Y0cvJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307788; c=relaxed/simple;
	bh=kYbsGAy8GMeUA6lqVnw4fhaUnEOWu7NsbJ/bKKr/7v8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NfFbvA97OmgzCCNotIAXcAKupgQGAKVUZPcPBbRbi4O9SnXYj2UusfrQhTVVDPRnKaKxQ5YKbeq7r6E9mBdXNPjmBlCzSlDo9HPeE3Ti8NUuD3FU0JMJNHQxm8pxQXsiTClANyOsLBxOADLMn972GPlXPyLkoJOtGI3UTDY1AB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZoAl2W3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756307785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTUCl5n/kCYAs38Bk2khoNLAR3VoHOaPiVzysLhfkqM=;
	b=aZoAl2W3Tkxk/oW35j08i8aaRWvbiGELT7VH9BfFyWlw00nei+rfLS+u9w7r0wwsD91FDA
	liyhE9MMJ0iZRolbYaFx4wXyxT62tEei9xQFpmAr38a4k7EYMYXeKRKCn+wqiVshHRkkik
	bFld+vzg6qtdSDRP3Ghzsft4lb0hLmA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-bmZpxRd_PJWeQ2PdqHJu-g-1; Wed, 27 Aug 2025 11:16:23 -0400
X-MC-Unique: bmZpxRd_PJWeQ2PdqHJu-g-1
X-Mimecast-MFC-AGG-ID: bmZpxRd_PJWeQ2PdqHJu-g_1756307783
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1ad21752so5434095e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 08:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756307782; x=1756912582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTUCl5n/kCYAs38Bk2khoNLAR3VoHOaPiVzysLhfkqM=;
        b=cOnWdSMI0aBWj8OzfXUbBPUPeampvynuSItnnVGwBkojJ/P1fclzXcB9CNSwzhXTqc
         Rm3Kbr1qXKAg+njVvBRTWtMxsRXs2FCz+1ixqkO2hySKSfbhCkjdzdw5lgguMEae7E9w
         yI2dtMihZg6sqntT1L0LefazZH1SCQF8KJxpWeDJSfw2LSlc8nGsG9ayPXDlozqgk/X1
         FEvH4xnBK7wG0XOXoP6kVjoT/4vZy3TqNaAt1RxBbdmRfD0MEtnpdFLoTSq6YU+6POCk
         dKldkpx8qI9v/GaAguxfXo6GtvXu5Ja2y2FRnGV3How1uu0LLF3CXT3FI4yu3jFcjBv3
         mXpw==
X-Forwarded-Encrypted: i=1; AJvYcCUxVKg0Lac/y1qqqnJt9jYyX6ZV0wgDplbtGdwAvYbrdiIVFFEpKuszQWdyUAOHFa2SRwCswjCTSTpYkSri@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3OnMq3O3y6ZzlTKMQspS5/Ek9kyqUL8o/8FeryV8lx9DjFY8/
	3WOe7GwMwmI98949hoiC0Y6ch42MWcXf7gjBeXEYMgoJd/MykRB5IoSqc5WNLVNld+Zu4+oxH25
	76uE3tTIFfkkjp7Rfmv8VmlMdzsRZsY5QptCIEER5Ha/vRfyZHoDyOyeHLF+DuuA5yA==
X-Gm-Gg: ASbGncvYu9oY9T0Kg4j/1grKfv+gu0MLeRuwIAxUQL7/uI17JanRtbN6ZtAncXiRku2
	QVrbVwqFzUMlAKLd+Lh7Ffym8ZGY9yMqatnC+3LBgaiWOJDA10MPp9EHQuyGoXriJXSVlpxZPx3
	ZiCdyk5x3r8MokdOmJdty0mfPAH4Ww8aWrR+uosc0obxX3ryoMzyMeucxSLLCdtucmYlYlAok2d
	BdmosxzpSIh6ZsvBwHuZnsJnW355gICTEAMfjCWNW/fMi/YDhJcno1+aSrh7RxvOgSJ3t6sPGIF
	xpBMwA9sw/gT6+mx7w==
X-Received: by 2002:a05:600c:c0d9:b0:459:dbc2:201e with SMTP id 5b1f17b1804b1-45b6870dda4mr26737665e9.9.1756307782493;
        Wed, 27 Aug 2025 08:16:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPJoIJySLeawXgr/PUlSZfR/ZHT6IBnT2EEtKiU7dNbcjnC1lc9hzdIQdOtJCf9k0+zYGgNA==
X-Received: by 2002:a05:600c:c0d9:b0:459:dbc2:201e with SMTP id 5b1f17b1804b1-45b6870dda4mr26737515e9.9.1756307782002;
        Wed, 27 Aug 2025 08:16:22 -0700 (PDT)
Received: from [127.0.0.2] ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6dc1sm35019145e9.1.2025.08.27.08.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:16:21 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Wed, 27 Aug 2025 17:16:17 +0200
Subject: [PATCH v2 3/3] xfs: test quota's project ID on special files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-xattrat-syscall-v2-3-ba489b5bc17a@kernel.org>
References: <20250827-xattrat-syscall-v2-0-ba489b5bc17a@kernel.org>
In-Reply-To: <20250827-xattrat-syscall-v2-0-ba489b5bc17a@kernel.org>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>, 
 Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3958; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=WxjcIOGrMxQ8fi2CDevfH6n7oBhoM80FQoibXLNSdqo=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtYrOq17uqvDwDGr7//vyMqzHbX11ob6lxITJ92bc
 W4X88fpbqs6SlkYxLgYZMUUWdZJa01NKpLKP2JQIw8zh5UJZAgDF6cATIT3BSPD6b6Onr03OWbW
 m77ZM4GrO+xi/GoHbQPrWx6u4U/Yl88/x/Df8UamnvP22w4cQTcj9+d489uYuGx47SudfIb9/Ht
 b+d+MANODR5E=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

With addition of file_getattr() and file_setattr(), xfs_quota now can
set project ID on filesystem inodes behind special files. Previously,
quota reporting didn't count inodes of special files created before
project initialization. Only new inodes had project ID set.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 tests/xfs/2000     | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/2000.out | 15 +++++++++++
 2 files changed, 88 insertions(+)

diff --git a/tests/xfs/2000 b/tests/xfs/2000
new file mode 100755
index 000000000000..7d45732bdbb7
--- /dev/null
+++ b/tests/xfs/2000
@@ -0,0 +1,73 @@
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
2.49.0


