Return-Path: <linux-fsdevel+bounces-43017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB6CA4D09A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 02:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FD516EFDD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 01:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ECB41AAC;
	Tue,  4 Mar 2025 01:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="m0t94J/h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bx5cACyV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A123F383;
	Tue,  4 Mar 2025 01:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050985; cv=none; b=fUiwj2VRuS9B3i7djyxFwp5BSj7tc3J4i4gBrunmUjycjiBkDyojwyGq8rIREaLukqxNghAexrzwJ72qpE4DqeTJmyQgWxKwMi5RX4aml92ysoIzcc5w1MsZqZIu4VQThySaXUWwLoRiY/1BsQJLKCEB/58MBLuidibZ9PsrGxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050985; c=relaxed/simple;
	bh=GB5PTejEb52DlcHgyWLNIgsn0TZHai1ZJRw5pAJ76h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRayWKJ+v4heHXZxpjqU9F6wafiOBVSJn8X34MQ45M9k6gsxvlCIdMKvYDVYNTq/a94vrl1v94GOCb0m/mCBRf9pX3iGyIwuB3g2IpJacR0/a69UmwljE2sIhwXWZPMV0QWXn157gakZ+RvnxrXocqsJleevttu1yEgmrMZqnmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=m0t94J/h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bx5cACyV; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id D33371D413F5;
	Mon,  3 Mar 2025 20:16:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 03 Mar 2025 20:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741050982;
	 x=1741054582; bh=Gl2rUkxfUrKKVIO5dmMkfvs2cEint31zV1hl5A3zvNE=; b=
	m0t94J/hB7ZxJkwe5Buckj39dUA5of+/mcVaB4KzR09G2xjZGn5Er+heClD83Yhz
	W06xNYq2QMj88tQzGCu0MWHc7ltYy/W2v80F2xVl84+aGTuHVYhKzE200iUGexvk
	srZ2f19mqsQdOWQbr+QZdBWACp8vlacXqbiu4NcFpJyUZDT4TiO5vTJt4qdI6ak1
	dMvyHPn/5F7EtuffUUtUXMsevbA8BOHnDMTVqB7+K3csyGQ9mHTCudOOd6WMATps
	1iFK1m88G0S6jVCITIwiJ1p4Ni+FUNi2yawFHcD5RSfHbHIQpEYKDpQ73El1Z28J
	hnBsjp7Dg3T09tSCxN/hGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741050982; x=
	1741054582; bh=Gl2rUkxfUrKKVIO5dmMkfvs2cEint31zV1hl5A3zvNE=; b=B
	x5cACyVI/9Xm+y2bWssNsNdtXuR46GXBFTwRnKrDGMRS9Byon7HpeR7PlsVYTUSa
	kO5vruvUDx7W960wE4BEvCUgCO0bCWTqbT04yQxxRKNvVsLaE90IlZz9YpiYeYJz
	edPJFvb373TXcaG6yzTTxa9C/CuMo/yWz0yhTrt4cWPxA4EKmCgqcn5IAmR4hUii
	byJZnTMnFxbHUgMQo3do1BUE4zcuG5HJXdrrD0ifq2qgENkMlrDnMYWma5m9kj2Q
	q2jIFjYvxeVn7goktJWWHsL9P9yPH8gyk3X+XvYc0l83WZMlf0WImfywMWEVtQea
	dqCqmAI2SDHp1/3nh99jA==
X-ME-Sender: <xms:ZlTGZyNRFaMHiBkyC5GmbWbD2zfkCCmoJvZBIiV1trf2CEf6lYpSbw>
    <xme:ZlTGZw8aMwWTkYADZXyGzXihs0SL3awsM9oY0aaO3cZWQ8zZgIFiFfGU6dKSiX010
    lCtZtaVGNl3GSMPkec>
