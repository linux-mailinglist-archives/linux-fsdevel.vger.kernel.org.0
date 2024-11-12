Return-Path: <linux-fsdevel+bounces-34376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9739C4D62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 04:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA76B25AC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 03:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DFD208964;
	Tue, 12 Nov 2024 03:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A/be+K1o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF145205ADF
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 03:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731382555; cv=none; b=aa7S/GYd0No0vCdxbOuxNPs+2gbCSYgK0qTyorxqIzrPzEzsBm4fwPTLkjNr//2oGrGf628VLBkZ33OKU4HUHbeTuvuPkiaTzvd2ldPyovysf18USApOLK6Gba0sudgW+bxHd0Q7UfDX5b2t3L/+J6nsGrvRnJfKyaSRugYERMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731382555; c=relaxed/simple;
	bh=6J4Z/IH8miq2Vj86/pvZl6h+Ef99mZY0cnIU+HWgFeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEFFf0ptMQct8xNr8aQ/WLMHsriLPzaWOBqYr4jz3Hc9s3+3BsLo8jlqM7tLoc5X9mvgm06BsBEX/+OX8ox6ghHPUFhha2rDuMqL1386aSyz8zlBZciYtpjCYEjG84YXY827LNd5SARfcQkEhaAF5xOsQKrmnYWYxH5t+dX0R3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A/be+K1o; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731382551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pU+5IikF3km19ie4C+fsoK6OOEtUdQNll9al6dBtF5E=;
	b=A/be+K1o9Hx/YsSgYNUL6IHzd8k9XeqRo+Q1Rr2BYrWSmEKXtjYs2yXGxfdRa29CjHqDu6
	UyHtVbUgL0cfDdxDS28XG4IhHf0aPH3EPt71nECggyhLk6e2VRSaRdD82dtJUof5TqwuAq
	PMNx65+/JqkFk4s4b60hsRCMTefaNeA=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	brauner@kernel.org,
	sforshee@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: [PATCH 1/3] bcachefs: BCH_SB_VERSION_INCOMPAT
Date: Mon, 11 Nov 2024 22:35:33 -0500
Message-ID: <20241112033539.105989-2-kent.overstreet@linux.dev>
In-Reply-To: <20241112033539.105989-1-kent.overstreet@linux.dev>
References: <20241112033539.105989-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We've been getting away from feature bits: they don't have any kind of
ordering, and thus it's possible for people to enable weird combinations
of features that were never tested or intended to be run.

Much better to just give every new feature, compatible or incompatible,
a version number.

Additionally, we probably won't ever rev the major version number: major
version numbers represent incompatible versions, but that doesn't really
fit with how we actually roll out incompatible features - we need a
better way of rolling out incompatible features.

So, this patch adds two new superblock fields:
- BCH_SB_VERSION_INCOMPAT
- BCH_SB_VERSION_INCOMPAT_ALLOWED

BCH_SB_VERSION_INCOMPAT_ALLOWED indicates that incompatible features up
to version number x are allowed to be used without user prompting, but
it does not by itself deny old versions from mounting.

BCH_SB_VERSION_INCOMPAT does deny old versions from mounting, and must
be <= BCH_SB_VERSION_INCOMPAT_ALLOWED.

BCH_SB_VERSION_INCOMPAT will only be set when a codepath attempts to use
an incompatible feature, so as to not unnecessarily break compatibility
with old versions.

bch2_request_incompat_feature() is the new interface to check if an
incompatible feature may be used.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/bcachefs.h        |  2 ++
 fs/bcachefs/bcachefs_format.h | 25 ++++++++++--------
 fs/bcachefs/recovery.c        | 27 +++++++++++++++++---
 fs/bcachefs/super-io.c        | 48 ++++++++++++++++++++++++++++++++---
 fs/bcachefs/super-io.h        | 18 ++++++++++---
 5 files changed, 99 insertions(+), 21 deletions(-)

