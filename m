Return-Path: <linux-fsdevel+bounces-78328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFWlGgMnnmn5TgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:32:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC61318D5C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1854430D0B39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C0C34AB17;
	Tue, 24 Feb 2026 22:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="KAE+Cx8K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TOUwpW+T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030C4330641;
	Tue, 24 Feb 2026 22:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972060; cv=none; b=ly5urAeoSmYz3h2s10TgTy7zAOVKXjeuLFARkNNaNhx6E6eja7ywo+nQhczX9VI9sxun20SfO4VI9Z4QET/1qtUD3KQUdwrJU1tDP2NuEPSv16usd4Eq055DT/MqoRO6EtDb+jvtoItR05evSXshJTtLNPv62jbyJFQy4G1AXGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972060; c=relaxed/simple;
	bh=xM7SAoZXwXzQ5TEGYKXSSmvOr/UxYWiOr0Yv0fzVzrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbkaiLadrzLj+SyZZELwC9wEo3DfIRDIlrtOfjq4/U6GBu57fMAKdKUt/Zq9S4hjrdlx8dNq+uz4V9n16ndOU3/XHaM9VP0HnFu+9iyGxQz8Ov0HFd4Bc8s1oU93GFniJvAlzQKExwVyj2FICG6bE4MrcJfXsf3dnqjP4FpJzkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=KAE+Cx8K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TOUwpW+T; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 52966138052C;
	Tue, 24 Feb 2026 17:27:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 24 Feb 2026 17:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771972058;
	 x=1771979258; bh=+n/TdNDWt0YGfbs3tUCUsBBqqY8Ht+jCITPiyVgI6RU=; b=
	KAE+Cx8KQQbP885GNTbuAul7FA9qjVN7lT8hINyLuxP9Qg0MObojudF5zU7fzTSV
	R6PcHD8qNIftJq+qt0KpO/PyawHBxnCxjiP2cGcDWMezbjsuYX4T0J4E+cM0Aj+0
	XyiKCjtpqjMCcJksd+WG+LVyrJwXYqbCKglNoV5kB0yHO7yvvo/g7zJTw9wcF1US
	kICdc4KjC7m5q8QJRvnIQKHK+osKj2jLfC85q9lt/iXDRVTX619EomNjJz+aKcGe
	HGVDofOSCtj7ifgDW+WuRG/b1LPlLNA7C5/NgDiFu8UxNr+QvfiOtsEzXZsYhaVN
	cnQEXsb0q5LJV9aENuJPdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771972058; x=1771979258; bh=+
	n/TdNDWt0YGfbs3tUCUsBBqqY8Ht+jCITPiyVgI6RU=; b=TOUwpW+T4OdE92Y2P
	2tnlKVavGx6kUdGEzSgdSQf13DXhfLnDXhBDe+XndeX8jVp3iM5MJbL4U2iJocoK
	nBBrVH3hF9gjBPpIyZig+IQpLOsWiyVS72zfBfsM0JmwcFt1SywrFNserBJR+fFX
	SZY41v1zFZWSiR+pVz/bpLtH7NrT8W0tYRKfeetkqesJHXpGRBsD5qYAjsDZV34M
	TsMqfxz5f6CpB7wZnewmutz+8eT5tXaEIwuy5gqJS/msxbaW2FB5qWVyPTLar0bC
	akZin1PFpK0cYraooH71uUUxsGNeAMXoHePhg3sVIDFdXsP2VUEtUE0uAQYCd4PT
	WuCMg==
X-ME-Sender: <xms:2SWeaWRsUqWqIvR69-C9xIekTemSirprZ1ZOtIzLdtTkJ8eWvbXCWw>
    <xme:2SWeaftF1OMtDycEVCM2VSsPCAX7BX8s4ys30RcTtT8AZ_eb5UjN9oFeZ_2ddudsI
    Oge0HQ9oK8XumPVpdJhM84WfoBl3kgNFy2uOlx1fgzqmlnrgrw>
X-ME-Received: <xmr:2SWeacWNYi5UKBrcrTUtA-_Z6pjp-ViUsuRrRRxUaI8k20X5i1Oy5OjltgQIYm9Kc-BuWcqWOPHdEtEWgxgC3vpc1WoMKkVzZdIRK_KlDPtc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedufeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:2SWeablrzUTm1RixdP63G17JvymBDWzWR6Ue1Jb997ou4TW7JeSFug>
    <xmx:2SWeaXBmk2UlBRNA_4zg8On0W4QXn4P_4EnMTunW1nDnC4P-loIruw>
    <xmx:2SWeaY9PVDzM2UuSbi0dQUWiYUZxMGSqxF4nk68Tos8Fnmzk4FkVpQ>
    <xmx:2SWeaRSAJRkhUwC1wCf5tOlXI1PkmZfgovM39Z0m4HyYBdPZtKlH7Q>
    <xmx:2iWeacrtuKjgol5xmRtiQ_8RZBlQ5L36T7UStvttdHnm29OmUMUm4qju>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:27:31 -0500 (EST)
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
Subject: [PATCH v3 12/15] ovl: change ovl_create_real() to get a new lock when re-opening created file.
Date: Wed, 25 Feb 2026 09:16:57 +1100
Message-ID: <20260224222542.3458677-13-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260224222542.3458677-1-neilb@ownmail.net>
References: <20260224222542.3458677-1-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-78328-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	HAS_REPLYTO(0.00)[neil@brown.name];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:mid,ownmail.net:dkim,brown.name:replyto,brown.name:email,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC61318D5C5
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

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c       | 37 +++++++++++++++++++++++++------------
 fs/overlayfs/overlayfs.h |  8 +-------
 fs/overlayfs/super.c     |  1 +
 3 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index c4feb89ad1e3..8c0a3d876fef 100644
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
@@ -221,19 +222,30 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent,
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
+		} else {
+			dput(newdentry);
 			return d;
+		}
+		end_creating(d);
+		dput(newdentry);
+		return ERR_PTR(err);
 	}
 out:
 	if (err) {
@@ -252,7 +264,7 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 	ret = ovl_start_creating_temp(ofs, workdir, name);
 	if (IS_ERR(ret))
 		return ret;
-	ret = ovl_create_real(ofs, workdir, ret, attr);
+	ret = ovl_create_real(ofs, workdir, ret, &QSTR(name), attr);
 	return end_creating_keep(ret);
 }
 
@@ -352,14 +364,15 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
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


