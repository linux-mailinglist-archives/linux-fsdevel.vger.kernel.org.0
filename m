Return-Path: <linux-fsdevel+bounces-62839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EFABA23E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 04:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BCD385C8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 02:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F641FCFEF;
	Fri, 26 Sep 2025 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="F+KEZcQH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MO+KYHoY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BB217996
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855036; cv=none; b=aWfT0904ALlLkGse6uUsyUCfyAg7yJaLZL8mHnHZK8ARmJTgjWSp4a68cn2HvODS4NZHq6qq2Ds2oGHv+VInorDtRzqjS/te3lgH+wQyQPNBM/c3b5jNsKnot/DSgop0Qbkn/tEInyYB4TvXZxL0Bq2NKB2dZ5Shu2t+xnSbhbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855036; c=relaxed/simple;
	bh=iMSQhOYSiQLJM2QbYl9qFisfBeSS7jsKIXSrtECzWA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rD5MrvvR3mPAhmu8MGc3b77OY7Ubk/XVxvJX5rljn7IQuvr0PdzmnV6yok2bgu3BOTWEslRjsvZ8xG/RTZix9fkQG2iT+8xADy854c1LITilMARVfzVp7dKFrc/FpdkLd4QB3JckJhncTCrqzdm4zkzp1AnCAYxidKeFTKto4SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=F+KEZcQH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MO+KYHoY; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 516F1EC00C3;
	Thu, 25 Sep 2025 22:50:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 25 Sep 2025 22:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1758855033;
	 x=1758941433; bh=PfPqWP/bhkM3qojrikkjCCHncRUAAp45waFVYFTjl00=; b=
	F+KEZcQHH8TbBy0l9FSI/Gg76mhO6OdJ+Ioi9mUNR4kgmkLj94hczj6C+s0Cz3X/
	PjRaninTFZ5GKKnvhOPDvxBW2c1jiDtCyFQtpaetkrrJFsA3Ln+QGgcQTFrKF/9c
	AZhfS8ww+Rrd5ikltSZm7hBKylHUH5/XQ7Y7akSAZKspd7bHnOjuQ9yq6EoEUvXl
	zIJzt5rTFL3k8j2SzemkukR30dp3Xf5vc8hRc1J/2fyggAwkTvoIFncupxkldaVG
	0Ng+eDuMxHtwk5bfIjaZprCFBOBRGlUlS2nLMQSqIZ2cO5o4UBgSws8iOG8Uc46M
	rXBDjId/m36b7cSLjZrPyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758855033; x=1758941433; bh=P
	fPqWP/bhkM3qojrikkjCCHncRUAAp45waFVYFTjl00=; b=MO+KYHoYq/V9q32Qj
	RKTI2ZNrjoR18fukgcZK0IhKg4im96hTxKGOilGhotLYwe7qP1nyd8SvN+wFY+KY
	Ruk6kwijeRrjw4Z850WcqjVyvzQd4V2yzoez2AGwMp/XmdUek4MzOd2seqlsVZal
	SZTs8I3T+KIJ7btWFUN9eVtzzwKu3r09hfZc8I/buA7WlpQ/V2UIITqQjWqwXfvb
	dCcgraES1gd/ILw1zCU6IgLXjQUtnPYqu1d8iNlB/pOFUW3lUDLJPQ1xHcXJ575S
	PnU+QzvJ/yJKa3EtH5Wd7PgdN9dXMal1csdpNmByqLzt9oXMiHAeE+NzZuFI4+Dp
	Zqe3A==
X-ME-Sender: <xms:eP_VaEJzCz84dJ2l0Sd9EggMQX-2BWsI1hQLOusIBNKh2ozRkm4VVg>
    <xme:eP_VaPF9dS34ITDJQqQSgvMB29jG0xSyh0nYyf7TIak2SqzGqzAIupS_juQkB3pze
    xosXcuIRTwUaSwSV7rFsXz6KWn0Jn-0mmh0Tuy5vk-x1JOoIA>
X-ME-Received: <xmr:eP_VaDucYRAwuYPH8mdGoX4W_3wnHKq43wtsjHbh1nQrASCYb2yLxWc__oOrRY8-v0Nodk3HghH40dxo8HOvePbgsozQ3ZkOUGp-tRXgP5Q0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeikedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:eP_VaGuLHtsWgMiHijX5TuGrsfqRB1EYC_9y0J0E9nIO7ivrkhlFyw>
    <xmx:eP_VaJBaK_mjp-FLfPnMxbxzo0q6Qovgp-JNwwkVzuTZInjMgZOVgw>
    <xmx:eP_VaINdQvZ4Sfp163quNLHsCJGyrH3shvQrrrH8oxRRsQPtP8g8og>
    <xmx:eP_VaCxXvpDqimRZrpS5ip0cUu1ZIHdhrS9xZEjHMbSa2eeS4K4qjw>
    <xmx:ef_VaDiIwRbAZtWCNMYRAwG4tG-dHc9PHU1wANXFaOpIQNhd-8B03ahY>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 22:50:30 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/11] debugfs: rename end_creating() to debugfs_end_creating()
Date: Fri, 26 Sep 2025 12:49:05 +1000
Message-ID: <20250926025015.1747294-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250926025015.1747294-1-neilb@ownmail.net>
References: <20250926025015.1747294-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

By not using the generic end_creating() name here we are free to use it
more globally for a more generic function.
This should have been done when start_creating() was renamed.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/debugfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 661a99a7dfbe..b863c8d0cbcd 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -411,7 +411,7 @@ static struct dentry *failed_creating(struct dentry *dentry)
 	return ERR_PTR(-ENOMEM);
 }
 
-static struct dentry *end_creating(struct dentry *dentry)
+static struct dentry *debugfs_end_creating(struct dentry *dentry)
 {
 	inode_unlock(d_inode(dentry->d_parent));
 	return dentry;
@@ -458,7 +458,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 
 	d_instantiate(dentry, inode);
 	fsnotify_create(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 
 struct dentry *debugfs_create_file_full(const char *name, umode_t mode,
@@ -605,7 +605,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	d_instantiate(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_dir);
 
@@ -652,7 +652,7 @@ struct dentry *debugfs_create_automount(const char *name,
 	d_instantiate(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 EXPORT_SYMBOL(debugfs_create_automount);
 
@@ -705,7 +705,7 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 	inode->i_op = &debugfs_symlink_inode_operations;
 	inode->i_link = link;
 	d_instantiate(dentry, inode);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_symlink);
 
-- 
2.50.0.107.gf914562f5916.dirty


