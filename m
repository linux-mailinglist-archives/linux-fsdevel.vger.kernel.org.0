Return-Path: <linux-fsdevel+bounces-37760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863289F6F27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 22:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434B8189088F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 21:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851731FC7DF;
	Wed, 18 Dec 2024 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U06emEIZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB751FC0E3;
	Wed, 18 Dec 2024 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555708; cv=none; b=C91SjG0qQ6lBep9KLcBkCXtWEwzBwunfNM4neOQIDJkLrSZxuUdJoCBS37F/zvW0quZl62qBI9ITmG/yuF3rz4LzCzOPYDAKzUqJhquQ4CjsJ8tH7z5FZxGRqK0HHZvWB4TqYZCPysdotdsz8MR/Ltdz/Jc9Oi186RLfUKxc2tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555708; c=relaxed/simple;
	bh=oHX8g+2ihpxwTrK041BqNedpS6IlTwzwvwCuJno8/NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9b0JZbgCtfVss7oWSYGE7eJGtU1NJWhz9UbbOMAkJYjx7o8z10iWMtmH8JkCpMUwfpHmcsZc6DRVVRdFdVOwrskdt50IdawHSaDP2xHpt74PJbk1+qzqqjlnnoaVcXj9agaN7/EfLCX51ZL9NDAz4Yh52+yt0fGwdJdskVGc2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U06emEIZ; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3fd6cd9ef7so1075873276.1;
        Wed, 18 Dec 2024 13:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734555705; x=1735160505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvYqTuGIf+upof8GIbZFvu/MmffRm+hDcwiYX6WvDfc=;
        b=U06emEIZTaHsSNck++ePl2bE+EQyoxn4SxsZr4vFaasqq95G5ET2+y9QyTtV8FmIgt
         SBmiVvJm5AvYeoIrmZQUur6fQC+XB+RaNE4kjdB7IG+WE76sFhbsOM2eofnSd2Ed1owA
         blyyuM4Wn+4Qkt5eT0bN/eQg0dAWbBJK67+fhqzVbvYdvZiv/yrYBltSVNewTiW0j7QM
         MNBKaykL92BawpKeJ4AICB0wTIb3axsTTxviJ1Nf3AsdvIP/WTa7L6YA+d4iFOM43i5E
         2gDQ5OdEv3NGDphbcOWcXrFdW6Xo9dGBvJoHPt3fTUfEcpULHsrea5IcUxjuXySIQ1r/
         J4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734555705; x=1735160505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvYqTuGIf+upof8GIbZFvu/MmffRm+hDcwiYX6WvDfc=;
        b=BXbyxtjHkIDICSrpNUQjXs6GKLqjQ0WxIZB1IoraC8M2rqiqoB1DyUyl/m01NiyB6c
         qrr9QplgvHi4qFHy7hJPxov3BAufw4dAM+UyXEj/JV8P6Oub9+lB/U8PZrm8ysEHVHfb
         LSNIn6nD4ML9D4AUh6cfnzuXj/ZhxfXeoDC8Q94j+XN7VAkbQvyP5QaRGIuliCJeaFK0
         Oy39ZAOO33793gyjXhTJxNJexytNK71xYw2+GwOMHtJNGCgDT3/1SYpj+POT2fjrkApH
         84zNe8glrss2s8Ep39YiHk8hxItJrb2yHgYLiPabNze/qS/q+V+EdFb6zLc7vxqd9AXY
         3Waw==
X-Gm-Message-State: AOJu0Yw0GDDvbIAWK6+tYMKFCKveWmxBsBfyIX+hPsiRDt2dvrrAspsy
	rbn+0VOfB4RDoaNzBlWRHKT4y3zAMiHckucNvMQNVpv/AvAJ6eQ/JwgD0A==
