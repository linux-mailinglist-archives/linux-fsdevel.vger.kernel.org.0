Return-Path: <linux-fsdevel+bounces-69810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A06DC86123
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 18:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7EC74EA050
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 17:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2CC32BF46;
	Tue, 25 Nov 2025 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="QGObA8dL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C05E32B991
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089949; cv=none; b=DdON/oUrV6n7ndzICRJMuCFLMAjNWMKFzlkyOVmU6UOPn5T0qqOjBH6yw999YPYSmObbZaMp4VDuYnnOJLMmSXMWrhGr30kv5FuzgiDYDQ5ifslkFkE5Exx8ac1exkJPLSfdnN/1o/A9CIww0gZpoScbvo6JUXlkSkd1lmSZ218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089949; c=relaxed/simple;
	bh=3tM7kSnLRy7sFArgZjMsRTIjTqxCZSzVQzifmn+OWtY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2BGcj/dOjVB6bIINgbIUUY86M4dktC9r69Y55BRdi1E9Cjwgxbcig2BwMLxf+KqgzZDd/VL2ONq/RO3UshmzM24uOWVzhUDCHvIfsYTpo61FykwjjzRbI6W2EArdRBvCEF1rK0o+e0b6zPO28wAcatoU5jt6/37tc69GUODshc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=QGObA8dL; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-642fcb9c16aso4458875d50.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 08:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764089946; x=1764694746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qY9wo9jaEowvBGqUAjQT6FCUqqOXzwqYWEwdmUcM3GY=;
        b=QGObA8dL/1xmeKrgHqpNkzxZIJ1GTEAuN4B2I0gZ8AutjEva1RIRJLz0MMlqU7LxhO
         CP1ZwbueKd0zOg2qYM0zTLO/8BICnMNAihHggLyhG0aCSKAmkejDCZR483/v/HtzXY07
         h34jgTNOtSfzE5hiSI3lsQC4ylc+S/ENpojJiL1+OX8fvsXx1brFVCSQH8NgokxqEKxH
         PdIU7rGLiIX5KMyq1YDF1kp6rggRFVd2fg5RnGuDzinw/13K+2T+6Lh8hU9/GIAiZToq
         EsejDIcAyGvDSAkWa/bGPFose2h50+CHHx1SjnH0Me3G/ZiGprpLbFOq6ArtEc1A2Gko
         7Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089946; x=1764694746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qY9wo9jaEowvBGqUAjQT6FCUqqOXzwqYWEwdmUcM3GY=;
        b=lUVg0UEa3UyBKFjMkRiT9e0TPBDw5lZgyM0h+eDyS02Da/oWiFaf+h5Tf1bnbCuOai
         hVIuBV/8xGGATyBEbP12ytKUQkMZsml6QF2brYTUHCjqR4q7NOm4n0cJeySwj/IyKb2j
         /xacxyNNspbG0Rrwvm7taTyJOTNYE2iXsdRk8aayASff5bd1UXf2Fb8JHAoc9RfeVmPp
         XNFbQZOIZzK7iOXGPffDcBYoc/KjnXX5iKNiND7TMFp5nGh2Vk9kOsTEWg7CV/cFi0BA
         HQLGoa8n5INjjGXMFVTaWqQvctxQnsoFPRKFoFXbR+0wjaJcI9at/KeDaYOpoYANCGiN
         F/PA==
X-Forwarded-Encrypted: i=1; AJvYcCWjMvPpD/EYwUaEjTjK9LGeKjD/HAsYyQ7yKYSbFOCqfake40gzLNrbSdoFcQv1v1KJXRx8gnAPC8YuveGO@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyj04/avhd2k/fihNmw4LTi3IuPnzcWRxSPXXmS6WBvWSbWKUH
	42ET0Bz2RfKZXp3K8di8gXFICuyU0JmzyZmvJl+NgmWqB/hghNJidfdE566fp4XE66w=
X-Gm-Gg: ASbGncubDb7Ibp9YvNXElOenO4u7Xe/3tXSTVlQ3V+U5fQADb4X+3yufInnS1hlEIwV
	2zO0/m2zwA5HXJvrFF20EVQxKQrdTh3iaHuo+TZ4VastJxWUEgSDC1wNrnqOrXUaiihpxm1cNGS
	HiKevYjS75wf19OlhjCWHpjZoSPlpkQSAylIpenmCzeube70qw20xR7LEV0PCfDYIsUAJpq5rAJ
	19bJi92pJHeRcTNFbJOThzgtMQmLkbYCW+/CUoakIjvSlbBD1NPwr0PYxRzRK7duBgcgbktHudv
	5G3MJ0Qd6goB1/Ii8j4mG6OytHyFMmaHJYEv7g3vNqj032cs1YEH2EXSnqdow/0RmumF7Wbjibm
	NYUMj8A6+AIiciq/lS24XyksL2Nc4Vz4vZO4MyXEKfTP2CRvbgOAn1QoBIpv6tWe9xED7+Pr619
	BWkNrYPNxaINd3YiLg8iuxsMBcdiZLZGU4JINsvQGsH8XxapPjL09zsMnLORskapdx
