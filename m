Return-Path: <linux-fsdevel+bounces-55859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C22AB0F61D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7EF587FB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8442E2FE389;
	Wed, 23 Jul 2025 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="MfM1vsUL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251E72FCFF4
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282060; cv=none; b=syMctK9yzsMlMTeG76NbnXzfu76VA/9pBzeARdkYmn5SwHJRlFzgRoLYd8hohwrQZHXoVw04ms6vHcBtvdVAv+d5LaZDobS7MpK8OjEI00nYbgm2tbwZnEZyUzsjUyEsZvVSdB+3TQH2QvS4+JdKTbQL5XV0CeKXTgTSXrZ2i14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282060; c=relaxed/simple;
	bh=BYE6CFYNp+bC24GEWjI/kpdlZd1bkuK5lqVnOzx7zbo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvuMHvLA/lUhvgHrQZnebgJ5jKXJj2QDvuukdBRQ5+k6i/0JQRw6MWLgmbK6rUtS8P2SDRPl/SO74tYbHwQgwwxuZHwFl0s/MTiSJiOAjN8icyjKHRW4kEsDtKA+BUM6ojdh2yaAgzBcwPKzNt+4P7Wzqk5InqLPon2I3OovCvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=MfM1vsUL; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7086dcab64bso64862287b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282053; x=1753886853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+trs6zLLPmtqa3TLX7M9IRokbE5V0+8Th4y6mj0Kyj4=;
        b=MfM1vsULL/brUnd0SM/r5d5jGS24kBw36dOk+k1u8tGauy67q+a2kUpzQ4WJYOZNVh
         vyRKWSai3zvLyqTdnI0CQnvoGUe2IJGRF28YH6qrDzmmYjsMQ1n0YCf6FX/az85vTH0o
         Dk5VKUC7C2iraFOKHU7kkShfMoFlKDSOvkj0V0sIVPTnrkjHzF2YUkSoRCEhM9wLMYyD
         foOMi8NyQqiT+CAGnddXqB4hhSTxZJPFs+miQvkazJw6zadmo+SjBwAePiPCSZTG3naj
         o1sDeLc8O0ehJkrLftHErqBM8OeVYmOLmfIQLKsD0YFHjLFZ0gKUs7ym1mo/VufLY7+V
         4PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282053; x=1753886853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+trs6zLLPmtqa3TLX7M9IRokbE5V0+8Th4y6mj0Kyj4=;
        b=ZqL2dZSQsZuu7BnlO1raNU5qDsYy9VNOq9rD5ytd/5ab6vRzlDJrrd9TzVEfx9cI7l
         23szdL2TQ7IOYaN5JC8lNlRkDQRZrMT3Z1dwIsn6C39VgO4FfaOIG91wCNNRx3Hi6dvB
         +p/KEqyHwOJJAbUNnRAQ+UbjKZ25+oAQTmb191wjETnQAvm2Rrtt9cDelnMPELWUZxjQ
         eso1m2TmXjgR4wHOFFKY2zDMzFd9fomgYSNWiPhnSi+pc+OSwwWYbprNfPxpmhLCD4Fa
         vT28/F5ipzISZaaZ1og7pz3Zviy8Nv/oA+0eMcfY4E474G/laOnA58L5xOLS1LHuiKwX
         L58g==
X-Forwarded-Encrypted: i=1; AJvYcCX0wJR1/xYYd1qbloEiaEwRuQ9F+V43qTf1bCzkThvx40Ccrs7sEM8yhe+vKTD2LesDw2CGsbb1ig565FtC@vger.kernel.org
X-Gm-Message-State: AOJu0YzbygzRSuBLZQVIc9vfTgUoxb15ewzGDl1Kxl6CMyfv3fJlCtlG
	YpP6dN9MBQLs/U3OOQvaXFkEhdHvz/w4YPeHogRIlM26swIlaSx56rKLEseNp4kVlz8=
