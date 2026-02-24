Return-Path: <linux-fsdevel+bounces-78329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPhmG4cmnmn5TgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:30:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D83C318D4D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3E2931286A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CFC34A765;
	Tue, 24 Feb 2026 22:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="eunBjtdv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DFvVp2g0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DC6349AF5;
	Tue, 24 Feb 2026 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972069; cv=none; b=Ou+11k0fWpLuyduWTa2w0Vwqt+BjMuLsNyWm03tT9H9zYkvYEUWRv5BhplFHTiiv8r41RvqqrIzBee4O/X8qmlGDHUk5G/uipsho5uUAaxXlTWMWg1oFiPkLEWkAz3amp7NPOPPyn5YkDkH+i/mVFZEx8ieeb/3ftQGFEXYsg20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972069; c=relaxed/simple;
	bh=8npN8lDUKLB/B/vi6olsXCscd/grdMnQXyTSElVQCIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyY/PNOhlOQnqg5ehihYfnisCylprj3kJ6LFxdw1//4T4EX2oOZ2Pt7zya95AuG7tc4VGb3KRo8NySL3u9aO+ruwGubikxi4M3K68ewo+DpDqTtJabGT04i86XHsHJkvdB7uheI54zLN/PGWHZzZTUex2HwG9lWzBM/FwVkqpos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=eunBjtdv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DFvVp2g0; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id A16B0138052C;
	Tue, 24 Feb 2026 17:27:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 24 Feb 2026 17:27:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771972066;
	 x=1771979266; bh=zoLaKvUIcq0LBSrvSvYdTrZyLAsLuraYZU3vedQYf7U=; b=
	eunBjtdvb7py65uKkhmWny3U0yrgkknbEzMVQWKR+94mqZBtzVxNG5UcQZeTXet1
	f+sFFa1H7+k0RQ3dGy17Q8a4likxcrMxwnAG/xA499ylO5Abt49a3ZDk85O9WQr9
	Cz0DTv8sPh8sqCI+a9KXs/NaCZ1kJGNLh1MCaj4Ag5LoDF8GCMewVz6BNuXdz1tL
	+WSGeeV8W7HNwadLfkZJdMj/b2WxWBMSME2ppKQ28WbR+H/+ugCmHg7deoZiiZWv
	PSfz9SjKvntrtb6Z8/ba/hoFi1Y2tsfv6rq+4AW6LMiMsxHzAAoG6skhYXbrIjXN
	+c2A0Ea/Sv+A43yHxjYu/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771972066; x=1771979266; bh=z
	oLaKvUIcq0LBSrvSvYdTrZyLAsLuraYZU3vedQYf7U=; b=DFvVp2g0aej3dNXGt
	WHFp/uzE8GtGq2WoHKtqHDsKXVgQ6Q7svrfudc4BRLDYwF3ZxQ0DcNnh7bJ0Y7Ly
	3PBvs8vIjLmWL76cuGp601c+1oOwQnel/RaE9da0J5l0iuMTeDVpRRV8O11455SG
	kNCkqICmXWzTkaZN1demnwZvrZgKHrTVekon1VvKRJQDackfFkM51A2Wa+Iqkxu0
	CBd6pi8lMlBSrn3VIs141ef66gGoy81xRjSb4mnmuxyWUNvIERuuYIIVgzuUEkon
	oSxZJSRGrdBIrQSE7yMPTqlbVdZotyhWZzEONFfP4J6acQyOTW0v/5FTIm6ZBB/o
	vViKw==
X-ME-Sender: <xms:4iWeaSCkrulfSSLGPswGsBm3-I1EpzIzXVMfhzn51t6xnQ70lFFIAQ>
    <xme:4iWeaQfpekKpKmYAxrlm-eOt4JJwC-UV1Vwxe-rKjznRmJdJLJgppmfsup5WRUoji
    Ng_X1OFLLPzGHylK2ql41SETEbd5_dXWB8V_HKbrCZ1znDb9Q>
X-ME-Received: <xmr:4iWeaeHB4ujld8rTbzIBqbicinQ1h_qqYflrTzCfA7GHEclvVBivm3Iok-rgmU3zNDHBKD8BCPj_EUmHa4f5egznf23gIbKvBIen4pI1hfvk>
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
X-ME-Proxy: <xmx:4iWeaaXDBC5x9Iad4eIzwRsf5TAWzZYe55nciyN5A6tPxAA1WR41dg>
    <xmx:4iWeaezdsSAM519uoLl6n385isoXBcUnWsEFizUVa-MnamggMYVFVg>
    <xmx:4iWeaVuX9vW-FdcViHd5GtAdk9KR2ZYJ06ok1egm9w1Az4bS3We8kQ>
    <xmx:4iWeafBZzwciAvXxla5DYM3dJnt9GQkYuHTstkJPCM1IUml5Wvrj0g>
    <xmx:4iWeafYran51VVKU68fjE_PM0fsWRcxFL9TkxDQyd_eJC-z3g_VSnVvj>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:27:40 -0500 (EST)
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
Subject: [PATCH v3 13/15] ovl: use is_subdir() for testing if one thing is a subdir of another
Date: Wed, 25 Feb 2026 09:16:58 +1100
Message-ID: <20260224222542.3458677-14-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-78329-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,ownmail.net:mid,ownmail.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: D83C318D4D5
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

Rather than using lock_rename(), use the more obvious is_subdir() for
ensuring that neither upper nor workdir contain the other.
Also be explicit in the comment that the two directories cannot be the
same.

As this is a point-it-time sanity check and does not provide any
on-going guarantees, the removal of locking does not introduce any
interesting races.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/super.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 109643930b9f..58adefb1c5b8 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -451,18 +451,13 @@ static int ovl_lower_dir(const char *name, const struct path *path,
 	return 0;
 }
 
-/* Workdir should not be subdir of upperdir and vice versa */
+/*
+ * Workdir should not be subdir of upperdir and vice versa, and
+ * they should not be the same.
+ */
 static bool ovl_workdir_ok(struct dentry *workdir, struct dentry *upperdir)
 {
-	bool ok = false;
-
-	if (workdir != upperdir) {
-		struct dentry *trap = lock_rename(workdir, upperdir);
-		if (!IS_ERR(trap))
-			unlock_rename(workdir, upperdir);
-		ok = (trap == NULL);
-	}
-	return ok;
+	return !is_subdir(workdir, upperdir) && !is_subdir(upperdir, workdir);
 }
 
 static int ovl_setup_trap(struct super_block *sb, struct dentry *dir,
-- 
2.50.0.107.gf914562f5916.dirty


