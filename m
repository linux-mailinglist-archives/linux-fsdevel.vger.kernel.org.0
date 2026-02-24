Return-Path: <linux-fsdevel+bounces-78331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNFnE2wnnmn5TgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:34:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD3418D5FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E7C9318B1A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D91F349AF8;
	Tue, 24 Feb 2026 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Qsc1ePeS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JJyeWTwq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D5934E769;
	Tue, 24 Feb 2026 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972085; cv=none; b=jKgKQJaP/XNr3vZFyEKgktXUNvFmDhmvXVcuMPssGO3rboPJ78XziQRCpnIUir8Ix6d6bYoQnaJPZmP3w79lbxfgEJ9FEt25SED1KUxzpv6kgvdZeg052jUtz7AEOPF1slH43kLBJhR/HWW45GcAc4rA60uv25pleEHPXm70yrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972085; c=relaxed/simple;
	bh=ZN5XFPn7tUkfMGc5iwQB3ZTfDKP5sgGwhooynf+keDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pt+buVsZVublxOsMOYAUoEHbflAvNSuvyz0HYwK3Z8bn0bwQhJFrt2QyxwKCb2m+leNjh/5BbhF33cSHg2gC8TGkLP4Nmmrw9Xr1+v/E5LKjhXq3zGAJTaMf3xXvUuAuOgB8jnRIepDI6LPvR6viCsnSi8jIkB51Srm/9glubaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Qsc1ePeS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JJyeWTwq; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id B1B5F138052C;
	Tue, 24 Feb 2026 17:28:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 24 Feb 2026 17:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771972083;
	 x=1771979283; bh=wijvxZQWm9lKy/h3JSFEVjiYfslMBA04IhCaGLEm+aw=; b=
	Qsc1ePeSEaLWi8BDrsD9vY2ogxq/J/OJ+6DtZSsY4kpbC630IqfzW2ELvRLbF0xH
	n4n/hLKHJSnJiMVp1uNGG9Rlxq7ptH66Wbkf+bBs6qm42CnmQkbjQ5NXMMEBGMoH
	h7PMEuKXYCi19HURgYdLP3S9jxRjkCqwMchfscEqtL3c4vBlqOlEUBAK97192xNf
	6Ov/iwuTkTMx0yjx6vpVUsTSbCOyIXhOBPbDM6okDqghjBNbm+nEGNs8MDP1Uf7d
	1ID2SjWug65BTZe73wsuY9EGSugYjl9IlHJ1k+IknPOIaYGQr90i6+2nvRg7L+0x
	0cVwg5VLWo1u+dJo7qF0DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771972083; x=1771979283; bh=w
	ijvxZQWm9lKy/h3JSFEVjiYfslMBA04IhCaGLEm+aw=; b=JJyeWTwqbNVQ7ik2z
	5xdf8bbM5zDUFVdjfpi/zzOa4qnkq62FeoQ/DA5Z+vQmEJZ3al1E1urqxtv4d0Ld
	bE1ikLaQU7vA7bjRcHCKFDcGsJm16dhB6MypAhLDUFS4hyxWokG7yCbDgvKL9Q4e
	05Tz8O9CuryBcvGdj330lyokQejeynz5uXNSrCFgFmWDYFqg9CSSPo8XTTnnC5iK
	qWAUDw+Qd/WvQhLieYeLl20fh1gs7DZndVW7Ou9sCisHuObLPHB2NuZ2SkbwWMBb
	zCtwpOmP25+0KbHOPRdBmp+0GApQWThdjOdVsVn+3Bu+0AordG3i6cFHx7kw67Rj
	DiUcQ==
X-ME-Sender: <xms:8yWeaV50ce2t6SX59updm27nWQp8eGTKxw3rAaNZjL4DXBBbZSebtw>
    <xme:8yWeaW1HraDo8_99jFRL_aecm-h1fk4i_3OGtcuNhB--O_d9DxhUuRfSUi879bqbG
    qKZB0631GoQG-wU0UrmkcXYrikooe74BWIE3MGcCFOrhPDz>