X-Gm-Gg: ASbGncsqLgaazQCBsg2zzLa/Yn2w1CJUiuIT2TjZc3Brzn/mrnpmzmxbADDEHmox159
	4Gl3JiY1K8A3Rwl9tROOWm2mNWGBCCaW4HWC1t5N7p43k3fJT16Z+e7QtFsiqytykc4HwGnEeDb
	ptH0l8xLshYrQgVpIwS9dEjurRfGLb5WQUABcObXb3EMNhDpeO4eJrE5YNtclmaogtHM5JzZ8T2
	Z+jrwq1OXBUyv4ahDAx4zOwYXiEhjHa1QzBWlaWpLhsyfmjk5ZtKgesKGAGjoDaZ5rjCNxmjqwQ
	3jd/DT0N7KySn1Gl/E97K8L+QW83k7TAA8/B1kWJnu7jl7rhenQjXtT7JSnJqfu4OUmKip5ICxq
	iLqvWseWOE1xiGZK4c7zoiY3Gpma/h6gfR7cvuW+uc3pGZDMH+QNmyKw5ZwgpZCSP2hQ+5uMJg2
	GKfP9Ks9ojrQsJeg==
X-Google-Smtp-Source: AGHT+IFtwvreCL2sXFpP4tWrdElOCBJZZ61/Ssj3Y5oUsXYhD2MOsAfBd7Qfuabw6eVPL1olg8NVIg==
X-Received: by 2002:a05:690c:6c86:b0:717:ca51:d781 with SMTP id 00721157ae682-719b4185488mr45868507b3.17.1753282053192;
        Wed, 23 Jul 2025 07:47:33 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:32 -0700 (PDT)
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
Subject: [PATCH v2 19/32] liveupdate: luo_files: luo_ioctl: session-based file descriptor tracking
Date: Wed, 23 Jul 2025 14:46:32 +0000
Message-ID: <20250723144649.1696299-20-pasha.tatashin@soleen.com>
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

Currently, file descriptors registered for preservation via
/dev/liveupdate remain globally registered with the LUO core until
explicitly unregistered. This behavior can lead to unintended
consequences: if a userspace process (e.g., a VMM or
an agent managing FDs) registers FDs for preservation and then crashes
or exits prematurely before LUO transitions to a PREPARED state (and
without explicitly unregistering them), these FDs would remain marked
for preservation. This could result in unnecessary resources being
carried over to the next kernel or stale state or leaks.

Introduce a session-based approach to FD preservation to address this
issue. Each open instance of /dev/liveupdate now corresponds to a "LUO
session," which tracks the FDs registered through it. If a LUO session
is closed (i.e., the file descriptor for /dev/liveupdate is closed by
userspace) while LUO is still in the NORMAL or UPDATED state, all FDs
registered during that specific session are automatically unregistered.

This ensures that FD preservations are tied to the lifetime of the
controlling userspace entity's session, preventing unintentional leakage
of preserved FD state into the next kernel if the live update process
is not fully initiated and completed for those FDs. FDs are only
globally committed for preservation if the LUO state machine progresses
beyond NORMAL (i.e., into PREPARED or FROZEN) before the managing
session is closed. In the future, we can relax this even further, and
preserve only when the session is still open while we are already in
reboot() system call.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_files.c    | 225 ++++++++++++++++++++++++-------
 kernel/liveupdate/luo_internal.h |   9 +-
 kernel/liveupdate/luo_ioctl.c    |  20 ++-
 3 files changed, 197 insertions(+), 57 deletions(-)

diff --git a/kernel/liveupdate/luo_files.c b/kernel/liveupdate/luo_files.c
index cd956ea69f43..256b5261f81e 100644
--- a/kernel/liveupdate/luo_files.c
+++ b/kernel/liveupdate/luo_files.c
@@ -67,7 +67,6 @@
 #define LUO_FILES_COMPATIBLE	"file-descriptors-v1"
 
 static DEFINE_XARRAY(luo_files_xa_in);
-static DEFINE_XARRAY(luo_files_xa_out);
 static bool luo_files_xa_in_recreated;
 
 /* Registered files. */
@@ -81,6 +80,15 @@ static size_t luo_file_fdt_out_size;
 
 static atomic64_t luo_files_count;
 
