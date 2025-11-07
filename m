Return-Path: <linux-fsdevel+bounces-67483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 376FCC41B19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 22:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F54F42395E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 21:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E1930F941;
	Fri,  7 Nov 2025 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TQL0YT54"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F54267B00
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549549; cv=none; b=tj/oIo1+eXiigCiQDWXZtgmBnZiQO/uamIS1qbiNSknFDDRGDNh4fSIcifhKgSMBkdCnyfnoRtEf5Mx5pY716vI4423h85TPEJ4nEXfcJR5xXFwwSTanD0ubKQc6XkHmQzTTIdPoo5yKNe+HB7y0aANskf8vfUhb0KHREU/l6Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549549; c=relaxed/simple;
	bh=arMv3Uml3w7W+Y/8Q8q1oELKbHlFGIzA8SRpMFCYgdU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9aF2zZw7qI0CUGmK9yuhsXEDnuBvYBwXMeuGhbVmjpQt5yrjEDDmDkEHmoK+D+FNs7DHA60dsJ2LLo2FG618R2BAuqix7IvR/D0+AKsd8mbsgEjxjjIpUpVbm8TitO0zF3LoQzjWebxRQ8q6wejhQgspmt51Z9hhQtG1YVMw3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=TQL0YT54; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63f97ab5cfcso1016794d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 13:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549546; x=1763154346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdwSyej57m2z8fVHqgqF2nxiJqoHnbMJTxDva58Hcjk=;
        b=TQL0YT54kreAk8jInheAbBoM6kOVOuos1ju+ZgCXfznJWko6iBlnXY8PGQoT+PzY+c
         k2fEXbT1SBtbhbAYPEIEh5HvoYOFJ5Gcjw45lMN6OUKtRPX3pYF5Tbzlias1EFNuqn05
         3FjRM3OFaCu8tGB8ryM75kLy+GHS7rvLLcvx3G4bxWNZ2Kpmxa0KrEmURxbg6f34cx1N
         PGmpZ39I/xfVVt2C8dlUbIf3uqbEAIUav+d4UT/pmZ5LvlOkGCQ1UY3l5Tth05VwcuIW
         j2Qyv0GF+QSoatkSWuGdG4SsBvAwoHEPOdiV9mOKEYQj6J5rgm1TvTBXsZTNlCV6+ZGA
         1C2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549546; x=1763154346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gdwSyej57m2z8fVHqgqF2nxiJqoHnbMJTxDva58Hcjk=;
        b=kF2h5ikNuaOrqpsmkxEe+KQmNwjtsCVL55ldFUuiKyM0u7fOm8E7qGkYWD4QsebocG
         DicQvVV5vYj8YOf7DIo2ZtaLaEeUam+2A882mRpifaRxIFqeKCIfJAt2LGEetl7kGIiT
         n3tSDI0HuNJOFh0SQuebjzYgoZ8CdIjCeW+8LfodTcT05AFAvEvmbOIn7mxZ1yFaFhdj
         IOu88xnXjM9OAtaH7bTrENtkrFWakz14RKxFNVLPL2nU9qQT/6H9UzLLS/MAu1+6X86R
         MDtXWNaHB0UFJExNRNfsXVU2o7PE8pO/zXbxT0EkRpIu2UYVSHDB0XjE9ygps1YiAhOY
         lQuA==
X-Forwarded-Encrypted: i=1; AJvYcCWph/9l9V0M/cr28mUE0O9dI14SKVjRN6pCguJvEoWcZDTogT2VgQQCnSjUYs3p54PjYqG5IZqdpHE/+9Jq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzen0dBRiGgXP5lsNWEFU4C+TnDrmlY0K1Su3+YlFykgPVHgSxP
	lnyRPEq922kkxCRghmgKHHCFYgy+Qzv0XJnDwgGc9lVLyE3KxvL+2z40khOjYZfnWSc=
