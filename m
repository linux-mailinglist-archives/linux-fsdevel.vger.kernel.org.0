Return-Path: <linux-fsdevel+bounces-67238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B81CC38898
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 01:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BE23B474B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 00:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284331DF99A;
	Thu,  6 Nov 2025 00:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Jc9akLQC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BJlCBmIn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6001613D521;
	Thu,  6 Nov 2025 00:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390452; cv=none; b=I6pkTPkt4sKuiynqnuXjkXxXsi6MT4i56TioGd4ArJY8H3DX5qzN2Y0aD3sYQdlf55WZr01j00sedKIz5kfLt6/I5pL2ONXR8kzsrCZmv/z3JDLRv8MNYHX0H3FSb69hdYJ2wUSZq5f22CNrzGThD8dQ8R+GLfxxOqYB0VZPs14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390452; c=relaxed/simple;
	bh=TAN7fEBHF6l6av49IjnjkWwi18U3z35Kj1YFqr+hndU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFFcvLfJnkiTPAOXgww7cT0f4+E6arnDedimPUqoKF1Sz7fOdfZMG+zxJVyCft7cXmL/g7qofx7BfQBpfztz2V7bolfABfsgFPLAwVnK4uKL766P16YjivbRFlIUpsUpMoVmGz/XlakNX7jZ2hlf5xZAIxZCB5G5yQni4zTL2II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Jc9akLQC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BJlCBmIn; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id A4EEF13005FD;
	Wed,  5 Nov 2025 19:54:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 05 Nov 2025 19:54:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1762390448;
	 x=1762397648; bh=ymZTXBnehovWBhFY5IZfw5DvNFPVLbASCb4gqoKTrXQ=; b=
	Jc9akLQC0Or25ytnK4JRKP7zpntMcu6FPkUSoJgIu0ANimz4dJiSS/pqFfeoz3hv
	LWzRwWcwUrufaf1p3lqjvEN99ylQa/DZW6bkPu4hkMMw59Sqc25jxzLi6aTH/JLy
	OrqFpwrjYVYBbz0aaQ2czGANrqrF1xOV7OLMn2J9e5svURccdN1kEOJ5Pj7TcDN/
	St8z9ZzAwBeAxlpPrBtXodjYCrNCEze3ldDtoXUebwNCXIiAIFcfSx+ALrpB0bc9
	NS5oUpMO+2qVrMXj+s3ucax2m4hFKoqRAInUaUJRFJKU3Ip161P4+AH1nxJHegj+
	qYqFKccZuMAuAZxqQzKK6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762390448; x=1762397648; bh=y
	mZTXBnehovWBhFY5IZfw5DvNFPVLbASCb4gqoKTrXQ=; b=BJlCBmInFk0SeBgfk
	cVSBeNN/bWjpx+3BaKOxKm7+wx2JNGW4Nkj8Bi4tXOpGz+WCExcUtVizq4vC9/uo
	Phet5mr6xCifpdQrK22d6LexUJqgt9QTYPmkCE7o1a2KXM29fVOJM5PU052/RZD5
	/Z54iHD82JVnpoc93XRX2o4zWe7DG+oaEYJrHXMc35wXJacuU5kVdlZCEa6yiFNb
	SOdAfAsOe9GLNvC339d2neezSm3u4PW3y3Zk6Sk6H6TFzq0UYB70wZd/C+wu5gtW
	SPQMQPmPlSFzYTLqPsEkOmJ0/ElNA6iIru+Bi5ztO5ev3jTZ2Rvzgvt3lE5ZDbZ4
	oB7ow==
X-ME-Sender: <xms:sPELaTnk1qyCDddWdE7YMrCFFh8EeNsE3CkQTdVh1hBIk1Z1I2hw8Q>
    <xme:sPELab4wGGipQhU9ljRGUi-QS140ns-R6ZTS2PNQ3dYBAq_C0r8LzImN9a641qq7B
    vIE-Kvr0WruAjvzxKmeEj5YeeaPeS8QHS8iVyPXlCSuByWrIg>
