Return-Path: <linux-fsdevel+bounces-43023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A764A4D0A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 02:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC851891240
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 01:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEB077102;
	Tue,  4 Mar 2025 01:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="aFPNH2In";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JVyXtXIN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3BD22092;
	Tue,  4 Mar 2025 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051263; cv=none; b=P3U7KBUId4PEZxvhfKdSBoyQ7UVKVu3URbjc90487JqOAlF2jLnG7HIrsPfffF+8IRWnAxflSm+tfr8ZCcj9WBfhemfcaZcbuALNvhX8M1LkmOOpHKn0H55WLhQJ2b7T/A51lhqG2HmSJdAP6c2MSuX8L5JoYQuLI2ciW0RmUvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051263; c=relaxed/simple;
	bh=Hsw+AMk4pRtKuraWYKtIjzWeF8iSeu5Jokn2tnsObuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4yzUawb/tQKycLxhbl+egnj2rJ8TLlooyaJAIiUVVaGE3UyjxnO9L90dODg07qpVKJpHN4wk/BxRiA3cZOWRZ06mPKqKyiOsj/Qgdybd3Ae1lQWnQmzgVlVyhNqAw8k0ng8LoV9snPIy4YOlmgBBoJrOdMNTI1WuNxbDRanuuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=aFPNH2In; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JVyXtXIN; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailflow.stl.internal (Postfix) with ESMTP id 8816B1D415DD;
	Mon,  3 Mar 2025 20:21:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 03 Mar 2025 20:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1741051260; x=
	1741054860; bh=Indt7uouUdIV1MUQRSDcszN4dc63JyY5LYMIguCfl5g=; b=a
	FPNH2InAF25Gq/+LCU+rudz8ednodDhHmfEzy2tDs/q1kRuHGyZu36AaqNKEEA6E
	EpSAmbNUGy/gqVIL/8eP0PzG8g1f9S0anfRjjxcJ/HvUYPx2aOOW0vwUikq+QGdW
	KWO3nNihiGTine40aRJcsI0uYqncg6Y8ZorcoaTbKY9qTnGkotoZHF5ziF8JJaPY
	MKv1Iy9wNB1vt8BOA4YFYGxKJ2sTICaqcTuW7ESIywNRNYYLab8iLvq2zDJlY+EC
	2RxKmvEvaFyoToBsivSINRJxmSOA60Q9iBM2ngFH/Hp/+X4JglgbgDhVfl5dnRLQ
	qw92ZBaTXEqWfq9hcwoew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741051260; x=1741054860; bh=I
	ndt7uouUdIV1MUQRSDcszN4dc63JyY5LYMIguCfl5g=; b=JVyXtXINeBUy0Z7eF
	S9PwrgiNR5JI6iKO9ugMdRGcXPBYVwnOdBGLe3tAkZdkjk2Y2Uw6e9qWu3HIw3nr
	j694IINK2RG3FjU8beEEnTe34ySfAI3eUlfX1xEiWpJhtw5oXDQq9i8P6kIpgXMF
	e3yHwAOyBLsKs0wfLWRxonWYpDLI8rmOAssFjhYjCRwKFOH2laP3QX0kpZfSpggW
	V1B3U+gmD5IPF7lrSMKbgm1OLizKGycUTHgPSuzoKZnYlli10FrA7Y51YDzefT4d
	r9Ok5apqA33mZFqxHE6BFAKmWfitY1/LxA2gQ9Inkbz+cK2KPHssbxBWbtKytbQA
	tdXbw==
X-ME-Sender: <xms:e1XGZwAMCBhCZxqF4IvAPZn3ZhWVXIP7wnEHHYhBIwSsAPiCgAFxyA>
    <xme:e1XGZyg4K86zqvG3yO0ofGwDRoZn_TiEyq8wfWNk_DGExxQB_vD8mFtvIu2ziRKnS
    93VbwpTiDStdfLE0iU>
