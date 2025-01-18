Return-Path: <linux-fsdevel+bounces-39567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF04A15A9B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 01:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DCB3A8DD7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 00:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AE617C61;
	Sat, 18 Jan 2025 00:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KL0/4wWo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E8A2913;
	Sat, 18 Jan 2025 00:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737161295; cv=none; b=F24ZMAG/2AAQXOFLUg68vZflq3QPeQVIXBYkMrw3j/A0vhDeu6Iallnwq6LeSj02RAp0yZTNoN4dHJnPrmiEscu4+YcwdjCSAYocwHPArm2VjGUR8fRF2j08iHszE7hokqlwk7KRKShVwgIZzlsOFdgQLahVI66YBYMUFq2qSFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737161295; c=relaxed/simple;
	bh=daBzD//cBkg5rogE6pEcC4+gYYpGqWl0biKOXvthShQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXZCD7RUplPLWWemgU9w55PnGy8wCHt1KYNl4b3ASDZWqC3vqC1y9mK8my95YpeCFtfAj6Yiw/2vVa9tpWx4hWbY/SxevvIgGbk4bVq4ERUi1PcWePZmrTWXAINWMQNl9obcIP5+TdF257Csy8kKmgSg5jnGeHmZL1o+SzmeA9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KL0/4wWo; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e461015fbd4so4180989276.2;
        Fri, 17 Jan 2025 16:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737161292; x=1737766092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p90TONDalliPlYjPPsOYvMlU+K4gQUMKH3aG4J/s8yc=;
        b=KL0/4wWodpGw34GgBHwccR88euAznJ7++rHNGYX3vIe4gv22pu02KMFs2M0BfFCC8p
         JD8yvXZOGtEUUn5ogvvDhtM9Y1w8v9wdOrxXJFFPPT93JQ1rB0bEy7FRuX/+DKk5zkaG
         XM4eIj+mM4LOtQKgsop8tby3fw4A+TOtHhM95wkFZnTnXuuZ3e1mW6k2yY9O7wrc2bv9
         cA5+KIqywciOpV/8+ZyFghU7tol3RGnb4yvUSVDd9zfBfC4kAGjfjLPcgffrn+2H8Jjt
         LxbtAG6IE6HWhljeJMwvZhw+WdBS6NwJcoNcCEnsy5ZH8UwKyTC9TW2vToMoKWhos9p1
         6bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737161292; x=1737766092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p90TONDalliPlYjPPsOYvMlU+K4gQUMKH3aG4J/s8yc=;
        b=fRFJQyD9ffsgPr3ltRbm4ovx5aUVmCXESjaFGFlq7R0aaJhI54wqbOJ/7rdP/kEBwH
         vmM9LM8xYvDKDbvfsrPHAJ2pzNMEg1NQu2LULg2YY0X/qYt5/p49b3zTHpLWZujRqmGa
         OmLsa1iseRa5ni3nOilBwg3aAVxSuMMit5sxdRA89KXP8ZgYFGm/BkquUgrIJLslXy8W
         Yuig5jLWjv1EwdScU+PI3XQflteNmXK49wQE6nfM2JxRwlkUsu1Mzo8+pCVgSG6NGx0D
         qS8kNKaTS4tCC/pSndZLyc9s5Ss1rMhhxSThpfPXXvIxW4k/wfJLhTbaG/sTbpYG1hLk
         TBpA==
X-Gm-Message-State: AOJu0YynXot5YaxMPzimVbQ+sYOhjTcFfwcHOMFS414HUWOSUsgmDI1p
	jRaX3BllC+38oKlVa/IIQXyH8Kso+xpbm0PErii3L+JdU+NVJ334vmjeoA==
X-Gm-Gg: ASbGnctx2q2m8r4tADiEcSebdERoJBVGCyg+Os20QMweu9p107rtppAwXiW0bDp24Io
	t5KKCgO7sd006nU7IdhkC7y3Z0LwmKvcvRwI4tyi+AhRZ8/8OpLHCu31YcNZ7Y1hRWPoCLYFWi+
	HJIF/CWc7eP6DXBMe4BjbIa+Pr4E63DUjHRQ2QBFtTFj13KhpZfnRKZkji6hC5Okn9bb4C0T+w0
	23yU/C96Wi0K8Ea+WFY8NLp5um7iwWT8HAExGxB2miVLxnjvDPzjkA2A1Y7WShOV2U=
X-Google-Smtp-Source: AGHT+IE2Vqy5z/eDdSfmsk6Si7xp1zWOne1XWU3hbGXwnMHdtMGCHHoLif4tCYLULGL/ELAFrpGllw==
X-Received: by 2002:a05:690c:31a:b0:6ef:6f24:d080 with SMTP id 00721157ae682-6f6eb6490edmr41809017b3.7.1737161292712;
        Fri, 17 Jan 2025 16:48:12 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e640bdd0sm6336707b3.45.2025.01.17.16.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 16:48:12 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com,
	djwong@kernel.org,
	nirjhar@linux.ibm.com,
	zlang@redhat.com,
	kernel-team@meta.com
Subject: [PATCH v4 2/2] generic: add tests for read/writes from hugepages-backed buffers
Date: Fri, 17 Jan 2025 16:47:59 -0800
Message-ID: <20250118004759.2772065-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250118004759.2772065-1-joannelkoong@gmail.com>
References: <20250118004759.2772065-1-joannelkoong@gmail.com>
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


