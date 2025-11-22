Return-Path: <linux-fsdevel+bounces-69489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F066C7D8E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 23:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A218534E155
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 22:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9852C2D9EC7;
	Sat, 22 Nov 2025 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="GNHBOd4i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE6F2D7DF2
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850255; cv=none; b=mIBJpv8Gx/tI4msvypYhDHb4Sd1D5QYMvckwQtcJ3sD5GTgFuAJzaSbgjzVkOLdhlYLYcyOWh4tRWnri2LVy5F3YU2iGVkIaAcVJQmT1+SKTzMt/Z+0GV3Hv3VOPrhMDKHSQGY0Tgpr1qprIGt5/yIExcbanmvmgg1o3rTcMc7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850255; c=relaxed/simple;
	bh=kgZHf9xz4+4bBw2EOBuQEpUtWJuh9Bt1Lgy3ywrEmYw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTNt8C3U3CkkqZ2h7moJm683RbBG12kGFeiUytNI0O/SdIAYsuoy6pBHQOEka8C/E0hu5uoi0aXuTDsFhK6V1BYMYKr3ni/OYmeW9kfpDC9sYnuwAkSAVNhu+O5ZO99i6zkvU7WnlXbRfcVVV4/h1p6jXWLhL/UTHdpd3fxo86I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=GNHBOd4i; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-640d8b78608so2270898d50.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 14:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850251; x=1764455051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wE+SYfoU7cK/nhV6OlVUw04UpAJe3OMhPaMlk1e9ud4=;
        b=GNHBOd4ilqM6mBFUA7vI+7o0FLW00FdXYJZdGGUGnqg28g6Ago5LwZhuy6Zx398WVU
         fxnf3XNrMfUfVRzbAQ7JHc7eD597s1rdcVM1zeUpp1zSU8eigWxlriST86Vpl0WWT1bj
         OgUDqFLXxc2nHcoiBlbdEDsm3xnmk+/CfjCScIzk1oyHGe9kNUJ5q1NapV3xjVKIbRph
         gUZHD71VOoX3DIbdmLAX7UvE/ctelzBzVsmNyhnIXmEfzjOnoTfO+/IjwdJ9LzSs/KtA
         x2GCMBEai+2NqfmEsdmnBZJnsENQFcmSI+NtQN9B9Okb7nAKZle2o25MPJIt0XsG3gRB
         w7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850251; x=1764455051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wE+SYfoU7cK/nhV6OlVUw04UpAJe3OMhPaMlk1e9ud4=;
        b=DUilefZnPuQNXTU0nXVmAdC35CbiK3Vi1XThuZUBSGcAslP/ceQ6ucNN2AwWOSY0L/
         pci7GNV/CWoeyOhy/M+DYDmk8umGlDlM8pZXVppR3oo7DcYLl+zk3LKIOx6TqyY2pqp+
         hH+Uq+DlRVE12RYmkBDXxtcUOpE+suEgzPcNzP+VI8mlZvYUiZGdTz5Lh9V6Wi6YfGie
         3/Jw1td/HFmYrU+jpo/RAz659yxdDf3BsMunMh67AjolfwCoFWPOAKfwBKq9S4qdS8TG
         FYWUicTTLOK0Fl2BU1UlLeT8Ssw7cZRmsRjAk3kbyoC4J4SRlOFYyJx40GjgORRB138i
         p4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6NdFaIiId9gbh9qZtF6cwkG2O3/xmzdiUITVO4kzN/SGwtwLMAuM3Vuo8CLMTsJtSWRG3BLhlxj2vcwN8@vger.kernel.org
X-Gm-Message-State: AOJu0YyspHRcn8ljU1g9ToLDyRTo2BSTyyghFuD4RHC5v6tB2TQTVI1P
	qr7iUPdU4wZ+XWTfL3Tdn5EQoM/ih+lb/GnJuipEhcNpSnzzN3WBfLrYFc9SAi7PD/0=
