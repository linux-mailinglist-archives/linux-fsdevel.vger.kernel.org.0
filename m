Return-Path: <linux-fsdevel+bounces-78320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LDyACsmnmn5TgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:28:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3BF18D415
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1160430FAC27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DD1344DB1;
	Tue, 24 Feb 2026 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Ai/u2HwO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xu6mjPIb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB162344D81;
	Tue, 24 Feb 2026 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971993; cv=none; b=N56z02hPB2S7edaFV0G8aCtdYwSvwN1EobTd5UZjXY4o5UZgKrce2KIZnsz44aTLx5wHDMGPbu0WfTdQzCFWX1dxsL46v0eumlcmtNnM6EBCR9siLQHeY8HXpfCzKZ+eRanrmEroyH5RiJ3w9DZyRu/7oa82hiWkA80Q4rvJqow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971993; c=relaxed/simple;
	bh=KuROo3JMGIM8j5aDxLYEHHUTuMsukyM2SLM5WpxIkqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mf/2dhBtWXRHYdFyyqpE8PO1LPgKZV1EEiLr2GksTNtmI0hzKB+cnAIRrz7jqIf1ppHx/i3iGMMFUQ+Ez0nuhBtCpXFuctERymDV7W1SOUC1B84a4RL72Z+fMtg+6dNw8GSdApPZNK9RBuE9kvxi4PGcTiovbbyTl0T1Dn661Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Ai/u2HwO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xu6mjPIb; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 2E8AE138052C;
	Tue, 24 Feb 2026 17:26:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 24 Feb 2026 17:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771971992;
	 x=1771979192; bh=tmfYUs18u0P/igCXZvtuab+4hhfHHoKRLjZ+0PQIG4w=; b=
	Ai/u2HwOUqLnIdnD5V+zLmPuoVjGNlXD81MbBpc7z1PHgBnvG7Ymiv5m5uaDlWWF
	+lwJuPiWhG61HCuVeSHHnx68u+fv1Wf8TRz72p9gjCtj3Yvjw7gPJ9zGQY8x7nW8
	3l/8dt9BukfR6xWzkBOtVA4MQ2PqWTN9extp92bo+Lk6uhrpZOzSDX/yiSGJGiyi
	PawVsXiKoGfeUBHEkYFXJRQbGeFOEXOLwjMpbgH20/TuYwzYWasq97Q7lVwDPkTK
	L2mylnq8p/nTHbxmHJVQXmbG2Pidy1W2D4mBDtZ79LzPIf6Tvy2F9CoaGxJwKyVD
	iLijKtdtSWM9wzQwAxDKFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771971992; x=1771979192; bh=t
	mfYUs18u0P/igCXZvtuab+4hhfHHoKRLjZ+0PQIG4w=; b=Xu6mjPIbk6OseLsUO
	EpB+RqSqof1NkfiLM6333Bf2X97bTET8Gs/4CVyrC/czTP5h3fWkqxyH9/1tD3XY
	Ly/BsVT+XWkn33C9vbBzkfVJ4CwyOhl3RXGGAe3WI+mJb/fEgozhC83BgwDkwfbq
	a7nRqRlJ9RV5oPjJy/ON3ZjIgumjMADOc4j51bZx1tpocRT+jmqTp0GAYuv7QxNA
	grxI0eRebNu5eR0Z+KC3uKRwJNNIyHceODx/eTPoMCBiV+Fe1HAUaUIgmgs5qQNQ
	mqTrpNHci+3lh9w18ISkVPVLHojbFeB1BvlS0rqOqI4o3hhBFWLbUnCoVtitD7HR
	YMRrQ==
X-ME-Sender: <xms:lyWeaWNpO8pwbuHCZxcBbYWHLc6PB8xoH0_wNU37y6xHbySCxYBBsQ>
    <xme:lyWeaQ0R_MXwGGvcrF22WFfzsmQRDr3iKcLlWVYOezAQOMWOnjPFAte2QxjzBeCPa
    V_CrYX990WJqp3xhoJhtr5VW8ZV9w2L2splFPN5j7XNuDW21g>
X-ME-Received: <xmr:lyWeaWEBfTPm2_XCE6GtBVLJvtrCQtttE8qRX7bBOMO89G8lFPYLsvD_Ds4R6KxThV3stxqPhMYaA4XzzwAc913HT1BgLf2_k5q7uNevqKJw>
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
X-ME-Proxy: <xmx:lyWeafgOq21g7CRohbd-FjuFt4n22DxEjFZ6nQ0FKBh4OY1d3rzraQ>
    <xmx:lyWeaXdBMT21Fh9nknZb3vg-5e2u9ylIzFk78MCHRwLKwnWyDH2BaA>
    <xmx:lyWeadzvbioktjA-36CCBCROrqfcSAgRJuHJioB1gltPQd1fQyEqRA>
    <xmx:lyWeaZb3LfxO7omueO1CvT47yRPCQP9idzSz0MkDLqgHCrvipGVlVQ>
    <xmx:mCWeaRCTkAv-YbcMlDH27PSYQ77Rb34NjEjtoQ-zXUbawDtjrUByBAKz>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:26:25 -0500 (EST)
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
Subject: [PATCH v3 04/15] libfs: change simple_done_creating() to use end_creating()
Date: Wed, 25 Feb 2026 09:16:49 +1100
Message-ID: <20260224222542.3458677-5-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-78320-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,ownmail.net:mid,ownmail.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 6C3BF18D415
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
index 74134ba2e8d1..63b4fb082435 100644
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


