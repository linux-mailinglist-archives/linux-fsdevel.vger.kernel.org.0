Return-Path: <linux-fsdevel+bounces-77887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGDBN2Wqm2mb4QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:16:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4556D171357
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E998305A431
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03764257423;
	Mon, 23 Feb 2026 01:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="A2ZDjogy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p9bPsCpx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546F5231C9F;
	Mon, 23 Feb 2026 01:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771809200; cv=none; b=ut6LkQxWU0UrzK2XwUv6eh2kKg12874eUCFPDlMqmq3uYukOSoBdVXsGPbjngCKMiVVy6wiy+oD0BhDVTsJYGJZ56E3pN4ViVSSz2vcKOF/fA67L6GQM0GB51tEf6QSCnKu/EOJeIk16GbcYzslnVTYa21cL4/XiIZd+S+oaBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771809200; c=relaxed/simple;
	bh=vlxskyEUB0dnx8Tl8FcZiAX25ptet1IjxeqP5VrcfUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcorXLoFVU/FRWAj1CmEQ5eB8Ev4rdOjSni5lhPr5EpgVw5OyZtV8ypkHR8cRMPo1Ks+33uC8dWzPinfobyLB5LKhXDURjtl2AUI9zMBwu3/3oLcKEbMJJhAYVBYX2YSEUczQCNhfhLq7T1/rZ3r19xifnIpPXWVxeVx+cgdXi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=A2ZDjogy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p9bPsCpx; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id A26B413807AC;
	Sun, 22 Feb 2026 20:13:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 22 Feb 2026 20:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771809198;
	 x=1771816398; bh=O4F49usif+OP5XD8k3JzmeUE/gWUb/ClWD4S6e21APM=; b=
	A2ZDjogyAeueQm3VULS1JYIm4Z2/9muD4MFKmmAQJe8ZDc6fKUIJ+udJZKePzdgv
	vLUS3PlyBid0N94vo61vyMGpf1kCT4Xpc97sJbFCOjYn7knSodGWdEOJpL2BF/Rs
	2YM1Lwo+jGyOxGZYeEsZI4iHSDmChMZeP3t2G7Kh7vFZmJGU53dGs9TFo8HWiA40
	JxTSthdlUa9Su/YF55dxHR3jw+YUKZlZDhkFuHxnu7EnRQB3bhPP4kTNf9yVmfE7
	4RwNFpgQV0+pglI+aakYpfCZUb6vSydp7Pq8cUvo7nb3R4tJ06nNPi0FJuTvuVXr
	4fwgR+LbuT3sAHPLjO4gqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771809198; x=1771816398; bh=O
	4F49usif+OP5XD8k3JzmeUE/gWUb/ClWD4S6e21APM=; b=p9bPsCpx/iOtvGUVM
	4gmG8sq5sg1m7Dr1t+nYuHG08hEZW9eO8O0BwAnVHvyQHXgSuS9SGyFog+P4d5uJ
	4dmu2E2tIsGbXKq8J+Hh9+4IFdPUQ9AtMlvHGpUpUt5aIi30FFCtTZ9rmvc1b+9L
	hCHKU4XFAsXb1eqMA3bfK3ZnlSpSW2V7CuWKmwGxkY+1/5Yyi3sELKFP4wi5NwMg
	71kGICWhu9xTXaqeA5pgBeMCxgJgQ/ZH0bdWm8PJA72l1zUgNEGF+BeYb29e48L5
	Xofi+h5fpTr5HXqAAcqWq0VTnYW6gTQPcGnxIAXymd7972qqqLr/d/t3cTHfIXnb
	EVH2w==
X-ME-Sender: <xms:rqmbaQtIqQqOCEscY7aURyE_Vw6tIH4oXApz2fOTyqeyF0mJza7opw>
    <xme:rqmbaRbWG2M6umnFygKktr2iXqpke4PWaKFtdgymbqPZKvpaT-6qc7PBjuJ68j2Tn
    zfRs_G2K1atSaZ6yYXwVVlo2bxGKqENe3eqjkyvtDaHiS1_RQ>
