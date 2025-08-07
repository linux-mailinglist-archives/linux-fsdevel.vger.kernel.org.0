Return-Path: <linux-fsdevel+bounces-56948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A336B1D08F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 03:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433921708EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 01:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC3E227599;
	Thu,  7 Aug 2025 01:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Q31CMqbt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B7B257AC7
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 01:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531126; cv=none; b=GfqDIprOWU73oUQhyZ7jvxsK6FjL1ISYdN5fe3gyBQ7oUth9sAsS4LEv2Xdis4AQ69uejFoc/k2EKZGh5Y/U8IhPCnkT7DItTGCukmIC1QD03k5MkZ0bpdVf5I+CqCZnnZ31imPXKJ/dFF/x0woPdFHLwinP66jkIGiMRJI2JcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531126; c=relaxed/simple;
	bh=UP+tTKO8bTmYY5fR3f5WgKrqzkcSSflb/PbEDUyLyGI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqGpLnw+TiVi/ZOW0q44p6WK8JHYv+Nuf/9UYy94ERRwWuQ50t+5rBzM59rrASxoPDrR5ap+k3zcJabXlROJfKqpMvdxpQzM/ZL+TJB9ICivNcZzEDzlfEYQzd2yaKL5LedO5uYeiirTvtZl51JXqWxj5+XAUERdOAp73f2tFo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Q31CMqbt; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e2c1dc6567so35168185a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 18:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531123; x=1755135923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGzTQ+v+K/aDaHLB/ImuEc3dGBvilPrPVquoyLgmTGc=;
        b=Q31CMqbtC/2m7/iYzYo6w3yVUrIPBZ2T4f3K93wetHSduR9Q58N/8m4gax2mIpxC4W
         OWTBVnzfGngopUnsG4Md3DnYxOV0gmC0yXFYtvirvn37qWZ3Tbe5hKpUhD72OqpHgDr5
         MyTVIYob57EMv+igLq5GantSC4GmLxiUKFZs0W+dXKVWg2xMC0aoIo3PXrVIM/2i8jA8
         OYkxZUJ18v2ce+Rf/mPcgxygjsmeHXDjA2M23NLTUezFlTf0Vk95pPpArWsp0WrbbKwm
         LBxtXiv6dazu2CIerewSSocUVZmxxQoU2eIAxkDsc5cVzjpBqKv5uEyToKY72ftatRSs
         d+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531123; x=1755135923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGzTQ+v+K/aDaHLB/ImuEc3dGBvilPrPVquoyLgmTGc=;
        b=M/1KS+QHwKREfOiuueyhpMbvEXedzUMl/2Bofu3Yu0rgxZDADTP9KGSPrEd7HcGXgF
         H2kpnrb7S5LhcJ4dKlkrNKnq5g2nR72OjsvG4L65o0yfO0KSdipa2J67p1xBPK5NZMwM
         K1pTKxMNuVSxXE9mktRMnIjyo/sWHgmMnXmkWdCtJ79RPZ8YSaEXgsCC3gRYxvqhkB3t
         5fKhfSpUwex9voGiC6d8FT4umEXweRKUE9ZkUAjKkEgAqfvrb3q4iMCY1wNHy2tQVtv0
         cWR5FZPwgLfZ8K5yNjqzNBwVlbTzpEk95hfD7fgbP0aAxi+xO/Vi+SSBOzcW+703mQEH
         uM+A==
X-Forwarded-Encrypted: i=1; AJvYcCWq/iAoYZ/J7QEaKmzTFIClVSmH4XvlqszR3PQ0Rhc+YiemnY4Q9MJLyuInFW4G5icBSKPIrRE8NlBY9jdr@vger.kernel.org
X-Gm-Message-State: AOJu0YwfRtoh/vca/4v40fUhEGKPBsKtqWiQXQMejSZ34STykSesyvzm
	qUL2vzQ3HbF6/aTJfNJEFvsVNj4IJeWs9t2QB0ANIVyUZ7I5b2ZQcCpupFM8zLK5QAQ=
X-Gm-Gg: ASbGncvfP6Wmio+UJ90/d2TSzO9FtuCpHOPhAme1cNODNFqzdrxZPBtuKsfmrDw9X91
	pbmho4uIWhBlCOvMseqM7ZHSdVyFcVPtCZPbItz4pDDnoWJsBKTbDgUuqkWPl6DzpP2jkY+wUj8
	stmNkeJhGxVEx61MCMhmfKFtnOSQSuxUXkMDWEioe5WSTbPywkuc1ey+kTP6MH3oq8b8KQXHAxB
	9UTTwN5+468+nTpJDbk7GeBr0+I9YUgGE9/McQOEBXxk2pxDiS5r+BWyRQh6xweOn1sS4ZZHrwD
	r5Djb+rBv/1LqBZZIRfAD//iAWGN1YxoGg09EZYq5vcDlLYWIbynq88BYWJw3XsYja6JB3J35dH
	T45V/5e983gbzsVrTWrOyHJRUE9iXP+BMuwBy1wtcd3ksCjjDiQu94/7eWtnNw2+b69MonPNTEE
	YbmcBJg9bi4eCte3+5JA/UUxY=