X-Gm-Gg: ASbGncuKKLw3IG77LRsFY/0wcLvQYYLbFOLTo7u/XesFPg0fF9v2OHvsZ7mE+bIBJbJ
	D36k2ywG9VXzlOISIJwOAXP31LcZkPW6yIprYyFD9WuzZV+XsPDVK+sZ1HP1Lf7qw0pdi7h3vX6
	zNoHacnLnJjD7W2DsIwHx3b7ceEv+Fu2LgA1RXUF1W3vwr8XHPBx7kgT/CP35CTGtGCrRnoMIvl
	BBJT5enypxQdZ/R7sGOPltLLhxJ3s8rpNKcerZJkBPa3d/A86FAmymGE1O/d98bwjBDxmrOIbRB
	Gwrbx1b3w+IFGUvS2DVkfz+zqHpOsISNOa8VonsxO7Yiy7d+Uyrz7xfMXsTYGwwGSp8bo0WJTBn
	SbRyFJIttX48ZhZo8aPPFbhQCw3TWMKbRE49xHNjUU8gQGkK48sTYWrJJhjc8AovgpzShpwQ8L0
	pCAIFRaapn0b3PhrK8FxemB1hev+MrgDcmpu6eooteBcXfPn+ZeEKjTlBoQ77gk2pCK1qIv4viF
	NuRk5Y=
X-Google-Smtp-Source: AGHT+IFScFT+y7taI+nsUYPq/JIzG5JwdVjEcr1qsjsOYvdiw1Mp8L5ZIUpuDVOehaLVZrPL9iFxhw==
X-Received: by 2002:a05:690e:18e:b0:641:f5bc:694e with SMTP id 956f58d0204a3-64302aee0bcmr3414583d50.82.1763850250714;
        Sat, 22 Nov 2025 14:24:10 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:24:10 -0800 (PST)
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
Subject: [PATCH v7 07/22] liveupdate: luo_session: Add ioctls for file preservation
Date: Sat, 22 Nov 2025 17:23:34 -0500
Message-ID: <20251122222351.1059049-8-pasha.tatashin@soleen.com>
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

Introducing the userspace interface and internal logic required to
manage the lifecycle of file descriptors within a session. Previously, a
session was merely a container; this change makes it a functional
management unit.

The following capabilities are added:

A new set of ioctl commands are added, which operate on the file
descriptor returned by CREATE_SESSION. This allows userspace to:
- LIVEUPDATE_SESSION_PRESERVE_FD: Add a file descriptor to a session
  to be preserved across the live update.
- LIVEUPDATE_SESSION_RETRIEVE_FD: Retrieve a preserved file in the
  new kernel using its unique token.
- LIVEUPDATE_SESSION_FINISH: finish session

The session's .release handler is enhanced to be state-aware. When a
session's file descriptor is closed, it correctly unpreserves
the session based on its current state before freeing all
associated file resources.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 include/uapi/linux/liveupdate.h | 103 ++++++++++++++++++
 kernel/liveupdate/luo_session.c | 187 +++++++++++++++++++++++++++++++-
 2 files changed, 288 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 1183cf984b5f..30bc66ee9436 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -53,6 +53,14 @@ enum {
 	LIVEUPDATE_CMD_RETRIEVE_SESSION = 0x01,
 };
 
