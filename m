Return-Path: <linux-fsdevel+bounces-43024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5386A4D0AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 02:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 727877A7CA2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 01:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479D77E0E8;
	Tue,  4 Mar 2025 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="IXnkfQQM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pFhLA5Cb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B218338DC8;
	Tue,  4 Mar 2025 01:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051301; cv=none; b=AUnFiQDO7FwcXjlkd1Eoms/ZOHRZY1UT+jLMRUGdkto6B7Mm1LisemFA2ywV6NvK45/Bk0Zun62ID4RzIkkyoZ9IaiRfPlImE3INJwWFIurdZQB+zc4ZVavT6rPRElbmtkSQqwK8KyVFrSkvFg90URwEM8t7RBg1Yh6PHSW03/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051301; c=relaxed/simple;
	bh=1Mn2+uQQ2KRXMmbUb9a3CWJIPCf1eEI2cF0Pvk/Y3eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkFJF5WEarnz+2O8XSM4k/d0r8XEJIxkfuDbqtCkkVwhlPz0qEdx4TKPRmCmFpAP3Zn4PjC6rXGfifNpIvZTrq8kgLa988kYwTT568vymqVHyVHytveoJoI8oTDDRK/hWJ27OQm1MVoABzAcDl04E36VOAc1s5lSgHD7w1gzcy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=IXnkfQQM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pFhLA5Cb; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 9CEB11D4151B;
	Mon,  3 Mar 2025 20:21:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 03 Mar 2025 20:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1741051298; x=
	1741054898; bh=aspxL3lmWFQP1jsGikwXAoHhhRl7ll7aEVe5a3LCQYo=; b=I
	XnkfQQMq2hZaBkM/zmMiVsA+2oGcvRXuDoCmjOgh7hQdq4mO+53DgjINU1JgOpWU
	DboPg4AI7OP+1tdr7BqmzUyzktR8uTiTjgqXfJxrqcnIiGEjipLNn4cj6K3Jb7dN
	4h0e75f+wc/uxhH5nFZgSrSFKYdE1eOAVL2nX3sw3alfSil6+HvLqyC0e/yMWxwI
	RaNKwkoSmKCdUj+kG6GIU8+x8bjCCwlf5+f4xaffDgmu6WiDexQRqtHQYn86+S5k
	uB8wWI3c5D6VNc1fkesQBuCS7LTq1acYYzfDM8Sb3caVxbTNfdFve+fCGMk9GlU9
	evRfHHl2PZg5nPIMFXnrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741051298; x=1741054898; bh=a
	spxL3lmWFQP1jsGikwXAoHhhRl7ll7aEVe5a3LCQYo=; b=pFhLA5CbGUe6BMznF
	5818kzTPuu0/yXvqYKmSApQk2fq32WlQUl/GBEzcebMUWW5ajqi65knYfTK8PZGw
	mUmABJ6jZ/mWu07xmqbS482iEzTbN+DluTEdXnGNh3DFqNi9HOuXTmld1+7jo6vp
	rTwfVwy2JnGh+6qk81Y+vIFqT3jHO4KnSWqTq4iD5KCk0GHzREiT5iLe1ocEecp2
	QZoFgJMoztG/BYnLp19X/bYH0HkWIbUq5WDpvguTTjg4sdQvMfm1JWStGBNCSLAR
	3LV2bdz4w/XeNG+BuhwT1Vol04dcumHjaeY0/mQl3uGpBsmD8aNFb9M4rHbprWnD
	H1iug==
X-ME-Sender: <xms:olXGZ2S_uL6UKQ1N4fM7oImIZVjBvvqdt31zzfPnHg0jjELAFNviDA>
    <xme:olXGZ7xxw6B8J0C4K6-9iZT0NiEntnQ2onkAKGSbTDwNIyN2f0n6ZTq_CuyqNIR6c
    cjKrjmMZ8RaEkQoVy8>
X-ME-Received: <xmr:olXGZz2tFuRSUM97ykAm0CNRN_Ajs1QO1_iu_YydcKFFP0rF_iojGXGiyRx2Xy14nQjgpKCfZVzcvHbQlgAnlx2jT5ldX-1JIvf5PPGUx5lk5Qjxy8-TExM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeuuddthefhhefhvdejteevvddvteefffegteetueegueel
    jeefueekjeetieeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtph
    htthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhgrtghksehs
    uhhsvgdrtgiipdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhope
    hrvghpnhhophesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggv
    vhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthigthhhosehthi
    gthhhordhpihiiiigr
