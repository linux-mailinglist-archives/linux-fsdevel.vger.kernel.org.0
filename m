Return-Path: <linux-fsdevel+bounces-62968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A745FBA7B23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 03:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF19B7AAF9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 01:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67411F3FEC;
	Mon, 29 Sep 2025 01:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FUvUjTul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12CB19EED3
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107873; cv=none; b=lixej3tze+IuSyvhSiVy+Pf12nxkjbWk+4iOXtwaA2/vKcOv1giRlRiQeGYRDHn2RGpGy36clWt8WgoszkFGQaw7Z5tK1tx/ZdoEaKC4VlWef+ux1HOIexOj2j6E1vIpBaWA5E2aLDCTJYSJ+UGe3pyqWrB5pwRfPMMc7FvlYnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107873; c=relaxed/simple;
	bh=Y7nqGbM4CxQL86kixsX259srVrd5urtxz+FvNAryO8g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBaePG8CkyXBQDXpMaDq+yGnMZDa20IsPImO7H3JyY+jpbShNArWUzdihhLN9D0j2l6C8A38Tg98H0GFc+SagtrBXt5UU8sOlHtbGkL6V/imhHxC8yuxy1CzJEA80h4h0UD8kq7908N3+DdasQ6JLle+6/KPPVAR4kPEOFi3sIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=FUvUjTul; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4df4d23fb59so16774011cf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 18:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107870; x=1759712670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zcSgDH9VLG2SUi6g3+OVDiDVEtFrrRUlaRrL6JR5uy0=;
        b=FUvUjTulAcdL0Hy8nICHHKSiz4BRUYwCLvUG/OMnwizHU3hoOuUCwkFFK5kO5eFjtH
         WN61fs5sMjCB53dKMEEmdviCxsa1QIqH20uoxvDJgRv6R12h+RyjmYBYxRg9M/7L8TMh
         HkP3nK7MZdlZqoW27b5GfnzBLpcMDypmFiByGIbJriynIkEKNZ6kpO7nir/2DcaUuC+m
         iD9Eivck40OG/ruaBuaUNyym9Aebljh9NoDsQCq4v2Ks3/ADahe65xDmLno6h8AODh2v
         o1/PZh4G3/n/0wSi9XWVq3wkP+XWrYs2IxvzviHlkp0aOjs/FB2hjAxRYtcXaTWSWfxm
         FUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107870; x=1759712670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcSgDH9VLG2SUi6g3+OVDiDVEtFrrRUlaRrL6JR5uy0=;
        b=a+vbZXQkeevA57dKAg9EyFfcjGVTdZ/aFHnh7mecZNCtMERc326D1vr6wEUixpHkiL
         /BsiRh1LrXKRGotzI6zSIwN1pbD4lZnq6sTLUYyxD50UZrY9dXZCi2obYkJiFSGBmfCD
         ScJwMNiZI2REAKnEC1lYWTimemoJh+foFvqItHBnO50bny4sosG2O5mRObST6VIWFvNq
         R+G2UOPisdK4yRjl+msimoYJCa6xxyIAJuIssFfX7bRN0UGEbcwn1giE2JgT26A0NR7t
         zHGDpOrRIq9TVKjQs+G9CC4Jdz2W9rXi9D5Cr86qwvKu6+4Ca5jkH00BfBduDrMOlyYz
         Vyvg==
X-Forwarded-Encrypted: i=1; AJvYcCVlS4EabgG55CEHN1z6WwOZNdZz+EnhBOufxUDy7OFRMk5GuGcQCOmQIC1gPOT2JMWPREeYhRXpIFh+1pz/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf9uRrh8uTjm+LH8UT+Lw+zfuxDr4HtK/H6MfOBENXSSUG/DLS
	98nXeZU8QSABhpidhkQEvYnxvaMokdCvRSm7uITptSJZkbJaugv0NADoaYU4dffQO4o=
