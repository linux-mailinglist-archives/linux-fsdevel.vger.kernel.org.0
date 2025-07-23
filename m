Return-Path: <linux-fsdevel+bounces-55853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FEAB0F608
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E277458812F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93E72FC3A1;
	Wed, 23 Jul 2025 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="ksU/galY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100EC2FC01B
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282050; cv=none; b=TvwJi/m6RCxhBMsJmKJP2jfFbAI3ZFein3o2RZFhbeKEznIub1BMdKKoLyfUAkesyjSu4UK5udRQ7LqaGwogtJoaB0jZJb9Qk9gdLytb+Cg/z0kRQI5OPOuB+q3+qUvnr1EL+gmhh+iEqfxVM9ktiTdke78vGXLkvzoOF8sV44I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282050; c=relaxed/simple;
	bh=h1L0cbeVfJxO9kghsvJ6bWhgk+o6POMPbs4sljzTVS0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXJ646X09EsJKfzTbhT7RGVZ3xQMSroI2HNIt1hNFwVI07jSuqA8vI3J44WNry//y6q/gJ0FPHWIr827Di5Qdn9TvSOGXyyUyBgAGPWpNuP34McHtfcDuVZ46mR423D8aoFl/ZLoN0Q8D0Fa8oUPrye/HvYPbBN71R3gdaDFS7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=ksU/galY; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-708d90aa8f9so63906487b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282040; x=1753886840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UX19BNUcwB6TjSqCz6om7S5yVRpVe4SwKywfTR0ocE=;
        b=ksU/galYA/CnJq8mbRbvGlg59PEgswL5MSxvTNKED3a9CycFHuIrRmC5UxRuqmDGly
         iWfsXZayuhJXIgX0oE3b22ErGFEXCi/xhmYA8Cw1EWD7IYr2T11ke5HbYZ/QtAUZ/Ngb
         5BnmuBrOyjAxngM0/m3FI8OtwwNBFEAGQGNn/peEU314L6Ts1lamt7GhzatA3+cOfUcS
         S3EVwR8xobm0jOqUmXDM2pvW5IbL/nHqDu2OEK1/GFhpVuO2X6x7g9ybz0yumLF098gY
         QDYnabfzwDM/IszMbrfH2lXi5UAhx+hEgnXWPzZo3KVJeNaIb3J4fwizMH4EjZCWOBE0
         t0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282040; x=1753886840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UX19BNUcwB6TjSqCz6om7S5yVRpVe4SwKywfTR0ocE=;
        b=n+66Anhf3p6Xt51E0Jg/t8ysHhOxtYLVtioARgD1ost9umJmY90t4hxHHgrgs8llfg
         X/RxGYRMKLSksiX2teVUSGeri2M247V6OSWRlK8rD8A0KYMruNw8DNnTi5N2KBFIa6at
         01gXjWRb6vX/5dOM3f8VuHa0r3d/PPguIAaSjGRSmGzmHNQvuRmYs1QoyQmHHvSr7DML
         zh5aa0cXdtzLNNUiZATiTxKTQ8pJeTa8zcl7kLMikt/AQ99blaQgtDq0RG26VNakDEBU
         mPKZW8bcj6zkV2L2OtC3Hmy3bW1NTbHZgKqbh50qYZjNPguS4UtG2z6o/XnydBVQNPbf
         tFbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5dkRCGr1EmpLbQaLWgafWzgpR+30EIl4MpGH7gp9vWwUK4san3VGdfdxhD4Jw5MqW1ttq8CkKotjMjNOZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwMXHGhbuhffRNltWMgkikcwDS3ePbLL0XaoiR4rjn/JodvZHFU
	gpg9MD6v6AGGMt0e96CFgETw3eMWtezSoeAQ9EBUr8NJ+UNuTCyIQfctkM5zdJm2z+A=
