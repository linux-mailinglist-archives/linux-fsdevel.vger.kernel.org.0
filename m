Return-Path: <linux-fsdevel+bounces-14627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E9187DED2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8041C210D8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF2B1B949;
	Sun, 17 Mar 2024 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIss8dZ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312761CF89;
	Sun, 17 Mar 2024 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693387; cv=none; b=S24BbjJvgKcw2+B0DI1NbGK0IIybUcdjRAFAbuX7Xh8yZxVCGI8Z+ToIaoLdEVxdXR78yuSCuQ1gyvmCYHB5ea1+n3qdrFLjB1+WvqDXtvktmjCmXfwr1TC7btJFUBjdtMxAEOYBsMVMfgw6aKyNkBmfoTphQ7b6NbEamYdlbGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693387; c=relaxed/simple;
	bh=/3zIsbCULrlmi+z1U3hHczhCFh/SR3zMtocXoymYOH0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNEI+2rp8lJs2tOMGUkmTPp9bcB5oM0Je3EeauQhjgz81dRsAfAxB3edcwXFm5469052dNjV1sqIRME9oOHzwZWqxtvJtdmTov1v+sew5bETUVXH15zfibzU93mGdwKMzqziCy93/kT7p/uvVzN1EA2fw9sxnPyuGscgosDT+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIss8dZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCE4C433C7;
	Sun, 17 Mar 2024 16:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693386;
	bh=/3zIsbCULrlmi+z1U3hHczhCFh/SR3zMtocXoymYOH0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gIss8dZ+/yEm/hgbIlNiBHu//6U2E/qmyFpsosPy5pNMsmZGyYZ4qywmhmjmYVSnA
	 et7ToJn+So9OAo6koDx1oJWGA7J6gawtWeYU+YVUogcycj2uXPm4V+7PlHSg0ouEtp
	 a64qjUxgkxZHciHMtBXw9+OhHX8P3rSmIFEIQHx2P4dvMcU1HyO8oybFoFxnPKno2i
	 0dNrfkIEoKQxL5keheOKd1ddj3EQlCTFqLsDBTZ2FEEO+c6uu/zQnGd7Xm7caeSH3j
	 rNSb0rDF8+9syjjQQCUNg7x5K2Yz2k86BFUGJ9NbdoCz9aBVCffAUd0yCW/4thc3XI
	 hfG6tSKXoBJ3A==
Date: Sun, 17 Mar 2024 09:36:26 -0700
Subject: [PATCH 10/20] xfs: create separate name hash function for xattrs
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171069247813.2685643.380949365170709573.stgit@frogsfrogsfrogs>
In-Reply-To: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
References: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a new hashing function for extended attribute names.  The next
patch needs this so it can modify the hash strategy for verity xattrs.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 db/hash.c                |    4 ++--
 db/metadump.c            |   26 +++++++++++++++-----------
 libxfs/libxfs_api_defs.h |    1 +
 libxfs/xfs_attr.c        |   16 ++++++++++++++--
 libxfs/xfs_attr.h        |    3 +++
 libxfs/xfs_attr_leaf.c   |    4 ++--
 repair/attr_repair.c     |    9 ++++++---
 7 files changed, 43 insertions(+), 20 deletions(-)


diff --git a/db/hash.c b/db/hash.c
index 05a94f24..df214c16 100644
--- a/db/hash.c
+++ b/db/hash.c
@@ -73,7 +73,7 @@ hash_f(
 		if (use_dir2_hash)
 			hashval = libxfs_dir2_hashname(mp, &xname);
 		else
-			hashval = libxfs_da_hashname(xname.name, xname.len);
+			hashval = libxfs_attr_hashname(0, xname.name, xname.len);
 		dbprintf("0x%x\n", hashval);
 	}
 
