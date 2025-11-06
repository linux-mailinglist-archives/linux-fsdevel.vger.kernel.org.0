Return-Path: <linux-fsdevel+bounces-67240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69467C388E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 01:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AED3B7303
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 00:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27801E9B35;
	Thu,  6 Nov 2025 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ayE02s+m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OydEuUfA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5F1DBB3A;
	Thu,  6 Nov 2025 00:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390479; cv=none; b=eOzbJJn4OLM6+m/8o+hyI52VLN50cSD4nA5pPB6aNB64yZkSX1mHIarQyDPBUesrTBE2f5REteQXR6Tem0i2G2IlUq2yXVuZX2kuCuW5KZak7yw2vjn3pA6CQMW1xT8Y6rrrGWs9Zw41YsSFOLy+TkpirmLGiXCmh2qzT/QTUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390479; c=relaxed/simple;
	bh=pwwf2eZdH4paX+NVy07huwl2ixfz7Y09Pw2z2VdPEEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMNnZ7EGktcVwJ169zCEJMT2rB/TnC9qo22VV0xoUGErvmtAutZZpSDAl9ff2EazDZrgpWaCWISdLFnLU18Y2HfiFhX//7yf9x5jv6/PGfvn75KgBlodmDBNZmECi1rGtdF9TBi3uy5gQ5eR49q2Y74g1ZDcXdJG1kxiBxtJC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ayE02s+m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OydEuUfA; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 8D33C13005D8;
	Wed,  5 Nov 2025 19:54:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 05 Nov 2025 19:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1762390476;
	 x=1762397676; bh=eEhtPf3j1g85S+RHaSaC+a31yH7FYFSWk8gUwaN1ev4=; b=
	ayE02s+msFGbE6i4ybqvPgcbvFKuP5wIxzua7i3y2LKfRqSjHKCjwh+ZH9h21ek8
	TGG16dsuQZaKa7bhJK09AR8/VnbQqcfPomyf1OaP1jo/CjHCexaNq1StmTk9FtIg
	FNJ5tTIB3d2SD4hzuS3lH4d/4KwU6xq1tLmNyx/iwW4+KL18yIru46G/lp6oTW2X
	gbmXw6bcjUApTnOu/KxYm7o0LnSAM50nD+a63N5koC7GeqcUDgpCD503WXbDXVSO
	00qL+jEaTdlcT0cLoMv3iEOKWhO/KkRddlEUnCZqiSTr8P9ulYFzpGfcdlxrF4l/
	8BcMuIwJ1WeffIRRSwnr2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762390476; x=1762397676; bh=e
	EhtPf3j1g85S+RHaSaC+a31yH7FYFSWk8gUwaN1ev4=; b=OydEuUfA7IoXargGe
	Um4XRwzaRw/sm0PhnazdaXDhIKIL8ZtljGOX71d6cIR26jrOnvdn93Hq2DTBFXjt
	pSkRwCvV268HapLonlV6QdKEjvkAaj9/twWjiPZWBNivbGvVHkuPVnwI4ldbLjvb
	oUj1cMKNvG7Xeji8+kYto66WSPrr97l9JVdksdSOu6Mc6bCZvMJANO3k/qPUTsyo
	8Jx+6gp9Ax60iLcM2FHtKYowSteaHjHfaSu1xfCMbGINd9LORV8+MBwMwOHd+wZk
	mIx7KEwS4QOd/AYji8oLPGd+eBAsu3tEm1nmD4EkD99Jh7nckam5geJjxJnTLg+V
	fSkTg==
X-ME-Sender: <xms:y_ELaeGJahAAKrH1-M1V_z0XuNSSmwL9eW9MjOyUIAUQRcf-syir9A>
    <xme:y_ELaUapqttVoz7KwDn-z4S-dCUUN1EFpslPgzJ8zRsBYMkwdYH27yKwD5OU98f1v
    lpzY9DcvUbz4I2ifoWfwoADRBRdheY7vS91KEiDDCWBvpBL1w>
X-ME-Received: <xmr:y_ELaVI8bYf6_5OWXLTT7ux0jEycCbuoPGjkHvjaaOPKMeyv66CZQKtbA7dJ32uoQ_zQp6oBcsXtDUb9bF2shy-3hAR2CQyvizmHaHzPZK1F>
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
X-ME-Proxy: <xmx:y_ELaVz8evo_d045GB_MPuohsUVNNf_3LiUkn-Fd-Vb5RzvBskryDg>
    <xmx:y_ELaV2yeE0Uq0a4fdd3We7Yu709FuG6kuCRFU8tEOI2C18iwUCGAA>
    <xmx:y_ELaQiOPNQYR1pSmjs-NPsu4hRlAz0Q7VDUYBGmecSCKKPDGZHDzw>
    <xmx:y_ELaRO-_ID0BQBs7rlzKK_aIfxj36cCs_ZLCeuHrzKXtx6S0H5tbg>
    <xmx:zPELabcUr5BPZw2sDMekJO11IOz-SsPJZuCXCa_YucPWWzjVWv5xnzZb>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 19:54:25 -0500 (EST)
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
Subject: [PATCH v5 03/14] VFS: tidy up do_unlinkat()
Date: Thu,  6 Nov 2025 11:50:47 +1100
Message-ID: <20251106005333.956321-4-neilb@ownmail.net>
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
index 231e1ffd4b8d..93c5fce2d814 100644
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


