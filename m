Return-Path: <linux-fsdevel+bounces-77894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Av3I26qm2mb4QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:16:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1A417136A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25B52304A894
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5946C13959D;
	Mon, 23 Feb 2026 01:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="iYdk9m3J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AEzioooi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E87125487B;
	Mon, 23 Feb 2026 01:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771809261; cv=none; b=HpkbVZkuJ5ihGLpw6EmKKSeiVfLH/leNU8LrG6oIr4sl6btDnGRfm2F+/+AAXWUo6sYvUmvwWnDfqJ0/Snlu5FfudGJhY16MRL8eBzT/qOehdJuWEy/V0JUDWPi39kjYIosHlTMz3g2Fie26H8LM7A1KJI8zbkgs61xULjQeAbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771809261; c=relaxed/simple;
	bh=4uJ43gCR+R+5739+KuOB3jGnEHFLI7d72qp5ShsDOL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuRTC5ElyCblspKUChBk37veAMBbAFTg0FhTn33RRIe+Fz7ugQSDCPtq6KHZEFAmJXpYS4t+bY8ZMp8HqjYchcxdq6N82rbGAvYYtbOPO/w4fe3bIayLFpSACYinewXjWTEU09LGFWszLtboe3+WyKSb9st7M97SC5kw2PYAxv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=iYdk9m3J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AEzioooi; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 9CDB513807AC;
	Sun, 22 Feb 2026 20:14:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 22 Feb 2026 20:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771809258;
	 x=1771816458; bh=xzd8MRLrq+miwzpwYsGD1K87iUt7Jqp/guhVUroV3xQ=; b=
	iYdk9m3J++Dx+2BhMPIbfv2krZP6VsVd09GMgAefl5IqqypjXj/2QZTHKozcq9Xx
	YDYrs28SyFLHzBqfsD32i0jOfh9WMs12SF2zolYnbxNDPpekMX0hXxxZuJemRkyp
	ev1Pqd8WlzOSGDZ1XzoNJfjai9S/F3/HMQ7hn8NXTV/QbNAHfIp/YOk6zNecdM4j
	/IYJGWRpqaQ/S3Wiwn7UMOh8UI/Rc5A+X/zRD4AQSS2FUS1GJnv+q212ISM55SKo
	LGrmQasiARQANbZhnXORrwm6ex0fNnpXxzUAmVtyDaqsf8jtzftjH2+FYSuSR9sq
	sbF+Fz6P+LCnSXdabHOx3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771809258; x=1771816458; bh=x
	zd8MRLrq+miwzpwYsGD1K87iUt7Jqp/guhVUroV3xQ=; b=AEzioooie+jC9Ln6a
	NXbS7RGHDgVxyQKkvatk2J9tOj/JVRJgRCm9FBvY+IEhQOlsg0G2wcNCLujByfVF
	U0aE5Esy5s6lBzHDg1iJp7UFBJpf6GJ26jv6oeMI7DVri/2pJ5O2TIeODAa7/3Pq
	FbFN0V6PfBFjrFnM9oYurlk8OqkDY8luqzbTCfA+/riqoEml4k+d8ASkw0A1a+Vh
	P/Z6Qw55tYIAQQaI35ie3ayQ/yEjkl0A0WRskWlIPGd489dppZmhojMs8BdeSKIX
	XaStM5lYwRA+DfDuczRkTA/PEVeAcgSGNrORn83iBPosIFNzqTpVLJxdULXIbXxh
	aOrNg==
X-ME-Sender: <xms:6qmbabe6xjbahTEWYrFyudsLjZ6ngQ9LsE4ELQdaXfS6Bgixc5NboA>
    <xme:6qmbaVIxPH_alkxLJrGSVh6F2XVlPiT425iCqLDGVnSd2-AReer7y2rkuhSTVi83Z
    IHXEzrHeGbTuFY6TZUewvjPysYB-OvuwaHOQKc82I6EXyua9A>
X-ME-Received: <xmr:6qmbadDrRR30X_N2P8xC4iuXA701ccJF_6bk7VDpLeWC70mxB46XWh4xd6LMEZaYkVZM5rzONeKiJeqkBIeEg0VxxdIJR7RpFwh_aNlvufuv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhr
    tghpthhtohepjhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:6qmbaWhYPn7jFF8YR_WoC-g5Zs2yULhQR6sOmlhiEUnv6stRisAh7g>
    <xmx:6qmbafNmoULUddBF724_Br4t7PDngjIXJd9xWPD3UNly4Uv5yiD9zA>
    <xmx:6qmbaVY5hAKF3X-nrGKSYW8B4W9_nsy7p2f0naAFAoI6sL82cBZJXg>
    <xmx:6qmbac_TCJ0jsJBdkcfZH6ynGPuJVmANg1E2mUdqSTGLX96gILiFnQ>
    <xmx:6qmbacnb0E6H9Ytk_BY5x02aD8lTseYNFbI_kislTO6lC2B-l1UcG1eB>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 20:14:12 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Howells <dhowells@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v2 12/15] ovl: change ovl_create_real() to get a new lock when re-opening created file.
Date: Mon, 23 Feb 2026 12:06:27 +1100
Message-ID: <20260223011210.3853517-13-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260223011210.3853517-1-neilb@ownmail.net>
References: <20260223011210.3853517-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-77894-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,brown.name:replyto,brown.name:email,ownmail.net:mid,ownmail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 0F1A417136A
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

When ovl_create_real() is used to create a file on the upper filesystem
it needs to return the resulting dentry - positive and hashed.
It is usually the case the that dentry passed to the create function
(e.g.  vfs_create()) will be suitable but this is not guaranteed.  The
filesystem may unhash that dentry forcing a repeat lookup next time the
name is wanted.

