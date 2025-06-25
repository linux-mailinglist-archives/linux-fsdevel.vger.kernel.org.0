Return-Path: <linux-fsdevel+bounces-53012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2186AE925C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409AD1C42C9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250EC2D979F;
	Wed, 25 Jun 2025 23:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="pOY+I0Ux"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B9F2D3EE8
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893552; cv=none; b=SGuzUYYCEkiVHDt6wmOJ5dPwIunyPvsewC5IQmFmV4zqQf2FzAFl59Zuz9fP9JxnhIPxpO2FUVShtXZWEeu9Hapz1tA04MAmxoqPcFRKCCYbUDAVDoCN4D3csFOOBAzcasE2Szl8l9QIQ2q01P8mec3XIGHvp0oHXP9wiuASek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893552; c=relaxed/simple;
	bh=Cfi9j2oHaj3a+1RPOlQ6V9S6n7G0Pg+wsLencW8TXUg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bu9PSO258xt508YnolcpUszjcaBlcFJ6L1fEq4vpz+AcziP5NQqM9LOkLPkY3aMjSrI3EsT0/e0MHHnksG9ZbsBtqfGogSIi/UJIlQln3eC6vLpazGT7N98Db1cdz8t8Hb4aCisP3kUwCR2GsJhfHFfUVkh+OUJlo5WS2dHTEYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=pOY+I0Ux; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e812c817de0so347531276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893549; x=1751498349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sk38mGBhqK7qzK3HNwB+80JVX/lHD/SIvkcYryZBkd4=;
        b=pOY+I0UxdKQFTSBy93acHuTY4hqY1W+Ye9acZfjYXHsYXo6ah1Kz+RnyjrdmSCc4yT
         9Opu3R+xhCJIWZN0N0dVgs8I0+s9XCp9iUS4iuQ3tpUQE3gsTjgSW12znb78e3k5nt/5
         mectUkj5025YU6T8EcV2p49MzBai4NfTpdElgVoYAfY6imlv3PoTdPpFmZsYkNAFyQNH
         P6ur8CYcUKof9gAUiyrVi2p3pCwiPJ/eBY2y+ecd9JyikmYAHezogaItiU4VLhllTz/t
         iE7Rz+OhtjIuLRFMjmAx/m9+EK5DG3sDr7fk3C2e1oUUs7rbdqJ21a7vpBM3wwIS/oF4
         COXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893549; x=1751498349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sk38mGBhqK7qzK3HNwB+80JVX/lHD/SIvkcYryZBkd4=;
        b=WIvhtCD90MYXQRO0ejDwak2CO0p4C6WfK+1iHzCZZx9U9hYOgLZueY4GVp00IRChlk
         zVK6db5jQUzJZlI0bhfXOwgFTGWP8xmUnv3aYGlMY6A4TP0Ixo2Du44d6boOxv8IQ+LW
         oG4BMYk/VNBbr4DEzBRYlI2GyGIJEnSZM7aC7G3LYl4jLCeJDWdxtFb6SLbxhKl+04ko
         u4/VhKNpFwE29gk97Kaaf/SiVteeeMhfjzsT5pmt3IJ4bC8FD7s3yy3kX47TlDWs7aLL
         Yvo8VYpJqHr3CsIXsxouxhaLUBghMJj1AbCYbuZKsZCCQDkzUKxg8DdMTancydjhoBiI
         FAag==
X-Forwarded-Encrypted: i=1; AJvYcCVn1E7BCzvfXlIn1aur3seTG5Dk9qiIpQXLnVRwgWwm2IsY3mis92n+Winhfl8sFlyVjw9nTWPwKJXw9JQr@vger.kernel.org
X-Gm-Message-State: AOJu0YwacD8l6lFxeV5uYPOmqurmLN2TCe087hSxPD3M+mOX75PNoITw
	1Av4ltN0gQ7yY3AEyS8bLRcXXdU5f/67/6f1g6c+flcvbMEs5O6UvrPH8JDNYtj3FKI=
