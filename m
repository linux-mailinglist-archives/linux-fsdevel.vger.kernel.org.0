Return-Path: <linux-fsdevel+bounces-67485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 793D7C41B49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 22:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0947F4F1BF3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 21:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF8C33EAE9;
	Fri,  7 Nov 2025 21:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="S1PCexuT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63B533F37C
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549553; cv=none; b=BSDUQSNLl01n4VzYF6c5J002D2uft5wRKkkQ0Or9Hhu7OYVTHUpaujPHBWeNax9WBbY7reYdQi/sTFFIs2x+LKosBa+4NxNeaSmgYb5pkjBKOpatHjWIUw/Yk/8Hz30UqM8QWp6MhlrCWA6IxY0JMHJYR/qNxbGpRFXfr8U2CDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549553; c=relaxed/simple;
	bh=1tAUjU7HRPRMnOOaxXw2LBOaUHpXqy5QA8W9SlbrSto=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGjSFbNhrgGIBz4Umxzkw8Jfkx3i7yH4Oyfsy5osDp90b7iAKHDJxJXf1rsrYezfMnT3kkAfDJQ7yBeKEji6qOYHKpyF1mAon17q0XxUFP0l0AR2peWsvplja/4j8VdIlHN/g+Z7ksUPgUTLuurULYPb/U3zSmygmdqX6b3zP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=S1PCexuT; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78488cdc20aso12734427b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 13:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549550; x=1763154350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0H1a2b10/az7J4jiEg4FN+EzMD5QNU4qG1nwYSONnc0=;
        b=S1PCexuTKw7a/5Qh5YcXzmCmMfpBdyHyVhtf6Y0UmLH5vDKFql2p+L+HHyNgnKOOL/
         Db/tbCJ+AemovQtwnKMWheVWlJVf4OXH/9pHQVQUKJXXpfXlWl+0dhebex/5sAgnH5Ja
         5o5nTVCJLROQvOM7epU0X5Fztd4DvIow1JR0M6uCT3BCwfwLxzf+vORXW4A/Pr+1RCDM
         9g0tqCVeUM/N4cTs1B1hVfC5DV9kTK8zpS1h7U89NWkVj4fj3NHawX24qKGC8463rbM5
         H5IqCgLa4VEVDQ+3AD9hvYa99YCRsePsb/ch+eKM+8PZzYQTd4uxG4FzyRF6b57MPe3Y
         M9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549550; x=1763154350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0H1a2b10/az7J4jiEg4FN+EzMD5QNU4qG1nwYSONnc0=;
        b=lNWZF1w6C/Z2Xk+fxkEFoncGaSkUU4rIT8YIIHzBwdMMwQHdCM8HVO1EO3+u2sOVnM
         N4ePsW38TweUcls8+uK+3oXxboL4wqSky4CIj5Acy/TK97TICJhf6JmqwtBYbCGQH8wJ
         02ji/vt/De5y2uJUAW27hSlqsf4ytbInndymR8sV6bf/2yxhV5BGt8xjS1BwpuUoCZnp
         1+YfBrKgZ8ybinAJ8HGL/VtrjMZUWUR5JSzO+XUfKlSjuUErHDzy5/MdIWbJ99X4WvVh
         f2gNbHF5hDLwEXxSYBk4cJ5282dBRS1F4SVpkPF1KthH1aI6fLRcF04SrjqJIhoRCoNo
         gKbw==
X-Forwarded-Encrypted: i=1; AJvYcCUgCfdWLDACmYOI5y5mAvIPJELBJPxJe+AvBKEDDaZHTzKqF6bzv3Qzr4Kj/h2+r2B8g9EsXs1LKMHEOh5i@vger.kernel.org
X-Gm-Message-State: AOJu0Yx92uCpaHpvx8HGXMFKMffRrGTXB8ytHcDfJzpV5K1MxQEa3jHV
	fcRR2xYQomXrUcPSHBtmzxaIXr2eX2c6qp8qV14uhQ0sge3NgYuH1zNS8aXlWVwnobI=
