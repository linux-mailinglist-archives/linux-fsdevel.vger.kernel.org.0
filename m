Return-Path: <linux-fsdevel+bounces-78321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOBJMKclnmn5TgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:26:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9613A18D25C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93D233065E46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E11346FAB;
	Tue, 24 Feb 2026 22:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="IeWHMqZU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FEopHGyM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CEE33A9ED;
	Tue, 24 Feb 2026 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972003; cv=none; b=sApitzGbrKvdFpiXLHAjJbrjpoqEP7Z/9slaJHJHq03OY4obDZ1MHj8IgzjYrhwNWJE/defycYuNrwFOgYE+pBsSVa+9CdDlsCOgqsE6mKZWsAuOmC5dVhQzPtAxWblpYAzeayUwzc/4uqzBsculOzq1SYa3fpOuneHtci17wBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972003; c=relaxed/simple;
	bh=vlxskyEUB0dnx8Tl8FcZiAX25ptet1IjxeqP5VrcfUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjd+kaJGAQBhqwxtrrjMz731qA4XT8wwK1PyglA9wdR6z6OZMN3bZEC4RWFU4LI3IF7/V0LoSr3QraZgmXeZeK21qBSsHTqi4+xTtJ4Vv5JCxH8XTjO6aiop/I/UQ3Fbf/P7lcJbWvBxN+UaMsbxcJ4zI7NaGccAV2DD6cfCzm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=IeWHMqZU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FEopHGyM; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 64C88138052C;
	Tue, 24 Feb 2026 17:26:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 17:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771972000;
	 x=1771979200; bh=O4F49usif+OP5XD8k3JzmeUE/gWUb/ClWD4S6e21APM=; b=
	IeWHMqZUGKoTBpMl0ugzK4xq2wS2PMSDjK0GEN0Q+DNcwjSPaIHOd2yEa1OrwTzG
	jQeK5X7QjA7FP4gDPXtMprXzD2WJeH8bhZqR2Vbu+LSkyV/r+imfLlu7LqMmu7ic
	9UWOx0p6NT6Y9CbrBjRJrisPY6Q7wOmS67lNk18gM4bCbCSLj9s6BXmFausJ6woa
	cJNEbMriw4/1F0upRMHXvvmusWCUu+Svdkrw6JwxqaJOzbBSTDR/zbX5okaVIvWG
	R4RrvoFvvZVl85xInOWS58mwYY4uuQSY91VY6A/3wTHm4sYLVlGx/pnBnVinp7/T
	FyBYSB57KKfOdfbQKHq/Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771972000; x=1771979200; bh=O
	4F49usif+OP5XD8k3JzmeUE/gWUb/ClWD4S6e21APM=; b=FEopHGyM2D1CKq+4X
	3g8EZ/fUrIzIWNiOT/hQKgHo13UiqDf5cNt2a1T1TFDP4iNPL5LbL1sQ8K5KNNR9
	SAQdGlUl1sKge1hy3rJPPuahT5RcHC8MHbkKr/4QPL6EeLyQIzkvEqlqu+MODhK+
	43NwebESY/CvhG6XFqibBLTxRPaJ7oSyG4n5pQ0TA1CZP/YRhFnWq+LpqC4zxlHX
	rvTi6Yj4K90oxCEy86PDl2mCI7ZdRlbkPwmvUb1re0IW3iWIOcRIgchYsY9R86jX
	jnUnjp4/JI76ceU/1XqJdPelX8clNEf3ca94saSjeUhZkRlzEZD7cowTd0e7ICb9
	mUkmg==
X-ME-Sender: <xms:oCWeaYLkCWB8lbUqEsNeM61yRR29Uu_tE24RKxMbXu1EShozk62ryA>
    <xme:oCWeacFehfk_AY0bUHNgu6ftXJbZJZuSJEax0gddISpehfhGtZ9TXAGeeKtrKktKb
    KsiO4SNPbh2YRjQ_2pjnh4B3Qa8Hs5pcdEyssNpRA7TF88m8w>
