Return-Path: <linux-fsdevel+bounces-56940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639A4B1D06F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 03:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45C507A19AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 01:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452A8235BE1;
	Thu,  7 Aug 2025 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="W8Rlbie9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B88227E95
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 01:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531115; cv=none; b=iotObNrVjac4w9V31ElghwcY7wE10GDkJtD1V3D3ZQRCavgedh/z4EGAUN5gZ37t5uX6mnkm8PVa1TNENG+7k565Um6pZEGE2cZjnqR97mgCenpUWBjmIaYCOUkWC/yTUZu0gy30NaZO2hZhP/NYwMcipDEAPeQoGdmryHRdwA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531115; c=relaxed/simple;
	bh=2bOvVYYu5v/Os2gHERdEl5mhadRivrwZwBWuB57XWlE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asx4P71vVsZTsqO5qVQ8bgCisJXAhdLwRuCh+6nKZK/6sd/HacEuxF2SplK098u2YNvmdHhDoWxkCJ4Z1USvK5USIuoryytj4vdJ1E5FRw2U+mJe6X5YS/DozwZNKch63zBihnMo22hXO1dmGtIDsWfqcsMzvLHvUmKWIb9iMAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=W8Rlbie9; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7076b55460eso6343966d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 18:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531111; x=1755135911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8Pc86FlLRtwRUzQGSvmjZcMELF/5Imt71S8yXJrUQE=;
        b=W8Rlbie9uRug5A5oQgGVho6uqXDlii0pjLF0N9rb3+XmiMWIyb70ZZF7owytjsX2EI
         z61DAYil7fB7uhM5w/By3Mt6rfeinWWEABmbcTxPGOFQC8igaDKaPlz1QTaMA8lTbCRB
         P1BSLQFmtHF+qo4OnosmnOZSjSSuwFWQNwvVxDq5Gabt2TfGrbkI9UzZUWKLUPuZtC4k
         6hfk6tOUyLoJOrhFKouD5LwzL7Pw/j0qqjnLPTXgDcopCNq9iZ3cGfZ6hgfufz4KLgUp
         jHjbERpedcNHg/Z5W8J7zGe2L2xFvrwHuQxftjzFuPfX/1IWxPCBBj7DoO2bBASBIGcK
         147Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531111; x=1755135911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8Pc86FlLRtwRUzQGSvmjZcMELF/5Imt71S8yXJrUQE=;
        b=T/gD7oQRLNsf83p1Aw3NzTMOufkkZMjJfMJDk0UCvhtxpD7K588fTqcSsWS79NeW+f
         hnZdDtgdsI10mLBnAF4pLIkg6Df5UG/OpyZWXPMZzh9DW1rnRBtoF+ozv+25zKI8cCiH
         hAOfeZ63uPB/BuxGfaQGJq7NjMbmSOlD5khWICmByaS3PsJIIG1z6EN2Bgazl0Atrso6
         gRLTlrSpHeDISrbDr6RBb0jEvIDEstHhkbMxm45sRav/9ZSvk1IWYUse3/Yo9NdqkJig
         6+nCRVQcWzx44DsdKdI1V0HvvWEqUCkIHqFbpzmefZBKl46l9i1vzjGCqGhDiasfJcFX
         BPQg==
X-Forwarded-Encrypted: i=1; AJvYcCXJXm//ckzXNEJxA0Sa/2MSPNzLlT5Q4efWuPR7vvvNlBOiRl3ax92JpULmy6jzTXQgzbaEKFEZWZrq1Yt9@vger.kernel.org
X-Gm-Message-State: AOJu0YzDZoT9MU27k7OB8QDJ54XfdYm1K/Uu9IepEwU85qPmErNLzbeq
	ZtmzViGpfrt2gyay2kj6/Fi/bn9KeRInYcOBOeARKVTAWAx1dvi4qsbSYDbQmrJ2L9s=
X-Gm-Gg: ASbGnculG8rk3a3gavf4/kZhilCRFQH8Jyx09H5Kp3+iUCSoFqmvR5VMDfMjsf+90/S
	80eDszZom90xw2YTgWWSIy/vhYtAhkTiWVhDh7kTdvZ36hCreW3VAwm1U7nlG3O2+s/DbmvLsFR
	WF6/etek/BqV9qYLXws8FjHX6IlxslEDiybxGASI4C9C3yygtJDmc4KXdjKhswscRATxWoo8kVF
	XKEmBlmHQ33Zb8lrwTL83KmYtkdwDgzSOBHs5BPMlL+pl9qas4AUm2ku9KQzVFT1M4iDIusN7dP
	MOahIXsee/Z6ZTn0KqlrRcJa4gCeSwalh7JuQQT5yRrSYTDWad7KtqiPXkzO8pCTeKBY5DDO7kj
	bUbn/cX1ejPl66JFY6Bb3f2zf2hRD1Oq3wov9R0s7SXnxQx70kutk/noEd34AjXA0nFDoaK4yuI
	EJ3E3oHS4gUZgq