@@ -306,7 +306,7 @@ collide_xattrs(
 	unsigned long		i;
 	int			error;
 
-	old_hash = libxfs_da_hashname((uint8_t *)name, namelen);
+	old_hash = libxfs_attr_hashname(0, (uint8_t *)name, namelen);
 
 	if (fd >= 0) {
 		/*
diff --git a/db/metadump.c b/db/metadump.c
index a656ef57..95f58363 100644
--- a/db/metadump.c
+++ b/db/metadump.c
@@ -823,6 +823,7 @@ handle_duplicate_name(xfs_dahash_t hash, size_t name_len, unsigned char *name)
 static inline xfs_dahash_t
 dirattr_hashname(
 	bool		is_dirent,
+	unsigned int	attr_flags,
 	const uint8_t	*name,
 	int		namelen)
 {
@@ -835,12 +836,13 @@ dirattr_hashname(
 		return libxfs_dir2_hashname(mp, &xname);
 	}
 
-	return libxfs_da_hashname(name, namelen);
+	return libxfs_attr_hashname(attr_flags, name, namelen);
 }
 
 static void
 generate_obfuscated_name(
 	xfs_ino_t		ino,
+	unsigned int		attr_flags,
 	int			namelen,
 	unsigned char		*name)
 {
@@ -866,9 +868,9 @@ generate_obfuscated_name(
 
 	/* Obfuscate the name (if possible) */
 
-	hash = dirattr_hashname(ino != 0, name, namelen);
+	hash = dirattr_hashname(ino != 0, attr_flags, name, namelen);
 	obfuscate_name(hash, namelen, name, ino != 0);
-	ASSERT(hash == dirattr_hashname(ino != 0, name, namelen));
+	ASSERT(hash == dirattr_hashname(ino != 0, attr_flags, name, namelen));
 
 	/*
 	 * Make sure the name is not something already seen.  If we
@@ -945,7 +947,7 @@ process_sf_dir(
 		if (metadump.obfuscate)
 			generate_obfuscated_name(
 					 libxfs_dir2_sf_get_ino(mp, sfp, sfep),
-					 namelen, &sfep->name[0]);
+					 0, namelen, &sfep->name[0]);
 
 		sfep = (xfs_dir2_sf_entry_t *)((char *)sfep +
 				libxfs_dir2_sf_entsize(mp, sfp, namelen));
@@ -1071,8 +1073,8 @@ process_sf_attr(
 		}
 
 		if (metadump.obfuscate) {
-			generate_obfuscated_name(0, asfep->namelen,
-						 &asfep->nameval[0]);
+			generate_obfuscated_name(0, asfep->flags,
+					asfep->namelen, &asfep->nameval[0]);
 			memset(&asfep->nameval[asfep->namelen], 'v',
 			       asfep->valuelen);
 		}
@@ -1283,7 +1285,7 @@ process_dir_data_block(
 
 		if (metadump.obfuscate)
 			generate_obfuscated_name(be64_to_cpu(dep->inumber),
-					 dep->namelen, &dep->name[0]);
+					 0, dep->namelen, &dep->name[0]);
 		dir_offset += length;
 		ptr += length;
 		/* Zero the unused space after name, up to the tag */
@@ -1452,8 +1454,9 @@ process_attr_block(
 				break;
 			}
 			if (metadump.obfuscate) {
-				generate_obfuscated_name(0, local->namelen,
-					&local->nameval[0]);
+				generate_obfuscated_name(0, entry->flags,
+						local->namelen,
+						&local->nameval[0]);
 				memset(&local->nameval[local->namelen], 'v',
 					be16_to_cpu(local->valuelen));
 			}
@@ -1475,8 +1478,9 @@ process_attr_block(
 				break;
 			}
 			if (metadump.obfuscate) {
-				generate_obfuscated_name(0, remote->namelen,
-							 &remote->name[0]);
+				generate_obfuscated_name(0, entry->flags,
+						remote->namelen,
+						&remote->name[0]);
 				add_remote_vals(be32_to_cpu(remote->valueblk),
 						be32_to_cpu(remote->valuelen));
 			}
diff --git a/libxfs/libxfs_api_defs.h b/libxfs/libxfs_api_defs.h
index 9d2084e2..ccc92a83 100644
--- a/libxfs/libxfs_api_defs.h
+++ b/libxfs/libxfs_api_defs.h
@@ -44,6 +44,7 @@
 #define xfs_attr_set			libxfs_attr_set
 #define xfs_attr_sf_firstentry		libxfs_attr_sf_firstentry
 #define xfs_attr_shortform_verify	libxfs_attr_shortform_verify
+#define xfs_attr_hashname		libxfs_attr_hashname
 
 #define __xfs_bmap_add_free		__libxfs_bmap_add_free
 #define xfs_bmap_validate_extent	libxfs_bmap_validate_extent
diff --git a/libxfs/xfs_attr.c b/libxfs/xfs_attr.c
index 30cf3688..aca65971 100644
--- a/libxfs/xfs_attr.c
+++ b/libxfs/xfs_attr.c
@@ -234,6 +234,16 @@ xfs_attr_get_ilocked(
 	return xfs_attr_node_get(args);
 }
 
+/* Compute hash for an extended attribute name. */
+xfs_dahash_t
+xfs_attr_hashname(
+	unsigned int		attr_flags,
+	const uint8_t		*name,
+	unsigned int		namelen)
+{
+	return xfs_da_hashname(name, namelen);
+}
+
 /*
  * Retrieve an extended attribute by name, and its value if requested.
  *
@@ -264,7 +274,8 @@ xfs_attr_get(
 
 	args->geo = args->dp->i_mount->m_attr_geo;
 	args->whichfork = XFS_ATTR_FORK;
-	args->hashval = xfs_da_hashname(args->name, args->namelen);
+	args->hashval = xfs_attr_hashname(args->attr_filter, args->name,
+					  args->namelen);
 
 	/* Entirely possible to look up a name which doesn't exist */
 	args->op_flags = XFS_DA_OP_OKNOENT;
@@ -938,7 +949,8 @@ xfs_attr_set(
 
 	args->geo = mp->m_attr_geo;
 	args->whichfork = XFS_ATTR_FORK;
-	args->hashval = xfs_da_hashname(args->name, args->namelen);
+	args->hashval = xfs_attr_hashname(args->attr_filter, args->name,
+					  args->namelen);
 
 	/*
 	 * We have no control over the attribute names that userspace passes us
diff --git a/libxfs/xfs_attr.h b/libxfs/xfs_attr.h
index af92cc57..30cf51f3 100644
--- a/libxfs/xfs_attr.h
+++ b/libxfs/xfs_attr.h
@@ -619,4 +619,7 @@ extern struct kmem_cache *xfs_attr_intent_cache;
 int __init xfs_attr_intent_init_cache(void);
 void xfs_attr_intent_destroy_cache(void);
 
+xfs_dahash_t xfs_attr_hashname(unsigned int attr_flags,
+		const uint8_t *name_string, unsigned int name_length);
+
 #endif	/* __XFS_ATTR_H__ */
diff --git a/libxfs/xfs_attr_leaf.c b/libxfs/xfs_attr_leaf.c
index 663347b1..2459a1e7 100644
--- a/libxfs/xfs_attr_leaf.c
+++ b/libxfs/xfs_attr_leaf.c
@@ -909,8 +909,8 @@ xfs_attr_shortform_to_leaf(
 		nargs.namelen = sfe->namelen;
 		nargs.value = &sfe->nameval[nargs.namelen];
 		nargs.valuelen = sfe->valuelen;
-		nargs.hashval = xfs_da_hashname(sfe->nameval,
-						sfe->namelen);
+		nargs.hashval = xfs_attr_hashname(sfe->flags, sfe->nameval,
+						  sfe->namelen);
 		nargs.attr_filter = sfe->flags & XFS_ATTR_NSP_ONDISK_MASK;
 		error = xfs_attr3_leaf_lookup_int(bp, &nargs); /* set a->index */
 		ASSERT(error == -ENOATTR);
diff --git a/repair/attr_repair.c b/repair/attr_repair.c
index 25588b3b..9c41cb21 100644
--- a/repair/attr_repair.c
+++ b/repair/attr_repair.c
@@ -492,8 +492,10 @@ process_leaf_attr_local(
 	 * ordering anyway in case both the name value and the
 	 * hashvalue were wrong but matched. Unlikely, however.
 	 */
-	if (be32_to_cpu(entry->hashval) != libxfs_da_hashname(
-				&local->nameval[0], local->namelen) ||
+	if (be32_to_cpu(entry->hashval) !=
+			libxfs_attr_hashname(entry->flags,
+					     &local->nameval[0],
+					     local->namelen) ||
 				be32_to_cpu(entry->hashval) < last_hashval) {
 		do_warn(
 	_("bad hashvalue for attribute entry %d in attr block %u, inode %" PRIu64 "\n"),
@@ -537,7 +539,8 @@ process_leaf_attr_remote(
 	    !libxfs_attr_namecheck(mp, remotep->name,
 				   remotep->namelen, flags) ||
 	    be32_to_cpu(entry->hashval) !=
-			libxfs_da_hashname((unsigned char *)&remotep->name[0],
+			libxfs_attr_hashname(entry->flags,
+					   (unsigned char *)&remotep->name[0],
 					   remotep->namelen) ||
 	    be32_to_cpu(entry->hashval) < last_hashval ||
 	    be32_to_cpu(remotep->valueblk) == 0) {


