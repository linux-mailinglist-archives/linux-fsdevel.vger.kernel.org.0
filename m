Return-Path: <linux-fsdevel+bounces-68580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC52C60D35
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 00:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3131235DF7C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 23:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7EE2874F5;
	Sat, 15 Nov 2025 23:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ifdsKQen"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905B9284665
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249681; cv=none; b=Lk2etzEZPBC6m+EpmMvMswkw7hyldCniKBPZ9JTa/a4tkFp4rIsGYMIKoTgg+ZLwWQ0ralvdf3J3GW/u2MeIY2HkaAq+5P+/qnpDvySvkaSpPehBgL0uoA8hcRFS3/fet7z2WH2zIfD4osiLxlFhVegk3YRko2TaW0z5K820doA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249681; c=relaxed/simple;
	bh=2mrQ965aNOyL25lReCyXI/DAGszixk+DgWv0xAAZqf8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uz7p7kYhDyVltwWVJObveFbgyM+XaYNDLOM0EHhmq9W9zMBZGt4PuQZNhiLtqPighmIJVIpPI9V4KG9DWYZlNS8vDiVZZSX5dKc40C9YCDgk39OpK8F7l7al/yvQshzoTx00a1Sv733B7ozFsXqhn1OQN7cP2Add9bYNxH0YrIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ifdsKQen; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78802ac2296so31689567b3.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 15:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763249677; x=1763854477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXGZnSu70DIN08Y0wZgdajU/gnoj90NX2WHdQr/BE9Y=;
        b=ifdsKQenuCkFbYlErcumtEHB7MCaBK+jrTWYSop+MA1bI9SXOMY9vZuXKirW4wWNSM
         Qe7ELLdfAe9e62omxkkDndWMjc2hTk2yQ8p5UbnwTmcZ+97CLWVji40SlMxMe3Sdjn7x
         H4dXBI7ES+KA+cY1Rp0ljwSSR0hkcDu0lmPpj9/GGCrEGA62q+4vJQhFLAuCV52yUlgy
         RQFrRPgGqJ/wLXwrMcuu4yRAdIFkoV+CQN6mcFASWo9Ua6ra8c4Yl4zRFY/rj1AoRApX
         euVsoZ+2lZ6wekiH4l49wQ7bW44FvQGuuCF06Ublhl5Jg2DQVGEeW9/V92RV7eE5Zsjk
         Aanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763249677; x=1763854477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tXGZnSu70DIN08Y0wZgdajU/gnoj90NX2WHdQr/BE9Y=;
        b=vCZfAKP8BAf96fb6H2SOHiAXoodigOPUk25lXeLtSJMM4WlsaHTBFGHXvJ6V7a3iwV
         NOfilmk/3a9m7vJBBmi4m5p7AmqzBwuHlGSpMTs1lgVDwu3+Vy6BPtQhOb/lkscc4b3E
         IMqHTkyLCr7I6qWYi37W8IzT9mQ4XjiPurqK9//isfQPNx1IpDaVG4meQEg3LniWX2Dk
         voKmgY7RlnaVrQghiYMvjuiN04upCRnrUQTwt87xK9kpdtlFVCzlWugnDPXnSM8CrumU
         OPPY2nSNjjrXmC5a60CrFXZ84MW1rQJit9zOxi4BRCxOAm6NSpHR737FL+0S7xgNPhyP
         dAMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm33oadlYETtcflPeY3MdYm9ArjEl5cihYZBMZunpwJvlkY4tTJx1UdI+nesfibm1xEh8OnF1GNX7E4oRO@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeuw/dSFx8lFT5yWRAIHBVog1sCF03QbTKc4vJpEG7dNawjoTa
	ZbIuzf1lweu27I3dGxPw4zdTzanhbDFeA6mmTA6O1MeIjwdpWj0jMXjWm7VYHInKi8E=
X-Gm-Gg: ASbGncuVy7NhXbWMjcHWJSmUS0GjYtT5zGB9znKJnkwfpApq1Bm8rcu1yA1VBl8u025
	iZfFEf+Tikdcty2XkMXfoVHTDkyxCPvtbnaoQYlANZn/y1Xxw1tavIIq0B4h0CzrgrjDC/p5BkK
	EpuT/ErGr1IL/E7ZPtZlNlWn0NZohEn2qsJ6JE47wWBsZ3S1u8FiJI4lj1ThK/NfbR0dS/Rllzn
	7CdBsNxdpBhVHudSS44SYs4Wx2CBoO5w1IXsHm6Mm29Ha9WxPTlWWBkCQhpVDOYZbnszOItHDdY
	NM/ZDFyv8xaLap21r5DBMgRou7vzHyOPdYrFEiCRA7N9KazBxTqeSfsngIXGmKtsVkUN6XTNLLE
	3BmsxSiboIyxMo83sT4g/pWAVBj7cfmxFJsWG9xkSoRtrDTBDAxpmzV4mIC8JU/EaoOurKcQpmz
	swfbG3jze/7nPpxanm+lSqJ0bRSpABqKdut3Mx7p0yWIxiTTnmgkqMgYhKfP3oHEKNbWsQ
