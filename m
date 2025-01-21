Return-Path: <linux-fsdevel+bounces-39790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24053A18157
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 16:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ECAC167D40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 15:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2FD1F2C5B;
	Tue, 21 Jan 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="UdWTYFgM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v8z82WJz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9C31E51D
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737474435; cv=none; b=niyt0YWg1au/7gEjcMg/cKz1fiAtUj17NRwyX8upDPfggbi+oVnTSCuOUTbgkCGA5uZDPO01b0Odij8GOWV4vMy48vE5EV2axAdKyJSn5aHRolrlNsXbojWZZ6JnzJFsv3GWoAMBPEYtgh3q0v8fPZ8/DT9EXJBH2T5zzYzFJT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737474435; c=relaxed/simple;
	bh=GJgRTwJNMrvtt23OSJL7fsWrRantcnQpj5/kZp8XSX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ad3OjJ+43nzRMrgnoWf61ETOTtfxwsAKRyEmuLqi+tslLcC5rWNcnBdIzOo3HYMXV+ciHrFshaln2o6l/gpuQYoeltBiQ3IcUBPtIeZEFqZaKtFNwqwsi+6xDNgdc1vg39cu34IEyt+AXEaeW5K2bJPAyvcv6xJ5+5POPp9J3gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=UdWTYFgM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v8z82WJz; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BCFE011401A8;
	Tue, 21 Jan 2025 10:47:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 21 Jan 2025 10:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737474432; x=
	1737560832; bh=+dpuSj/YgA/FHya1kHurTlC4CWRVvZf6PYZabCw2m74=; b=U
	dWTYFgMUUUG/nl5kxDOaAIMm76WXNGfD86hJ+Wqq5t9dUgLM78eb3SvFYKKgM2OI
	YcyzbzpiZLI9r7fIdLqjpme5A1p8GoHh9e0YW4DFQK0CIR/4UPbL/8s74+mMrm9k
	49vwqB5C9zI7/3paXxvOixrnX1VlZrIPeS3DTxDDtS1of87rTjnMk0jXxCfQYL3m
	r1nMeZ6RHTY3fVOxsYN9wqX+e48lvtno/JLe0Plxq3hH6ci2qojKx3y15Zpe5+HN
	SVrmAQ+HBQ1Ncid+BCjW/20TbyvoQXRnK4VTj+EuAriAombEfoovVj6GTkK8x0OX
	WP9pWKzsnrFEq4PX7aDJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1737474432; x=1737560832; bh=+
	dpuSj/YgA/FHya1kHurTlC4CWRVvZf6PYZabCw2m74=; b=v8z82WJzH7mOiVfu5
	eP7rBBwcYUwS9Nj0pbl6ZFnOqbRqzvSH6L1+STiEgYIMU1LgenD7nZT6H+pIN3ix
	mhuuz4GG1RVfIxBT7Vm2OY4ZqAKN+5Enrqvl+Pj3ouyP3CdGdtu+TgtnaE2Uxogl
	MdlMs21Q3cu3mMXzUuiAN5vumca8W3xb+L6Bzo93lCOe1l4JQiQDejs5Av+Kahpo
	yJj4tqL2tcEPcBNtMjavQT9BTE6a7d4SedF5MKz0deQVOl6TjRQBo+DSStP5ZJvV
	HbV/gkXZt2nWj1MNnahZuy0LDnN5X+854Nl/axF//XKTEY8do0XfYd+hHs/kNK9G
	r4qtw==
X-ME-Sender: <xms:gMGPZ4uPXPRRtRLj2aJIR60AueoFL-EHtQzba2VbQzxXsa3b-nFZNA>
    <xme:gMGPZ1ccelpzMvQBSkdbpGnagWxQeGR_HxN0s-fzG6QtEg8aphBLafVQkgQRrcQyG
    iEN_GzjwheONlHEqLk>
X-ME-Received: <xmr:gMGPZzyTCMVlwZrb0QTdG9JL6Yw5QQFu2zIvNlE8FNoskqNZp30FEbGY6OkSsK47pqNeWYUrPC0d8xgvRlGwhSUAGEabotMCNgKj8nH91lOQPmM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepffgrvhhiugcutfgvrghvvghruceomhgvsegurghvihgurhgvrghvvghrrd
    gtohhmqeenucggtffrrghtthgvrhhnpeduveetffevuedutdektdevtdetuedtfedvgefh
    hfejieevgedvtedvjeetjeelieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
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
X-ME-Proxy: <xmx:gMGPZ7MEIqF5AEyvYaQPjGIgbm_78UCm4mIR8HeMYh_pKEf2cl2IJQ>
    <xmx:gMGPZ4-W_PaRfaFAaYPtm8MHsCxhNnOAFFfbL71uABXd5z1XeX4CMw>
    <xmx:gMGPZzUxi2fKQ3Hs5-kR-7ZeiWnGIMjBsk0wMdKt6_PowVtfzknVdw>
    <xmx:gMGPZxcj8-k3FFtSb77P9x3xhABjqHXaZ6nzKIrEEs7PmJGRU_abDw>
    <xmx:gMGPZ53qgRgdz8CYzTNs5Zj1lTjv5UKKYKXx9CoFwWly_RpL6b3Td-2Q>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 10:47:11 -0500 (EST)
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
Subject: [PATCH 4/5] samples/kernfs: Allow creating and removing directories
Date: Tue, 21 Jan 2025 07:47:06 -0800
Message-ID: <20250121154707.43185-1-me@davidreaver.com>
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

Users can mkdir and rmdir sample_kernfs directories, similar to how cgroups
are added and removed in the cgroup pseudo-filesystem. New directories
automatically get a counter file.

