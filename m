Return-Path: <linux-fsdevel+bounces-39322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAE3A12AFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 19:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9667D3A7F97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 18:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771641DC9AB;
	Wed, 15 Jan 2025 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xer1Bbdh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BB0161321;
	Wed, 15 Jan 2025 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736965881; cv=none; b=KxpuK4gZRBEfjboi3BqSTahUCElMbrMXUIQr0LOaaYK0Zzj3qfDpVzcIhmUJzFubFg4UIYGGg3MyGqyhXRschWTaGSjx8Ce0l7vGbcMg2dtWfv95BmFcJeudgVPphZDu7AHqk3TnRvUCvJerKaeCNgLmrx4KeZ1yrRwPKN8Rj94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736965881; c=relaxed/simple;
	bh=Ivrma/0GlUdpWF8GN1pm70CHhsBiKmg2J/LXsP7TdRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dO/PhEm0uDiggKNefQqOxh+9b10bQOCsgDdQkvXY/4LRAGToYJt9mZstIVxGE0RZQCMyw2JcG5OrtieBVW7GzDp3tZCo08aFjlhGtXDrh1oKBwv/X1mfgW4oIFBND86FTZMGLQIQWRc35dreHWBt8IeVoYsegrum/WKD3TKOOdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xer1Bbdh; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e46ac799015so103915276.0;
        Wed, 15 Jan 2025 10:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736965879; x=1737570679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjZ969536HYyRs5Aqy2O3IFQ3d7msh85rXJbCpiIXXQ=;
        b=Xer1BbdhkkxjVSRqFl12MiwDUO0CGbIwq/bZmZLG68u6FhD9z9C8f6QJDtGDyxXX15
         Ga3wZyAaHusgtMmIWjjeKdx0Q5NEW5z2XFvWK5Vu28VraVsA7lje2zaO2wpO4yALaQT7
         NOarGjYzwdM6Mcrj2+eyRhOS7zHcm4Rbl+JcZz/9QLXB0PSGb3ibh2oIAkZFNwfY4iR+
         kNDyfcfVoo5+oSA7FdmCL4AOtruLnsV/Xb3fo/iWcwPaV63jCd6z3yMwtCnihbGIHW4w
         iMwpClosJOz5DS41ozV4pZnm2jSug1wK/8rytZ96cZi9NWnGlYUPLTUKBKjBPH8wzSq0
         +a7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736965879; x=1737570679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjZ969536HYyRs5Aqy2O3IFQ3d7msh85rXJbCpiIXXQ=;
        b=cZE+ws/vbrsFvBm1TirVBweOpBRbAmoOirP4HFrUhDjXIvg0M3FEg7O/6wZ3F+1kpb
         6krOK+9CJ2ULtYk87almBvwXH9XR8cr0D2X2am05vAMK/1DaL8svkM8kGYFUOqVzBOVo
         Ms9915i2rRKDwi2WTA4xJT7luOsP+ru3vd6oHYzz1U0a5vacqhL3ZTSC7O044bHnanXr
         mLKKxk80JG4bSEEuDd3psee/emFvfnzKnJNQne4aHYwNxYCAJcKrdY3gpea/LcBHdRES
         zgt1tCGIhN+t+3OgJ9KqAqFYonLlV/FFDy0mCACztbVEHC0JibLXfWbRtvGYCobLjNj5
         2bQg==
X-Gm-Message-State: AOJu0Yyrzx4ZGNC3Igz5YVmHCHms3FVaXpqIm+KogBYGwIOLC4LB70oQ
	ixKHpvS6qhb53yk+TxA9sg9D/RddSc2d5OHJHPkJQAdNdddXlT5aIGoGow==
X-Gm-Gg: ASbGncv2TUQLUcp0ifvTPb8UC3ik6E/+OWo9d8HRLU0RluU+8gJCZAaa4DJERtrWrCb
	Pf87YPNTTi7UcWDJPjQU1BA8dF5SYRkRW0Z4zdyF1VouQEBlsWz6WrvOIovHSgCl1q1WWxq70a4
	Jdy1HgvXmphlT+ujnntNLAV4F9UlBcKns20Fd6tmu+y8UOe+2KIIsdC/uSkNhR7OdNGyK3hLjGW
	j/37Yo5n2JPT1wORaNZE8m1MRXy+o/X9T8UEjdl9+9Fz9FuNkjIzQ==