X-Google-Smtp-Source: AGHT+IFHcYm7yT/4Xvuv4TWFZXCA+gfPfNAN3UieGuxKRFyW9+H99+FaVZtYe/cgGd4cOSeq4i1AXA==
X-Received: by 2002:a05:6214:2522:b0:707:5dac:be09 with SMTP id 6a1803df08f44-7097add7f30mr59186586d6.9.1754531122925;
        Wed, 06 Aug 2025 18:45:22 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:22 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
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
	zhangguopeng@kylinos.cn,
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
	witu@nvidia.com
Subject: [PATCH v3 24/30] docs: add luo documentation
Date: Thu,  7 Aug 2025 01:44:30 +0000
Message-ID: <20250807014442.3829950-25-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
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
 Documentation/admin-guide/index.rst        |  1 +
 Documentation/admin-guide/liveupdate.rst   | 16 +++++++
 Documentation/core-api/index.rst           |  1 +
 Documentation/core-api/liveupdate.rst      | 50 ++++++++++++++++++++++
 Documentation/userspace-api/index.rst      |  1 +
 Documentation/userspace-api/liveupdate.rst | 25 +++++++++++
 6 files changed, 94 insertions(+)
 create mode 100644 Documentation/admin-guide/liveupdate.rst
 create mode 100644 Documentation/core-api/liveupdate.rst
 create mode 100644 Documentation/userspace-api/liveupdate.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 259d79fbeb94..3f59ccf32760 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -95,6 +95,7 @@ likely to be of interest on almost any system.
    cgroup-v2
    cgroup-v1/index
    cpu-load
+   liveupdate
    mm/index
    module-signing
    namespaces/index
diff --git a/Documentation/admin-guide/liveupdate.rst b/Documentation/admin-guide/liveupdate.rst
new file mode 100644
index 000000000000..ff05cc1dd784
--- /dev/null
+++ b/Documentation/admin-guide/liveupdate.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Live Update sysfs
+=================
+:Author: Pasha Tatashin <pasha.tatashin@soleen.com>
+
+LUO sysfs interface
+===================
+.. kernel-doc:: kernel/liveupdate/luo_sysfs.c
+   :doc: LUO sysfs interface
+
+See Also
+========
+
+- :doc:`Live Update Orchestrator </core-api/liveupdate>`
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index a03a99c2cac5..a8b7d1417f0a 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -137,6 +137,7 @@ Documents that don't fit elsewhere or which have yet to be categorized.
    :maxdepth: 1
 
    librs
+   liveupdate
    netlink
 
 .. only:: subproject and html
diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
new file mode 100644
index 000000000000..41c4b76cd3ec
--- /dev/null
+++ b/Documentation/core-api/liveupdate.rst
@@ -0,0 +1,50 @@
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
+LUO Subsystems Participation
+============================
+.. kernel-doc:: kernel/liveupdate/luo_subsystems.c
+   :doc: LUO Subsystems support
+
+LUO Preserving File Descriptors
+===============================
+.. kernel-doc:: kernel/liveupdate/luo_files.c
+   :doc: LUO file descriptors
+
+Public API
+==========
+.. kernel-doc:: include/linux/liveupdate.h
+
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :export:
+
+.. kernel-doc:: kernel/liveupdate/luo_subsystems.c
+   :export:
+
+.. kernel-doc:: kernel/liveupdate/luo_files.c
+   :export:
+
+Internal API
+============
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :internal:
+
+.. kernel-doc:: kernel/liveupdate/luo_subsystems.c
+   :internal:
+
+.. kernel-doc:: kernel/liveupdate/luo_files.c
+   :internal:
+
+See Also
+========
+
+- :doc:`Live Update uAPI </userspace-api/liveupdate>`
+- :doc:`Live Update SysFS </admin-guide/liveupdate>`
+- :doc:`/core-api/kho/concepts`
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index b8c73be4fb11..ee8326932cb0 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -62,6 +62,7 @@ Everything else
 
    ELF
    netlink/index
+   liveupdate
    sysfs-platform_profile
    vduse
    futex2
diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation/userspace-api/liveupdate.rst
new file mode 100644
index 000000000000..70b5017c0e3c
--- /dev/null
+++ b/Documentation/userspace-api/liveupdate.rst
@@ -0,0 +1,25 @@
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
+LUO selftests ioctl
+===================
+.. kernel-doc:: kernel/liveupdate/luo_selftests.c
+   :doc: LUO Selftests
+
+See Also
+========
+
+- :doc:`Live Update Orchestrator </core-api/liveupdate>`
-- 
2.50.1.565.gc32cd1483b-goog


