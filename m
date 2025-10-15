Return-Path: <linux-fsdevel+bounces-64179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 418EFBDC05A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 03:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14D23B01BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 01:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BA82FB985;
	Wed, 15 Oct 2025 01:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="xu5CG8GD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OSGPsy3D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CD02FABF9
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 01:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492908; cv=none; b=BKGeoQcYa6Blmj33kyr6+2KEyXt4/MID1TMCPglj6Xq0NjT6icKoRsniTQPLitpQ+Si6JQygGtmruuFygnKA2gG0JaX9YwJZG79/WtBpDhYE7iGS5lxcl0hcjujHAkpocZMjGGVG1Ioki7wNMKyUcFb819vYL85+Ougyo0K3VOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492908; c=relaxed/simple;
	bh=tb04WQEi6I93x3at26UIVoWMtyUVrz4OhK1KhxOSJhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUG+aoFmy0EWK+wLp12IihjeZ9YjGlByJsk5zBF7gZB6Vmld6mEjw2l58wbnmB2hzSIrypIncprU2lb/Bh1PquTXv4QAIr8Pbhbj5cqGQO8IGZXj07rTlqHLlesm4GvQJalmG3wy+wULKev62zA9or2J7dctZMZCgFvW7M0ylU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=xu5CG8GD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OSGPsy3D; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BCF8E14000A2;
	Tue, 14 Oct 2025 21:48:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 14 Oct 2025 21:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760492905;
	 x=1760579305; bh=SAsKm7IWlbtNaX8+pnOuAQHs2pi0ciU6MTi65sj4lRU=; b=
	xu5CG8GDB10/7jP9HfMj4tdoKTGP7Mv4C4oM0trvRYolYpOhUubqCkmWqscBU1Hk
	bVZ3T9oYEAjAbddCoHHFb4q4LzbY14HuAcQMOx0frLGXLnm+/1e5q+JBiGV+O78O
	i3JqftTpnO8xLTVyp3bWuDwTrNjmT3hKJuUN1BghmVw6dbvHWTjH+AQja5RV8jsT
	lyYVlY2qOjLSzutiS7Ib8zZJ6PIs9slue3TrBbVNeFJlc5t0M7vw5Wl7fAPXh3hl
	7zXOKidpCB2APoNgvpnFqrlJ322Uv5u2Ha7/SeA6J6fa9smep2XwpPD8AebcgCHS
	cdssNuMStb8LHvbcq78QDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760492905; x=1760579305; bh=S
	AsKm7IWlbtNaX8+pnOuAQHs2pi0ciU6MTi65sj4lRU=; b=OSGPsy3DLdh4suVtL
	lyxUmKNLuhxjlm8H5ORlFL3CiMVgdqiqZoDqZ+p/u0RIa6P4aGOOcNJJxD1qKE5B
	D11IHsZ+NMnVb+kW6oPE9Gstsru8NBO4doCt779RTJvX80g0dD2XQRIDro+aPp3e
	FDi2rmAs4Co9nTlonDk39BYe5jhjVrNoY4ke62gO2jKOllx3AkD8CcSbGawHqQZg
	7eRY9Wf6Jpf5EupAlSjIV2DeSk0eHOTaSddhK1nYk6ezsl4yv61dTxMUMZngeTMZ
	SFtD90L1NOdjf0Et9QlnUl1Zg/5tRbNYLYfcad2twVjQcQRAOT+ypHrX/6OOH+Db
	1zn7Q==
X-ME-Sender: <xms:af3uaORMJ-QbJW5Pv_XD1DIuy_EkixlPU41gME10rZ9x3mo8GS901Q>
    <xme:af3uaOuzMJ0wsSOOxnoZeR6GTSwz0wmH3PjoHnydVEaR7wC8Er3IkTcsR7bPv7y60
    9Nr_6uQBQcmyPKpUIQq3F3dHr5q-TG9LyO3A17-CQ2F_Aoa5dw>
X-ME-Received: <xmr:af3uaK0zDmSe4sEvi2uAQ-yIEEbY96S2CaJJmWx5BrYFBR1ET2PXT45vAU7gyIPbbEv-rqfabHxDVH5vs08bbGr5mtICkWw6ZHr8Tz05rJNe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvudefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:af3uaPVywwTpZ7Nminnh_d_jU04wh39eaPozolsy7dxlR5Xlv_8rUg>
    <xmx:af3uaFLsn_vubFaRZSITp38yADo5kVYgQZQa2l66n5MEEtncVBB9lA>
    <xmx:af3uaB25sFchgJffPrLWzec1Z9xJkvOSZre4_LCUUy-zSXtZUmubbw>
    <xmx:af3uaL6z_zDP7WzBZk_0MMm8GV_Ar5bCddKpcoLdWxBAlAizJiEJ6Q>
    <xmx:af3uaAoYp3z_zEPu6YJRalsEoO2grpWRaInwvQjrqRfRdFvvmnf9AIw0>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 21:48:23 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 03/14] VFS: tidy up do_unlinkat()
Date: Wed, 15 Oct 2025 12:46:55 +1100
Message-ID: <20251015014756.2073439-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251015014756.2073439-1-neilb@ownmail.net>
References: <20251015014756.2073439-1-neilb@ownmail.net>
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