X-Gm-Gg: ASbGnctMbMEgBTO8XWO5fEMH75Uis3vqnhOf7n3TMrYDXgVORqneF+Hg1q9FjGXekkm
	rjGNWKULSEaYaENvIcIhh6QmFlz+On9E7u/GESVNC+nlD99X/2VydwmVf4E1xRPId54hgFlvyPn
	hIkkuuZY9g3bvlGxSiJebxRiIBcIVu0W2Rt6xjQNNjwYCkXx/d2viYWtuugZmVFxx8lO7xTBH2A
	2BmLPjaq6djdDEvKxVDrRU1R6o3OWIvCAWNJIgM5vnU45JnVppJ2F0OAvjfN73ujaCYrc0bpX7L
	IomNqX0UUYnCOwoC7hZDFx8VgxArm6852AUW3N4SlfRz7BdR7siVnJevNfHeeWZUPeCCpygwxrd
	gRpCdLDt3GVZv1/JjckhyCQEb5CnMaqeU6RcVwT25C9uFqqwpKrFiSoR5X+oaaL56LqFkYqYY4g
	2BsvqmJVRMQo9w0TsmEb2l7/SBOcASIZQVGrBd4NXZ4sxCUa6jtj27LsS3Wb50lQ5dWmN5y3XVN
	IkTt9ffWgJe
X-Google-Smtp-Source: AGHT+IHDSr1AQF8Wap6vS17SlScfz5Kr2vkF9XLTYeISsPUyhEI9f5yexLUWISImV79oI8Dockuc/Q==
X-Received: by 2002:a05:690e:1657:b0:63f:aadb:397a with SMTP id 956f58d0204a3-640d45c8834mr350073d50.55.1762549545602;
        Fri, 07 Nov 2025 13:05:45 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:05:45 -0800 (PST)
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
Subject: [PATCH v5 07/22] liveupdate: luo_ioctl: add user interface
Date: Fri,  7 Nov 2025 16:03:05 -0500
Message-ID: <20251107210526.257742-8-pasha.tatashin@soleen.com>
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

Introduce the user-space interface for the Live Update Orchestrator
via ioctl commands, enabling external control over the live update
process and management of preserved resources.

The idea is that there is going to be a single userspace agent driving
the live update, therefore, only a single process can ever hold this
device opened at a time.

The following ioctl commands are introduced:

LIVEUPDATE_IOCTL_CREATE_SESSION
Provides a way for userspace to create a named session for grouping file
descriptors that need to be preserved. It returns a new file descriptor
representing the session.

LIVEUPDATE_IOCTL_RETRIEVE_SESSION
Allows the userspace agent in the new kernel to reclaim a preserved
session by its name, receiving a new file descriptor to manage the
restored resources.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/uapi/linux/liveupdate.h  |  64 ++++++++++++
 kernel/liveupdate/luo_internal.h |  21 ++++
 kernel/liveupdate/luo_ioctl.c    | 173 +++++++++++++++++++++++++++++++
 3 files changed, 258 insertions(+)

diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index d2ef2f7e0dbd..3ce60e976ecc 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -46,4 +46,68 @@
 /* The maximum length of session name including null termination */
 #define LIVEUPDATE_SESSION_NAME_LENGTH 56
 