X-Gm-Gg: ASbGncseHgAnRjpPPAARXOkJZ263q8CsVc3ovk+Yp0igkkLF1VaPMypN2WZdcwRmfAi
	ykojJblY4Se3ejU9lCHXd9Jr2+NwFFctkVSC/V+dQv3tIaSPDHji3nLvcsyKbGoOq0jgIoyvygj
	l46A+IlgTlm44RRhQtjjcrrjOnBDev7hLXIX3M9yozDBkIwSbJyhJoXJtgXkYaGqy0ysWtsVLLw
	57yitsKqcI8JXSBo3tWydMG7+3Jesce/tKPi2AeTcb473MzyDs4V1OL4+UKpFSKh4radSPcX4Uz
	YIMH4299tVSwTNz3cDUUkZgnEM+xoYf2PIvkYhRQ1KhT6RonsK9PtWtRl5trEoAyPG5Ly6mnz0U
	xV9pkmPOYDr/YFdvojEixM/KuuHNiAud61AIfUqQrv6kgfdMR6mZXeBGxDGeYI0qB6QE4YM4Ocu
	bDeDJx0GygVj4uR8qIi25eQaNL/8I6KXtt6t/vUA33oUlXyz+p4hP7ZSkO0yeESbQ=
X-Google-Smtp-Source: AGHT+IFQwHqNI6dZv0OYvv/A/7mWGgOnDHLBKzgUSO31hY47HAU5moGRNVmS+T0lEJI58NPUXQlkuQ==
X-Received: by 2002:a05:690c:8d10:b0:784:8b82:98d8 with SMTP id 00721157ae682-787d5369a5emr6209347b3.16.1762549549650;
        Fri, 07 Nov 2025 13:05:49 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:05:49 -0800 (PST)
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
Subject: [PATCH v5 09/22] liveupdate: luo_session: Add ioctls for file preservation and state management
Date: Fri,  7 Nov 2025 16:03:07 -0500
Message-ID: <20251107210526.257742-10-pasha.tatashin@soleen.com>
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

Introducing the userspace interface and internal logic required to
manage the lifecycle of file descriptors within a session. Previously, a
session was merely a container; this change makes it a functional
management unit.

The following capabilities are added:

A new set of ioctl commands are added, which operate on the file
descriptor returned by CREATE_SESSION. This allows userspace to:
- LIVEUPDATE_SESSION_PRESERVE_FD: Add a file descriptor to a session
  to be preserved across the live update.
- LIVEUPDATE_SESSION_UNPRESERVE_FD: Remove a previously added file
  descriptor from the session.
- LIVEUPDATE_SESSION_RESTORE_FD: Retrieve a preserved file in the
  new kernel using its unique token.

A state machine for each individual session, distinct from the global
LUO state. This enables more granular control, allowing userspace to
prepare or freeze specific sessions independently. This is managed via:
- LIVEUPDATE_SESSION_SET_EVENT: An ioctl to send PREPARE, FREEZE,
  CANCEL, or FINISH events to a single session.
- LIVEUPDATE_SESSION_GET_STATE: An ioctl to query the current state
  of a single session.

The global subsystem callbacks (luo_session_prepare, luo_session_freeze)
are updated to iterate through all existing sessions. They now trigger
the appropriate per-session state transitions for any sessions that
haven't already been transitioned individually by userspace.

The session's .release handler is enhanced to be state-aware. When a
session's file descriptor is closed, it now correctly cancels or
finishes the session based on its current state before freeing all
associated file resources, preventing resource leaks.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/uapi/linux/liveupdate.h | 104 ++++++++++++++++++
 kernel/liveupdate/luo_session.c | 183 +++++++++++++++++++++++++++++++-
 2 files changed, 283 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 3ce60e976ecc..c55b3c7a1a39 100644
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
@@ -110,4 +118,100 @@ struct liveupdate_ioctl_retrieve_session {
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
+ * Holds parameters for preserving Validate and initiate preservation for a file
+ * descriptor.
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
+ * @size:  Input; sizeof(struct liveupdate_session_RETRIEVE_fd)
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
+	__u8		reserved[2];
+};
+
+#define LIVEUPDATE_SESSION_FINISH					\
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_FINISH)
+
 #endif /* _UAPI_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index a3513118aa74..ec526de83987 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -164,26 +164,185 @@ static void luo_session_remove(struct luo_session_head *sh,
 	sh->count--;
 }
 
