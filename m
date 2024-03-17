Return-Path: <linux-fsdevel+bounces-14620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF38C87DEBD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE2D280946
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F611CAAE;
	Sun, 17 Mar 2024 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbIzSL53"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952E91B949;
	Sun, 17 Mar 2024 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693277; cv=none; b=PvDitcqTM9oVc2Ce0qtQpRZEhUwjldMcmh2h4/tImDCsbYcRGm9Y2qmwhp5Mh3jQiQfI4AspHtpidokW+I8bW/ckLekQk0LvVyqOgH16RPL968nNFEMRjaTnz/yXJN7AGLg4xhbvEmaZ2snW4FIiITsjjfTBipHVnuflLG9MPRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693277; c=relaxed/simple;
	bh=qz+FGJ6RLkUwKwK0DKJWnw4RO5PtzLDwaxpfHG3YJdo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8IbALPj5OLIF+nwK00/ykRghkbNwfWuFHGKsd2rNSCBIOgZaw7TmNraQeY79ua3X/idREqpEcWI2a0dp5Z5iQy9+KGZgg8oqU/3EUNiz56uCr/YjEOuFH6gqhoHLm1MBjZOpyx7XxIvb24iKxOcYN3MbEshiE/SuffscvLbsmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbIzSL53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C26AC433F1;
	Sun, 17 Mar 2024 16:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693277;
	bh=qz+FGJ6RLkUwKwK0DKJWnw4RO5PtzLDwaxpfHG3YJdo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JbIzSL53zxR2HrcD0zt4oXSZdedBQERHewi+OIq3luKm+/eHo3F36qbLQ6NSAi+Ne
	 jkDHge8M31PscpVdjyqgNEWFZBiyryjAF4vt59gDiJngOE1kviFALWktixj110oK9+
	 KnBPR5OG1G06rLuBxqEso7wSipQQTYCoBqVIHf7+g1YLI+GAArHSX6Cd8e7zLqw1wa
	 zMEriX9MKfbgvsWtrhblGk1kJPiE/d8gJA/m5XcEMqVi54vjGMnypGFjbv043LiRrx
	 erSqFYLVNgGvqK4iaQ17RjP7BmJcaeas23rMcqjKIL8S8Ksaihm6UuDSNM9+enxjh9
	 ogJXxpxE1dbrA==
Date: Sun, 17 Mar 2024 09:34:36 -0700
Subject: [PATCH 03/20] xfsprogs: Add xfs_verify_pptr
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: Allison Henderson <allison.henderson@oracle.com>,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171069247716.2685643.14245994906424011556.stgit@frogsfrogsfrogs>
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

From: Allison Henderson <allison.henderson@oracle.com>

Source kernel commit: 27e62618672464a8c011ee180878c711a6faed73

Attribute names of parent pointers are not strings.  So we need to modify
attr_namecheck to verify parent pointer records when the XFS_ATTR_PARENT flag is
set.

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 libxfs/xfs_attr.c      |   47 ++++++++++++++++++++++++++++++++++++++++++++---
 libxfs/xfs_attr.h      |    3 ++-
 libxfs/xfs_da_format.h |    8 ++++++++
 repair/attr_repair.c   |   19 ++++++++++++-------
 4 files changed, 66 insertions(+), 11 deletions(-)


diff --git a/libxfs/xfs_attr.c b/libxfs/xfs_attr.c
index 4818eabb..a9241d18 100644
--- a/libxfs/xfs_attr.c
+++ b/libxfs/xfs_attr.c
@@ -1510,9 +1510,33 @@ xfs_attr_node_get(
 	return error;
 }
 
