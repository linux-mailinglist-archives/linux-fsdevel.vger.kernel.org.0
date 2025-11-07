Return-Path: <linux-fsdevel+bounces-67486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD8CC41B43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 22:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48023AB304
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 21:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8E7341AD8;
	Fri,  7 Nov 2025 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="N3nULHcE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E433FE33
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 21:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549557; cv=none; b=P7jYpS08QirV3cL2CBehuo22jTMSWgf8QFr6mbvVVhprGKjub+kRi7zl1Wm+Vglft91Tz2mTkDieiJWDG2iGUTd4qgXgy9bJC6R8pohsVPaCKTxqFXCK4LM2ZGg18wyvKZm9wTp6nmiJefok+MEo4NBu8ScnWqSGuDz0cCDqyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549557; c=relaxed/simple;
	bh=uKOjvZQKso7oyRqI+EFwVBOcyaYMS+ZmmItsS5LMjXs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHVYNQBsSwg5Z1pyRyRU1PyDZnMKKqazuUMxSBJRiZdJLR0HD1fmVD6WKXzN9+uJ2PF9QzlDxcktpOKCoJN2+K1ZFsOjIiuMbbyJJfNrvCpdm7q2qX0FiJFLF4G0CclbihMI7fYUBUHgTMgEbNxzcITcE5iZbPqhHxBLpT5DVDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=N3nULHcE; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-787be077127so14125037b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 13:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549553; x=1763154353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGX1JNngtcEnINGvpjjZOvPiM15RTyTbrS+2qficDEY=;
        b=N3nULHcEfeJW9vb0K9acHjVYC8tnA7xB98Bn2gv4gK2+UgBeEgiK2dMxzDLMwHON7c
         es08N7fsAL1V1801m24UcvZ/Wa83Iq2hRAE5dPkLDuf+bV7oLVmb77nuawry8Dmw+7qd
         sw2DYwiPslgPCcNI3gbBvUIkO4wcnsiTJa90lv5ki74kzSpxxUdmRp2REjhjh6LNSDC7
         ch5QyN9+L11E1xRNc/PtkTq0iYTZb1ZCudkOozxk03ZECJ9LEjLB5X1YkO6L6l1pjKiv
         V8JCoU5ni/TiPTx/YxwjOzvDuKnmooWw6hWpfUAUioekHuDP8CU83G2nOButDFevqZzJ
         Qr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549553; x=1763154353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eGX1JNngtcEnINGvpjjZOvPiM15RTyTbrS+2qficDEY=;
        b=fcCXe6d7hOiJt8U0DpcYsYdEGj12m1xE9h2wc1cxV7nM5IBf63P0v9JJLNjek0ie1c
         Li9ea392vqLKJzPj2XN/XAshkJGJmbJwXF5HL2OrF5F2RzNp0i4lWsmk1GjWih2anF/C
         qi0kScpbQk8PATEzFnxnpNNOooiGyBk1pVPkdNyprq2sD2o9qdf5TlJCwTxmFbQ39u1N
         4cz1VP/Cv9hBOkeQgug3J90RP5ttVGQCwK7iuYaqaawoeZvxYhkhSklgMLTQBWNX3D7S
         i6+BLStUWotvKiH230c/ppSJMouX56ja1ghqenfbD8V+ZXW/uI6w55t8QSxOY2a18uVY
         KIZw==
X-Forwarded-Encrypted: i=1; AJvYcCVyw+d8huicVeJEw06SZW8oPyVdsK0GDxD3B1ZufqAJ4/Qo03STpV9n+vCtxnuiFAmPQI3Ote8gAH8aHPFl@vger.kernel.org
X-Gm-Message-State: AOJu0YwanFgAJ9dlGtoNrrRt/Y/dbA0cB/u2emkaaiQ5u7a7LEET2Qig
	qiJBXHBTwjEnW4bJhUGAbqGcsR0zvPTMOXyotks7ukX+RAcbQPW6ylPkmbgw7P2xKWo=
X-Gm-Gg: ASbGnct+OwzCIdeBh0RepgmOQWO1JWiqFaNjTRHyWxX2WqtvEIzbd/FAVeK9qB0cU3u
	yp9Lw+bixfR+KuHWf5KtgIFBaATzF4MtV/WLoG/ImnLamfxHekmUBmuWax5jQEUrSyxq+t28ICc
	lcu9K7/JKoUMZQfwfH8IDig1omGpvH2RzsGPDb0hDGDBcNoANHGefo99S2AFcXkoievKV9JjkeA
	vGDdHKw6XbXy3baekE2V05Q5WrqmdyHZOkiTkQj1Pyjz6jJsuK0cKBqreY0s9xd//TWtkvMKCUP
	aWqPznfogfpI0lAudvbAIV0TpszFFmJfGnQiaMrUpVbE/SFA3RSG5yXpd4zCPqHlTb/9E2H2wnA
	fdJtcWZ1kZDRd6dbfl+cI9VYHN52kQ6a94ZKybOhCZ2DAO9sAHDY0IDfFHszzfBb2PXvGrrP4Nd
	WxiIVztLZ8CG/lSRFU7fiAb5Z6zP1VR1fnb8PD5PLLrkR0XiMNofZJL2aQSm9IGwzEthrEycUmb
	w==
X-Google-Smtp-Source: AGHT+IFbkLlhQosQFQ+WdXArr3gHVo/6dHC8xvUgFjTdDqpIfNT6vGARK5zq5TsgxqtRCa2zCH7RmA==
X-Received: by 2002:a05:690c:c341:b0:785:ec4f:3c8 with SMTP id 00721157ae682-787d543901cmr7438187b3.48.1762549553481;
        Fri, 07 Nov 2025 13:05:53 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:05:53 -0800 (PST)
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
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v5 11/22] docs: add luo documentation
Date: Fri,  7 Nov 2025 16:03:09 -0500
Message-ID: <20251107210526.257742-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251107210526.257742-1-pasha.tatashin@soleen.com>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
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
2.51.2.1041.gc1ab5b90ca-goog