X-Gm-Gg: ASbGncsMefCMjkNFdKbp9tuixBYbLie8zKMdDUKhCMU4mlWNIOs1UcigwNbkzuqh27F
	B90LLbUNf0ARghGkgJT3g8Jn/rUi9yAoEXJUFTjfO4zQ6doW74UmshCSNTLrt2lMu5aOaxkqn+3
	73oyN0ABR1DKGSPwEZx2vWb6aGW9xaK/2gqdi530ya0e+6dJgUQhQ/uu9DPz8BVrtXHCSMHthQJ
	1Whljv6ziKy/MgyooaBp3wro+BoDxgeYhPLt093TjOur1GeYkuiAk8dn3NPoCd7aFGLvrYov64D
	aQB1v6SAsDAGEOz/8XMrcVWauzjfu8Vqrog+8LlEbNAdpWfSLntUihSc8vlc+cwxl9x3XDdosXT
	TwLtuazUWkYhlTZJ15DlW0hYTfjqmur3uwsp5qFicBS9gJYFi/d7jVKipscX/1TDA48rVe7nZbk
	b1tt/O9gfE6jo/fKlIig==
X-Google-Smtp-Source: AGHT+IGF0S9IclOBJkoE08yEa53PAxQoR+uRPkimKbM/oD4UzxexMGmwGzEkKHwSpei9vqN/FCsqQA==
X-Received: by 2002:ac8:5f53:0:b0:4b9:d7c2:756a with SMTP id d75a77b69052e-4da4cd49c0cmr194938831cf.77.1759107869557;
        Sun, 28 Sep 2025 18:04:29 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:04:28 -0700 (PDT)
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
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 12/30] liveupdate: luo_ioctl: add user interface
Date: Mon, 29 Sep 2025 01:03:03 +0000
Message-ID: <20250929010321.3462457-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
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

LIVEUPDATE_IOCTL_GET_STATE
Allows userspace to query the current state of the LUO state machine
(e.g., NORMAL, PREPARED, UPDATED).

LIVEUPDATE_IOCTL_SET_EVENT
Enables userspace to drive the LUO state machine by sending global
events. This includes:

LIVEUPDATE_PREPARE
To begin the state-saving process.

LIVEUPDATE_FINISH
To signal completion of restoration in the new kernel.

LIVEUPDATE_CANCEL
To abort a prepared update.

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
 include/uapi/linux/liveupdate.h  | 199 ++++++++++++++++++++++++++++++
 kernel/liveupdate/luo_internal.h |  20 +++
 kernel/liveupdate/luo_ioctl.c    | 201 +++++++++++++++++++++++++++++++
 3 files changed, 420 insertions(+)

diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index e8c0c210a790..2e38ef3094aa 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -14,6 +14,32 @@
 #include <linux/ioctl.h>
 #include <linux/types.h>
 
+/**
+ * DOC: General ioctl format
+ *
+ * The ioctl interface follows a general format to allow for extensibility. Each
+ * ioctl is passed in a structure pointer as the argument providing the size of
+ * the structure in the first u32. The kernel checks that any structure space
+ * beyond what it understands is 0. This allows userspace to use the backward
+ * compatible portion while consistently using the newer, larger, structures.
+ *
+ * ioctls use a standard meaning for common errnos:
+ *
+ *  - ENOTTY: The IOCTL number itself is not supported at all
+ *  - E2BIG: The IOCTL number is supported, but the provided structure has
+ *    non-zero in a part the kernel does not understand.
+ *  - EOPNOTSUPP: The IOCTL number is supported, and the structure is
+ *    understood, however a known field has a value the kernel does not
+ *    understand or support.
+ *  - EINVAL: Everything about the IOCTL was understood, but a field is not
+ *    correct.
+ *  - ENOENT: A provided token does not exist.
+ *  - ENOMEM: Out of memory.
+ *  - EOVERFLOW: Mathematics overflowed.
+ *
+ * As well as additional errnos, within specific ioctls.
+ */
+
 /**
  * enum liveupdate_state - Defines the possible states of the live update
  * orchestrator.
@@ -94,4 +120,177 @@ enum liveupdate_event {
 /* The maximum length of session name including null termination */
 #define LIVEUPDATE_SESSION_NAME_LENGTH 56
 