+/* The /dev/liveupdate ioctl commands */
+enum {
+	LIVEUPDATE_CMD_BASE = 0x00,
+	LIVEUPDATE_CMD_CREATE_SESSION = LIVEUPDATE_CMD_BASE,
+	LIVEUPDATE_CMD_RETRIEVE_SESSION = 0x01,
+};
+
+/**
+ * struct liveupdate_ioctl_create_session - ioctl(LIVEUPDATE_IOCTL_CREATE_SESSION)
+ * @size:	Input; sizeof(struct liveupdate_ioctl_create_session)
+ * @fd:		Output; The new file descriptor for the created session.
+ * @name:	Input; A null-terminated string for the session name, max
+ *		length %LIVEUPDATE_SESSION_NAME_LENGTH including termination
+ *		char.
+ *
+ * Creates a new live update session for managing preserved resources.
+ * This ioctl can only be called on the main /dev/liveupdate device.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+struct liveupdate_ioctl_create_session {
+	__u32		size;
+	__s32		fd;
+	__u8		name[LIVEUPDATE_SESSION_NAME_LENGTH];
+};
+
+#define LIVEUPDATE_IOCTL_CREATE_SESSION					\
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_CREATE_SESSION)
+
+/**
+ * struct liveupdate_ioctl_retrieve_session - ioctl(LIVEUPDATE_IOCTL_RETRIEVE_SESSION)
+ * @size:    Input; sizeof(struct liveupdate_ioctl_retrieve_session)
+ * @fd:      Output; The new file descriptor for the retrieved session.
+ * @name:    Input; A null-terminated string identifying the session to retrieve.
+ *           The name must exactly match the name used when the session was
+ *           created in the previous kernel.
+ *
+ * Retrieves a handle (a new file descriptor) for a preserved session by its
+ * name. This is the primary mechanism for a userspace agent to regain control
+ * of its preserved resources after a live update.
+ *
+ * The userspace application provides the null-terminated `name` of a session
+ * it created before the live update. If a preserved session with a matching
+ * name is found, the kernel instantiates it and returns a new file descriptor
+ * in the `fd` field. This new session FD can then be used for all file-specific
+ * operations, such as restoring individual file descriptors with
+ * LIVEUPDATE_SESSION_RETRIEVE_FD.
+ *
+ * It is the responsibility of the userspace application to know the names of
+ * the sessions it needs to retrieve. If no session with the given name is
+ * found, the ioctl will fail with -ENOENT.
+ *
+ * This ioctl can only be called on the main /dev/liveupdate device when the
+ * system is in the LIVEUPDATE_STATE_UPDATED state.
+ */
+struct liveupdate_ioctl_retrieve_session {
+	__u32		size;
+	__s32		fd;
+	__u8		name[64];
+};
+
+#define LIVEUPDATE_IOCTL_RETRIEVE_SESSION \
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_RETRIEVE_SESSION)
+
 #endif /* _UAPI_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index b4f2d1443c76..ab4652d79e64 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -9,6 +9,27 @@
 #define _LINUX_LUO_INTERNAL_H
 
 #include <linux/liveupdate.h>
+#include <linux/uaccess.h>
+
+struct luo_ucmd {
+	void __user *ubuffer;
+	u32 user_size;
+	void *cmd;
+};
+
+static inline int luo_ucmd_respond(struct luo_ucmd *ucmd,
+				   size_t kernel_cmd_size)
+{
+	/*
+	 * Copy the minimum of what the user provided and what we actually
+	 * have.
+	 */
+	if (copy_to_user(ucmd->ubuffer, ucmd->cmd,
+			 min_t(size_t, ucmd->user_size, kernel_cmd_size))) {
+		return -EFAULT;
+	}
+	return 0;
+}
 
 void *luo_alloc_preserve(size_t size);
 void luo_free_unpreserve(void *mem, size_t size);
diff --git a/kernel/liveupdate/luo_ioctl.c b/kernel/liveupdate/luo_ioctl.c
index 44d365185f7c..ab03792fec0f 100644
--- a/kernel/liveupdate/luo_ioctl.c
+++ b/kernel/liveupdate/luo_ioctl.c
@@ -5,15 +5,187 @@
  * Pasha Tatashin <pasha.tatashin@soleen.com>
  */
 
