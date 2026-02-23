Return-Path: <linux-fsdevel+bounces-77891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PERF/Kqm2mu4QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:18:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07289171421
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 792CD3038517
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655FD257423;
	Mon, 23 Feb 2026 01:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="COIrnCuI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qDOVUob1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACECE231C9F;
	Mon, 23 Feb 2026 01:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771809233; cv=none; b=RFsyepYh7JCh3hZCgvDn4wirK3BOs2FfYAS3YlpUsXSuTAcXS9bk1P+z6Xg1ZGcNcR4wmADK3/qYvEkPgjhvsalF81S+vOc9aGMlsII7Q+psKraTEHE1fVoq/crTsQA2nJ3lIzJRFUOFe0OWn9Fzakqu6XxauX2CynGM4f/IO6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771809233; c=relaxed/simple;
	bh=XjOWdC+g4FNsjlHlt6f2jss0p2+dkDuiZErV2U861I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTzPJJvsuLKwtu7FFIixwfMOBY6dJ435uT7BVldMd9+rfFuVEPjxojFklz6juqvjAGozIdcg4XnNr5028jsn8KX3caVdkOK9o8+JsBlkj04nBmyoWNe7m4mhH/630FVJ+UjiRbjuy1Ak+jP+P1Gxuax7yXkvUZs4twJD0nd29kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=COIrnCuI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qDOVUob1; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 25BDB13807AC;
	Sun, 22 Feb 2026 20:13:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 22 Feb 2026 20:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771809232;
	 x=1771816432; bh=ml1LiguIrJHeWfdJIINaTOuxtTcyMpy4ph9bxhYGeRY=; b=
	COIrnCuIhyBmcEbOHolu6EeslkemNH1XFmqSMkEWj0PEU8jeHq3vddKgIkyIzAeA
	LZJ0CLcS9NQPpdUJbW4rswtgt7padwgTQ5SL4/62XzUTwE5B2rKkbrmcgC1daYSX
	L9pklLkeEnykthJdkggHE4L3yoDgBnNQDorHw3vCjwkqE+y8g5xuH/2QJluFTTjc
	Ck++t4GkfGJ56WLS9RquhT2KJHB86+JqS1fsEQ7imW6d6i2r9YKu/OOv3KavLOjN
	+AkGe8xiZPusauaOU8LwxjwwnCGD/ZUH4a01XuOO4/G7MZtLHNU+ZIoNGdFbBNmM
	0K2ZNACsr8O/y+7T/P89Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771809232; x=1771816432; bh=m
	l1LiguIrJHeWfdJIINaTOuxtTcyMpy4ph9bxhYGeRY=; b=qDOVUob1aQNH9fKFM
	fTfGOsurhB3PMpUX6gvkYTI+/a/dxyojQU3vVlf7BiWMfcl6jLs6mMq3j9E2JQPJ
	2Z0T7gaMvvaNbP6CbHTMtwkzpN45/0V5iNrjF7NnvpDezvm8gNYMY/Pr9dydIEdQ
	SGa6DP941VRn/7ePqWMleZfbQbAU3jdx+eD8C2kqDGDQBn/NgXbQdZ9bD0Ygi9zh
	QCcn3L1cM2uL1rXleTdxG5pGnBEKT/1IczkuU9byzVCjQFD3NBRIrudunYsyhin9
	kAwJtOrN1C3xZcqTVwo/Ph8Kz6BaDsZXWZB3o1x4U8gnYM6Tai7nrX48dyxov98l
	6E1nw==
X-ME-Sender: <xms:z6mbaT4R9pIdfV1s7B-UzfuR26IihBGiVa-oOG4YzYr_KZpzqLgbiw>
    <xme:z6mbac1SlR2MilSCggT2w-KfN-AjAIwXwTVbKf7zOOjcEilKGz0nSjWuQ7bGp0qht
    qUp5dne2vY6w1UPqN6hQ21R1BKCH9DU3BRoLPg3e7bVdYen-w>
X-ME-Received: <xmr:z6mbaS-vsSRX_Je4pb0JoY8z35fIgJQE7HvF9Ot5N_VToubjqWnJTHALE_yN3m-3fgQ5u7NayjwyTSKJGy1SigK7SBHOuhoDqvdH2bNJ3_Bk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehkeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:z6mbadvhO_Z6Ok08_QW4EUSplEKeeBIq9_rzWtYCqnsBqTsnCbsFug>
    <xmx:z6mbaeo-FpP_ADCNjxg0haPpa2yxFSCqX-IL-9RyWWy-sDkjqP5FfA>
    <xmx:z6mbaYEXAIgVAttcS4ZiwN0152kIEdt_JeGXdcPgGfLPEs44xGCOhA>
    <xmx:z6mbaR4OBdZCBx5jJP9v2DXHb1mrkMojwt7Gg9PEEibcCPdh2wqj3Q>
    <xmx:0KmbaUyJ_IvaaCgpW-laJ1pogNpwAArH52miXAnBFYRvoT5bOmQt0gHE>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 20:13:45 -0500 (EST)
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
Subject: [PATCH v2 09/15] ovl: Simplify ovl_lookup_real_one()
Date: Mon, 23 Feb 2026 12:06:24 +1100
Message-ID: <20260223011210.3853517-10-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260223011210.3853517-1-neilb@ownmail.net>
References: <20260223011210.3853517-1-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-77891-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:replyto,brown.name:email,ownmail.net:mid,ownmail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 07289171421
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/export.c | 71 ++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 83f80fdb1567..b448fc9424b6 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -349,69 +349,64 @@ static struct dentry *ovl_dentry_real_at(struct dentry *dentry, int idx)
 	return NULL;
 }
 
-/*
- * Lookup a child overlay dentry to get a connected overlay dentry whose real
- * dentry is @real. If @real is on upper layer, we lookup a child overlay
- * dentry with the same name as the real dentry. Otherwise, we need to consult
- * index for lookup.
+/**
+ * ovl_lookup_real_one -  Lookup a child overlay dentry to get an overlay dentry whose real dentry is given
+ * @connected: parent overlay dentry
+ * @real: given child real dentry
+ * @layer: layer in which @real exists
+ *
+ *
+ * Lookup a child overlay dentry in @connected with the same name as the @real
+ * dentry.  Then check that the parent of the result is the real dentry for
+ * @connected, and @real is the real dentry for the result.
+ *
+ * Returns:
+ *   %-ECHILD if the parent of @real is no longer the real dentry for @connected.
+ *   %-ESTALE if @real is no the real dentry of the found dentry.
+ *   Otherwise the found dentry is returned.
  */
 static struct dentry *ovl_lookup_real_one(struct dentry *connected,
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
-	 */
-	inode_lock_nested(dir, I_MUTEX_PARENT);
-	err = -ECHILD;
-	parent = dget_parent(real);
-	if (ovl_dentry_real_at(connected, layer->idx) != parent)
-		goto fail;
-
-	/*
-	 * We also need to take a snapshot of real dentry name to protect us
+	 * We need to take a snapshot of real dentry name to protect us
 	 * from racing with underlying layer rename. In this case, we don't
 	 * care about returning ESTALE, only from dereferencing a free name
 	 * pointer because we hold no lock on the real dentry.
 	 */
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