So ovl_create_real() must be (and is) aware of this and prepared to
perform that lookup to get a hash positive dentry.

This is currently done under that same directory lock that provided
exclusion for the create.  Proposed changes to locking will make this
not possible - as the name, rather than the directory, will be locked.
The new APIs provided for lookup and locking do not and cannot support
this pattern.

The lock isn't needed.  ovl_create_real() can drop the lock and then get
a new lock for the lookup - then check that the lookup returned the
correct inode.  In a well-behaved configuration where the upper
filesystem is not being modified by a third party, this will always work
reliably, and if there are separate modification it will fail cleanly.

So change ovl_create_real() to drop the lock and call
ovl_start_creating_upper() to find the correct dentry.  Note that
start_creating doesn't fail if the name already exists.

The lookup previously used the name from newdentry which was guaranteed
to be stable because the parent directory was locked.  As we now drop
the lock we lose that guarantee.  As newdentry is unhashed it is
unlikely for the name to change, but safest not to depend on that.  So
the expected name is now passed in to ovl_create_real() and that is
used.

This removes the only remaining use of ovl_lookup_upper, so it is
removed.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c       | 36 ++++++++++++++++++++++++------------
 fs/overlayfs/overlayfs.h |  8 +-------
 fs/overlayfs/super.c     |  1 +
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index c4feb89ad1e3..6285069ccc59 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -159,7 +159,8 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
 }
 
 struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent,
-			       struct dentry *newdentry, struct ovl_cattr *attr)
+			       struct dentry *newdentry, struct qstr *qname,
+			       struct ovl_cattr *attr)
 {
 	struct inode *dir = parent->d_inode;
 	int err;
@@ -221,19 +222,29 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent,
 		struct dentry *d;
 		/*
 		 * Some filesystems (i.e. casefolded) may return an unhashed
-		 * negative dentry from the ovl_lookup_upper() call before
+		 * negative dentry from the ovl_start_creating_upper() call before
 		 * ovl_create_real().
 		 * In that case, lookup again after making the newdentry
 		 * positive, so ovl_create_upper() always returns a hashed
-		 * positive dentry.
+		 * positive dentry.  We lookup using qname which should be
+		 * the same name as newentry, but is certain not to change.
+		 * As we have to drop the lock before the lookup a race
+		 * could result in a lookup failure.  In that case we return
+		 * an error.
 		 */
-		d = ovl_lookup_upper(ofs, newdentry->d_name.name, parent,
-				     newdentry->d_name.len);
-		dput(newdentry);
-		if (IS_ERR_OR_NULL(d))
+		end_creating_keep(newdentry);
+		d = ovl_start_creating_upper(ofs, parent, qname);
+
+		if (IS_ERR_OR_NULL(d)) {
 			err = d ? PTR_ERR(d) : -ENOENT;
-		else
+		} else if (d->d_inode != newdentry->d_inode) {
+			err = -EIO;
+			dput(newdentry);
+		} else {
+			dput(newdentry);
 			return d;
+		}
+		return ERR_PTR(err);
 	}
 out:
 	if (err) {
@@ -252,7 +263,7 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 	ret = ovl_start_creating_temp(ofs, workdir, name);
 	if (IS_ERR(ret))
 		return ret;
-	ret = ovl_create_real(ofs, workdir, ret, attr);
+	ret = ovl_create_real(ofs, workdir, ret, &QSTR(name), attr);
 	return end_creating_keep(ret);
 }
 
@@ -352,14 +363,15 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
 	struct dentry *newdentry;
+	struct qstr qname = QSTR_LEN(dentry->d_name.name,
+				     dentry->d_name.len);
 	int err;
 
 	newdentry = ovl_start_creating_upper(ofs, upperdir,
-					     &QSTR_LEN(dentry->d_name.name,
-						       dentry->d_name.len));
+					     &qname);
 	if (IS_ERR(newdentry))
 		return PTR_ERR(newdentry);
-	newdentry = ovl_create_real(ofs, upperdir, newdentry, attr);
+	newdentry = ovl_create_real(ofs, upperdir, newdentry, &qname, attr);
 	if (IS_ERR(newdentry))
 		return PTR_ERR(newdentry);
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index cad2055ebf18..714a1cec3709 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -406,13 +406,6 @@ static inline struct file *ovl_do_tmpfile(struct ovl_fs *ofs,
 	return file;
 }
 
-static inline struct dentry *ovl_lookup_upper(struct ovl_fs *ofs,
-					      const char *name,
-					      struct dentry *base, int len)
-{
-	return lookup_one(ovl_upper_mnt_idmap(ofs), &QSTR_LEN(name, len), base);
-}
-
 static inline struct dentry *ovl_lookup_upper_unlocked(struct ovl_fs *ofs,
 						       const char *name,
 						       struct dentry *base,
@@ -888,6 +881,7 @@ struct ovl_cattr {
 
 struct dentry *ovl_create_real(struct ovl_fs *ofs,
 			       struct dentry *parent, struct dentry *newdentry,
+			       struct qstr *qname,
 			       struct ovl_cattr *attr);
 int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir, struct dentry *dentry);
 #define OVL_TEMPNAME_SIZE 20
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index d4c12feec039..109643930b9f 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -634,6 +634,7 @@ static struct dentry *ovl_lookup_or_create(struct ovl_fs *ofs,
 	if (!IS_ERR(child)) {
 		if (!child->d_inode)
 			child = ovl_create_real(ofs, parent, child,
+						&QSTR(name),
 						OVL_CATTR(mode));
 		end_creating_keep(child);
 	}
-- 
2.50.0.107.gf914562f5916.dirty


