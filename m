Return-Path: <linux-fsdevel+bounces-39803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A30A1878B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 22:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4C93A531B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 21:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3381F8ACB;
	Tue, 21 Jan 2025 21:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5GdrBI4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F081F8913;
	Tue, 21 Jan 2025 21:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737496681; cv=none; b=enF4Bx24ZrfF4gnFcB7/8ZRN8KcTYlAgvIeBHufxoyADy1GpcxU0nWdAKI2+LMcVBFJmixk65ZBFiV2ImRuA78xe4N0xxKJ3JxoJOojVJUSkRFOvIaqo1OXmP1g14H/o7NhcNKO5bcIbjRxC6zZIvX2HaOF8mniqhxuX5aKo7w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737496681; c=relaxed/simple;
	bh=daBzD//cBkg5rogE6pEcC4+gYYpGqWl0biKOXvthShQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsLSjLcwtnMsFbuCARmtN4m9PvUaw4y4OnQChVVskkaf/11dvgs8ItuOK6FeEtF77q0GYC2HznO5ByYbTCbVIBixFRk3HOeHtr+Ph2NR7rtmCUuxTRoFFMUVh0aNqDrmetY+KixoX2AFxlk0hY1rntmz3ijUTgXT+ufOASvzTnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5GdrBI4; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e46c6547266so8954263276.3;
        Tue, 21 Jan 2025 13:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737496678; x=1738101478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p90TONDalliPlYjPPsOYvMlU+K4gQUMKH3aG4J/s8yc=;
        b=D5GdrBI47vsUAWgRQBY9UatEjAM2/SZdRnQHAI1RvwwJsDg++ZVkrnUQNV6g/RjZj/
         pM4sGJgnaCDLDvlhIuDwhGHg1Sdlyhl7T6m+f3Kr6YXiC9ob+Z1L/MymYA/ydjnpO2CO
         BY4f0WsERBdbBgcgTkVGMC/gndmzqBwxoX+XVHGsQm74YQxH6NkLXlj/u4EgiAjcqO21
         3SquKmuUYS3tdAKkBZwcSKszIu1QD+jUUjjZSgcrxRcpcaq5U2YUB8xbILwmt7PD3+wQ
         kfl+NUTvBhN5QTOULpzPLAUmQtcQbC1ZrMAYx4fFRJETUbPdTvy3aQezwpS36I4aeNVy
         MsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737496678; x=1738101478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p90TONDalliPlYjPPsOYvMlU+K4gQUMKH3aG4J/s8yc=;
        b=KbuDQZcm23Za8zzYgLQT+oEp669PQR4hHdYPu62nDFzE9o6NqxEnviKV93ekvVDD9c
         7HqaqSYYsvqY4kFVH5PUKM/n11cWQmXRB3sdfAzMQuQoCNE70CjPAy198Msw+u2SgWao
         JgYJHVCHnPXzy0qi3xNgJOXR7eckJClHnfu3peqGnQ6U2nQRAqTtkjOaSVjeAB7t56Xk
         ElBt0rnt9crWi7/rPLA1cFDZZLC4IaGSqGyRAOo5QM/w5Cl4e6IPJPs6SkMUkwJiZJq+
         NeSBzVFfslJQBr49YNnDimq2YvJWt25CIZOvmvoAzZfykQVIvlmOy/bsE9VX38xmer3m
         d5cg==
X-Gm-Message-State: AOJu0YwnmG1Fc4tRdhsaK0BE7hr/8aYu5hyo+RtcZrD3iZykjNPN4EwA
	RkpIyYHnBy31v5XaeAWO9uUc9nhr8WsxU7KBwWUHDHz1j+9VECKGxMal4Q==
X-Gm-Gg: ASbGnctfMQ7H1tYXNTWF9qpUJ0/64GWEv7XnFk0k1WAWCc+3bOwpf6RZXHm5N+2SgQW
	8Zs1pvXtbv6EpNLtC2hgXryEpCfO1EwzQyXwVkAFZMVpdvbe6iXBwisInq969ENXgAefaKBrsNt
	oWGuy7GSkg0MjMETsu1RWOwERYmONaYRsofVUK3pijJRjpyVFIZnBH+LL0DPctJY1xtrp3LIMqn
	ArzPo1cWd+dcE3cuKphEuobu763jVUqD/CfdYT4VQA4kBR491uPFDZZN4D8jXVjJcI=
X-Google-Smtp-Source: AGHT+IFmvaCmmiQ82v5xYu6S4f5vefDSLrJUTgNzpkacFGYkawWwEP3UxMXw+8/a/x37kHBGoekXgA==
X-Received: by 2002:a05:690c:c83:b0:6db:c847:c8c5 with SMTP id 00721157ae682-6f6eb67bca1mr172803707b3.16.1737496678480;
        Tue, 21 Jan 2025 13:57:58 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:3::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e66f8dc7sm18206407b3.116.2025.01.21.13.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 13:57:58 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com,
	djwong@kernel.org,
	nirjhar@linux.ibm.com,
	zlang@redhat.com,
	kernel-team@meta.com
Subject: [PATCH v5 2/2] generic: add tests for read/writes from hugepages-backed buffers
Date: Tue, 21 Jan 2025 13:56:41 -0800
Message-ID: <20250121215641.1764359-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250121215641.1764359-1-joannelkoong@gmail.com>
References: <20250121215641.1764359-1-joannelkoong@gmail.com>
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
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
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
index 1b2e4508..0c44d096 100644
--- a/common/rc
+++ b/common/rc
@@ -3016,6 +3016,19 @@ _require_xfs_io_command()
 	fi
 }
 
+# check that the system supports transparent hugepages
+_require_thp()
+{
+	if [ ! -e /sys/kernel/mm/transparent_hugepage/enabled ]; then
+		_notrun "system doesn't support transparent hugepages"
+	fi
+
+	thp_status=$(cat /sys/kernel/mm/transparent_hugepage/enabled)
+	if [[ $thp_status == *"[never]"* ]]; then
+		_notrun "system doesn't have transparent hugepages enabled"
+	fi
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


