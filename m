Return-Path: <linux-fsdevel+bounces-78318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MPpF9Ulnmn5TgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:27:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FB218D2FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B96430C6188
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A1C346A19;
	Tue, 24 Feb 2026 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="GBOmuITS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ji6BHf6a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580D233C1B7;
	Tue, 24 Feb 2026 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971977; cv=none; b=DvzhyJkhBG/mX6utGdtL0AS6Y0uait3d9nSlrolq7SYAeSEqyxkSfvf8TOx5I8Tv4fqriazrzySFlFsvyYjwxtCq4sMSktXx+feedE2jyWh3DGleurZ8QsrnSWt632pa46eu2IdRHUMPgd+yg+/PZKTnCKn/WpqgxQPSPbB3nuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971977; c=relaxed/simple;
	bh=EWcvGbpStxBrKNDwCaNU/qsj2uNCtRG9uAAL8HCuTAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bip3gv8WQem5c3lvMEn/40MftJVq/IcO5M2sIAOl4A8VUztDelGxXr56GppFtQhgizhUT/3BxwGGdyFrL7D4mzjg3mDI5PAn9r/kk1rkVrFyw/rHC+Vddr4EIQD2WXq3bndUmxsgMZGsldT0CPElxkOnAdq90s+/rihuvnh2Zdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=GBOmuITS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ji6BHf6a; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id C491D13802AD;
	Tue, 24 Feb 2026 17:26:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 24 Feb 2026 17:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771971975;
	 x=1771979175; bh=tPobfa0i3jHvv1Dk9y6zx4amsTjnJAZYw4PN6GvcHrM=; b=
	GBOmuITSxnJ0zBVJ+LVfhDX24n3oxRgOKWRz0aHEofjwaEv0YNuaedYRJ95TGwAd
	RYQ0aT8EVoXoOYakO8/SJ2QWzdzf7u9RtKyGUxl9eJcw7D1Y2mJuqRqvS+mDs3IE
	vFCaoptFxzMkHzPCRyvfBEDVLWYUU23dnKMYBiynw02k0CtWISG3guFyIgnirdm0
	zddj8N+H7cLy+O0p+kmddNH+zBTC2lLY5rEDBYikyqtFC96vM36VCq75W4DxP1Na
	55A99XpQYaomtAKsptlrssepaxWJir8G86kpidVKKJwfkmhmcSLYFBu2puzqK/aC
	C77yncxWTkVZ0GDj+n9gzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771971975; x=1771979175; bh=t
	Pobfa0i3jHvv1Dk9y6zx4amsTjnJAZYw4PN6GvcHrM=; b=ji6BHf6ag+iUvrc9d
	ti0YI3wi2DWW8jNzZyWp7fqtOBGrwcJIgaBqidIciiHfIEtCOFaH6DJYCy4IIZif
	74JGqmMn+bl+bBLM0vZr0XYO2dIqdD6k76nSM+4861sB7clcrLOB5cqT0lOFTj0c
	hYFXQ1gWl3xdh0Z6fqItxNV6dXbtZ3qR1RqGoocQwZK6rfGYeHQvIs3yqZOELygu
	N3Z6eOT4BQUyyRkiTd0Y9m30UQz2N5PHzcm8YHhem1ZpTe0BAevq5afIN0Vdk2PU
	P7paQ1+yfyfGySjhJP/M0Jq2s20yQpxEC1+FfJTkEOVBnj3g7zTNX3UE8em8QAv+
	X5vWA==
X-ME-Sender: <xms:hyWeaUrXw_yiHdeJApRZvwSCGHi95MaeXKQtAnkBEjsbIveRCXNTQg>
    <xme:hyWeaeltMQUAhLvkkkD5XOM9tE2k45V-DvO3z88yg-XZddiUxFUcI9ghHakuWetIc
    2pmH_TwMQkdREoMDwT6a-ShFlB37ry4ypwuHrjk1NL0I8MQCGg>
