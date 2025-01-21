Return-Path: <linux-fsdevel+bounces-39789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1837A18156
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 16:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E241884366
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 15:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA01E1F2C5B;
	Tue, 21 Jan 2025 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="bxEk73uW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B21g0p4r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C591E51D
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737474425; cv=none; b=bDbKy2LhRjG758+0B7Adm8dOXB8iT6timnqDENSNTohTmjwpzqX5SyYByOqE2VLHwTHLDIPOLyRevK4viEwDevLDGKE+GuuoV6N95zhKE1M4uEGOgJyunbOzNAcy3KKiY75wftoAqOBIuPIfVBnXjaqGr65ACni5jWUzMhv8saA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737474425; c=relaxed/simple;
	bh=Tbw7QXRqo4mt07TRq9auXc5khpNtsubsMBtRuEVJpRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXYbCkvKwt+uMVuRP1HwfLA4DfjumT2GLl9cr2OynMMvdc7QSm1SX1jVInf526StFimddlFYkBHx64K34I2Of3ietzZp3hfWNf65IjdLsR8VjYguQi31q6ijOp/Ea3hcsmQz/AWOD3EhuFrkhMGUy57JJmH1Fw2dQzXzgHLqveI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=bxEk73uW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B21g0p4r; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9632B11401A8;
	Tue, 21 Jan 2025 10:47:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 21 Jan 2025 10:47:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737474422; x=
	1737560822; bh=W5C4F9PM/PfNqSW4bOY/QOCtG2nxDvTduzMolvI7/po=; b=b
	xEk73uWM4WQlWvRRXiSG4EeepgqCM6qDaeZnFZP0CxrH7/mxR69Z3OSe1PpC4OVG
	FmhP+kaALUt33Of4+nsFHtlwVpi7JdOHMkCubSR8MHX7rEMjSQLKrIMZHYfUdBbS
	lQRaJhhUs+DV/f8xF8aoEKAXP53VE2P4ZMswb9F7yWA48gzXIPBzXFjjjBcp5jP1
	0WxDhhYrIWLVF/PPWxXx/ojEbhwMOK8auJZsbU5U1ubuovH4JhieQptpw8c/+wQk
	u0RteUpfA0Fr9WJ2+4jFBIaHbBeaHkH/tacRvDXGsePUjkc6yIrJtTVEa7Rdk2pq
	O2DUQmmwjdtVdNZ6hSMMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1737474422; x=1737560822; bh=W
	5C4F9PM/PfNqSW4bOY/QOCtG2nxDvTduzMolvI7/po=; b=B21g0p4r7myARh0ui
	1Prhostia08QWqFlXaYW+zVHPxWTpCYf3pdyLe/ywaBfVRc/vf4F3sGc0Wce5Zym
	obJZZQjuDgZHju7GpPBXffJjuMJFW4WtSlx+P6XrLdqcko3goAd+y8EiM9jRgVJF
	eWQf/LkqzL4sz/gkC6h0JD1BjSCoIr7RHJ/WzU5y7l/MDNPOND8hd6/4emBwtQej
	bBNt32PZS6MZC8AWLlU6N7Yy1w27xThSlIbaXZ4zcvYCKF/yVKoVOiZjQRVq7ghh
	bInPDoBsJkxERT1qiAHEEdqszfYDUOcOhOdqx7ax7HejhxWvRRYAwoG9ZdsDgVow
	joWKQ==
X-ME-Sender: <xms:dsGPZ7FEKRA2m4CLXK6Xlr_jCc9meTHETWqR0TY9o1AHbpzUK2tRGg>
    <xme:dsGPZ4Vhaw7E1FtQk4T1bU1RuoADqcaPtc0Niii75Kf_fdpE6CJCbNxTOI7t2CSl6
    grBjGLnOQCL4tlt8Qc>
X-ME-Received: <xmr:dsGPZ9JbUtG8cO4yRJqWBwJIJtHPYVuUFUFhZjmifa-zXX3i59AqMrMN581Lqu6E98ePchHuEQjTVn0tdImOT3oosMmwO1aSZbw_MCez-aie_l8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddghedtucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:dsGPZ5EwCyWrREZCV9ubh4pI1kq8fJ4BpVFmo-qI7GSShUDI7GBj2w>
    <xmx:dsGPZxW4VZPPl1ppGn528MhwvaaYMFUviL93eSF7RNk8U2k-Tjp4Bg>
    <xmx:dsGPZ0PbJCnNZ60NDqm9qkXw8nBpbeQfR9kLpRMlpNfDqC7DuRYLIQ>
    <xmx:dsGPZw0fEVBFx2WhiT7daq9RPez-LYByuZvDfV5V2h1J7-h8UjoGcg>
    <xmx:dsGPZ6N5Hu4hCGe7jI4tTUurWfWW8bFQ72UmvYaUGqrKDCb2pI1z0hFD>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 10:47:00 -0500 (EST)
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
Subject: [PATCH 3/5] samples/kernfs: Add counter file to each directory
Date: Tue, 21 Jan 2025 07:46:57 -0800
Message-ID: <20250121154659.43079-1-me@davidreaver.com>
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

The counter file is automatically added to all sample_kernfs
directories (including the root directory). This demonstrates how to tie an
internal datastructure -- sample_kernfs_directory in this case -- to kernfs
nodes via kernfs_node->priv. Also demonstrates how to read and write simple
integer values to/from kernfs files.

