Return-Path: <linux-fsdevel+bounces-41358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D97A2E37C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 06:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23D0165C09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 05:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0E9192580;
	Mon, 10 Feb 2025 05:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="eN+YVGFH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y7XXu+U2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39F0189F20;
	Mon, 10 Feb 2025 05:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739164883; cv=none; b=tPCPkqQYm28e2Me67CMBmXYtr7h6htNAirn4MP0EVtpdRla+RvxU4nyNFUe04zQPyNo5yw+jcvNETGaxfzB9GdACEXGVAgQJJnL0iiNfGh2stJ3B3fPBg1gUF1bFMCdhwMm+bsZavi+qAVRIENVNH9fxBEclwTYIALGUNqgSiTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739164883; c=relaxed/simple;
	bh=2vSMEoX0Evv+1Tz969k9GK0fXp0LkjywetRjgGkKadU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qt5CZLaOR8rIsh90I/YyUqh8kkdqmd/b5qphoYotUtr6737oGcI/x851/t44vW72SaQhitAA2cIEJ0i94x6F5yqydO016peKOxzdlLxH7i69faMWNKFGa/vGNGhsJDKtDK9tlbC9XqBV63guB3vwNCTR9sT1O/2JXJPktMZ311s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=eN+YVGFH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y7XXu+U2; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 00D6F138010C;
	Mon, 10 Feb 2025 00:21:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 10 Feb 2025 00:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1739164880; x=
	1739251280; bh=/M2Nru2NZro488gTVTzJhmdDjcvACD8WWOsTwksoVh4=; b=e
	N+YVGFHiY3Y/gF/cpS0Mh+bC4gVAgX8HwHHQonFV/uxvYtGd+2aVSrSfK8w7raCb
	ZdQlJknLRyndLWN7N8zabhZ/I6i1grQEWBe1UsJ0+oAmbA5XUgmzgAH1+4Oti9me
	QK6eIYpYqyKoJvX99CsIMXWAUkISM3G9mguW6+1GN5WiI03SnUIy/jTuGozvkYjB
	kHkGh2RtOHoEzwgyd/jgf3WS9qq3VMr4NSLzMMAaszNyna1tIjGmT1rvlGK0WV2L
	ZTn9/Xn7sRTgHePIRciGNUXwzcnVcIXy10mx9UomSHernqT4BTSmp+7nsKbdCP+W
	ce/7g+PUgAw6YXZ7FCGXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1739164880; x=1739251280; bh=/
	M2Nru2NZro488gTVTzJhmdDjcvACD8WWOsTwksoVh4=; b=y7XXu+U2Z0pF9JM2I
	YGsbX662Nw6O8Ef2ZPF3G3KfC/cBGymONrxgZrIR/mL01L4d45tNbBFnRJrRVYYL
	66/LBbbqejibI3VPjo8lBLjXTA9WQFOuI858pznRMhJQ53B/uXj6Vw/JIMr7/bOc
	N9zYv6xv98dlynRlMMha95G5YZTtSOOY9b/BqYi3YiftnIWKgNy6VShbpqHaVtBx
	DKf+MkFtV8G71Zsj8wGj8mlzzflN6MLjzXGfzw4h24JiK3gy2UJHYNjUMVKw4euE
	ebc2liN9UEPHfcFOXV8/h0nsXe6mqTZFXPr1vq7KDXtxGAf918Hi7YMU4LiAOlAQ
	D4a0Q==
X-ME-Sender: <xms:0IypZ5EQINYkMcUZJK17vmn5CrBuS0L1k1KcE2Zt4klW7F9NQoKRUw>
    <xme:0IypZ-VvK0YZAeYRmkQZoL3a_bJZ9n4Z-c5lNkuOqzJIK-mxt16bFq0na3mHyyI7b
    cCIdHwpXC8iiWGzhEA>
X-ME-Received: <xmr:0IypZ7K6gpvON7wYtxXDBvfS9AXWwXkS4fI1SJD68z_8I4LUumuULEKTzSw44V2nGI83TZmB74r5N8zs7CcE8fY_og68c6XO9gD4TchoIO03dqs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefjedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrh
    drtghomheqnecuggftrfgrthhtvghrnhepudevteffveeuuddtkedtvedtteeutdefvdeg
    hffhjeeiveegvdetvdejteejleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhnsggprhgt
    phhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhrvghgkhhhse
    hlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhrtghpthhtoheprhhoshht
    vgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdr
    uhhkpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohgttghisehinhhrihgrrdhfrh
X-ME-Proxy: <xmx:0IypZ_HVYGe_UJ_lfrg7oQ81Mvcx1xnWVu2M_G1DB4VvuudneeastA>
    <xmx:0IypZ_Vh4XhuoTFEune1QNdJJwF9EPE7udYUnJPqvnwf7ECuu6z_YA>
    <xmx:0IypZ6Nvuzrn71dUm7n6oN4yv9Mbc_tlKYnTF-ZhgHGc8bz7E7i8yg>
    <xmx:0IypZ-2L_B4aftB5ye4axSbl9dcGiGFm_C2EmljOaNN9UXZqreceVQ>
    <xmx:0IypZ4NbaEcdiw1vFe-px8kM2gDBIC3qNFsp3mNoWb07uggKuqnFiW5_>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 00:21:19 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: David Reaver <me@davidreaver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/6] debugfs: Add helper functions for debugfs_node encapsulation
Date: Sun,  9 Feb 2025 21:20:22 -0800
Message-ID: <20250210052039.144513-3-me@davidreaver.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210052039.144513-1-me@davidreaver.com>
References: <20250210052039.144513-1-me@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once debugfs_node becomes a struct, users will need helper functions since
direct access to the underlying dentry will no longer be possible. This
commit introduces these helpers, which will be used in the automated
Coccinelle conversion.

Signed-off-by: David Reaver <me@davidreaver.com>
---
 fs/debugfs/inode.c      | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/debugfs.h | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 75715d8877ee..6892538d9d49 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -353,6 +353,44 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
 }
 EXPORT_SYMBOL_GPL(debugfs_lookup);
 
+char *debugfs_node_path_raw(struct debugfs_node *node, char *buf, size_t buflen)
+{
+	return dentry_path_raw(node, buf, buflen);
+}
+EXPORT_SYMBOL_GPL(debugfs_node_path_raw);
+
+struct debugfs_node *debugfs_node_get(struct debugfs_node *node)
+{
+	return dget(node);
+}
+EXPORT_SYMBOL_GPL(debugfs_node_get);
+
+void debugfs_node_put(struct debugfs_node *node)
+{
+	dput(node);
+}
+EXPORT_SYMBOL_GPL(debugfs_node_put);
+
+struct inode *debugfs_node_inode(struct debugfs_node *node)
+{
+	return d_inode(node);
+}
+EXPORT_SYMBOL_GPL(debugfs_node_inode);
+
+struct debugfs_node *debugfs_node_from_dentry(struct dentry *dentry)
+{
+	if (dentry->d_sb->s_op == &debugfs_super_operations)
+		return dentry;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(debugfs_node_from_dentry);
+
+struct dentry *debugfs_node_dentry(struct debugfs_node *node)
+{
+	return node;
+}
+EXPORT_SYMBOL_GPL(debugfs_node_dentry);
+
 static struct dentry *start_creating(const char *name, struct dentry *parent)
 {
 	struct dentry *dentry;
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index e6ee571e8c36..738a990f99cd 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -79,6 +79,18 @@ struct debugfs_short_fops {
 
 struct dentry *debugfs_lookup(const char *name, struct dentry *parent);
 
+char *debugfs_node_path_raw(struct debugfs_node *node, char *buf, size_t buflen);
+
+struct debugfs_node *debugfs_node_get(struct debugfs_node *node);
+
+void debugfs_node_put(struct debugfs_node *node);
+
+struct inode *debugfs_node_inode(struct debugfs_node *node);
+
+struct debugfs_node *debugfs_node_from_dentry(struct dentry *dentry);
+
+struct dentry *debugfs_node_dentry(struct debugfs_node *node);
+
 struct dentry *debugfs_create_file_full(const char *name, umode_t mode,
 					struct dentry *parent, void *data,
 					const void *aux,
@@ -271,6 +283,35 @@ static inline struct dentry *debugfs_lookup(const char *name,
 	return ERR_PTR(-ENODEV);
 }
 
+static inline char *debugfs_node_path_raw(struct debugfs_node *node, char *buf,
+					  size_t buflen)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline struct debugfs_node *debugfs_node_get(struct debugfs_node *node)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+void debugfs_node_put(struct debugfs_node *node)
+{ }
+
+struct inode *debugfs_node_inode(struct debugfs_node *node)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+struct debugfs_node *debugfs_node_from_dentry(struct dentry *dentry)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+struct dentry *debugfs_node_dentry(struct debugfs_node *node)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct dentry *debugfs_create_file_aux(const char *name,
 					umode_t mode, struct dentry *parent,
 					void *data, void *aux,

