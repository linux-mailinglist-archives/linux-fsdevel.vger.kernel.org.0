Return-Path: <linux-fsdevel+bounces-76257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PX8F9zVgmmWcgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:15:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B2AE1D59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 166A5315A3DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 05:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA26356A1C;
	Wed,  4 Feb 2026 05:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="X6NQdBUW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kmB+ot27"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003743542D4;
	Wed,  4 Feb 2026 05:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181781; cv=none; b=nGzTN5lMRUfRPU3CVS25x+cwYqWREo1DnZXWLyzi/b/FSHA+LRqVNV1LH43Y1r3atyYw6Tyfra+4tr/iuDuvc3W/GvXqcsMyJ22ePSFgQvEhStRW6Au4PJGxJGMMsakwC14WC3MY6DAAJphd9rtQWu6+u7QV8cPuJW8rekl+gIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181781; c=relaxed/simple;
	bh=nqWal0iOV1tfqu1iiBXDGnrZqyugYCtEuXBL3nFrC9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2TF5rhWfDctAaYLtq2jhbrmkbNL+8RnE5aR6TVJDQSbdB88/+BLEAbSEz0bkrNhk9xK1EP4ypjHgQAvbsmq7fhw2bF9XnMwZEzOPbbMXT2h2ZQRHAv1B++1qdSwBGizTpmS6hlwgoyzaZceDV5mNk+hUu6+R5ttu4wwkY4m1xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=X6NQdBUW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kmB+ot27; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 4099F1380795;
	Wed,  4 Feb 2026 00:09:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 04 Feb 2026 00:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1770181780;
	 x=1770188980; bh=8uvFxwZx470aImGVKlG0uaaAm+xyg6DFqB4tuvF9Ezc=; b=
	X6NQdBUWgv9UAfWXzK36C8w6nTRgTe0N5Z1gJvzM7DoG6VAuIZku11+m9hcSC/ZB
	aXmrlSfdDvDZS2SmrHomjEjDLoAkT8Uq3jau2H9dzWwcHwtzpzdWk+2NE+52+v5h
	zsxOwTsy93vCnnsXnNLsxPeikb/9IpQ7v8C9GVWepGp59Na98ypFSUEoye89WJC0
	5CSgMh28x6lqapknOxx3AdHOiG8qXXTxBeXjCHRDfr11qfc8p59PqRqB0i97pYIw
	DJMCB0SZgzHSH69zxksTi56OMZSkna58XtCRmfNHnvSqHJ/XmYBa56CaApY0rwhk
	Mqlax1kLntLtkzG4xh4Qvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770181780; x=1770188980; bh=8
	uvFxwZx470aImGVKlG0uaaAm+xyg6DFqB4tuvF9Ezc=; b=kmB+ot27SP14nRc3Z
	ExPswFqN3VilfHWndDFQ6rvtgXowfuRBGj2WbnZiuzvRMypLthjxQR5eIYSI425k
	QFNCsHUt7piO42NFv8jXjEucTrpD4+IB+MEqx1o7fL7w3pUvciWSopZL9AeNHsCO
	+YpHhHGTKuvM1bwldq0VVCXBIW99BoOxpIXFzBSg6gSBvDmW8oRn9029PN46PdmC
	U0eG3+7Jjpp3FyYZM57sq6htOJJEVNBsUHuUMmA/8YA12DW/PkiDqTE8uE1XyqAr
	Ron7Q2ikWLhSnc2+x18eAVSwnrRbB8SZx9RQNGy9UqUDHFmsol3+XnTeE01Jx6ev
	H5+nQ==
X-ME-Sender: <xms:lNSCaRvUsZFXgscOuwBvgEkQMj-pMEreyZpFm0CQGdrEuf9qYIKOFQ>
    <xme:lNSCaestJo6rqe8WHLLbMXBFsrpETLhnMWpAmr-juUDmydPwhT2eJyOqwPb3-aVf3
    h9rVCbRyyGXm91Jez78MaswVRL8H0BlrLGmGxqkoceWPiTH0A>
X-ME-Received: <xmr:lNSCaYWid_SHr9146bclU6qiijgMEDdNSfgJ_JjFJcuBx6tJr7lKm1iRK2bUYW7X8GbpVY-jYP4LmSvpGC2dFt2mzGMDbdv8XuQOEYkscQXu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedukeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:lNSCaXXBuxMhe3vw7s_YyZoqDu3S3BkNP6jqbcKkggELA3GhVossbA>
    <xmx:lNSCabRMP_HWealeI6a3NCdH_a1ZCd10Rx68kMEFlrCV9DTK5Mapew>
    <xmx:lNSCaeG5FQH0LJEzLVABJgJz-dlcqgItcb1S7TG7N05_sJvEHQuWng>
    <xmx:lNSCaTSS1kJX5znMbZHuXS0jOW3AAQg-_cDjhvd9fpfnUXkMiKS5Fg>
    <xmx:lNSCaXNYPc1adEhH2bDN-sBbKMGpCx1YdDRPdm_O8hKfrfv1o6u2nrOW>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 00:09:34 -0500 (EST)
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
Subject: [PATCH 12/13] ovl: remove ovl_lock_rename_workdir()
Date: Wed,  4 Feb 2026 15:57:56 +1100
Message-ID: <20260204050726.177283-13-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-76257-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,ownmail.net:mid,ownmail.net:dkim,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17B2AE1D59
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

This function is unused.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/overlayfs.h |  2 --
 fs/overlayfs/util.c      | 25 -------------------------
 2 files changed, 27 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 4fb4750a83e4..3eedc2684c23 100644
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
index 94986d11a166..810c8752b4f7 100644
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


