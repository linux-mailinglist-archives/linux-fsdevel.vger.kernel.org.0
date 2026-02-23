Return-Path: <linux-fsdevel+bounces-77888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CChsBIyqm2mb4QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:17:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B4D17139F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA0A0306375D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EECA269D18;
	Mon, 23 Feb 2026 01:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="D98kyxwk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BqHmm20O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6AE1A76BB;
	Mon, 23 Feb 2026 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771809208; cv=none; b=G/V04GOq3UlaOlZw83M/rcbphPNzT6JQkcYax7yRB5EX+fOqUF2VjkBGyA7US0UE3DmuJbgQDb5ihyHlzY9bwNAAQlm/17/BtIIQlX4jvtKeRrJrzXndPH8E0eu5fRjur1JgesWqUwNPm4op+z7L1C70uO73kB6A7H+xEPGH1CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771809208; c=relaxed/simple;
	bh=kABf4LtCGJxugGBeu/1hVo5NeuAaOTrWKXF60CVcJI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPZ0kOgEsQW7yhfyGheQzdAYZkhw/ir+gTBNBCTK4WUL1qaGr4hrELbPGe0OEEL0XswqgtdmDuD1EsVM6o2vSP/mKobReiiNABR3SedHBxnFV1XqLUxUzYuj3Nh5XAneO5a3ilyATHwq98yvwIgmtSy0hICX3Vc8bHrcpJQnzkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=D98kyxwk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BqHmm20O; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 00D2E13807AC;
	Sun, 22 Feb 2026 20:13:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 22 Feb 2026 20:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771809206;
	 x=1771816406; bh=hvSLo0cVB0FT2RzgczA5tPPEpyfUY+L7/ZDHkxjaRZg=; b=
	D98kyxwk6g7hfS73f6+VorQaDNLAuUeOmLj4/iP0EyncZeFwy7TTIyQ2IHRkrBrR
	KVE+Sb0jEyNLtBVLd53AGSPz2ad+/jmB4nhOYtKypsz2WEqx4RMXD0MifAhkz5ox
	b41A72y3ldD9kGY+93OLJNElRg71ieJ3Q7Uc4Mz8gPbV2Oh4PzgtVA87c2a3H9fi
	5bFuBwCgtlRdbEXE3keLe/I7HUia3rs6xKFu/HeHtXbn/8bQCEnZtvuegPnVl7b1
	F9ylBSd85jxjxUgb7O9baHoO93XCEYLgPhS8sWCHNjrEip+RpcqEKYna4qmp+W3w
	Pn75tDEwOZNgCnilV8vJ6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771809206; x=1771816406; bh=h
	vSLo0cVB0FT2RzgczA5tPPEpyfUY+L7/ZDHkxjaRZg=; b=BqHmm20O2nDUitYlh
	Mc9I9KfF53lDrFOD9d/lK4C4Wxwa/mz6ljh7Snj/FNeDq1qD1kxqorfW+rKKJjDF
	uDYrebG2Y5DELkCctW1h2L1VR7sle0QDxxtWMwmmroKv18wkzFNblU3v6IC1tQdg
	+EjHwgMi4nR4cUhbYOS+9PtGnlSeKs9o/zR9a26DZ+cqB/vERdXenmljEREPJbqf
	D73F9CObBxi+9NZAN3ewz8qCGlrMM1Chi3PxW3PZoNpfStNPB5jfsi5YgAYX9xBF
	g8YwhkCalOiAw4ORiFw8uAXNwLNhwSP4UCuWTIRYULV7xOYL0qKBlDpzxPwtjX8S
	gqd1A==
X-ME-Sender: <xms:tqmbaR0HxM3okMVpisWYn1Ctsk6CmGU0A4yRPj8a-bP5bCkrANnYGA>
    <xme:tqmbacBcwT3udlybvo4708sw57-0lKBg0WNzX_d8BFbCwlhnxF36IjM0jOUcQEMQ8
    Re7MKm_jWupSlvA3HyfG-kpPhcQTu_SSSVK50iHdcsDObmNasI>
X-ME-Received: <xmr:tqmbaaY9Zk4NtNapbQbw1LehWodJRKXCgzI6IljtClzQFP1cjjO2Hy52x1ZcuKHeINQPXOfu5Mo632mFttqaDQoCN5bhmstvHJM54-5Nj8_l>
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
X-ME-Proxy: <xmx:tqmbaYZ0z3dyybFmipWTRbDaVhGqpS-rtJ7nhE21fPb5i-cs2DpyDA>
    <xmx:tqmbablTVdS2sE-LsiEIdUkaXzVyRtROFK7aKklevNlxbR7FzfEvew>
    <xmx:tqmbaaTtYa1laSE6mTNt2c216gydh6RAfdAsZTJS25Q-qTVS-5Jdmw>
    <xmx:tqmbaQWtVGl0jmOu5jhIEI8UEeHGANuJ9tx0p6zeEMp2LTHK0fS_8A>
    <xmx:tqmbaU-_9KUZWKiWl_3vvmKaA6bfnoB9V0TDU9rIl0XqY7AcldkSG8tn>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 20:13:20 -0500 (EST)
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
Subject: [PATCH v2 06/15] selinux: Use simple_start_creating() / simple_done_creating()
Date: Mon, 23 Feb 2026 12:06:21 +1100
Message-ID: <20260223011210.3853517-7-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-77888-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:mid,ownmail.net:dkim,messagingengine.com:dkim,paul-moore.com:email,brown.name:replyto,brown.name:email]
X-Rspamd-Queue-Id: 71B4D17139F
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

Instead of explicitly locking the parent and performing a lookup in
selinux, use simple_start_creating(), and then use
simple_done_creating() to unlock.

This extends the region that the directory is locked for, and also
performs a lookup.
The lock extension is of no real consequence.
The lookup uses simple_lookup() and so always succeeds.  Thus when
d_make_persistent() is called the dentry will already be hashed.
d_make_persistent() handles this case.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 security/selinux/selinuxfs.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 3245cc531555..7d4f90e5b12a 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1931,15 +1931,16 @@ static const struct inode_operations swapover_dir_inode_operations = {
 static struct dentry *sel_make_swapover_dir(struct super_block *sb,
 						unsigned long *ino)
 {
-	struct dentry *dentry = d_alloc_name(sb->s_root, ".swapover");
+	struct dentry *dentry;
 	struct inode *inode;
 
-	if (!dentry)
+	inode = sel_make_inode(sb, S_IFDIR);
+	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	inode = sel_make_inode(sb, S_IFDIR);
-	if (!inode) {
-		dput(dentry);
+	dentry = simple_start_creating(sb->s_root, ".swapover");
+	if (!dentry) {
+		iput(inode);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1947,11 +1948,9 @@ static struct dentry *sel_make_swapover_dir(struct super_block *sb,
 	inode->i_ino = ++(*ino);
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
-	inode_lock(sb->s_root->d_inode);
 	d_make_persistent(dentry, inode);
 	inc_nlink(sb->s_root->d_inode);
-	inode_unlock(sb->s_root->d_inode);
-	dput(dentry);
+	simple_done_creating(dentry);
 	return dentry;	// borrowed
 }
 
-- 
2.50.0.107.gf914562f5916.dirty