X-Gm-Gg: ASbGncuVhy7S08xKG++/M1RwErGi64v5/Wgiz6hD4wCqQZYVxiF1hrJWFD8emzvYR6B
	wvOTSbvswebqAvvqKHauqSWDQLZ6SxfQECTLjTDPxlX3jct2SKtryK968bYcUNG025SQSojymhy
	+LH/nY9QtiIyYzahe069JwNTt39HnRygslUsuZcBRcZuFPP1L7H+Iw7/JaSSvE3WgXeR1yt9stv
	sz9izhw3VpCxu88YjLo0OXZ/xrln6zavqJiRXmTRBNW/LU75StNQSxhYMMxvgyBVxZLuYCUA5l1
	SN+nskLmtQzVItcvRew7aqVxqIfkerJvRoK6fEs9DvbzdItrVAtKE/GX8Kc+6qbXWs6hDfLuBU6
	xRoIuZPjyWwDf61F2dfCCuX2ozub3o4oGuRpRy3hqQVv09JU8KyOlkPq1KSWP2InDm9ycxlWLes
	W3zGBjExkbYPw0SQ==
X-Google-Smtp-Source: AGHT+IHeWCg5lvgS3ayNuzJMHqUh46fT1SJdtuE/GRTZAvZI/FWwWLnu+spwLbexNESx5UBQY3MOUg==
X-Received: by 2002:a05:690c:7202:b0:710:f2a1:fa6 with SMTP id 00721157ae682-719b4335d19mr40934067b3.29.1753282040576;
        Wed, 23 Jul 2025 07:47:20 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:19 -0700 (PDT)
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
Subject: [PATCH v2 13/32] liveupdate: luo_subsystems: implement subsystem callbacks
Date: Wed, 23 Jul 2025 14:46:26 +0000
Message-ID: <20250723144649.1696299-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the core logic within luo_subsystems.c to handle the
invocation of registered subsystem callbacks and manage the persistence
of their state via the LUO FDT. This replaces the stub implementations
from the previous patch.

This completes the core mechanism enabling subsystems to actively
participate in the LUO state machine, execute phase-specific logic, and
persist/restore a u64 state across the live update transition
using the FDT.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_subsystems.c | 140 ++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 2 deletions(-)

diff --git a/kernel/liveupdate/luo_subsystems.c b/kernel/liveupdate/luo_subsystems.c
index 436929a17de0..0e0070d01584 100644
--- a/kernel/liveupdate/luo_subsystems.c
+++ b/kernel/liveupdate/luo_subsystems.c
@@ -99,6 +99,66 @@ void __init luo_subsystems_startup(void *fdt)
 	luo_fdt_in = fdt;
 }
 