X-Google-Smtp-Source: AGHT+IFBNMs4cA9mfXfs+UfRF6OXAxVhmWhl0xvnB86ygK/E+UbH0gsrwEnsBLd9L25QsRfTdYCESw==
X-Received: by 2002:a05:690c:6806:b0:788:20a1:48c0 with SMTP id 00721157ae682-78ab6d6ce3dmr62989787b3.12.1764089945871;
        Tue, 25 Nov 2025 08:59:05 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a5518sm57284357b3.14.2025.11.25.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:59:05 -0800 (PST)
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
Subject: [PATCH v8 05/18] liveupdate: luo_core: add user interface
Date: Tue, 25 Nov 2025 11:58:35 -0500
Message-ID: <20251125165850.3389713-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
In-Reply-To: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
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
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 include/uapi/linux/liveupdate.h  |  64 +++++++++++
 kernel/liveupdate/luo_core.c     | 178 +++++++++++++++++++++++++++++++
 kernel/liveupdate/luo_internal.h |  21 ++++
 3 files changed, 263 insertions(+)

diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 40578ae19668..1183cf984b5f 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -46,4 +46,68 @@
 /* The maximum length of session name including null termination */
 #define LIVEUPDATE_SESSION_NAME_LENGTH 64
 
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
+ *		character.
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
+	__u8		name[LIVEUPDATE_SESSION_NAME_LENGTH];
+};
+
+#define LIVEUPDATE_IOCTL_RETRIEVE_SESSION \
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_RETRIEVE_SESSION)
+
 #endif /* _UAPI_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index a0f7788cd003..f7ecaf7740d1 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -41,7 +41,13 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/atomic.h>
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/init.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/luo.h>
 #include <linux/kobject.h>
@@ -246,12 +252,183 @@ bool liveupdate_enabled(void)
 	return luo_global.enabled;
 }
 
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
 struct luo_device_state {
 	struct miscdevice miscdev;
+	atomic_t in_use;
 };
 
+static int luo_ioctl_create_session(struct luo_ucmd *ucmd)
+{
+	struct liveupdate_ioctl_create_session *argp = ucmd->cmd;
+	struct file *file;
+	int err;
+
+	argp->fd = get_unused_fd_flags(O_CLOEXEC);
+	if (argp->fd < 0)
+		return argp->fd;
+
+	err = luo_session_create(argp->name, &file);
+	if (err)
+		goto err_put_fd;
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
+static int luo_ioctl_retrieve_session(struct luo_ucmd *ucmd)
+{
+	struct liveupdate_ioctl_retrieve_session *argp = ucmd->cmd;
+	struct file *file;
+	int err;
+
+	argp->fd = get_unused_fd_flags(O_CLOEXEC);
+	if (argp->fd < 0)
+		return argp->fd;
+
+	err = luo_session_retrieve(argp->name, &file);
+	if (err < 0)
+		goto err_put_fd;
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
+static int luo_open(struct inode *inodep, struct file *filep)
+{
+	struct luo_device_state *ldev = container_of(filep->private_data,
+						     struct luo_device_state,
+						     miscdev);
+
+	if (atomic_cmpxchg(&ldev->in_use, 0, 1))
+		return -EBUSY;
+
+	/* Always return -EIO to user if deserialization fail */
+	if (luo_session_deserialize()) {
+		atomic_set(&ldev->in_use, 0);
+		return -EIO;
+	}
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
+	int err;
+
+	nr = _IOC_NR(cmd);
+	if (nr < LIVEUPDATE_CMD_BASE ||
+	    (nr - LIVEUPDATE_CMD_BASE) >= ARRAY_SIZE(luo_ioctl_ops)) {
+		return -EINVAL;
+	}
+
+	ucmd.ubuffer = (void __user *)arg;
+	err = get_user(ucmd.user_size, (u32 __user *)ucmd.ubuffer);
+	if (err)
+		return err;
+
+	op = &luo_ioctl_ops[nr - LIVEUPDATE_CMD_BASE];
+	if (op->ioctl_num != cmd)
+		return -ENOIOCTLCMD;
+	if (ucmd.user_size < op->min_size)
+		return -EINVAL;
+
+	ucmd.cmd = &buf;
+	err = copy_struct_from_user(ucmd.cmd, op->size, ucmd.ubuffer,
+				    ucmd.user_size);
+	if (err)
+		return err;
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
@@ -260,6 +437,7 @@ static struct luo_device_state luo_dev = {
 		.name  = "liveupdate",
 		.fops  = &luo_fops,
 	},
+	.in_use = ATOMIC_INIT(0),
 };
 
 static int __init liveupdate_ioctl_init(void)
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 05ae91695ec6..1292ac47eef8 100644
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
 
 /*
  * Handles a deserialization failure: devices and memory is in unpredictable
-- 
2.52.0.460.gd25c4c69ec-goog


