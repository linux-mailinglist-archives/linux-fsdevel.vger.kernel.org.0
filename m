Return-Path: <linux-fsdevel+bounces-39791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20332A18159
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 16:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FDA168A26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 15:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4C51F2C5B;
	Tue, 21 Jan 2025 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="om2NMjXf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V/OwZSjJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B61E51D
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737474445; cv=none; b=oEtQydDbL2tgfX4R9ajM6ed5hnNoLKeLJL1EFdzRLHw8slmm14LkNi5J57mxYUWOrKWdJYfnH5y1SUIPlA4Br2M280We9tcXyluLTjkSihj+QtD2tDgB4aDJRQHwBK7U5MMJ7TfBp4KskgdCEZ0q49/Dfk0z4zYV1PrdYG5qbrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737474445; c=relaxed/simple;
	bh=6EloJYI9kgbDyE7k3p0lFEr8X4AAjesJgfnUDnigGO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNSgjOr94UePpSVeQE/qG2uisPoIytB1Sv7wBO34dME1FrATZ2SzbOTFMnhGUYKhMwoyFlqoFvKZBRNIqxidpYGQ8CPVLoujQVKxmnE6nV7C7pvIAZNrtlliPN2Q/CU6lxk9kAuJ4GTVlAK4ompFjJ0dpZd9zvLgvQNZw9ZtpfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=om2NMjXf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V/OwZSjJ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 30E011140207;
	Tue, 21 Jan 2025 10:47:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 21 Jan 2025 10:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737474443; x=
	1737560843; bh=z421Buuoe3xBjBaJiL2rQxq6qPXzp06EqCnslaWE9bY=; b=o
	m2NMjXfoXpESKg8TBEKGD+I58bE82T2DnkAjlpBzvsxwblctcaqlSX6nBcXkYbmr
	jpBEPnsKbEYLLXJdIRbKSkGB1t92URuMi6jyF6lebjx+5QdQZeSo7R6I6t8xyViQ
	SttwddpZpHNrNUZrHzyMYLBrbYG9QAHPK1awsI6Gm4uZb+UPm4ForuANX7BTqsed
	9hO2nde4DkDf6H1Yh9Xc4tgUa+2/0W77/u6iGCHUhoEeVaGlqHR3B2HjD9yWDnzY
	VVimjHSuJg0dtaEEIh6HQ6uDAtNMME0pFN8DK2xaFwnszD1heCEDuMHyYWu61XtL
	mg0j/q8dfrfz+STgU5IBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1737474443; x=1737560843; bh=z
	421Buuoe3xBjBaJiL2rQxq6qPXzp06EqCnslaWE9bY=; b=V/OwZSjJLXcsy8LF4
	YYDJC7u+WSJdDoWgaPa4Q6Y5dBPf/xmPewnEiNYgy0WO5r0cp2WzNMfyMxwTHRAn
	22DoB1KEtu6Bg2uYIgzOV2EOi/GWF9l+92jJ2dOdSHVKYu5jOkHWLlyhmrGbsnCz
	LS1gauXmkGzrH0sV10/vPQX2nhQTb+hC1Bm0VnQmeIiVTOoFI0PLjMUp7eZNT+UT
	HaFiCmoI9GEGqNhnYFZa62JW/G6YuMyEXA55MgrKGxZ2qT8xrmfRm4/2aJ+6BXub
	XhSnx+Ocgivby0DUo4C4i9VxPGJfvp3g8E/LTLai1slw3nGjpIfHd/oQJjh4dc2C
	Ch8fw==
X-ME-Sender: <xms:i8GPZ8abMrjjms7s-RZv2RZ5TFFz2e9ZsN0aoVtraYXItC4NQDD_4A>
    <xme:i8GPZ3ZT_nukPh57g9-JfKR4a-v63uVNgocGYoJuHlVjlRA1S8kOJKb-v22Altqjg
    BW6Yi5GUFYc5Z2vqHs>