+/* ioctl commands for session file descriptors */
+enum {
+	LIVEUPDATE_CMD_SESSION_BASE = 0x40,
+	LIVEUPDATE_CMD_SESSION_PRESERVE_FD = LIVEUPDATE_CMD_SESSION_BASE,
+	LIVEUPDATE_CMD_SESSION_RETRIEVE_FD = 0x41,
+	LIVEUPDATE_CMD_SESSION_FINISH = 0x42,
+};
+
 /**
  * struct liveupdate_ioctl_create_session - ioctl(LIVEUPDATE_IOCTL_CREATE_SESSION)
  * @size:	Input; sizeof(struct liveupdate_ioctl_create_session)
@@ -110,4 +118,99 @@ struct liveupdate_ioctl_retrieve_session {
 #define LIVEUPDATE_IOCTL_RETRIEVE_SESSION \
 	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_RETRIEVE_SESSION)
 
+/* Session specific IOCTLs */
+
+/**
+ * struct liveupdate_session_preserve_fd - ioctl(LIVEUPDATE_SESSION_PRESERVE_FD)
+ * @size:  Input; sizeof(struct liveupdate_session_preserve_fd)
+ * @fd:    Input; The user-space file descriptor to be preserved.
+ * @token: Input; An opaque, unique token for preserved resource.
+ *
+ * Holds parameters for preserving a file descriptor.
+ *
+ * User sets the @fd field identifying the file descriptor to preserve
+ * (e.g., memfd, kvm, iommufd, VFIO). The kernel validates if this FD type
+ * and its dependencies are supported for preservation. If validation passes,
+ * the kernel marks the FD internally and *initiates the process* of preparing
+ * its state for saving. The actual snapshotting of the state typically occurs
+ * during the subsequent %LIVEUPDATE_IOCTL_PREPARE execution phase, though
+ * some finalization might occur during freeze.
+ * On successful validation and initiation, the kernel uses the @token
+ * field with an opaque identifier representing the resource being preserved.
+ * This token confirms the FD is targeted for preservation and is required for
+ * the subsequent %LIVEUPDATE_SESSION_RETRIEVE_FD call after the live update.
+ *
+ * Return: 0 on success (validation passed, preservation initiated), negative
+ * error code on failure (e.g., unsupported FD type, dependency issue,
+ * validation failed).
+ */
+struct liveupdate_session_preserve_fd {
+	__u32		size;
+	__s32		fd;
+	__aligned_u64	token;
+};
+
+#define LIVEUPDATE_SESSION_PRESERVE_FD					\
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_PRESERVE_FD)
+
+/**
+ * struct liveupdate_session_retrieve_fd - ioctl(LIVEUPDATE_SESSION_RETRIEVE_FD)
+ * @size:  Input; sizeof(struct liveupdate_session_retrieve_fd)
+ * @fd:    Output; The new file descriptor representing the fully restored
+ *         kernel resource.
+ * @token: Input; An opaque, token that was used to preserve the resource.
+ *
+ * Retrieve a previously preserved file descriptor.
+ *
+ * User sets the @token field to the value obtained from a successful
+ * %LIVEUPDATE_IOCTL_FD_PRESERVE call before the live update. On success,
+ * the kernel restores the state (saved during the PREPARE/FREEZE phases)
+ * associated with the token and populates the @fd field with a new file
+ * descriptor referencing the restored resource in the current (new) kernel.
+ * This operation must be performed *before* signaling completion via
+ * %LIVEUPDATE_IOCTL_FINISH.
+ *
+ * Return: 0 on success, negative error code on failure (e.g., invalid token).
+ */
+struct liveupdate_session_retrieve_fd {
+	__u32		size;
+	__s32		fd;
+	__aligned_u64	token;
+};
+
+#define LIVEUPDATE_SESSION_RETRIEVE_FD					\
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_RETRIEVE_FD)
+
+/**
+ * struct liveupdate_session_finish - ioctl(LIVEUPDATE_SESSION_FINISH)
+ * @size:     Input; sizeof(struct liveupdate_session_finish)
+ * @reserved: Input; Must be zero. Reserved for future use.
+ *
+ * Signals the completion of the restoration process for a retrieved session.
+ * This is the final operation that should be performed on a session file
+ * descriptor after a live update.
+ *
+ * This ioctl must be called once all required file descriptors for the session
+ * have been successfully retrieved (using %LIVEUPDATE_SESSION_RETRIEVE_FD) and
+ * are fully restored from the userspace and kernel perspective.
+ *
+ * Upon success, the kernel releases its ownership of the preserved resources
+ * associated with this session. This allows internal resources to be freed,
+ * typically by decrementing reference counts on the underlying preserved
+ * objects.
+ *
+ * If this operation fails, the resources remain preserved in memory. Userspace
+ * may attempt to call finish again. The resources will otherwise be reset
+ * during the next live update cycle.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+struct liveupdate_session_finish {
+	__u32		size;
+	__u32		reserved;
+};
+
+#define LIVEUPDATE_SESSION_FINISH					\
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_FINISH)
+
 #endif /* _UAPI_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index ee363d1b2b10..cf5c83b272e7 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -125,6 +125,8 @@ static struct luo_session *luo_session_alloc(const char *name)
 		return ERR_PTR(-ENOMEM);
 
 	strscpy(session->name, name, sizeof(session->name));
+	INIT_LIST_HEAD(&session->file_set.files_list);
+	luo_file_set_init(&session->file_set);
 	INIT_LIST_HEAD(&session->list);
 	mutex_init(&session->mutex);
 
@@ -133,6 +135,7 @@ static struct luo_session *luo_session_alloc(const char *name)
 
 static void luo_session_free(struct luo_session *session)
 {
+	luo_file_set_destroy(&session->file_set);
 	mutex_destroy(&session->mutex);
 	kfree(session);
 }
@@ -177,16 +180,46 @@ static void luo_session_remove(struct luo_session_header *sh,
 	sh->count--;
 }
 
+static int luo_session_finish_one(struct luo_session *session)
+{
+	guard(mutex)(&session->mutex);
+	return luo_file_finish(&session->file_set);
+}
+
+static void luo_session_unfreeze_one(struct luo_session *session,
+				     struct luo_session_ser *ser)
+{
+	guard(mutex)(&session->mutex);
+	luo_file_unfreeze(&session->file_set, &ser->file_set_ser);
+}
+
+static int luo_session_freeze_one(struct luo_session *session,
+				  struct luo_session_ser *ser)
+{
+	guard(mutex)(&session->mutex);
+	return luo_file_freeze(&session->file_set, &ser->file_set_ser);
+}
+
 static int luo_session_release(struct inode *inodep, struct file *filep)
 {
 	struct luo_session *session = filep->private_data;
 	struct luo_session_header *sh;
 
 	/* If retrieved is set, it means this session is from incoming list */
