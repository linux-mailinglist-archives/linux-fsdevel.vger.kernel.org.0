Return-Path: <linux-fsdevel+bounces-78330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIeWCd4mnmn5TgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:31:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB33318D57B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68B923144D7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D148735BDBD;
	Tue, 24 Feb 2026 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="hy7u65I+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ChwCLTxk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C0350A08;
	Tue, 24 Feb 2026 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972077; cv=none; b=rBhLwEL5ukfSHnm9w12AvCAHQ2iB7yS1cR8Tr2oF5TbAc4VlkxCWfDQRejNAdagC4kgPVSz53nrA1fB+mXL1u9y3Cw5FeHKlsdIeFabZB5e1BoQwYT/0Aav7Jor5sT90l7BSBNiK7dj6O2zg42DaQfNjPwuNxsTHUJU9PF8v1dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972077; c=relaxed/simple;
	bh=SohgNuLUXSQSkgtDnRyuTdAQDh9isNIABR5R5Yifjlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeU0xjkw3aqLiJae7VGtDpR+drVAsDEe3NeKYC1dkMUIVO68Qp468YRnkvsojrgIf39AQf/CEy3QnmTc/n7RdvLhigDkdbBOpL/427mjzKBicKDPis80LgOaytfjL6UZwl8FrsZn8dy1BAPm7i45qErG0PpdwkOHGXhZzklO5O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=hy7u65I+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ChwCLTxk; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 3D3A1138052C;
	Tue, 24 Feb 2026 17:27:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 24 Feb 2026 17:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771972074;
	 x=1771979274; bh=bIUlSuwFKeFIuLZj8rOB/AbskaH/BxVOAKu2PHwCVKQ=; b=
	hy7u65I+Q9tpvbtcV5WQpUFJvQgpsRwv2rvP+I7kvnfDA2SHObxNGtFreHDTOSpg
	09z5WCa/28GuKNBjXyppssw8J3Uj1ZOsoC2eGUwFjpwUIWUgfIT4JJLNTK0hpsd1
	zxUbyQbXhfWzRKrmAQu8x9zmGv/ZfgfbNGFvmC6BaloDTtBfY5R29PQfmXaV0gNk
	trMCyaOl7XwljFqdU53OxnkUFmdtLoA/vRTpRsha+Ms+jfYYr3n+68C6FJkCUc1j
	1fCICJdAnXvQuuxISxUUEI88SC9G/7WxaiGqvMgSdpfPetdheLPfbciehBmpb4Pb
	d/j8SR622VN3qhsTWP5PdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771972074; x=1771979274; bh=b
	IUlSuwFKeFIuLZj8rOB/AbskaH/BxVOAKu2PHwCVKQ=; b=ChwCLTxk1c0zImyBL
	o1kANErg77ogwCm8US7Si3pa7+uAi2BjF1NsmTVx3inbCEynTVl8WEWS5fZtkU3E
	+OTBB6d7aLRGIZyoZawqFkFwK7a+MXQGmKlrEdkl5rnr++KLM9EX1OxzNaDO2lUK
	GRUNm7ZTjM6l9ww9i2GH8rxX9lRdyf9JwFBo3ghiv4aijGzJx2YDOab042LFVSRK
	GrDV8MaV2eIFCSiUpJoqKE0Y/DqGGDDYsrWNeBsgVrOzgiLLJjYFNhzAUVGq4MB/
	VNt0nmx6+E4H/n7tMX/4MDGaSiw9olL3vcDDbKfFzfFURKIKzbFQ+0qVESQIhMM5
	kn+Ww==
X-ME-Sender: <xms:6iWeaR8zjrSULEgJxL4HxQeMb0iNrr7oldp1caBAy34wh68VNn6jIQ>
    <xme:6iWeaZrlN3Pvk6uuJlkWEtNzi9_Xgju7-jOWrKwNAwErzBbyJYjHMThEdno8Sh_al
    2GAuGyHkHHsPoHHCLAmYsv8vFyVNgQf1rRAGCP03l9kV0rxOA>
X-ME-Received: <xmr:6iWeaXheysVn-uoUcSyQv4xBDu9Api4cdR_yaIJwU7jIWGz2IGp3Pug8ie9SzTS_qRMVE2o_yJLpED929HsTd4H-yxFV3N_egTxE0nBhDhF1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedufeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:6iWeafAZhqD0o-xubhL_NLxGif5moM4AVm6R2w-HkR4VrNBWFRCyCw>
    <xmx:6iWeadv9bqx7fnW0gA_j7o77UPv6Is2EdCFioHTryJPYnBKYXo1nNw>
    <xmx:6iWeaR7qgRLo6XdfLxRwDTRgu2O927KGrOYBde6D_XveM6jd-YwYkg>
    <xmx:6iWeaffIQMEmijHro1jv9uWsOZ1i6qlbmbESWKz3svGjNkr9-nkXpw>
    <xmx:6iWeadFi3JtRYFd-LF_nWGJ_7B0vwYcxYUH6IZHFBvnbRAwHQP5h9N2L>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:27:48 -0500 (EST)
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
Subject: [PATCH v3 14/15] ovl: remove ovl_lock_rename_workdir()
Date: Wed, 25 Feb 2026 09:16:59 +1100
Message-ID: <20260224222542.3458677-15-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-78330-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ownmail.net:mid,ownmail.net:dkim,brown.name:replyto,brown.name:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: AB33318D57B
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


