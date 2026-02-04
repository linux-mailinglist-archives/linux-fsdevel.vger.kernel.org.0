Return-Path: <linux-fsdevel+bounces-76252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBEsJYXUgml5cQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:09:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE80E1B4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BB7B300F997
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 05:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3024C354AD1;
	Wed,  4 Feb 2026 05:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="PfzG4VfU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vI1bsTE0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D33D353EE9;
	Wed,  4 Feb 2026 05:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181742; cv=none; b=BpTiDzBF74qHcV2Eg3frSgIbDHljnRta38FHJqCTUo1AdCtAttj9A7q8260y5iL4KNVE5tdQhKMbvuTbrxKTnQT4Kp7mDYM4cN9+ymuBkQzXj6UfNdXt9W0g2RACT+KvvQruQiQ3QNxmPKSSBV8VdceaPSdYxjKU2iKovedwkvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181742; c=relaxed/simple;
	bh=szaegCj6EuoIzcSxYsl3y37lh1EU/+GDN4Dj+hHqAMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzlimoPAGHWX/uGzJ740RKih0jPOGXLoNSWYYJ6W+GBXcmuq9V8eIDCgkptN/lQjm0fOZm9WvaMnaIRfY9iIh4Hsotq1/5yOIEIk/d8ACQS71gIduTZU6CiPu0CHOLzYD+4P3RVSbwiKpkFJiJRUkFTZKPUaqltdrXL5iy6q22s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PfzG4VfU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vI1bsTE0; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 0596B1380791;
	Wed,  4 Feb 2026 00:09:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 04 Feb 2026 00:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1770181742;
	 x=1770188942; bh=1n4lIAxtUgYajLCifkhNHQVF/GnsaAGGAoPUyk9Rs5w=; b=
	PfzG4VfUoa4kqnybFWiRirIn8E+3tUu2xcunk30foo2e06HIR48ujZB8b3xxusgm
	WVSM0gMq9sTgfuG3YaZVBrji7gcfCV35aznQOyzvdfUO7hRo9/cj5uXa2WWBKE8M
	HT1TxjSqBPOtlgke9WjuSUhuqTDK0WsjpXm8BERnV4C+LkNKrpACwAm0u/7blDQ8
	AlQPu5DSJk+OLJ4UNsVDg+cE4bIbEmQwPj2VUu6ZUEk30mI9k7HIkcQoOwOIyAZw
	qkaXLSDZC/49EtfMmNKrMuQw8F5ql63HYMn8/w9Obblbi4GpXok73xz/1ftFOzaZ
	7MBxMYrPzWzkse+wJgk90Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770181742; x=1770188942; bh=1
	n4lIAxtUgYajLCifkhNHQVF/GnsaAGGAoPUyk9Rs5w=; b=vI1bsTE0ScZ4pS5tu
	ze1uWD8qTwq+UFYud0AFiKMwMUfHP0HFyyQEY5bG7tZrySF5/f2E0HX1Xw2t3t7v
	hA6en9hIxsCU+xJ1GmqAw2rRvw1DhJ42LRkph6rd7h7wUZOGMvIA89hmA8xz02NO
	juE/pmHjikSChuPMt2koSlhPlCChASZ41Wx5yJsTLl9KrQ24RvB8L5ca8nz+mqr+
	+zp7A05Wp38hlZSAFyivv2FvSaXO7YhAC3gbAV5ltP5MR0k6cqyenDDAQlZtkRW/
	kjF5JievC7DbFWZIp5mGy3dKMjxG1unQaf4A5nrue6+1h5pPnj2GZnxYOtI3Qk0k
	aUgtw==
X-ME-Sender: <xms:bdSCaZajut9P0mv6SRPb5AKgXkFI1wtlRBOXv9o-5CxpQc1WyHW1QQ>
    <xme:bdSCab8Rypm_QZWj3HM0plElx9sWGV-HF7OPyKpw-gYdkHROaSEBtfJ4YmxSgdDN9
    ftnJaNNPiUar4U-wCmqk1RbMMbJNe-oH-zNI07JHik8Fpi9kuY>
X-ME-Received: <xmr:bdSCab_ECdN75wefMdIYBc_svaUmmoWVLC3d1ueeGDWGc0ZOouWvXjq7RlXXwJjkbo4aUP94M6lW5aEcQnnUkBHMbmzEDjMTZBStRaaCkxRf>
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
X-ME-Proxy: <xmx:bdSCaclSUaYdZdcl_HuB5Gi44brVVDJkvhdM3W-bZ6Z6OghhUNz27w>
    <xmx:bdSCaWnmeNhNf9NGnlryVtvfEpwJ3EhiRJu4G032YgkRtneFh4nqNg>
    <xmx:bdSCaZhA603sM_N5pByFe7XMuPlm0PR041pbodRDTTsgeWA-CLefUQ>
    <xmx:bdSCafVpm4Ha7-DcZ_-AMmxDN4vq93H_huln7RT-kPWoSsnS8NQ8mQ>
    <xmx:btSCaWibUNdm9CX7JCYqBP378_jdso1AUwPNGAvpRGGXVVnLX-fzkjKN>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 00:08:56 -0500 (EST)
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
Subject: [PATCH 07/13] VFS: make lookup_one_qstr_excl() static.
Date: Wed,  4 Feb 2026 15:57:51 +1100
Message-ID: <20260204050726.177283-8-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-76252-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ownmail.net:mid,ownmail.net:dkim,messagingengine.com:dkim,brown.name:replyto,brown.name:email]
X-Rspamd-Queue-Id: BFE80E1B4A
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

lookup_one_qstr_excl() is no longer used outside of namei.c, so
make it static.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst | 7 +++++++
 fs/namei.c                            | 5 ++---
 include/linux/namei.h                 | 3 ---
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index ed3ac56e3c76..ed86c95d9d01 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1340,3 +1340,10 @@ The ->setlease() file_operation must now be explicitly set in order to provide
 support for leases. When set to NULL, the kernel will now return -EINVAL to
 attempts to set a lease. Filesystems that wish to use the kernel-internal lease
 implementation should set it to generic_setlease().
+
+---
+
+**mandatory**
+
+lookup_one_qstr_excl() is no longer exported - use start_creating() or
+similar.
diff --git a/fs/namei.c b/fs/namei.c
index 40af78ddfb1b..307b4d0866b8 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1730,8 +1730,8 @@ static struct dentry *lookup_dcache(const struct qstr *name,
  * Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
  * Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
  */
-struct dentry *lookup_one_qstr_excl(const struct qstr *name,
-				    struct dentry *base, unsigned int flags)
+static struct dentry *lookup_one_qstr_excl(const struct qstr *name,
+					   struct dentry *base, unsigned int flags)
 {
 	struct dentry *dentry;
 	struct dentry *old;
@@ -1768,7 +1768,6 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 	}
 	return dentry;
 }
-EXPORT_SYMBOL(lookup_one_qstr_excl);
 
 /**
  * lookup_fast - do fast lockless (but racy) lookup of a dentry
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 58600cf234bc..c7a7288cdd25 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -54,9 +54,6 @@ extern int path_pts(struct path *path);
 
 extern int user_path_at(int, const char __user *, unsigned, struct path *);
 
-struct dentry *lookup_one_qstr_excl(const struct qstr *name,
-				    struct dentry *base,
-				    unsigned int flags);
 extern int kern_path(const char *, unsigned, struct path *);
 struct dentry *kern_path_parent(const char *name, struct path *parent);
 
-- 
2.50.0.107.gf914562f5916.dirty