X-ME-Received: <xmr:rqmbaUQrN-4_covSKNUqrs00JV1RUCahCWNILqvTC-WtHRJUoWs2P7gN5JuBiKxtz1nIhX9rabrgIpM0mU7B7uxmTFbt_bKY6KxO2iLx7YP2>
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
X-ME-Proxy: <xmx:rqmbacyU6Eqtm5ExMC3pvFj8bNmsLKDjWJA0ixJRhbxw5avgppOtnA>
    <xmx:rqmbaYf1jr0yXFyzhyKmVq0ZzoaqoG_TO9u4Ye2bX9OSnCr_M3oDFA>
    <xmx:rqmbaVrmMpDxEEcrGCZ1LbMLXjzcWnkqwk6ix8MJD38ZXu-5ybIX1A>
    <xmx:rqmbaYMWiteP_XY1_7ZLI6CIG6AHFkKA069CgysB84iKNxTPSNLfng>
    <xmx:rqmbae1YDQOYXiRdmKzur85QJjjz6RCXS6HrK5m5Sm6phIIpozIoFVS_>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 20:13:12 -0500 (EST)
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
Subject: [PATCH v2 05/15] Apparmor: Use simple_start_creating() / simple_done_creating()
Date: Mon, 23 Feb 2026 12:06:20 +1100
Message-ID: <20260223011210.3853517-6-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-77887-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:mid,ownmail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 4556D171357
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

Instead of explicitly locking the parent and performing a look up in
apparmor, use simple_start_creating(), and then simple_done_creating()
to unlock and drop the dentry.

This removes the need to check for an existing entry (as
simple_start_creating() acts like an exclusive create and can return
-EEXIST), simplifies error paths, and keeps dir locking code
centralised.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 security/apparmor/apparmorfs.c | 35 ++++++++--------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 2f84bd23edb6..f93c4f31d02a 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -282,32 +282,20 @@ static struct dentry *aafs_create(const char *name, umode_t mode,
 
 	dir = d_inode(parent);
 
-	inode_lock(dir);
-	dentry = lookup_noperm(&QSTR(name), parent);
+	dentry = simple_start_creating(parent, name);
 	if (IS_ERR(dentry)) {
 		error = PTR_ERR(dentry);
-		goto fail_lock;
-	}
-
-	if (d_really_is_positive(dentry)) {
-		error = -EEXIST;
-		goto fail_dentry;
+		goto fail;
 	}
 
 	error = __aafs_setup_d_inode(dir, dentry, mode, data, link, fops, iops);
+	simple_done_creating(dentry);
 	if (error)
-		goto fail_dentry;
-	inode_unlock(dir);
-
+		goto fail;
 	return dentry;
 
-fail_dentry:
-	dput(dentry);
-
-fail_lock:
-	inode_unlock(dir);
+fail:
 	simple_release_fs(&aafs_mnt, &aafs_count);
-
 	return ERR_PTR(error);
 }
 
@@ -2585,8 +2573,7 @@ static int aa_mk_null_file(struct dentry *parent)
 	if (error)
 		return error;
 
-	inode_lock(d_inode(parent));
-	dentry = lookup_noperm(&QSTR(NULL_FILE_NAME), parent);
+	dentry = simple_start_creating(parent, NULL_FILE_NAME);
 	if (IS_ERR(dentry)) {
 		error = PTR_ERR(dentry);
 		goto out;
@@ -2594,7 +2581,7 @@ static int aa_mk_null_file(struct dentry *parent)
 	inode = new_inode(parent->d_inode->i_sb);
 	if (!inode) {
 		error = -ENOMEM;
-		goto out1;
+		goto out;
 	}
 
 	inode->i_ino = get_next_ino();
@@ -2606,18 +2593,12 @@ static int aa_mk_null_file(struct dentry *parent)
 	aa_null.dentry = dget(dentry);
 	aa_null.mnt = mntget(mount);
 
-	error = 0;
-
-out1:
-	dput(dentry);
 out:
-	inode_unlock(d_inode(parent));
+	simple_done_creating(dentry);
 	simple_release_fs(&mount, &count);
 	return error;
 }
 
-
-
 static const char *policy_get_link(struct dentry *dentry,
 				   struct inode *inode,
 				   struct delayed_call *done)
-- 
2.50.0.107.gf914562f5916.dirty