X-ME-Proxy: <xmx:olXGZyD9a1we90RLSmRMebTGbx6XkjI-K2hSHJNyRWiPSAFr57QRPQ>
    <xmx:olXGZ_hKKbWj5v189lpERMcYcHLbJAYNHNcgod_JHQzvXDBDmFMSUA>
    <xmx:olXGZ-pXdunRnjLY36yVWaKObehVqX8PCPHGGpTr7HLXZyVSYmQbTw>
    <xmx:olXGZyg8tSRGP4T7S0xj9Fnfq3UHU3M6s31gOSEqT05GLqN9yesMfQ>
    <xmx:olXGZ6XFJMOtFlC5Cl2FfgRZkjc_bLPvnMhF1NZy0FRYg2l8j0-9sRQ0>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 20:21:36 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>
Subject: [RFC PATCH 8/9] Implement fops for supervisor-fd
Date: Tue,  4 Mar 2025 01:13:04 +0000
Message-ID: <a16f84a0869867c94c93ed68a17a25549341b302.1741047969.git.m@maowtm.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741047969.git.m@maowtm.org>
References: <cover.1741047969.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch exposes the events to user-space via read and receives response
back via writes to the fd.

We will set aside the problem of how to handle situations where the
supervisor don't actually have the permission to open a fd for the path
for now (and just deny the event on any error), but note that landlock
does not restrict opening of O_PATH fds, and so at least a supervisor
supervising itself is not completely out of the question (but the
usefulness of this is perhaps questionable).

NOTE: despite this patch having a new uapi, I'm still very open to e.g.
re-using fanotify stuff instead (if that makes sense in the end). This is
just a PoC.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/syscalls.c | 349 ++++++++++++++++++++++++++++++++++-
 1 file changed, 346 insertions(+), 3 deletions(-)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 3018e3663173..7d191c946ecc 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -203,6 +203,348 @@ static int fop_supervisor_release(struct inode *const inode,
 	return 0;
 }
 
