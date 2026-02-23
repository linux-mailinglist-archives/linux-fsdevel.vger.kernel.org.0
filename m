Return-Path: <linux-fsdevel+bounces-77883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC5jAJepm2l94QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:12:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FECB171136
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF570301DEFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B502594BD;
	Mon, 23 Feb 2026 01:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ZnVT2UVN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nV58vRES"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE5F1E3DCD;
	Mon, 23 Feb 2026 01:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771809168; cv=none; b=FXdh7RKHB3plRIn1WHfXSdUhcG1+JNCRAtrKYkX59EfvUSHev74MCgdc+RP45mYnRrS0CPhyBt5XMwQsjp0701aVIyHk28qyNjSXqWQXmXrCriD7WlPYvtoi/4Vj2EbcpZ3Ldwfv8zeZ67EOxWRHjWSqK1+lMpBR/MMR121ISuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771809168; c=relaxed/simple;
	bh=fDGm93ACAJKTtjqMT6L3/YB0cVc21gyBhXcFCFCqfhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vs2QE7XWtH6nkzlpci65JmNMPbh1hHzWRieJ+OW/Ia7sxBqp3LUlC5s8kN7N2Y1cglhj5KHqSGBjircQJojRkcDuIH4056BfxTW8+PZuAfnXeSXuEMCOmwD5iUZ+AJlMJtWGgXrnNC6vPZaiYVI+CiKieCqhGVsebGoiSGtA5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ZnVT2UVN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nV58vRES; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 160AB13807AC;
	Sun, 22 Feb 2026 20:12:45 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 22 Feb 2026 20:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771809165;
	 x=1771816365; bh=23NReJbZM+lIJGPHnKuksenVFNj8L/NWqFsZpeZ9f4c=; b=
	ZnVT2UVNJDW4hZXXnaht3bVT69psY3a9JSNyYo64tNT7X9q5jyT96Ez+Kucrox2F
	QCedlpMmqmN8yhpm6R+0sZoAmU32h9YfK9K6Bbe3LO7NuE+9xtiRtxkMyXlkopIW
	YF65OaWyGN9MEA5CxfuAZsXFX7MlBaYVde7gcMCXaW1lVrypt9OoYGatFNm+5kN3
	HsJLLXtPvB5itjvMrQmnAHM1AfOItr8pfneMEE+gJes1Bg+cnbAQgtFSSKiBay3e
	L8mLXhfap5IKSxtOVGxeoMWlmcKdpXlo8vQPZz8NSMz+zIHgT+FLbeU2s6j2ennr
	UGs788065Ckah8IQl7ezlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771809165; x=1771816365; bh=2
	3NReJbZM+lIJGPHnKuksenVFNj8L/NWqFsZpeZ9f4c=; b=nV58vRESjdk43UqyA
	eRiGYG7oG3VAe3YQranjkOfZwMU50wsn6QaOpYa18k2+gQO5p461zq7B3hleEahT
	lHFMPo6qpMclo4x3eL9xqzEr5j0+wm3ibrL3EBsCllFXW3t1b1zgpi7/9LSdc9ET
	TxzyEZfP1vLzXHPn/Do3abTttzVNiFlpcz4SA5PRr8ZKQAN1pWJbK0qCD+k+JscT
	5uQai6sjRtk4wbulIgK6Y+foSKbf74dFg9/71w5HGEJSNTdbfAtPAmBE1geqlj1P
	SQg5f9lYwtNv5yP52jdyOBhdWngB+hNGFOHFmX5JXaKX8ops+N/ok7628S1lsuhK
	egJow==
X-ME-Sender: <xms:jKmbaeGRpbhrkJBkAUShkfJmwbfycZHXOQx1-TTlh4VFXRhH1Ka5uA>
    <xme:jKmbabOCuEH5_CjZ595fdko-MX7pWpiFC4rTHYczjOc6lx8JGz7xOPYLlgFwxYd_z
    msAAZtYbEe3ACKbyP783RBjQyC_FZjYXRvFBtyx29gomZK7>
X-ME-Received: <xmr:jKmbaQ-J3OljBXqBhnIjc4XZOHYOJ_g1TOaDrgbTOoCentl91phzazslvDNb0iG9l4ZssBQnTuaSeY-UgXQxuDsU-oOqKoHxZR46fiK7MzLH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epgfevjeduvdeufeeileefteegudetheetffdtjeegvdfgtdetjeeihfeigeffffehnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhose
    iivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehsvghlihhnuhigsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidquhhnihhonhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhr
    ihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehjrggtkhesshhushgvrd
    gtii
