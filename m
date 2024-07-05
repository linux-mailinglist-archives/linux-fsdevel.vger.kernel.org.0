Return-Path: <linux-fsdevel+bounces-23184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B62928207
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 08:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D041F2403A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 06:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E49A144D23;
	Fri,  5 Jul 2024 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bjkww8Dy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6921442EF;
	Fri,  5 Jul 2024 06:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160816; cv=none; b=U37D7Dolni5ANX7xwzUXXjiyLSshjRZKvhnKz3VYuu3dL8DfGiGVvL3q9HF6GtQUq0Vp/43l2KQVDschTCj14j/1yOdMruHr0+EM1w93wG41sfOFoyiz/NRFacF910xqfpQby3N9ePUXs0zcr2ASPo/IrURbFnYP2ZMsPK0CWhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160816; c=relaxed/simple;
	bh=el7WDEyxzkTMFs74C0dzBELK1UOmG6xUcP5nR6bp1Fc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CEf1KPlbMazkXzLutvR5iOPH0gMxZiYeJT0qIlX2G9UcP+23zqiBKljeAJUS4jhWAy89gDmHQwd6J9p89k/ZEEIfX5iCZpYsCPrktayyUPNSst4Y/w4mJr9+sRASHwqfaI1/O42fFJfdeAai/mMbpw8ojlY/GPjK0al0TsBik5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bjkww8Dy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720160813;
	bh=el7WDEyxzkTMFs74C0dzBELK1UOmG6xUcP5nR6bp1Fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bjkww8DyZGSv3BdpXAkVnP59v+TpbpGZ5KyEv53gOn18V0vbXLnggvqMlonbgkBKn
	 kDGON7647RZBtowFEjipCHCfa5qLUTKMFKjcg29p/nDrc4vb646DaYVlMEwMC/XSZU
	 A4ZTcxctboZwdPx/8w8jK4FjTg9N8eDaRlyN3rsKiUOyS7u8hpn6yoyawyt1/niKg1
	 P9l5q8V5+oG/vt06FvNhcHLj9FTFx3k3LJRIYR0BcIaW73XER9DzANVQI3T8stPfZe
	 JLUIt7zAKKbN+opkuT/PCEZO2BdQCbfoc+k7nyKGLuNk391GM9CAF1Xursds7UC1h6
	 9v5zDeQpQVy3A==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5605737821F2;
	Fri,  5 Jul 2024 06:26:52 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	tytso@mit.edu,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz,
	adilger.kernel@dilger.ca,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	krisman@suse.de,
	kernel@collabora.com,
	shreeya.patel@collabora.com,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH 1/2] fs/dcache: introduce d_alloc_parallel_check_existing
Date: Fri,  5 Jul 2024 09:26:20 +0300
Message-Id: <20240705062621.630604-2-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240705062621.630604-1-eugen.hristev@collabora.com>
References: <20240705062621.630604-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

d_alloc_parallel currently looks for entries that match the name being
added and return them if found.
However if d_alloc_parallel is being called during the process of adding
a new entry (that becomes in_lookup), the same entry is found by
d_alloc_parallel in the in_lookup_hash and d_alloc_parallel will wait
forever for it to stop being in lookup.
To avoid this, it makes sense to check for an entry being currently
added (e.g. by d_add_ci from a lookup func, like xfs is doing) and if this
exact match is found, return the entry.
This way, to add a new entry , as xfs is doing, is the following flow:
_lookup_slow -> d_alloc_parallel -> entry is being created -> xfs_lookup ->
d_add_ci -> d_alloc_parallel_check_existing(entry created before) ->
d_splice_alias.
The initial entry stops being in_lookup after d_splice_alias finishes, and
it's returned to d_add_ci by d_alloc_parallel_check_existing.
Without d_alloc_parallel_check_existing, d_alloc_parallel would be called
instead and wait forever for the entry to stop being in lookup, as the
iteration through the in_lookup_hash matches the entry.
Currently XFS does not hang because it creates another entry in the second
call of d_alloc_parallel if the name differs by case as the hashing and
comparison functions used by XFS are not case insensitive.

Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/dcache.c            | 29 +++++++++++++++++++++++------
 include/linux/dcache.h |  4 ++++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index a0a944fd3a1c..459a3d8b8bdb 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2049,8 +2049,9 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		return found;
 	}
 	if (d_in_lookup(dentry)) {
-		found = d_alloc_parallel(dentry->d_parent, name,
-					dentry->d_wait);
+		found = d_alloc_parallel_check_existing(dentry,
+							dentry->d_parent, name,
+							dentry->d_wait);
 		if (IS_ERR(found) || !d_in_lookup(found)) {
 			iput(inode);
 			return found;
@@ -2452,9 +2453,10 @@ static void d_wait_lookup(struct dentry *dentry)
 	}
 }
 
-struct dentry *d_alloc_parallel(struct dentry *parent,
-				const struct qstr *name,
-				wait_queue_head_t *wq)
+struct dentry *d_alloc_parallel_check_existing(struct dentry *d_check,
+					       struct dentry *parent,
+					       const struct qstr *name,
+					       wait_queue_head_t *wq)
 {
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
@@ -2523,6 +2525,14 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		}
 
 		rcu_read_unlock();
+
+		/* if the entry we found is the same as the original we
+		 * are checking against, then return it
+		 */
+		if (d_check == dentry) {
+			dput(new);
+			return dentry;
+		}
 		/*
 		 * somebody is likely to be still doing lookup for it;
 		 * wait for them to finish
@@ -2560,8 +2570,15 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	dput(dentry);
 	goto retry;
 }
-EXPORT_SYMBOL(d_alloc_parallel);
+EXPORT_SYMBOL(d_alloc_parallel_check_existing);
 
+struct dentry *d_alloc_parallel(struct dentry *parent,
+				const struct qstr *name,
+				wait_queue_head_t *wq)
+{
+	return d_alloc_parallel_check_existing(NULL, parent, name, wq);
+}
+EXPORT_SYMBOL(d_alloc_parallel);
 /*
  * - Unhash the dentry
  * - Retrieve and clear the waitqueue head in dentry
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index bf53e3894aae..6eb21a518cb0 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -232,6 +232,10 @@ extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_anon(struct super_block *);
 extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *,
 					wait_queue_head_t *);
+extern struct dentry * d_alloc_parallel_check_existing(struct dentry *,
+						       struct dentry *,
+						       const struct qstr *,
+						       wait_queue_head_t *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
 extern bool d_same_name(const struct dentry *dentry, const struct dentry *parent,
-- 
2.34.1