X-ME-Received: <xmr:i8GPZ2_lbYYU3STttliui3y1uoMzUmvf4Z7Ndz3vbE41JA0gRWRO_6660Jee_6yqySoT6saT624y5jAo73o22OWFchb_o6O5v6eiMgqiqmwWZmI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepffgrvhhiugcutfgvrghvvghruceomhgvsegurghvihgurhgvrghvvghrrd
    gtohhmqeenucggtffrrghtthgvrhhnpeduveetffevuedutdektdevtdetuedtfedvgefh
    hfejieevgedvtedvjeetjeelieenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
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
X-ME-Proxy: <xmx:i8GPZ2rWIwKzAmBun65z8pI5Y3GoG5nrGm-hogsGU9ZLkTzw0u6-TQ>
    <xmx:i8GPZ3pL4e2zap_YRwqhq5UKvgYJmBgyNQjEcseGXvasGIP2ThzJxg>
    <xmx:i8GPZ0RbG5TeUm08I66bpFb42ZQGJYGNc8ICgchpX_EfXB1kcRk1JQ>
    <xmx:i8GPZ3qF8jAHPH_iCJP4F-Mil_6dbntyTKgkf07YSXTkEB4_fa5Fzw>
    <xmx:i8GPZ0iweawztWDcD4ou1PhT5bLstSt7N6Ggq8GEbpx20jTccrcXrNGN>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 10:47:21 -0500 (EST)
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
Subject: [PATCH 5/5] samples/kernfs: Add inc file to allow changing counter increment
Date: Tue, 21 Jan 2025 07:47:17 -0800
Message-ID: <20250121154719.43303-1-me@davidreaver.com>
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

A file called inc is automatically added to sample_kernfs directories.
Users can read and write unsigned integers to this file. The value stored
in inc determines how much counter values are incremented every time they
are read.

Signed-off-by: David Reaver <me@davidreaver.com>
---
 samples/kernfs/sample_kernfs.c | 42 +++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/samples/kernfs/sample_kernfs.c b/samples/kernfs/sample_kernfs.c
index e632b5f66924..3d1e7fb4ecc5 100644
--- a/samples/kernfs/sample_kernfs.c
+++ b/samples/kernfs/sample_kernfs.c
@@ -17,11 +17,13 @@
 /**
  * struct sample_kernfs_directory - Represents a directory in the pseudo-filesystem
  * @count: Holds the current count in the counter file.
+ * @inc: Amount to increment count by. Value of inc file.
  * @subdirs: Holds the list of this directory's subdirectories.
  * @siblings: Used to add this dir to parent's subdirs list.
  */
 struct sample_kernfs_directory {
 	atomic64_t count;
+	atomic64_t inc;
 	struct list_head subdirs;
 	struct list_head siblings;
 };
@@ -34,6 +36,7 @@ static struct sample_kernfs_directory *sample_kernfs_create_dir(void)
 	if (!dir)
 		return NULL;

+	atomic64_set(&dir->inc, 1);
 	INIT_LIST_HEAD(&dir->subdirs);
 	INIT_LIST_HEAD(&dir->siblings);

@@ -55,7 +58,8 @@ static int sample_kernfs_counter_seq_show(struct seq_file *sf, void *v)
 {
 	struct kernfs_open_file *of = sf->private;
 	struct sample_kernfs_directory *counter_dir = kernfs_of_to_dir(of);
-	u64 count = atomic64_inc_return(&counter_dir->count);
+	u64 inc = atomic64_read(&counter_dir->inc);
+	u64 count = atomic64_add_return(inc, &counter_dir->count);

 	seq_printf(sf, "%llu\n", count);

@@ -83,6 +87,38 @@ static struct kernfs_ops counter_kf_ops = {
 	.write		= sample_kernfs_counter_write,
 };

+static int sample_kernfs_inc_seq_show(struct seq_file *sf, void *v)
+{
+	struct kernfs_open_file *of = sf->private;
+	struct sample_kernfs_directory *counter_dir = kernfs_of_to_dir(of);
+	u64 inc = atomic64_read(&counter_dir->inc);
+
+	seq_printf(sf, "%llu\n", inc);
+
+	return 0;
+}
+
+static ssize_t sample_kernfs_inc_write(struct kernfs_open_file *of, char *buf,
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
+	atomic64_set(&counter_dir->inc, new_value);
+
+	return nbytes;
+}
+
+static struct kernfs_ops inc_kf_ops = {
+	.seq_show	= sample_kernfs_inc_seq_show,
+	.write		= sample_kernfs_inc_write,
+};
+
 static int sample_kernfs_add_file(struct kernfs_node *dir_kn, const char *name,
 				  struct kernfs_ops *ops)
 {
@@ -105,6 +141,10 @@ static int sample_kernfs_populate_dir(struct kernfs_node *dir_kn)
 	if (err)
 		return err;

+	err = sample_kernfs_add_file(dir_kn, "inc", &inc_kf_ops);
+	if (err)
+		return err;
+
 	return 0;
 }

