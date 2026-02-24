Return-Path: <linux-fsdevel+bounces-78322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EL+FoYmnmn5TgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:30:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B10C418D4CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B4393129872
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5363B34A3BC;
	Tue, 24 Feb 2026 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Dxxendxg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fW+7qVBm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E20344D98;
	Tue, 24 Feb 2026 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972011; cv=none; b=aOMVrgqLWNa3a3tUvUemUo/8qClE0iWea/A/t3kGvTBEJwKAOAI/1klxusjz4/EZ5bUm9o11kY1ZYRrCMTXyYthgcf8R/aRv8fB8RKOSmDpl1pZiAAj8Vt5ELqc4YMQij3cUxXxRzIufo47qNGNa4GhgQJlF4NxQxiuezENjRaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972011; c=relaxed/simple;
	bh=XdH95tiFrQ/sKORHCrxucIV+VvmedwyPT7NUDj0XhsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqPUMAB+4JkJZCfM00MZSr1yOa41JG5pDnk/V78xqHZo04clQ63LX3n/4ZDbDb4mw6pX6hGRjIbXc3gdUVvAXgJk+bbeiFVYgFoIvgwQ4OkcDSjcEc/Y1eepTWmlI1veGvB0iAZRUwFJikwGPTqNRLaylbe+KNYMfJri39RxAZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Dxxendxg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fW+7qVBm; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id A3CA213805A6;
	Tue, 24 Feb 2026 17:26:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 24 Feb 2026 17:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771972008;
	 x=1771979208; bh=uXMU6tWLxH62oiHRDx59UoQh2FcFUEj9XaKWMgxDywE=; b=
	DxxendxgyK6rTiqG/fxumh1kOC6ytof4U4niPIav51NX7ee/mCUy0bU+TUm+/0Mm
	rFj2T38yPbTdz9PP3+zc+ovcdQXWWs/Dd5/r2DA0CLQy6p4a6DvvBx6FDbv+CVXL
	uDjQuYQvf5ea1y9rg2MrEzKlaEEZCht9eSHlLCMx3AkrdMwxU+aN7fBkpoek9xTR
	4PVF+NCj1EPeG7h/0P9DsB77rKWQnnchfa7OErS6boEFK0f1NfQAD+lrFjz9Asgc
	HrAkn3QmXAQteBcAckwenqh5ufmzzshcWB1aKTyHJ+xzE4IHeYTh/CIvXHa9CGg3
	3gAB0KwqmPs7v3X3LpnZBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771972008; x=1771979208; bh=u
	XMU6tWLxH62oiHRDx59UoQh2FcFUEj9XaKWMgxDywE=; b=fW+7qVBmtWMZCbjyx
	hnRlX0IaoiA7RThWcfCR03kI9XQ2zX8Khs3d/poMc4rqnMGdv1tfcfF6tWtGGgJ1
	duI9rVPkdEpp/HjFy/BXyhblmTBTS5ML+2s9HqJ/S1RathJXRQP4FKvtpM/KTLsT
	8c4FAq5J2neZoaWMwkcEetoH1+FfPadcHWq+L0E0IBNjkulXWQSJJi0+NbKBQXF4
	Yyzhasq874CLbWLTM6lr47KRLYE51Ru9oVY4i4rIDpZFr28ntAjnC+zFAiqonBAh
	m7WOlInrlEOnf99F0tljLcn3JbSLPx73PnRrj6toPcnwq8rhagPp7ttw+bvyvLyl
	Luvdw==
X-ME-Sender: <xms:qCWeaVkYQ78gPUeqLQtjiJTx-x7yYC8cPurx1YbJB5DawYS6ehqIbA>
    <xme:qCWeaUybpyULqy32aBrTL0fMszuSm8bVC0JiFR98Vv-qGHGdmJ_qyMd2MHe6TIQzv
    IRlFSTLc9lWTw1Qcdr025dknQZFGarMHhw2xvKeCzMn56TTaA>
X-ME-Received: <xmr:qCWeaUKnsPg9ZYhrYCzu0CkjIeOK9YJfe3ohg4ZB4IWVjE7S18o0z7sS_qJLFa6sseL4VtYjeodZFb5BElgH2PyXVKmVoLpBMoD9RNwlRHR->
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
X-ME-Proxy: <xmx:qCWeafKTMHiq7iIMBA5BL27TsongeqK4NAsayui5BdmkXUZxKtB8Pg>
    <xmx:qCWeabW8et8RJwPavnEC8dIPftIY7Cb5NXWbxwTUC35F9CPfo3UgCw>
    <xmx:qCWeafAI8lg-t-gW6clAGStqeniJGlIo4NNuywjazIXwFvdRiACTGA>
    <xmx:qCWeaWGURgAbAWSCZXP8ZyXd-5hALipgb2wMo9CUtdfYfVwdI-hOnw>
    <xmx:qCWeaTPMKQOqg1XyBHJ0e_4tDbXyOXOJuY0gCG5CS4-lfUXQ_hZbqy5h>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:26:42 -0500 (EST)
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
Subject: [PATCH v3 06/15] selinux: Use simple_start_creating() / simple_done_creating()
Date: Wed, 25 Feb 2026 09:16:51 +1100
Message-ID: <20260224222542.3458677-7-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-78322-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:email,brown.name:replyto,brown.name:email,messagingengine.com:dkim,ownmail.net:mid,ownmail.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B10C418D4CE
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

Instead of explicitly locking the parent and performing a lookup in
selinux, use simple_start_creating(), and then use
simple_done_creating() to unlock.

This extends the region that the directory is locked for, and also
performs a lookup.
The lock extension is of no real consequence.
The lookup uses simple_lookup() and so always succeeds.  Thus when
d_make_persistent() is called the dentry will already be hashed.
d_make_persistent() handles this case.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 security/selinux/selinuxfs.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 3245cc531555..83aa765a09f9 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1931,27 +1931,26 @@ static const struct inode_operations swapover_dir_inode_operations = {
 static struct dentry *sel_make_swapover_dir(struct super_block *sb,
 						unsigned long *ino)
 {
-	struct dentry *dentry = d_alloc_name(sb->s_root, ".swapover");
+	struct dentry *dentry;
 	struct inode *inode;
 
-	if (!dentry)
-		return ERR_PTR(-ENOMEM);
-
 	inode = sel_make_inode(sb, S_IFDIR);
-	if (!inode) {
-		dput(dentry);
+	if (!inode)
 		return ERR_PTR(-ENOMEM);
+
+	dentry = simple_start_creating(sb->s_root, ".swapover");
+	if (IS_ERR(dentry)) {
+		iput(inode);
+		return dentry;
 	}
 
 	inode->i_op = &swapover_dir_inode_operations;
 	inode->i_ino = ++(*ino);
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
-	inode_lock(sb->s_root->d_inode);
 	d_make_persistent(dentry, inode);
 	inc_nlink(sb->s_root->d_inode);
-	inode_unlock(sb->s_root->d_inode);
-	dput(dentry);
+	simple_done_creating(dentry);
 	return dentry;	// borrowed
 }
 
-- 
2.50.0.107.gf914562f5916.dirty


