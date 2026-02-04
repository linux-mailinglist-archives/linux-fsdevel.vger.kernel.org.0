Return-Path: <linux-fsdevel+bounces-76251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DI0E37Vgml5cQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:13:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1930E1CE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2718131304AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 05:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969273542D6;
	Wed,  4 Feb 2026 05:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="OM3atnOE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NsdEeoqn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AF6352C48;
	Wed,  4 Feb 2026 05:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181734; cv=none; b=SXbM8YQ0+n+cnnymRzle9DbYpy9Cm540NJXeXWvrKVTFgwTJ1Vq5e4FyFqrlfiwrn/RsRVAq5pNmuVeAlOQUOk5DsmkvIBlmVlMAaXxqcE9XuwXXlI0Z7wW6kuK6kNYdmCxdJWM34wHiU1Pn4EJdUs9a4CYSt+WaWQT81IGKnYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181734; c=relaxed/simple;
	bh=qplDwUllsW2g+2INEuHLvBwHd3Fd/OhHhjHp2RMiR8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUd1X1mK0GDRlWGj2fT5gUylRQZn/XLA9h1pKPVPjdKfGYBsPiNkb7YpQT61HCiaxpq4x10EHNrcRkEOSrKJX+FUlfviY6UHq9lpg4u9DixF3cxPySYmBwkcHaebppcDcqJkaJXFKNeXXZz9O42jY0zcg1uuLXE9i30MB9h1I/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=OM3atnOE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NsdEeoqn; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 4795D138078E;
	Wed,  4 Feb 2026 00:08:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 04 Feb 2026 00:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1770181733;
	 x=1770188933; bh=dlJn5fjDHHJoTWsI4P2Q723YQf/tI/C5cM/SmaJ+5tY=; b=
	OM3atnOEau3pjHPWUS+XNXAPWU0+DV5lW/4kD8G68mLyz/jBiyKMW8654CvgrsQu
	Ijpet03LuJBeR55yOqREIAsWOxI9GQaW7t+8u6Qmu5RxeyGozk/Qyb5xPcO0CVcA
	P65B30oW14XFWXyRseJkx4GgizLj9a3MviH8mX8Tho+baH/UtwIuQJGl4pVDJ9MS
	tjPEnhIOboaLjurukC5XbQkanfCBYf/J9Q2T7jbcTK8BImTMgk0rDzTY9HPW31Ph
	IkBM5emdXLol0waOIhNv2DPN9co1TDkKlj1AXt8uwBnq0Du+FbYLtU0Ubz4E/uh9
	D8kBSXMnhsFiP+T/0usRQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770181733; x=1770188933; bh=d
	lJn5fjDHHJoTWsI4P2Q723YQf/tI/C5cM/SmaJ+5tY=; b=NsdEeoqnXG043UXih
	3duarZcI3Q0aOWXv42GjSOOhBCMB57FsVmsHwlxXxSfmCVDHUrAt9r9T4MNY503h
	qIGcw/Gy/oir7FqqmTI0PdYx6bgpriKzQ+T7F+gao2JFP93fgWjkGDTin0hOLZHn
	CufXI7zEq+57hVdZ3nBoUAlJM5Je7RTiYlSeLpK8Hz5Wp7AVTOmZ1kZYXobHQpyk
	OHMfcpC/KMA6+JYGw7hIK8hZg40uYxgIjxQWLPaUnuwc1mg2wRYJMeL6bgaX57bK
	cAW+yKyHR+B6IIKIW0N2FV5yfh23VDXScApj/g4yceUzHB1WROEO8tqMTU33qRDC
	VRpPg==
X-ME-Sender: <xms:ZdSCafRAOtf6XHmz6Fbr_IF3kN9L1LJrkzG1XvkLDOfiifFnzGo40A>
    <xme:ZdSCacWGKjkVLMCCU67oBxRTyRS5NmEbR1zt0gc-8swH71Adi6l9dZgXHG8scJPv_
    Qc0-cK9b_qnvckMYSY7PPkgkybrrI60mscu1n6YXela-FzPEg>
X-ME-Received: <xmr:ZdSCaU38xm3m3u4jtZfdesJH4aAoNlNp1VLNUWNB-PfJRjc49-POvuzRl5HTH73iFXGW-Z2VNkWlayzWQAisPe7DnhjlD-yF4_DufHATTsq6>
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
X-ME-Proxy: <xmx:ZdSCaT-Os-NXFm9rkqmDp-hPlnS-wA87CHcHWapOcazK6Xgc8Y55aw>
    <xmx:ZdSCaac7gGHcsPOYloUaW7RSTmQ7ryQi_PtgBc5NkfdmV4jakHGmlQ>
    <xmx:ZdSCaf4_yJWAMGl6NHU_ioxQuvoZWa-f4rVZQOcD9-AQM5og0-kz4A>
    <xmx:ZdSCaWPMMY45QKvZclfwK_FySuNft6Qf09QX3CM8XZ5soLGNq_UzqA>
    <xmx:ZdSCaZbmF-s3cXOcl2CXqTibHukiwITQJoj-8b6ApLFmuY2GsjApIfXR>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 00:08:47 -0500 (EST)
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
Subject: [PATCH 06/13] nfsd: switch purge_old() to use start_removing_noperm()
Date: Wed,  4 Feb 2026 15:57:50 +1100
Message-ID: <20260204050726.177283-7-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-76251-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[name.data:url,messagingengine.com:dkim,brown.name:replyto,brown.name:email,ownmail.net:mid,ownmail.net:dkim]
X-Rspamd-Queue-Id: B1930E1CE2
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

Rather than explicit locking, use the start_removing_noperm() and
end_removing() wrappers.
This was not done with other start_removing changes due to conflicting
in-flight patches.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4recover.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 441dfbfe2d2b..52fbe723a3c8 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -351,16 +351,14 @@ purge_old(struct dentry *parent, char *cname, struct nfsd_net *nn)
 	if (nfs4_has_reclaimed_state(name, nn))
 		goto out_free;
 
-	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
-	child = lookup_one(&nop_mnt_idmap, &QSTR(cname), parent);
+	child = start_removing_noperm(parent, &QSTR(cname));
 	if (!IS_ERR(child)) {
 		status = vfs_rmdir(&nop_mnt_idmap, d_inode(parent), child, NULL);
 		if (status)
 			printk("failed to remove client recovery directory %pd\n",
 			       child);
-		dput(child);
 	}
-	inode_unlock(d_inode(parent));
+	end_removing(child);
 
 out_free:
 	kfree(name.data);
-- 
2.50.0.107.gf914562f5916.dirty


