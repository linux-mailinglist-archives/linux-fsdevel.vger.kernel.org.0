Return-Path: <linux-fsdevel+bounces-76247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAmbB1DUgml5cQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:08:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D7EE1AEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA288300BEA7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 05:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD44353EE9;
	Wed,  4 Feb 2026 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="KiIPM8T+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RvJkWztt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414DD32F759;
	Wed,  4 Feb 2026 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181703; cv=none; b=Ql9joq8I4PnLUP3BOMXRK20NDt8xfo/9lgOKR4POidl7JqBy+j06f6+KMxVZ/aKMDdls+mxL6rujoDTPudoPZYoHV3MW1BGqwN4KAbtPbL1bhAqTevbvSWN0f2/l3HBNI3WabPl3P+y+xr4JAWHonSNGrKmcMSBNIbDQUqpVvn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181703; c=relaxed/simple;
	bh=WcuGfAaU+Z2+KHqcZEi7NR4U2jlWhd5mTxC/d64/YfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKlzqlJxIG/7Hfe2cnz/wqKQaa3XZI6TzzHBDMqwWwnyXM1m8hKmtnGHBKuLnof68YqjV2lwLAmzda+phCStG4o29DcTY6QqbKSmFmalis5jssjs0eucYVol5ww0HD7TNf4kHB086q3Q4dTXdrByi+/GcimUmz47gT37Wa+GAxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=KiIPM8T+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RvJkWztt; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 863B21380781;
	Wed,  4 Feb 2026 00:08:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 04 Feb 2026 00:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1770181702;
	 x=1770188902; bh=czLckKBE0Hyt9Dd+uhzinS1Ik9k72RW9/tiMvXjH9ZE=; b=
	KiIPM8T+9Qs7OMViXU2ryPo92F7MQmvanDSVUIjj5kC57ZcpVQaFnv4rQ1NMLi4B
	+0RV73AC3r13JN5qIK1EhD+Tu70qyQCgvG1EHuvV5EPBAXYRAVPdX8jol3tDjUl+
	xCuDDT+BHlg+nhgNj7Q16RBLeutN55zpthaytVCWQGcbSeQxYiM4BYvrGKScCx3J
	ZdcE5j4rU3uZZYWzLeOdqIF+ZKUo3CNqxDFnJaQTY3nVKvxowyR9+UkPlD+N5g+F
	NdWf52di24JGw/l9PriGoDD7z/vEmDmWIwFDlbPXl2AazB1bGjPw9gG2E3Nmypf4
	xBdB1ZxRbTl2gKxhSjEUjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770181702; x=1770188902; bh=c
	zLckKBE0Hyt9Dd+uhzinS1Ik9k72RW9/tiMvXjH9ZE=; b=RvJkWztt3XeqOopzq
	Z3hLdDpnoBpjoznAYPP7N0yKlbOsq5EXH1Bszoir1vuBAX48a9NgeogyHQ73wHEo
	z/oizouEHIODIXBpnV33EA61RMDPTbwj+rAepzhBlc4VLCUYJ1uI7KRdrHOs6hw1
	JTLepBfzI+42m6l5+4R8v1tBuvf1ywnQauoadNBniqZM39DAExI68jtT1Qxyko5U
	d82AM3QiOyxyn/v9u3WQ4Tt8iHhnjHFIZKeWhGRK27Ns1sIjLIcma7JtZgJS/ygA
	pq5sgU4k8HHaFdrU4XtoAZdA37ixRm5dktHh7MMsltzrp/PAW5dkeo2C3XPrwUmw
	RwEZw==
X-ME-Sender: <xms:RtSCaSaTeFPpwZ9ad5ECOH79gWBgfv8Uw60jM-icIBHcn9J8GK85Rg>
    <xme:RtSCaQ9ypD_gg3ssbVAeszvRJFosEo9N69T_G15GjBZU5L-iwWmp6WBNYiaNyziD5
    YU7MBzgrQ8Qc4aCJOnqCWOTrAjUD2Kfsz7lprM5fmJFK3A>
X-ME-Received: <xmr:RtSCac-mTM3MPBtazCIE51UTNsCjLtw-TALLZJD84jeacmyiwAssCyXhRQdhS3MdhL4epXsdBpPj2_uW4QfaAGxWY_OTLVzmbTPjZqE5Q7T8>
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
X-ME-Proxy: <xmx:RtSCaZnzpZLunuK6z5TIO8Aj7lUMUd_Fy0B2rnFKFFVaYfWAJQyMpQ>
    <xmx:RtSCafk-vCA_IzafYYcNyxP39V2qQpHXVCREOmBpqllj7uWP2ErqUQ>
    <xmx:RtSCaehV6RiZ72St-j3GmlBEVQEJq95INHC71585LPTuTSPtdKqpFA>
    <xmx:RtSCaQVdsDxSUpYL_PlDqbsr5oWbrM8KhOJ9NixtxGdE520zekBqoQ>
    <xmx:RtSCaXhYhR2dry0tYUo7vtVGScp-vIyzxkT3enECCHJuTuKSjv22NqRf>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 00:08:16 -0500 (EST)
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
Subject: [PATCH 02/13] VFS: move the start_dirop() kerndoc comment to before start_dirop()
Date: Wed,  4 Feb 2026 15:57:46 +1100
Message-ID: <20260204050726.177283-3-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-76247-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,ownmail.net:mid,ownmail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 89D7EE1AEC
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

This kerneldoc comment was always meant for start_dirop(), not for
__start_dirop() which is a static function and doesn't need
documentation.

It was in the wrong place and was then incorrectly renamed (instead of
moved) and useless "documentation" was added for "@state" was provided.

This patch reverts the name, removes the mention of @state, and moves
the comment to where it belongs.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index b28ecb699f32..40af78ddfb1b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2841,20 +2841,6 @@ static int filename_parentat(int dfd, struct filename *name,
 	return __filename_parentat(dfd, name, flags, parent, last, type, NULL);
 }
 
-/**
- * __start_dirop - begin a create or remove dirop, performing locking and lookup
- * @parent:       the dentry of the parent in which the operation will occur
- * @name:         a qstr holding the name within that parent
- * @lookup_flags: intent and other lookup flags.
- * @state:        task state bitmask
- *
- * The lookup is performed and necessary locks are taken so that, on success,
- * the returned dentry can be operated on safely.
- * The qstr must already have the hash value calculated.
- *
- * Returns: a locked dentry, or an error.
- *
- */
 static struct dentry *__start_dirop(struct dentry *parent, struct qstr *name,
 				    unsigned int lookup_flags,
 				    unsigned int state)
@@ -2876,6 +2862,19 @@ static struct dentry *__start_dirop(struct dentry *parent, struct qstr *name,
 	return dentry;
 }
 
+/**
+ * start_dirop - begin a create or remove dirop, performing locking and lookup
+ * @parent:       the dentry of the parent in which the operation will occur
+ * @name:         a qstr holding the name within that parent
+ * @lookup_flags: intent and other lookup flags.
+ *
+ * The lookup is performed and necessary locks are taken so that, on success,
+ * the returned dentry can be operated on safely.
+ * The qstr must already have the hash value calculated.
+ *
+ * Returns: a locked dentry, or an error.
+ *
+ */
 struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
 			   unsigned int lookup_flags)
 {
-- 
2.50.0.107.gf914562f5916.dirty