X-ME-Received: <xmr:ZlTGZ5TqXx9KMThSNIkxjlWnEK2RLOgNAuL3EQpwq5y-WGBj7xG4tO6JNbFv60bo4lpAFTHPurhHOO8G62ut22lk2jm2qYvLvPRbzmBMlFfkkRwJi4fnNEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertder
    tdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepieeigeeghedtffeifffhkeeuffehhfevuefgvdekjeek
    hedvtedtgfdvgefhudejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtg
    hpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrggtkhes
    shhushgvrdgtiidprhgtphhtthhopehmsehmrghofihtmhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprhgvphhnohhpsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshgu
    vghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthihtghhohesth
    ihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:ZlTGZytF62UGZMsl5avE0eChFIigitQMydY3zCzrmS_6ly1NRFGhcQ>
    <xmx:ZlTGZ6fZOA8Ipup89x5je3pAL3PPA98PdUu6Wk0s7aOIGIB_o_DcgA>
    <xmx:ZlTGZ21Sm4cHKIT6neDtISTm7o8Wfp6_TGozL-8AARHkBw2dQ0-Kww>
    <xmx:ZlTGZ--XST4GHQUGAI2Fh-5a4cBDZ5j86lwpo4zuMgQ8ElOIcS_xow>
    <xmx:ZlTGZyRFVSKGI5YHcM7J9YBfDO433ZwQ0v6svNZuSM_VCwj7-3gWwJ4e>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 20:16:20 -0500 (EST)
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
Subject: [RFC PATCH 1/9] Define the supervisor and event structure
Date: Tue,  4 Mar 2025 01:12:57 +0000
Message-ID: <a5ffb6eb9be53fbc2e322dd77d4d0df930c009cc.1741047969.git.m@maowtm.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741047969.git.m@maowtm.org>
References: <cover.1741047969.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the current design (mostly not implemented yet), a "supervisor" is a
program that creates (but probably not enforce on itself) a Landlock
ruleset which it specifically marks as operating in "supervise" mode. For
such a layer (but not other layers below or above it), access not granted
by the ruleset, which would normally result in a denial, instead triggers
a supervise event, and the thread which caused the event is paused until
either the supervisor responds to the event, the event is cancelled due to
supervisor termination, or the requesting thread being killed.

We define a refcounted structure that represents a supervisor, and will
later be exposed to the user-space via a file descriptor.  Each supervisor
has an event queue and a separate list of events which have been read by
the supervisor and is now awaiting response.  This allows the future read
codepath to not have to iterate over already notified events, but still
allow the response codepath to find the event.

The event struct is also refcounted, so that it is not tied to the
lifetime of the supervisor (e.g. if it dies, the task doing the access
that is currently stuck in kernel syscall still holds the event refcount,
and can read its status safely).

The details of the event structure will be populated in a future patch.

The struct is called landlock_supervise_event_kernel so that the uapi
header can use the shorter name.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/Makefile    |  2 +-
 security/landlock/supervise.c | 72 +++++++++++++++++++++++++++++++++++
 security/landlock/supervise.h | 63 ++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+), 1 deletion(-)
 create mode 100644 security/landlock/supervise.c
 create mode 100644 security/landlock/supervise.h

diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index b4538b7cf7d2..c9bab22ab0f5 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
 
 landlock-y := setup.o syscalls.o object.o ruleset.o \
-	cred.o task.o fs.o
+	cred.o task.o fs.o supervise.o
 
 landlock-$(CONFIG_INET) += net.o