-	if (session->retrieved)
+	if (session->retrieved) {
+		int err = luo_session_finish_one(session);
+
+		if (err) {
+			pr_warn("Unable to finish session [%s] on release\n",
+				session->name);
+			return err;
+		}
 		sh = &luo_session_global.incoming;
-	else
+	} else {
+		scoped_guard(mutex, &session->mutex)
+			luo_file_unpreserve_files(&session->file_set);
 		sh = &luo_session_global.outgoing;
+	}
 
 	luo_session_remove(sh, session);
 	luo_session_free(session);
@@ -194,9 +227,140 @@ static int luo_session_release(struct inode *inodep, struct file *filep)
 	return 0;
 }
 
+static int luo_session_preserve_fd(struct luo_session *session,
+				   struct luo_ucmd *ucmd)
+{
+	struct liveupdate_session_preserve_fd *argp = ucmd->cmd;
+	int err;
+
+	guard(mutex)(&session->mutex);
+	err = luo_preserve_file(&session->file_set, argp->token, argp->fd);
+	if (err)
+		return err;
+
+	err = luo_ucmd_respond(ucmd, sizeof(*argp));
+	if (err)
+		pr_warn("The file was successfully preserved, but response to user failed\n");
+
+	return err;
+}
+
+static int luo_session_retrieve_fd(struct luo_session *session,
+				   struct luo_ucmd *ucmd)
+{
+	struct liveupdate_session_retrieve_fd *argp = ucmd->cmd;
+	struct file *file;
+	int err;
+
+	argp->fd = get_unused_fd_flags(O_CLOEXEC);
+	if (argp->fd < 0)
+		return argp->fd;
+
+	guard(mutex)(&session->mutex);
+	err = luo_retrieve_file(&session->file_set, argp->token, &file);
+	if (err < 0)
+		goto  err_put_fd;
+
+	err = luo_ucmd_respond(ucmd, sizeof(*argp));
+	if (err)
+		goto err_put_file;
+
+	fd_install(argp->fd, file);
+
+	return 0;
+
+err_put_file:
+	fput(file);
+err_put_fd:
+	put_unused_fd(argp->fd);
+
+	return err;
+}
+
+static int luo_session_finish(struct luo_session *session,
+			      struct luo_ucmd *ucmd)
+{
+	struct liveupdate_session_finish *argp = ucmd->cmd;
+	int err = luo_session_finish_one(session);
+
+	if (err)
+		return err;
+
+	return luo_ucmd_respond(ucmd, sizeof(*argp));
+}
+
+union ucmd_buffer {
+	struct liveupdate_session_finish finish;
+	struct liveupdate_session_preserve_fd preserve;
+	struct liveupdate_session_retrieve_fd retrieve;
+};
+
+struct luo_ioctl_op {
+	unsigned int size;
+	unsigned int min_size;
+	unsigned int ioctl_num;
+	int (*execute)(struct luo_session *session, struct luo_ucmd *ucmd);
+};
+
+#define IOCTL_OP(_ioctl, _fn, _struct, _last)                                  \
+	[_IOC_NR(_ioctl) - LIVEUPDATE_CMD_SESSION_BASE] = {                    \
+		.size = sizeof(_struct) +                                      \
+			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) <          \
+					  sizeof(_struct)),                    \
+		.min_size = offsetofend(_struct, _last),                       \
+		.ioctl_num = _ioctl,                                           \
+		.execute = _fn,                                                \
+	}
+
+static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
+	IOCTL_OP(LIVEUPDATE_SESSION_FINISH, luo_session_finish,
+		 struct liveupdate_session_finish, reserved),
+	IOCTL_OP(LIVEUPDATE_SESSION_PRESERVE_FD, luo_session_preserve_fd,
+		 struct liveupdate_session_preserve_fd, token),
+	IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
+		 struct liveupdate_session_retrieve_fd, token),
+};
+
+static long luo_session_ioctl(struct file *filep, unsigned int cmd,
+			      unsigned long arg)
+{
+	struct luo_session *session = filep->private_data;
+	const struct luo_ioctl_op *op;
+	struct luo_ucmd ucmd = {};
+	union ucmd_buffer buf;
+	unsigned int nr;
+	int ret;
+
+	nr = _IOC_NR(cmd);
+	if (nr < LIVEUPDATE_CMD_SESSION_BASE || (nr - LIVEUPDATE_CMD_SESSION_BASE) >=
+	    ARRAY_SIZE(luo_session_ioctl_ops)) {
+		return -EINVAL;
+	}
+
+	ucmd.ubuffer = (void __user *)arg;
+	ret = get_user(ucmd.user_size, (u32 __user *)ucmd.ubuffer);
+	if (ret)
+		return ret;
+
+	op = &luo_session_ioctl_ops[nr - LIVEUPDATE_CMD_SESSION_BASE];
+	if (op->ioctl_num != cmd)
+		return -ENOIOCTLCMD;
+	if (ucmd.user_size < op->min_size)
+		return -EINVAL;
+
+	ucmd.cmd = &buf;
+	ret = copy_struct_from_user(ucmd.cmd, op->size, ucmd.ubuffer,
+				    ucmd.user_size);
+	if (ret)
+		return ret;
+
+	return op->execute(session, &ucmd);
+}
+
 static const struct file_operations luo_session_fops = {
 	.owner = THIS_MODULE,
 	.release = luo_session_release,
+	.unlocked_ioctl = luo_session_ioctl,
 };
 
 /* Create a "struct file" for session */
