Return-Path: <linux-fsdevel+bounces-62363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476D9B8EF16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 06:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F533BC46E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 04:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE1C218AB0;
	Mon, 22 Sep 2025 04:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="CiRpUGIj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YL/h/Wim"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1452010EE
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 04:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758515627; cv=none; b=qcliguvzApF8ggm1eXRCSVu3T+Ioyes/KTIb02AzKfWKa3OLhmwPNOQk1d9Qt/MarWFqSYtdgWhwvyZHTDB9u9oHzmLtEHGr1WgZOC80aKX1rzx9KVoQxXPZUcw5F7nmRr0fGtvgIdN76tr32QYk8G1w4GzYukC/YRagiIdQ6Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758515627; c=relaxed/simple;
	bh=dorb3XkAnq3m+Ip/+8OPelvYCsN+wO6LGLRcQiaeqYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNJVg/eyJTTy4AyPg0eqeS/5YHfkcK46K8pl89uhuKnQw2GQbpK+H9J9L/ZRtZpSxIholTB2HkSks3a0QheAoijxp+iX2PntZx6fTtEeWspeIGHMpIP1v0WmwAjDBJchoqaf1y6aVIKbK8BRkFUJPS44Y3YWpNWud+lIyYDuu58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=CiRpUGIj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YL/h/Wim; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 83A8FEC008E;
	Mon, 22 Sep 2025 00:33:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 22 Sep 2025 00:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1758515625;
	 x=1758602025; bh=6iHRI8psVgHHTLvGUROVbKi9+7XOp6D150cYatnnwV8=; b=
	CiRpUGIjSbaneqDF8Vtkd34vQRXCiVexvq/yUAVxkPwVORNoYwekPF2L1INEO60t
	ek6cBpxmk6LehZ1Em57yYQEOvCOp2QAMP0Kc+gbn2lGRfg11wntPplrNMJzgBTm7
	OgwC3i2cIxdExQuvLacNevEhM7uz+6LmXWK429kOLQvdvchjpiLwtndekYc7dvW3
	y31A8OusgEe6TI+dWxKe7jbCb/QH6DOLC7xVoGeikKtUGYzWLWCpUVQwGuNjqPrx
	Kg1+LQHAsvj7KyzZTpV7VvYiAcAx6A4cIEZF+QUrB9RgrZqMXBkHrs7ldNGrDsHv
	1/laQyVpWYmGcNYS+XMmLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758515625; x=1758602025; bh=6
	iHRI8psVgHHTLvGUROVbKi9+7XOp6D150cYatnnwV8=; b=YL/h/WimQCu5cS3MX
	fIJF6VuA31qlXrezuWC0GZkrKxc4lSDj6qYVvrDg5EAOZ9DaEh4h9jEOlxJAV1Wh
	3c3Gq5tjv8hEfVC/vZpcA4+na+paDTX689p9uoJaZvOvDhShawhlXVwj239zJuWW
	JnN+38iWxQTGTLqJ2E8dA8YOmJ+Thf5NhwZzZ2qBjtKiTj9SHMBeMabuVTvAW3gB
	2b1+X22/aEJeqTze7M4dDK6jq7YUStI01eddyHg2butLlLpH/Z2KdHHY9LtkZ3g2
	zf25mKhRZZq5CSVCa9hn6ztxiOZppY5Fq68Pu4IX8iQwZnyuYqfThgAVL40E2xtV
	gqTTQ==
X-ME-Sender: <xms:qdHQaDHnqCEB9ps4QE7utFzwq2GyGxUuYA5_fFZJnHrzIAPsVnhqTw>
    <xme:qdHQaHvs1MEofANAiT0pyu8UAmT9QrYI4HJifRo8af-6__EmlbxM2cwczPGS-7LEm
    Vv7FcsbmZa5AA>
X-ME-Received: <xmr:qdHQaKs2UX4qAT4xPkbfbmAcNmYvBM8wK6OxbnTfMrM-Jcv9bu2l_T1aDwQz5hu3T25JoRqoKec8Mr6newYc8MBd5nJ1zXgiGek7OgA8nlfd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehieeltdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:qdHQaNDEmVpljO3J1_ZygUWhRJeIlNrbS9zXbCN3TRDznaBLGsetCg>
    <xmx:qdHQaMMauxiRU5UI0Jti34b-fiFMQ-qLZ6QR6XZdl4Ou3wE7jz_CKA>
    <xmx:qdHQaGxrLq8oyToh-J35QJn1-0qpYr0-snCJDJmuZw7iOWIiZJhnfw>
    <xmx:qdHQaMUkJE31aUHzHlZGd4QYflQl5k-IJ8ZbgNtkfEV7hpr0OtvtXQ>
    <xmx:qdHQaH8-eIg97JX676sCwZgT7dEzVuWIdi0qIadvU5DbALy4rEEIScoI>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 00:33:43 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 6/6] debugfs: rename start_creating() to debugfs_start_creating()
Date: Mon, 22 Sep 2025 14:29:53 +1000
Message-ID: <20250922043121.193821-7-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250922043121.193821-1-neilb@ownmail.net>
References: <20250922043121.193821-1-neilb@ownmail.net>
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


