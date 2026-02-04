Return-Path: <linux-fsdevel+bounces-76253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ84IeDUgml5cQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:10:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C30E1BE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D695D30886DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 05:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B88535503B;
	Wed,  4 Feb 2026 05:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="OQOjItrC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J9yqRo5O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A59B352FA7;
	Wed,  4 Feb 2026 05:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181750; cv=none; b=GBVADWyTH2eQt/X5/euuDOHEsSXxN1E+tFDlsnNpzPcx7RkEbRsO0DO68SaFQ1K1Dmvp2giezNyihyGFS2iNR3kwT3u+/ZhyCXwfkW+mBXEufEVhTSQZyQEgEDunG6dnFHaDSXe3Qqkg3b18n4Gglca4cM+DJyWIuvCn6mIqWwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181750; c=relaxed/simple;
	bh=UiKhd6cRVvyAPZpBDZyoF+ZxPC2lzBSUG/oEH68lhts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0/uv2ycIIkox5/aNga2jbaf5WnDGfSph7dynNybzlnpuNfZd24owNunl/JnLmOAc5297D96P5adNW4FTi2eAE42FeBCL5iZYpp7ph8SynFlPhXIQ2SFmUzyHZO3YBDL8VEPqa5ypkT8GideyFjxd5XXa87sKon3lsP+ty0Gxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=OQOjItrC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J9yqRo5O; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id D49981380795;
	Wed,  4 Feb 2026 00:09:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 04 Feb 2026 00:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1770181749;
	 x=1770188949; bh=5s0iIT+XNExhLX4EVMTlOFY6+XLlXqu70qn6dIJpSIM=; b=
	OQOjItrCfoqOTOO9ryHcjEe4QYUAhupdEzR6GH1O63/IqBzDPntxEPnrjmI3h+5F
	IfhyBW/7htevNA4G1WLpw0Kb0j4MU/BL0ePnzTX23vdbEAdVXeq+0J2TmjngZauA
	dwgN96K/M9BMFJkHiX+uHpK3K5VfZpuCPb+HBSbvywq1b5xy+7+dSzY8NZf6DqZc
	rgPSEbbfAe9DOS5X2S1Sw2hF2ty4itbad6DPCExZ00B1Qcjy38WZGeXKCkZ193cy
	dyLgLaBTRcknE9RQJUJRlWV4rV9WLbN4L1YshKJoSitlb5bm5PY702X9TDLiQiJH
	J6WJzEBbij31dMK/t4n1Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770181749; x=1770188949; bh=5
	s0iIT+XNExhLX4EVMTlOFY6+XLlXqu70qn6dIJpSIM=; b=J9yqRo5OJYO4ZfZ+T
	7Gf4ML/54iRezOXns/GN8Uxk0PsbmYknQwxZn7DXedfLmhQwbc8Zpuj6mF8Mh6Dy
	sjJRL9wilM2OIFEvcqz7iKZnfdAIWxNnisOvMt2E37BHJkiB9tjpKUzNmzkvTobY
	jzftr8sSkxXThzHJIGYNQ17C76kxJA8cUCGDDqmb3byTIsgXNowQok3Nn+2o+wj7
	AYgPaxwD0g8QE/c5pzNHRh5sqQT/rCEXdqBj8BYtWaYvvgeIkVcqMPGv4yx2i8Ug
	NkjcH1kGHHDQBn73lZc4sPUIcZupFCsm1sXUBroYtz0xAhhj3nRqPToJ8rXK93oY
	AyKzw==
X-ME-Sender: <xms:ddSCaW0j-URjR_drkKKkPmOYLC0sTlI6Nzjb6mvTo0Ru0jUYa0qsuQ>
    <xme:ddSCaUqqdSgcQS_Ju7yL_DTW43JnuAIoK9rN_EQxub6jEOiaKgm1w8DEvOKJVKs1s
    td15Jwdsl8fgYd4qjmmWnNoqop8oP8wPU9kSBhrkBdbbmKmmw>
X-ME-Received: <xmr:ddSCae6ZSuclrSjg9piRz3N1cKT_JUTQUT29dQORYkCVYJIU7-Cvm8RO1NLQTHIE4fCK4K_vd2-kLqjxhFUAYj5SUYtgBe8gJGWBFK1nnFb8>
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
X-ME-Proxy: <xmx:ddSCacxRyM6a6y8rE-CTWUMh8J0NemEKS7qekVuHSkjvUKqj1ZPvLQ>
    <xmx:ddSCabAsBK3L4dAbtfHsw3Yz-x8OvL5et-Pe2N8le48QZtNbPTPZRA>
    <xmx:ddSCadP2z0ln1X4CGH1K326HUnULH4QyJ9ULUWh_twYUV_ZmM_vs-A>
    <xmx:ddSCaRQDGmbnsRg2SRodNw4sdFUrmCfmjatXLEsRRlp8wkMKqzhn1A>
    <xmx:ddSCaYr5yNzU31bba9C-4w3hzqa5ml07WNbt9_h56b2JpHzlwpPo6PDH>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 00:09:04 -0500 (EST)
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
Subject: [PATCH 08/13] ovl: Simplify ovl_lookup_real_one()
Date: Wed,  4 Feb 2026 15:57:52 +1100
Message-ID: <20260204050726.177283-9-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-76253-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:mid,ownmail.net:dkim,messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,brown.name:replyto,brown.name:email]
X-Rspamd-Queue-Id: 16C30E1BE1
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

