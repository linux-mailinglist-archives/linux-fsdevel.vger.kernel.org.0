Return-Path: <linux-fsdevel+bounces-69490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB03C7D8B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 23:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F7A14E11E9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 22:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F642DA74C;
	Sat, 22 Nov 2025 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="EKZSh50U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB12D879B
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850256; cv=none; b=Wia7EMuO0h+khpOyYX4hj21yIEmWyABzYS6J2Y7sxJML0ydjH7APJcbhCTz7wRjxe9X4ZvGMrRvWbmxcnb0Z5PfI0r4hcUOyMU8TIoTayYfWDY9BkSYzYf0OmedNxYPWz407zcc0VCwwr3qB3S6mYOgN7bFMzd876g3L1Y4BkOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850256; c=relaxed/simple;
	bh=1xESM3kSF6vnWYSb1QgtWGhaZBJp9gmYV9s8UUP630A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kzm0vuZase7gQ85vcExFQVHdHNwWfAhNCf47wdAEghVfQ94fa4NCliBnvz07yEcRB9lD2fhMfUr1eMnT9J19fMmw4Eawt3jgLo9483WLeq2BZ5UC77zcBcC4G/kkEOdYgDYxEv2IepA+QjHh82CGOhksNylKxUSNnZ4+Nn54/Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=EKZSh50U; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-786635a8ce4so25677477b3.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 14:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850253; x=1764455053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9VyPKNhrn6KupO2JDxcjMrdrPrlD9k+PG4k0aWwewA=;
        b=EKZSh50UwQFxjlcTV07lk8FgnLcovZponwg3MsyQ0oXvmZnzthjz0qar0sFedeADGx
         WN9d+Ujs5MJwp0+78pdJiAubqSXrs2j7gvXOrXEqe4obDVXZHRFa24LPtT0yrcmq8+JR
         eRyeSkJSBb0ky5giXZdPKNgaltJn+UucOOn1o1h+Br5ypohMNzsjyTwUHCQGzXhXjrSg
         XnS1GiexdfM9Hs6HY6pSDI856IcXMueeyM5S+UIZkLb9Yb5qpwws9HdMoIkglCO0lmSr
         JQ9VFWY2VUpIgC018HBGYRHvQHPHuC94PkkPgQjhoadlyXPehjwECUEO7rdpIGy/u0mz
         wvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850253; x=1764455053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G9VyPKNhrn6KupO2JDxcjMrdrPrlD9k+PG4k0aWwewA=;
        b=pmzUS+85LcjJEtgsydRrQL2R6vKOVGUtGsLB38lHw4P1MUpyDg7VPmiKUNcAEgg/81
         Kvl9piIkaN8s4b0f6PDVZIng7kqV2dNeTjlCBSnMNxI1AQxUFWu7frTbCHL8oKOP1Vm+
         UBrnEE9u99z8PaJkE3Od0RdFDKN+2e/DZCX5R+WRmeXgjoyxIyHWwWDcuRAmGcSeqbZi
         N7SDlAdC4uUG/MYr0Qh66fxxJ1VQk7vqG+jdhXECLyaM4NUm64fbZW0dSjpXJoYIpfpU
         XCSerhuRsUrwlrGey0aRkT7q1sKIox+kJrT7x0Vk7mhkF7Pl9Upn8sWH5xrxkMxElDuo
         q18g==
X-Forwarded-Encrypted: i=1; AJvYcCWokzl25JsnUcAPeinGUblySZ7P6Yys7tAzN2tc5/La6Del9iO8ycjYburdwxNZpGgjEBrQmlMqUcbrFoz5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi2TmC2CL3HMg0B1r9bl1tVzlBwxKhEtc6ixX0hLMc6mUwwjQA
	3mOwbkY6ghwp8Q3HgM5LZN14mB1R0giy1g3CxqDvxYjsNv36rkOf9gfX/qfXDCnFzxc=
X-Gm-Gg: ASbGncv+Pqj0qsXU9nXe/bxBU02Br0KABv7fpfukBOVGipYpkPY7O4ePQm7dEXufhO4
	InNsZ9rE0hSm17gQzFb/eKCwzd4TG4FEXcQgmzTlJsfHC3Zg9mKVVZNmO+8qAyDe4HEdfkMnGY5
	+C1RbYwzBsBBLwxXqwgdtJaft82c8q2DHdrc8EJPzxLKoZn0r3yoqIcyHZ6dC5NSUo3ydosbZFv
	2L7Zb8zbYJXz3yMqoX6seewSySFmSDcqCeFMLAH2COoAkeEn6WuQ1Uoj2gE9T1/zKzcPsuj7oeR
	PVREfLSvC7riBe2FLhAgfrkgM9dXMPhx6vmuBu8jrf7v1OleVF4j29ZpQs4Mn0gupu5uGAH9UF9
	nWJGhAeJCszRLvjEtcwbKxX0YfnQephwITsBwDQ3A0QRzo5sHP2RxaaWbAHXRfB3zSLL2kbnPWP
	LMwYDnLTJ9LroPfQZmiNhZv8MvjAkp1iMyplG6pvds1tFxF9lmfduSAzjONtx/4HNEvIz2tlh4O
	/PiXmgYFYJJk4iawg==
X-Google-Smtp-Source: AGHT+IHmRWFE7rOb/6+yLAu3Pk2al1IPioQp+ETOH2bTApyjFAeLipumKzaBW+6hLLJxhT3rh6iVOw==
X-Received: by 2002:a05:690c:d88:b0:786:a39e:e836 with SMTP id 00721157ae682-78a8b5672d2mr62717227b3.60.1763850253309;
        Sat, 22 Nov 2025 14:24:13 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:24:12 -0800 (PST)
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
Subject: [PATCH v7 08/22] docs: add luo documentation
Date: Sat, 22 Nov 2025 17:23:35 -0500
Message-ID: <20251122222351.1059049-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
In-Reply-To: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
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
 Documentation/core-api/liveupdate.rst      | 53 ++++++++++++++++++++++
 Documentation/userspace-api/index.rst      |  1 +
 Documentation/userspace-api/liveupdate.rst | 20 ++++++++
 4 files changed, 75 insertions(+)
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
index 000000000000..e1f0c13d5b4a
--- /dev/null
+++ b/Documentation/core-api/liveupdate.rst
@@ -0,0 +1,53 @@
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
+Live Update Orchestrator ABI
+============================
+.. kernel-doc:: include/linux/kho/abi/luo.h
+   :doc: Live Update Orchestrator ABI
+
+Public API
+==========
+.. kernel-doc:: include/linux/liveupdate.h
+
+.. kernel-doc:: include/linux/kho/abi/luo.h
+
+.. kernel-doc:: kernel/liveupdate/luo_core.c
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
index 000000000000..41c0473e4f16
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
+.. kernel-doc:: kernel/liveupdate/luo_core.c
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
2.52.0.rc2.455.g230fcf2819-goog


