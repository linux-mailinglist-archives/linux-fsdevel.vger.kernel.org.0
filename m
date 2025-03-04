Return-Path: <linux-fsdevel+bounces-43020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38960A4D0A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 02:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7549B3A8A07
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 01:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE5C4D8C8;
	Tue,  4 Mar 2025 01:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="hBPxXWfu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XYscuKvA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877E38494;
	Tue,  4 Mar 2025 01:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051169; cv=none; b=lmhglZvqo+uZ1JBMCWuFBqT4wGwlWWrbLmJi0EGOJ8qSh1xMV+p0BU40KXF3kSA6Z+ka3F3yk6GSUe+q9o+ez+Ojfm5W2rbTQWzz0DcBP/O40dl31NQhhwzWUmHyi79tG62CoxhfBeceC8p1UkJZDqgmxM9oqB2evpY0bmRZv5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051169; c=relaxed/simple;
	bh=07ti56OF70Rg82aq8oC1MBeYhwa+T+Bz0OBSbhzm2vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8gQurrqXFOnT5i7Jzz5fi4pQ3NTvbEnN6ybmHyHcKQcPQYGC3mwY8tTns3Hbw+eWBtdC7Li1KI+vFiR3mLwJuh6RyuxvCelgqDdpa4cgCrnVzrLDP1QfSN38jP2J9b7j4RFM4mk+QUqyd4OfLMOVLCrHOrqp7987KX4PFHXNLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=hBPxXWfu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XYscuKvA; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailflow.stl.internal (Postfix) with ESMTP id 4A3E41D415DB;
	Mon,  3 Mar 2025 20:19:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 03 Mar 2025 20:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1741051166; x=
	1741054766; bh=9bKXC+Rkl+qdQICNs4xhf8d4SSP5mCAePj8E00/EBdc=; b=h
	BPxXWfuFGrIKMLbfSMc29N+Y8i0A22P/WFQQVPwI7NLzPBBpuU/3DtQWarBVaRyT
	IqAEKt1pJ5ZSFw1W8nEGyH5DKGxCRuR2KXclgci/AlVhyWOcW+6cioz56M8AiKma
	GD2zFErL5UH7OUcCFNfOCYJO9USVsvZXuDqepBB6IPY993/pIuzEOIaeOKlI5blV
	BtW9FFAUedoRDXzirmwZvn/08PPUba+DwIHwcr0VyQyAOdvQD5uiKd62f54d4Iia
	nO+QSa3qaTUr26rbcNVtR4Uv+Z6pHOl6qf0wlZQul8G23Hoj24i9PoBLcCvgl+MK
	4tKpmLIop7m6zdidrTLjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741051166; x=1741054766; bh=9
	bKXC+Rkl+qdQICNs4xhf8d4SSP5mCAePj8E00/EBdc=; b=XYscuKvAGIPDwcwHp
	W3kaGtNhcAzP/RkIdzOUxANz7aD0Vo1JeUxjzQmBzxGT66wPq/2ktvP03zRxlifP
	bkhU7vv3iZ65aNm6p1E30merCZGvWrfumrs8ZYrcxeMzIe54Mk02XWr9896LZAA7
	i1fl4Cm39iSzN0cYx5TgEbJn9lnz46xFti3VuxzDZYyt+4IYYJCAAp1OfcML1ehk
	VVZ1nEwmTFPjBN8/kznaL/SZ9/KueX4cp8JOotD1bSugH65PTQBfn/1G4yqH530j
	g6h3AeRokoUnPZgTrZuVSwfkwVvyvL7VagzQO5xuEmK9Yh+X9k9/W8di/AsTEl7J
	7hfLA==
X-ME-Sender: <xms:HVXGZ-C7-NbBAianZbGo2qlrgaCNzAnmA967C4lZpNZzOy4k31ToCg>
    <xme:HVXGZ4haKbtx0tVimGvyv4T4lF6vRpG7NKXxksnsmwTTm-d-4uQTiIhOZXpYWy5tw
    4KoD5bfwoxENMTPZSc>
