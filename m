Return-Path: <linux-fsdevel+bounces-77896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHwDI7Oqm2mu4QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:17:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 252921713DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1949C30312E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3864E2BE05A;
	Mon, 23 Feb 2026 01:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="UYZfuRjR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jIR0bzYx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C53C20B80B;
	Mon, 23 Feb 2026 01:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771809276; cv=none; b=ot67VinS7IXfFA/eDCKWVckyct2B1GEf2hadaZw2/QtFnAZI5rDFpY8sD9dsJgr9UZzZs6sLaU9EZeSsMsubfuIC3qYuRICcRHi7aDKDtKEThOlLHZxJrQcN/cfn/CtXk+6YvAELpCrrHqo01M1sewcjLPNlwa4R48UX2YatA6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771809276; c=relaxed/simple;
	bh=SohgNuLUXSQSkgtDnRyuTdAQDh9isNIABR5R5Yifjlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRl57guCN7p6MR0XYlOlFllEjp4VEqQnbI8ajVwD/k84ibVYbJSlwDv4agHNXajgQgJ4HL+vj+LUYfIAJ12oCSTm5TNDv4qGLOP7bcsHTImI7S0aqx8bghxNt4eAU9yWJ3oosvgM4JQGsUBpj4HcUqbyRibOeHZqKZSdZ3EVHQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=UYZfuRjR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jIR0bzYx; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 06A6B13807AC;
	Sun, 22 Feb 2026 20:14:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 22 Feb 2026 20:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771809275;
	 x=1771816475; bh=bIUlSuwFKeFIuLZj8rOB/AbskaH/BxVOAKu2PHwCVKQ=; b=
	UYZfuRjRs65gR/ukYhi0GqnXITvPd25nHmqRdOCcA4Ze4MayUk7C378y+wq0raeF
	y8T+MBOGRjU5VZwOTbSXHJeGGzugdntSzqvzIvbdYk6TX2yqtzxR6SWcdhTD+S8N
	EeNZzsISlTh5HbnfOUPVn73iz1wL4gXVJ/D/gsGs/FBK23mRpXwpflFgr/M8hZ/W
	EPgIMX91DpgMkRHNaCknR89ddJ0zQWLpY63e5/MWXxLLAPsOh2AkFiho+LkDdiX9
	POS6D1crZQKO5GS3z58lb7oR4F1Lb1sCvLddhmLayQOnUBMoTPuxXmGvbsXfbVB+
	eEsxgV1jBjeSvPw4DeSiNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771809275; x=1771816475; bh=b
	IUlSuwFKeFIuLZj8rOB/AbskaH/BxVOAKu2PHwCVKQ=; b=jIR0bzYxDas0hwFOX
	B7R77iebelURlC1EULeJpzlNwU1GXhSVc6tCQpkXBDGPpmgm+d0hO/L0cY/uLytr
	erb+CyFuUkMZ8vk64NUsxLGnARVyCPhVztMgXojwJelJXzCy6Eev3w/pXHAx/Vpd
	gz4RIFzae1+DNRSb8uHeQn5Ij8VQ3YN3M6Avyh7lbH7wfBknVKP8cEtxCecloQnc
	EvfSR1AJ4lhPLKo6UouPpJQL2t4z82G9w54pLpgaWypxVLx2DUUGhjpGz85Hh8+T
	GgIooWYFBpAbsBwqOm29g0dcDqO68CFzMz8+0cgTw807dpM2tIK2LVK8O8issHZO
	ExXFQ==
X-ME-Sender: <xms:-qmbaWBVM5rBNyvK0GdGWsvcPE4BZ1SjtQOlYsc7LQlXWr3gc8bKiQ>
    <xme:-qmbaUfhOYnVtVG0NgydVoC52XUz4dzaadlwAE_A2cy9JnKM7CSpmrOik8EAkvUU_
    Y-x8aiHJ2errsB4MRA_Eyait-fZRccXmZo3SDEpV4fu6k0a>
X-ME-Received: <xmr:-qmbaSH1O_YjX6wEiLKjV-ebPONPByhbIDg50TBZ_lnEYLZjaaG9PYV6F9rXDqCZOwfgBKltZ6Auy1l0kydDZYbHZ_lwd4ICiFsQ4sSbzrrt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:-qmbaeUVC8CQdYd6acXC4Ajl01_3_yz7_8B_8iq4HIbwrV1bdur10A>
    <xmx:-qmbaSxjSE6kmX3Ipt7kZFJ9r3nyKw4x_1tiCZubJGbJzJyw3dnqzg>
    <xmx:-qmbaZvTxPGT0w3F5xmJe8N8i7W_Igq84_d8BHrpr8VifwnodV1-iA>
    <xmx:-qmbaTCBwJMV_yuLVyTTrB_ikB8FuCR7DKbolv4U5Q2RPlTt5rR3iQ>
    <xmx:-6mbaTbKKCUE-zB2echJ_EjBQBRKt6G1YMul8XuYuMaTzGexQOi2prWP>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 20:14:28 -0500 (EST)
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
Subject: [PATCH v2 14/15] ovl: remove ovl_lock_rename_workdir()
Date: Mon, 23 Feb 2026 12:06:29 +1100
Message-ID: <20260223011210.3853517-15-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-77896-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,ownmail.net:mid,ownmail.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 252921713DA
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

This function is unused since
   Commit 833d2b3a072f ("Add start_renaming_two_dentries()")

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/overlayfs.h |  2 --
 fs/overlayfs/util.c      | 25 -------------------------
 2 files changed, 27 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 714a1cec3709..6fb99c583c31 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -569,8 +569,6 @@ bool ovl_is_inuse(struct dentry *dentry);
 bool ovl_need_index(struct dentry *dentry);
 int ovl_nlink_start(struct dentry *dentry);
 void ovl_nlink_end(struct dentry *dentry);
-int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *work,
-			    struct dentry *upperdir, struct dentry *upper);
 int ovl_check_metacopy_xattr(struct ovl_fs *ofs, const struct path *path,
 			     struct ovl_metacopy *data);
 int ovl_set_metacopy_xattr(struct ovl_fs *ofs, struct dentry *d,
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 3f1b763a8bb4..aa2a32793c2f 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1213,31 +1213,6 @@ void ovl_nlink_end(struct dentry *dentry)
 	ovl_inode_unlock(inode);
 }
 
-int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *work,
-			    struct dentry *upperdir, struct dentry *upper)
-{
-	struct dentry *trap;
-
-	/* Workdir should not be subdir of upperdir and vice versa */
-	trap = lock_rename(workdir, upperdir);
-	if (IS_ERR(trap))
-		goto err;
-	if (trap)
-		goto err_unlock;
-	if (work && (work->d_parent != workdir || d_unhashed(work)))
-		goto err_unlock;
-	if (upper && (upper->d_parent != upperdir || d_unhashed(upper)))
-		goto err_unlock;
-
-	return 0;
-
-err_unlock:
-	unlock_rename(workdir, upperdir);
-err:
-	pr_err("failed to lock workdir+upperdir\n");
-	return -EIO;
-}
-
 /*
  * err < 0, 0 if no metacopy xattr, metacopy data size if xattr found.
  * an empty xattr returns OVL_METACOPY_MIN_SIZE to distinguish from no xattr value.
-- 
2.50.0.107.gf914562f5916.dirty