+static int luo_session_finish_one(struct luo_session *session)
+{
+	guard(mutex)(&session->mutex);
+	return luo_file_finish(session);
+}
+
+static void luo_session_unfreeze_one(struct luo_session *session)
+{
+	guard(mutex)(&session->mutex);
+	luo_file_unfreeze(session);
+}
+
+static int luo_session_freeze_one(struct luo_session *session)
+{
+	guard(mutex)(&session->mutex);
+	return luo_file_freeze(session);
+}
+
 static int luo_session_release(struct inode *inodep, struct file *filep)
 {
 	struct luo_session *session = filep->private_data;
 	struct luo_session_head *sh;
+	int err = 0;
 
 	/* If retrieved is set, it means this session is from incoming list */
-	if (session->retrieved)
+	if (session->retrieved) {
 		sh = &luo_session_global.incoming;
-	else
+
+		err = luo_session_finish_one(session);
+		if (err) {
+			pr_warn("Unable to finish session [%s] on release\n",
+				session->name);
+		} else {
+			luo_session_remove(sh, session);
+			luo_session_free(session);
+		}
+
+	} else {
 		sh = &luo_session_global.outgoing;
 
-	luo_session_remove(sh, session);
-	luo_session_free(session);
+		scoped_guard(mutex, &session->mutex)
+			luo_file_unpreserve_files(session);
+		luo_session_remove(sh, session);
+		luo_session_free(session);
+	}
+
+	return err;
+}
+
+static int luo_session_preserve_fd(struct luo_session *session,
+				   struct luo_ucmd *ucmd)
+{
+	struct liveupdate_session_preserve_fd *argp = ucmd->cmd;
+	int err;
+
+	guard(mutex)(&session->mutex);
+	err = luo_preserve_file(session, argp->token, argp->fd);
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
+	err = luo_retrieve_file(session, argp->token, &file);
+	if (err < 0) {
+		put_unused_fd(argp->fd);
+
+		return err;
+	}
+
+	err = luo_ucmd_respond(ucmd, sizeof(*argp));
+	if (err)
+		return err;
+
+	fd_install(argp->fd, file);
 
 	return 0;
 }
 
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
@@ -375,6 +534,8 @@ int luo_session_deserialize(void)
 		session->count = sh->ser[i].count;
 		session->files = __va(sh->ser[i].files);
 		session->pgcnt = sh->ser[i].pgcnt;
+		scoped_guard(mutex, &session->mutex)
+			luo_file_deserialize(session);
 	}
 
 	luo_free_restore(sh->head_ser, sh->head_ser->pgcnt << PAGE_SHIFT);
@@ -389,9 +550,14 @@ int luo_session_serialize(void)
 	struct luo_session_head *sh = &luo_session_global.outgoing;
 	struct luo_session *session;
 	int i = 0;
+	int err;
 
 	guard(rwsem_write)(&sh->rwsem);
 	list_for_each_entry(session, &sh->list, list) {
+		err = luo_session_freeze_one(session);
+		if (err)
+			goto err_undo;
+
 		strscpy(sh->ser[i].name, session->name,
 			sizeof(sh->ser[i].name));
 		sh->ser[i].count = session->count;
@@ -402,4 +568,13 @@ int luo_session_serialize(void)
 	sh->head_ser->count = sh->count;
 
 	return 0;
+
+err_undo:
+	list_for_each_entry_continue_reverse(session, &sh->list, list) {
+		luo_session_unfreeze_one(session);
+		memset(&sh->ser[i], 0, sizeof(sh->ser[i]));
+		i--;
+	}
+
+	return err;
 }
-- 
2.51.2.1041.gc1ab5b90ca-goog