X-Gm-Gg: ASbGnctAQnwRZoqEvT6q8kPZUhhw1OKBkr5TbjlVJhfRf9IcrcYBrJ+51tejj6aLjsG
	VH7G9eoCheKfOZpJKKupkrE7Ene4G3osjbZ+b0yRdR0yONQXgu88uVIXx6OTlHpre4kbCLvm+/s
	B9tdwpymRvb04g/CfqRUzqiT00Hb5wHNh4xppV6YZn+pk/CSjgO9oE0nux1eU61wfRU6LoYTCUR
	uCizgd3sN8fGigU+WHBMZ2FXumOJ/EqI8aX9u9F/RFBoF2CE30ervFwVIM6o8AUR1/nn0eDgbZu
	fNpkGI3LJdeNBL36fedkhP8ERDe38/XTJONBC417XsAYNj/UhdYToMfdGN1fja3sBrdplGYZ8hK
	s3Wl4aLV6pbDnk/lisFesxCsaG/No99nmBRwA76xGaFmoakb01+oc
X-Google-Smtp-Source: AGHT+IF/RgxxhWmfB1Y2MqbieDB4I6eRiGrckxjMs1m4U+N2pAXqAFN4tpFMCdmuvzDLcl2Fl05y+g==
X-Received: by 2002:a05:6902:114b:b0:e84:363a:133e with SMTP id 3f1490d57ef6-e8601760f75mr6660102276.13.1750893549002;
        Wed, 25 Jun 2025 16:19:09 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:19:08 -0700 (PDT)
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
Subject: [PATCH v1 15/32] liveupdate: luo_files: implement file systems callbacks
Date: Wed, 25 Jun 2025 23:18:02 +0000
Message-ID: <20250625231838.1897085-16-pasha.tatashin@soleen.com>
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

Implements the core logic within luo_files.c to invoke the prepare,
reboot, finish, and cancel callbacks for preserved file instances,
replacing the previous stub implementations. It also handles
the persistence and retrieval of the u64 data payload associated with
each file via the LUO FDT.

This completes the core mechanism enabling registered files handlers to actively
manage file state across the live update transition using the LUO framework.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_files.c | 166 +++++++++++++++++++++++++++++++++-
 1 file changed, 164 insertions(+), 2 deletions(-)

diff --git a/kernel/liveupdate/luo_files.c b/kernel/liveupdate/luo_files.c
index 3582f1ec96c4..cd956ea69f43 100644
--- a/kernel/liveupdate/luo_files.c
+++ b/kernel/liveupdate/luo_files.c
@@ -325,31 +325,193 @@ static int luo_files_fdt_setup(void)
 	return ret;
 }
 
