Return-Path: <linux-fsdevel+bounces-65035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0979DBF9FEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 06:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A01564A9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 04:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742DD2E090C;
	Wed, 22 Oct 2025 04:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="S6/r6pB8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NfciAuuJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AA02E091C
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 04:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108447; cv=none; b=W32c6mbvnbz7PnEsImXakVVPCmlICi2NIE3FXJEyuxjo7IZvknqBb4l16t8DnOsV5pl4v/KBbsRM8DoBW39f0ypSE/uzINQNgaEU5wBYVv3DE4si1/bUqmY7H+4qBL+/yZLpvXvpQP3iQX/fmcjIXcEJ0mRxkJCfkAQmrHtVzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108447; c=relaxed/simple;
	bh=oVS+h5r0DK/yL/nJuSoEVwkYmXX5izACS08ItM8n8P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k25yv9R4jQ64zD9d702VXc4c7QPefmLcdksi+nMCcSU7o88B5IwRQGTIRA4dfRUI28IGmwrLQY4doCDxvcY0ksuLauDetJE34qIeaIXowJWkbWpb8C3w8MTTU4iT6GwJivretoRR1PnK+Nk+t3zvxqZOVPPDiQbOt5cYPthvUS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=S6/r6pB8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NfciAuuJ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 225B11400131;
	Wed, 22 Oct 2025 00:47:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 22 Oct 2025 00:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761108445;
	 x=1761194845; bh=bd+J28EpkqsL+J3nsCE3KaLQTbVtAeBoRgW0o7OZd6Q=; b=
	S6/r6pB8e8tpE2H3qH48mUEIg86OkI3xXG7t0PlK5kqSj9Iw4c/wAiSV18CJrjNS
	S8ubaFgMXyWP7ULpTz+cPypqWDbc0AqacVgsPcdvJ4L5p1ANttafVjq+WgsjOIbs
	VMTuZh9xHgo3TX34BHqDRISpfnRvXvVydfc4f7M97wwwZ3jihCVh0fX//g6wlCDw
	tceUoIjNzx/jV0aZzCysoy7CO4b2I24ZN2I7Hp8VrTB9F+my3HbU3BOEmQERCw/o
	Bwtf1JtXrbIEdoPQTOlIlY5RTHORZ0Ne0WahwmmrP1uTDAI+o8nhOIinHo86LUEq
	AvPHKMQjRuVeWQtsSUASlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761108445; x=1761194845; bh=b
	d+J28EpkqsL+J3nsCE3KaLQTbVtAeBoRgW0o7OZd6Q=; b=NfciAuuJ9A5Y9IeYw
	bhSkYek9PsnHMUQRkSYTpryOX9Pvu813JiftlmlOV4EKA+0nl8bKPgtkA2bmzW9Z
	mhBUZ9o+zjfaNxHE1BLdAPHOqEzuK/W2sf3NqEOnaYDguyHB2sbAm995khfImpTy
	blTUMmgsTCts4eCvoSl5MqJwXvcdLbB8nkyi8NCz8Gntv0YENSorowiJOUmbS/le
	yLho0r1VAUKwkTo5iVz0rM+fWrXFG7rWSXvW0T6MkX2g0mZu7f3AkA63hrVyOLpg
	cDKue3WigcizhqlXJgVfJTy14T/HiPcJyWecRsH1YSc/YQLu8VPEjq4AbbmD1h09
	ac80g==
X-ME-Sender: <xms:3GH4aGAQHEbkC-cF15zHpDvHld4rYZ_FCx70Xg9APuVm_qT2JruXWw>
    <xme:3GH4aLdXWfgQrbzf_XYNlD7suNjEwjoMWd2Svwiq8rjCwcGI9DlubHD7X97r-aVGZ
    k_nDRZ-fl0b_gE-pNelIT40Ih-sRU8nxQkj6xAkfG0b1DIfJcc>