diff --git a/security/landlock/supervise.c b/security/landlock/supervise.c
new file mode 100644
index 000000000000..a3bb6928f453
--- /dev/null
+++ b/security/landlock/supervise.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Implementation specific to landlock-supervise
+ *
+ * Copyright © 2025 Tingmao Wang <m@maowtm.org>
+ */
+
+#include <linux/path.h>
+#include <linux/pid.h>
+#include <linux/slab.h>
+#include <linux/wait_bit.h>
+
+#include "supervise.h"
+
+struct landlock_supervisor *landlock_create_supervisor(void)
+{
+	struct landlock_supervisor *supervisor;
+
+	supervisor = kzalloc(sizeof(*supervisor), GFP_KERNEL_ACCOUNT);
+	if (!supervisor)
+		return ERR_PTR(-ENOMEM);
+	refcount_set(&supervisor->usage, 1);
+	supervisor->next_event_id = 1;
+	spin_lock_init(&supervisor->lock);
+	INIT_LIST_HEAD(&supervisor->event_queue);
+	INIT_LIST_HEAD(&supervisor->notified_events);
+	init_waitqueue_head(&supervisor->poll_event_wq);
+	return supervisor;
+}
+
+void landlock_get_supervisor(struct landlock_supervisor *const supervisor)
+{
+	refcount_inc(&supervisor->usage);
+}
+
+static void
+deny_and_put_event(struct landlock_supervise_event_kernel *const event)
+{
+	cmpxchg(&event->state, LANDLOCK_SUPERVISE_EVENT_NEW,
+		LANDLOCK_SUPERVISE_EVENT_DENIED);
+	cmpxchg(&event->state, LANDLOCK_SUPERVISE_EVENT_NOTIFIED,
+		LANDLOCK_SUPERVISE_EVENT_DENIED);
+	wake_up_var(event);
+	landlock_put_supervise_event(event);
+}
+
+void landlock_put_supervisor(struct landlock_supervisor *const supervisor)
+{
+	if (refcount_dec_and_test(&supervisor->usage)) {
+		struct landlock_supervise_event_kernel *freeme, *next;
+
+		might_sleep();
+		/* we are the only reference, hence no locking */
+
+		/* deny all pending events */
+		list_for_each_entry_safe(freeme, next, &supervisor->event_queue,
+					 node) {
+			list_del(&freeme->node);
+			deny_and_put_event(freeme);
+		}
+		/*
+		 * user reply no longer possible without any reference to
+		 * supervisor, deny all notified events
+		 */
+		list_for_each_entry_safe(freeme, next,
+					 &supervisor->notified_events, node) {
+			list_del(&freeme->node);
+			deny_and_put_event(freeme);
+		}
+		kfree(supervisor);
+	}
+}
diff --git a/security/landlock/supervise.h b/security/landlock/supervise.h
new file mode 100644
index 000000000000..1fc3460335af
--- /dev/null
+++ b/security/landlock/supervise.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - Implementation specific to landlock-supervise
+ *
+ * Copyright © 2025 Tingmao Wang <m@maowtm.org>
+ */
+
+#ifndef _SECURITY_LANDLOCK_SUPERVISE_H
+#define _SECURITY_LANDLOCK_SUPERVISE_H
+
+#include <linux/refcount.h>
+#include <linux/wait.h>
+#include <linux/path.h>
+#include <linux/pid.h>
+
+#include "access.h"
+#include "ruleset.h"
+
+struct landlock_supervisor {
+	refcount_t usage;
+	spinlock_t lock;
+	/* protected by @lock, contains landlock_supervise_event_kernel */
+	struct list_head event_queue;
+	/* protected by @lock, contains landlock_supervise_event_kernel */
+	struct list_head notified_events;
+	struct wait_queue_head poll_event_wq;
+	/* protected by @lock */
+	u32 next_event_id;
+};
+
+enum landlock_supervise_event_state {
+	LANDLOCK_SUPERVISE_EVENT_NEW,
+	LANDLOCK_SUPERVISE_EVENT_NOTIFIED,
+	LANDLOCK_SUPERVISE_EVENT_ALLOWED,
+	LANDLOCK_SUPERVISE_EVENT_DENIED,
+};
+
+struct landlock_supervise_event_kernel {
+	struct list_head node;
+	refcount_t usage;
+	enum landlock_supervise_event_state state;
+
+	/* more fields to come */
+};
+
+struct landlock_supervisor *landlock_create_supervisor(void);
+void landlock_get_supervisor(struct landlock_supervisor *const supervisor);
+void landlock_put_supervisor(struct landlock_supervisor *const supervisor);
+
+static inline void landlock_get_supervise_event(
+	struct landlock_supervise_event_kernel *const event)
+{
+	refcount_inc(&event->usage);
+}
+
+static inline void landlock_put_supervise_event(
+	struct landlock_supervise_event_kernel *const event)
+{
+	if (refcount_dec_and_test(&event->usage))
+		kfree(event);
+}
+
+#endif /* _SECURITY_LANDLOCK_SUPERVISE_H */
-- 
2.39.5