@@ -394,6 +558,11 @@ int luo_session_deserialize(void)
 				session->name, ERR_PTR(err));
 			return err;
 		}
+
+		scoped_guard(mutex, &session->mutex) {
+			luo_file_deserialize(&session->file_set,
+					     &sh->ser[i].file_set_ser);
+		}
 	}
 
 	kho_restore_free(sh->header_ser);
@@ -408,9 +577,14 @@ int luo_session_serialize(void)
 	struct luo_session_header *sh = &luo_session_global.outgoing;
 	struct luo_session *session;
 	int i = 0;
+	int err;
 
 	guard(rwsem_write)(&sh->rwsem);
 	list_for_each_entry(session, &sh->list, list) {
+		err = luo_session_freeze_one(session, &sh->ser[i]);
+		if (err)
+			goto err_undo;
+
 		strscpy(sh->ser[i].name, session->name,
 			sizeof(sh->ser[i].name));
 		i++;
@@ -418,6 +592,15 @@ int luo_session_serialize(void)
 	sh->header_ser->count = sh->count;
 
 	return 0;
+
+err_undo:
+	list_for_each_entry_continue_reverse(session, &sh->list, list) {
+		i--;
+		luo_session_unfreeze_one(session, &sh->ser[i]);
+		memset(sh->ser[i].name, 0, sizeof(sh->ser[i].name));
+	}
+
+	return err;
 }
 
 /**
-- 
2.52.0.rc2.455.g230fcf2819-goog