X-Gm-Gg: ASbGncvEniuDf/KcsWAWMEUMdzgjZu34QVgAuqQZmFDGpTviiSB05bYjehjIhFujmeZ
	UQejRj7lsXUfAMQhGUlK75vB6Os3W6oBkCgk8KChPb0OLHkbhT74R1RSN+pbzSzx+kGu2JelvgF
	EmHWGQBxv0lT/PXwNNYETkwnZCwtpuTnBijqP34k6oyleFLYYKFNADOiSDEhrVs9JKxFVaWo0wt
	ofskyLnD7UAI6uhxWTYv8K4k3QA4ZWf/wSipi89cu/nDtQ/j4BnEao=
X-Google-Smtp-Source: AGHT+IHyKxeuut12QZgBEbwguNN7FiQkO9LFs+0DGUkwKEJI0I/G7ylMOyfzoVFkoCfLcvzQdAuAow==
X-Received: by 2002:a05:690c:6:b0:6e2:fcb5:52fa with SMTP id 00721157ae682-6f3e2ad85f1mr8345377b3.9.1734555705304;
        Wed, 18 Dec 2024 13:01:45 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f288fc5111sm25545047b3.4.2024.12.18.13.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 13:01:45 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 2/2] generic: add tests for read/writes from hugepages-backed buffers
Date: Wed, 18 Dec 2024 13:01:22 -0800
Message-ID: <20241218210122.3809198-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218210122.3809198-1-joannelkoong@gmail.com>
References: <20241218210122.3809198-1-joannelkoong@gmail.com>
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
 common/rc             | 10 ++++++++++
 tests/generic/758     | 23 +++++++++++++++++++++++
 tests/generic/758.out |  4 ++++
 tests/generic/759     | 24 ++++++++++++++++++++++++
 tests/generic/759.out |  4 ++++
 5 files changed, 65 insertions(+)
 create mode 100755 tests/generic/758
 create mode 100644 tests/generic/758.out
 create mode 100755 tests/generic/759
 create mode 100644 tests/generic/759.out

diff --git a/common/rc b/common/rc
index 1b2e4508..33af7fa7 100644
--- a/common/rc
+++ b/common/rc
@@ -3016,6 +3016,16 @@ _require_xfs_io_command()
 	fi
 }
 
+# check that the kernel and system supports huge pages
+_require_thp()
+{
+    thp_status=$(cat /sys/kernel/mm/transparent_hugepage/enabled)
+    if [[ $thp_status == *"[never]"* ]]; then
+	    _notrun "system doesn't support transparent hugepages"
+    fi
+    _require_kernel_config CONFIG_TRANSPARENT_HUGEPAGE
+}
+
 # check that kernel and filesystem support direct I/O, and check if "$1" size
 # aligned (optional) is supported
 _require_odirect()
diff --git a/tests/generic/758 b/tests/generic/758
new file mode 100755
index 00000000..b3bd6e5b
--- /dev/null
+++ b/tests/generic/758
@@ -0,0 +1,23 @@
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
+# Import common functions.
+. ./common/filter
+
+_require_test
+_require_thp
+
+run_fsx -N 10000   	    -l 500000 -h
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
index 00000000..6dfe2b86
--- /dev/null
+++ b/tests/generic/759
@@ -0,0 +1,24 @@
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
+# Import common functions.
+. ./common/filter
+
+_require_test
+_require_odirect
+_require_thp
+
+run_fsx -N 10000            -l 500000 -Z -R -W -h
+run_fsx -N 10000  -o 8192   -l 500000 -Z -R -W -h
+run_fsx -N 10000  -o 128000 -l 500000 -Z -R -W -h
+
+status=0
+exit
diff --git a/tests/generic/759.out b/tests/generic/759.out
new file mode 100644
index 00000000..18d21229
--- /dev/null
+++ b/tests/generic/759.out
@@ -0,0 +1,4 @@
+QA output created by 759
+fsx -N 10000 -l 500000 -Z -R -W -h
+fsx -N 10000 -o 8192 -l 500000 -Z -R -W -h
+fsx -N 10000 -o 128000 -l 500000 -Z -R -W -h
-- 
2.47.1


