Return-Path: <linux-fsdevel+bounces-69497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69172C7D95A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 23:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8533034CDFC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 22:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164772E6CBF;
	Sat, 22 Nov 2025 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="kUNpuhcm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714722E2852
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850270; cv=none; b=LwLIxWidofL2Gl+Y3AR/b3Oi+UfyGie/ZhVDSlMEbNNimFiOHRQDYbFe0Mt2zMXv+30VrCbC21k/LLJZxHDgBP/RsVZXpB5FiCsX/GLyKQPV73aEdcULOIr9eZa4Yj7VfaS0lO68BE3BH1GK/9T6lUCpVPC+z8FvK73fNZe/ToM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850270; c=relaxed/simple;
	bh=HckDMYe0+V7dIt+99RvEfUMzQcIYTFKI66vYhRUdjQA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lje2L7RbG/y7nDRTNf9EtvL0snzdDPrvOZmxhzwWlS48ZuyneLLXBwIoqMh2D/KtIdPB+1vRjZQrGQBKr4DKvBxFvNqZYD0/hP3FrT4yJ+fsTInBVxEncRqYNDKMP1IaBZRr8ueNWO81DQb94m3iVMJZXezEcmrUlQyba8YxLto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=kUNpuhcm; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78a76afeff6so32530907b3.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 14:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850266; x=1764455066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8oZaYRe5g0R4lweOQLAK81RG676DLPyUWLh/z30V3oE=;
        b=kUNpuhcmhJRzDdbopx+yw1ynUATxeENtPf4tOwHPPENr78Xz1DbY8zuYNGC0GNDPTa
         ZSk0TiTXYZP4GoAEH9ga0HJqU7yWWdru/Vbpyg2wwwpx4nYuC2OigJLFMpv3MSCnRcss
         8VgrDTkHGCLQ2t+gaP6n4rUES77FYvAgAmH9IZYo/H9rQV17xQZyJy7R5ks7GABKkWi8
         Grd5BW4wn5TyZ4RKzBrN6WPo8lbCWq4ImT2WC5mW72L4pS8dme6t1iJHvyM6T+b99QKd
         M64TuQZrRsHu4DEhr8Ss9BfKanjC9absBmTvPnBPvDDnPORW8ckvh/ZjV71fAGyb5XFP
         Xi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850266; x=1764455066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8oZaYRe5g0R4lweOQLAK81RG676DLPyUWLh/z30V3oE=;
        b=um7oYtHHKZZotYL/J0Q35pO7j7Uao4o8SMu8x+/aw0oLIwzEACl+1N/PqowepTH8GZ
         bbKBIKCMDt2RyugidigCkEc3qszhxURIcPH4si2886NBLVxT0bNThPtwWmpUiJUl2/RX
         ts9i94G09TZFlslQeFBYlFFKTQT1qpF5a23431FHpjyqdiSqfp8qyIhmJTpUQ/SMBD0e
         qqA37PmnKMKCbsetm0jnXVm7S/SY3SSXyxP6rz/VOzBJ9PHxAf6kOFZrzVUHA6x8nHBA
         5cGlFtkjup1QWeuGRkj83fp03aOMtZrw+9S2pDezQ6UmL6MddEh8xOiKPp4iAO3/2E3+
         oVvA==
X-Forwarded-Encrypted: i=1; AJvYcCVC3bkENwikjUNX5hhJoNOZJlEMfqTWtfoWC1kmmqssabPvv47XLAve596PJuJD0SprU/EoZPOg9BcX6d6W@vger.kernel.org
X-Gm-Message-State: AOJu0YxwTXfbyBOSg3xJWVALpcpozIaBhXtWcrz721qKT2Cfgt4WZF5k
	+Tg8YxwgS3YeuOJHKDk4lzWzfpScF+ElL3Zh/vRvScgY50bewwINp0N59zE6GGRU9yM=