X-ME-Received: <xmr:hyWeaRtiVEgB0cvqqxTQ4DQZf1IgrBy0FYjr3KA03HJ8QkuMCpZcQd9l0pJNoE8CWiCjF0deskre9fPCafqhaAg8vY5j6evWg_2zSJfdEyEt>
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
X-ME-Proxy: <xmx:hyWeaVcY0uiiDK6vRfNWnFtyktJ0zNiSiu7kcxCo6c9H1Qjv8VpRdQ>
    <xmx:hyWeabbZTpSqwSFRmP6cL6bLpn2oFoeIJkNG5A2spsiv2unalWScRQ>
    <xmx:hyWeaV1IPYTROvj8sy6YBxdpy_MWuMWaO45WYYsOqpa1W_9nNlp6Qg>
    <xmx:hyWeacqDyAjzL4gKUya-oVYsP-F5qW_dS-cvGwDx5s596-EwCwbsyQ>
    <xmx:hyWeaQiZY7LEPGTsv6elnnur_KUXS3QwX9fqMav7i-YuY8hhRi6N_YJ6>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:26:09 -0500 (EST)
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
Subject: [PATCH v3 02/15] fs/proc: Don't lock root inode when creating "self" and "thread-self"
Date: Wed, 25 Feb 2026 09:16:47 +1100
Message-ID: <20260224222542.3458677-3-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-78318-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:mid,ownmail.net:dkim]
X-Rspamd-Queue-Id: B8FB218D2FA
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

proc_setup_self() and proc_setup_thread_self() are only called from
proc_fill_super() which is before the filesystem is "live".  So there is
no need to lock the root directory when adding "self" and "thread-self".
This is clear from simple_fill_super() which provides similar
functionality for other filesystems and does not lock anything.

The locking is not harmful, except that it may be confusing to a reader.
As part of an effort to centralise all locking for directories for
name-based operations (prior to changing some locking rules), it is
simplest to remove the locking here.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/proc/self.c        | 3 ---
 fs/proc/thread_self.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/fs/proc/self.c b/fs/proc/self.c
index 62d2c0cfe35c..56adf1c68f7a 100644
--- a/fs/proc/self.c
+++ b/fs/proc/self.c
@@ -35,11 +35,9 @@ unsigned self_inum __ro_after_init;
 
 int proc_setup_self(struct super_block *s)
 {
-	struct inode *root_inode = d_inode(s->s_root);
 	struct dentry *self;
 	int ret = -ENOMEM;
 
-	inode_lock(root_inode);
 	self = d_alloc_name(s->s_root, "self");
 	if (self) {
 		struct inode *inode = new_inode(s);
@@ -55,7 +53,6 @@ int proc_setup_self(struct super_block *s)
 		}
 		dput(self);
 	}
-	inode_unlock(root_inode);
 
 	if (ret)
 		pr_err("proc_fill_super: can't allocate /proc/self\n");
diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
index d6113dbe58e0..61ac62c3fd9f 100644
--- a/fs/proc/thread_self.c
+++ b/fs/proc/thread_self.c
@@ -35,11 +35,9 @@ unsigned thread_self_inum __ro_after_init;
 
 int proc_setup_thread_self(struct super_block *s)
 {
-	struct inode *root_inode = d_inode(s->s_root);
 	struct dentry *thread_self;
 	int ret = -ENOMEM;
 
-	inode_lock(root_inode);
 	thread_self = d_alloc_name(s->s_root, "thread-self");
 	if (thread_self) {
 		struct inode *inode = new_inode(s);
@@ -55,7 +53,6 @@ int proc_setup_thread_self(struct super_block *s)
 		}
 		dput(thread_self);
 	}
-	inode_unlock(root_inode);
 
 	if (ret)
 		pr_err("proc_fill_super: can't allocate /proc/thread-self\n");
-- 
2.50.0.107.gf914562f5916.dirty