X-ME-Received: <xmr:3GH4aIk5lZ98-nhpxdwXc4y7k72UDhx20Sb4yV99GDgH1sAuEM-4brTzBsCgb06cQ-jysu3N4pEtjgb6sNswlzY_WMkNz04gr_SzXnzmhkAR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:3GH4aKGZVNsw85XWOxyY6VIjy6r7CJFI2_D7MeNwIW32G9J_yKt9_w>
    <xmx:3GH4aI7ru46T1Lda21eUVDjvk3N1fM5llG1AQe23Is3LlJ2sXWh94g>
    <xmx:3GH4aKlNPHWtbJUWseSu1HptItZIadgnFKlXkD5_trF82jVN8bdMJg>
    <xmx:3GH4aFq784XKbhJFr7x6O2-myne3v3Uv3iUGvzz5J-0tW_yNfUul1w>
    <xmx:3WH4aCYxZCI6SG3a9vysQvmwIfvaYpypXKE7Ms1XES77CwUf7NZgWszF>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 00:47:22 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 03/14] VFS: tidy up do_unlinkat()
Date: Wed, 22 Oct 2025 15:41:37 +1100
Message-ID: <20251022044545.893630-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251022044545.893630-1-neilb@ownmail.net>
References: <20251022044545.893630-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

The simplification of locking in the previous patch opens up some room
for tidying up do_unlinkat()

- change all "exit" labels to describe what will happen at the label.
- always goto an exit label on an error - unwrap the "if (!IS_ERR())" branch.
- Move the "slashes" handing inline, but mark it as unlikely()
- simplify use of the "inode" variable - we no longer need to test for NULL.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 55 ++++++++++++++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3618efd4bcaa..9effaad115d9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4755,65 +4755,62 @@ int do_unlinkat(int dfd, struct filename *name)
 	struct path path;
 	struct qstr last;
 	int type;
-	struct inode *inode = NULL;
+	struct inode *inode;
 	struct inode *delegated_inode = NULL;
 	unsigned int lookup_flags = 0;
 retry:
 	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
-		goto exit1;
+		goto exit_putname;
 
 	error = -EISDIR;
 	if (type != LAST_NORM)
-		goto exit2;
+		goto exit_path_put;
 
 	error = mnt_want_write(path.mnt);
 	if (error)
-		goto exit2;
+		goto exit_path_put;
 retry_deleg:
 	dentry = start_dirop(path.dentry, &last, lookup_flags);
 	error = PTR_ERR(dentry);
-	if (!IS_ERR(dentry)) {
+	if (IS_ERR(dentry))
+		goto exit_drop_write;
 
-		/* Why not before? Because we want correct error value */
-		if (last.name[last.len])
-			goto slashes;
-		inode = dentry->d_inode;
-		ihold(inode);
-		error = security_path_unlink(&path, dentry);
-		if (error)
-			goto exit3;
-		error = vfs_unlink(mnt_idmap(path.mnt), path.dentry->d_inode,
-				   dentry, &delegated_inode);
-exit3:
+	/* Why not before? Because we want correct error value */
+	if (unlikely(last.name[last.len])) {
+		if (d_is_dir(dentry))
+			error = -EISDIR;
+		else
+			error = -ENOTDIR;
 		end_dirop(dentry);
+		goto exit_drop_write;
 	}
-	if (inode)
-		iput(inode);	/* truncate the inode here */
-	inode = NULL;
+	inode = dentry->d_inode;
+	ihold(inode);
+	error = security_path_unlink(&path, dentry);
+	if (error)
+		goto exit_end_dirop;
+	error = vfs_unlink(mnt_idmap(path.mnt), path.dentry->d_inode,
+			   dentry, &delegated_inode);
+exit_end_dirop:
+	end_dirop(dentry);
+	iput(inode);	/* truncate the inode here */
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
 	}
+exit_drop_write:
 	mnt_drop_write(path.mnt);
-exit2:
+exit_path_put:
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
-		inode = NULL;
 		goto retry;
 	}
-exit1:
+exit_putname:
 	putname(name);
 	return error;
-
-slashes:
-	if (d_is_dir(dentry))
-		error = -EISDIR;
-	else
-		error = -ENOTDIR;
-	goto exit3;
 }
 
 SYSCALL_DEFINE3(unlinkat, int, dfd, const char __user *, pathname, int, flag)
-- 
2.50.0.107.gf914562f5916.dirty