+static void __luo_do_subsystems_cancel_calls(struct liveupdate_subsystem *boundary_subsystem)
+{
+	struct liveupdate_subsystem *subsystem;
+
+	list_for_each_entry(subsystem, &luo_subsystems_list, list) {
+		if (subsystem == boundary_subsystem)
+			break;
+
+		if (subsystem->ops->cancel) {
+			subsystem->ops->cancel(subsystem->arg,
+					       subsystem->private_data);
+		}
+		subsystem->private_data = 0;
+	}
+}
+
+static void luo_subsystems_retrieve_data_from_fdt(void)
+{
+	struct liveupdate_subsystem *subsystem;
+	int node_offset, prop_len;
+	const void *prop;
+
+	if (!luo_fdt_in)
+		return;
+
+	node_offset = fdt_subnode_offset(luo_fdt_in, 0,
+					 LUO_SUBSYSTEMS_NODE_NAME);
+	list_for_each_entry(subsystem, &luo_subsystems_list, list) {
+		prop = fdt_getprop(luo_fdt_in, node_offset,
+				   subsystem->name, &prop_len);
+
+		if (!prop || prop_len != sizeof(u64)) {
+			panic("In FDT node '/%s' can't find property '%s': %s\n",
+			      LUO_SUBSYSTEMS_NODE_NAME, subsystem->name,
+			      fdt_strerror(node_offset));
+		}
+		memcpy(&subsystem->private_data, prop, sizeof(u64));
+	}
+}
+
+static int luo_subsystems_commit_data_to_fdt(void)
+{
+	struct liveupdate_subsystem *subsystem;
+	int ret, node_offset;
+
+	node_offset = fdt_subnode_offset(luo_fdt_out, 0,
+					 LUO_SUBSYSTEMS_NODE_NAME);
+	list_for_each_entry(subsystem, &luo_subsystems_list, list) {
+		ret = fdt_setprop(luo_fdt_out, node_offset, subsystem->name,
+				  &subsystem->private_data, sizeof(u64));
+		if (ret < 0) {
+			pr_err("Failed to set FDT property for subsystem '%s' %s\n",
+			       subsystem->name, fdt_strerror(ret));
+			return -ENOENT;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * luo_do_subsystems_prepare_calls - Calls prepare callbacks and updates FDT
  * if all prepares succeed. Handles cancellation on failure.
@@ -114,7 +174,29 @@ void __init luo_subsystems_startup(void *fdt)
  */
 int luo_do_subsystems_prepare_calls(void)
 {
-	return 0;
+	struct liveupdate_subsystem *subsystem;
+	int ret;
+
+	list_for_each_entry(subsystem, &luo_subsystems_list, list) {
+		if (!subsystem->ops->prepare)
+			continue;
+
+		ret = subsystem->ops->prepare(subsystem->arg,
+					      &subsystem->private_data);
+		if (ret < 0) {
+			pr_err("Subsystem '%s' prepare callback failed [%d]\n",
+			       subsystem->name, ret);
+			__luo_do_subsystems_cancel_calls(subsystem);
+
+			return ret;
+		}
+	}
+
+	ret = luo_subsystems_commit_data_to_fdt();
+	if (ret)
+		__luo_do_subsystems_cancel_calls(NULL);
+
+	return ret;
 }
 
 /**
@@ -132,7 +214,29 @@ int luo_do_subsystems_prepare_calls(void)
  */
 int luo_do_subsystems_freeze_calls(void)
 {
-	return 0;
+	struct liveupdate_subsystem *subsystem;
+	int ret;
+
+	list_for_each_entry(subsystem, &luo_subsystems_list, list) {
+		if (!subsystem->ops->freeze)
+			continue;
+
+		ret = subsystem->ops->freeze(subsystem->arg,
+					     &subsystem->private_data);
+		if (ret < 0) {
+			pr_err("Subsystem '%s' freeze callback failed [%d]\n",
+			       subsystem->name, ret);
+			__luo_do_subsystems_cancel_calls(subsystem);
+
+			return ret;
+		}
+	}
+
+	ret = luo_subsystems_commit_data_to_fdt();
+	if (ret)
+		__luo_do_subsystems_cancel_calls(NULL);
+
+	return ret;
 }
 
 /**
@@ -143,6 +247,17 @@ int luo_do_subsystems_freeze_calls(void)
  */
 void luo_do_subsystems_finish_calls(void)
 {
+	struct liveupdate_subsystem *subsystem;
+
+	luo_subsystems_retrieve_data_from_fdt();
+
+	list_for_each_entry(subsystem, &luo_subsystems_list, list) {
+		if (subsystem->ops->finish) {
+			subsystem->ops->finish(subsystem->arg,
+					       subsystem->private_data);
+		}
+		subsystem->private_data = 0;
+	}
 }
 
 /**
@@ -156,6 +271,8 @@ void luo_do_subsystems_finish_calls(void)
  */
 void luo_do_subsystems_cancel_calls(void)
 {
+	__luo_do_subsystems_cancel_calls(NULL);
+	luo_subsystems_commit_data_to_fdt();
 }
 
 /**
@@ -279,6 +396,25 @@ EXPORT_SYMBOL_GPL(liveupdate_unregister_subsystem);
  */
 int liveupdate_get_subsystem_data(struct liveupdate_subsystem *h, u64 *data)
 {
+	int node_offset, prop_len;
+	const void *prop;
+
+	luo_state_read_enter();
+	if (WARN_ON_ONCE(!luo_fdt_in || !liveupdate_state_updated())) {
+		luo_state_read_exit();
+		return -ENOENT;
+	}
+
+	node_offset = fdt_subnode_offset(luo_fdt_in, 0,
+					 LUO_SUBSYSTEMS_NODE_NAME);
+	prop = fdt_getprop(luo_fdt_in, node_offset, h->name, &prop_len);
+	if (!prop || prop_len != sizeof(u64)) {
+		luo_state_read_exit();
+		return -ENOENT;
+	}
+	memcpy(data, prop, sizeof(u64));
+	luo_state_read_exit();
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(liveupdate_get_subsystem_data);
-- 
2.50.0.727.gbf7dc18ff4-goog


