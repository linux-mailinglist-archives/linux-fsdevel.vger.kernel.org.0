Return-Path: <linux-fsdevel+bounces-77893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL4wFU6qm2mu4QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:15:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8138171304
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 794883042FE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DE82BE7DC;
	Mon, 23 Feb 2026 01:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="NGMlU3nD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XM5KgFV7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DA720B80B;
	Mon, 23 Feb 2026 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771809252; cv=none; b=Ft7kRg12Z5soCV84iMHoQdKmBDoPO3AxgCALDbldb7nl7LkIVB/RTNVWmOSJHN0V6+TywofL8bdMj4gyQ52XHdxeRHqCeObhF1jxy71OEMyo9nF946yz87ZrE3vbqhQ6LLfX7tu32wXy3dMZTXaUBuY0Ufl+QKSyedYsl55neqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771809252; c=relaxed/simple;
	bh=iH1MILHl+tOvo5CVf6o2Pd/av7QPtAnQxEUaiW0K75Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vu5eItrQf6wAn6C4VC0mPzGErGL7n5AmdFHwcKT+jQx8oPHkyQ+xlnKAA5FgrfIDvNrz04uMuI2IsD6R3wchiBYbtJb5sNpvd1W0QNWx38bJnbMXmH4gzg0pavPBK24xnzfhODiwDuaFOCsU3a5bJrErP+1WNNmj6n+ljArMBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=NGMlU3nD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XM5KgFV7; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 88C8913807AC;
	Sun, 22 Feb 2026 20:14:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 22 Feb 2026 20:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771809250;
	 x=1771816450; bh=ZrynPbWfNd1wtJYWqA15M9j3OKRPKOEVKgjSx2abQ0w=; b=
	NGMlU3nDnrZhVL0ZQk5jQiE+XRWezBF8D+SwKtWiE035Bzv/ek6gI456XKffeDM8
	7efwEcV7kbV2WktLtPKostu7wV/kVIou84AAd28YEsn1jb4Lvy4NP/PhxPpg3WYF
	IJDgCMJ1orQevF2uv5fNoVr4MkBsMNrS23QCKsDIR8g08Hck2NB9CJ5Dkm+om72t
	Au8wsxgaWyQzK+u8xowgy1kDL7ubM5azk46cLLcAhwSWOyWF9ruekX6Qcux+gq+u
	3gVEORWnQk1+EUtiexokW9A1lwbVKYSxj4KFf6c07IiNJCQ+YYMXWW0GD31hfqaE
	6b0xPP4o96eMncP40+mGgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771809250; x=1771816450; bh=Z
	rynPbWfNd1wtJYWqA15M9j3OKRPKOEVKgjSx2abQ0w=; b=XM5KgFV7FzBwIgO/p
	QZauYZJ8YWGj+WGDjQXs45FWSVBUGixPS7o0CrVuErRaO5oMd0vwhr8/N/ntVWef
	fMSASFpl/KetESOFySezmCyPuGrbvWlj8zZt/z7xYVA9In9LN5N2yaDVmPA7lzl+
	e2uRf0+F79u2zEBaHS8Wh/1W12tNQC68vewvcNuiBo6gf89wE9A+jMA53RPDNzQK
	08vRqJE5IIvBfUlE4XurLjIfYTmylPEe1LiM9WDIT3IYpbdN4vVE22x9Mrs0cT4m
	+Bs9wz671RQxFh27Ckh0+vwkAMTTZVjw+SWq1cxvoKgFbCEmymatnR7z4Sdj7rl2
	2anNQ==
X-ME-Sender: <xms:4qmbaUni-8HWf60zhi1jooT0eqqP2SYBoazhxoUATOJzMJQPRIP2MA>
    <xme:4qmbaXw2A50owTPcEnxSlROAmPgiHn5DoSCxq4KVqhiohaVrCzlD2ADOxL5wzrsZH
    oj0iJ63KkOpp42u_xL0HixU332rQMKwys1ibTlPFyJ63NXx>
X-ME-Received: <xmr:4qmbabLaXsiRPkb1JdiN4I5vWFEzDfMSB6DwPU0jKDgiVE22xKnIaAxyjq57m7XjHaOf5FTHS0sln21Uf8flYPFNLEI7wkmgTGAmIvV4ZxqX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:4qmbaaIa0_LVqULGh5HRmxJiSgc-CVtPo3LepIJrPbhK0yIsE06pnQ>
    <xmx:4qmbaaU18OXqYFL9I-pMWzSJbnE7pHBUaJLxHg0gxEq2UMoxEDVLhw>
    <xmx:4qmbaSAn3kBSk-kjs3jljAZX0GRl_EAPNjE5Kb5Fy95SIG0MV9JPPw>
    <xmx:4qmbadGOLle07fgErkv3kYka5x4sTLwl6720rT7iWz57J1NALMQ6hA>
    <xmx:4qmbaXtnPl59sof2Es_wddRBiXeSSIgLdU8xjdeICrzHZ2whXwPGnoa2>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 20:14:04 -0500 (EST)
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
Subject: [PATCH v2 11/15] ovl: pass name buffer to ovl_start_creating_temp()
Date: Mon, 23 Feb 2026 12:06:26 +1100
Message-ID: <20260223011210.3853517-12-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-77893-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,ownmail.net:mid,ownmail.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: C8138171304
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

Now ovl_start_creating_temp() is passed a buffer in which to store the
temp name.  This will be useful in a future patch were ovl_create_real()
will need access to that name.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index ff3dbd1ca61f..c4feb89ad1e3 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -66,10 +66,9 @@ void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
 }
 
 static struct dentry *ovl_start_creating_temp(struct ovl_fs *ofs,
-					      struct dentry *workdir)
+					      struct dentry *workdir,
+					      char name[OVL_TEMPNAME_SIZE])
 {
-	char name[OVL_TEMPNAME_SIZE];
-
 	ovl_tempname(name);
 	return start_creating(ovl_upper_mnt_idmap(ofs), workdir,
 			      &QSTR(name));
@@ -81,11 +80,12 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 	struct dentry *whiteout, *link;
 	struct dentry *workdir = ofs->workdir;
 	struct inode *wdir = workdir->d_inode;
+	char name[OVL_TEMPNAME_SIZE];
 
 	guard(mutex)(&ofs->whiteout_lock);
 
 	if (!ofs->whiteout) {
-		whiteout = ovl_start_creating_temp(ofs, workdir);
+		whiteout = ovl_start_creating_temp(ofs, workdir, name);
 		if (IS_ERR(whiteout))
 			return whiteout;
 		err = ovl_do_whiteout(ofs, wdir, whiteout);
@@ -97,7 +97,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 	}
 
 	if (!ofs->no_shared_whiteout) {
-		link = ovl_start_creating_temp(ofs, workdir);
+		link = ovl_start_creating_temp(ofs, workdir, name);
 		if (IS_ERR(link))
 			return link;
 		err = ovl_do_link(ofs, ofs->whiteout, wdir, link);
@@ -247,7 +247,9 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 			       struct ovl_cattr *attr)
 {
 	struct dentry *ret;
-	ret = ovl_start_creating_temp(ofs, workdir);
+	char name[OVL_TEMPNAME_SIZE];
+
+	ret = ovl_start_creating_temp(ofs, workdir, name);
 	if (IS_ERR(ret))
 		return ret;
 	ret = ovl_create_real(ofs, workdir, ret, attr);
-- 
2.50.0.107.gf914562f5916.dirty


