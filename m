Return-Path: <linux-fsdevel+bounces-78326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Pg/LPQmnmn5TgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:32:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5325F18D5B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84B383156E18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9AD34B404;
	Tue, 24 Feb 2026 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ac7NN+mS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jypiJw/C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2276E33A9C4;
	Tue, 24 Feb 2026 22:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972043; cv=none; b=LMeJOWpIk9NLCmQReAvdYpwLyc5kQ18rv+2I4vGRhm7QiptuZ6jYlW0soJHoDYG2jVemhexdWCpBmJSpKlWc33Q7iltStLdY2X6gFqUF0u2HTasJJxYZ8tPLhaSbZaCxw31WMwPrHunD1A/qrOfAxLhQA3csVAVKofT7pssRADQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972043; c=relaxed/simple;
	bh=jlJ9DWdOy/WeR7QWrpmvr1QyEtCF9bsrk1spWZE7J5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=untUMevZ59suF8PyoHFpRwbo8ntR+sQjtFS096TSnpm4J2mkw8kPVR3EUQcCMeajZ9mI21ajnw8LqiQXwWD4krUPHM/Qwey7fWon5GlJKlNVo5ugGCwf4Se99bFuUC08ZDaGXx12YnKgmeVZsR3P9wTsENcnw51v7CeqVdURZKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ac7NN+mS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jypiJw/C; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 916FE138052C;
	Tue, 24 Feb 2026 17:27:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 24 Feb 2026 17:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771972041;
	 x=1771979241; bh=Vj23dTx8hYfvjWUpL8KmWQGYvEI277aBCAy+9LFoa/c=; b=
	ac7NN+mS0EFDNPiwo8c907vK2y43OM8r/UqvyTneeok+wx5FRLRj5S5ME/gTb2q9
	rOgeRuvFPd/YBkvTtgtIN9g/YNVSthdjHTXH1CXV4m1hCjK2Ih0x5hr/wBQsri9D
	sv35ybqI2JJz9bjbVtyPYGgAfwZ0oLGDA/1bP2KBODyCemS4m3YiJtZc2t2RGjRc
	J95k8sMNiltNfqtINj6Yfv7ap9xGF2QpmDPtheE5p/9BArMglMMWU6GBq0loiVW/
	yp4K0D9rx9U4BAMPc79xwJUtT1SKg6jvviHif7GIVhdRyEBRcVEVoBOIhbTLDxN2
	ORt0tzWprp366sHlIq7m3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771972041; x=1771979241; bh=V
	j23dTx8hYfvjWUpL8KmWQGYvEI277aBCAy+9LFoa/c=; b=jypiJw/CZ95Rcl/y3
	0NqKjvCvJ5capr659QfzFe+Lx3zRg9R5LmtT22t1tLEbomCDyDfquLkNXSxHMr6+
	7GgORgvf4WHNEZN7WLZTE07hyB+GSX+/2kZyxzduA8zY9jh4l9QLDaeObtOTr/Ti
	XPWLoYkNG/q26UVRUxGUbVwEu3NZr3YIjsZE1Yyo58UJGjhVrp4d+3R6XhsrQOJC
	R86kYOmWCwp8xTD15fGfk53eYxGpnLHCcAELQPwWrGg2R9rN0RHFVkmhFHgPN3Ji
	XKZ9N5qE5kjzNcz4aIXyoVi12aoHadXqz0oCGd7V3sQhIc6FZt0Au3IRQX5NoCWI
	oKZDA==
X-ME-Sender: <xms:ySWeaWSDZskC3H-i4WasjYdZYUyzLMXw4AdGUkmUv9HELq22arUuYg>
    <xme:ySWeafsQDIE4csTEAvH_MK4zK7uN42mig0IlVhuF5OCkCw4dazc1PVi7pCCcUJvG6
    Athv-uN-zZ7tzBYvNxWdSTQJ4da7vrNFAW2LXyun1SVh-gHDFA>
X-ME-Received: <xmr:ySWeacX8hWODJd_kkiF2ZwEAR-BVuAapimlKFj-3DTqmgNvAse1yfjahtvRWEgePePdXLTQnXzAOytaCC-eXPju_oQTYhHYJQju18aZ0XRKS>
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
X-ME-Proxy: <xmx:ySWeabmunQ7h81DOgUqvNEEK9eXJ0RjDGhCV7HOOv2qI7voTMW2ZuQ>
    <xmx:ySWeaXDtcTMy3nn8uoPvcJYpic4sXlfOejDQlGbSrO0bKudTdz8AAw>
    <xmx:ySWeaY_KXUUNSOQT7puTdOP2sFEa83kdLUIXVcTyznUBNOp4DHZySA>
    <xmx:ySWeaRTfsNoDqnnc0JGxb3CNDJ_QeVfukpwOQFOVjO-npS0LQGK7CQ>
    <xmx:ySWeadaHXqw92pRRHGG_5eOw4dBPE3p-nzJOnVcwQ5l0TongogFZZTf4>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:27:15 -0500 (EST)
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
Subject: [PATCH v3 10/15] cachefiles: change cachefiles_bury_object to use start_renaming_dentry()
Date: Wed, 25 Feb 2026 09:16:55 +1100
Message-ID: <20260224222542.3458677-11-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-78326-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:mid,ownmail.net:dkim,brown.name:replyto,brown.name:email,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5325F18D5B6
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

Rather then using lock_rename() and lookup_one() etc we can use
the new start_renaming_dentry().  This is part of centralising dir
locking and lookup so that locking rules can be changed.

Some error check are removed as not necessary.  Checks for rep being a
non-dir or IS_DEADDIR and the check that ->graveyard is still a
directory only provide slightly more informative errors and have been
dropped.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