X-ME-Received: <xmr:sPELaWq6ZazY9beNEyhv4N5ZRHibCT94A0SN3JRPMFoo3NCDsFCNLwudNJokEpqUyePg0c02puGxCqbDsb8i0qpziW3qLbsuNgZcyXy08F8s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedtpdhmohguvgepshhmthhp
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
X-ME-Proxy: <xmx:sPELaZQ8sgcBk0ZiIjFE_Y0_QyuI7f38H-zw4nVH_jEQOehgPZCvKQ>
    <xmx:sPELaTVaUVWIKGl1UZcWFq4_M-ZUb2-GIwcsz2arVT3bU31ctv4bnw>
    <xmx:sPELaQAVaN0VwuMmTwgIj05U39JLBIW4bW26OeGf4vPvirrcy32tmg>
    <xmx:sPELaasFaACD6vSuMqRgzdWUO40n85MwsvDxJwO1eEYfRwO2rruC3A>
    <xmx:sPELaa8s54cAt8ehjEhjstrizhLAvCXU0sYMeYmWOkM31bYxxlbzCVIQ>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 19:53:57 -0500 (EST)
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
	linux-security-module@vger.kernel.org,	selinux@vger.kernel.org
Subject: [PATCH v5 01/14] debugfs: rename end_creating() to debugfs_end_creating()
Date: Thu,  6 Nov 2025 11:50:45 +1100
Message-ID: <20251106005333.956321-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251106005333.956321-1-neilb@ownmail.net>
References: <20251106005333.956321-1-neilb@ownmail.net>
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

For consistency, also rename failed_creating().

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/debugfs/inode.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 661a99a7dfbe..f241b9df642a 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -403,7 +403,7 @@ static struct dentry *debugfs_start_creating(const char *name,
 	return dentry;
 }
 
-static struct dentry *failed_creating(struct dentry *dentry)
+static struct dentry *debugfs_failed_creating(struct dentry *dentry)
 {
 	inode_unlock(d_inode(dentry->d_parent));
 	dput(dentry);
@@ -411,7 +411,7 @@ static struct dentry *failed_creating(struct dentry *dentry)
 	return ERR_PTR(-ENOMEM);
 }
 
-static struct dentry *end_creating(struct dentry *dentry)
+static struct dentry *debugfs_end_creating(struct dentry *dentry)
 {
 	inode_unlock(d_inode(dentry->d_parent));
 	return dentry;
@@ -435,7 +435,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 		return dentry;
 
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
-		failed_creating(dentry);
+		debugfs_failed_creating(dentry);
 		return ERR_PTR(-EPERM);
 	}
 
@@ -443,7 +443,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create file '%s'\n",
 		       name);
-		return failed_creating(dentry);
+		return debugfs_failed_creating(dentry);
 	}
 
 	inode->i_mode = mode;
@@ -458,7 +458,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 
 	d_instantiate(dentry, inode);
 	fsnotify_create(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 
 struct dentry *debugfs_create_file_full(const char *name, umode_t mode,
@@ -585,7 +585,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 		return dentry;
 
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
-		failed_creating(dentry);
+		debugfs_failed_creating(dentry);
 		return ERR_PTR(-EPERM);
 	}
 
@@ -593,7 +593,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create directory '%s'\n",
 		       name);
-		return failed_creating(dentry);
+		return debugfs_failed_creating(dentry);
 	}
 
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
@@ -605,7 +605,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	d_instantiate(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_dir);
 
@@ -632,7 +632,7 @@ struct dentry *debugfs_create_automount(const char *name,
 		return dentry;
 
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
-		failed_creating(dentry);
+		debugfs_failed_creating(dentry);
 		return ERR_PTR(-EPERM);
 	}
 
@@ -640,7 +640,7 @@ struct dentry *debugfs_create_automount(const char *name,
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create automount '%s'\n",
 		       name);
-		return failed_creating(dentry);
+		return debugfs_failed_creating(dentry);
 	}
 
 	make_empty_dir_inode(inode);
@@ -652,7 +652,7 @@ struct dentry *debugfs_create_automount(const char *name,
 	d_instantiate(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 EXPORT_SYMBOL(debugfs_create_automount);
 
@@ -699,13 +699,13 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 		pr_err("out of free dentries, can not create symlink '%s'\n",
 		       name);
 		kfree(link);
-		return failed_creating(dentry);
+		return debugfs_failed_creating(dentry);
 	}
 	inode->i_mode = S_IFLNK | S_IRWXUGO;
 	inode->i_op = &debugfs_symlink_inode_operations;
 	inode->i_link = link;
 	d_instantiate(dentry, inode);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_symlink);
 
-- 
2.50.0.107.gf914562f5916.dirty


