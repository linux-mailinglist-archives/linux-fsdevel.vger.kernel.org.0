Return-Path: <linux-fsdevel+bounces-76255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAixLvvUgml5cQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:11:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC273E1BFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9FA8301D263
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 05:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40954353EF9;
	Wed,  4 Feb 2026 05:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="E/sOgPKT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZOvcqmcB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5B3542CC;
	Wed,  4 Feb 2026 05:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181765; cv=none; b=EufonnjQyYeyZD0JPTn/JVXMkk/BSvM+9yZ1SW1ua0ckpdfai437N1pXGnq/YLg7KBiiXJKVLD2TOTMA7AZo8mN2K6AbKve7R+bambMhKfzljaltVCiGWkAuRgMMDPAcg/TeTfdrzRWPY637jJ1yreQ35D6VGigu9mD/1EGQQYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181765; c=relaxed/simple;
	bh=sEo96npQHfrM9Xw+dAcfcpavn/0Ov4UeSJyaPDDxEFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzjxWjrPLyc/hdVVcUAlYBcLsk/h1OcfTjyRToms5VLJQ0eirFhicrGbe5Ltv2lBNWNpYj/Evq6c8GlE54/vTayMFCNz7jDIVI+80wJrPSiGl+3aGCeFGWVCNbNWBOe7Z6fd+EUXQqEBvuV/n38hu8gfYNTf2/CO/P5pAWoaEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=E/sOgPKT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZOvcqmcB; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 167271380795;
	Wed,  4 Feb 2026 00:09:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 04 Feb 2026 00:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1770181765;
	 x=1770188965; bh=nJtSWChYFVufGICSrThoSoHlrNw9bn4Yse/vvvU70+A=; b=
	E/sOgPKToHWjYxZ6WIVxtMg9YuDoZQP0lcZ2muf991rjavLEhG+pl/gFz02ICbaP
	L/M17TOEmg2crZrRhARRBq5ukpFeBmgnqMQvU5G6WgQhvwJbxCDawutyFhC6Nlhe
	vobCn5z4kz4T6jHgcHv7teaPSFfnAu7Ay9VUI5SUA1rH/Uj78x6YGNcFHiODfLal
	PEro/Kgiy8kZls/H7Qn1t31kk0zWU4jUqdamK2Fm3svwKOVzyHoxEb5Mbph5LqDD
	YP722hFWE190uElSrRDc7Z8kesz4Fu/KUldnGz37+mwg3+6uxyQ/fJf3fameixJE
	MecIUqq88RblWsIofUCYNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770181765; x=1770188965; bh=n
	JtSWChYFVufGICSrThoSoHlrNw9bn4Yse/vvvU70+A=; b=ZOvcqmcBE67ozty1S
	rVttn8hUDMPFlNtD7/lhG4wDoHsZmqTdmz8T82HxnxvlslRWWQdOXdkZT5/wrodS
	7Fz8rnQCPhzj4PoFF50jwGWQ2wPqiRBQ/DJE7XviD0+iwL22XN2y5H4xWbQ0vHFq
	NodUgFjKZJsg0sFtZOtPD9i6eiHbd9VobQAUA/bQDU941rwF/50JkT+6twrspaan
	uS0Y0gzLjHRVad5RH6NNUtTy2FKunqV4+gvX7sbBF1tjajLaDPLhCXcUID/l/14D
	NVU5cXGi3YnIhdJHVyCQf28d6R2RF/JiMDshKLxAGjFZVAwXNfBGgnwLz8VLpqno
	MUXVg==
X-ME-Sender: <xms:hNSCaaJ3jxmWC-Yztd67k7nKdiCFe3bYDM3rVfoDbGmy9aZOYCf9Tg>
    <xme:hNSCadsi-1LRJa48a13UlYKzWKI_0bqvuQhsiadix0-jyhQc3HGIRw_FddghE9rH8
    FZD_yVijan_WH2tlOGClz3ujrsx2vRsYgstBsRYPgj_eGsiDQ>
