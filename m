Return-Path: <linux-fsdevel+bounces-43021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC51A4D0A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 02:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4986D16F781
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 01:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B4D6A33B;
	Tue,  4 Mar 2025 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="caWyo5Hf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1iIinpMM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E81E33D8;
	Tue,  4 Mar 2025 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051206; cv=none; b=gizVZCGoM2BZ30MqWfyYJKDmCE4zMS4KAHKaNbk7DNlTu/lofWB0ybmsOOLtpgcjw3bybYNrf3KnxwvUZ4Z6T4cXrrVleVbJEVg2L8hrUOnlnCvMS5KqAyIXGsHe9dm0jQR6LhPDVbO6PTIFmmLkWLb35doPxzPl/TL2eO0U/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051206; c=relaxed/simple;
	bh=/6zHEeNlWOk76fvKC+LZi+JAcOoQkyaG2HOS//r+sOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drhLkXNDHioJBGaQcdVsEr5AIlmvpNMq4/EbcG1fCPu+QU67TQGEu0a2Tvf8Z6ezSPP2nGPGUsBU/PgEaeRQcZl94xkPC2CzX0ii06O6bhExaCcPH3ReKQUomFgNIVHHD/wzGt6PIFKOQIMw+EwFQLRk5MgqflpTcMZ39Nv206E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=caWyo5Hf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1iIinpMM; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id B5DA21D415DA;
	Mon,  3 Mar 2025 20:20:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 03 Mar 2025 20:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1741051203; x=
	1741054803; bh=dJjmDT0TrggptoCsUZJlKhp/zUupXoZO1X3oOo6W7zU=; b=c
	aWyo5HfgJInzlqmlMSvctKnJPI4fSsqxx/LvhKr/xW3/S/82N81F58NwiEwd7nvU
	Mr4/fw1f70/7AelsugDrAbeiWD4rRrGHK0Cj9I8dOGQ7L8RCHy7IwwaD3N3d37a8
	H8FGnWIFzB/SID9uYIZ1zlGLCuR/YDuRq0s96SkDWYLAYMnxkUCAaqVuOfJLnxIj
	VuTEQAehVLp+LLARMaY04JXSGTs6fEJ5gaAnnt1PbltkpzriwTIouxhWiTPHoMOT
	CMm+AL9XgnssppugivfVSiTMoNOsMGFquVZG7b1v1+75NeCtLHnfx9/TfbUj5hlY
	BKtTdlovJRCJ1nf72qRlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741051203; x=1741054803; bh=d
	JjmDT0TrggptoCsUZJlKhp/zUupXoZO1X3oOo6W7zU=; b=1iIinpMMlhSA+BDCv
	snHeVKMwGVg/LyzQhXL48UqBM3u8toYr092KS7zIMn5GkuvWVvs+xXOZEKebpl5p
	QAeqrbqpU9bUNvidcC8uX70S3L01sEStOIPJL9I49Hm+errBfgl8q8LBVXI8TAjh
	CDfgRXpbPfG+u9PfIf9+dwC1Husz6gjnKIwP3iIoG2ayOxhQMsN1PLmNpHQgbS7x
	kVsurGI8EUoT37isORC9tzBHV00a0JoJ+IchLZvcJww/fJCoWRt+z7riJrADWTkN
	UHMT9A9Uo7fOzM2NzHuJfgswXsmzhbkuc1xqAbRsV8sqy5a5Fq1gapDp+dAad63Q
	MX53g==
X-ME-Sender: <xms:Q1XGZ29FC5Z08064V-Mj1bLXqvSJCWiQcNx7o8xlwSyaIeBTWCuXtQ>
    <xme:Q1XGZ2tmeI8buQ1ki_OHVtQBlRrFnYaD623v5ZAhUYu8xfs_T0mzQ2Fk3jxCf1oqi
    6sSq0h3GEF0OWhFq0I>
