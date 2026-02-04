Return-Path: <linux-fsdevel+bounces-76248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLcRCevUgml5cQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:11:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84566E1BE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0422630D206C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 05:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACABA3542D4;
	Wed,  4 Feb 2026 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="VWDBgqqS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rpyLh5/y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC3932F759;
	Wed,  4 Feb 2026 05:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181711; cv=none; b=SKqtFursdJXBnTsccWrShbr1pqLtgS8/MQgfKSt1E2TV2WjIjrLJCHG08KtB/c5MZzsBMCN04UkcL2OCeO4zUgCKC4K9N7tVwmZDgkvecyzeAANaVKAAkRoba3fYPHJqPKzMTGbctnJ9U2oLptt6VfAzkwcWrtknKXmQyNU90nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181711; c=relaxed/simple;
	bh=X3yURENEupz4CUecqxn/1nXh1M8n3fSd3Ij96hU/uvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYLw82n439CiMldgUQYQJUHiD0LzB8JkDKu/wJlSzeGfy0gJ6GU9vi24XZ2vGowyiIq/wtaDibcyHsyVuUAtvUKjPGRtekYlMAJr2BKG17pNoSQm+u/wcdBSInTCFfzxo6SD4xyFJbyf4ZRIlFropFsMbZtWTBTqZ5zp2BmoGMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=VWDBgqqS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rpyLh5/y; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 59BA01380783;
	Wed,  4 Feb 2026 00:08:30 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 04 Feb 2026 00:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1770181710;
	 x=1770188910; bh=nbu6leitHLk/a+LhHhFGF+M+ZAOtaZT49soxaSpp/w4=; b=
	VWDBgqqSFRCwbTr47z3pCBaPLI4Yy770051CjDEfiEaUIdEaPJGP4024DX+gErZy
	W2512BJG4dCqUd419LPFfzbiLsBf35lQnSg4TRTRk8QX9ao2rKVKkbxH35I5PhVJ
	B+Rw//Zu0JVY+RNtDJMO+7atD3m5NUZK0WNVidT05e/CC+3GlxvD3JwBQUu7t3nl
	ro79mi+zNkWbKafKoP0tZ3/Ju6j8Iroq24BqlOcaXMa8EnrKBR3jiTwMfGPyTVpX
	KoZT168soFmyp/HEMxDBgZIwB6TSW2QylXPyweEuX3bMtC5ezm4PrROHQl80uSoH
	8sRpJxPJXk9R+3iAuFMVZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770181710; x=1770188910; bh=n
	bu6leitHLk/a+LhHhFGF+M+ZAOtaZT49soxaSpp/w4=; b=rpyLh5/ysnp0C/Vxh
	9xfg9K1SRqftlsE/R2+1mXgaOCn6cydz40zGRMEf8TN+tuy9gVCcdyjRSzeNPSNf
	HMTnayYqD/UGOtSYHt8JWvX7X4c01jXx3lVRlXKFMozz5pcciI5e1uv5etCJu8uf
	Zugkloczv4zJS5cVT8TTqYVRuL4iGerwHwJgbTwetUtGl90IbR89XjHUt/V5yCxi
	tRY+yYG5Ob2q6SVKzXXTn/vCGvNF3QJl9Ykr1q9LxwirZ0t6rSJYS9Nn7NfUU+zh
	Uhpz0/IYSbMNfGQ2Bz3Lbdy7SROh1GZmgR2AjcsT9Njb6CFt1aUfsK6nA5V/Y+dh
	1TrVA==
X-ME-Sender: <xms:TtSCaSkMrIX7PpYPRNUmTWhS4u9DfPsjsq0bome50i0U41XqOoPnOw>
    <xme:TtSCaeGf9A4Nk5v_tjks5SbNPBna85y1Z8VXmHl-49aNh-NOA6RO285_dzlKvpF1O
    S8zE8YD6o57rHHYpLEQHKUm2Uy0LpoNGpZXHAWYITUXjBWGMQ>
X-ME-Received: <xmr:TtSCaUMsian_2ISD4x1GemAHXj1FquE0oBdBERV4ohVJlgZ8hLA2KPqLghqblmNJvumixY1KnaYtDvPlD9t-D9WsIG6PaYciBr2B2WdwutNR>
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
X-ME-Proxy: <xmx:TtSCaVsbHK3RlbHs9cbh55DL4KjaYbrs4GxRtn4eVqGNUKwdZo4BTA>
    <xmx:TtSCaaI3EiRW5HYpqRuDVyNa51fJHwSHVpN1RZb_sFsyatcUfJqIWg>
    <xmx:TtSCaTeVXRtjqTJgeVick76Q0m3FHMQTOg2zjzN2tN_GbluY-BPDuw>
    <xmx:TtSCadI5xslSKhIzNtRkDYbXFnRf8eYEt-kEY6vtoMX8pfg9VC9p9Q>
    <xmx:TtSCadHG6IYTA23SVFXR-echai330oXmMmV0WjEyfm41UnEciAgB0_MV>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 00:08:24 -0500 (EST)
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
Subject: [PATCH 03/13] libfs: change simple_done_creating() to use end_creating()
Date: Wed,  4 Feb 2026 15:57:47 +1100
Message-ID: <20260204050726.177283-4-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-76248-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 84566E1BE8
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

simple_done_creating() and end_creating() are identical.
So change the former to use the latter.  This further centralises
unlocking of directories.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/libfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index f1860dff86f2..db18b53fc189 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2318,7 +2318,6 @@ EXPORT_SYMBOL(simple_start_creating);
 /* parent must have been held exclusive since simple_start_creating() */
 void simple_done_creating(struct dentry *child)
 {
-	inode_unlock(child->d_parent->d_inode);
-	dput(child);
+	end_creating(child);
 }
 EXPORT_SYMBOL(simple_done_creating);
-- 
2.50.0.107.gf914562f5916.dirty


