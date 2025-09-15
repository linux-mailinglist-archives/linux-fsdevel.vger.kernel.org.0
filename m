Return-Path: <linux-fsdevel+bounces-61272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E87CB56E3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 04:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F04F3B6C14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 02:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E73222585;
	Mon, 15 Sep 2025 02:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="xSaWPW6X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kh/E7tGS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6327B1F37D3
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757902592; cv=none; b=g84AqM+aj20LibIG2jiW7r6e+gY2Fvd4re+1UQ0u2VKZ5u2ZbE4Ori8mkLvlIzUsMrxrd96bWGF0CsclLVf+E4VcIIRfvRIElp52/H7m+/Clqg8tsRWiwKV+UCWBywJTM3O72+vfm8yGkvFEqh/FAFEAqQFNKiRE2BSCblIF6vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757902592; c=relaxed/simple;
	bh=dorb3XkAnq3m+Ip/+8OPelvYCsN+wO6LGLRcQiaeqYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NloUpQNTV/5y849KHo9sOtRxOtk9+SHiJNEctx4Nwj/SrhE+BIZiD3gamVbpsdXB80WQTUoNxOrdjer6uv72//ZdmwW3FYms+tdPYy0p5yUp8Nf1DN9o+8yoKVB7Cgn11Hc4g1HT4tU+Q5zuVxCBzuSj6d9W1IhY9jbx0D4a4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=xSaWPW6X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kh/E7tGS; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8E9331D0008A;
	Sun, 14 Sep 2025 22:16:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 14 Sep 2025 22:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1757902588;
	 x=1757988988; bh=6iHRI8psVgHHTLvGUROVbKi9+7XOp6D150cYatnnwV8=; b=
	xSaWPW6Xbr1/4B1HZlhxkuLklQccFv1ktXFac3B128lxynCpJmyPF31dPAqzFoeh
	vsVP335YYk8l9jfUoypuy3AojUyY3coSB/P7gjOiRDULv4KC0fRM3Sqgb0Y0WXix
	AlXxx7JwIdxXs5kh2AUIWBaRoaJSL7Cd5CVy1LGxipVvDAyVezw3bvrR3xR8SsQ9
	R4khmrx0KHuPAERbV7K8EVLr2V32jgh10v3UmoJ8vDpdg1N+FyDomYrzpB2dWUk/
	DUojL8Wre9aGxLdv/AX3Meva+wWChoelEgyFW+E3N5ZSR/3ZR29ULkuLV9GU5DYN
	ulfkyqRc9XaAsU+ClIRPSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757902588; x=1757988988; bh=6
	iHRI8psVgHHTLvGUROVbKi9+7XOp6D150cYatnnwV8=; b=kh/E7tGS0SgnR4dGi
	g+ADxVku8WkZ5srsXDT2ur/wHJnEKYKNcwNulLzQVuqonyqOJQIXjieYvjRkYBnG
	9vDF7zICZB+jX4e6Yu/K2KM+kwehl15Fg8Boqu0LItG4VheDQGNSqSGPEAdwwvQg
	1raG9wW9E9Vlfhg8ZCcRoe0o7aBG/RqJ6kwVmmrzQ42VXNJAUVh/oqMSgZ1dG9AQ
	MYlMiBTApT46o99nNhK2G9I7Zu9hnL1GzBw8XlCHvq9yQyyx4NZsvYHYGLJGb1V4
	wnt3T5I+3sXZQ6oQauYqmsxcF5Zwl4Fq5O4S44wSPW9AjIIf3fqg848f27xTIYiU
	S4+KA==
X-ME-Sender: <xms:_HbHaOdBctNE3Krke3rl_3fuJ9Y7PWSUCWH9TTtsCX4pm78trYU1PQ>
    <xme:_HbHaPkP2M-2TUcISeju_MVkMpyZygbmNEsl3JpiL1ryi8kohpBK_fdOfEH-3fCKH
    5zp1nNaiZhPqw>
X-ME-Received: <xmr:_HbHaFGHskN-023mt0ThjuNRYYoq_xQ4-HiaukynDUaERN8fvmJmxBWSkHi55heazM7rzaEq88A4nC7StfQuCY7XRTP40UjAA6t5E-PnLK0W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefieegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:_HbHaH4_hiBWO6UPXz5IUmCCZTDncafi-gQqpQ-dazXyx6eRa8HHmg>
    <xmx:_HbHaNmqC9FwBxz2NiUQHNGvfVgm54eymmrkwJgmoNip6d8MurIqXQ>
    <xmx:_HbHaMqIN3MZ0ou6I2aEvqD7eDcCIEqg8CuRkK-uNNFXOoIKt436eA>
    <xmx:_HbHaMsZEIzYS6VwdjbI1iHiQCYzbo3THnAtRnmIplg05sjh1E9v7A>
    <xmx:_HbHaEeOnsvBgdAmHSP3a_9Fe5N2INgTFpteFET8rj-itk7beqXCVSi7>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 22:16:26 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 6/6] debugfs: rename start_creating() to debugfs_start_creating()
Date: Mon, 15 Sep 2025 12:13:46 +1000
Message-ID: <20250915021504.2632889-7-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250915021504.2632889-1-neilb@ownmail.net>
References: <20250915021504.2632889-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

start_creating() is a generic name which I would like to use for a
function similar to simple_start_creating(), only not quite so simple.

debugfs is using this name which, though static, will cause complaints
if then name is given a different signature in a header file.

So rename it to debugfs_start_creating().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/debugfs/inode.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index c12d649df6a5..661a99a7dfbe 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -362,7 +362,8 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
 }
 EXPORT_SYMBOL_GPL(debugfs_lookup);
 
-static struct dentry *start_creating(const char *name, struct dentry *parent)
+static struct dentry *debugfs_start_creating(const char *name,
+					     struct dentry *parent)
 {
 	struct dentry *dentry;
 	int error;
@@ -428,7 +429,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	if (!(mode & S_IFMT))
 		mode |= S_IFREG;
 	BUG_ON(!S_ISREG(mode));
-	dentry = start_creating(name, parent);
+	dentry = debugfs_start_creating(name, parent);
 
 	if (IS_ERR(dentry))
 		return dentry;
@@ -577,7 +578,7 @@ EXPORT_SYMBOL_GPL(debugfs_create_file_size);
  */
 struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 {
-	struct dentry *dentry = start_creating(name, parent);
+	struct dentry *dentry = debugfs_start_creating(name, parent);
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
@@ -624,7 +625,7 @@ struct dentry *debugfs_create_automount(const char *name,
 					debugfs_automount_t f,
 					void *data)
 {
-	struct dentry *dentry = start_creating(name, parent);
+	struct dentry *dentry = debugfs_start_creating(name, parent);
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
@@ -687,7 +688,7 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 	if (!link)
 		return ERR_PTR(-ENOMEM);
 
-	dentry = start_creating(name, parent);
+	dentry = debugfs_start_creating(name, parent);
 	if (IS_ERR(dentry)) {
 		kfree(link);
 		return dentry;
-- 
2.50.0.107.gf914562f5916.dirty


