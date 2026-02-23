Return-Path: <linux-fsdevel+bounces-77886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uc6BMTyqm2mu4QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:15:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B3B1712CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 176173051454
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F66E20B80B;
	Mon, 23 Feb 2026 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="iNBVJLyJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UnCX7v2I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193C21A76BB;
	Mon, 23 Feb 2026 01:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771809192; cv=none; b=e6jPVb0LtG686dlPM6BWcKVw+ojmEB6HL+QyigBtd1G6iy2E0T34Pdbarjr7kNMElIlvk/X9+gKlGwNbyWBHElVQwEjt9cCuuN9n0o083wn9zXKFHNNzxfKZTEcD27gZiAtqKlUenyY6+kPZCGua5YJL3f0Hrhp/ATKOR8EnkEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771809192; c=relaxed/simple;
	bh=KuROo3JMGIM8j5aDxLYEHHUTuMsukyM2SLM5WpxIkqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQmUd86N89IkU2SV2ffZiVsyNdAagpS5ylJSLtCA8S7SYcCYBs8BEiWcQTJ/xFu9vm9KTNN6d1SrIP/8EzSwl7A0qIFP22KCEEtJgCTiwMQYgoI9Z3BHl0M8zCGMlur/oywXf7BXYYaoYlehCGAgU4DG05QmYXMsF4MoznohyPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=iNBVJLyJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UnCX7v2I; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.phl.internal (Postfix) with ESMTP id 8818013807AC;
	Sun, 22 Feb 2026 20:13:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sun, 22 Feb 2026 20:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771809190;
	 x=1771816390; bh=tmfYUs18u0P/igCXZvtuab+4hhfHHoKRLjZ+0PQIG4w=; b=
	iNBVJLyJT2/2nYTBExUQGUDGC3MBexXlH1Pl54+BnlXAc6MwBmS2XQ9EQExYRKbf
	snMEl56sLn5x0fhT8tmAFaccR/bJZ0OQoTV+PUESQyoIog+FhT31zFtfqiQqk9qT
	X21FCTKjdDbiQRqFnrqR/LArzpu53H7Q6eDjM8PhhpUn1ftKwhqm9LVmnzUl0zWS
	6kemztpQSprR8GBSGlKJrvB5gGWkPWdQlEoqSksIQ/UO8SkVJSulngf/5HkA72Sy
	urGnvqnIC9fwa8yhyv7doZoU8bzdHYv3W6IzC+0YqgYfsJkKe+hiH2RbxIq8ql7g
	I1doF3C7vv8qCuHvo+h7kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771809190; x=1771816390; bh=t
	mfYUs18u0P/igCXZvtuab+4hhfHHoKRLjZ+0PQIG4w=; b=UnCX7v2I8jpgw9D74
	0Pdd9jjqOlr5Ln3EvRHmg6sY38YbGAjfpYPNSptkcGazqKPeUD3WI57AcgO9NkFD
	dz2nVRveiPlcvJjAoY0XE2lRLFM0xMdhJJcMT12vOPEk/eBS9VQNheHlu9mtKH55
	J7VlQ8tWNc+5o+yzogXaXim/gBAGmjWVjl2eX7OYgkYxZgmj6Fq2zqQmgyvTqxCt
	kAehUg/x6kcqMgJ4eSBR7hIRtxAg+nsrkVyWu14PGuYgGwCtWnyrSPe5WudTkXPB
	w/gT5+ikTEExsLdkKCYKyaEnj8IKRQkMzkurmSyzmSruC5CpavOEarusLZrjg7gS
	mmi4Q==
X-ME-Sender: <xms:pqmbaaN0m7G1LlF2CR4COhVnKHzKQpGbquEkDUmmrchyd2VlrQoVlQ>
    <xme:pqmbac5iafiQK2CZ69nLX6kud_6Zs5h2jLW8RPfpFmTVgDNb_sEMN3sAw4ogmD80d
    Rgn6rbvXSoT3_3f_flRqdPV_bgYvscOgdT-iksAj7Uttrro>
X-ME-Received: <xmr:pqmbaZxlSXaI094DHaNXYftNgK9Zl5b0I1rIJLGG3Kb3wNxbrxDPOnUbeEYyawjhznXF_Eq4IpnR7nWNEwaCL62_KW8Huq95YmxZLt7LR-vO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehkeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:pqmbaUR8NrQZsSyfJ726cjwxW8vw2r6ZK_23sAnoB57enAguZ1PTSg>
    <xmx:pqmbaZ9TUARuuQyyDP_5Eyob_hw8qzw9BreSd1Kj-eHFgEu-jp8aAg>
    <xmx:pqmbaZKGMfkEvAifhJL7B6M2H80VXjAJqbeiwNMjCZE983QgtUGaLg>
    <xmx:pqmbaVuehpOqXsXTCzTfwNqZxD1FUtfoY0vaUdoA5ZXKkfWCXGwRVg>
    <xmx:pqmbaVX3OXJoF99V1aVUAMZUYtZckvYbHog-pargisZdFdoFq0ysDAD8>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 20:13:04 -0500 (EST)
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
Subject: [PATCH v2 04/15] libfs: change simple_done_creating() to use end_creating()
Date: Mon, 23 Feb 2026 12:06:19 +1100
Message-ID: <20260223011210.3853517-5-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-77886-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,ownmail.net:mid,ownmail.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31B3B1712CE
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

simple_done_creating() and end_creating() are identical.
So change the former to use the latter.  This further centralises
unlocking of directories.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/libfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 74134ba2e8d1..63b4fb082435 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2318,7 +2318,6 @@ EXPORT_SYMBOL(simple_start_creating);
 /* parent must have been held exclusive since simple_start_creating() */
 void simple_done_creating(struct dentry *child)
 {
-	inode_unlock(child->d_parent->d_inode);
-	dput(child);
+	end_creating(child);
 }
 EXPORT_SYMBOL(simple_done_creating);
-- 
2.50.0.107.gf914562f5916.dirty


