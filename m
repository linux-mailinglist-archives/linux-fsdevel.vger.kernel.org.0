Return-Path: <linux-fsdevel+bounces-76246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOZtKInUgml5cQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:09:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE8FE1B62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D56A308B829
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 05:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696C2353EE0;
	Wed,  4 Feb 2026 05:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="DhtD8bzC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w89hP2rE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A335B1632E7;
	Wed,  4 Feb 2026 05:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181695; cv=none; b=i2gPW6BIWWDbUWrqnxY/Tl/JcB7IsxhMirjflJ91sDIW6XMajinMOWn4X27IlHGRoiabC/d2z1ISn2AA5/GCyNJpFkbL3zo5sapBqW9j7hdtLnYcoNYvPaT+FhqGjiqYj5GM92Bvl0jNd4ReGwmznJC3/ZakSOoaag+3jXMPDHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181695; c=relaxed/simple;
	bh=FB/uc3IA68XJYpoaP3UA2p1FkWkGkzu0EoP3vo0ZfU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7ZdYMflYHA0UCfsLai6FkkPnM6IH34h5QkOqZfiHyK4JCWZKu5GdbDvYWSqqYKCz4BbimdyjgNOgZ1epIBSvpLYxHSxt5ngpR2j50PJofftavMVh8tWHFVb9R878IZ+Er/QszgGRXNVESGLI2orE9K0112Six+G7noJY/T9XKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=DhtD8bzC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w89hP2rE; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id EA7B0138077B;
	Wed,  4 Feb 2026 00:08:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 04 Feb 2026 00:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1770181694;
	 x=1770188894; bh=3vylP70Td4gLvBkKBkP+NDaQ107NjHxVZqjmkf4RPM4=; b=
	DhtD8bzCE/oNQIkGTTjyqSX4LQFUqFhjVSWKj/iXxrgRLl9NMJgIFm1xZ4/+udL+
	/9QWvwMQV6geJ18mtU4+cgzDERVj1ReQO2ExjsJaVPBAVXtasGRepSdMNCEs3Cen
	CSHYUma0vbM4ukuPPL8Z+pOn/nj6EBbbHKgw+8Uy+6hKfGk7XO7tQ6p6EyhH6c8C
	6p87VF0V5HVZ3l4zZJvwKWrqJ1tuJ4YK8Vb4OGfaZgK4ZEwkYmQGCwmBQcSAAb+W
	YTqNDXuE4QXcuT2g5nwtYr+JVfmjJkqqHAoAEzlxhbyx6v3JmJad53Gh8DcrsokT
	ZZ8ubTAUQbE5Utbhr9g6Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770181694; x=1770188894; bh=3
	vylP70Td4gLvBkKBkP+NDaQ107NjHxVZqjmkf4RPM4=; b=w89hP2rEFqQl9e3q2
	g2FP5CWLzoLxvBPctBENFDxM58CxydFLvse3FHdP6d0+csiZVe2ZvqhGTbwvpjLN
	8RZExjMi7fsXAsrW2rNHsW8myHB3LnaOhRbyUB74IWtr8/qkS7dOTCDnbVKBtB1o
	TkoG0g9EuxvgI28XT+UnTGzKof8yNAjVTmIBkM2hvmtfEnwcacSmkVx000eCS3VM
	GKno6xlQSBDJjHWqV8Jzuvr5kjZ3q7qpw40XTCPMFdJu7SnRFt3E98DL/BqeNVEF
	P+RWyaXoyUXGMz2W7fIKHBAtXLUjLtTMg1lzqsBu+G8WvZ+9okCIlHHVcJNQBI95
	IeHAQ==
X-ME-Sender: <xms:PtSCaRWK9CbwYmtwwlh5aoV8Dyt096I5dx4dm5-UQ2ahT-mugdIwog>
    <xme:PtSCadJPm5HNUHC82q7naFpsh7T9mJ46Be5jIwHNl69dpLD-CxhuM2O2thJ8k_Ur8
    IaAnukIuBfqVdHk1DOtI5ax30L0AChNU-7_9TfKpwrWh3vwqg>
X-ME-Received: <xmr:PtSCadZEaggWHYq0wx4dK8BuY-9dGYzUuqF2q6qf-sxhwmMWZQ-R_uLTVUYkVeWcBDFKqwc2gTH0q1PsjPJRVRlloKGWvQXJOycNcA_OjKEG>
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
X-ME-Proxy: <xmx:PtSCaZSGsBqfYqbFFS8dtfzI2ivVNXNwDGaqiKOPBmwCVKJrs0LH5g>
    <xmx:PtSCadhVrra5MkiI8N6tG94c5mXG8tip-xJcKGrKu_bp0501UG2d7A>
    <xmx:PtSCadtsHemgaPVocEe53BqPbwoeWP6Fz8DlHNPTF7gvd3V3UWs00A>
    <xmx:PtSCaXx0gJHSWG2JkZc3PQb04rk9gpV4HtUVRHcN2h3onw-czQ39mA>
    <xmx:PtSCaU9Mqd1v6-21hkHMOFCVfaR5earMybe2t_lXznNPm_tYkXKs48Ir>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 00:08:09 -0500 (EST)
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
Subject: [PATCH 01/13] fs/proc: Don't lock root inode when creating "self" and "thread-self"
Date: Wed,  4 Feb 2026 15:57:45 +1100
Message-ID: <20260204050726.177283-2-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-76246-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:mid,ownmail.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:replyto,brown.name:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 2EE8FE1B62
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

proc_setup_self() and proc_setup_thread_self() are only called from
proc_fill_super() which is before the filesystem is "live".  So there is
no need to lock the root directory when adding "self" and "thread-self".
This is clear from simple_fill_super() which provides similar
functionality for other filesystems and does not lock anything.

The locking is not harmful, except that it may be confusing to a reader.
As part of a an effort to centralise all locking for directories for
name-based operations (prior to changing some locking rules), it is
simplest to remove the locking here.

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


