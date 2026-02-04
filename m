Return-Path: <linux-fsdevel+bounces-76254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPH2IvDVgml5cQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:15:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F1EE1D67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB1C2308C2BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 05:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EE23557FC;
	Wed,  4 Feb 2026 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="nCx5KwkU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A3i3ZoJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB30353EF6;
	Wed,  4 Feb 2026 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181758; cv=none; b=Xw7A3RbYigVU1cZmlxVd88uaVYtzWhdBYvISiRZzKLSP86ZATw/agYWGekNLTIo6u/sWH/ohaTQqYlMaDMeSOds3rr6ssW835cLX/pcF/25UM+FJPs/s+NHQ8xrkbiz4peiIBU2LZFv2PEOv6sIyIqTHAjiiK7/tx/820j7t/Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181758; c=relaxed/simple;
	bh=rH5ToO3KgPItJ2E1apkxbcYKMkFVXEoaa92XHEKaQxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQ1xRqbQ6TRn4owcta2vIA3n5Vh3iSv0Q3W4q4G6KvR+WkRDaaQ2UuYrnYE8t2wGECRaW9IVRavRoOjJqVRrdzBdM81KCrodpKPPclEYVOS71ZyYH2cc3uFylEMICWFU57aZKp9/XQYsl5e5zPM6frQf/OJqpdZwusiodVwLCVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=nCx5KwkU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A3i3ZoJq; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 6BE721380795;
	Wed,  4 Feb 2026 00:09:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 04 Feb 2026 00:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1770181757;
	 x=1770188957; bh=pN+yLpO/IC8bNZZqLlpN4OtI3NJ62DZfY8eOdtW8yW4=; b=
	nCx5KwkUvmOY2D+QWH/GTtAR4AsL/vjdDV+XleINbfEAk2Mlpe+XWaJLmCYXPgfw
	h1jfsrIZxighrad8sQB2zkKaQZ+XvpR3vUPyR2AQ/EINNlTC14yV8ljs82jDF8zY
	h55ztsImqG81i9MkG5T00sTYYS+FLyXDQnTGok49TiaflaCT9jkiXv+Y0Huy4dUI
	Qo5/OhlhAk62AIXd9vMdKS1lXwkd9JXays+ao+ATq2Y6G40VMdIqcwlaUvK8jIwT
	UNpIvlOHk8qegoUJVbmV+7IxW4Lsr3Ulk7HeG8ijr1LcW/WfY3SdO7zkn9uXauUT
	r5hRyq26yjoS4rdI0WQuWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770181757; x=1770188957; bh=p
	N+yLpO/IC8bNZZqLlpN4OtI3NJ62DZfY8eOdtW8yW4=; b=A3i3ZoJqkXJfDI1EQ
	JoXgeaBcZtTKsdMVLXUPPte9p4pifxnptHhaRHsz5gMZ7lHOXOYCW5siPKDs+hTi
	uC+auPjuM9uI1tzaN25+BcHHVaupOtOWW+8RLwXz7o2lYgYKZEzL30uOpBSX34X0
	C7Rml1qF5MzgA2hg008FKfAgMPYYJM04YYBUEosOVcT5mQzdCWTJBCes80x+Hwka
	VthYG/fHgYkskpZ9dTk7j4e84MV/pu2aJ0pz8cOPMzYArYV38+faN3yMU1Ztqwsa
	fEzldh7JcohcdK/0UntB4lRWXljH3/JOMPhkAxdHXAgxhdC9TXX7+5ymB3NIptcN
	q0C9A==
X-ME-Sender: <xms:fdSCaUjzQJd0i0c2xN-hZUFHfcffyG7XsQ5j_23MIZUnaSKnjYNBlw>
    <xme:fdSCaYnsqz184Hw98WwGlR_YkkaZEBenCi67fxiLereBhdKioyegy-lkcgy_O0i-o
    b3xf0UiGN62SfWsXlAp3rDi_vtOq3KRLlr3jww7UqnsJWa_194>
X-ME-Received: <xmr:fdSCacFo_WLyyn9cvSdhmUPiAgjgjEBCRpkbKFQNCb_jsmmkkf1PI4Q1P4Pw-ZHg68_g_elTZ3erAoM8QvVJvWwsy6xwxu4J5lNX13Uxw0ex>
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
X-ME-Proxy: <xmx:fdSCaaPzP8RoZBAwmq6IcdpW7mmFbv0a7f3RRWVG4Y4to60p3-B4Iw>
    <xmx:fdSCaTs_j1AtY2XikJJJNddtvkhITzILQTtWe_Brf8KcqhB-aoNWZg>
    <xmx:fdSCaQK-04B94Ar9wTfvs24OmDbUOvJ1tpiWjh32WvX8oOjOIFJRxg>
    <xmx:fdSCaRcM_pgyTPRC35CpoRHVLpaZXOcwW8gmAm6P-5otSLeR4MDU5g>
    <xmx:fdSCaTFA7PpTxgy_c1_WUCyvTXLmWWYCgpWt-X2gS7VaFMMrYgOQY09D>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 00:09:11 -0500 (EST)
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
Subject: [PATCH 09/13] cachefiles: change cachefiles_bury_object to use start_renaming_dentry()
Date: Wed,  4 Feb 2026 15:57:53 +1100
Message-ID: <20260204050726.177283-10-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-76254-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:mid,ownmail.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,brown.name:replyto,brown.name:email]
X-Rspamd-Queue-Id: 14F1EE1D67
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

