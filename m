Return-Path: <linux-fsdevel+bounces-34681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81879C7A65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 18:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992362859CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 17:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C1A20604B;
	Wed, 13 Nov 2024 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="ja2Ublu5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HVMJRe7b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B80202650;
	Wed, 13 Nov 2024 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520533; cv=none; b=NxQRUSX3kfraYsetyDDddkUL7JUQaWQ83XtFd9uvjL06kOtTyQ+lWH6+B4sZR6sh3OECh7zINwGQHevXd4WjpHiUZJadojK9xlNoDCuUqalX1Qys7vIGnCuizmqyRbtVe/q5J+3H7UmbeiwfYDvVu02v3ppE2BgpTlut+mjLqc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520533; c=relaxed/simple;
	bh=SLg3Nvd2Ng6Z3O2BakSqNJpdSY8Mjm5+k/iUlOERlV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KD4XaRTMIge8yYq8F3QJ0yy+ftvXq3Wpv1cgec72/wd1vTni/PkPhWIEMrAdWXp8bdGl3p22tqR69Xfh+6lkoE1ZkTB5/DBgmvKDI2d+GW8pNdMsCWbKl0Obr57x5id/x9llMU0LUwaQPmgBZm5JW/Tht0Fc4sV/YISZsY5IE2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=ja2Ublu5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HVMJRe7b; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id C8207114009D;
	Wed, 13 Nov 2024 12:55:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 13 Nov 2024 12:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731520529;
	 x=1731606929; bh=JLHWSuoD9LDVViaWJnWQUHzrViCI5wNYkPdZg2ABbyQ=; b=
	ja2Ublu5wGcgzQYXqoBkO591VZ12L67g+RR6TBTcouTpjWU1lWSz48zavD7BnJU2
	fmYGfMjpMhJAybRD3nIIS0YJUN2UPefBCSmkoaKZyBXMKckgEter9NsrL01bj1Gi
	di9OSOP48/H68DxnXe9bVxRzKjOgdDD/vjpC99lMcASUGEX5vF6zFh0lAdexENQ+
	oq61qmWUX2FshXkkvvzoAb0RtretwbP8XzBC8jG5cGdFfIEihkL7pNacBEoqGhgd
	JXp8a1vxrAJtG/o1Y1QR/qLuAorSsPVM6iiumoT95zmTMBlGSLmaY7hONBhK5CKw
	HudXBJ9lkVigAmlK4xH2JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731520529; x=
	1731606929; bh=JLHWSuoD9LDVViaWJnWQUHzrViCI5wNYkPdZg2ABbyQ=; b=H
	VMJRe7bbVq6IHTGhIoes/TG+TZCqa4zgIzlbs7ixvFvw6VVdYEml52FtCc2YnZCC
	7XxCzDp8p7OiNWUXqd+/aHvEwcwM1kMHAyUlzRrICtIYqEs0cSMbrsyGd9wOVTOk
	2joW6mfZq5d2H9vkm6Dtf1KGToyngu8xu8w5jYAQx8WA4SRdeXZUeW+uY72W+PnS
	tImZilyIkwpuAqPfT3oioZSqmTszTjSLS3Mo40dLaG1ag8AGEhrILB2g9EWwEFSL
	DEp71oajH5j25dg8XZTCKc2gY8A9clnlvK9yQOQj8Gja8YwrkNUSlmj+bG6GirHE
	ubRjLbrr5DTLsydHuUquA==
X-ME-Sender: <xms:Eeg0Z1-O_L54LDLeYsa4UQDPd_ufXK-Xo5_VSRJq4aioTB-z7SKH6A>
    <xme:Eeg0Z5sU_CKvh2JE9XCQ--35VqszvnOUmXOQ6TkI9DSdMrj3u1PEkJcgE9e9KEqD2
    kF9jqqMsTMnxYeg49E>
X-ME-Received: <xmr:Eeg0ZzBgHMBJMwQ6TXeLhQdy9MvqNduyKpsJdldGEJ1qj_rVPteCnzbPSkCakc4FfBbhai9Oy8N5uJEmdbje0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefgrhhinhcuufhhvghphhgvrhguuceovghrihhnrdhshhgvphhhvghrug
    esvgegfedrvghuqeenucggtffrrghtthgvrhhnpeegvdffgedugfeiveeifffggefhvddu
    uedvkefgvdduueeuheffgffftddtffeuveenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegvrhhinhdrshhhvghphhgvrhgusegvgeefrdgvuhdp
    nhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmh
    hirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhu
    khdprhgtphhtthhopegvrhhinhdrshhhvghphhgvrhgusegvgeefrdgvuhdprhgtphhtth
    hopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:Eeg0Z5eAo9vjt-SwNaJ5SGiBSDZ_hBy676gQOm9YL3usS61CUEWeYg>
    <xmx:Eeg0Z6MunSOtKXeu68pVrVbsTZoQ196CzvY6GpcPW6OVZ50K7-hWJA>
    <xmx:Eeg0Z7np_To1MN_R1xj48t-EKMtexEleZHVE69t6_o9x-JM7CXcaNw>
    <xmx:Eeg0Z0tLQpWjbKXBU7ESMAu3d-Dm4VyyxqTce-gFyQPtxGn6Zr_epw>
    <xmx:Eeg0Z7GviBd0g4BbNfhWrxhvfC-8dVGUmonF3JlFGFmje5iPYDDvgMkI>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 12:55:28 -0500 (EST)
From: Erin Shepherd <erin.shepherd@e43.eu>
Date: Wed, 13 Nov 2024 17:55:23 +0000
Subject: [PATCH v2 1/3] pseudofs: add support for export_ops
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-pidfs_fh-v2-1-9a4d28155a37@e43.eu>
References: <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
In-Reply-To: <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 linux-nfs@vger.kernel.org, Erin Shepherd <erin.shepherd@e43.eu>
X-Mailer: b4 0.14.2

Pseudo-filesystems might reasonably wish to implement the export ops
(particularly for name_to_handle_at/open_by_handle_at); plumb this
through pseudo_fs_context

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
---
 fs/libfs.c                | 1 +
 include/linux/pseudo_fs.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 46966fd8bcf9f042e85d0b66134e59fbef83abfd..698a2ddfd0cb94a8927d1d8a3bb3b3226d6d5476 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -669,6 +669,7 @@ static int pseudo_fs_fill_super(struct super_block *s, struct fs_context *fc)
 	s->s_blocksize_bits = PAGE_SHIFT;
 	s->s_magic = ctx->magic;
 	s->s_op = ctx->ops ?: &simple_super_operations;
+	s->s_export_op = ctx->eops;
 	s->s_xattr = ctx->xattr;
 	s->s_time_gran = 1;
 	root = new_inode(s);
diff --git a/include/linux/pseudo_fs.h b/include/linux/pseudo_fs.h
index 730f77381d55f1816ef14adf7dd2cf1d62bb912c..2503f7625d65e7b1fbe9e64d5abf06cd8f017b5f 100644
--- a/include/linux/pseudo_fs.h
+++ b/include/linux/pseudo_fs.h
@@ -5,6 +5,7 @@
 
 struct pseudo_fs_context {
 	const struct super_operations *ops;
+	const struct export_operations *eops;
 	const struct xattr_handler * const *xattr;
 	const struct dentry_operations *dops;
 	unsigned long magic;

-- 
2.46.1


