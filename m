Return-Path: <linux-fsdevel+bounces-78324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFCFL8Alnmn5TgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:27:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9C118D2A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F72E3067128
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E46334A3BC;
	Tue, 24 Feb 2026 22:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="DHCrV62+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S4SHo91X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFD43446DA;
	Tue, 24 Feb 2026 22:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972026; cv=none; b=I0XRHzS7Q6D1GP6GNuadocXqIFYJJVGVa8LrXV0cV4OWRnqfnxwwhbAdhPbyhrZ10R03JElMa3iweNO7Anqj//WGPlppsnO6MJxmp/6+aG9Q//VLVG7RPDWmEBJNHI49PpHfVjhKItmTrQ6ZUZ/vb6727id9t2m5ae6UqiAHRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972026; c=relaxed/simple;
	bh=ojKvC9TV5lLHEchjVZ+jGT9aO+3WC+YXqxZ4cm0jL2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ttc4ydse/K4/nTlDQJpJBzWaDgqHp0txvS0yw1NC/u+d0AfqRxR7wZGBaLE7CprWvyeioMmtSH1M1COenCr3G1Y/JBcaR1YkS5Qn8czFpZs/qCsaKU6jOXXVvTW4UjGRqkHw+6Dzf5vQf47Tl0yGtXxyTHZWjwBKie3yDINhEdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=DHCrV62+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S4SHo91X; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id 1883D138052C;
	Tue, 24 Feb 2026 17:27:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 24 Feb 2026 17:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771972025;
	 x=1771979225; bh=7mZv59/XBHyrbXM2e8385B3rlZeYZjJwl/wrmf7v+4o=; b=
	DHCrV62+FVQSKKY9oPA5I9UMEE9pC/8WEvW9kUHBtA3frmmP/cPBf0zd6bJbIqbC
	vN5knIKY45dLrV5XJHCjsfef/l9dWsv86b5HD6hgOTiUThfLND+2pic44c6BUycP
	jXtyYZfcm7lGlO64UbkAq2ExoRXoKUuQlEWQn0+ZMzy6eIXv5O8G5fQ5z1xyZIV7
	8uQLN9ckPvBNjC9O3XaYvG+R9Mfn/pPZ2eh/4nfsLBB0/xGbcH09yL3qW+uTTNFe
	k9DTNOyKWyS2VWdTrAIqNPKPwGhj5dNQi0vWyZ0rjK1xZuOZCnCWfEHMF0a0/yr4
	28g4CInm6Bzvmd4QsW7rJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771972025; x=1771979225; bh=7
	mZv59/XBHyrbXM2e8385B3rlZeYZjJwl/wrmf7v+4o=; b=S4SHo91XvY7j79cy/
	WD7j/EIok8aqeOa0BdQBWd3+PAk0+opZiEQ0fmdJ/s48/8lo6yX2834cVkUmQR7l
	ajXFnqoFYiOed1A6cXIDwMYnkUueynatL3IWxytkEqRWL8GixYl5+bkFhAohu42r
	g/5Yr/YbCPOUUyCb7OMB2znUuY6eFTLcT9mXNgtJZ93LMl73N1enpxu94/2f87U9
	yI5AXgorYVBZwJtgIuYDfX+zTelz5ydj/xW1HHRgU75QPK0m7elj2A27UDDGauT0
	K4iql0+Z59N7bNch+sMKIjepH5qgV12o9TlaBvg4J76NH41YOV+cH3YyBf5J/0eD
	P9UaQ==
X-ME-Sender: <xms:uCWeaXheA8vKdner4da0s7BnTNIb8PKGmMmtG1lD62cH8D7Tp8RdBg>
    <xme:uCWeaX9QGWwgJ54Q7QeP9Xz9HCTG3uqib8IHkHmIKz7kaJDRm3JWx8PyKor-pxn9y
    yF82_-AD0zqr6UUW01oPihplckDwdp-WDiHaJ2ZHT1cv37wU-s>
X-ME-Received: <xmr:uCWeafmf6mRLAvdJ_Uvcdqzvx0pb1O847OpiP0-0H5MkSIzrdbVPbeBuDui2jEazYX4jxlk9V5Cw5bL1MM5CmrAJLrkoiZbrFGvs4Z5N_Knt>
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
X-ME-Proxy: <xmx:uCWead3jB53TyJlqfFS71Lp4xP-NPd9bqX8EZF4s_hqe9-kAASjdGQ>
    <xmx:uCWeacTlmHfetoTdsHPd7CShZFuAPwpmZHMzJV57NgNSDBR2CTg3NQ>
    <xmx:uCWeaVP-gBKua4IdJsRwRu9akTPXjBjBlMoRDaUMDTuy1utex_JoWQ>
    <xmx:uCWeaYgB4IPPmkOycaAc71gfR7a2uZvl6PVYl38GI6ew8gZceTxMWA>
    <xmx:uSWeaa76MDi0L1OATF7Fsrq1l2CkRXKnqiOO8LN8hHYif0ZhXT-molBE>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:26:58 -0500 (EST)
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
Subject: [PATCH v3 08/15] VFS: make lookup_one_qstr_excl() static.
Date: Wed, 25 Feb 2026 09:16:53 +1100
Message-ID: <20260224222542.3458677-9-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-78324-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 6C9C118D2A3
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

lookup_one_qstr_excl() is no longer used outside of namei.c, so
make it static.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst | 7 +++++++
 fs/namei.c                            | 5 ++---
 include/linux/namei.h                 | 3 ---
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 52ff1d19405b..1dd31ab417a2 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1361,3 +1361,10 @@ to match what strlen() would return if it was ran on the string.
 
 However, if the string is freely accessible for the duration of inode's
 lifetime, consider using inode_set_cached_link() instead.
+
+---
+
+**mandatory**
+
+lookup_one_qstr_excl() is no longer exported - use start_creating() or
+similar.
diff --git a/fs/namei.c b/fs/namei.c
index 11c9a4a6c396..a5daa62399d7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1782,8 +1782,8 @@ static struct dentry *lookup_dcache(const struct qstr *name,
  * Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
  * Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
  */
-struct dentry *lookup_one_qstr_excl(const struct qstr *name,
-				    struct dentry *base, unsigned int flags)
+static struct dentry *lookup_one_qstr_excl(const struct qstr *name,
+					   struct dentry *base, unsigned int flags)
 {
 	struct dentry *dentry;
 	struct dentry *old;
@@ -1820,7 +1820,6 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 	}
 	return dentry;
 }
-EXPORT_SYMBOL(lookup_one_qstr_excl);
 
 /**
  * lookup_fast - do fast lockless (but racy) lookup of a dentry
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 58600cf234bc..c7a7288cdd25 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -54,9 +54,6 @@ extern int path_pts(struct path *path);
 
 extern int user_path_at(int, const char __user *, unsigned, struct path *);
 
-struct dentry *lookup_one_qstr_excl(const struct qstr *name,
-				    struct dentry *base,
-				    unsigned int flags);
 extern int kern_path(const char *, unsigned, struct path *);
 struct dentry *kern_path_parent(const char *name, struct path *parent);
 
-- 
2.50.0.107.gf914562f5916.dirty