+/**
+ * Lifetime of return value is tied to p.
+ */
+static struct path p_parent(struct path p)
+{
+	struct path parent_path = { .mnt = p.mnt,
+				    .dentry = p.dentry->d_parent };
+	return parent_path;
+}
+
+/**
+ * Open an O_PATH fd of a target file for passing to the
+ * supervisor.
+ */
+static int supervise_fs_fd_open_install(struct path *path)
+{
+	int fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		pr_warn("get_unused_fd_flags: %pe\n", ERR_PTR(fd));
+		return fd;
+	}
+	struct file *f = dentry_open(path, O_PATH | O_CLOEXEC, current_cred());
+	if (IS_ERR(f)) {
+		pr_warn("Failed to open fd in supervisor: %ld\n", PTR_ERR(f));
+		put_unused_fd(fd);
+		return PTR_ERR(f);
+	}
+	fd_install(fd, f);
+	return fd;
+}
+
+static ssize_t fop_supervisor_read(struct file *const filp,
+				   char __user *const buf, const size_t size,
+				   loff_t *const ppos)
+{
+	struct landlock_supervisor *supervisor = filp->private_data;
+	struct landlock_supervise_event_kernel *event = NULL;
+	bool found = false;
+	struct landlock_supervise_event *user_event = NULL;
+	size_t destname_size = 0, event_size = 0;
+	const size_t dest_offset =
+		offsetof(struct landlock_supervise_event, destname);
+	const char *destname = NULL; /* Lifetime tied to event */
+	int fd1 = -1, fd2 = -1, ret = 0;
+	bool nonblock = filp->f_flags & O_NONBLOCK;
+	struct path parent_path;
+
+	if (WARN_ON(!supervisor))
+		return -ENODEV;
+
+	if (size < sizeof(struct landlock_supervise_event))
+		return -EINVAL;
+
+retry:
+	spin_lock(&supervisor->lock);
+
+	/*
+	 * Find the first new event (but really, all events in this
+	 * list should be new)
+	 */
+	list_for_each_entry(event, &supervisor->event_queue, node) {
+		if (event->state == LANDLOCK_SUPERVISE_EVENT_NEW) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		spin_unlock(&supervisor->lock);
+		if (nonblock) {
+			return -EAGAIN;
+		}
+
+		/*
+		 * Wait for events to be added to the queue.
+		 * Not sure if we can call list_empty() without the lock
+		 * here, hence true.
+		 */
+		ret = wait_event_interruptible(supervisor->poll_event_wq, true);
+		if (ret)
+			return ret;
+
+		goto retry;
+	}
+
+	/*
+	 * We take the event out of the list and let other readers
+	 * carry on.  We take over the event's ownership from the
+	 * list (hence no get/put).
+	 */
+	list_del(&event->node);
+	spin_unlock(&supervisor->lock);
+
+	if (event->type == LANDLOCK_SUPERVISE_EVENT_TYPE_FS_ACCESS) {
+		struct dentry *dest_dentry;
+
+		if (WARN_ON(event->target_1_is_new && event->target_2_is_new)) {
+			ret = -EAGAIN;
+			goto fail_deny;
+		}
+
+		/*
+		 * Get destname out here so that we know the event's size.
+		 * We separate the lifetime of destname away from the
+		 * kernel event so we can move the copy outside of lock.
+		 */
+		if (event->target_1.dentry && event->target_1_is_new) {
+			dest_dentry = event->target_1.dentry;
+			destname = (char *)dest_dentry->d_name.name;
+			destname_size = dest_dentry->d_name.len + 1;
+		} else if (event->target_2.dentry && event->target_2_is_new) {
+			dest_dentry = event->target_2.dentry;
+			destname = (char *)dest_dentry->d_name.name;
+			destname_size = dest_dentry->d_name.len + 1;
+		}
+	}
+
+	event_size = ALIGN(dest_offset + destname_size,
+			   __alignof__(typeof(*user_event)));
+
+	if (event_size > size) {
+		ret = -EINVAL;
+		goto fail_readd_event;
+	}
+
+	/* We will copy the destname directly to user buffer */
+	user_event =
+		kzalloc(sizeof(struct landlock_supervise_event), GFP_KERNEL);
+	if (!user_event)
+		return -ENOMEM;
+
+	user_event->hdr.type = event->type;
+	user_event->hdr.length = event_size;
+	user_event->hdr.cookie = event->event_id;
+	user_event->access_request = event->access_request;
+	user_event->accessor = pid_vnr(event->accessor);
+
+	/* Set up the appropriate file descriptors based on the type */
+	if (event->type == LANDLOCK_SUPERVISE_EVENT_TYPE_FS_ACCESS) {
+		if (event->target_1.dentry) {
+			if (event->target_1_is_new) {
+				parent_path = p_parent(event->target_1);
+				fd1 = supervise_fs_fd_open_install(
+					&parent_path);
+				if (fd1 < 0) {
+					ret = fd1;
+					goto fail_deny_or_readd;
+				}
+			} else {
+				fd1 = supervise_fs_fd_open_install(
+					&event->target_1);
+				if (fd1 < 0) {
+					ret = fd1;
+					goto fail_deny_or_readd;
+				}
+			}
+		}
+
+		if (event->target_2.dentry) {
+			if (event->target_2_is_new) {
+				parent_path = p_parent(event->target_2);
+				fd2 = supervise_fs_fd_open_install(
+					&parent_path);
+				if (fd2 < 0) {
+					ret = fd2;
+					goto fail_deny_or_readd;
+				}
+			} else {
+				fd2 = supervise_fs_fd_open_install(
+					&event->target_2);
+				if (fd2 < 0) {
+					ret = fd2;
+					goto fail_deny_or_readd;
+				}
+			}
+		}
+	} else if (event->type == LANDLOCK_SUPERVISE_EVENT_TYPE_NET_ACCESS) {
+		user_event->port = event->port;
+	}
+
+	user_event->fd1 = fd1;
+	user_event->fd2 = fd2;
+
+	/* Non-variable-sized part */
+	if (copy_to_user(buf, user_event, dest_offset)) {
+		ret = -EFAULT;
+		goto fail_readd_event;
+	}
+
+	/* destname */
+	if (destname && destname_size > 0) {
+		if (copy_to_user(buf + dest_offset, destname, destname_size)) {
+			ret = -EFAULT;
+			goto fail_readd_event;
+		}
+	}
+
+	/* Zero out any padding bytes */
+	if (event_size > dest_offset + destname_size) {
+		size_t padding_len = event_size - dest_offset - destname_size;
+		if (clear_user(buf + dest_offset + destname_size,
+			       padding_len)) {
+			ret = -EFAULT;
+			goto fail_readd_event;
+		}
+	}
+
+	ret = event_size;
+	event->state = LANDLOCK_SUPERVISE_EVENT_NOTIFIED;
+	/* No decision yet, don't wake up! */
+	spin_lock(&supervisor->lock);
+	list_add(&event->node, &supervisor->notified_events);
+	event = NULL;
+	spin_unlock(&supervisor->lock);
+	goto free;
+
+fail_deny_or_readd:
+	if (ret == -EINTR)
+		goto fail_readd_event;
+	else
+		goto fail_deny;
+
+fail_readd_event:
+	WARN_ON(event->state != LANDLOCK_SUPERVISE_EVENT_NEW);
+	spin_lock(&supervisor->lock);
+	list_add(&event->node, &supervisor->event_queue);
+	event = NULL;
+	spin_unlock(&supervisor->lock);
+	goto free;
+
+fail_deny:
+	event->state = LANDLOCK_SUPERVISE_EVENT_DENIED;
+	wake_up_var(event);
+	landlock_put_supervise_event(event);
+	event = NULL;
+	goto free;
+
+free:
+	WARN_ON(event);
+	if (fd1 >= 0)
+		put_unused_fd(fd1);
+	if (fd2 >= 0)
+		put_unused_fd(fd2);
+	kfree(user_event);
+	return ret;
+}
+
+static __poll_t fop_supervisor_poll(struct file *file, poll_table *wait)
+{
+	struct landlock_supervisor *supervisor = file->private_data;
+	__poll_t mask = 0;
+
+	poll_wait(file, &supervisor->poll_event_wq, wait);
+
+	spin_lock(&supervisor->lock);
+	if (!list_empty(&supervisor->event_queue))
+		mask |= POLLIN | POLLRDNORM;
+	spin_unlock(&supervisor->lock);
+
+	return mask;
+}
+
+static ssize_t fop_supervisor_write(struct file *const filp,
+				    const char __user *const buf,
+				    const size_t size, loff_t *const ppos)
+{
+	struct landlock_supervisor *supervisor = filp->private_data;
+	struct landlock_supervise_response response;
+	struct landlock_supervise_event_kernel *event;
+	size_t bytes_processed = 0;
+	bool found;
+
+	/* We need at least one complete response */
+	if (size < sizeof(response))
+		return -EINVAL;
+
+	while (bytes_processed + sizeof(response) <= size) {
+		if (copy_from_user(&response, buf + bytes_processed,
+				   sizeof(response)))
+			return -EFAULT;
+
+		if (response.length != sizeof(response))
+			return -EINVAL;
+
+		spin_lock(&supervisor->lock);
+
+		/* Find the event with matching cookie */
+		found = false;
+		list_for_each_entry(event, &supervisor->notified_events, node) {
+			if (event->event_id == response.cookie) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found) {
+			spin_unlock(&supervisor->lock);
+			pr_warn("Unknown supervise event cookie: %u\n",
+				response.cookie);
+			event = NULL;
+			goto ret;
+		}
+
+		list_del(&event->node);
+		spin_unlock(&supervisor->lock);
+
+		if (WARN_ON(LANDLOCK_SUPERVISE_EVENT_HANDLED(event))) {
+			bytes_processed += sizeof(response);
+			landlock_put_supervise_event(event);
+			event = NULL;
+			continue;
+		}
+
+		if (response.decision == LANDLOCK_SUPERVISE_DECISION_ALLOW)
+			event->state = LANDLOCK_SUPERVISE_EVENT_ALLOWED;
+		else if (response.decision == LANDLOCK_SUPERVISE_DECISION_DENY)
+			event->state = LANDLOCK_SUPERVISE_EVENT_DENIED;
+		else {
+			pr_warn("Invalid supervise event decision: %u\n",
+				response.decision);
+			goto fail_re_add;
+		}
+
+		wake_up_var(event);
+		landlock_put_supervise_event(event);
+		event = NULL;
+
+		bytes_processed += sizeof(response);
+	}
+	goto ret;
+
+fail_re_add:
+	spin_lock(&supervisor->lock);
+	list_add(&event->node, &supervisor->notified_events);
+	event = NULL;
+	spin_unlock(&supervisor->lock);
+
+ret:
+	WARN_ON(event);
+	return bytes_processed > 0 ? bytes_processed : -EINVAL;
+}
+
 static const char *
 event_state_to_string(enum landlock_supervise_event_state state)
 {
@@ -338,9 +680,10 @@ static void fop_supervisor_fdinfo(struct seq_file *m, struct file *f)
 
 static const struct file_operations supervisor_fops = {
 	.release = fop_supervisor_release,
-	/* TODO: read, write, poll, dup */
-	.read = fop_dummy_read,
-	.write = fop_dummy_write,
+	.read = fop_supervisor_read,
+	.write = fop_supervisor_write,
+	.poll = fop_supervisor_poll,
+	.llseek = noop_llseek,
 	.show_fdinfo = fop_supervisor_fdinfo,
 };
 
-- 
2.39.5