+/* Opened sessions */
+static DECLARE_RWSEM(luo_sessions_list_rwsem);
+static LIST_HEAD(luo_sessions_list);
+
+struct luo_session {
+	struct xarray files_xa_out;
+	struct list_head list;
+};
+
 /**
  * struct luo_file - Represents a file descriptor instance preserved
  * across live update.
@@ -262,6 +270,7 @@ static int luo_files_to_fdt(struct xarray *files_xa_out)
 
 static int luo_files_fdt_setup(void)
 {
+	struct luo_session *s;
 	int ret;
 
 	luo_file_fdt_out_size = luo_files_fdt_size();
@@ -300,9 +309,15 @@ static int luo_files_fdt_setup(void)
 	if (ret < 0)
 		goto exit_end_node;
 
-	ret = luo_files_to_fdt(&luo_files_xa_out);
-	if (ret < 0)
-		goto exit_end_node;
+	down_read(&luo_sessions_list_rwsem);
+	list_for_each_entry(s, &luo_sessions_list, list) {
+		ret = luo_files_to_fdt(&s->files_xa_out);
+		if (ret < 0) {
+			up_read(&luo_sessions_list_rwsem);
+			goto exit_end_node;
+		}
+	}
+	up_read(&luo_sessions_list_rwsem);
 
 	ret = fdt_end_node(luo_file_fdt_out);
 	if (ret < 0)
@@ -405,44 +420,59 @@ static void luo_files_cancel_one(struct luo_file *h)
 
 static void __luo_files_cancel(struct luo_file *boundary_file)
 {
+	struct luo_session *s;
 	unsigned long token;
 	struct luo_file *h;
 
-	xa_for_each(&luo_files_xa_out, token, h) {
-		if (h == boundary_file)
-			break;
+	down_read(&luo_sessions_list_rwsem);
+	list_for_each_entry(s, &luo_sessions_list, list) {
+		xa_for_each(&s->files_xa_out, token, h) {
+			if (h == boundary_file)
+				goto exit;
 
-		luo_files_cancel_one(h);
+			luo_files_cancel_one(h);
+		}
 	}
+exit:
+	up_read(&luo_sessions_list_rwsem);
 	luo_files_fdt_cleanup();
 }
 
 static int luo_files_commit_data_to_fdt(void)
 {
+	struct luo_session *s;
 	int node_offset, ret;
 	unsigned long token;
 	char token_str[19];
 	struct luo_file *h;
 
-	xa_for_each(&luo_files_xa_out, token, h) {
-		snprintf(token_str, sizeof(token_str), "%#0llx", (u64)token);
-		node_offset = fdt_subnode_offset(luo_file_fdt_out,
-						 0,
-						 token_str);
-		ret = fdt_setprop(luo_file_fdt_out, node_offset, "data",
-				  &h->private_data, sizeof(h->private_data));
-		if (ret < 0) {
-			pr_err("Failed to set data property for token %s: %s\n",
-			       token_str, fdt_strerror(ret));
-			return -ENOSPC;
+	down_read(&luo_sessions_list_rwsem);
+	list_for_each_entry(s, &luo_sessions_list, list) {
+		xa_for_each(&s->files_xa_out, token, h) {
+			snprintf(token_str, sizeof(token_str), "%#0llx",
+				 (u64)token);
+			node_offset = fdt_subnode_offset(luo_file_fdt_out,
+							 0, token_str);
+			ret = fdt_setprop(luo_file_fdt_out, node_offset, "data",
+					  &h->private_data,
+					  sizeof(h->private_data));
+			if (ret < 0) {
+				up_read(&luo_sessions_list_rwsem);
+				pr_err("Failed to set data property for token %s: %s\n",
+				       token_str, fdt_strerror(ret));
+				up_read(&luo_sessions_list_rwsem);
+				return -ENOSPC;
+			}
 		}
 	}
+	up_read(&luo_sessions_list_rwsem);
 
 	return 0;
 }
 
 static int luo_files_prepare(void *arg, u64 *data)
 {
+	struct luo_session *s;
 	unsigned long token;
 	struct luo_file *h;
 	int ret;
@@ -451,16 +481,21 @@ static int luo_files_prepare(void *arg, u64 *data)
 	if (ret)
 		return ret;
 
-	xa_for_each(&luo_files_xa_out, token, h) {
-		ret = luo_files_prepare_one(h);
-		if (ret < 0) {
-			pr_err("Prepare failed for file token %#0llx handler '%s' [%d]\n",
-			       (u64)token, h->fh->compatible, ret);
-			__luo_files_cancel(h);
-
-			return ret;
+	down_read(&luo_sessions_list_rwsem);
+	list_for_each_entry(s, &luo_sessions_list, list) {
+		xa_for_each(&s->files_xa_out, token, h) {
+			ret = luo_files_prepare_one(h);
+			if (ret < 0) {
+				pr_err("Prepare failed for file token %#0llx handler '%s' [%d]\n",
+				       (u64)token, h->fh->compatible, ret);
+				__luo_files_cancel(h);
+				up_read(&luo_sessions_list_rwsem);
+
+				return ret;
+			}
 		}
 	}
+	up_read(&luo_sessions_list_rwsem);
 
 	ret = luo_files_commit_data_to_fdt();
 	if (ret)
@@ -473,20 +508,26 @@ static int luo_files_prepare(void *arg, u64 *data)
 
 static int luo_files_freeze(void *arg, u64 *data)
 {
+	struct luo_session *s;
 	unsigned long token;
 	struct luo_file *h;
 	int ret;
 
-	xa_for_each(&luo_files_xa_out, token, h) {
-		ret = luo_files_freeze_one(h);
-		if (ret < 0) {
-			pr_err("Freeze callback failed for file token %#0llx handler '%s' [%d]\n",
-			       (u64)token, h->fh->compatible, ret);
-			__luo_files_cancel(h);
-
-			return ret;
+	down_read(&luo_sessions_list_rwsem);
+	list_for_each_entry(s, &luo_sessions_list, list) {
+		xa_for_each(&s->files_xa_out, token, h) {
+			ret = luo_files_freeze_one(h);
+			if (ret < 0) {
+				pr_err("Freeze callback failed for file token %#0llx handler '%s' [%d]\n",
+				       (u64)token, h->fh->compatible, ret);
+				__luo_files_cancel(h);
+				up_read(&luo_sessions_list_rwsem);
+
+				return ret;
+			}
 		}
 	}
+	up_read(&luo_sessions_list_rwsem);
 
 	ret = luo_files_commit_data_to_fdt();
 	if (ret)
@@ -561,6 +602,7 @@ late_initcall(luo_files_startup);
 
 /**
  * luo_register_file - Register a file descriptor for live update management.
+ * @s: Session for the file that is being registered
  * @token: Token value for this file descriptor.
  * @fd: file descriptor to be preserved.
  *
@@ -568,10 +610,11 @@ late_initcall(luo_files_startup);
  *
  * Return: 0 on success. Negative errno on failure.
  */