kernfs doesn't expose functions to traverse child nodes. We demonstrate how
to keep track of child nodes ourselves in sample_kernfs_directory.

Removing a directory is surprisingly tricky and can deadlock if you use
kernfs_remove() instead of kernfs_remove_self(), so a comment explains the
motivation for using kernfs_remove_self(). I also added a comment
explaining the lack of locking when manipulating the subdirs/children
lists.

Signed-off-by: David Reaver <me@davidreaver.com>
---
 samples/kernfs/sample_kernfs.c | 94 ++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/samples/kernfs/sample_kernfs.c b/samples/kernfs/sample_kernfs.c
index b6d44fc3b935..e632b5f66924 100644
--- a/samples/kernfs/sample_kernfs.c
+++ b/samples/kernfs/sample_kernfs.c
@@ -17,9 +17,13 @@
 /**
  * struct sample_kernfs_directory - Represents a directory in the pseudo-filesystem
  * @count: Holds the current count in the counter file.
+ * @subdirs: Holds the list of this directory's subdirectories.
+ * @siblings: Used to add this dir to parent's subdirs list.
  */
 struct sample_kernfs_directory {
 	atomic64_t count;
+	struct list_head subdirs;
+	struct list_head siblings;
 };

 static struct sample_kernfs_directory *sample_kernfs_create_dir(void)
@@ -30,6 +34,9 @@ static struct sample_kernfs_directory *sample_kernfs_create_dir(void)
 	if (!dir)
 		return NULL;

+	INIT_LIST_HEAD(&dir->subdirs);
+	INIT_LIST_HEAD(&dir->siblings);
+
 	return dir;
 }

@@ -101,6 +108,87 @@ static int sample_kernfs_populate_dir(struct kernfs_node *dir_kn)
 	return 0;
 }

+static void sample_kernfs_remove_subtree(struct sample_kernfs_directory *dir)
+{
+	struct sample_kernfs_directory *child, *tmp;
+
+	/*
+	 * Recursively remove children. This approach is acceptable for this
+	 * sample since we expect the tree depth to remain small and manageable.
+	 * For real-world filesystems, an iterative approach should be used to
+	 * avoid stack overflows.
+	 *
+	 * Also, we could be more careful with locking our lists, but kernfs
+	 * holds a tree-wide lock before calling our rmdir, so we should be
+	 * safe.
+	 */
+	list_for_each_entry_safe(child, tmp, &dir->subdirs, siblings) {
+		sample_kernfs_remove_subtree(child);
+	}
+
+	/* Remove this directory from its parent's subdirs list */
+	list_del(&dir->siblings);
+
+	kfree(dir);
+}
+
+static int sample_kernfs_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
+{
+	struct kernfs_node *dir_kn;
+	struct sample_kernfs_directory *dir, *parent_dir;
+	int ret;
+
+	dir = sample_kernfs_create_dir();
+	if (!dir)
+		return -ENOMEM;
+
+	/* dir gets stored in dir_kn->priv so we can access it later. */
+	dir_kn = kernfs_create_dir_ns(parent_kn, name, mode, current_fsuid(),
+				      current_fsgid(), dir, NULL);
+
+	if (IS_ERR(dir_kn)) {
+		ret = PTR_ERR(dir_kn);
+		goto err_free_dir;
+	}
+
+	ret = sample_kernfs_populate_dir(dir_kn);
+	if (ret)
+		goto err_free_dir_kn;
+
+	/* Add directory to parent->subdirs */
+	parent_dir = parent_kn->priv;
+	list_add(&dir->siblings, &parent_dir->subdirs);
+
+	return 0;
+
+err_free_dir_kn:
+	kernfs_remove(dir_kn);
+err_free_dir:
+	sample_kernfs_remove_subtree(dir);
+	return ret;
+}
+
+static int sample_kernfs_rmdir(struct kernfs_node *kn)
+{
+	struct sample_kernfs_directory *dir = kn->priv;
+
+	/*
+	 * kernfs_remove_self avoids a deadlock by breaking active protection;
+	 * see kernfs_break_active_protection(). This is required since
+	 * kernfs_iop_rmdir() holds a tree-wide lock.
+	 */
+	kernfs_remove_self(kn);
+
+	sample_kernfs_remove_subtree(dir);
+
+	return 0;
+}
+
+static struct kernfs_syscall_ops sample_kernfs_kf_syscall_ops = {
+	.mkdir		= sample_kernfs_mkdir,
+	.rmdir		= sample_kernfs_rmdir,
+};
+
 static void sample_kernfs_fs_context_free(struct fs_context *fc)
 {
 	struct kernfs_fs_context *kfc = fc->fs_private;
@@ -132,7 +220,7 @@ static int sample_kernfs_init_fs_context(struct fs_context *fc)
 	}

 	/* dir gets stored in root->priv so we can access it later. */
-	root = kernfs_create_root(NULL, 0, root_dir);
+	root = kernfs_create_root(&sample_kernfs_kf_syscall_ops, 0, root_dir);
 	if (IS_ERR(root)) {
 		err = PTR_ERR(root);
 		goto err_free_dir;
@@ -153,7 +241,7 @@ static int sample_kernfs_init_fs_context(struct fs_context *fc)
 err_free_root:
 	kernfs_destroy_root(root);
 err_free_dir:
-	kfree(root_dir);
+	sample_kernfs_remove_subtree(root_dir);
 err_free_kfc:
 	kfree(kfc);
 	return err;
@@ -167,7 +255,7 @@ static void sample_kernfs_kill_sb(struct super_block *sb)

 	kernfs_kill_sb(sb);
 	kernfs_destroy_root(root);
-	kfree(root_dir);
+	sample_kernfs_remove_subtree(root_dir);
 }

 static struct file_system_type sample_kernfs_fs_type = {