X-ME-Received: <xmr:HVXGZxkUsjQlSmi21hfV2E5ZfpoYYmxONDU7LWLT9746rNXOgMC7sWTzsaW3r0j-euwu_sy_xgvcS_e1GARKp3mXT55wcwjDMv9ej6M10TK0hwnP1nScSP4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtieekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:HVXGZ8xw0OdP2MEs81Pw7wq2KHCxWZaxaXfrLK-YpO9VXMUTcrUG6Q>
    <xmx:HVXGZzQTaxntJPO7jXXnbnBsVb7o7Ff-cXAUslUPLpizFOMrVjKjIw>
    <xmx:HVXGZ3aBrlI9kVXP_piMCqDAw-mEJM6messyg7nZYEXaPlRhk4uV2A>
    <xmx:HVXGZ8S0AhwT1qBBM946kolLMNreEHhihcJ7GfjWEEJsZSoTwYePcA>
    <xmx:HVXGZyHZjFP3uWSNN8-llJiJpeKoGxxTydYjK3SN4yjyAaq0KntNpGJA>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 20:19:24 -0500 (EST)
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
Subject: [RFC PATCH 4/9] User-space API for creating a supervisor-fd
Date: Tue,  4 Mar 2025 01:13:00 +0000
Message-ID: <03d822634936f4c3ac8e4843f9913d1b1fa9d081.1741047969.git.m@maowtm.org>
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

We allow the user to pass in an additional flag to landlock_create_ruleset
which will make the ruleset operate in "supervise" mode, with a supervisor
attached. We create additional space in the landlock_ruleset_attr
structure to pass the newly created supervisor fd back to user-space.

The intention, while not implemented yet, is that the user-space will read
events from this fd and write responses back to it.

Note: need to investigate if fd clone on fork() is handled correctly, but
should be fine if it shares the struct file. We might also want to let the
user customize the flags on this fd, so that they can request no
O_CLOEXEC.

NOTE: despite this patch having a new uapi, I'm still very open to e.g.
re-using fanotify stuff instead (if that makes sense in the end). This is
just a PoC.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 include/uapi/linux/landlock.h |  10 ++++
 security/landlock/syscalls.c  | 102 +++++++++++++++++++++++++++++-----
 2 files changed, 98 insertions(+), 14 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index e1d2c27533b4..7bc1eb4859fb 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -50,6 +50,15 @@ struct landlock_ruleset_attr {
 	 * resources (e.g. IPCs).
 	 */
 	__u64 scoped;
+	/**
+	 * @supervisor_fd: Placeholder to store the supervisor file
+	 * descriptor when %LANDLOCK_CREATE_RULESET_SUPERVISE is set.
+	 */
+	__s32 supervisor_fd;
+	/**
+	 * @pad: Unused, must be zero.
+	 */
+	__u32 pad;
 };
 
 /*
@@ -60,6 +69,7 @@ struct landlock_ruleset_attr {
  */
 /* clang-format off */
 #define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
+#define LANDLOCK_CREATE_RULESET_SUPERVISE		(1U << 1)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index ead9b68168ad..adf7e77023b5 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -32,6 +32,7 @@
 #include "limits.h"
 #include "net.h"
 #include "ruleset.h"
+#include "supervise.h"
 #include "setup.h"
 
 static bool is_initialized(void)
@@ -99,8 +100,10 @@ static void build_check_abi(void)
 	ruleset_size = sizeof(ruleset_attr.handled_access_fs);
 	ruleset_size += sizeof(ruleset_attr.handled_access_net);
 	ruleset_size += sizeof(ruleset_attr.scoped);
+	ruleset_size += sizeof(ruleset_attr.supervisor_fd);
+	ruleset_size += sizeof(ruleset_attr.pad);
 	BUILD_BUG_ON(sizeof(ruleset_attr) != ruleset_size);
-	BUILD_BUG_ON(sizeof(ruleset_attr) != 24);
+	BUILD_BUG_ON(sizeof(ruleset_attr) != 32);
 
 	path_beneath_size = sizeof(path_beneath_attr.allowed_access);
 	path_beneath_size += sizeof(path_beneath_attr.parent_fd);
@@ -151,16 +154,42 @@ static const struct file_operations ruleset_fops = {
 	.write = fop_dummy_write,
 };
 
-#define LANDLOCK_ABI_VERSION 6
+static int fop_supervisor_release(struct inode *const inode,
+				  struct file *const filp)
+{
+	struct landlock_supervisor *supervisor = filp->private_data;
+
+	landlock_put_supervisor(supervisor);
+	return 0;
+}
+
+static const struct file_operations supervisor_fops = {
+	.release = fop_supervisor_release,
+	/* TODO: read, write, poll, dup */
+	.read = fop_dummy_read,
+	.write = fop_dummy_write,
+};
+
+static int
+landlock_supervisor_open_fd(struct landlock_supervisor *const supervisor,
+			    const fmode_t mode)
+{
+	landlock_get_supervisor(supervisor);
+	return anon_inode_getfd("[landlock-supervisor]", &supervisor_fops,
+				supervisor, O_RDWR | O_CLOEXEC);
+}
+
+#define LANDLOCK_ABI_VERSION 7
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
  *