+/* The ioctl type, documented in ioctl-number.rst */
+#define LIVEUPDATE_IOCTL_TYPE		0xBA
+
+/* The /dev/liveupdate ioctl commands */
+enum {
+	LIVEUPDATE_CMD_BASE = 0x00,
+	LIVEUPDATE_CMD_GET_STATE = LIVEUPDATE_CMD_BASE,
+	LIVEUPDATE_CMD_SET_EVENT = 0x01,
+	LIVEUPDATE_CMD_CREATE_SESSION = 0x02,
+	LIVEUPDATE_CMD_RETRIEVE_SESSION = 0x03,
+};
+
+/**
+ * struct liveupdate_ioctl_get_state - ioctl(LIVEUPDATE_IOCTL_GET_STATE)
+ * @size:  Input; sizeof(struct liveupdate_ioctl_get_state)
+ * @state: Output; The current live update state.
+ *
+ * Query the current state of the live update orchestrator.
+ *
+ * The kernel fills the @state with the current
+ * state of the live update subsystem. Possible states are:
+ *
+ * - %LIVEUPDATE_STATE_NORMAL:   Default state; no live update operation is
+ *                               currently in progress.
+ * - %LIVEUPDATE_STATE_PREPARED: The preparation phase (triggered by
+ *                               %LIVEUPDATE_PREPARE) has completed
+ *                               successfully. The system is ready for the
+ *                               reboot transition. Note that some
+ *                               device operations (e.g., unbinding, new DMA
+ *                               mappings) might be restricted in this state.
+ * - %LIVEUPDATE_STATE_UPDATED:  The system has successfully rebooted into the
+ *                               new kernel via live update. It is now running
+ *                               the new kernel code and is awaiting the
+ *                               completion signal from user space via
+ *                               %LIVEUPDATE_FINISH after restoration tasks are
+ *                               done.
+ *
+ * See the definition of &enum liveupdate_state for more details on each state.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+struct liveupdate_ioctl_get_state {
+	__u32	size;
+	__u32	state;
+};
+
+#define LIVEUPDATE_IOCTL_GET_STATE					\
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_GET_STATE)
+
+/**
+ * struct liveupdate_ioctl_set_event - ioctl(LIVEUPDATE_IOCTL_SET_EVENT)
+ * @size:  Input; sizeof(struct liveupdate_ioctl_set_event)
+ * @event: Input; The live update event.
+ *
+ * Notify live update orchestrator about global event, that causes a state
+ * transition.
+ *
+ * Event, can be one of the following:
+ *
+ * - %LIVEUPDATE_PREPARE: Initiates the live update preparation phase. This
+ *                        typically triggers the saving process for items marked
+ *                        via the PRESERVE ioctls. This typically occurs
+ *                        *before* the "blackout window", while user
+ *                        applications (e.g., VMs) may still be running. Kernel
+ *                        subsystems receiving the %LIVEUPDATE_PREPARE event
+ *                        should serialize necessary state. This command does
+ *                        not transfer data.
+ * - %LIVEUPDATE_FINISH:  Signal restoration completion and triggercleanup.
+ *
+ *                        Signals that user space has completed all necessary
+ *                        restoration actions in the new kernel (after a live
+ *                        update reboot). Calling this ioctl triggers the
+ *                        cleanup phase: any resources that were successfully
+ *                        preserved but were *not* subsequently restored
+ *                        (reclaimed) via the RESTORE ioctls will have their
+ *                        preserved state discarded and associated kernel
+ *                        resources released. Involved devices may be reset. All
+ *                        desired restorations *must* be completed *before*
+ *                        this. Kernel callbacks for the %LIVEUPDATE_FINISH
+ *                        event must not fail. Successfully completing this
+ *                        phase transitions the system state from
+ *                        %LIVEUPDATE_STATE_UPDATED back to
+ *                        %LIVEUPDATE_STATE_NORMAL. This command does
+ *                        not transfer data.
+ * - %LIVEUPDATE_CANCEL:  Cancel the live update preparation phase.
+ *
+ *                        Notifies the live update subsystem to abort the
+ *                        preparation sequence potentially initiated by
+ *                        %LIVEUPDATE_PREPARE event.
+ *
+ *                        When triggered, subsystems receiving the
+ *                        %LIVEUPDATE_CANCEL event should revert any state
+ *                        changes or actions taken specifically for the aborted
+ *                        prepare phase (e.g., discard partially serialized
+ *                        state). The kernel releases resources allocated
+ *                        specifically for this *aborted preparation attempt*.
+ *
+ *                        This operation cancels the current *attempt* to
+ *                        prepare for a live update but does **not** remove
+ *                        previously validated items from the internal list
+ *                        of potentially preservable resources.
+ *
+ *                        This command does not transfer data. Kernel callbacks
+ *                        for the %LIVEUPDATE_CANCEL event must not fail.
+ *
+ * See the definition of &enum liveupdate_event for more details on each state.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+struct liveupdate_ioctl_set_event {
+	__u32	size;
+	__u32	event;
+};
+
+#define LIVEUPDATE_IOCTL_SET_EVENT					\
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SET_EVENT)
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
+ * LIVEUPDATE_SESSION_RESTORE_FD.
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
 #endif /* _UAPI_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 9223f71844ca..a14e0b685ccb 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -17,6 +17,26 @@
  */
 #define luo_restore_fail(__fmt, ...) panic(__fmt, ##__VA_ARGS__)
 
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
+
 int luo_cancel(void);
 int luo_prepare(void);
 int luo_freeze(void);
