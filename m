Return-Path: <linux-fsdevel+bounces-68127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43603C54F48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 01:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BAA0734A539
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 00:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB90D1E3DED;
	Thu, 13 Nov 2025 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="BFMEuzCV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cg4wtkWj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B67E1547EE;
	Thu, 13 Nov 2025 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994425; cv=none; b=Hp3IazfVhEZZaE9UTjJTivONjAAS2AESaHNXxqfgjXBGIyHJBevVbT+GRrtOvqoekZoyfeOMulhZH2UonrpWjRTtvALSAgTsvhg4D8uZPTyl/b2V2L9e82RYzuv53bcKVkuTdubtiBlkLMH7mgPHo2D+UHDVRaxoohGM7EQJqbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994425; c=relaxed/simple;
	bh=yztetP9ZaDLHnyfdQEv73H2bxz9Hdt+EsOyz787jXmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhmeEatLVeKvxY2DqK0WtJW4gtHNQePxl9eKBBinzsAJqyQCKzsj0Xmmys6iIhQczzRNVjLtiKk36sHq8mflEPCm8boBGQEXrM3nVzaMEcrRPYacFElG3yuv2xJTD4W5guUoY9dahEJv7sbcZeTPJT+zcwSancSizRpNYaNz+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=BFMEuzCV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cg4wtkWj; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 2A8DE13000C2;
	Wed, 12 Nov 2025 19:40:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 12 Nov 2025 19:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1762994421;
	 x=1763001621; bh=uEkzPpv4qpG0oSRrio394roBppQWXWpenmZoEGmtDOU=; b=
	BFMEuzCVy+uRVDIswxV1cl9wFjBjdRfK88VTsoHhWVxJJa7dj6mBp/sjc337n2Zl
	V427W2kpCtRACw+wQwkcenCu6cKRlu+swnnkR9uWUtsEf+0AE34hEzkLR8yOXdCU
	VyPvmmyGjm1xxR6F/j4FsJ3yyPaZeqBO8AEC3Hcsxrh8Ox5T0OVj7r4k8lF4wHSk
	WGRwL4haJ9bBWDHOfp3zXpyyW6O24nCUAflXwsU7+X3gjA9Yd6VSfLQR5E527a7h
	dyzmtLZCOgCH3FMsn4ieRNw0sFjDECLLFV2qkTnx5uoYpdjM4b+kt6BaTPYczTbC
	U6nGkTNj2H+mkY03Bqk+OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762994421; x=1763001621; bh=u
	EkzPpv4qpG0oSRrio394roBppQWXWpenmZoEGmtDOU=; b=cg4wtkWjUhgYXij2g
	NIZpXMKcM5ocUVK1Pb5lbCKuKwzdzMjmM2CPZst3ARQhwNlA4YdR4Smq7JGAybsQ
	avmn7M0FrUi7mWAImA1yC1gc/vWBp1c2VOtTMO8Y8mf+5pgfQidQTaLdTvf/FmNH
	Fheo/IchYtIn/vFbDm4VnR7MBoUHQteD8TExU2RNhxy9FBJcj4xxMTydNcg4xszT
	DkTak93m9TOL8pcyc6m8dEc2f+0+UuMQX9gunXn8Dn7T9qwGN7u8tUcGJec7GHmw
	exaC4nWv6D8xg1Le435adw9QYcw1ARY43ZVkgO59ea6kElAFFeDo9hoixSuHKYk/
	efmKg==
X-ME-Sender: <xms:9CgVaUF0_sy3jZN6aj2jMTaLhHY6rOAPIOjs-KfuiZka5jfeFgVRdA>
    <xme:9CgVaSa0t1tZwVM6cFkfvLkoL74O5LwwbSW53EQ3GEspGw0M_Ka8Vr9Cvfa-drTPP
    z-ixBKet1WM_JxXJIXpgOq0SXY-LFGANLBGsKrsL-Eg7AHasw>
X-ME-Received: <xmr:9CgVabIdQAvp5CvzigMcrDB33uq4xot-9gaQsjuI5nf2v42Ugdm4iNvRO_cRMXDGd84zitpe46XfIy492gaiI9XCYb2vRpuyV3IAIcQIcUQC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:9CgVaTwyQZaRrJd2bEGRONB9QH_P3zSYYi9vJsoIlER0vTzv5uQ-Pw>
    <xmx:9CgVab3ixJ9T4MkTyM9aU1OsL5xB-C9IwItNn2TRAWieuugE6vMxFw>
    <xmx:9CgVaehmoyrhBtvQMCgdenN6MRe_onfMLdcHOzz1mA8J1tuAXfiXEg>
    <xmx:9CgVaXNVIODmtcdBsjx9sjEr8RKNf2SyHGzaWrQv-331CnKVgEdEmw>
    <xmx:9SgVaWHupMzfLmsMvJJ2tvbWJi_SnHDFv8U6kIjnalOnwmcN5WGP037M>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 19:40:10 -0500 (EST)
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
Subject: [PATCH v6 03/15] VFS: tidy up do_unlinkat()
Date: Thu, 13 Nov 2025 11:18:26 +1100
Message-ID: <20251113002050.676694-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251113002050.676694-1-neilb@ownmail.net>
References: <20251113002050.676694-1-neilb@ownmail.net>
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


