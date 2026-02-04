Return-Path: <linux-fsdevel+bounces-76258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bjj6HIvVgmmUcgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:13:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D27E1CF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0D6330E0266
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 05:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C2135CBCA;
	Wed,  4 Feb 2026 05:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="IA/OH9nB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VvpC2+sx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9733235503B;
	Wed,  4 Feb 2026 05:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181788; cv=none; b=CjB0s7cfL9OvLGfgheDcMovh69Txv5i5QIuneFIc09tqQz/BI48W8KZG0upBxg0AmIVHpvIzdv/cMH2QJG1E6YHlxjiPsNlID5LlHipo/083ngST1Wm80ITxFPirLY8AyzT0xhc8su/1H1DKmzjb47e2zJqvGRkmPRrWCV7fHXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181788; c=relaxed/simple;
	bh=EcuUci3NrafWHA9mqFebcPpgK+jW1TgeLPfYj6hWJgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cqd8zYgwRIS3Q7LC7HhU9SIc2FFLxrpaBZZiQOWY0cyLUL52JEf5gH49Bn2sKojAPICLIRUuN7UydqWDK0vn/G+RvXZnhlqTa2PPqStHdHtH8Svo+KjdVUA1T+Du1T2gYVMWViBoCnt/IkKuolMMPpXZirXAKjg55L2G8GE9rt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=IA/OH9nB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VvpC2+sx; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id C45231380795;
	Wed,  4 Feb 2026 00:09:47 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 04 Feb 2026 00:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1770181787;
	 x=1770188987; bh=FodiWxTGOrcO4kqPhH8V5J2d81hZRju7CaAdC0kBghU=; b=
	IA/OH9nBkl0L/V4jFP0mIYu5PuKIWyyOkTV1eMHW4QZ7laA9FwSl+rvwQD8LUZIp
	unDzrnaePoojghi7bR9bhXeZN06pX2dwTMqHCe9tI2g/fRs+DQIix/0+kn6nxe9T
	hsMLoe0UHc3+8Vy+XcMCdLkvasUKBJ7HwwMkdy8dFVFW/QTWdqwOtPjAe32LnlbH
	HQiWbqoxnPWmxAgTymOh89AME4UI3S9tm9r+x6bDau0zH6ZV8haZEJ0Xf2lZIOlU
	Gyp9nLt58dFVVQMHoXoGcNmfvQagYknwlVX8k7P9hbOdpFiGdxL6JXqayrorAjmG
	+L3C6kyZ83Yk/IpCvuiFGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770181787; x=1770188987; bh=F
	odiWxTGOrcO4kqPhH8V5J2d81hZRju7CaAdC0kBghU=; b=VvpC2+sxldBw2tIOW
	77AL6W0NTYq6ye2ZXiZ6qd6fJui28cxi+I6rws1ykZaKi8AO5OrEWElgFhEZrjW0
	DNHvITXcnfTkgCsX6s6duFifX3jwG8J5XNp1iGHv0fFCAiLwqn3c7jmhrt+GhSZY
	cmh4lZmKT0BIAZBJqjxaYyuf53nTkzqLtPRTbnmxMDndi6K3W7OU9B6eHmueuARz
	7g5vX6ai8jIhDKtxb/CqwfxGxnNY2FNSxW0H0img3B+L8yvltu+hOkXcCHsIWzsI
	PPDD37WzgTyV7h/3LSwqo+hU6AcUKoUNXOVsA2Hv9E6PXTzKf4e7DrjTfKRASpSy
	NpyOg==
X-ME-Sender: <xms:m9SCaReHppifkN_Cf5pTv_545vMDS_sv_yJ9eBTKCHZ1YTNCXkRCIw>
    <xme:m9SCaazVi91ief2zLXDLLQWt7rXy2ZSNzJqjO4DnknaJU9H6B-uYqXxzL6ZYoJRue
    d2ihvs9jQk0PwqTuKHRvYPN5oQAPii3NDr8dYRArtqGlE9I2A>