The primary purpose of this patch is to remove the locking from
ovl_lookup_real_one() as part of centralising all locking of directories
for name operations.

The locking here isn't needed.  By performing consistency tests after
the lookup we can be sure that the result of the lookup was valid at
least for a moment, which is all the original code promised.

lookup_noperm_unlocked() is used for the lookup and it will take the
lock if needed only where it is needed.

Also:
 - don't take a reference to real->d_parent.  The parent is
   only use for a pointer comparison, and no reference is needed for
   that.
 - Several "if" statements have a "goto" followed by "else" - the
   else isn't needed: the following statement can directly follow
   the "if" as a new statement
 - Use a consistent pattern of setting "err" before performing a test
   and possibly going to "fail".
 - remove the "out" label (now that we don't need to dput(parent) or
   unlock) and simply return from fail:.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/export.c | 61 ++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 83f80fdb1567..dcd28ffc4705 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -359,59 +359,50 @@ static struct dentry *ovl_lookup_real_one(struct dentry *connected,
 					  struct dentry *real,
 					  const struct ovl_layer *layer)
 {
-	struct inode *dir = d_inode(connected);
-	struct dentry *this, *parent = NULL;
+	struct dentry *this;
 	struct name_snapshot name;
 	int err;
 
 	/*
-	 * Lookup child overlay dentry by real name. The dir mutex protects us
-	 * from racing with overlay rename. If the overlay dentry that is above
-	 * real has already been moved to a parent that is not under the
-	 * connected overlay dir, we return -ECHILD and restart the lookup of
-	 * connected real path from the top.
+	 * @connected is a directory in the overlay and @real is an object
+	 * on @layer which is expected to be a child of @connected.
+	 * The goal is to return a dentry from the overlay which corresponds
+	 * to @real.  This is done by looking up the name from @real in
+	 * @connected and checking that the result meets expectations.
+	 *
+	 * Return %-ECHILD if the parent of @real no-longer corresponds to
+	 * @connected, and %-ESTALE if the dentry found by lookup doesn't
+	 * correspond to @real.
 	 */
-	inode_lock_nested(dir, I_MUTEX_PARENT);
-	err = -ECHILD;
-	parent = dget_parent(real);
-	if (ovl_dentry_real_at(connected, layer->idx) != parent)
-		goto fail;
 
-	/*
-	 * We also need to take a snapshot of real dentry name to protect us
-	 * from racing with underlying layer rename. In this case, we don't
-	 * care about returning ESTALE, only from dereferencing a free name
-	 * pointer because we hold no lock on the real dentry.
-	 */
 	take_dentry_name_snapshot(&name, real);
-	/*
-	 * No idmap handling here: it's an internal lookup.
-	 */
-	this = lookup_noperm(&name.name, connected);
+	this = lookup_noperm_unlocked(&name.name, connected);
 	release_dentry_name_snapshot(&name);
+
+	err = -ECHILD;
+	if (ovl_dentry_real_at(connected, layer->idx) != real->d_parent)
+		goto fail;
+
 	err = PTR_ERR(this);
-	if (IS_ERR(this)) {
+	if (IS_ERR(this))
 		goto fail;
-	} else if (!this || !this->d_inode) {
-		dput(this);
-		err = -ENOENT;
+
+	err = -ENOENT;
+	if (!this || !this->d_inode)
 		goto fail;
-	} else if (ovl_dentry_real_at(this, layer->idx) != real) {
-		dput(this);
-		err = -ESTALE;
+
+	err = -ESTALE;
+	if (ovl_dentry_real_at(this, layer->idx) != real)
 		goto fail;
-	}
 
-out:
-	dput(parent);
-	inode_unlock(dir);
 	return this;
 
 fail:
 	pr_warn_ratelimited("failed to lookup one by real (%pd2, layer=%d, connected=%pd2, err=%i)\n",
 			    real, layer->idx, connected, err);
-	this = ERR_PTR(err);
-	goto out;
+	if (!IS_ERR(this))
+		dput(this);
+	return ERR_PTR(err);
 }
 
 static struct dentry *ovl_lookup_real(struct super_block *sb,
-- 
2.50.0.107.gf914562f5916.dirty