X-Google-Smtp-Source: AGHT+IEhA0QesCBs9Rro7SuewSiUGU8rDS7yvn1okysx9FgcI1M1Z0UadP+fhEkBUH9Ofl09bYq+0A==
X-Received: by 2002:a05:6214:4013:b0:707:5986:8963 with SMTP id 6a1803df08f44-7098a801aeemr17644456d6.33.1754531110843;
        Wed, 06 Aug 2025 18:45:10 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:10 -0700 (PDT)
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
Subject: [PATCH v3 16/30] liveupdate: luo_ioctl: add userpsace interface
Date: Thu,  7 Aug 2025 01:44:22 +0000
Message-ID: <20250807014442.3829950-17-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
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

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/uapi/linux/liveupdate.h | 243 ++++++++++++++++++++++++++++++++
 kernel/liveupdate/luo_ioctl.c   | 200 ++++++++++++++++++++++++++
 2 files changed, 443 insertions(+)

diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 3cb09b2c4353..37ec5656443b 100644
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
+ *  - ENOENT: An ID or IOVA provided does not exist.
+ *  - ENOMEM: Out of memory.
+ *  - EOVERFLOW: Mathematics overflowed.
+ *
+ * As well as additional errnos, within specific ioctls.
+ */
+
 /**
  * enum liveupdate_state - Defines the possible states of the live update
  * orchestrator.
@@ -91,4 +117,221 @@ enum liveupdate_event {
 	LIVEUPDATE_CANCEL = 3,
 };
 
+/* The ioctl type, documented in ioctl-number.rst */
+#define LIVEUPDATE_IOCTL_TYPE		0xBA
+
+/* The ioctl commands */
+enum {
+	LIVEUPDATE_CMD_BASE = 0x00,
+	LIVEUPDATE_CMD_FD_PRESERVE = LIVEUPDATE_CMD_BASE,
+	LIVEUPDATE_CMD_FD_UNPRESERVE = 0x01,
+	LIVEUPDATE_CMD_FD_RESTORE = 0x02,
+	LIVEUPDATE_CMD_GET_STATE = 0x03,
+	LIVEUPDATE_CMD_SET_EVENT = 0x04,
+};
+
+/**
+ * struct liveupdate_ioctl_fd_preserve - ioctl(LIVEUPDATE_IOCTL_FD_PRESERVE)
+ * @size:  Input; sizeof(struct liveupdate_ioctl_fd_preserve)
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
+ * the subsequent %LIVEUPDATE_IOCTL_FD_RESTORE call after the live update.
+ *
+ * Return: 0 on success (validation passed, preservation initiated), negative
+ * error code on failure (e.g., unsupported FD type, dependency issue,
+ * validation failed).
+ */
+struct liveupdate_ioctl_fd_preserve {
+	__u32		size;
+	__s32		fd;
+	__aligned_u64	token;
+};
+
+#define LIVEUPDATE_IOCTL_FD_PRESERVE					\
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_FD_PRESERVE)
+
+/**
+ * struct liveupdate_ioctl_fd_unpreserve - ioctl(LIVEUPDATE_IOCTL_FD_UNPRESERVE)
+ * @size:  Input; sizeof(struct liveupdate_ioctl_fd_unpreserve)
+ * @token: Input; A token for resource to be unpreserved.
+ *
+ * Remove a file descriptor from the preservation list.
+ *
+ * Allows user space to explicitly remove a file descriptor from the set of
+ * items marked as potentially preservable. User space provides a @token that
+ * was previously used by a successful %LIVEUPDATE_IOCTL_FD_PRESERVE call
+ * (potentially from a prior, possibly cancelled, live update attempt). The
+ * kernel reads the token value from the provided user-space address.
+ *
+ * On success, the kernel removes the corresponding entry (identified by the
+ * token value read from the user pointer) from its internal preservation list.
+ * The provided @token (representing the now-removed entry) becomes invalid
+ * after this call.
+ *
+ * Return: 0 on success, negative error code on failure (e.g., -EBUSY or -EINVAL
+ * if bad address provided, invalid token value read, token not found).
+ */
+struct liveupdate_ioctl_fd_unpreserve {
+	__u32		size;
+	__aligned_u64	token;
+};
+
+#define LIVEUPDATE_IOCTL_FD_UNPRESERVE					\
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_FD_UNPRESERVE)
+
+/**
+ * struct liveupdate_ioctl_fd_restore - ioctl(LIVEUPDATE_IOCTL_FD_RESTORE)
+ * @size:  Input; sizeof(struct liveupdate_ioctl_fd_restore)
+ * @fd:    Output; The new file descriptor representing the fully restored
+ *         kernel resource.
+ * @token: Input; An opaque, token that was used to preserve the resource.
+ *
+ * Restore a previously preserved file descriptor.
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
+struct liveupdate_ioctl_fd_restore {
+	__u32		size;
+	__s32		fd;
+	__aligned_u64	token;
+};
+
+#define LIVEUPDATE_IOCTL_FD_RESTORE					\
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_FD_RESTORE)
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
+ *                        of potentially preservable resources. Consequently,
+ *                        preservation tokens previously used by successful
+ *                        %LIVEUPDATE_IOCTL_FD_PRESERVE or calls **remain
+ *                        valid** as identifiers for those potentially
+ *                        preservable resources. However, since the system state
+ *                        returns towards %LIVEUPDATE_STATE_NORMAL, user space
+ *                        must initiate a new live update sequence (starting
+ *                        with %LIVEUPDATE_PREPARE) to proceed with an update
+ *                        using these (or other) tokens.
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
 #endif /* _UAPI_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_ioctl.c b/kernel/liveupdate/luo_ioctl.c
index 3df1ec9fbe57..6f61569c94e8 100644
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
@@ -17,8 +36,189 @@
 #include <uapi/linux/liveupdate.h>
 #include "luo_internal.h"
 
+static atomic_t luo_device_in_use = ATOMIC_INIT(0);
+
+struct luo_ucmd {
+	void __user *ubuffer;
+	u32 user_size;
+	void *cmd;
+};
+
+static int luo_ioctl_fd_preserve(struct luo_ucmd *ucmd)
+{
+	struct liveupdate_ioctl_fd_preserve *argp = ucmd->cmd;
+	int ret;
+
+	ret = luo_register_file(argp->token, argp->fd);
+	if (!ret)
+		return ret;
+
+	if (copy_to_user(ucmd->ubuffer, argp, ucmd->user_size))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int luo_ioctl_fd_unpreserve(struct luo_ucmd *ucmd)
+{
+	struct liveupdate_ioctl_fd_unpreserve *argp = ucmd->cmd;
+
+	return luo_unregister_file(argp->token);
+}
+
+static int luo_ioctl_fd_restore(struct luo_ucmd *ucmd)
+{
+	struct liveupdate_ioctl_fd_restore *argp = ucmd->cmd;
+	struct file *file;
+	int ret;
+
+	argp->fd = get_unused_fd_flags(O_CLOEXEC);
+	if (argp->fd < 0) {
+		pr_err("Failed to allocate new fd: %d\n", argp->fd);
+		return argp->fd;
+	}
+
+	ret = luo_retrieve_file(argp->token, &file);
+	if (ret < 0) {
+		put_unused_fd(argp->fd);
+
+		return ret;
+	}
+
+	fd_install(argp->fd, file);
+
+	if (copy_to_user(ucmd->ubuffer, argp, ucmd->user_size))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int luo_ioctl_get_state(struct luo_ucmd *ucmd)
+{
+	struct liveupdate_ioctl_get_state *argp = ucmd->cmd;
+
+	argp->state = liveupdate_get_state();
+
+	if (copy_to_user(ucmd->ubuffer, argp, ucmd->user_size))
+		return -EFAULT;
+
+	return 0;
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
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int luo_open(struct inode *inodep, struct file *filep)
+{
+	if (atomic_cmpxchg(&luo_device_in_use, 0, 1))
+		return -EBUSY;
+
+	return 0;
+}
+
+static int luo_release(struct inode *inodep, struct file *filep)
+{
+	atomic_set(&luo_device_in_use, 0);
+
+	return 0;
+}
+
+union ucmd_buffer {
+	struct liveupdate_ioctl_fd_preserve	preserve;
+	struct liveupdate_ioctl_fd_unpreserve	unpreserve;
+	struct liveupdate_ioctl_fd_restore	restore;
+	struct liveupdate_ioctl_get_state	state;
+	struct liveupdate_ioctl_set_event	event;
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
+	IOCTL_OP(LIVEUPDATE_IOCTL_FD_PRESERVE, luo_ioctl_fd_preserve,
+		 struct liveupdate_ioctl_fd_preserve, token),
+	IOCTL_OP(LIVEUPDATE_IOCTL_FD_UNPRESERVE, luo_ioctl_fd_unpreserve,
+		 struct liveupdate_ioctl_fd_unpreserve, token),
+	IOCTL_OP(LIVEUPDATE_IOCTL_FD_RESTORE, luo_ioctl_fd_restore,
+		 struct liveupdate_ioctl_fd_restore, token),
+	IOCTL_OP(LIVEUPDATE_IOCTL_GET_STATE, luo_ioctl_get_state,
+		 struct liveupdate_ioctl_get_state, state),
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
 static const struct file_operations fops = {
 	.owner		= THIS_MODULE,
+	.open		= luo_open,
+	.release	= luo_release,
+	.unlocked_ioctl	= luo_ioctl,
 };
 
 static struct miscdevice liveupdate_miscdev = {
-- 
2.50.1.565.gc32cd1483b-goog