diff --git a/kernel/liveupdate/luo_ioctl.c b/kernel/liveupdate/luo_ioctl.c
index fc2afb450ad5..01ccb8a6d3f4 100644
--- a/kernel/liveupdate/luo_ioctl.c
+++ b/kernel/liveupdate/luo_ioctl.c
@@ -5,6 +5,25 @@
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
 #include <linux/errno.h>
 #include <linux/file.h>
 #include <linux/fs.h>
@@ -19,10 +38,191 @@
 
 struct luo_device_state {
 	struct miscdevice miscdev;
+	atomic_t in_use;
+};
+
+static int luo_ioctl_get_state(struct luo_ucmd *ucmd)
+{
+	struct liveupdate_ioctl_get_state *argp = ucmd->cmd;
+
+	argp->state = liveupdate_get_state();
+
+	return luo_ucmd_respond(ucmd, sizeof(*argp));
+}
+
+static int luo_ioctl_set_event(struct luo_ucmd *ucmd)
+{
+	struct liveupdate_ioctl_set_event *argp = ucmd->cmd;
+	int ret;
+
+	switch (argp->event) {
+	case LIVEUPDATE_PREPARE:
+		ret = luo_prepare();
+		break;
+	case LIVEUPDATE_FINISH:
+		ret = luo_finish();
+		break;
+	case LIVEUPDATE_CANCEL:
+		ret = luo_cancel();
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
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
+	struct liveupdate_ioctl_get_state state;
+	struct liveupdate_ioctl_retrieve_session retrieve;
+	struct liveupdate_ioctl_set_event event;
 };
 
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
+	IOCTL_OP(LIVEUPDATE_IOCTL_GET_STATE, luo_ioctl_get_state,
+		 struct liveupdate_ioctl_get_state, state),
+	IOCTL_OP(LIVEUPDATE_IOCTL_RETRIEVE_SESSION, luo_ioctl_retrieve_session,
+		 struct liveupdate_ioctl_retrieve_session, name),
+	IOCTL_OP(LIVEUPDATE_IOCTL_SET_EVENT, luo_ioctl_set_event,
+		 struct liveupdate_ioctl_set_event, event),
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
@@ -31,6 +231,7 @@ static struct luo_device_state luo_dev = {
 		.name  = "liveupdate",
 		.fops  = &luo_fops,
 	},
+	.in_use = ATOMIC_INIT(0),
 };
 
 static int __init liveupdate_init(void)
-- 
2.51.0.536.g15c5d4f767-goog