X-ME-Received: <xmr:e1XGZzkxGwl9lPRIm6NuQA1FtrdfyDYl1EpkdkYaW9E2tcjgVofJsSpcunnULGXPxEEvVPKAdpWllktsKzanbrD4DUEhqWuyYCm_8xazZVR6GtutCohk-xM>
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
X-ME-Proxy: <xmx:e1XGZ2yXPGJRI9KjdDGqrlQQnkYqr1_a2Tf3p6ROOOpC4MvgaR2Xaw>
    <xmx:fFXGZ1RFq78psVHRM7cIzcT69sQryRh16uSVD5RYtB19DihtvQtv1w>
    <xmx:fFXGZxaZjL6uuI8pNciEwHjVsJqW-1pNGlV9EzDP8z057Ee5g7_1xg>
    <xmx:fFXGZ-SDTBpYJbt-awKy9PWuwhFLb7gXTf0zSNBC56FZym2RIji2zg>
    <xmx:fFXGZ0FxkEVUJc5wtWi5kfIoKTXXS5vrMkeypJXI-EgxKqpX2wZW7FIl>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 20:20:58 -0500 (EST)
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
Subject: [RFC PATCH 7/9] Implement fdinfo for ruleset and supervisor fd
Date: Tue,  4 Mar 2025 01:13:03 +0000
Message-ID: <ac7d452d8ab49338b8d44c66190230ecab44f0dd.1741047969.git.m@maowtm.org>
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

Purely for ease of debugging. Shows whether a ruleset is in
supervisor mode, and for the supervisor fd, any events.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 include/uapi/linux/landlock.h |   2 +
 security/landlock/syscalls.c  | 146 ++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index b5645fdd998d..2b2a21c1b6cf 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -270,6 +270,7 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
 #define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
 /* clang-format on */
+/* Add extra entries to access_request_to_string too */
 
 /**
  * DOC: net_access
@@ -292,6 +293,7 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
 #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
 /* clang-format on */