X-Google-Smtp-Source: AGHT+IEr4ZSX5F0ShTJnhoCAiRSreIR9tV+TAE+bMcxkAeUYbXHH2oKIfnq7gg9dS89JT0P8DLy0LQ==
X-Received: by 2002:a05:690c:9304:b0:784:8286:fde3 with SMTP id 00721157ae682-78929ee3a37mr62160337b3.42.1763249677538;
        Sat, 15 Nov 2025 15:34:37 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882218774esm28462007b3.57.2025.11.15.15.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 15:34:37 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v6 09/20] docs: add luo documentation
Date: Sat, 15 Nov 2025 18:33:55 -0500
Message-ID: <20251115233409.768044-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251115233409.768044-1-pasha.tatashin@soleen.com>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the documentation files for the Live Update Orchestrator

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/core-api/index.rst           |  1 +
 Documentation/core-api/liveupdate.rst      | 64 ++++++++++++++++++++++
 Documentation/userspace-api/index.rst      |  1 +
 Documentation/userspace-api/liveupdate.rst | 20 +++++++
 4 files changed, 86 insertions(+)
 create mode 100644 Documentation/core-api/liveupdate.rst
 create mode 100644 Documentation/userspace-api/liveupdate.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 6cbdcbfa79c3..5eb0fbbbc323 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -138,6 +138,7 @@ Documents that don't fit elsewhere or which have yet to be categorized.
    :maxdepth: 1
 
    librs
+   liveupdate
    netlink
 
 .. only:: subproject and html
diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
new file mode 100644
index 000000000000..deacc098d024
--- /dev/null
+++ b/Documentation/core-api/liveupdate.rst
@@ -0,0 +1,64 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+Live Update Orchestrator
+========================
+:Author: Pasha Tatashin <pasha.tatashin@soleen.com>
+
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :doc: Live Update Orchestrator (LUO)
+
+LUO Sessions
+============
+.. kernel-doc:: kernel/liveupdate/luo_session.c
+   :doc: LUO Sessions
+
+LUO Preserving File Descriptors
+===============================
+.. kernel-doc:: kernel/liveupdate/luo_file.c
+   :doc: LUO File Descriptors
+
+LUO File Lifecycle Bound Global Data
+====================================
+.. kernel-doc:: kernel/liveupdate/luo_flb.c
+   :doc: LUO File Lifecycle Bound Global Data
+
+Live Update Orchestrator ABI
+============================
+.. kernel-doc:: include/linux/liveupdate/abi/luo.h
+   :doc: Live Update Orchestrator ABI
+
+Public API
+==========
+.. kernel-doc:: include/linux/liveupdate.h
+
+.. kernel-doc:: include/linux/liveupdate/abi/luo.h
+
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :export:
+
+.. kernel-doc:: kernel/liveupdate/luo_flb.c
+   :export:
+
+.. kernel-doc:: kernel/liveupdate/luo_file.c
+   :export:
+
+Internal API
+============
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :internal:
+
+.. kernel-doc:: kernel/liveupdate/luo_flb.c
+   :internal:
+
+.. kernel-doc:: kernel/liveupdate/luo_session.c
+   :internal:
+
+.. kernel-doc:: kernel/liveupdate/luo_file.c
+   :internal:
+
+See Also
+========
+
+- :doc:`Live Update uAPI </userspace-api/liveupdate>`
+- :doc:`/core-api/kho/concepts`
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index b8c73be4fb11..8a61ac4c1bf1 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -61,6 +61,7 @@ Everything else
    :maxdepth: 1
 
    ELF
+   liveupdate
    netlink/index
    sysfs-platform_profile
    vduse
diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation/userspace-api/liveupdate.rst
new file mode 100644
index 000000000000..04210a6cf6d6
--- /dev/null
+++ b/Documentation/userspace-api/liveupdate.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+Live Update uAPI
+================
+:Author: Pasha Tatashin <pasha.tatashin@soleen.com>
+
+ioctl interface
+===============
+.. kernel-doc:: kernel/liveupdate/luo_ioctl.c
+   :doc: LUO ioctl Interface
+
+ioctl uAPI
+===========
+.. kernel-doc:: include/uapi/linux/liveupdate.h
+
+See Also
+========
+
+- :doc:`Live Update Orchestrator </core-api/liveupdate>`
-- 
2.52.0.rc1.455.g30608eb744-goog