X-ME-Received: <xmr:Q1XGZ8AVTG64EoOuQZpoCzMOmMTz2z2WHaW3CaF0rzXVLQfWnk8q7aeGpKZDgL8GDbf6e6OJoqhzyuIdjivzBbs2lQ56oh1a231dmzOZaNKrXvmKVHzNoq0>
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
X-ME-Proxy: <xmx:Q1XGZ-cu0yOgeLxD4Fqks4N_YCNJUm6F7c3ELhu-jDV1SU35yBSNbQ>
    <xmx:Q1XGZ7NGRsg62TJZbcECZGOFRuuzZ0OcHiEvLEwdNzD2wTCa2k89wQ>
    <xmx:Q1XGZ4mIW1GbV2ooJf_JWkY-N_Ub0Sz9-5zqm-sdR50BczODxsPM9A>
    <xmx:Q1XGZ9vJjf8zgF9sHl1ijQ3CI1oGqj6z-DQ-sIH_NUfv0n0mXHqPHg>
    <xmx:Q1XGZ3DkIPHoOricJaJkzcn7vdSk23MSMVc6xArQVag4L1IyqXv-a3pQ>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 20:20:01 -0500 (EST)
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
Subject: [RFC PATCH 5/9] Define user structure for events and responses.
Date: Tue,  4 Mar 2025 01:13:01 +0000
Message-ID: <cde6bbf0b52710b33170f2787fdcb11538e40813.1741047969.git.m@maowtm.org>
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

The two structures are designed to be passed via read and write
to the supervisor-fd.  Compile time check for no holes are added
to build_check_abi.

The event structure will be a dynamically sized structure with
possibly a NULL-terminating filename at the end.  This is so that
we can pass a raw filename to the supervisor for file creation
requests, without having the trouble of not being able to open a
fd to a file that has not been created.