+/* Add extra entries to access_request_to_string too */
 
 /**
  * DOC: scope
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index f1080e7de0c7..3018e3663173 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -170,6 +170,17 @@ static ssize_t fop_dummy_write(struct file *const filp,
 	return -EINVAL;
 }
 
+static void fop_ruleset_fdinfo(struct seq_file *const m, struct file *const f)
+{
+	struct landlock_ruleset *const ruleset = f->private_data;
+
+	seq_printf(m, "num_rules: %d\n", ruleset->num_rules);
+	if (ruleset->layer_stack[0].supervisor)
+		seq_puts(m, "supervisor: yes\n");
+	else
+		seq_puts(m, "supervisor: no\n");
+}
+
 /*
  * A ruleset file descriptor enables to build a ruleset by adding (i.e.
  * writing) rule after rule, without relying on the task's context.  This
@@ -180,6 +191,7 @@ static const struct file_operations ruleset_fops = {
 	.release = fop_ruleset_release,
 	.read = fop_dummy_read,
 	.write = fop_dummy_write,
+	.show_fdinfo = fop_ruleset_fdinfo,
 };
 
 static int fop_supervisor_release(struct inode *const inode,
@@ -191,11 +203,145 @@ static int fop_supervisor_release(struct inode *const inode,
 	return 0;
 }
 
+static const char *
+event_state_to_string(enum landlock_supervise_event_state state)
+{
+	switch (state) {
+	case LANDLOCK_SUPERVISE_EVENT_NEW:
+		return "new";
+	case LANDLOCK_SUPERVISE_EVENT_NOTIFIED:
+		return "notified";
+	case LANDLOCK_SUPERVISE_EVENT_ALLOWED:
+		return "allowed";
+	case LANDLOCK_SUPERVISE_EVENT_DENIED:
+		return "denied";
+	default:
+		WARN_ONCE(1, "unknown event state\n");
+		return "unknown";
+	}
+}
+
+static void
+access_request_to_string(const landlock_supervise_event_type_t access_type,
+			 const access_mask_t access_request, struct seq_file *m)
+{
+	switch (access_type) {
+	case LANDLOCK_SUPERVISE_EVENT_TYPE_FS_ACCESS:
+		if (access_request & LANDLOCK_ACCESS_FS_EXECUTE)
+			seq_puts(m, "FS_EXECUTE ");
+		if (access_request & LANDLOCK_ACCESS_FS_WRITE_FILE)
+			seq_puts(m, "FS_WRITE_FILE ");
+		if (access_request & LANDLOCK_ACCESS_FS_READ_FILE)
+			seq_puts(m, "FS_READ_FILE ");
+		if (access_request & LANDLOCK_ACCESS_FS_READ_DIR)
+			seq_puts(m, "FS_READ_DIR ");
+		if (access_request & LANDLOCK_ACCESS_FS_REMOVE_DIR)
+			seq_puts(m, "FS_REMOVE_DIR ");
+		if (access_request & LANDLOCK_ACCESS_FS_REMOVE_FILE)
+			seq_puts(m, "FS_REMOVE_FILE ");
+		if (access_request & LANDLOCK_ACCESS_FS_MAKE_CHAR)
+			seq_puts(m, "FS_MAKE_CHAR ");
+		if (access_request & LANDLOCK_ACCESS_FS_MAKE_DIR)
+			seq_puts(m, "FS_MAKE_DIR ");
+		if (access_request & LANDLOCK_ACCESS_FS_MAKE_REG)
+			seq_puts(m, "FS_MAKE_REG ");
+		if (access_request & LANDLOCK_ACCESS_FS_MAKE_SOCK)
+			seq_puts(m, "FS_MAKE_SOCK ");
+		if (access_request & LANDLOCK_ACCESS_FS_MAKE_FIFO)
+			seq_puts(m, "FS_MAKE_FIFO ");
+		if (access_request & LANDLOCK_ACCESS_FS_MAKE_BLOCK)
+			seq_puts(m, "FS_MAKE_BLOCK ");
+		if (access_request & LANDLOCK_ACCESS_FS_MAKE_SYM)
+			seq_puts(m, "FS_MAKE_SYM ");
+		if (access_request & LANDLOCK_ACCESS_FS_REFER)
+			seq_puts(m, "FS_REFER ");
+		if (access_request & LANDLOCK_ACCESS_FS_TRUNCATE)
+			seq_puts(m, "FS_TRUNCATE ");
+		if (access_request & LANDLOCK_ACCESS_FS_IOCTL_DEV)
+			seq_puts(m, "FS_IOCTL_DEV ");
+		break;
+	case LANDLOCK_SUPERVISE_EVENT_TYPE_NET_ACCESS:
+		if (access_request & LANDLOCK_ACCESS_NET_BIND_TCP)
+			seq_puts(m, "NET_BIND_TCP ");
+		if (access_request & LANDLOCK_ACCESS_NET_CONNECT_TCP)
+			seq_puts(m, "NET_CONNECT_TCP ");
+		break;
+	}
+}
+
+static void fop_supervisor_fdinfo(struct seq_file *m, struct file *f)
+{
+	struct landlock_supervisor *const supervisor = f->private_data;
+	struct landlock_supervise_event_kernel *event;
+
+	spin_lock(&supervisor->lock);
+
+	size_t cnt = list_count_nodes(&supervisor->event_queue);
+	seq_printf(m, "num_events: %zu\n", cnt);
+	list_for_each_entry(event, &supervisor->event_queue, node) {
+		struct task_struct *task =
+			get_pid_task(event->accessor, PIDTYPE_PID);
+
+		seq_puts(m, "event:\n");
+		if (task) {
+			seq_printf(m, "\taccessor: %s[%d]\n", task->comm,
+				   task->pid);
+			put_task_struct(task);
+		} else {
+			seq_puts(m, "\taccessor: defunct\n");
+		}
+
+		if (event->type == LANDLOCK_SUPERVISE_EVENT_TYPE_FS_ACCESS) {
+			seq_puts(m, "\taccess: filesystem\n");
+			seq_printf(m, "\taccess_request: %llu ",
+				   (unsigned long long)event->access_request);
+			access_request_to_string(event->type,
+						 event->access_request, m);
+			seq_puts(m, "\n");
+			if (event->target_1.dentry) {
+				/*
+				 * ok to access since event owns a ref to the
+				 * path, and we have event list spin lock.
+				 */
+				if (event->target_1_is_new) {
+					seq_puts(m, "\ttarget_1 (new): ");
+				} else {
+					seq_puts(m, "\ttarget_1: ");
+				}
+				seq_path(m, &event->target_1, "");
+				seq_puts(m, "\n");
+			}
+			if (event->target_2.dentry) {
+				if (event->target_2_is_new) {
+					seq_puts(m, "\ttarget_2 (new): ");
+				} else {
+					seq_puts(m, "\ttarget_2: ");
+				}
+				seq_path(m, &event->target_2, "");
+				seq_puts(m, "\n");
+			}
+		} else if (event->type ==
+			   LANDLOCK_SUPERVISE_EVENT_TYPE_NET_ACCESS) {
+			seq_puts(m, "\taccess: network\n");
+			seq_printf(m, "\tport: %u\n",
+				   (unsigned int)event->port);
+		} else {
+			WARN(1, "unknown event key type\n");
+		}
+
+		seq_printf(m, "\tstate: %s\n",
+			   event_state_to_string(event->state));
+	}
+
+	spin_unlock(&supervisor->lock);
+}
+
 static const struct file_operations supervisor_fops = {
 	.release = fop_supervisor_release,
 	/* TODO: read, write, poll, dup */
 	.read = fop_dummy_read,
 	.write = fop_dummy_write,
+	.show_fdinfo = fop_supervisor_fdinfo,
 };
 
 static int
-- 
2.39.5