X-ME-Received: <xmr:oCWeaRP-kxHVDztNwkVQVhyW-bL1zWXz_yOlwQJLmk9Nc3cbGmL9hG7dkh6keULceM0zHtjIFhY66YnjMBYyVKjNQfQVNfxC4PGjq9VDOW43>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedufeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:oCWeae9QqJesMbmZvVqBZ6RCt0DghifFtqHAEegrIjQXqUYHsMJLYA>
    <xmx:oCWeaW6CfXhjjAIuW08gMlcur-nUhuvljhzCIaAf6o6beRl7GjS1ug>
    <xmx:oCWeabVuULFUFhEJoQGuANnqwC6a1OnvUn187RATBGfndH-bHpQB-A>
    <xmx:oCWeaULnghfmWFKSPx1QoyttO1Ql6fbxIKQtcfDa1QkhVZDFljCZVA>
    <xmx:oCWeaSDieEMGg-IJlkKEjAJoWctIuEbU_6LsGcpJv67e_hl_lxILWaSN>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:26:34 -0500 (EST)
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
Subject: [PATCH v3 05/15] Apparmor: Use simple_start_creating() / simple_done_creating()
Date: Wed, 25 Feb 2026 09:16:50 +1100
Message-ID: <20260224222542.3458677-6-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-78321-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,ownmail.net:mid,ownmail.net:dkim]
X-Rspamd-Queue-Id: 9613A18D25C
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

Instead of explicitly locking the parent and performing a look up in
apparmor, use simple_start_creating(), and then simple_done_creating()
to unlock and drop the dentry.

This removes the need to check for an existing entry (as
simple_start_creating() acts like an exclusive create and can return
-EEXIST), simplifies error paths, and keeps dir locking code
centralised.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 security/apparmor/apparmorfs.c | 35 ++++++++--------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 2f84bd23edb6..f93c4f31d02a 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -282,32 +282,20 @@ static struct dentry *aafs_create(const char *name, umode_t mode,
 
 	dir = d_inode(parent);
 
-	inode_lock(dir);
-	dentry = lookup_noperm(&QSTR(name), parent);
+	dentry = simple_start_creating(parent, name);
 	if (IS_ERR(dentry)) {
 		error = PTR_ERR(dentry);
-		goto fail_lock;
-	}
-
-	if (d_really_is_positive(dentry)) {
-		error = -EEXIST;
-		goto fail_dentry;
+		goto fail;
 	}
 
 	error = __aafs_setup_d_inode(dir, dentry, mode, data, link, fops, iops);
+	simple_done_creating(dentry);
 	if (error)
-		goto fail_dentry;
-	inode_unlock(dir);
-
+		goto fail;
 	return dentry;
 
-fail_dentry:
-	dput(dentry);
-
-fail_lock:
-	inode_unlock(dir);
+fail:
 	simple_release_fs(&aafs_mnt, &aafs_count);
-
 	return ERR_PTR(error);
 }
 
@@ -2585,8 +2573,7 @@ static int aa_mk_null_file(struct dentry *parent)
 	if (error)
 		return error;
 
-	inode_lock(d_inode(parent));
-	dentry = lookup_noperm(&QSTR(NULL_FILE_NAME), parent);
+	dentry = simple_start_creating(parent, NULL_FILE_NAME);
 	if (IS_ERR(dentry)) {
 		error = PTR_ERR(dentry);
 		goto out;
@@ -2594,7 +2581,7 @@ static int aa_mk_null_file(struct dentry *parent)
 	inode = new_inode(parent->d_inode->i_sb);
 	if (!inode) {
 		error = -ENOMEM;
-		goto out1;
+		goto out;
 	}
 
 	inode->i_ino = get_next_ino();
@@ -2606,18 +2593,12 @@ static int aa_mk_null_file(struct dentry *parent)
 	aa_null.dentry = dget(dentry);
 	aa_null.mnt = mntget(mount);
 
-	error = 0;
-
-out1:
-	dput(dentry);
 out:
-	inode_unlock(d_inode(parent));
+	simple_done_creating(dentry);
 	simple_release_fs(&mount, &count);
 	return error;
 }
 
-
-
 static const char *policy_get_link(struct dentry *dentry,
 				   struct inode *inode,
 				   struct delayed_call *done)
-- 
2.50.0.107.gf914562f5916.dirty


