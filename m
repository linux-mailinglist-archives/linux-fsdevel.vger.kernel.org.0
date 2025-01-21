Return-Path: <linux-fsdevel+bounces-39788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A16BA18154
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 16:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD1218841B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 15:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCDB1F2C5B;
	Tue, 21 Jan 2025 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="XzixGwz7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xOepJp35"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA8415383C
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737474412; cv=none; b=Txijwvbrb2iD4FtSvbkUVZUWKnlxtIsdzgS6xQuAzvUOlcJa2tbR2wVXOmQJEPQ4zwbK9IESwG2UL8eSRwtJM225efF7IDBj+teKXlBi0DcwHtzKodp1J2f9LKC6EW4jFS8oZTfcSVuIoYrjr+AvMh3uTbLlfd6IMd58wzr4Ks8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737474412; c=relaxed/simple;
	bh=9Y6Jwh1Q6ztKytHccbJhZDFI1e1hh+CWeIK8rGnZcRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrlNCI9hhW2J+XA4686GFUejVHWNbJ4MfCeXhWZ2c3xZbibv0URu4lOJTLHEvxAe+TSl/VTgCnfB7kgHsin6JgT+6hhiKyZiT6Opgyh9C5Hcx8IvquyEiWN5L6DPTH2hRPDHSr2CpDUcGIq5Iscv0wIQ11PRqOHrE3j/L/azMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=XzixGwz7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xOepJp35; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BCC2C11401A8;
	Tue, 21 Jan 2025 10:46:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 21 Jan 2025 10:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737474409; x=
	1737560809; bh=vHoCF68rFLj2RfdBRp0BprGKUNmf9JimnOKnExNcSys=; b=X
	zixGwz7gZjsRoU4jxrat6tFURw9sCYEQmIqQZts7pdlpcYjFz4CXarlgfk3QzpZY
	j8zxib1445eEyOVsuDPdTl7y7YZSdhAAQ6fsjSOHQVfWn9816Vb+/v7KoOdIlGAC
	FA5kiiS+r6p5sMvrjcVBKw0cg0IYcXfDXcao52lIoPR3/bPwtav882JIGU4eBQoI
	dVAhHm895FUvAJzF/V/k85/yAC9Z2hgOg//kzs6t/oFbvS809ML8/KhwDQnM8/L/
	AzRMQLSFyDyeYap5pqs8ifQ8n5/DAFf3Wf/SX+SaIDnp2ceUiRLvOSAzBx8l4qvK
	xCTelVdp1gMSNg6UiedHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1737474409; x=1737560809; bh=v
	HoCF68rFLj2RfdBRp0BprGKUNmf9JimnOKnExNcSys=; b=xOepJp35a31uiY2oe
	rnWTKcWx7fI83DEsNFKZzooNd+8Y1APTWDxCR/ZYwE2vT4Q7+NeSxZtxm+VZ4qIQ
	MpEAO9OzRFUoqV52kPxnySl17AxYHYMqcqp4xiUlmPk4iZQAKousXs8ejXU+FzNp
	Vr9jyoDgS7kmcmADHmZYwBcTqcOklFkmbi9FAkpYe6RvStC+6QwJhEvQippaIROY
	o4GRXZiPJMJhB3EnEZyVvlx6pYjCFTc+FduTfaYZ2N0sJHK85DSaro4U8jghGCti
	HO0VrK/os0oANRKIeiTXrfwNXkzuWDGfzkFo+4Qp4ys2GPrg342ks6TRsTuYEPRh
	onPhw==
X-ME-Sender: <xms:acGPZ9pHp_XlUOTZdL6u9k0uz4xEVnUJ8Eahi8IFbiXkrBDG5ky7Wg>
    <xme:acGPZ_qPtXPYfvA0DpxkMoXmSoiYa6HHewcLmCdaKyPPnHQg9_kaEj0uygPHynUka
    rKTU3ynr4lS54fSz8M>
X-ME-Received: <xmr:acGPZ6NBgeGyiT7a1rnaBbv0eBsdS9rFXk2OD3YMS4wRBRtK6HLYAdUsBIiEUg3TvoN6XiBBRJuOX3HewI2QAuzvO1PScv71acrnMNm40_YzkU4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepffgrvhhiugcutfgvrghvvghruceomhgvsegurghvihgurhgvrghvvghrrd
    gtohhmqeenucggtffrrghtthgvrhhnpeduveetffevuedutdektdevtdetuedtfedvgefh
    hfejieevgedvtedvjeetjeelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmvgesuggrvhhiughrvggrvhgvrhdrtghomhdpnhgspghrtghp
    thhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrhgvghhkhheslh
    hinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehtjheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhrtghpth
    htoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopegsrhgruhhn
    vghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinh
    hugidrohhrghdruhhkpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghp
    thhtohepjhgrmhgvshdrsghothhtohhmlhgvhieshhgrnhhsvghnphgrrhhtnhgvrhhshh
    hiphdrtghomhdprhgtphhtthhopehkjhhlgiesthgvmhhplhgvohhfshhtuhhpihgurdgt
    ohhm