X-Gm-Gg: ASbGncvoCPDLRwi+XyWDwmMbHyEUSv/9stJaIK5JJPYQpTOWGdngjRrp7FlH7y+fDXc
	jfDa75XlnPR1wt3alFpS6MssGHTQUwGsF91KHOPZRso3qdqE2hr8a3QVAUEpxLiwx8S2//5YxYg
	mYot56i1ILhsLOTamiiP97HihcZQOJoEOtvBUe4iCH8W2Ob0JWp3Wy9BtKfspcAQCVRGy9X+o4+
	9kx3oYUzmPV7vFwyrTw+x9w5dJ1+aJkoK1N4vF3toln1OlOsvXZjeefeJJ1jRLh2pDmDeF7VoVK
	ay/sRJ8ML/BMcI4MoTVYOBjxEcYcP9LH4smaPB93lN+AZVC1oscE94mfWbXg3ffEkKCmFrB6nvI
	7vuT071Jeit0N7vNeJYJwPKJnHuJ7Pi0ljPNg2cAUvwM5gN0eLvnn6bFFL2QW1sBYx+8iSVjMyR
	LYOUYGNtN3Pv7W6pIvpv/oqCfQ1i7injswfFUr+L/NUeP9ZCaIgoCwb4B01EvZLbmcoIn0fpHfZ
	OUCSOp4U0jPQol5BA==
X-Google-Smtp-Source: AGHT+IFA8xiqyidX6vSHxt0Fa6KY7zq1D81H8XmTPSjBAk/TG7qP+fvxB9otYVm16cp+k+p4xO9fVA==
X-Received: by 2002:a05:690e:118d:b0:63f:b634:4224 with SMTP id 956f58d0204a3-64302a427cemr5083872d50.21.1763850266314;
        Sat, 22 Nov 2025 14:24:26 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:24:25 -0800 (PST)
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
Subject: [PATCH v7 15/22] docs: add documentation for memfd preservation via LUO
Date: Sat, 22 Nov 2025 17:23:42 -0500
Message-ID: <20251122222351.1059049-16-pasha.tatashin@soleen.com>
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

From: Pratyush Yadav <ptyadav@amazon.de>

Add the documentation under the "Preserving file descriptors" section of
LUO's documentation.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/core-api/liveupdate.rst   |  7 +++++++
 Documentation/mm/index.rst              |  1 +
 Documentation/mm/memfd_preservation.rst | 23 +++++++++++++++++++++++
 MAINTAINERS                             |  1 +
 4 files changed, 32 insertions(+)
 create mode 100644 Documentation/mm/memfd_preservation.rst

diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index e1f0c13d5b4a..b776b625c60f 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -23,6 +23,13 @@ Live Update Orchestrator ABI
 .. kernel-doc:: include/linux/kho/abi/luo.h
    :doc: Live Update Orchestrator ABI
 
+The following types of file descriptors can be preserved
+
+.. toctree::
+   :maxdepth: 1
+
+   ../mm/memfd_preservation
+
 Public API
 ==========
 .. kernel-doc:: include/linux/liveupdate.h
diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index ba6a8872849b..7aa2a8886908 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -48,6 +48,7 @@ documentation, or deleted if it has served its purpose.
    hugetlbfs_reserv
    ksm
    memory-model
+   memfd_preservation
    mmu_notifier
    multigen_lru
    numa
diff --git a/Documentation/mm/memfd_preservation.rst b/Documentation/mm/memfd_preservation.rst
new file mode 100644
index 000000000000..66e0fb6d5ef0
--- /dev/null
+++ b/Documentation/mm/memfd_preservation.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+==========================
+Memfd Preservation via LUO
+==========================
+
+.. kernel-doc:: mm/memfd_luo.c
+   :doc: Memfd Preservation via LUO
+
+Memfd Preservation ABI
+======================
+
+.. kernel-doc:: include/linux/kho/abi/memfd.h
+   :doc: DOC: memfd Live Update ABI
+
+.. kernel-doc:: include/linux/kho/abi/memfd.h
+   :internal:
+
+See Also
+========
+
+- :doc:`/core-api/liveupdate`
+- :doc:`/core-api/kho/concepts`
diff --git a/MAINTAINERS b/MAINTAINERS
index 425c46bba764..cabbf30d50e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14473,6 +14473,7 @@ R:	Pratyush Yadav <pratyush@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/core-api/liveupdate.rst
+F:	Documentation/mm/memfd_preservation.rst
 F:	Documentation/userspace-api/liveupdate.rst
 F:	include/linux/liveupdate.h
 F:	include/linux/liveupdate/
-- 
2.52.0.rc2.455.g230fcf2819-goog