X-ME-Received: <xmr:hNSCaas1HdAHGM-rhlTM7y5nTL0ybkRZGhLNAMxNIDC90JVrt-6xEYaj8pEt_hezTEZ9dfR50gvdRc7YyKN_yzAeDmIv9qm6Yc9k612m9aKm>
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
X-ME-Proxy: <xmx:hNSCaUVvnKDBm49DadJMBtzP60M3LaY0QwUYgucgLuuluHyHtG8fYA>
    <xmx:hdSCaTVvW7BJnqcQP-ta1EDtqawEGUS47cJqgPr5VXeWcxo-WJuIyw>
    <xmx:hdSCaXTHVsTFpco-dF0U69SB6O_p2lzlEkn4m8ZL3BeFGsXsavrQDg>
    <xmx:hdSCaaF9XaNjvfw9hOKHwOtmFdcTlAkqAk9poB7jrxOj1-VArZkcpg>
    <xmx:hdSCaZQiXqVic_VKMEghlflygMschjbZRRb8iLUpZb5-Gw5rARyjNqVL>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 00:09:19 -0500 (EST)
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
Subject: [PATCH 10/13] ovl: change ovl_create_real() to get a new lock when re-opening created file.
Date: Wed,  4 Feb 2026 15:57:54 +1100
Message-ID: <20260204050726.177283-11-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-76255-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,ownmail.net:mid,ownmail.net:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,brown.name:replyto,brown.name:email]
X-Rspamd-Queue-Id: EC273E1BFE
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

When ovl_create_real() is used to create a file on the upper filesystem
it needs to return the resulting dentry - positive and hashed.
It is usually the case the that dentry passed to the create function
(e.g.  vfs_create()) will be suitable but this is not guaranteed.  The
filesystem may unhash that dentry forcing a repeat lookup next time the
name is wanted.

So ovl_create_real() must be (and is) aware of this and prepared to
perform that lookup to get a hash positive dentry.

This is currently done under that same directory lock that provided
exclusion for the create.  Proposed changes to locking will make this
not possible - as the name, rather than the directory, will be locked.
The new APIs provided for lookup and locking do not and cannot support
this pattern.

The lock isn't needed.  ovl_create_real() can drop the lock and then get
a new lock for the lookup - then check that the lookup returned the
correct inode.  In a well-behaved configuration where the upper
filesystem is not being modified by a third party, this will always work
reliably, and if there are separate modification it will fail cleanly.

So change ovl_create_real() to drop the lock and call
ovl_start_creating_upper() to find the correct dentry.  Note that
start_creating doesn't fail if the name already exists.

This removes the only remaining use of ovl_lookup_upper, so it is
removed.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c       | 24 ++++++++++++++++++------
 fs/overlayfs/overlayfs.h |  7 -------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index ff3dbd1ca61f..ec08904d084d 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -219,21 +219,33 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent,
 		err = -EIO;
 	} else if (d_unhashed(newdentry)) {
 		struct dentry *d;
+		struct name_snapshot name;
 		/*
 		 * Some filesystems (i.e. casefolded) may return an unhashed
-		 * negative dentry from the ovl_lookup_upper() call before
+		 * negative dentry from the ovl_start_creating_upper() call before
 		 * ovl_create_real().
 		 * In that case, lookup again after making the newdentry
 		 * positive, so ovl_create_upper() always returns a hashed
 		 * positive dentry.
+		 * As we have to drop the lock before the lookup a race
+		 * could result in a lookup failure.  In that case we return
+		 * an error.
 		 */
-		d = ovl_lookup_upper(ofs, newdentry->d_name.name, parent,
-				     newdentry->d_name.len);
-		dput(newdentry);
-		if (IS_ERR_OR_NULL(d))
+		take_dentry_name_snapshot(&name, newdentry);
+		end_creating_keep(newdentry);
+		d = ovl_start_creating_upper(ofs, parent, &name.name);
+		release_dentry_name_snapshot(&name);
+
+		if (IS_ERR_OR_NULL(d)) {
 			err = d ? PTR_ERR(d) : -ENOENT;
-		else
+		} else if (d->d_inode != newdentry->d_inode) {
+			err = -EIO;
+			dput(newdentry);
+		} else {
+			dput(newdentry);
 			return d;
+		}
+		return ERR_PTR(err);
 	}
 out:
 	if (err) {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 315882a360ce..4fb4750a83e4 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -406,13 +406,6 @@ static inline struct file *ovl_do_tmpfile(struct ovl_fs *ofs,
 	return file;
 }
 
-static inline struct dentry *ovl_lookup_upper(struct ovl_fs *ofs,
-					      const char *name,
-					      struct dentry *base, int len)
-{
-	return lookup_one(ovl_upper_mnt_idmap(ofs), &QSTR_LEN(name, len), base);
-}
-
 static inline struct dentry *ovl_lookup_upper_unlocked(struct ovl_fs *ofs,
 						       const char *name,
 						       struct dentry *base,
-- 
2.50.0.107.gf914562f5916.dirty