X-ME-Received: <xmr:m9SCaageDee_ewTZdEfo4v5irqih55Q_MG6RsNlHJ4hIyo3audOAfLi9JZMEfZMB_hVGeOQApdLuRPyEuHvlgNNt9VgK56EXDH5euRUdiBYt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedukeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhr
    tghpthhtohepjhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:m9SCaf7wUR-6rC9qxE37Pn-XLmXMIJbY-YfMMuv6gX6Hfc4oF7ghwA>
    <xmx:m9SCafrgu7obCByNluMMGgzqCW9uKie2YIniIl8drQyqVYXq9fa8lA>
    <xmx:m9SCaVU2Oo14aWIcBSdLi7nwxx2H6Jjh6w-fdwFVHtOG6gTrp4vHPg>
    <xmx:m9SCaW7ZPddf_NbC6pITmfJZdwCMnXFE3qGdi2pLlgQhx_l0N3-XFQ>
    <xmx:m9SCaYGk926uEosUz1L3DRfHiJX2djLrvwovEuCTy8dCgWLI-yIwGImH>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 00:09:42 -0500 (EST)
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
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH 13/13] VFS: unexport lock_rename(), lock_rename_child(), unlock_rename()
Date: Wed,  4 Feb 2026 15:57:57 +1100
Message-ID: <20260204050726.177283-14-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260204050726.177283-1-neilb@ownmail.net>
References: <20260204050726.177283-1-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-76258-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,ownmail.net:mid,ownmail.net:dkim]
X-Rspamd-Queue-Id: 90D27E1CF9
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

These three function are now only used in namei.c, so they don't need to
be exported.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst | 7 +++++++
 fs/namei.c                            | 9 +++------
 include/linux/namei.h                 | 3 ---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index ed86c95d9d01..5f7008172f14 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1347,3 +1347,10 @@ implementation should set it to generic_setlease().
 
 lookup_one_qstr_excl() is no longer exported - use start_creating() or
 similar.
+---
+
+** mandatory**
+
+lock_rename(), lock_rename_child(), unlock_rename() are no
+longer available.  Use start_renaming() or similar.
+
diff --git a/fs/namei.c b/fs/namei.c
index 307b4d0866b8..0bc82bf90adc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3713,7 +3713,7 @@ static struct dentry *lock_two_directories(struct dentry *p1, struct dentry *p2)
 /*
  * p1 and p2 should be directories on the same fs.
  */
-struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
+static struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
 {
 	if (p1 == p2) {
 		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
@@ -3723,12 +3723,11 @@ struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
 	mutex_lock(&p1->d_sb->s_vfs_rename_mutex);
 	return lock_two_directories(p1, p2);
 }
-EXPORT_SYMBOL(lock_rename);
 
 /*
  * c1 and p2 should be on the same fs.
  */
-struct dentry *lock_rename_child(struct dentry *c1, struct dentry *p2)
+static struct dentry *lock_rename_child(struct dentry *c1, struct dentry *p2)
 {
 	if (READ_ONCE(c1->d_parent) == p2) {
 		/*
@@ -3765,9 +3764,8 @@ struct dentry *lock_rename_child(struct dentry *c1, struct dentry *p2)
 	mutex_unlock(&c1->d_sb->s_vfs_rename_mutex);
 	return NULL;
 }
-EXPORT_SYMBOL(lock_rename_child);
 
-void unlock_rename(struct dentry *p1, struct dentry *p2)
+static void unlock_rename(struct dentry *p1, struct dentry *p2)
 {
 	inode_unlock(p1->d_inode);
 	if (p1 != p2) {
@@ -3775,7 +3773,6 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
 		mutex_unlock(&p1->d_sb->s_vfs_rename_mutex);
 	}
 }
-EXPORT_SYMBOL(unlock_rename);
 
 /**
  * __start_renaming - lookup and lock names for rename
diff --git a/include/linux/namei.h b/include/linux/namei.h
index c7a7288cdd25..2ad6dd9987b9 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -165,9 +165,6 @@ extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
 extern int follow_up(struct path *);
 
-extern struct dentry *lock_rename(struct dentry *, struct dentry *);
-extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
-extern void unlock_rename(struct dentry *, struct dentry *);
 int start_renaming(struct renamedata *rd, int lookup_flags,
 		   struct qstr *old_last, struct qstr *new_last);
 int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
-- 
2.50.0.107.gf914562f5916.dirty


