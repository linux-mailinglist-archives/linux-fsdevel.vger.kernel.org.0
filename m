Return-Path: <linux-fsdevel+bounces-66389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C13C1DB9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 00:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051501890BE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 23:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC7919995E;
	Wed, 29 Oct 2025 23:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="YUeSnern";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ffyA31nR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB7C320CBB;
	Wed, 29 Oct 2025 23:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781517; cv=none; b=TuWumy6tORXb7818foSkkls3Rs0CZwm8tdDr1zDn2G/gozq4O25vZjg0tc/RnaipRTIq3jD7Df7SO1Icd1oCysbXURI/qLq+sNLUWsHhvI+PAjWz1q9laFkqRTLFCCJU+YU4C7v45+zeCRaG2c44mUK3qwcTD5BUUOWK34g+Cgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781517; c=relaxed/simple;
	bh=oVS+h5r0DK/yL/nJuSoEVwkYmXX5izACS08ItM8n8P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ubck5AuogjROC2hnbXRE0eEN+aa6JqIai0OZ5l3DW5SqpWyY/IIRuKWYeJvfRklmCM80equHR/JqgzFh5wowNsLbA3oJbTXCjqVAdET6rUT+rLvhGfkJU8t3hEE5C1AsegORmDdAAetbVkSU+FZskkegYEhBjmYn8pk9J0txkNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=YUeSnern; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ffyA31nR; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 0C71B1300228;
	Wed, 29 Oct 2025 19:45:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 29 Oct 2025 19:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1761781513;
	 x=1761788713; bh=bd+J28EpkqsL+J3nsCE3KaLQTbVtAeBoRgW0o7OZd6Q=; b=
	YUeSnernCnh+2nQr8CxjtEzQZY0jFVgVVRGble88W+44mPbvXoihllhMI4v2ZhrO
	qWIvo68KBBp7gXV/XJ3FMwLmf2gSawuYU2HCgKzLX59vbxkyJ5wLTDnYe5pE/U8S
	acHMznQs4pMz31cXOemU1qEh+d+KV1xN1qDW3pfb6nfaSAQy2hsZKJvpymyaobVB
	G3yFNZcRR7mN40Ihb2v/2V+thBZ+EpfoF0MwYfcI8hlndKtaKtuV8O878QLi2i0X
	KzcZ2NCXWazgVUuCbthENAD/+lJxGVT9lDMFCkaVYGT/1wDgk9+/iWqpRkpOYbfY
	JIJEGP5KHvCBIQjT1Lkstg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761781513; x=1761788713; bh=b
	d+J28EpkqsL+J3nsCE3KaLQTbVtAeBoRgW0o7OZd6Q=; b=ffyA31nRBEIf8hr/d
	VTpNvZr1DY/UoCijvjV+GM9VeBh3RGMwjqzIlOEFj9/Mor9hNUmemf3z2V4dSViO
	9glt7i0ZDNoVjfSuDrhH0P8qjfHwqg4nv9GTxGPaySGSsybNrEP7e4MlVEFasNfy
	VI6OZnJypxCAJ/TaWuvf32NX3PIXM1hzmOHDbFd38k2/ePpSLkizb5LQRFW7ey1k
	4G6Mk7LA6ryoVMpDyZRed7xdO1qbP2ZQhOKkmpMzSWeqoncqxLp+mWjuYzIdTjf8
	lGR8/3yyXKUCwTnV/qPd+tUlUAYU+wBWobyNoax5mLfvT9pzAv/w8VzRenNwBCVx
	Bapnw==
X-ME-Sender: <xms:CacCaSN00cLSQBoqQgSdFpnLrX0Sw4ZRRQuq6DRXTtVoXBfK7cfrLA>
    <xme:CacCaT1HVXpEkYuUwX9Mj3gi2c3hC2k-FETR7PZ7u9IOTsFedjK1OCKVEDkpvb163
    RQtRxYw-MYcpP9Vvzk2IR609dmWwAnJEUXHZy9hOEEC0ydgPw>
X-ME-Received: <xmr:CacCaaHC_yd1MaN3VZH2FOEkq8YL27j67LCKens0HX0VZVUKgGZfdBGXka0y_j_YkOXdviq2xM34wyTHKqVcC2p2m9d3MFidD2DuKCyKLbWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieehtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:CacCaUha6wx_DtWI4PUF1bXbYiP0fj-T5EyvKnFfFlaqa8Vj_MT62A>
    <xmx:CacCaYZTnzrj5fIHYQBwZe8671Y23pQJGWlh0Gf4tJSECPFQ6hFoPQ>
    <xmx:CacCaZ320F0pkCKkY9pYfZXjCqUVdgSWiOYRVaataOzuQTyF0_P7WA>
    <xmx:CacCabxFdfyGdM9M_ueb3W1gZxRDekqXOdEGs-7tZqPzJoXunflhgw>
    <xmx:CacCaV0mWGjMcDY2QkUwdM0BBI2wiL7qs6rVwucAVZgPUJooIAdE7M0z>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 19:45:03 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>,	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,	Dai Ngo <Dai.Ngo@oracle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>,	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,	ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org,	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,	linux-xfs@vger.kernel.org,
	apparmor@lists.ubuntu.com,	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v4 03/14] VFS: tidy up do_unlinkat()
Date: Thu, 30 Oct 2025 10:31:03 +1100
Message-ID: <20251029234353.1321957-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251029234353.1321957-1-neilb@ownmail.net>
References: <20251029234353.1321957-1-neilb@ownmail.net>
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