-/* Returns true if the attribute entry name is valid. */
-bool
-xfs_attr_namecheck(
+/*
+ * Verify parent pointer attribute is valid.
+ * Return true on success or false on failure
+ */
+STATIC bool
+xfs_verify_pptr(
+	struct xfs_mount			*mp,
+	const struct xfs_parent_name_rec	*rec)
+{
+	xfs_ino_t				p_ino;
+	xfs_dir2_dataptr_t			p_diroffset;
+
+	p_ino = be64_to_cpu(rec->p_ino);
+	p_diroffset = be32_to_cpu(rec->p_diroffset);
+
+	if (!xfs_verify_ino(mp, p_ino))
+		return false;
+
+	if (p_diroffset > XFS_DIR2_MAX_DATAPTR)
+		return false;
+
+	return true;
+}
+
+/* Returns true if the string attribute entry name is valid. */
+static bool
+xfs_str_attr_namecheck(
 	const void	*name,
 	size_t		length)
 {
@@ -1527,6 +1551,23 @@ xfs_attr_namecheck(
 	return !memchr(name, 0, length);
 }
 
+/* Returns true if the attribute entry name is valid. */
+bool
+xfs_attr_namecheck(
+	struct xfs_mount	*mp,
+	const void		*name,
+	size_t			length,
+	int			flags)
+{
+	if (flags & XFS_ATTR_PARENT) {
+		if (length != sizeof(struct xfs_parent_name_rec))
+			return false;
+		return xfs_verify_pptr(mp, (struct xfs_parent_name_rec *)name);
+	}
+
+	return xfs_str_attr_namecheck(name, length);
+}
+
 int __init
 xfs_attr_intent_init_cache(void)
 {
diff --git a/libxfs/xfs_attr.h b/libxfs/xfs_attr.h
index 81be9b3e..af92cc57 100644
--- a/libxfs/xfs_attr.h
+++ b/libxfs/xfs_attr.h
@@ -547,7 +547,8 @@ int xfs_attr_get(struct xfs_da_args *args);
 int xfs_attr_set(struct xfs_da_args *args);
 int xfs_attr_set_iter(struct xfs_attr_intent *attr);
 int xfs_attr_remove_iter(struct xfs_attr_intent *attr);
-bool xfs_attr_namecheck(const void *name, size_t length);
+bool xfs_attr_namecheck(struct xfs_mount *mp, const void *name, size_t length,
+			int flags);
 int xfs_attr_calc_size(struct xfs_da_args *args, int *local);
 void xfs_init_attr_trans(struct xfs_da_args *args, struct xfs_trans_res *tres,
 			 unsigned int *total);
diff --git a/libxfs/xfs_da_format.h b/libxfs/xfs_da_format.h
index fa0f46db..e7045b36 100644
--- a/libxfs/xfs_da_format.h
+++ b/libxfs/xfs_da_format.h
@@ -757,6 +757,14 @@ xfs_attr3_leaf_name(xfs_attr_leafblock_t *leafp, int idx)
 	return &((char *)leafp)[be16_to_cpu(entries[idx].nameidx)];
 }
 
+static inline int
+xfs_attr3_leaf_flags(xfs_attr_leafblock_t *leafp, int idx)
+{
+	struct xfs_attr_leaf_entry *entries = xfs_attr3_leaf_entryp(leafp);
+
+	return entries[idx].flags;
+}
+
 static inline xfs_attr_leaf_name_remote_t *
 xfs_attr3_leaf_name_remote(xfs_attr_leafblock_t *leafp, int idx)
 {
diff --git a/repair/attr_repair.c b/repair/attr_repair.c
index f117f9ae..25588b3b 100644
--- a/repair/attr_repair.c
+++ b/repair/attr_repair.c
@@ -292,8 +292,9 @@ process_shortform_attr(
 		}
 
 		/* namecheck checks for null chars in attr names. */
-		if (!libxfs_attr_namecheck(currententry->nameval,
-					   currententry->namelen)) {
+		if (!libxfs_attr_namecheck(mp, currententry->nameval,
+					   currententry->namelen,
+					   currententry->flags)) {
 			do_warn(
 	_("entry contains illegal character in shortform attribute name\n"));
 			junkit = 1;
@@ -469,12 +470,14 @@ process_leaf_attr_local(
 	xfs_dablk_t		da_bno,
 	xfs_ino_t		ino)
 {
-	xfs_attr_leaf_name_local_t *local;
+	xfs_attr_leaf_name_local_t	*local;
+	int				flags;
 
 	local = xfs_attr3_leaf_name_local(leaf, i);
+	flags = xfs_attr3_leaf_flags(leaf, i);
 	if (local->namelen == 0 ||
-	    !libxfs_attr_namecheck(local->nameval,
-				   local->namelen)) {
+	    !libxfs_attr_namecheck(mp, local->nameval,
+				   local->namelen, flags)) {
 		do_warn(
 	_("attribute entry %d in attr block %u, inode %" PRIu64 " has bad name (namelen = %d)\n"),
 			i, da_bno, ino, local->namelen);
@@ -525,12 +528,14 @@ process_leaf_attr_remote(
 {
 	xfs_attr_leaf_name_remote_t *remotep;
 	char*			value;
+	int			flags;
 
 	remotep = xfs_attr3_leaf_name_remote(leaf, i);
+	flags = xfs_attr3_leaf_flags(leaf, i);
 
 	if (remotep->namelen == 0 ||
-	    !libxfs_attr_namecheck(remotep->name,
-				   remotep->namelen) ||
+	    !libxfs_attr_namecheck(mp, remotep->name,
+				   remotep->namelen, flags) ||
 	    be32_to_cpu(entry->hashval) !=
 			libxfs_da_hashname((unsigned char *)&remotep->name[0],
 					   remotep->namelen) ||