Rather then using lock_rename() and lookup_one() etc we can use
the new start_renaming_dentry().  This is part of centralising dir
locking and lookup so that locking rules can be changed.

Some error check are removed as not necessary.  Checks for rep being a
non-dir or IS_DEADDIR and the check that ->graveyard is still a
directory only provide slightly more informative errors and have been
dropped.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/cachefiles/namei.c | 76 ++++++++-----------------------------------
 1 file changed, 14 insertions(+), 62 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index e5ec90dccc27..3af42ec78411 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -270,7 +270,8 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 			   struct dentry *rep,
 			   enum fscache_why_object_killed why)
 {
-	struct dentry *grave, *trap;
+	struct dentry *grave;
+	struct renamedata rd = {};
 	struct path path, path_to_graveyard;
 	char nbuffer[8 + 8 + 1];
 	int ret;
@@ -302,77 +303,36 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 		(uint32_t) ktime_get_real_seconds(),
 		(uint32_t) atomic_inc_return(&cache->gravecounter));
 
-	/* do the multiway lock magic */
-	trap = lock_rename(cache->graveyard, dir);
-	if (IS_ERR(trap))
-		return PTR_ERR(trap);
-
-	/* do some checks before getting the grave dentry */
-	if (rep->d_parent != dir || IS_DEADDIR(d_inode(rep))) {
-		/* the entry was probably culled when we dropped the parent dir
-		 * lock */
-		unlock_rename(cache->graveyard, dir);
-		_leave(" = 0 [culled?]");
-		return 0;
-	}
-
-	if (!d_can_lookup(cache->graveyard)) {
-		unlock_rename(cache->graveyard, dir);
-		cachefiles_io_error(cache, "Graveyard no longer a directory");
-		return -EIO;
-	}
-
-	if (trap == rep) {
-		unlock_rename(cache->graveyard, dir);
-		cachefiles_io_error(cache, "May not make directory loop");
+	rd.mnt_idmap = &nop_mnt_idmap;
+	rd.old_parent = dir;
+	rd.new_parent = cache->graveyard;
+	rd.flags = 0;
+	ret = start_renaming_dentry(&rd, 0, rep, &QSTR(nbuffer));
+	if (ret) {
+		cachefiles_io_error(cache, "Cannot lock/lookup in graveyard");
 		return -EIO;
 	}
 
 	if (d_mountpoint(rep)) {
-		unlock_rename(cache->graveyard, dir);
+		end_renaming(&rd);
 		cachefiles_io_error(cache, "Mountpoint in cache");
 		return -EIO;
 	}
 
-	grave = lookup_one(&nop_mnt_idmap, &QSTR(nbuffer), cache->graveyard);
-	if (IS_ERR(grave)) {
-		unlock_rename(cache->graveyard, dir);
-		trace_cachefiles_vfs_error(object, d_inode(cache->graveyard),
-					   PTR_ERR(grave),
-					   cachefiles_trace_lookup_error);
-
-		if (PTR_ERR(grave) == -ENOMEM) {
-			_leave(" = -ENOMEM");
-			return -ENOMEM;
-		}
-
-		cachefiles_io_error(cache, "Lookup error %ld", PTR_ERR(grave));
-		return -EIO;
-	}
-
+	grave = rd.new_dentry;
 	if (d_is_positive(grave)) {
-		unlock_rename(cache->graveyard, dir);
-		dput(grave);
+		end_renaming(&rd);
 		grave = NULL;
 		cond_resched();
 		goto try_again;
 	}
 
 	if (d_mountpoint(grave)) {
-		unlock_rename(cache->graveyard, dir);
-		dput(grave);
+		end_renaming(&rd);
 		cachefiles_io_error(cache, "Mountpoint in graveyard");
 		return -EIO;
 	}
 
-	/* target should not be an ancestor of source */
-	if (trap == grave) {
-		unlock_rename(cache->graveyard, dir);
-		dput(grave);
-		cachefiles_io_error(cache, "May not make directory loop");
-		return -EIO;
-	}
-
 	/* attempt the rename */
 	path.mnt = cache->mnt;
 	path.dentry = dir;
@@ -382,13 +342,6 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 	if (ret < 0) {
 		cachefiles_io_error(cache, "Rename security error %d", ret);
 	} else {
-		struct renamedata rd = {
-			.mnt_idmap	= &nop_mnt_idmap,
-			.old_parent	= dir,
-			.old_dentry	= rep,
-			.new_parent	= cache->graveyard,
-			.new_dentry	= grave,
-		};
 		trace_cachefiles_rename(object, d_inode(rep)->i_ino, why);
 		ret = cachefiles_inject_read_error();
 		if (ret == 0)
@@ -402,8 +355,7 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 	}
 
 	__cachefiles_unmark_inode_in_use(object, d_inode(rep));
-	unlock_rename(cache->graveyard, dir);
-	dput(grave);
+	end_renaming(&rd);
 	_leave(" = 0");
 	return 0;
 }
-- 
2.50.0.107.gf914562f5916.dirty


