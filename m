Return-Path: <linux-fsdevel+bounces-78353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKKbHffcnmkTXgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:28:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D822E1967BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 647EC30F95C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 11:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1CA394490;
	Wed, 25 Feb 2026 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="alfu1oFC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6104D393DF7;
	Wed, 25 Feb 2026 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018721; cv=none; b=CcdwmjKuKZ2LDFOauOJz0bpAy+LDquWn46ZP/VV6et+GfR1BFm8TI/gM3g+NAogQt9BZEh3iS8VAj7SFFrZ9FqOP9TxQt3NpdwkNt5Y1f7ySmM+VfvBt0+hrUO0XmY0N1/lBJG0UAqLvUqefdqUjjUK4jWHcQsBMu2EA9bcQj5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018721; c=relaxed/simple;
	bh=Qh8KwzManAX1Jvn1/cEkLKhWxqyawNeQEFLzMnfIC/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H65VPQGmN8jMvJoq9MvTMuTwIkMXot7jB0jEIW5PE1CCy3vo2MJCzHhySAsNo9f7sRnQkerW/zpq6jQAlr+aUOI+qvQMSMFwbw+Qfzy8gA2CUL0ttM9QLlmoNivjOeOsEX6DAFiORBchcdUbLrIO0CdoqweCbwrY/GkuW2GYhAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=alfu1oFC; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9keiUKuR9YO5TYYSpyLSfn+0/T4EYYqevZQeVZSKLv8=; b=alfu1oFC0u+2Y6KZiVHfKiLN0t
	FqRk/3uYvP8UY2N5Pqo2gJcW6oUzYC/iv66AqkTr3jD0pDY0gfODtXc65cQvVGYg487N3Gp3/aF0y
	gtObpKSQeibkBG0KaTR/n3GBcdVQ/cwckJQFyLa31Ez8nWn/R6lhOIzWoV0xx7fgYUQe25gelDsNV
	AUUsR4nFnIOm8BucPmp9Zt2XU2w/rNi8KWrC7cFzs1oPS+E/lD+SnWeGrQhKWoKWSOXvEytIb2IJI
	vKEaAWtwiFMWKCt+pI7YXQ32qGELhl5Pn7XFNMS8nUwK1/lowJDqe7U5+fAFtIn5eSHiosoUphMLv
	Kgp658qQ==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vvD0o-005CmO-OQ; Wed, 25 Feb 2026 12:25:02 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Kevin Chen <kchen@ddn.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v3 4/8] fuse: drop unnecessary argument from fuse_lookup_init()
Date: Wed, 25 Feb 2026 11:24:35 +0000
Message-ID: <20260225112439.27276-5-luis@igalia.com>
In-Reply-To: <20260225112439.27276-1-luis@igalia.com>
References: <20260225112439.27276-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78353-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[szeredi.hu,gmail.com,ddn.com,bsbernd.com,kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,igalia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D822E1967BD
X-Rspamd-Action: no action

Remove the fuse_conn argument from function fuse_lookup_init() as it isn't
used since commit 21f621741a77 ("fuse: fix LOOKUP vs INIT compat handling").

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/dir.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index a1121feb63ee..92c9ebfb4985 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -354,8 +354,8 @@ static void fuse_invalidate_entry(struct dentry *entry)
 	fuse_invalidate_entry_cache(entry);
 }
 
-static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
-			     u64 nodeid, const struct qstr *name,
+static void fuse_lookup_init(struct fuse_args *args, u64 nodeid,
+			     const struct qstr *name,
 			     struct fuse_entry_out *outarg)
 {
 	memset(outarg, 0, sizeof(struct fuse_entry_out));
@@ -421,8 +421,7 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 
 		attr_version = fuse_get_attr_version(fm->fc);
 
-		fuse_lookup_init(fm->fc, &args, get_node_id(dir),
-				 name, &outarg);
+		fuse_lookup_init(&args, get_node_id(dir), name, &outarg);
 		ret = fuse_simple_request(fm, &args);
 		/* Zero nodeid is same as -ENOENT */
 		if (!ret && !outarg.nodeid)
@@ -571,7 +570,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	attr_version = fuse_get_attr_version(fm->fc);
 	evict_ctr = fuse_get_evict_ctr(fm->fc);
 
-	fuse_lookup_init(fm->fc, &args, nodeid, name, &outarg);
+	fuse_lookup_init(&args, nodeid, name, &outarg);
 	err = fuse_simple_request(fm, &args);
 	/* Zero nodeid is same as -ENOENT, but with valid timeout */
 	if (err || !outarg.nodeid)

