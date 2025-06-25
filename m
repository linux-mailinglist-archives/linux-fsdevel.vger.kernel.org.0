Return-Path: <linux-fsdevel+bounces-53010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6DEAE9273
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D59757B943F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8755E2D3ED8;
	Wed, 25 Jun 2025 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="dPrxG20h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914A0287269
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893548; cv=none; b=Ry94jneeBlX3Xti3tgQuBrKMu/qcTHss4vk+Mz7TD59PaTK8T/FqAES8sXaWUc43GiJXoaDPvgGaRCx0+SgImKUvi0JA8jAqtAxM8JvOQN6gfA5VtlfcESdude4iCysuK/IYiudY3KfMETA+uYzzKaastNDOWGsY8dhYJKVpmzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893548; c=relaxed/simple;
	bh=h1L0cbeVfJxO9kghsvJ6bWhgk+o6POMPbs4sljzTVS0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0E2ino+bP/8dVqOHzBSjnasBrVPXSzg/2ew/nLlqGk/lPUEQDFH4gv2rSOYzz7bG5czdqaoarezdmLuAMdmoZKpCbC+X6d4WSqixqF6RbP8p8DD53t4GMz8uPed+2Qt4OtghCBL5DWyBCF0TpBRvfEcLd3l5x07mwfkRJREnFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=dPrxG20h; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e81826d5b72so297398276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893545; x=1751498345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UX19BNUcwB6TjSqCz6om7S5yVRpVe4SwKywfTR0ocE=;
        b=dPrxG20hSsMW/B3OVCiaYwjuLVCscBPrvr1/Z0Gpy59Qirdl7dwvNP8SRiOisXkCRB
         wdbNM2w0Pe0/8XkVHDQXEYhz3W3JaD7vSQn0diOpRBa+Hi3nMwkgX/JSk/jjaZmqd+of
         2fEHz0KHUs6VOyMhJZkS3Fr4em+z0fLHagpINbXLA1VXw5JgdEh+I15S2ZzGsvtea8PN
         eQGzWjc09gvnvyOC1zrHdCo+T5o0b+JwUuojDdZVFW35Ew44YUaPjJGzCdoX28Nra9Zm
         sm+qxQ3al2dxjjGPwVVwaanpyuwtbUDD/I3Ex1NU7w2o3r14F2fQuCxQzr7QqRkHvPip
         +6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893545; x=1751498345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UX19BNUcwB6TjSqCz6om7S5yVRpVe4SwKywfTR0ocE=;
        b=dE2gxP5WLmJKk6WemECIdDICRiiuX8aDnErUlexT088/y7TbuAlWX1q/SfNCRbYHOO
         ismoaYIs3ZO4+NkdiSRA3TSw9b+R9tKYjMoYRofNR+5so8cP1Q8vHpKQ3rznQMkbQM0j
         T6bnX3nfqjdpwLrpjJojC8dbI8nuQbt+Erfr7LR6viCB/yo88iN4FrzBNr+wo5MxpCS2
         e5sByMALXKRh0x6YWMsVq78tO+pgL0OhELNQVF3/es9k6SmMtJjZjq//XxWbXf3SC8a9
         wTLrTFZRZdhGaXISf+ExYTaOEwh7TYslL2uO5NwKLPGRqJrqEi8z7Y4+jTjaH5UkR0ch
         UPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeskJYqLAeH/SfGDbwB7XZPfZt4Fi8qP9W3Rrk7Fcndy3EzaGxFH4O+0pFJsLacWnj6OI73ZLJPLN6PQzv@vger.kernel.org
X-Gm-Message-State: AOJu0YyWqStbsp3ijWdXREPNzmnrx6G8fbK9Lyp4M8WtRZVrc2qmx5JR
	cmn4jJDL/eso7LqFS5A6jw8EH2zFej4y5lr9mskDsFftHNw0wv8rcjHa/j77LX/hn4A=
X-Gm-Gg: ASbGncuQV+YQlezr66Cxmkxm7bI002w2KJKlvDupnQ0tF2bIJWSVh/njsAxSUdpstMO
	IjUV8366sC74Dc1ln+UEKKBVPa7zw6IMILV6i2BOKHul3J0OFZkxwS+P3I3RVvXt00EWKBnUMYc
	qPsQz9hy6Xb/z8rPRa+N15eCDbFFtmwnOW0uXLsRCs/AboPdUf6VFvCvFcdy72N2wg/HjWUletI
	y0IzXjv1ijI5Hu1sHYijl/aqa/PCcpRTU9Lnt586ar7fa2PlocshTncHqUhdPRwvOxRe4ZlycOU
	q62F8Im051ynR/jwsnz6+OKsk74UY3Ktx7HtsyvjH2Se/QQsnJHUfDoLmMFnJ4QOv4npA63S5UY
	My8S3C4OoZ4q2eu2fjLiCNas1Fy7fncIMnsoGYZD4ZftZXCKf+IcG7/xXomMrv7U=
X-Google-Smtp-Source: AGHT+IEUALELAR5NZDDDyivweXKXSv+YUONyeoj1fruSJbIWZ6q9777GsWvO1Or7ZMh1+hi6yBvkfg==
X-Received: by 2002:a05:6902:4790:b0:e81:9da8:522d with SMTP id 3f1490d57ef6-e8601765df4mr6268713276.23.1750893545592;
        Wed, 25 Jun 2025 16:19:05 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:19:05 -0700 (PDT)
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 13/32] liveupdate: luo_subsystems: implement subsystem callbacks
Date: Wed, 25 Jun 2025 23:18:00 +0000
Message-ID: <20250625231838.1897085-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
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


