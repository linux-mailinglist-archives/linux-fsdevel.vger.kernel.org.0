Return-Path: <linux-fsdevel+bounces-78327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLzEKFEmnmkaTwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:29:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B37B18D45B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 768AD3113560
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B32F34A3BC;
	Tue, 24 Feb 2026 22:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="NebVhl4U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fdd69+d/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646A13446DA;
	Tue, 24 Feb 2026 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972051; cv=none; b=R4iSJY9qst7zKN7R1s3jf4DMjl/va1fciR8X2O/ftw46ZcCIBQlouUm6OfF+UTOmUnUe/6AJym8XwV1PNQawGIWnsKQ8meGYarsBnXraDSdkvt/3LzMCnchGZsVMk4GbQSiAFY+a6UNquKuGvS5pLNVQXWoxf2slDTgoD3WlePM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972051; c=relaxed/simple;
	bh=Ud6UMjR5slj5om3VuWv4NgZ/iI9BwzOPv899jPc7cKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANyRdaCpMkhxU40M1Ry115RFFcBuPVo+0dd2g0DnqbGFbEYWFx97TTvqQG1TOPxONFBixWul2Tev+Y0A9txAnWxN5CdNX3lL2UxO2AsH9f5KR95vOsjdKiDuS8JJgg81M+lcOPdizgLWi9rZTPz15WH5OdFrWnen8ikL3uWn3Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=NebVhl4U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fdd69+d/; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id B446513805A6;
	Tue, 24 Feb 2026 17:27:29 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 17:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771972049;
	 x=1771979249; bh=vIMZKjfxmKkyu011y6KfL+N7g881UsmJU+U6+HLmMTM=; b=
	NebVhl4Uf0rQN6394D508zLVskPRA5kGJQqYtRAomfY3tJEG/4rasGHfTSOQlFW2
	WYW6BfxyHAvW/qQwxEumP0R5MCvRDhPpu9AQXj2AnNolzy3Ns4w3Qp4xuHt4rp8Q
	I06NaoDbmb7beCZ9P9gbf43WiOocoR91ywAFr4d6z/a2T71UrVG06faOxckf5MUE
	qsAxeIDt9S3qbq24h6OpAhKXm73qOHK6fW3hmyqPZ7aRN06ZuUJ6kegrpCuQQyjy
	1eFPRLI2Ipo+3CDUNp6upNbj/utD+G2SfrT48EEPjRhkeZnMwAa756C5B/8Nj1y2
	XJM81OYuELL69EX+3EAzFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771972049; x=1771979249; bh=v
	IMZKjfxmKkyu011y6KfL+N7g881UsmJU+U6+HLmMTM=; b=Fdd69+d/T013npC8h
	52Nt0SQ4HswdfJ5xjrIYiPjnQ2MDsau2C5CUT14zXzgT0dq8pXaGGo7Fhp17T7TB
	6yYDrW9oIFE0QRMnBsDBlea/pmF7yOrJ/VzKxmAAURgQafKsfdWaGuZ/CwWVfO97
	tHZewOpTmP0m9Ar0XChtj6RLLPf8GZEQ58EuHWdzZiIIqeY2E6k2NfyCdKVU4DHJ
	WfgxLcrxIU/nf0FvAcHwfexPQ0PTmrIX9LUb7Ldx/D4lFZGGORySIU8+6dYO1dfq
	2zpbyhjoFF5S5jsiEWBywRGPd74v8ISQr9eEeJC8nP/DmZtDPtO6xcHVU1DXIlwG
	J4ivw==
X-ME-Sender: <xms:0SWeaSe__UelJqauzvKjb8dBe2ssw74aa5xZm9gTEl7RVTWgNrfftg>
    <xme:0SWeaQK15XiUYwoW2R6B8cRwib_1BFxwlrfL9s3fDqyRPMpNUtoHHRJ5xBQpUvWof
    iuMsqg-8ZVGhDCj8Q8bnN70sufPPl66kHhLtFMy79JK7sQ3fg>
X-ME-Received: <xmr:0SWeacAdA716rIg0a6w0foGljLybvYaBk1u6IilFkiIuFOCnPVm8Tqr4bJrPmtyQ2PcdfVLe2iTacsebrv9WX57yPUpI_nfP6lzkFxAJlEeN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedufeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:0SWeaZg76qW1kadSC2zWUSznnvk-bRVH6IzXhORXNigu1_8mRgveDw>
    <xmx:0SWeaWNCLqVnHeuyRgytgouAXNnhtVcSoC3t6XWh6LAZDfJj8dsQhw>
    <xmx:0SWeaQZI5PDVRjMPFsTw2S-WgRNIGtqjm7gyQLZZCYCWRK-jx5SdBw>
    <xmx:0SWeab80YZP_XNxpfzgGFFPyuyWopzDNjkAPcOl5cptPOY5kkEhz_A>
    <xmx:0SWeadloxb2KJg35QewtDb4ElbVa5O-lhBjw_G2rPRq3SPVD-dBjlFEQ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:27:23 -0500 (EST)
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
Subject: [PATCH v3 11/15] ovl: pass name buffer to ovl_start_creating_temp()
Date: Wed, 25 Feb 2026 09:16:56 +1100
Message-ID: <20260224222542.3458677-12-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-78327-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,ownmail.net:mid,ownmail.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 3B37B18D45B
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

Now ovl_start_creating_temp() is passed a buffer in which to store the
temp name.  This will be useful in a future patch were ovl_create_real()
will need access to that name.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index ff3dbd1ca61f..c4feb89ad1e3 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -66,10 +66,9 @@ void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
 }
 
 static struct dentry *ovl_start_creating_temp(struct ovl_fs *ofs,
-					      struct dentry *workdir)
+					      struct dentry *workdir,
+					      char name[OVL_TEMPNAME_SIZE])
 {
-	char name[OVL_TEMPNAME_SIZE];
-
 	ovl_tempname(name);
 	return start_creating(ovl_upper_mnt_idmap(ofs), workdir,
 			      &QSTR(name));
@@ -81,11 +80,12 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 	struct dentry *whiteout, *link;
 	struct dentry *workdir = ofs->workdir;
 	struct inode *wdir = workdir->d_inode;
+	char name[OVL_TEMPNAME_SIZE];
 
 	guard(mutex)(&ofs->whiteout_lock);
 
 	if (!ofs->whiteout) {
-		whiteout = ovl_start_creating_temp(ofs, workdir);
+		whiteout = ovl_start_creating_temp(ofs, workdir, name);
 		if (IS_ERR(whiteout))
 			return whiteout;
 		err = ovl_do_whiteout(ofs, wdir, whiteout);
@@ -97,7 +97,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 	}
 
 	if (!ofs->no_shared_whiteout) {
-		link = ovl_start_creating_temp(ofs, workdir);
+		link = ovl_start_creating_temp(ofs, workdir, name);
 		if (IS_ERR(link))
 			return link;
 		err = ovl_do_link(ofs, ofs->whiteout, wdir, link);
@@ -247,7 +247,9 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 			       struct ovl_cattr *attr)
 {
 	struct dentry *ret;
-	ret = ovl_start_creating_temp(ofs, workdir);
+	char name[OVL_TEMPNAME_SIZE];
+
+	ret = ovl_start_creating_temp(ofs, workdir, name);
 	if (IS_ERR(ret))
 		return ret;
 	ret = ovl_create_real(ofs, workdir, ret, attr);
-- 
2.50.0.107.gf914562f5916.dirty