+static int luo_files_prepare_one(struct luo_file *h)
+{
+	int ret = 0;
+
+	mutex_lock(&h->mutex);
+	if (h->state == LIVEUPDATE_STATE_NORMAL) {
+		if (h->fh->ops->prepare) {
+			ret = h->fh->ops->prepare(h->file, h->fh->arg,
+						  &h->private_data);
+		}
+		if (!ret)
+			h->state = LIVEUPDATE_STATE_PREPARED;
+	} else {
+		WARN_ON_ONCE(h->state != LIVEUPDATE_STATE_PREPARED &&
+			     h->state != LIVEUPDATE_STATE_FROZEN);
+	}
+	mutex_unlock(&h->mutex);
+
+	return ret;
+}
+
+static int luo_files_freeze_one(struct luo_file *h)
+{
+	int ret = 0;
+
+	mutex_lock(&h->mutex);
+	if (h->state == LIVEUPDATE_STATE_PREPARED) {
+		if (h->fh->ops->freeze) {
+			ret = h->fh->ops->freeze(h->file, h->fh->arg,
+						 &h->private_data);
+		}
+		if (!ret)
+			h->state = LIVEUPDATE_STATE_FROZEN;
+	} else {
+		WARN_ON_ONCE(h->state != LIVEUPDATE_STATE_FROZEN);
+	}
+	mutex_unlock(&h->mutex);
+
+	return ret;
+}
+
+static void luo_files_finish_one(struct luo_file *h)
+{
+	mutex_lock(&h->mutex);
+	if (h->state == LIVEUPDATE_STATE_UPDATED) {
+		if (h->fh->ops->finish) {
+			h->fh->ops->finish(h->file, h->fh->arg, h->private_data,
+				      h->reclaimed);
+		}
+		h->state = LIVEUPDATE_STATE_NORMAL;
+	} else {
+		WARN_ON_ONCE(h->state != LIVEUPDATE_STATE_NORMAL);
+	}
+	mutex_unlock(&h->mutex);
+}
+
+static void luo_files_cancel_one(struct luo_file *h)
+{
+	int ret;
+
+	mutex_lock(&h->mutex);
+	if (h->state == LIVEUPDATE_STATE_NORMAL)
+		goto exit_unlock;
+
+	ret = WARN_ON_ONCE(h->state != LIVEUPDATE_STATE_PREPARED &&
+			   h->state != LIVEUPDATE_STATE_FROZEN);
+	if (ret)
+		goto exit_unlock;
+
+	if (h->fh->ops->cancel)
+		h->fh->ops->cancel(h->file, h->fh->arg, h->private_data);
+	h->private_data = 0;
+	h->state = LIVEUPDATE_STATE_NORMAL;
+
+exit_unlock:
+	mutex_unlock(&h->mutex);
+}
+
+static void __luo_files_cancel(struct luo_file *boundary_file)
+{
+	unsigned long token;
+	struct luo_file *h;
+
+	xa_for_each(&luo_files_xa_out, token, h) {
+		if (h == boundary_file)
+			break;
+
+		luo_files_cancel_one(h);
+	}
+	luo_files_fdt_cleanup();
+}
+
+static int luo_files_commit_data_to_fdt(void)
+{
+	int node_offset, ret;
+	unsigned long token;
+	char token_str[19];
+	struct luo_file *h;
+
+	xa_for_each(&luo_files_xa_out, token, h) {
+		snprintf(token_str, sizeof(token_str), "%#0llx", (u64)token);
+		node_offset = fdt_subnode_offset(luo_file_fdt_out,
+						 0,
+						 token_str);
+		ret = fdt_setprop(luo_file_fdt_out, node_offset, "data",
+				  &h->private_data, sizeof(h->private_data));
+		if (ret < 0) {
+			pr_err("Failed to set data property for token %s: %s\n",
+			       token_str, fdt_strerror(ret));
+			return -ENOSPC;
+		}
+	}
+
+	return 0;
+}
+
 static int luo_files_prepare(void *arg, u64 *data)
 {
+	unsigned long token;
+	struct luo_file *h;
 	int ret;
 
 	ret = luo_files_fdt_setup();
 	if (ret)
 		return ret;
 
-	*data = __pa(luo_file_fdt_out);
+	xa_for_each(&luo_files_xa_out, token, h) {
+		ret = luo_files_prepare_one(h);
+		if (ret < 0) {
+			pr_err("Prepare failed for file token %#0llx handler '%s' [%d]\n",
+			       (u64)token, h->fh->compatible, ret);
+			__luo_files_cancel(h);
+
+			return ret;
+		}
+	}
+
+	ret = luo_files_commit_data_to_fdt();
+	if (ret)
+		__luo_files_cancel(NULL);
+	else
+		*data = __pa(luo_file_fdt_out);
 
 	return ret;
 }
 
 static int luo_files_freeze(void *arg, u64 *data)
 {
-	return 0;
+	unsigned long token;
+	struct luo_file *h;
+	int ret;
+
+	xa_for_each(&luo_files_xa_out, token, h) {
+		ret = luo_files_freeze_one(h);
+		if (ret < 0) {
+			pr_err("Freeze callback failed for file token %#0llx handler '%s' [%d]\n",
+			       (u64)token, h->fh->compatible, ret);
+			__luo_files_cancel(h);
+
+			return ret;
+		}
+	}
+
+	ret = luo_files_commit_data_to_fdt();
+	if (ret)
+		__luo_files_cancel(NULL);
+
+	return ret;
 }
 
 static void luo_files_finish(void *arg, u64 data)
 {
+	unsigned long token;
+	struct luo_file *h;
+
 	luo_files_recreate_luo_files_xa_in();
+	xa_for_each(&luo_files_xa_in, token, h) {
+		luo_files_finish_one(h);
+		mutex_destroy(&h->mutex);
+		kfree(h);
+	}
+	xa_destroy(&luo_files_xa_in);
 }
 
 static void luo_files_cancel(void *arg, u64 data)
 {
+	__luo_files_cancel(NULL);
 }
 
 static const struct liveupdate_subsystem_ops luo_file_subsys_ops = {
-- 
2.50.0.727.gbf7dc18ff4-goog


