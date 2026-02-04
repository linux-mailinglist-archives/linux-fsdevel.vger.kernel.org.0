Return-Path: <linux-fsdevel+bounces-76249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P7IIxvVgml5cQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:11:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E864FE1C32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B11F930F23B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 05:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D743542CC;
	Wed,  4 Feb 2026 05:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="MXE/qyXA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fb6DeRDI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEABE352F8A;
	Wed,  4 Feb 2026 05:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181718; cv=none; b=bjcwf3G6eI2aONgMdLDNaooXc9tAbbeydDX7NNTLq8yRwm+qOmPzMm+2El/Zq/VC+9lpN6OK1lP7qOhLwEKs73F4XEq/h02SI5VLHSzJsiXYr7HNAeqqGGNzgUq0CmQ8ngdIJGsot4+rgwk+t8cW72TWxk8gEAUQuxoM7bz7JsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181718; c=relaxed/simple;
	bh=pNnjOc5fmEcwQUqR2kkDoAOFhmAX4yVyKqWdqZOoepM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejMcLljjBbCudebFWVZqODxeDmtRFAPoA2FbNNMisstCYABhUMMgyB+8LltZrqJm0Hk77gFSHt3WbKB4tsaTulkUBGmG3fMH09zb7g3fSjg2Ij2BMbpQPdkUeWhjl3SDNmrRBjav8/5PIvbU8T9hClaffHUU+BlouH4fx0ufFgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=MXE/qyXA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fb6DeRDI; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id 26B801380785;
	Wed,  4 Feb 2026 00:08:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 04 Feb 2026 00:08:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1770181718;
	 x=1770188918; bh=8wI2eoS5Ti0e8e9a5OXGf4ICfst25BignuwQVay1myA=; b=
	MXE/qyXAO0SlibBo/pe9gHtfQbldudp4yLTK4aISviPikND1RrYRXxvbI1j/RajE
	yJ+x8Y6R49TL9etkHnQLkdFi5B7eRU+tBZFHwfZhUmfJQ+2CBVyWg/elDu/RfJPv
	Wekfj7kHXKYQh5k0uYFczMMMYaSRdikAfeV7E4U0Q7l4BscWYDjA+0aWRoyaqEPa
	RXU2UKxtNIpC3AmNBTcoGO7eQvtttO4GPmfSa4YSbWagFkkPHObAMmjCR2fx2sYm
	TxWXSWke9uqBqM9A8zDle/FguWenrQs0whblpMFI0jao0xMeNY9DrLNKSR9bM3YI
	xUTyJp/H++0pCUMlwi4ZsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770181718; x=1770188918; bh=8
	wI2eoS5Ti0e8e9a5OXGf4ICfst25BignuwQVay1myA=; b=fb6DeRDItfriYices
	U725N5r6W1CZEi9lKyh2eHtQ5QPZhuyxFRJklTnkZ/5p4ygYhmm32OwOmRsNzT9B
	xezOFIhjwBGHRR3HcienKwgx1r4+ri7pQ49HAeAjyuqBvpHJorToPTFdTIWkVXqs
	xCxyeaL8trBKh2wUnaCrf+gQkneQZd2Zj10wwwaS2ya2BwxfnfrlcZaRugr8BnkL
	WyASw4Y3xSsTcoPhVH9AdWOgmKForQPcyTnNyyj5MDJSrB5BHc9afYWV2ZmvRIDu
	P5vsrCUyTPCHv24TLe4Ob7bJ3tlrKc0RJ59sBZFg7bZhn26xTQl5gLZEiC3s2ErA
	tgyLw==
X-ME-Sender: <xms:VdSCadVP2MH30OR1h8dWkFax2GSKzTZKUzgb2lhJR4yyO5pB9p02sA>
    <xme:VdSCaZICQfWPk40Qj-9vYoXwyKN6HMaXg0stz9trcbFlcwOhX0S7PZOdls9CKYyyN
    cp8OlkzObgeYUKY9RJkYHLcHOfzQxfqyOuZEtJWDrXNUAMmPh8>
X-ME-Received: <xmr:VdSCaZbgj51ZaQMj8q2_ltLnUSB4VyOZvc1ufN-yZRuFb_hl1LvCJvuizA3XzTgNuTmUM8ga5vOBrFje9vhZ9Jla278DVurPEdg4Nhp3mlJV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedukeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:VdSCaVRXonrb6RplrVMiPA590J-M8hza80CYNBfxD0-ALcPQmLk-nQ>
    <xmx:VdSCaZi3MMO7_XbpxrPd3vKjaGax9sQLzBHI85Q2SlxOjE9ugsekHQ>
    <xmx:VdSCaZuLc_1UNVdCfQlMd7fuoY6MQiBEqZY6oHtD08zD0pGaQ_ZyLw>
    <xmx:VdSCaTwMzHJ76pqwzf3zAjInGkdIMMuCcoQNmZHbIwx53gTbJcxJhQ>
    <xmx:VtSCaZKE0Zkxx0LWDOG1ADgZwR4l3Dj0T0T6XZ9W5NYakgoGwbZ_oCDh>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 00:08:32 -0500 (EST)
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
Subject: [PATCH 04/13] Apparmor: Use simple_start_creating() / simple_done_creating()
Date: Wed,  4 Feb 2026 15:57:48 +1100
Message-ID: <20260204050726.177283-5-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-76249-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:mid,ownmail.net:dkim]
X-Rspamd-Queue-Id: E864FE1C32
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

Instead of explicitly locking the parent and performing a look up in
apparmor, use simple_start_creating(), and then simple_done_creating()
to unlock and drop the dentry.

This removes the need to check for an existing entry (as
simple_start_creating() acts like an exclusive create and can return
-EEXIST), simplifies error paths, and keeps dir locking code
centralised.

Signed-off-by: NeilBrown <neil@brown.name>
---
 security/apparmor/apparmorfs.c | 38 ++++++++--------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 907bd2667e28..7f78c36e6e50 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -282,32 +282,19 @@ static struct dentry *aafs_create(const char *name, umode_t mode,
 
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
-	return dentry;
-
-fail_dentry:
-	dput(dentry);
-
-fail_lock:
-	inode_unlock(dir);
+		goto fail;
+	return 0;
+fail:
 	simple_release_fs(&aafs_mnt, &aafs_count);
-
 	return ERR_PTR(error);
 }
 
@@ -2572,8 +2559,7 @@ static int aa_mk_null_file(struct dentry *parent)
 	if (error)
 		return error;
 
-	inode_lock(d_inode(parent));
-	dentry = lookup_noperm(&QSTR(NULL_FILE_NAME), parent);
+	dentry = simple_start_creating(parent, NULL_FILE_NAME);
 	if (IS_ERR(dentry)) {
 		error = PTR_ERR(dentry);
 		goto out;
@@ -2581,7 +2567,7 @@ static int aa_mk_null_file(struct dentry *parent)
 	inode = new_inode(parent->d_inode->i_sb);
 	if (!inode) {
 		error = -ENOMEM;
-		goto out1;
+		goto out;
 	}
 
 	inode->i_ino = get_next_ino();
@@ -2593,18 +2579,12 @@ static int aa_mk_null_file(struct dentry *parent)
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


