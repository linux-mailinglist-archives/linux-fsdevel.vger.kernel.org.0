Return-Path: <linux-fsdevel+bounces-51085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D95AD2B1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 03:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1107C188EAD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 01:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729AE1A38E1;
	Tue, 10 Jun 2025 01:04:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401F84A06;
	Tue, 10 Jun 2025 01:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749517451; cv=none; b=SrYKuRKl1Z8EOm3iq7fuF8Ja9f8yrsZstSPzJrU2fChaxtQLK7OZJKzqLzC1VVetmV4FUhA27deozN+vB5JzzXAn0Atg60PzuzhRf0Nnb0utCMGGRao6UjvT9YR6eEwwHbFDN99iBEEitznKIVAjZllioRuHAWSLY9LDhX0Muww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749517451; c=relaxed/simple;
	bh=oNtpliR18g0ahA+9JLcjGgJv9HpJWIGv69pPnLfP2RQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=dZsk7M4bzLkQwlm/DNF2hIOFQb2rCT8YlbdC0K/VsOK2MVZsPd+L/PnH5j7NtO8QXL0D78PDmkM1mMebMaajc4WNbYnPRyNuds4vMxbaXb/WMeW2W9tgUsnkE34i5CTquIGNHDj/qq+QmkTtXZOmxk+Ns1SmYz4a7TYih4nC1KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOnPJ-0071y3-F8;
	Tue, 10 Jun 2025 01:04:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Steve French" <smfrench@gmail.com>,
 "Christian Brauner" <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>
Cc: "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
 "LKML" <linux-kernel@vger.kernel.org>, "CIFS" <linux-cifs@vger.kernel.org>,
 "Bharath S M" <bharathsm@microsoft.com>
Subject: [PATCH] VFS: change try_lookup_noperm() to skip revalidation
Date: Tue, 10 Jun 2025 11:04:04 +1000
Message-id: <174951744454.608730.18354002683881684261@noble.neil.brown.name>


The recent change from using d_hash_and_lookup() to using
try_lookup_noperm() inadvertently introduce a d_revalidate() call when
the lookup was successful.  Steven French reports that this resulted in
worse than halving of performance in some cases.

Prior to the offending patch the only caller of try_lookup_noperm() was
autofs which does not need the d_revalidate().  So it is safe to remove
the d_revalidate() call providing we stop using try_lookup_noperm() to
implement lookup_noperm().

The "try_" in the name is strongly suggestive that the caller isn't
expecting much effort, so it seems reasonable to avoid the effort of
d_revalidate().

Fixes: 06c567403ae5 ("Use try_lookup_noperm() instead of d_hash_and_lookup() =
outside of VFS")
Reported-by: Steve French <smfrench@gmail.com>
Link: https://lore.kernel.org/all/CAH2r5mu5SfBrdc2CFHwzft8=3Dn9koPMk+Jzwpy-oU=
Mx-wCRCesQ@mail.gmail.com/
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4bb889fc980b..f761cafaeaad 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2917,7 +2917,8 @@ static int lookup_one_common(struct mnt_idmap *idmap,
  * @base:	base directory to lookup from
  *
  * Look up a dentry by name in the dcache, returning NULL if it does not
- * currently exist.  The function does not try to create a dentry.
+ * currently exist.  The function does not try to create a dentry and if one
+ * is found it doesn't try to revalidate it.
  *
  * Note that this routine is purely a helper for filesystem usage and should
  * not be called by generic code.  It does no permission checking.
@@ -2933,7 +2934,7 @@ struct dentry *try_lookup_noperm(struct qstr *name, str=
uct dentry *base)
 	if (err)
 		return ERR_PTR(err);
=20
-	return lookup_dcache(name, base, 0);
+	return d_lookup(base, name);
 }
 EXPORT_SYMBOL(try_lookup_noperm);
=20
@@ -3057,14 +3058,22 @@ EXPORT_SYMBOL(lookup_one_positive_unlocked);
  * Note that this routine is purely a helper for filesystem usage and should
  * not be called by generic code. It does no permission checking.
  *
- * Unlike lookup_noperm, it should be called without the parent
+ * Unlike lookup_noperm(), it should be called without the parent
  * i_rwsem held, and will take the i_rwsem itself if necessary.
+ *
+ * Unlike try_lookup_noperm() it *does* revalidate the dentry if it already
+ * existed.
  */
 struct dentry *lookup_noperm_unlocked(struct qstr *name, struct dentry *base)
 {
 	struct dentry *ret;
+	int err;
=20
-	ret =3D try_lookup_noperm(name, base);
+	err =3D lookup_noperm_common(name, base);
+	if (err)
+		return ERR_PTR(err);
+
+	ret =3D lookup_dcache(name, base, 0);
 	if (!ret)
 		ret =3D lookup_slow(name, base, 0);
 	return ret;
--=20
2.49.0