X-Google-Smtp-Source: AGHT+IHlxAYuzx630TEA4BRLsejkHTIoMdRF+NXJcsTe6JfxoaogR66ow0RogOyb2oUo0VBxV6tVGQ==
X-Received: by 2002:a05:690c:4d81:b0:6ef:8e0b:8c63 with SMTP id 00721157ae682-6f53122728amr254831097b3.14.1736965878929;
        Wed, 15 Jan 2025 10:31:18 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c745bdsm26656627b3.55.2025.01.15.10.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 10:31:18 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com,
	djwong@kernel.org,
	nirjhar@linux.ibm.com,
	zlang@redhat.com,
	kernel-team@meta.com
Subject: [PATCH v3 2/2] generic: add tests for read/writes from hugepages-backed buffers
Date: Wed, 15 Jan 2025 10:31:07 -0800
Message-ID: <20250115183107.3124743-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250115183107.3124743-1-joannelkoong@gmail.com>
References: <20250115183107.3124743-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add generic tests 758 and 759 for testing reads/writes from buffers
backed by hugepages.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
---
 common/rc             | 13 +++++++++++++
 tests/generic/758     | 22 ++++++++++++++++++++++
 tests/generic/758.out |  4 ++++
 tests/generic/759     | 26 ++++++++++++++++++++++++++
 tests/generic/759.out |  4 ++++
 5 files changed, 69 insertions(+)
 create mode 100755 tests/generic/758
 create mode 100644 tests/generic/758.out
 create mode 100755 tests/generic/759
 create mode 100644 tests/generic/759.out

diff --git a/common/rc b/common/rc
index 1b2e4508..825e350e 100644
--- a/common/rc
+++ b/common/rc
@@ -3016,6 +3016,19 @@ _require_xfs_io_command()
 	fi
 }
 
+# check that the system supports transparent hugepages
+_require_thp()
+{
+    if [ ! -e /sys/kernel/mm/transparent_hugepage/enabled ]; then
+	    _notrun "system doesn't support transparent hugepages"
+    fi
+
+    thp_status=$(cat /sys/kernel/mm/transparent_hugepage/enabled)
+    if [[ $thp_status == *"[never]"* ]]; then
+	    _notrun "system doesn't have transparent hugepages enabled"
+    fi
+}
+
 # check that kernel and filesystem support direct I/O, and check if "$1" size
 # aligned (optional) is supported
 _require_odirect()
diff --git a/tests/generic/758 b/tests/generic/758
new file mode 100755
index 00000000..e7cd8cdc
--- /dev/null
+++ b/tests/generic/758
@@ -0,0 +1,22 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 758
+#
+# fsx exercising reads/writes from userspace buffers
+# backed by hugepages
+#
+. ./common/preamble
+_begin_fstest rw auto quick
+
+. ./common/filter
+
+_require_test
+_require_thp
+
+run_fsx -N 10000            -l 500000 -h
+run_fsx -N 10000  -o 8192   -l 500000 -h
+run_fsx -N 10000  -o 128000 -l 500000 -h
+
+status=0
+exit
diff --git a/tests/generic/758.out b/tests/generic/758.out
new file mode 100644
index 00000000..af04bb14
--- /dev/null
+++ b/tests/generic/758.out
@@ -0,0 +1,4 @@
+QA output created by 758
+fsx -N 10000 -l 500000 -h
+fsx -N 10000 -o 8192 -l 500000 -h
+fsx -N 10000 -o 128000 -l 500000 -h
diff --git a/tests/generic/759 b/tests/generic/759
new file mode 100755
index 00000000..514e7603
--- /dev/null
+++ b/tests/generic/759
@@ -0,0 +1,26 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 759
+#
+# fsx exercising direct IO reads/writes from userspace buffers
+# backed by hugepages
+#
+. ./common/preamble
+_begin_fstest rw auto quick
+
+. ./common/filter
+
+_require_test
+_require_odirect
+_require_thp
+
+psize=`$here/src/feature -s`
+bsize=`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`
+
+run_fsx -N 10000            -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
+run_fsx -N 10000  -o 8192   -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
+run_fsx -N 10000  -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
+
+status=0
+exit
diff --git a/tests/generic/759.out b/tests/generic/759.out
new file mode 100644
index 00000000..86bb66ef
--- /dev/null
+++ b/tests/generic/759.out
@@ -0,0 +1,4 @@
+QA output created by 759
+fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
+fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
+fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
-- 
2.47.1