+/**
+ * DOC: LUO ioctl Interface
+ *
+ * The IOCTL user-space control interface for the LUO subsystem.
+ * It registers a character device, typically found at ``/dev/liveupdate``,
+ * which allows a userspace agent to manage the LUO state machine and its
+ * associated resources, such as preservable file descriptors.
+ *
+ * To ensure that the state machine is controlled by a single entity, access
+ * to this device is exclusive: only one process is permitted to have
+ * ``/dev/liveupdate`` open at any given time. Subsequent open attempts will
+ * fail with -EBUSY until the first process closes its file descriptor.
+ * This singleton model simplifies state management by preventing conflicting
+ * commands from multiple userspace agents.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/atomic.h>
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/liveupdate.h>
 #include <linux/miscdevice.h>
+#include <uapi/linux/liveupdate.h>
+#include "luo_internal.h"
 
 struct luo_device_state {
 	struct miscdevice miscdev;
+	atomic_t in_use;
 };
 
+static int luo_ioctl_create_session(struct luo_ucmd *ucmd)
+{
+	struct liveupdate_ioctl_create_session *argp = ucmd->cmd;
+	struct file *file;
+	int ret;
+
+	argp->fd = get_unused_fd_flags(O_CLOEXEC);
+	if (argp->fd < 0)
+		return argp->fd;
+
+	ret = luo_session_create(argp->name, &file);
+	if (ret)
+		return ret;
+
+	ret = luo_ucmd_respond(ucmd, sizeof(*argp));
+	if (ret) {
+		fput(file);
+		put_unused_fd(argp->fd);
+		return ret;
+	}
+
+	fd_install(argp->fd, file);
+
+	return 0;
+}
+
+static int luo_ioctl_retrieve_session(struct luo_ucmd *ucmd)
+{
+	struct liveupdate_ioctl_retrieve_session *argp = ucmd->cmd;
+	struct file *file;
+	int ret;
+
+	argp->fd = get_unused_fd_flags(O_CLOEXEC);
+	if (argp->fd < 0)
+		return argp->fd;
+
+	ret = luo_session_retrieve(argp->name, &file);
+	if (ret < 0) {
+		put_unused_fd(argp->fd);
+
+		return ret;
+	}
+
+	ret = luo_ucmd_respond(ucmd, sizeof(*argp));
+	if (ret) {
+		fput(file);
+		put_unused_fd(argp->fd);
+		return ret;
+	}
+
+	fd_install(argp->fd, file);
+
+	return 0;
+}
+
+static int luo_open(struct inode *inodep, struct file *filep)
+{
+	struct luo_device_state *ldev = container_of(filep->private_data,
+						     struct luo_device_state,
+						     miscdev);
+
+	if (atomic_cmpxchg(&ldev->in_use, 0, 1))
+		return -EBUSY;
+
+	luo_session_deserialize();
+
+	return 0;
+}
+
+static int luo_release(struct inode *inodep, struct file *filep)
+{
+	struct luo_device_state *ldev = container_of(filep->private_data,
+						     struct luo_device_state,
+						     miscdev);
+	atomic_set(&ldev->in_use, 0);
+
+	return 0;
+}
+
+union ucmd_buffer {
+	struct liveupdate_ioctl_create_session create;
+	struct liveupdate_ioctl_retrieve_session retrieve;
+};
+
+struct luo_ioctl_op {
+	unsigned int size;
+	unsigned int min_size;
+	unsigned int ioctl_num;
+	int (*execute)(struct luo_ucmd *ucmd);
+};
+
+#define IOCTL_OP(_ioctl, _fn, _struct, _last)                                  \
+	[_IOC_NR(_ioctl) - LIVEUPDATE_CMD_BASE] = {                            \
+		.size = sizeof(_struct) +                                      \
+			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) <          \
+					  sizeof(_struct)),                    \
+		.min_size = offsetofend(_struct, _last),                       \
+		.ioctl_num = _ioctl,                                           \
+		.execute = _fn,                                                \
+	}
+
+static const struct luo_ioctl_op luo_ioctl_ops[] = {
+	IOCTL_OP(LIVEUPDATE_IOCTL_CREATE_SESSION, luo_ioctl_create_session,
+		 struct liveupdate_ioctl_create_session, name),
+	IOCTL_OP(LIVEUPDATE_IOCTL_RETRIEVE_SESSION, luo_ioctl_retrieve_session,
+		 struct liveupdate_ioctl_retrieve_session, name),
+};
+
+static long luo_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
+{
+	const struct luo_ioctl_op *op;
+	struct luo_ucmd ucmd = {};
+	union ucmd_buffer buf;
+	unsigned int nr;
+	int ret;
+
+	nr = _IOC_NR(cmd);
+	if (nr < LIVEUPDATE_CMD_BASE ||
+	    (nr - LIVEUPDATE_CMD_BASE) >= ARRAY_SIZE(luo_ioctl_ops)) {
+		return -EINVAL;
+	}
+
+	ucmd.ubuffer = (void __user *)arg;
+	ret = get_user(ucmd.user_size, (u32 __user *)ucmd.ubuffer);
+	if (ret)
+		return ret;
+
+	op = &luo_ioctl_ops[nr - LIVEUPDATE_CMD_BASE];
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
+	return op->execute(&ucmd);
+}
+
 static const struct file_operations luo_fops = {
 	.owner		= THIS_MODULE,
+	.open		= luo_open,
+	.release	= luo_release,
+	.unlocked_ioctl	= luo_ioctl,
 };
 
 static struct luo_device_state luo_dev = {
@@ -22,6 +194,7 @@ static struct luo_device_state luo_dev = {
 		.name  = "liveupdate",
 		.fops  = &luo_fops,
 	},
+	.in_use = ATOMIC_INIT(0),
 };
 
 static int __init liveupdate_ioctl_init(void)
-- 
2.51.2.1041.gc1ab5b90ca-goog