X-ME-Proxy: <xmx:acGPZ47QKEYUBafXQwqepeVkdPS7gnph-g8nvLx8ZkDyiSczdK7-Tw>
    <xmx:acGPZ84k7C2_r5DWgK1KgShYhWYrUj5mXp8lxJA9aDD4QGRef0aMDg>
    <xmx:acGPZwhca8kYbxqs475LNJXaesogU50Qo6vZ2FObP0mt50M5acO6Zg>
    <xmx:acGPZ-7wYnGCBtDxg-svQu5g7qkMj81YXWjIq3ZP4jcVsMDy7nUZpA>
    <xmx:acGPZ5yG_f5LitMwrKxdtPeVVWL0Q-R3LQcJ-fh8ROoQs_mRGg1Efupv>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 10:46:47 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>
Cc: David Reaver <me@davidreaver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Krister Johansen <kjlx@templeofstupid.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] samples/kernfs: Make filesystem mountable
Date: Tue, 21 Jan 2025 07:46:40 -0800
Message-ID: <20250121154641.42975-1-me@davidreaver.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250121153646.37895-1-me@davidreaver.com>
References: <20250121153646.37895-1-me@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements the bare minimum functionality to safely mount and unmount the
sample_kernfs filesystem.

Signed-off-by: David Reaver <me@davidreaver.com>
---
 samples/kernfs/sample_kernfs.c | 69 +++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/samples/kernfs/sample_kernfs.c b/samples/kernfs/sample_kernfs.c
index 82d4b73a4534..3ea8411a72ae 100644
--- a/samples/kernfs/sample_kernfs.c
+++ b/samples/kernfs/sample_kernfs.c
@@ -6,12 +6,79 @@

 #define pr_fmt(fmt) "%s: " fmt, __func__

+#include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/kernfs.h>
 #include <linux/kernel.h>
 #include <linux/module.h>

+#define SAMPLE_KERNFS_MAGIC 0x8d000ff0
+
+static void sample_kernfs_fs_context_free(struct fs_context *fc)
+{
+	struct kernfs_fs_context *kfc = fc->fs_private;
+
+	kernfs_free_fs_context(fc);
+	kfree(kfc);
+}
+
+static const struct fs_context_operations sample_kernfs_fs_context_ops = {
+	.get_tree	= kernfs_get_tree,
+	.free		= sample_kernfs_fs_context_free,
+};
+
+static int sample_kernfs_init_fs_context(struct fs_context *fc)
+{
+	struct kernfs_fs_context *kfc;
+	struct kernfs_root *root;
+	int err;
+
+	kfc = kzalloc(sizeof(struct kernfs_fs_context), GFP_KERNEL);
+	if (!kfc)
+		return -ENOMEM;
+
+	root = kernfs_create_root(NULL, 0, NULL);
+	if (IS_ERR(root)) {
+		err = PTR_ERR(root);
+		goto err_free_kfc;
+	}
+
+	kfc->root = root;
+	kfc->magic = SAMPLE_KERNFS_MAGIC;
+	fc->fs_private = kfc;
+	fc->ops = &sample_kernfs_fs_context_ops;
+	fc->global = true;
+
+	return 0;
+
+err_free_kfc:
+	kfree(kfc);
+	return err;
+}
+
+static void sample_kernfs_kill_sb(struct super_block *sb)
+{
+	struct kernfs_root *root = kernfs_root_from_sb(sb);
+
+	kernfs_kill_sb(sb);
+	kernfs_destroy_root(root);
+}
+
+static struct file_system_type sample_kernfs_fs_type = {
+	.name			= "sample_kernfs",
+	.init_fs_context	= sample_kernfs_init_fs_context,
+	.kill_sb		= sample_kernfs_kill_sb,
+	.fs_flags		= FS_USERNS_MOUNT,
+};
+
 static int __init sample_kernfs_init(void)
 {
-	pr_info("Loaded sample_kernfs module.\n");
+	int err;
+
+	err = register_filesystem(&sample_kernfs_fs_type);
+	if (err)
+		return err;
+
 	return 0;
 }

