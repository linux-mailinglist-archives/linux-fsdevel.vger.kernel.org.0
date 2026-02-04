Return-Path: <linux-fsdevel+bounces-76250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KvzFkvVgml5cQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:12:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1768E1C7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F95631121F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 05:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6BB3542FF;
	Wed,  4 Feb 2026 05:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="OSIwwhCE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IckxQb5e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B1E353ED1;
	Wed,  4 Feb 2026 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181726; cv=none; b=MSskCHvHVacmFz9rxoIW+tTxRHcun4Gq8eO7GZG2ZrP0pEh117km7cHdMchs5Gkz80hQOUDiOizgLewePACzYoSyFpGU0IRlFM5+b2hLiBx9Fh//zjZMYKcgQju78qprS6VwIFlNcDXs8Ih6LYa3Eihg8lKl/kvLM63NlBFcJh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181726; c=relaxed/simple;
	bh=4G2dvZDHtKO1ROuLl6tcnJdY+EMaZh/hy2e8eYdHCi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smogZFnQXVlutHeLQ+yi1WcRxD9LtNmxl4PUK9Sq9bjA9ZlUhF1gk9ezzQrGnK7LKIYqFI49cItsNWE2tbK+eadfHUhN6KRH2t0mrcX9OoFQ80lDlAvKH4tri5UbiLRu0v9zWJvbi0ysftRXbL088Ih31KVWT4l1hyT2N8cF6kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=OSIwwhCE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IckxQb5e; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id A26ED1380787;
	Wed,  4 Feb 2026 00:08:45 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 04 Feb 2026 00:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1770181725;
	 x=1770188925; bh=Xtl8I0VkwBbZNObKLjoeIAfJSZzFqP3UknI7fOZwH+Q=; b=
	OSIwwhCEIjbM7LfTzPSJhSef5BBZmE0JkVyVx8l1KZYiVpsDnn8K8qnCgjCtUOaJ
	1Pnh+pZiP/QcXciClhvqrLQFzLMPKbeoBnE3g5YQbQwerqhiws1FDQ4chBNhkbN/
	2lDaZNN6gNBt+MnpXZYJWqkAyYNq7lNd83ZjcUASBD+tA3wS1rkcfhkbO0+GAfh0
	lhE3cvfuuWY5eNpY2Le9uVITGvStkAYDSKcBLNSIaIcyiwdWUK+ayeJPisbkvXcC
	PiZhs0+4jHUpt5g0NJZDcHizH/NsBlNAlDfdgwt9HyUSXWMC2u5fRthtBesiYAGo
	bd5WKG+KnYWB8PKlEkgc2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770181725; x=1770188925; bh=X
	tl8I0VkwBbZNObKLjoeIAfJSZzFqP3UknI7fOZwH+Q=; b=IckxQb5eQ1teD/JC2
	2C6z4aLlWpOTXy+n37BxxAqbOsLUj5xcRzP18ybcP3MRqFT/MLZNgdepc46XyL73
	g85vy9/StufIHnLyOqaq/camuvYgVNST4xUFhb4+pEifAy6L/rxaifEfcctnW+iA
	dHgmFs1KGK7kMNPQRh3YS6wAFPj+7xYatkzBkd/MRhHvS1P71IULuYQs3HzkwOBb
	dT0PwfrWQleQdyKJOBwHM/6OnoX8ohPLx8/L4haPzwFCp33oEByj49+nyRpymIZu
	erYAXlHSL9+fnRNWKOPb336GZdqXNLeureCB1uQyQs1e277cOfDhM9rMJ+4YB1qb
	u07iQ==
X-ME-Sender: <xms:XdSCaWsfh2d-ioUmeNlRIDMj8rwlBG4jcTV5wl3rDs9Q1MzOh_1LaQ>
    <xme:XdSCafseYQkm6EX2rJn4Ud5eKs0MI05TmsSDaCR-Gk_OKpUk45GZcGXVpvXNLGc4x
    UxmaW6m6j7UZvQQ2plA_XKilTAcnzHYDNguYzDFl_Wkb3pq7K4>
X-ME-Received: <xmr:XdSCaVWm5HvaISOhWExU6yJRWs1YLPHaIho4mJwuAD8yVE9SbjiJJKkqbdeiuhs4NmE8uiIz0u8kWaucuvXhuMPUZmNpToftJzlTK4_8Ve_B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedukeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:XdSCaQVBU5IFoGFzV_wMu4KhZOjgRt10-YzzGZGXeMJabUhaGOQqYA>
    <xmx:XdSCaQT9G21T-9mjN0ptcYqmG_IOgMV4OlmhxXqmuBD4vVIljXISew>
    <xmx:XdSCafGrNO6uLKF4PoVFr0wvgJReoWMkuxqvjyapMBDqmIfjy-Ktsw>
    <xmx:XdSCaQQDPg2A9xmYsrnIw2GPGz1OOTaLAapSLpyryM3UmhtVEi5LZQ>
    <xmx:XdSCaUOrX_qr5Y4DPfFCLAWZvu_7P23WIOE4jqM2FyFvWuPH8wJDcVPA>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 00:08:40 -0500 (EST)
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
Subject: [PATCH 05/13] selinux: Use simple_start_creating() / simple_done_creating()
Date: Wed,  4 Feb 2026 15:57:49 +1100
Message-ID: <20260204050726.177283-6-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-76250-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:mid,ownmail.net:dkim,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:replyto,brown.name:email]
X-Rspamd-Queue-Id: B1768E1C7D
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

Signed-off-by: NeilBrown <neil@brown.name>
---
 security/selinux/selinuxfs.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 896acad1f5f7..97e02cd5a9dc 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1930,15 +1930,16 @@ static const struct inode_operations swapover_dir_inode_operations = {
 static struct dentry *sel_make_swapover_dir(struct super_block *sb,
 						unsigned long *ino)
 {
-	struct dentry *dentry = d_alloc_name(sb->s_root, ".swapover");
+	struct dentry *dentry;
 	struct inode *inode;
 
-	if (!dentry)
+	inode = sel_make_inode(sb, S_IFDIR);
+	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	inode = sel_make_inode(sb, S_IFDIR);
-	if (!inode) {
-		dput(dentry);
+	dentry = simple_start_creating(sb->s_root, ".swapover");
+	if (!dentry) {
+		iput(inode);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1946,11 +1947,9 @@ static struct dentry *sel_make_swapover_dir(struct super_block *sb,
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