X-ME-Received: <xmr:8yWeaU-XLL_iiElhQE7t7J8AyUG3uo0EVt7_NHMg2d7Fu4ruE0u3FtfmxMP3FVr3s10BZVC3OC719hMiadZwuRCKmukNcpVQa2t6ZnAr5kfs>
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
X-ME-Proxy: <xmx:8yWeaXt3neb7aslKJKcFebjTHhwfQfaqArxLek_2NK9m5pOR6El_1Q>
    <xmx:8yWeaQq0kEjtPws5Iv1mh25sJdoENaWIfgZyqM9V_JOnSEBMhRBEnQ>
    <xmx:8yWeaSG23osBRWpmi-0jY49_lLWwSTQ7Jm6D4szgx_LxwBw-LjnaqA>
    <xmx:8yWeaT5Y0nn_7QnsucvZuSrdnEqWFyMkR86WvQXCmZU-pM2CpKItwA>
    <xmx:8yWeaexc3PiU1gq6QfAmp2yyI8lJDKi8Zck37lv-r0FJGHXHFn_25csr>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:27:57 -0500 (EST)
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
Subject: [PATCH v3 15/15] VFS: unexport lock_rename(), lock_rename_child(), unlock_rename()
Date: Wed, 25 Feb 2026 09:17:00 +1100
Message-ID: <20260224222542.3458677-16-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-78331-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:mid,ownmail.net:dkim,brown.name:replyto,brown.name:email,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FD3418D5FB
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

These three function are now only used in namei.c, so they don't need to
be exported.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst | 7 +++++++
 fs/namei.c                            | 9 +++------
 include/linux/namei.h                 | 3 ---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 1dd31ab417a2..d02aa57e4477 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1368,3 +1368,10 @@ lifetime, consider using inode_set_cached_link() instead.
 
 lookup_one_qstr_excl() is no longer exported - use start_creating() or
 similar.
+---
+
+** mandatory**
+
+lock_rename(), lock_rename_child(), unlock_rename() are no
+longer available.  Use start_renaming() or similar.
+
diff --git a/fs/namei.c b/fs/namei.c
index a5daa62399d7..77189335bbcc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3775,7 +3775,7 @@ static struct dentry *lock_two_directories(struct dentry *p1, struct dentry *p2)
 /*
  * p1 and p2 should be directories on the same fs.
  */
-struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
+static struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
 {
 	if (p1 == p2) {
 		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
@@ -3785,12 +3785,11 @@ struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
 	mutex_lock(&p1->d_sb->s_vfs_rename_mutex);
 	return lock_two_directories(p1, p2);
 }
-EXPORT_SYMBOL(lock_rename);
 
 /*
  * c1 and p2 should be on the same fs.
  */
-struct dentry *lock_rename_child(struct dentry *c1, struct dentry *p2)
+static struct dentry *lock_rename_child(struct dentry *c1, struct dentry *p2)
 {
 	if (READ_ONCE(c1->d_parent) == p2) {
 		/*
@@ -3827,9 +3826,8 @@ struct dentry *lock_rename_child(struct dentry *c1, struct dentry *p2)
 	mutex_unlock(&c1->d_sb->s_vfs_rename_mutex);
 	return NULL;
 }
-EXPORT_SYMBOL(lock_rename_child);
 
-void unlock_rename(struct dentry *p1, struct dentry *p2)
+static void unlock_rename(struct dentry *p1, struct dentry *p2)
 {
 	inode_unlock(p1->d_inode);
 	if (p1 != p2) {
@@ -3837,7 +3835,6 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
 		mutex_unlock(&p1->d_sb->s_vfs_rename_mutex);
 	}
 }
-EXPORT_SYMBOL(unlock_rename);
 
 /**
  * __start_renaming - lookup and lock names for rename
diff --git a/include/linux/namei.h b/include/linux/namei.h
index c7a7288cdd25..2ad6dd9987b9 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -165,9 +165,6 @@ extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
 extern int follow_up(struct path *);
 
-extern struct dentry *lock_rename(struct dentry *, struct dentry *);
-extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
-extern void unlock_rename(struct dentry *, struct dentry *);
 int start_renaming(struct renamedata *rd, int lookup_flags,
 		   struct qstr *old_last, struct qstr *new_last);
 int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
-- 
2.50.0.107.gf914562f5916.dirty