-int luo_register_file(u64 token, int fd)
+int luo_register_file(struct luo_session *s, u64 token, int fd)
 {
 	struct liveupdate_file_handler *fh;
 	struct luo_file *luo_file;
+	struct luo_session *_s;
 	bool found = false;
 	int ret = -ENOENT;
 	struct file *file;
@@ -615,15 +658,20 @@ int luo_register_file(u64 token, int fd)
 	mutex_init(&luo_file->mutex);
 	luo_file->state = LIVEUPDATE_STATE_NORMAL;
 
-	if (xa_load(&luo_files_xa_out, token)) {
-		ret = -EEXIST;
-		pr_warn("Token %llu is already taken\n", token);
-		mutex_destroy(&luo_file->mutex);
-		kfree(luo_file);
-		goto exit_unlock;
+	down_read(&luo_sessions_list_rwsem);
+	list_for_each_entry(_s, &luo_sessions_list, list) {
+		if (xa_load(&_s->files_xa_out, token)) {
+			up_read(&luo_sessions_list_rwsem);
+			ret = -EEXIST;
+			pr_warn("Token %llu is already taken\n", token);
+			mutex_destroy(&luo_file->mutex);
+			kfree(luo_file);
+			goto exit_unlock;
+		}
 	}
+	up_read(&luo_sessions_list_rwsem);
 
-	ret = xa_err(xa_store(&luo_files_xa_out, token, luo_file,
+	ret = xa_err(xa_store(&s->files_xa_out, token, luo_file,
 			      GFP_KERNEL));
 	if (ret < 0) {
 		pr_warn("Failed to store file for token %llu in XArray: %d\n",
@@ -646,6 +694,7 @@ int luo_register_file(u64 token, int fd)
 
 /**
  * luo_unregister_file - Unregister a file instance using its token.
+ * @s: Session for the file that is being registered.
  * @token: The unique token of the file instance to unregister.
  *
  * Finds the &struct luo_file associated with the @token in the
@@ -659,7 +708,7 @@ int luo_register_file(u64 token, int fd)
  *
  * Return: 0 on success. Negative errno on failure.
  */
-int luo_unregister_file(u64 token)
+int luo_unregister_file(struct luo_session *s, u64 token)
 {
 	struct luo_file *luo_file;
 	int ret = 0;
@@ -671,7 +720,7 @@ int luo_unregister_file(u64 token)
 		return -EBUSY;
 	}
 
-	luo_file = xa_erase(&luo_files_xa_out, token);
+	luo_file = xa_erase(&s->files_xa_out, token);
 	if (luo_file) {
 		fput(luo_file->file);
 		mutex_destroy(&luo_file->mutex);
@@ -736,6 +785,74 @@ int luo_retrieve_file(u64 token, struct file **filep)
 	return ret;
 }
 
+/**
+ * luo_create_session - Create and register a new LUO file preservation session.
+ *
+ * This function is called when a userspace process opens the /dev/liveupdate
+ * character device.
+ *
+ * Each session allows a specific open instance of /dev/liveupdate to
+ * independently register file descriptors for preservation. These registrations
+ * are local to the session until LUO's prepare phase aggregates them.
+ * If the /dev/liveupdate file descriptor is closed while LUO is still in
+ * the NORMAL or UPDATES states, all file descriptors registered within that
+ * session will be automatically unregistered by luo_destroy_session().
+ *
+ * Return: Pointer to the newly allocated &struct luo_session on success,
+ *         NULL on memory allocation failure.
+ */
+struct luo_session *luo_create_session(void)
+{
+	struct luo_session *s;
+
+	s = kmalloc(sizeof(struct luo_session), GFP_KERNEL);
+	if (s) {
+		xa_init(&s->files_xa_out);
+		INIT_LIST_HEAD(&s->list);
+
+		down_write(&luo_sessions_list_rwsem);
+		list_add_tail(&s->list, &luo_sessions_list);
+		up_write(&luo_sessions_list_rwsem);
+	}
+
+	return s;
+}
+
+/**
+ * luo_destroy_session - Release a LUO file preservation session.
+ * @s: Pointer to the &struct luo_session to be destroyed, previously obtained
+ *     from luo_create_session().
+ *
+ * This function must be called when a userspace file descriptor for
+ * /dev/liveupdate is being closed (typically from the .release file
+ * operation). It is responsible for cleaning up all resources associated
+ * with the given LUO session @s.
+ */
+void luo_destroy_session(struct luo_session *s)
+{
+	unsigned long token;
+	struct luo_file *h;
+
+	down_write(&luo_sessions_list_rwsem);
+	list_del(&s->list);
+	up_write(&luo_sessions_list_rwsem);
+
+	luo_state_read_enter();
+	if (!liveupdate_state_normal() && !liveupdate_state_updated()) {
+		luo_state_read_exit();
+		goto skip_unregister;
+	}
+
+	xa_for_each(&s->files_xa_out, token, h)
+		luo_unregister_file(s, token);
+
+	luo_state_read_exit();
+
+skip_unregister:
+	xa_destroy(&s->files_xa_out);
+	kfree(s);
+}
+
 /**
  * liveupdate_register_file_handler - Register a file handler with LUO.
  * @fh: Pointer to a caller-allocated &struct liveupdate_file_handler.
@@ -796,6 +913,7 @@ EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
  */
 int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 {
+	struct luo_session *s;
 	unsigned long token;
 	struct luo_file *h;
 	int ret = 0;
@@ -807,15 +925,18 @@ int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 	}
 
 	down_write(&luo_register_file_list_rwsem);
-
-	xa_for_each(&luo_files_xa_out, token, h) {
-		if (h->fh == fh) {
-			up_write(&luo_register_file_list_rwsem);
-			luo_state_read_exit();
-			return -EBUSY;
+	down_read(&luo_sessions_list_rwsem);
+	list_for_each_entry(s, &luo_sessions_list, list) {
+		xa_for_each(&s->files_xa_out, token, h) {
+			if (h->fh == fh) {
+				up_read(&luo_sessions_list_rwsem);
+				up_write(&luo_register_file_list_rwsem);
+				luo_state_read_exit();
+				return -EBUSY;
+			}
 		}
 	}
-
+	up_read(&luo_sessions_list_rwsem);
 	list_del_init(&fh->list);
 	up_write(&luo_register_file_list_rwsem);
 	luo_state_read_exit();
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 05cd861ed2a8..8fef414e7e3e 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -25,9 +25,14 @@ int luo_do_subsystems_freeze_calls(void);
 void luo_do_subsystems_finish_calls(void);
 void luo_do_subsystems_cancel_calls(void);
 
+struct luo_session;
+
 int luo_retrieve_file(u64 token, struct file **filep);
-int luo_register_file(u64 token, int fd);
-int luo_unregister_file(u64 token);
+int luo_register_file(struct luo_session *s, u64 token, int fd);
+int luo_unregister_file(struct luo_session *s, u64 token);
+
+struct luo_session *luo_create_session(void);
+void luo_destroy_session(struct luo_session *s);
 
 #ifdef CONFIG_LIVEUPDATE_SYSFS_API
 void luo_sysfs_notify(void);
diff --git a/kernel/liveupdate/luo_ioctl.c b/kernel/liveupdate/luo_ioctl.c
index 3de1d243df5a..d2c49cf33dd3 100644
--- a/kernel/liveupdate/luo_ioctl.c
+++ b/kernel/liveupdate/luo_ioctl.c
@@ -62,6 +62,17 @@ static int luo_open(struct inode *inodep, struct file *filep)
 	if (filep->f_flags & O_EXCL)
 		return -EINVAL;
 
+	filep->private_data = luo_create_session();
+	if (!filep->private_data)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int luo_release(struct inode *inodep, struct file *filep)
+{
+	luo_destroy_session(filep->private_data);
+
 	return 0;
 }
 
@@ -101,9 +112,11 @@ static long luo_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 			break;
 		}
 
-		ret = luo_register_file(luo_fd.token, luo_fd.fd);
+		ret = luo_register_file(filep->private_data, luo_fd.token,
+					luo_fd.fd);
 		if (!ret && copy_to_user(argp, &luo_fd, sizeof(luo_fd))) {
-			WARN_ON_ONCE(luo_unregister_file(luo_fd.token));
+			WARN_ON_ONCE(luo_unregister_file(filep->private_data,
+							 luo_fd.token));
 			ret = -EFAULT;
 		}
 		break;
@@ -114,7 +127,7 @@ static long luo_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 			break;
 		}
 
-		ret = luo_unregister_file(token);
+		ret = luo_unregister_file(filep->private_data, token);
 		break;
 
 	case LIVEUPDATE_IOCTL_FD_RESTORE:
@@ -140,6 +153,7 @@ static long luo_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 static const struct file_operations fops = {
 	.owner          = THIS_MODULE,
 	.open           = luo_open,
+	.release	= luo_release,
 	.unlocked_ioctl = luo_ioctl,
 };
 
-- 
2.50.0.727.gbf7dc18ff4-goog


