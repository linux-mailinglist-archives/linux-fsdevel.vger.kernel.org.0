Return-Path: <linux-fsdevel+bounces-55855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AAAB0F5F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA8257B7C7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B442FD5BA;
	Wed, 23 Jul 2025 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="3VLGzvMI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDBC2F6FB0
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282052; cv=none; b=Y3tjlBXY1uuf/yXys+UzioZcbU+U3ttLx5fn6R1LpnZv1Re8rY8wG8pJo0gZOzZGG24h58IbxdV875YYrPN9HroWuOifso+e3CwLlu6YC959+X86d9e1QkgBiMAo/ymsXMCZPNBwm6XesPIj5EU/xwKCA+4FGhv2eSznHBD//qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282052; c=relaxed/simple;
	bh=Cfi9j2oHaj3a+1RPOlQ6V9S6n7G0Pg+wsLencW8TXUg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsT4uH5sC2Q0j08u+Ir5epnO/R+Tb6X3C2+DhrxoDP9FfI5hWHDrc4uETfb3SfKCFILRGZEchCd0KlWVr6t/mSfJAK3C8GPHA9XIu0JlMHGtcLSHJmTuJiSzBIdGfWMa+lc73jvwEU/Dl2okUnGFln78yMv4Zk3M7+29OfBOTOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=3VLGzvMI; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70e3e0415a7so262697b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282045; x=1753886845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sk38mGBhqK7qzK3HNwB+80JVX/lHD/SIvkcYryZBkd4=;
        b=3VLGzvMIMKYavfCYFadg0jiuAu3OUzrL0BaH9/F63R5glO8OibHyupSKD8hSxQMUIR
         NOEhS+pD/U7P4QAXFrnu8rBAlciyDtkhYKQnUFTHKnudoSvwua97UteWOkaHJkXOhSr6
         fJ6CjLCTtUCuU2+pZEqaFTQkSBRb3WCY0dr7MTYURuet8nSaPA90PO7eEL7lbO+0N1Od
         WvV6EiHXEkgkTGxSDiFvn7BGCIY6UQQrY6s6oNwUJWt9FERzYewmXPnAmTpFR2uBchKm
         JTvolDWKXnOLW2bdRKNMqSYM7yFIpA91aTfwX8MFJQXyXgM4YVEX/55Lt/fTRdRTX1lR
         sXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282045; x=1753886845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sk38mGBhqK7qzK3HNwB+80JVX/lHD/SIvkcYryZBkd4=;
        b=GHVMJpP67ppTff5P7Jh/pOw24XPCd3EZWC1tG4dhB+C8xam9XM9Xass/igRbOy+ZAd
         YM+tPAN9y+2nIJpmNroeqYo7gzXSvc2ut4f1cY7VjAckpJHNqy/V259c+6VQeWqGjjWt
         3gbsBgOjtVEYNxntuDoemHBEFwcXBaDO2ZmbGmgw3NGc56gGyixQBtPMgJalYggnJCJu
         35ZzekNdIrv/dzBt5dwn1ojWpd7k4maVRmj+iXX4vp1bkKmnBAGZEZrNyHqafH8a+89b
         VNuWM092uAfJjP/2iqdw6E9mWaHdt1IS0s0mr6oO5nVkOud0uLR3Ocey/W0GvLyZ0TuS
         Mm6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX90bzMkStRgmx+U6HXrvIGpkOk4b1PAoRDh39Whs+B0glRDg3Z13+0xLKpgG7mD5VitY9b8APDaQG/ZJaV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8x4jBxN0ORxpx0s9e2+kE3duRlxy7ZUzLSiNLnF0vj8ksGQbg
	Cn0aTiTddm938PmUFLWe+0Wvj8bLiSBOgNTgc0oDhf1AQEwPJ3oKKjRaqzXfHhfvbGA=
X-Gm-Gg: ASbGncvuzcz/+dIYAxwYFt+Lm+3HF+KyjpweWsHR0sNFz5U2wfNmsYarhANCcRV36zd
	9ASk1ANYIJOnOswsN0N1+RAyvd5xGaOoJk026aZ+7IN8sRu1Fv+nfq4bI0UngQoWsvGKDtdGZCK
	yE9hgGGe9YI0DmPpyU9i4uEUeVOzF5vyWM5Bld9CF/zWl53EVRJ08+vBD6VB1Ir+oOCFPvNOaim
	Bh//+cDkh8ALtj2xI7C6xWTWlcRwcmJs/7KBXugxfMFzu1stRUzdy5JVRJPFphYq1Dsct/3WvYD
	Lh+9EgP38Jwp1me+6ozhMv7Ye5euBObAZuAcp8A8FfJLSiQy1ApFGFSzeQSUBjXsdUBUBP2KnBH
	3K7n2IgF9wZr1cU8iXGvvBhd7cBNum+XUdV7BAPNyI9utv65u6YCmF8yAMyjnWtr9fAY8SQUSwm
	2wV87Z2GYEcqHuSg==
X-Google-Smtp-Source: AGHT+IHGYfjoIy8qo73uD860AaG0pKa+DBLv7UTBP+7WtZjAXyEb/laqBGmfDkMsPVthzLrkCs+A9A==
X-Received: by 2002:a05:690c:d84:b0:712:c5f7:1f11 with SMTP id 00721157ae682-719a0b52782mr94165947b3.10.1753282044761;
        Wed, 23 Jul 2025 07:47:24 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:23 -0700 (PDT)
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
Subject: [PATCH v2 15/32] liveupdate: luo_files: implement file systems callbacks
Date: Wed, 23 Jul 2025 14:46:28 +0000
Message-ID: <20250723144649.1696299-16-pasha.tatashin@soleen.com>
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


