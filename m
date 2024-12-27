Return-Path: <linux-fsdevel+bounces-38172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE3A9FD78D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 20:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B4718834E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 19:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08951F4735;
	Fri, 27 Dec 2024 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtaU5ifp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9735A1F8AF0;
	Fri, 27 Dec 2024 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735328084; cv=none; b=pa5uMzMZlOjEFPqm8TG15IgzxFgI5FdF1v1qSTGfcnG+ZXafxuov3Js/yESnfz694fV3yhe5jZgFRUnRw/pJy5CPnxZeZVEH4WeXhbyAG8jMGcMtKEeEFBHZb8oMOWAmM6XNXSxFbmpJqkEQLCZY1zYOmFGchHh5xAl3lkBzzps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735328084; c=relaxed/simple;
	bh=J2nDnZHVD3PUhI3gfwMH3zia8iSVciXv/zLsyHV2uoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGSU74aRrd/0HAOLjfJs3rnRezKIvPxQ8oTh916UK6iyx9gYcmNzA9FRpKBnhbRUD6sTE61rX6r+P7RQBZoJcx/CQ3UcNcwDx0/0LYt661l8ZVAV2l9JoXK48uU91y2H89kAC3dJkbVjpLQJykbh2EOy7JRh8EmkgmvK1Qxk7wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtaU5ifp; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e46c6547266so7781942276.3;
        Fri, 27 Dec 2024 11:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735328081; x=1735932881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWoRiMgvaJviAUxN9KUprvFhVYg1yBnylYuBnkhJ2oc=;
        b=mtaU5ifpmWS92n4VFPCeKnzwykdBnwXL3EYfgBQw6JEFQ7zpjYwTiJ/OqUgGg94lmD
         xY3ieYAE3HTb1Ot1Pr/gOO0/bUuqLC3vKaqWDNScXOFdNdljSUDhypw92fdwAF15Lm9x
         N70AnHU1d/cB7WUqN/Fi+oms7iWAFbgZgy2Dl6ltaqJ1x3ZChYAhbZyYAe/Us1dxCyxG
         guwS57fKYb13VepQLJCvv0S1inPbD8h0lyP4K1/isQH2wYyts7Sro1TAvJYyfQN7RMS7
         +3QbyVhwUQHKkKjojTvB7fZJxlGQUWSrhlHLOEXmQyK1sXw+tVCUAJe7JvgSckc/w5wF
         9Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735328081; x=1735932881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWoRiMgvaJviAUxN9KUprvFhVYg1yBnylYuBnkhJ2oc=;
        b=eQ3YdB6egg3fbeLRSZLJ1jCI8b0sEFPy2bsfW4UOAvD2Z01zD4fsJJxDbKzcYmVw7q
         fVFPp8IRgZLfzzgtuoSILgiTTGts6tNQyr7weyW9tSV2GJOj75XMZ0Vjqb5b5/qQMcOM
         MS8XFWuabWWEa+/UVMbPbOh6de8zMIzwegrOYI/jMscnBmUx3stH2sFDqOa8vi+ToJ7Z
         s0QDQbmQWAfLbzdfiCPhToLpA4CPDa+wuqJM9EmxrWVzd+F/YkF2oBDqf00kNiP1POUK
         VJh/chdnPmpwYIpEAkyft2g2gkAXU83hRcK/IXC/nRKkEQP82XsM3aKfyMC7nMeQtIwa
         +n6A==
X-Gm-Message-State: AOJu0Yyv1bGxgfCGs563kyiEuAnOiu9qBRxMErRsHZnboFWuTVg5hQ/6
	x4ux59OGGQhkA8KKWwDNwNFvjGrZf10AzZSJXImJAofqO/UDKGAjUjxOJQ==
X-Gm-Gg: ASbGnctJshipGimJjG/9SO4T8Y7ZmQkPimYKZ3tcVkvCuVAfng8MN6AMeURScMyKQ4r
	6xjK+8ODyrUv7Z7lpCTUj24wzdup8smh113QXZ+xZkyrzB+4ipqNyudSeoskN7ZzeRFOzt9wRm6
	e6AzCcui6ttq1346IWA47ei6nbq2WYGcIIygmk6rGLMzI3xRYw0JQq5TdJnrZJoHBiWR83jFGEq
	StuWjVRUOH3ED8o5vr8Agk0WA0WM92mopFaAQHRsa6tXb9kxhxxmPo=
X-Google-Smtp-Source: AGHT+IFfBKQuzZ1pImoo8jIJ66jxS/v0Rx/IPRzWJpHAUGnK1mLVBKrkwbs+Go5gu73V+UQcXS90yQ==
X-Received: by 2002:a05:690c:4b8d:b0:6ef:7f34:fe08 with SMTP id 00721157ae682-6f3f812730amr196875637b3.18.1735328081462;
        Fri, 27 Dec 2024 11:34:41 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e7444b73sm43180657b3.42.2024.12.27.11.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 11:34:41 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com,
	djwong@kernel.org,
	nirjhar@linux.ibm.com,
	kernel-team@meta.com
Subject: [PATCH v2 2/2] generic: add tests for read/writes from hugepages-backed buffers
Date: Fri, 27 Dec 2024 11:33:11 -0800
Message-ID: <20241227193311.1799626-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241227193311.1799626-1-joannelkoong@gmail.com>
References: <20241227193311.1799626-1-joannelkoong@gmail.com>
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


