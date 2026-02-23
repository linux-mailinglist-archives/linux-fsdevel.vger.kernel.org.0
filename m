Return-Path: <linux-fsdevel+bounces-77884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML6WIOypm2l94QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:14:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C98171225
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C16B303D306
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DA1257827;
	Mon, 23 Feb 2026 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="VkG7WHzv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MHlFIILF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523831A76BB;
	Mon, 23 Feb 2026 01:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771809175; cv=none; b=A9irVrE4ShtlC/HWO9SN7BsC0Eg4195GNL28TUUF49TNv+dADZ/OP96xhuaUFx8wgsgUG284ZhxiFwSqBwjgaiIrU7RrMntZPI6tOfYe4lcA6PZFqN75R4T0ICqN1AY4YYGynaXlWUuHOqb4cQKsMzikSmd4RfiXdp5HK1nmi30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771809175; c=relaxed/simple;
	bh=EWcvGbpStxBrKNDwCaNU/qsj2uNCtRG9uAAL8HCuTAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smV9Hucu1M9zNxjpl0t7Unf/eOMLje5cuabYbdqB5DortFtYqb19RBQGok07443kqNVj+RW/Oh9XgaEK75IA+yB1kuqesEEVfoywsPyiwvrq32TACoqXtls7dC4808nuy2Opwiomy/elG51zwVdPiHhFTSMLMpPsLrwDmiGuyuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=VkG7WHzv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MHlFIILF; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id A2F1113807AC;
	Sun, 22 Feb 2026 20:12:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 22 Feb 2026 20:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771809173;
	 x=1771816373; bh=tPobfa0i3jHvv1Dk9y6zx4amsTjnJAZYw4PN6GvcHrM=; b=
	VkG7WHzvoixd6ubzY5odJm09mG7iXftREpH9V2EzdLf9yyiCnXGgkgFg2Ggmhzwe
	3OiwiLKtH1+YR83Tg3vQb9Ydhimkce8HxkJ7SF7Drmn+nShtszmdw53Kvvy+mRzU
	eMnWsZ5FE/15Nm7ohJcX8YuDt+x/Gub0XKS8wiykDyJy0dAwP21d6DTdY3RXnKMd
	XXrdNoamG0MrSPSdD0cfMV6dNkbkrOrw1FIo8rogEFun8+TSlTB4hePn7eshCvfT
	7aLMU55YFR7HAWWM/Hx9lCiy4G1dQ3cMhOy9Jh24J2DV6pB6zbQOhvX/IdwnBegS
	ZOQSeW1oQ+2oxXFYuR9DyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771809173; x=1771816373; bh=t
	Pobfa0i3jHvv1Dk9y6zx4amsTjnJAZYw4PN6GvcHrM=; b=MHlFIILFDj3wzrnNG
	RyuyfvcDfRHL4BRuVeDj7AMglolqTP6qpECXlGclix2LWF9HfNQMPLLCP6DO/2K7
	yOm6A3RYzil40Xcx5B7CsXBbXz4B8eZ6UEjc1hirXnc3ySK+sWTiI9CRprRnEdQL
	GAOXS9CD45c6RGc9EWEmvQRoKnuNGzreiRmRraLHE5NvKwcsKCIIrefcOL0xO6j6
	grNBiQXhW82i+6doKjKElSDPrslncryMV4oRzRfMPANm4TJhDmwtG9tpe+O+aUbE
	u3Mx0kJATT3B03IypfIiIb264NAeGIGw9Koy8B7iDhQ5hoZq54zUWqhWn1JX394t
	0rsDw==
X-ME-Sender: <xms:lambaU743a3N7nteg2wyOFOGEsyv6Fy4eku-r8muYPeaBF834D4ZaA>
    <xme:lambaQ7eXHKq9aPhGGTq8oCkWy9U0Crzd5MstxiI2tkvxOKrp0yWBAZO8ZRDz6xtL
    e2ynAC4zOwJudOm2tNV2EuqSR_bXG-nx43r6PFYNkDnUlLW8f4>
X-ME-Received: <xmr:lambaaFyu8j6f1gP46miBRNu83vK5hWI9jhv6VwgKwO8v8qqrZ0k1iXTo-k_9ir--F-qtNZssCMujms7JgH032sR13xyQzCYHGKKq0KRlSkF>
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
X-ME-Proxy: <xmx:lambaWyGgSoxCgxtx3FWiiTgRP4Qp2ZW73Cj8kspFOvi-gM1ul8ECQ>
    <xmx:lambaS1qbFshcFgb3bxsW8hniyOSLf-37I4Bb-vnni0Tr4oTk6TB7Q>
    <xmx:lambaRPSq5Ty73GNFmygRB1zWCX8kYCdrwcJPAQs5y7cJrKmRNcJNQ>
    <xmx:lambaWvQs_e1fRYirwpoQuAeCIiCRILakQyRCX7oNsue-26X0zyFnA>
    <xmx:lambaXOXWDohSgpEDyzKkoC3_Phzfj6CIQk-iF47gaNr0zMO8IrXhpc7>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 20:12:47 -0500 (EST)
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
Subject: [PATCH v2 02/15] fs/proc: Don't lock root inode when creating "self" and "thread-self"
Date: Mon, 23 Feb 2026 12:06:17 +1100
Message-ID: <20260223011210.3853517-3-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-77884-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 07C98171225
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