Signed-off-by: David Reaver <me@davidreaver.com>
---
 samples/kernfs/sample_kernfs.c | 110 ++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/samples/kernfs/sample_kernfs.c b/samples/kernfs/sample_kernfs.c
index 3ea8411a72ae..b6d44fc3b935 100644
--- a/samples/kernfs/sample_kernfs.c
+++ b/samples/kernfs/sample_kernfs.c
@@ -14,6 +14,93 @@

 #define SAMPLE_KERNFS_MAGIC 0x8d000ff0

+/**
+ * struct sample_kernfs_directory - Represents a directory in the pseudo-filesystem
+ * @count: Holds the current count in the counter file.
+ */
+struct sample_kernfs_directory {
+	atomic64_t count;
+};
+
+static struct sample_kernfs_directory *sample_kernfs_create_dir(void)
+{
+	struct sample_kernfs_directory *dir;
+
+	dir = kzalloc(sizeof(struct sample_kernfs_directory), GFP_KERNEL);
+	if (!dir)
+		return NULL;
+
+	return dir;
+}
+
+static struct sample_kernfs_directory *kernfs_of_to_dir(struct kernfs_open_file *of)
+{
+	struct kernfs_node *dir_kn = kernfs_get_parent(of->kn);
+	struct sample_kernfs_directory *dir = dir_kn->priv;
+
+	/* kernfs_get_parent adds a reference; drop it with kernfs_put */
+	kernfs_put(dir_kn);
+
+	return dir;
+}
+
+static int sample_kernfs_counter_seq_show(struct seq_file *sf, void *v)
+{
+	struct kernfs_open_file *of = sf->private;
+	struct sample_kernfs_directory *counter_dir = kernfs_of_to_dir(of);
+	u64 count = atomic64_inc_return(&counter_dir->count);
+
+	seq_printf(sf, "%llu\n", count);
+
+	return 0;
+}
+
+static ssize_t sample_kernfs_counter_write(struct kernfs_open_file *of, char *buf,
+					   size_t nbytes, loff_t off)
+{
+	struct sample_kernfs_directory *counter_dir = kernfs_of_to_dir(of);
+	int ret;
+	u64 new_value;
+
+	ret = kstrtou64(strstrip(buf), 10, &new_value);
+	if (ret)
+		return ret;
+
+	atomic64_set(&counter_dir->count, new_value);
+
+	return nbytes;
+}
+
+static struct kernfs_ops counter_kf_ops = {
+	.seq_show	= sample_kernfs_counter_seq_show,
+	.write		= sample_kernfs_counter_write,
+};
+
+static int sample_kernfs_add_file(struct kernfs_node *dir_kn, const char *name,
+				  struct kernfs_ops *ops)
+{
+	struct kernfs_node *kn;
+
+	kn = __kernfs_create_file(dir_kn, name, 0666, current_fsuid(),
+				  current_fsgid(), 0, ops, NULL, NULL, NULL);
+
+	if (IS_ERR(kn))
+		return PTR_ERR(kn);
+
+	return 0;
+}
+
+static int sample_kernfs_populate_dir(struct kernfs_node *dir_kn)
+{
+	int err;
+
+	err = sample_kernfs_add_file(dir_kn, "counter", &counter_kf_ops);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static void sample_kernfs_fs_context_free(struct fs_context *fc)
 {
 	struct kernfs_fs_context *kfc = fc->fs_private;
@@ -30,6 +117,7 @@ static const struct fs_context_operations sample_kernfs_fs_context_ops = {
 static int sample_kernfs_init_fs_context(struct fs_context *fc)
 {
 	struct kernfs_fs_context *kfc;
+	struct sample_kernfs_directory *root_dir;
 	struct kernfs_root *root;
 	int err;

@@ -37,10 +125,17 @@ static int sample_kernfs_init_fs_context(struct fs_context *fc)
 	if (!kfc)
 		return -ENOMEM;

-	root = kernfs_create_root(NULL, 0, NULL);
+	root_dir = sample_kernfs_create_dir();
+	if (!root_dir) {
+		err = -ENOMEM;
+		goto err_free_kfc;
+	}
+
+	/* dir gets stored in root->priv so we can access it later. */
+	root = kernfs_create_root(NULL, 0, root_dir);
 	if (IS_ERR(root)) {
 		err = PTR_ERR(root);
-		goto err_free_kfc;
+		goto err_free_dir;
 	}

 	kfc->root = root;
@@ -49,8 +144,16 @@ static int sample_kernfs_init_fs_context(struct fs_context *fc)
 	fc->ops = &sample_kernfs_fs_context_ops;
 	fc->global = true;

+	err = sample_kernfs_populate_dir(kernfs_root_to_node(root));
+	if (err)
+		goto err_free_root;
+
 	return 0;

+err_free_root:
+	kernfs_destroy_root(root);
+err_free_dir:
+	kfree(root_dir);
 err_free_kfc:
 	kfree(kfc);
 	return err;
@@ -59,9 +162,12 @@ static int sample_kernfs_init_fs_context(struct fs_context *fc)
 static void sample_kernfs_kill_sb(struct super_block *sb)
 {
 	struct kernfs_root *root = kernfs_root_from_sb(sb);
+	struct kernfs_node *root_kn = kernfs_root_to_node(root);
+	struct sample_kernfs_directory *root_dir = root_kn->priv;

 	kernfs_kill_sb(sb);
 	kernfs_destroy_root(root);
+	kfree(root_dir);
 }

 static struct file_system_type sample_kernfs_fs_type = {