diff --git a/fs/bcachefs/bcachefs.h b/fs/bcachefs/bcachefs.h
index 18479787f31a..2110c79b276b 100644
--- a/fs/bcachefs/bcachefs.h
+++ b/fs/bcachefs/bcachefs.h
@@ -771,6 +771,8 @@ struct bch_fs {
 		__uuid_t	user_uuid;
 
 		u16		version;
+		u16		version_incompat;
+		u16		version_incompat_allowed;
 		u16		version_min;
 		u16		version_upgrade_complete;
 
diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
index dc14bfe37e3b..043390ce4b53 100644
--- a/fs/bcachefs/bcachefs_format.h
+++ b/fs/bcachefs/bcachefs_format.h
@@ -842,6 +842,9 @@ LE64_BITMASK(BCH_SB_VERSION_UPGRADE_COMPLETE,
 					struct bch_sb, flags[5],  0, 16);
 LE64_BITMASK(BCH_SB_ALLOCATOR_STUCK_TIMEOUT,
 					struct bch_sb, flags[5], 16, 32);
+LE64_BITMASK(BCH_SB_VERSION_INCOMPAT,	struct bch_sb, flags[5], 32, 48);
+LE64_BITMASK(BCH_SB_VERSION_INCOMPAT_ALLOWED,
+					struct bch_sb, flags[5], 48, 64);
 
 static inline __u64 BCH_SB_COMPRESSION_TYPE(const struct bch_sb *sb)
 {
@@ -894,21 +897,23 @@ static inline void SET_BCH_SB_BACKGROUND_COMPRESSION_TYPE(struct bch_sb *sb, __u
 	x(new_varint,			15)	\
 	x(journal_no_flush,		16)	\
 	x(alloc_v2,			17)	\
-	x(extents_across_btree_nodes,	18)
+	x(extents_across_btree_nodes,	18)	\
+	x(incompat_version_field,	19)
 
 #define BCH_SB_FEATURES_ALWAYS				\
-	((1ULL << BCH_FEATURE_new_extent_overwrite)|	\
-	 (1ULL << BCH_FEATURE_extents_above_btree_updates)|\
-	 (1ULL << BCH_FEATURE_btree_updates_journalled)|\
-	 (1ULL << BCH_FEATURE_alloc_v2)|\
-	 (1ULL << BCH_FEATURE_extents_across_btree_nodes))
+	(BIT_ULL(BCH_FEATURE_new_extent_overwrite)|	\
+	 BIT_ULL(BCH_FEATURE_extents_above_btree_updates)|\
+	 BIT_ULL(BCH_FEATURE_btree_updates_journalled)|\
+	 BIT_ULL(BCH_FEATURE_alloc_v2)|\
+	 BIT_ULL(BCH_FEATURE_extents_across_btree_nodes))
 
 #define BCH_SB_FEATURES_ALL				\
 	(BCH_SB_FEATURES_ALWAYS|			\
-	 (1ULL << BCH_FEATURE_new_siphash)|		\
-	 (1ULL << BCH_FEATURE_btree_ptr_v2)|		\
-	 (1ULL << BCH_FEATURE_new_varint)|		\
-	 (1ULL << BCH_FEATURE_journal_no_flush))
+	 BIT_ULL(BCH_FEATURE_new_siphash)|		\
+	 BIT_ULL(BCH_FEATURE_btree_ptr_v2)|		\
+	 BIT_ULL(BCH_FEATURE_new_varint)|		\
+	 BIT_ULL(BCH_FEATURE_journal_no_flush)|		\
+	 BIT_ULL(BCH_FEATURE_incompat_version_field))
 
 enum bch_sb_feature {
 #define x(f, n) BCH_FEATURE_##f,
diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
index 7086a7226989..e252b6ce0923 100644
--- a/fs/bcachefs/recovery.c
+++ b/fs/bcachefs/recovery.c
@@ -595,6 +595,7 @@ static bool check_version_upgrade(struct bch_fs *c)
 					 bch2_latest_compatible_version(c->sb.version));
 	unsigned old_version = c->sb.version_upgrade_complete ?: c->sb.version;
 	unsigned new_version = 0;
+	bool ret = false;
 
 	if (old_version < bcachefs_metadata_required_upgrade_below) {
 		if (c->opts.version_upgrade == BCH_VERSION_UPGRADE_incompatible ||
@@ -650,14 +651,32 @@ static bool check_version_upgrade(struct bch_fs *c)
 		}
 
 		bch_info(c, "%s", buf.buf);
+		printbuf_exit(&buf);
+
+		ret = true;
+	}
 
-		bch2_sb_upgrade(c, new_version);
+	if (new_version > c->sb.version_incompat &&
+	    c->opts.version_upgrade == BCH_VERSION_UPGRADE_incompatible) {
+		struct printbuf buf = PRINTBUF;
+
+		prt_str(&buf, "Now allowing incompatible features up to ");
+		bch2_version_to_text(&buf, new_version);
+		prt_str(&buf, ", previously allowed up to ");
+		bch2_version_to_text(&buf, c->sb.version_incompat_allowed);
+		prt_newline(&buf);
 
+		bch_info(c, "%s", buf.buf);
 		printbuf_exit(&buf);
-		return true;
+
+		ret = true;
 	}
 
-	return false;
+	if (ret)
+		bch2_sb_upgrade(c, new_version,
+				c->opts.version_upgrade == BCH_VERSION_UPGRADE_incompatible);
+
+	return ret;
 }
 
 int bch2_fs_recovery(struct bch_fs *c)
@@ -1056,7 +1075,7 @@ int bch2_fs_initialize(struct bch_fs *c)
 	bch2_check_version_downgrade(c);
 
 	if (c->opts.version_upgrade != BCH_VERSION_UPGRADE_none) {
-		bch2_sb_upgrade(c, bcachefs_metadata_version_current);
+		bch2_sb_upgrade(c, bcachefs_metadata_version_current, true);
 		SET_BCH_SB_VERSION_UPGRADE_COMPLETE(c->disk_sb.sb, bcachefs_metadata_version_current);
 		bch2_write_super(c);
 	}
diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
index 4c29f8215d54..0b5f0ce199de 100644
--- a/fs/bcachefs/super-io.c
+++ b/fs/bcachefs/super-io.c
@@ -42,7 +42,7 @@ static const struct bch2_metadata_version bch2_metadata_versions[] = {
 #undef x
 };
 
-void bch2_version_to_text(struct printbuf *out, unsigned v)
+void bch2_version_to_text(struct printbuf *out, enum bcachefs_metadata_version v)
 {
 	const char *str = "(unknown version)";
 
@@ -55,7 +55,7 @@ void bch2_version_to_text(struct printbuf *out, unsigned v)
 	prt_printf(out, "%u.%u: %s", BCH_VERSION_MAJOR(v), BCH_VERSION_MINOR(v), str);
 }
 
-unsigned bch2_latest_compatible_version(unsigned v)
+enum bcachefs_metadata_version bch2_latest_compatible_version(enum bcachefs_metadata_version v)
 {
 	if (!BCH_VERSION_MAJOR(v))
 		return v;
@@ -69,6 +69,16 @@ unsigned bch2_latest_compatible_version(unsigned v)
 	return v;
 }
 
+void bch2_set_version_incompat(struct bch_fs *c, enum bcachefs_metadata_version version)
+{
+	mutex_lock(&c->sb_lock);
+	SET_BCH_SB_VERSION_INCOMPAT(c->disk_sb.sb,
+		max(BCH_SB_VERSION_INCOMPAT(c->disk_sb.sb), version));
+	c->disk_sb.sb->features[0] |= cpu_to_le64(BCH_FEATURE_incompat_version_field);
+	bch2_write_super(c);
+	mutex_unlock(&c->sb_lock);
+}
+
 const char * const bch2_sb_fields[] = {
 #define x(name, nr)	#name,
 	BCH_SB_FIELDS()
@@ -364,7 +374,8 @@ static int bch2_sb_validate(struct bch_sb_handle *disk_sb,
 		return ret;
 
 	if (sb->features[1] ||
-	    (le64_to_cpu(sb->features[0]) & (~0ULL << BCH_FEATURE_NR))) {
+	    (le64_to_cpu(sb->features[0]) & (~0ULL << BCH_FEATURE_NR)) ||
+	    BCH_SB_VERSION_INCOMPAT(sb) > bcachefs_metadata_version_current) {
 		prt_printf(out, "Filesystem has incompatible features");
 		return -BCH_ERR_invalid_sb_features;
 	}
@@ -407,6 +418,20 @@ static int bch2_sb_validate(struct bch_sb_handle *disk_sb,
 		return -BCH_ERR_invalid_sb_time_precision;
 	}
 
+	if (BCH_SB_VERSION_INCOMPAT(sb) > BCH_SB_VERSION_INCOMPAT_ALLOWED(sb)) {
+		prt_printf(out, "Invalid version_incompat > incompat_allowed: %llu > %llu",
+			   BCH_SB_VERSION_INCOMPAT(sb),
+			   BCH_SB_VERSION_INCOMPAT_ALLOWED(sb));
+		return -BCH_ERR_invalid_sb_version;
+	}
+
+	if (BCH_SB_VERSION_INCOMPAT_ALLOWED(sb) > le16_to_cpu(sb->version)) {
+		prt_printf(out, "Invalid incompat_allowed > version: %llu > %u",
+			   BCH_SB_VERSION_INCOMPAT_ALLOWED(sb),
+			   le16_to_cpu(sb->version));
+		return -BCH_ERR_invalid_sb_version;
+	}
+
 	if (!flags) {
 		/*
 		 * Been seeing a bug where these are getting inexplicably
@@ -520,6 +545,9 @@ static void bch2_sb_update(struct bch_fs *c)
 	c->sb.uuid		= src->uuid;
 	c->sb.user_uuid		= src->user_uuid;
 	c->sb.version		= le16_to_cpu(src->version);
+	c->sb.version_incompat	= BCH_SB_VERSION_INCOMPAT(src);
+	c->sb.version_incompat_allowed
+				= BCH_SB_VERSION_INCOMPAT_ALLOWED(src);
 	c->sb.version_min	= le16_to_cpu(src->version_min);
 	c->sb.version_upgrade_complete = BCH_SB_VERSION_UPGRADE_COMPLETE(src);
 	c->sb.nr_devices	= src->nr_devices;
@@ -1159,7 +1187,7 @@ bool bch2_check_version_downgrade(struct bch_fs *c)
 	return ret;
 }
 
-void bch2_sb_upgrade(struct bch_fs *c, unsigned new_version)
+void bch2_sb_upgrade(struct bch_fs *c, unsigned new_version, bool incompat)
 {
 	lockdep_assert_held(&c->sb_lock);
 
@@ -1169,6 +1197,10 @@ void bch2_sb_upgrade(struct bch_fs *c, unsigned new_version)
 
 	c->disk_sb.sb->version = cpu_to_le16(new_version);
 	c->disk_sb.sb->features[0] |= cpu_to_le64(BCH_SB_FEATURES_ALL);
+
+	if (incompat)
+		SET_BCH_SB_VERSION_INCOMPAT_ALLOWED(c->disk_sb.sb,
+			max(BCH_SB_VERSION_INCOMPAT_ALLOWED(c->disk_sb.sb), new_version));
 }
 
 static int bch2_sb_ext_validate(struct bch_sb *sb, struct bch_sb_field *f,
@@ -1333,6 +1365,14 @@ void bch2_sb_to_text(struct printbuf *out, struct bch_sb *sb,
 	bch2_version_to_text(out, le16_to_cpu(sb->version));
 	prt_newline(out);
 
+	prt_printf(out, "Incompatible features allowed:\t");
+	bch2_version_to_text(out, BCH_SB_VERSION_INCOMPAT_ALLOWED(sb));
+	prt_newline(out);
+
+	prt_printf(out, "Incompatible features in use:\t");
+	bch2_version_to_text(out, BCH_SB_VERSION_INCOMPAT(sb));
+	prt_newline(out);
+
 	prt_printf(out, "Version upgrade complete:\t");
 	bch2_version_to_text(out, BCH_SB_VERSION_UPGRADE_COMPLETE(sb));
 	prt_newline(out);
diff --git a/fs/bcachefs/super-io.h b/fs/bcachefs/super-io.h
index 90e7b176cdd0..25b4bfe7a25e 100644
--- a/fs/bcachefs/super-io.h
+++ b/fs/bcachefs/super-io.h
@@ -18,8 +18,20 @@ static inline bool bch2_version_compatible(u16 version)
 		version >= bcachefs_metadata_version_min;
 }
 
-void bch2_version_to_text(struct printbuf *, unsigned);
-unsigned bch2_latest_compatible_version(unsigned);
+void bch2_version_to_text(struct printbuf *, enum bcachefs_metadata_version);
+enum bcachefs_metadata_version bch2_latest_compatible_version(enum bcachefs_metadata_version);
+
+void bch2_set_version_incompat(struct bch_fs *, enum bcachefs_metadata_version);
+
+static inline bool bch2_request_incompat_feature(struct bch_fs *c,
+						 enum bcachefs_metadata_version version)
+{
+	if (version < c->sb.version_incompat_allowed)
+		return false;
+	if (version > c->sb.version_incompat)
+		bch2_set_version_incompat(c, version);
+	return true;
+}
 
 static inline size_t bch2_sb_field_bytes(struct bch_sb_field *f)
 {
@@ -94,7 +106,7 @@ static inline void bch2_check_set_feature(struct bch_fs *c, unsigned feat)
 }
 
 bool bch2_check_version_downgrade(struct bch_fs *);
-void bch2_sb_upgrade(struct bch_fs *, unsigned);
+void bch2_sb_upgrade(struct bch_fs *, unsigned, bool);
 
 void __bch2_sb_field_to_text(struct printbuf *, struct bch_sb *,
 			     struct bch_sb_field *);
-- 
2.45.2