NOTE: despite this patch having a new uapi, I'm still very open to e.g.
re-using fanotify stuff instead (if that makes sense in the end). This is
just a PoC.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 include/uapi/linux/landlock.h | 107 ++++++++++++++++++++++++++++++++++
 security/landlock/syscalls.c  |  28 +++++++++
 2 files changed, 135 insertions(+)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 7bc1eb4859fb..b5645fdd998d 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -318,4 +318,111 @@ struct landlock_net_port_attr {
 #define LANDLOCK_SCOPE_SIGNAL		                (1ULL << 1)
 /* clang-format on*/
 
+/**
+ * DOC: supervisor
+ *
+ * Supervise mode
+ * ~~~~~~~~~~~~~~
+ *
+ * TODO
+ */
+
+typedef __u16 landlock_supervise_event_type_t;
+/* clang-format off */
+#define LANDLOCK_SUPERVISE_EVENT_TYPE_FS_ACCESS         1
+#define LANDLOCK_SUPERVISE_EVENT_TYPE_NET_ACCESS        2
+/* clang-format on */
+
+struct landlock_supervise_event_hdr {
+	/**
+	 * @type: Type of the event.
+	 */
+	landlock_supervise_event_type_t type;
+	/**
+	 * @length: Length of the entire struct
+	 * landlock_supervise_event including this header.
+	 */
+	__u16 length;
+	/**
+	 * @cookie: Opaque identifier to be included in the response.
+	 */
+	__u32 cookie;
+};
+
+struct landlock_supervise_event {
+	struct landlock_supervise_event_hdr hdr;
+	__u64 access_request;
+	__kernel_pid_t accessor;
+	union {
+		struct {
+			/**
+			 * @fd1: An open file descriptor for the file (open,
+			 * delete, execute, link, readdir, rename, truncate),
+			 * or the parent directory (for create operations
+			 * targeting its child) being accessed.  Must be
+			 * closed by the reader.
+			 *
+			 * If this points to a parent directory, @destname
+			 * will contain the target filename. If @destname is
+			 * empty, this points to the target file.
+			 */
+			int fd1;
+			/**
+			 * @fd2: For link or rename requests, a second file
+			 * descriptor for the target parent directory.  Must
+			 * be closed by the reader.  @destname contains the
+			 * destination filename.  This field is -1 if not
+			 * used.
+			 */
+			int fd2;
+			/**
+			 * @destname: A filename for a file creation target.
+			 *
+			 * If either of fd1 or fd2 points to a parent
+			 * directory rather than the target file, this is the
+			 * NULL-terminated name of the file that will be
+			 * newly created.
+			 *
+			 * Counting the NULL terminator, this field will
+			 * contain one or more NULL padding at the end so
+			 * that the length of the whole struct
+			 * landlock_supervise_event is a multiple of 8 bytes.
+			 *
+			 * This is a variable length member, and the length
+			 * including the terminating NULL(s) can be derived
+			 * from hdr.length - offsetof(struct
+			 * landlock_supervise_event, destname).
+			 */
+			char destname[];
+		};
+		struct {
+			__u16 port;
+		};
+	};
+};
+
+/* clang-format off */
+#define LANDLOCK_SUPERVISE_DECISION_DENY              0
+#define LANDLOCK_SUPERVISE_DECISION_ALLOW             1
+/* clang-format on */
+
+struct landlock_supervise_response {
+	/**
+	 * @length: Size of this structure.
+	 */
+	__u16 length;
+	/**
+	 * @decision: Whether to allow the request.
+	 */
+	__u8 decision;
+	/**
+	 * @pad: Reserved, must be zero.
+	 */
+	__u8 _reserved;
+	/**
+	 * @cookie: Cookie previously received in the request.
+	 */
+	__u32 cookie;
+};
+
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index adf7e77023b5..f1080e7de0c7 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -91,6 +91,9 @@ static void build_check_abi(void)
 	struct landlock_path_beneath_attr path_beneath_attr;
 	struct landlock_net_port_attr net_port_attr;
 	size_t ruleset_size, path_beneath_size, net_port_size;
+	struct landlock_supervise_event *event;
+	struct landlock_supervise_response response;
+	size_t supervise_evt_size, supervise_response_size;
 
 	/*
 	 * For each user space ABI structures, first checks that there is no
@@ -114,6 +117,31 @@ static void build_check_abi(void)
 	net_port_size += sizeof(net_port_attr.port);
 	BUILD_BUG_ON(sizeof(net_port_attr) != net_port_size);
 	BUILD_BUG_ON(sizeof(net_port_attr) != 16);
+
+	/* Check that anything before the destname does not have holes */
+	supervise_evt_size = sizeof(event->hdr.type);
+	supervise_evt_size += sizeof(event->hdr.length);
+	supervise_evt_size += sizeof(event->hdr.cookie);
+	BUILD_BUG_ON(offsetofend(typeof(*event), hdr) != 8);
+	supervise_evt_size += sizeof(event->access_request);
+	supervise_evt_size += sizeof(event->accessor);
+	supervise_evt_size += sizeof(event->fd1);
+	supervise_evt_size += sizeof(event->fd2);
+	BUILD_BUG_ON(offsetof(typeof(*event), destname) != supervise_evt_size);
+	BUILD_BUG_ON(offsetof(typeof(*event), destname) != 28);
+
+	/*
+	 * Make sure this struct does not end up with stricter
+	 * alignment than 8
+	 */
+	BUILD_BUG_ON(__alignof__(typeof(*event)) != 8);
+
+	supervise_response_size = sizeof(response.length);
+	supervise_response_size += sizeof(response.decision);
+	supervise_response_size += sizeof(response._reserved);
+	supervise_response_size += sizeof(response.cookie);
+	BUILD_BUG_ON(sizeof(response) != supervise_response_size);
+	BUILD_BUG_ON(sizeof(response) != 8);
 }
 
 /* Ruleset handling */
-- 
2.39.5