- * @attr: Pointer to a &struct landlock_ruleset_attr identifying the scope of
- *        the new ruleset.
- * @size: Size of the pointed &struct landlock_ruleset_attr (needed for
- *        backward and forward compatibility).
- * @flags: Supported value: %LANDLOCK_CREATE_RULESET_VERSION.
+ * @attr:  Pointer to a &struct landlock_ruleset_attr identifying the scope of
+ *         the new ruleset.
+ * @size:  Size of the pointed &struct landlock_ruleset_attr (needed for
+ *         backward and forward compatibility).
+ * @flags: Supported value: %LANDLOCK_CREATE_RULESET_VERSION,
+ * 	       %LANDLOCK_CREATE_RULESET_SUPERVISE.
  *
  * This system call enables to create a new Landlock ruleset, and returns the
  * related file descriptor on success.
@@ -172,18 +201,21 @@ static const struct file_operations ruleset_fops = {
  * Possible returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
- * - %EINVAL: unknown @flags, or unknown access, or unknown scope, or too small @size;
+ * - %EINVAL: unknown @flags, or unknown access, or unknown
+ * 	          scope, or too small @size, or non-zero @pad;
  * - %E2BIG: @attr or @size inconsistencies;
  * - %EFAULT: @attr or @size inconsistencies;
  * - %ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
  */
 SYSCALL_DEFINE3(landlock_create_ruleset,
-		const struct landlock_ruleset_attr __user *const, attr,
-		const size_t, size, const __u32, flags)
+		struct landlock_ruleset_attr __user *const, attr, const size_t,
+		size, const __u32, flags)
 {
 	struct landlock_ruleset_attr ruleset_attr;
 	struct landlock_ruleset *ruleset;
+	struct landlock_supervisor *supervisor;
 	int err, ruleset_fd;
+	bool supervise = false;
 
 	/* Build-time checks. */
 	build_check_abi();
@@ -192,10 +224,16 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 		return -EOPNOTSUPP;
 
 	if (flags) {
-		if ((flags == LANDLOCK_CREATE_RULESET_VERSION) && !attr &&
-		    !size)
+		if (flags == LANDLOCK_CREATE_RULESET_VERSION) {
+			if (attr || size)
+				return -EINVAL;
 			return LANDLOCK_ABI_VERSION;
-		return -EINVAL;
+		}
+		if (flags == LANDLOCK_CREATE_RULESET_SUPERVISE) {
+			supervise = true;
+		} else {
+			return -EINVAL;
+		}
 	}
 
 	/* Copies raw user space buffer. */
@@ -206,6 +244,13 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	if (err)
 		return err;
 
+	if (supervise && size < offsetofend(typeof(ruleset_attr), pad))
+		return -EINVAL;
+
+	if (size >= offsetofend(typeof(ruleset_attr), pad) &&
+	    ruleset_attr.pad != 0)
+		return -EINVAL;
+
 	/* Checks content (and 32-bits cast). */
 	if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_ACCESS_FS) !=
 	    LANDLOCK_MASK_ACCESS_FS)
@@ -227,11 +272,40 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);
 
+	if (supervise) {
+		supervisor = landlock_create_supervisor();
+		if (IS_ERR(supervisor)) {
+			landlock_put_ruleset(ruleset);
+			return -ENOMEM;
+		}
+		/* Pass ownership of supervisor to ruleset struct */
+		ruleset->layer_stack[0].supervisor = supervisor;
+	}
+
 	/* Creates anonymous FD referring to the ruleset. */
 	ruleset_fd = anon_inode_getfd("[landlock-ruleset]", &ruleset_fops,
 				      ruleset, O_RDWR | O_CLOEXEC);
-	if (ruleset_fd < 0)
+	if (ruleset_fd < 0) {
 		landlock_put_ruleset(ruleset);
+		return ruleset_fd;
+	}
+
+	if (supervise) {
+		int supervisor_fd;
+
+		supervisor_fd = landlock_supervisor_open_fd(
+			ruleset->layer_stack[0].supervisor, O_RDWR | O_CLOEXEC);
+		if (supervisor_fd < 0) {
+			landlock_put_ruleset(ruleset);
+			return supervisor_fd;
+		}
+		if (copy_to_user(&attr->supervisor_fd, &supervisor_fd,
+				 sizeof(supervisor_fd))) {
+			landlock_put_ruleset(ruleset);
+			return -EFAULT;
+		}
+	}
+
 	return ruleset_fd;
 }
 
-- 
2.39.5


