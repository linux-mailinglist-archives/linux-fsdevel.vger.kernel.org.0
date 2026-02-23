Return-Path: <linux-fsdevel+bounces-77895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHwPBY2qm2mu4QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:17:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 953221713A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D8AB3055576
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042202BDC0B;
	Mon, 23 Feb 2026 01:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="LWHP7ipA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kdCcOrz8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A9257452;
	Mon, 23 Feb 2026 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771809268; cv=none; b=e4meBRDYOud/Xvq1/FUgNbHoiEUveXPg5MWTNNx2tCDyhnvOCTg5tmEaedYieClbb2f+fxqoc5fK+/6zCTPtig1WoZkjI7MSR0kOVVyWY8Cwg1U68ZiT7g0wHjDvdqXsjJJPViXU98OxpWPy4rrhVe6sCE1QZRleWb1B8FTUjT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771809268; c=relaxed/simple;
	bh=8npN8lDUKLB/B/vi6olsXCscd/grdMnQXyTSElVQCIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbHBJdkL2pwMiuTDCkKKV4xiQUElKrEOP3riKk8+POGMiGkU94J1W/pdAd6AYGRXw9DWjhYlz1sz0xsPc3m0LWBGt908WDLG2hBXNnlaGijC+pZqT0wkazuoe1sMZW5IjOIArP+Sbvpm+JHeG8E+ADPuGq48lsoDDHuv7fNOcpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=LWHP7ipA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kdCcOrz8; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.phl.internal (Postfix) with ESMTP id CDA1613807AC;
	Sun, 22 Feb 2026 20:14:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sun, 22 Feb 2026 20:14:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771809266;
	 x=1771816466; bh=zoLaKvUIcq0LBSrvSvYdTrZyLAsLuraYZU3vedQYf7U=; b=
	LWHP7ipA7aoxVkSx9/ga8otxxNysTI6aOYkGNEY04VquVUsQdL65GdEMLquBgjbZ
	Lr8i/u0BGtb1t6IwNhqP7exD6BPfLP7wOcLnaPYlJe8AYLMb3djsfeXmlmnQXgqR
	m5fOuCcwEkZ81jfjDofMviu6E11NOKdzmC6sRqFl31fewivFnd1HkXB6LIWkZNBV
	8SHmgLPM4R631GIDyLkNAOc2HIy3gELd5qrSbcufgEsMGtLC8fNoYh2BhMyJajHt
	T/LhYaWxh7fq7B6XSe1WerWhvVPxxwFf0KIwY1VL600hPvih6hlqkoahk0ikvx2o
	IhLZg4urw3l1X/P2TTeH+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771809266; x=1771816466; bh=z
	oLaKvUIcq0LBSrvSvYdTrZyLAsLuraYZU3vedQYf7U=; b=kdCcOrz8Yn/o4tF0f
	sbl8LyztUevhsY2RtxugWwQBkBDYnyMSJCL3NbqZ0cJKfoXvBCfWZ+TuuJCix6sC
	ZPytJbsN2r5tcKbN8EuDGriAKSh6016FUy1OzKdvUMPES0+4zbvV9ADQEq/wVQE1
	BgyJ/mc8kXUmUSg66Fwgqc0UjdOwKvu2rIbeM0RljrxKWIYCyAphfme+DTv3GdR2
	NIGv3UxpCWiINzVTHO+Q7WYLlvPB6DsSEleQf3f1sA9mA/JCzcd6pPs2v4W+p/yE
	iy0hzmtHnqQRRdkDAHd5v1bFFcAlugAe3bLHWEm+41OK6FuSCOpR208r7G3obceN
	MP1YQ==
X-ME-Sender: <xms:8qmbacADZNbiO7Y2yIE08fxAyvwUHfkg_-04X2zEz1vSicm2I3xVXg>
    <xme:8qmbaSdgHufXnzQxWb6P8_rnlWtJh7zJF_UOtqR_tt89ck2yWF7oZd_E6xpQx0Rwq
    UADQLNNrdxaCZxI2DZLox2ReHKwSDz5aQ99ahLPjMp1rEFu>
X-ME-Received: <xmr:8qmbaYE6A3Gd6wY0XwFNHfR7LHL3jrHbt7vbwFOdNEz3lKDmKp9Oq9e4oVBdboYok-WT7sks_Xg34PonNqzghGvv1HdStY7inyDC5If4Nhec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehkeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:8qmbacXft0N6vFCMJRRO3JFF1tgfoBgBuBSGxO7FpgDDnr4RhTh_ZA>
    <xmx:8qmbaYyXufaQuBEji0UAT97vnJu7AtccRAEotXycK0rVy2G4T9x3vg>
    <xmx:8qmbaXtghudcr7SgVvBvTSV91YQL5jAUELoefQC2nAc3_-DcvZ9fag>
    <xmx:8qmbaZC8OjpTPIcn_vuQl8PPezayir7kAU5ELilPpCGyFOVxJfHtuA>
    <xmx:8qmbaTLp79yJqv9Vm99DgQaPUcZs8koOXi7thBtUmohPh_LzpUspFXtp>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 20:14:20 -0500 (EST)
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
Subject: [PATCH v2 13/15] ovl: use is_subdir() for testing if one thing is a subdir of another
Date: Mon, 23 Feb 2026 12:06:28 +1100
Message-ID: <20260223011210.3853517-14-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-77895-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,ownmail.net:mid,ownmail.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 953221713A6
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

Rather than using lock_rename(), use the more obvious is_subdir() for
ensuring that neither upper nor workdir contain the other.
Also be explicit in the comment that the two directories cannot be the
same.

As this is a point-it-time sanity check and does not provide any
on-going guarantees, the removal of locking does not introduce any
interesting races.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/super.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 109643930b9f..58adefb1c5b8 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -451,18 +451,13 @@ static int ovl_lower_dir(const char *name, const struct path *path,
 	return 0;
 }
 
-/* Workdir should not be subdir of upperdir and vice versa */
+/*
+ * Workdir should not be subdir of upperdir and vice versa, and
+ * they should not be the same.
+ */
 static bool ovl_workdir_ok(struct dentry *workdir, struct dentry *upperdir)
 {
-	bool ok = false;
-
-	if (workdir != upperdir) {
-		struct dentry *trap = lock_rename(workdir, upperdir);
-		if (!IS_ERR(trap))
-			unlock_rename(workdir, upperdir);
-		ok = (trap == NULL);
-	}
-	return ok;
+	return !is_subdir(workdir, upperdir) && !is_subdir(upperdir, workdir);
 }
 
 static int ovl_setup_trap(struct super_block *sb, struct dentry *dir,
-- 
2.50.0.107.gf914562f5916.dirty