X-ME-Proxy: <xmx:jKmbaQ4opuBqxwUSAPq6WHvrsvVpWUK9zsNtgQ9kiW16XnvaqOr_5w>
    <xmx:jKmbadWz7P5LLFgiR-LJAVqaXm-9v4HfScdbYg99axCAtRDwskgt0Q>
    <xmx:jKmbaeIVpwKMoijgXieIpSK2_EvHwUkrZH_G1SzVqpJa-6MaYQbBcw>
    <xmx:jKmbaSSMx7-zzuk_cmDpTAHdejook_NsOe2FyLMtc5FwW-OQ0WZtcQ>
    <xmx:jambaRRhzMuVQ12oF4kbEtrGZjelkuSKOvxQaz0imawuWp06I4b5tZf0>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 20:12:38 -0500 (EST)
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
Subject: [PATCH v2 01/15] VFS: note error returns is documentation for various lookup functions
Date: Mon, 23 Feb 2026 12:06:16 +1100
Message-ID: <20260223011210.3853517-2-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-77883-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,brown.name:replyto,brown.name:email,ownmail.net:mid,ownmail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 5FECB171136
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

Darrick recently noted that try_lookup_noperm() is documented as
"Look up a dentry by name in the dcache, returning NULL if it does not
currently exist." but it can in fact return an error.

So update the documentation for that and related function.

Link: https://lore.kernel.org/all/20260218234917.GA6490@frogsfrogsfrogs/
Cc: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 58f715f7657e..e4ac07a4090e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3124,7 +3124,8 @@ static int lookup_one_common(struct mnt_idmap *idmap,
  * @base:	base directory to lookup from
  *
  * Look up a dentry by name in the dcache, returning NULL if it does not
- * currently exist.  The function does not try to create a dentry and if one
+ * currently exist or an error is there is a problem with the name.
+ * The function does not try to create a dentry and if one
  * is found it doesn't try to revalidate it.
  *
  * Note that this routine is purely a helper for filesystem usage and should
@@ -3132,6 +3133,11 @@ static int lookup_one_common(struct mnt_idmap *idmap,
  *
  * No locks need be held - only a counted reference to @base is needed.
  *
+ * Returns:
+ *   - ref-counted dentry on success, or
+ *   - %NULL if name could not be found, or
+ *   - ERR_PTR(-EACCES) if name is dot or dotdot or contains a slash or nul, or
+ *   - ERR_PTR() if fs provide ->d_hash, and this returned an error.
  */
 struct dentry *try_lookup_noperm(struct qstr *name, struct dentry *base)
 {
@@ -3208,6 +3214,11 @@ EXPORT_SYMBOL(lookup_one);
  *
  * Unlike lookup_one, it should be called without the parent
  * i_rwsem held, and will take the i_rwsem itself if necessary.
+ *
+ * Returns:= A dentry, possibly negative, or
+ *	   - same errors as try_lookup_noperm() or
+ *	   - ERR_PTR(-ENOENT) if parent has been removed, or
+ *	   - ERR_PTR(-EACCES) if parent directory is not searchable.
  */
 struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap, struct qstr *name,
 				   struct dentry *base)
@@ -3244,6 +3255,10 @@ EXPORT_SYMBOL(lookup_one_unlocked);
  * It should be called without the parent i_rwsem held, and will take
  * the i_rwsem itself if necessary.  If a fatal signal is pending or
  * delivered, it will return %-EINTR if the lock is needed.
+ *
+ * Returns: A dentry, possibly negative, or
+ *	   - same errors as lookup_one_unlocked() or
+ *	   - ERR_PTR(-EINTR) is a fatal signal is pending.
  */
 struct dentry *lookup_one_positive_killable(struct mnt_idmap *idmap,
 					    struct qstr *name,
@@ -3283,6 +3298,10 @@ EXPORT_SYMBOL(lookup_one_positive_killable);
  * This can be used for in-kernel filesystem clients such as file servers.
  *
  * The helper should be called without i_rwsem held.
+ *
+ * Returns: A positive dentry, or
+ *	   - ERR_PTR(-ENOENT) if the name could not be found, or
+ *	   - same errors as lookup_one_unlocked().
  */
 struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
 					    struct qstr *name,
@@ -3311,6 +3330,10 @@ EXPORT_SYMBOL(lookup_one_positive_unlocked);
  *
  * Unlike try_lookup_noperm() it *does* revalidate the dentry if it already
  * existed.
+ *
+ * Returns: A dentry, possibly negative, or
+ *	   - ERR_PTR(-ENOENT) if parent has been removed, or
+ *	   - same errors as try_lookup_noperm()
  */
 struct dentry *lookup_noperm_unlocked(struct qstr *name, struct dentry *base)
 {
@@ -3335,6 +3358,10 @@ EXPORT_SYMBOL(lookup_noperm_unlocked);
  * _can_ become positive at any time, so callers of lookup_noperm_unlocked()
  * need to be very careful; pinned positives have ->d_inode stable, so
  * this one avoids such problems.
+ *
+ * Returns: A positive dentry, or
+ *	   - ERR_PTR(-ENOENT) if name cannot be found or parent has been removed, or
+ *	   - same errors as try_lookup_noperm()
  */
 struct dentry *lookup_noperm_positive_unlocked(struct qstr *name,
 					       struct dentry *base)
-- 
2.50.0.107.gf914562f5916.dirty


