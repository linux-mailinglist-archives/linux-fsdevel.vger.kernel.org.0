Return-Path: <linux-fsdevel+bounces-18279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F19638B68FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13156B22406
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02C4134BE;
	Tue, 30 Apr 2024 03:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wpt+VP86"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263BD111A2;
	Tue, 30 Apr 2024 03:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448214; cv=none; b=CLo5bJxOZFdIxvrgZ10W63ZHInRC/wAabgh1MtVELe2dlkcQ1RMXS3dDQyi79F+mzSoUq8a+LwIjGuDcKnJj3csmVordhTVFKdv/FJLdQAd4DavKdn9RqaQ9QplCHhSvxnDBjXsnT2DQW6GYhzPfKAvTSgvkT2Z0xctlQyKoDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448214; c=relaxed/simple;
	bh=l3cbf3vxDJ5u8rmBnahydFw9HCWhzoO6CZF966w06SU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BSC2slI/oak7GZQoANxCliiqMhzPfVWcJYtdC2MY1Id8ESMeCPRRQyzqMdoZl6l19eomxB0v5l06bGnSmZX5myFSi9CU2Oz/CFPmLsyhJbjQzwx8mNrEUInXuFdRz6RF715w9/r6F7PhcEM5gQqYQBUdjS3OySbhhpVCx/dR1As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wpt+VP86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA95C4AF18;
	Tue, 30 Apr 2024 03:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448213;
	bh=l3cbf3vxDJ5u8rmBnahydFw9HCWhzoO6CZF966w06SU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Wpt+VP86288uossigifZfnSiSmaqi8BoWqs6GZG0CgWIQ2l+Zb6szYf1EImaxwLM8
	 ZBrjvz8DkwL7l9tYmnFxMXgQyrEjfJtP4Le8rungqfaVzCOXKqhDBaf1snBiyJmjiw
	 O297sdIUgnL8OtvNIvPvw8e4583eqHsOvZXsDGk0pBZzsuprHUu6NhJ9wvOSYRn3aZ
	 YsLVTaqezHI+xg7HNh5YwvCymXtv5lslhilcYz3BjIR+CMQ2RefU6RQTap47fCXBkS
	 /wRrpAAZ02hkiU8rn4kZvilM5QXCURPfMZuUvom2u0842+jrLPE4GQWESusb9wgxJO
	 +MhcTgJEhQF5Q==
Date: Mon, 29 Apr 2024 20:36:53 -0700
Subject: [PATCH 23/38] xfs_db: dump merkle tree data
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683465.960383.2818025551403654518.stgit@frogsfrogsfrogs>
In-Reply-To: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
References: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
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

Teach the debugger to dump the specific fields in the fsverity xattr
blocks.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 db/attr.c      |  189 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 db/attrshort.c |   50 +++++++++++++++
 2 files changed, 237 insertions(+), 2 deletions(-)


diff --git a/db/attr.c b/db/attr.c
index 8e2bce7b7e02..7d8bdeb53032 100644
--- a/db/attr.c
+++ b/db/attr.c
@@ -35,6 +35,12 @@ static int	attr3_remote_data_count(void *obj, int startoff);
 
 static int	attr_leaf_value_pptr_count(void *obj, int startoff);
 
+static bool	is_verity_file(void);
+static int	attr3_remote_merkledata_count(void *obj, int startoff);
+static int	attr_leaf_name_local_merkledata_count(void *obj, int startoff);
+static int	attr_leaf_name_local_merkleoff_count(void *obj, int startoff);
+static int	attr_leaf_name_remote_merkleoff_count(void *obj, int startoff);
+
 const field_t	attr_hfld[] = {
 	{ "", FLDT_ATTR, OI(0), C1, 0, TYP_NONE },
 	{ NULL }
@@ -87,6 +93,9 @@ const field_t	attr_leaf_entry_flds[] = {
 	{ "parent", FLDT_UINT1,
 	  OI(LEOFF(flags) + bitsz(uint8_t) - XFS_ATTR_PARENT_BIT - 1), C1, 0,
 	  TYP_NONE },
+	{ "verity", FLDT_UINT1,
+	  OI(LEOFF(flags) + bitsz(uint8_t) - XFS_ATTR_VERITY_BIT - 1), C1, 0,
+	  TYP_NONE },
 	{ "pad2", FLDT_UINT8X, OI(LEOFF(pad2)), C1, FLD_SKIPALL, TYP_NONE },
 	{ NULL }
 };
@@ -113,6 +122,10 @@ const field_t	attr_leaf_map_flds[] = {
 
 #define	LNOFF(f)	bitize(offsetof(xfs_attr_leaf_name_local_t, f))
 #define	LVOFF(f)	bitize(offsetof(xfs_attr_leaf_name_remote_t, f))
+#define	MKLOFF(f)	bitize(offsetof(xfs_attr_leaf_name_local_t, nameval) + \
+			       offsetof(struct xfs_merkle_key, f))
+#define	MKROFF(f)	bitize(offsetof(xfs_attr_leaf_name_remote_t, name) + \
+			       offsetof(struct xfs_merkle_key, f))
 const field_t	attr_leaf_name_flds[] = {
 	{ "valuelen", FLDT_UINT16D, OI(LNOFF(valuelen)),
 	  attr_leaf_name_local_count, FLD_COUNT, TYP_NONE },
@@ -122,8 +135,12 @@ const field_t	attr_leaf_name_flds[] = {
 	  attr_leaf_name_local_name_count, FLD_COUNT, TYP_NONE },
 	{ "parent_dir", FLDT_PARENT_REC, attr_leaf_name_local_value_offset,
 	  attr_leaf_value_pptr_count, FLD_COUNT | FLD_OFFSET, TYP_NONE },
+	{ "merkle_pos", FLDT_UINT64X, OI(MKLOFF(mk_pos)),
+	  attr_leaf_name_local_merkleoff_count, FLD_COUNT, TYP_NONE },
 	{ "value", FLDT_CHARNS, attr_leaf_name_local_value_offset,
 	  attr_leaf_name_local_value_count, FLD_COUNT|FLD_OFFSET, TYP_NONE },
+	{ "merkle_data", FLDT_HEXSTRING, attr_leaf_name_local_value_offset,
+	  attr_leaf_name_local_merkledata_count, FLD_COUNT|FLD_OFFSET, TYP_NONE },
 	{ "valueblk", FLDT_UINT32X, OI(LVOFF(valueblk)),
 	  attr_leaf_name_remote_count, FLD_COUNT, TYP_NONE },
 	{ "valuelen", FLDT_UINT32D, OI(LVOFF(valuelen)),
@@ -132,6 +149,8 @@ const field_t	attr_leaf_name_flds[] = {
 	  attr_leaf_name_remote_count, FLD_COUNT, TYP_NONE },
 	{ "name", FLDT_CHARNS, OI(LVOFF(name)),
 	  attr_leaf_name_remote_name_count, FLD_COUNT, TYP_NONE },
+	{ "merkle_pos", FLDT_UINT64X, OI(MKROFF(mk_pos)),
+	  attr_leaf_name_remote_merkleoff_count, FLD_COUNT, TYP_NONE },
 	{ NULL }
 };
 
@@ -265,7 +284,19 @@ __attr_leaf_name_local_count(
 	struct xfs_attr_leaf_entry      *e,
 	int				i)
 {
-	return (e->flags & XFS_ATTR_LOCAL) != 0;
+	struct xfs_attr_leaf_name_local	*l;
+
+	if (!(e->flags & XFS_ATTR_LOCAL))
+		return 0;
+
+	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) == XFS_ATTR_VERITY) {
+		l = xfs_attr3_leaf_name_local(leaf, i);
+
+		if (l->namelen == sizeof(struct xfs_merkle_key))
+			return 0;
+	}
+
+	return 1;
 }
 
 static int
@@ -289,6 +320,10 @@ __attr_leaf_name_local_name_count(
 		return 0;
 
 	l = xfs_attr3_leaf_name_local(leaf, i);
+	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) == XFS_ATTR_VERITY &&
+	    l->namelen == sizeof(struct xfs_merkle_key))
+		return 0;
+
 	return l->namelen;
 }
 
@@ -311,7 +346,8 @@ __attr_leaf_name_local_value_count(
 
 	if (!(e->flags & XFS_ATTR_LOCAL))
 		return 0;
-	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) == XFS_ATTR_PARENT)
+	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) == XFS_ATTR_PARENT ||
+	    (e->flags & XFS_ATTR_NSP_ONDISK_MASK) == XFS_ATTR_VERITY)
 		return 0;
 
 	l = xfs_attr3_leaf_name_local(leaf, i);
@@ -382,6 +418,10 @@ __attr_leaf_name_remote_name_count(
 		return 0;
 
 	r = xfs_attr3_leaf_name_remote(leaf, i);
+	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) == XFS_ATTR_VERITY &&
+	    r->namelen == sizeof(struct xfs_merkle_key))
+		return 0;
+
 	return r->namelen;
 }
 
@@ -542,6 +582,141 @@ attr_leaf_value_pptr_count(
 	return attr_leaf_entry_walk(obj, startoff, __leaf_pptr_count);
 }
 
+/*
+ * Is the current file a verity file?  This is a kludge for handling merkle
+ * tree blocks stored in a XFS_ATTR_VERITY attr's remote value block because we
+ * can't access the leaf entry to find out if the attr is actually a verity
+ * attr.
+ */
+static bool
+is_verity_file(void)
+{
+	struct xfs_inode	*ip;
+	bool			ret = false;
+
+	if (iocur_top->ino == 0 || iocur_top->ino == NULLFSINO)
+		return false;
+
+	if (!xfs_has_verity(mp))
+		return false;
+
+	ret = -libxfs_iget(mp, NULL, iocur_top->ino, 0, &ip);
+	if (ret)
+		return false;
+
+	if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
+		ret = true;
+
+	libxfs_irele(ip);
+	return ret;
+}
+
+static int
+attr3_remote_merkledata_count(
+	void				*obj,
+	int				startoff)
+{
+	struct xfs_attr3_leaf_hdr	*lhdr = obj;
+	struct xfs_attr3_rmt_hdr	*rhdr = obj;
+
+	if (rhdr->rm_magic == cpu_to_be32(XFS_ATTR3_RMT_MAGIC) ||
+	    lhdr->info.hdr.magic == cpu_to_be16(XFS_DA_NODE_MAGIC) ||
+	    lhdr->info.hdr.magic == cpu_to_be16(XFS_DA3_NODE_MAGIC) ||
+	    lhdr->info.hdr.magic == cpu_to_be16(XFS_ATTR_LEAF_MAGIC) ||
+	    lhdr->info.hdr.magic == cpu_to_be16(XFS_ATTR3_LEAF_MAGIC))
+		return 0;
+
+	if (startoff != 0 || !is_verity_file())
+		return 0;
+
+	return mp->m_sb.sb_blocksize;
+}
+
+static int
+__leaf_local_merkledata_count(
+	struct xfs_attr_leafblock	*leaf,
+	struct xfs_attr_leaf_entry      *e,
+	int				i)
+{
+	struct xfs_attr_leaf_name_local	*l;
+
+	if (!(e->flags & XFS_ATTR_LOCAL))
+		return 0;
+	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) == XFS_ATTR_PARENT)
+		return 0;
+
+	l = xfs_attr3_leaf_name_local(leaf, i);
+	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) == XFS_ATTR_VERITY &&
+	    l->namelen == sizeof(struct xfs_merkle_key))
+		return be16_to_cpu(l->valuelen);
+
+	return 0;
+}
+
+static int
+attr_leaf_name_local_merkledata_count(
+	void				*obj,
+	int				startoff)
+{
+	return attr_leaf_entry_walk(obj, startoff, __leaf_local_merkledata_count);
+}
+
+static int
+__leaf_local_merkleoff_count(
+	struct xfs_attr_leafblock	*leaf,
+	struct xfs_attr_leaf_entry      *e,
+	int				i)
+{
+	struct xfs_attr_leaf_name_local	*l;
+
+	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) != XFS_ATTR_VERITY)
+		return 0;
+	if (!(e->flags & XFS_ATTR_LOCAL))
+		return 0;
+
+	l = xfs_attr3_leaf_name_local(leaf, i);
+	if (l->namelen != sizeof(struct xfs_merkle_key))
+		return 0;
+
+	return 1;
+}
+
+static int
+attr_leaf_name_local_merkleoff_count(
+	void				*obj,
+	int				startoff)
+{
+	return attr_leaf_entry_walk(obj, startoff, __leaf_local_merkleoff_count);
+}
+
+static int
+__leaf_remote_merkleoff_count(
+	struct xfs_attr_leafblock	*leaf,
+	struct xfs_attr_leaf_entry      *e,
+	int				i)
+{
+	struct xfs_attr_leaf_name_remote	*r;
+
+	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) != XFS_ATTR_VERITY)
+		return 0;
+	if (e->flags & XFS_ATTR_LOCAL)
+		return 0;
+
+	r = xfs_attr3_leaf_name_remote(leaf, i);
+	if (r->namelen != sizeof(struct xfs_merkle_key))
+		return 0;
+
+	return 1;
+}
+
+static int
+attr_leaf_name_remote_merkleoff_count(
+	void				*obj,
+	int				startoff)
+{
+	return attr_leaf_entry_walk(obj, startoff, __leaf_remote_merkleoff_count);
+}
+
 int
 attr_size(
 	void	*obj,
@@ -570,6 +745,8 @@ const field_t	attr3_flds[] = {
 	  FLD_COUNT, TYP_NONE },
 	{ "data", FLDT_CHARNS, OI(bitize(sizeof(struct xfs_attr3_rmt_hdr))),
 	  attr3_remote_data_count, FLD_COUNT, TYP_NONE },
+	{ "merkle_data", FLDT_HEXSTRING, OI(0),
+	  attr3_remote_merkledata_count, FLD_COUNT, TYP_NONE },
 	{ "entries", FLDT_ATTR_LEAF_ENTRY, OI(L3OFF(entries)),
 	  attr3_leaf_entries_count, FLD_ARRAY|FLD_COUNT, TYP_NONE },
 	{ "btree", FLDT_ATTR_NODE_ENTRY, OI(N3OFF(__btree)),
@@ -652,6 +829,9 @@ xfs_attr3_set_crc(
 		xfs_buf_update_cksum(bp, XFS_ATTR3_RMT_CRC_OFF);
 		return;
 	default:
+		if (is_verity_file())
+			return;
+
 		dbprintf(_("Unknown attribute buffer type!\n"));
 		break;
 	}
@@ -687,6 +867,11 @@ xfs_attr3_db_read_verify(
 		bp->b_ops = &xfs_attr3_rmt_buf_ops;
 		break;
 	default:
+		if (is_verity_file()) {
+			bp->b_ops = &xfs_attr3_rmtverity_buf_ops;
+			goto verify;
+		}
+
 		dbprintf(_("Unknown attribute buffer type!\n"));
 		xfs_buf_ioerror(bp, -EFSCORRUPTED);
 		return;
diff --git a/db/attrshort.c b/db/attrshort.c
index 7e5c94ca533d..1d26a358335f 100644
--- a/db/attrshort.c
+++ b/db/attrshort.c
@@ -20,6 +20,9 @@ static int	attr_shortform_list_offset(void *obj, int startoff, int idx);
 
 static int	attr_sf_entry_pptr_count(void *obj, int startoff);
 
+static int	attr_sf_entry_merkleoff_count(void *obj, int startoff);
+static int	attr_sf_entry_merkledata_count(void *obj, int startoff);
+
 const field_t	attr_shortform_flds[] = {
 	{ "hdr", FLDT_ATTR_SF_HDR, OI(0), C1, 0, TYP_NONE },
 	{ "list", FLDT_ATTR_SF_ENTRY, attr_shortform_list_offset,
@@ -35,6 +38,8 @@ const field_t	attr_sf_hdr_flds[] = {
 };
 
 #define	EOFF(f)	bitize(offsetof(struct xfs_attr_sf_entry, f))
+#define	MKOFF(f) bitize(offsetof(struct xfs_attr_sf_entry, nameval) + \
+			offsetof(struct xfs_merkle_key, f))
 const field_t	attr_sf_entry_flds[] = {
 	{ "namelen", FLDT_UINT8D, OI(EOFF(namelen)), C1, 0, TYP_NONE },
 	{ "valuelen", FLDT_UINT8D, OI(EOFF(valuelen)), C1, 0, TYP_NONE },
@@ -48,10 +53,17 @@ const field_t	attr_sf_entry_flds[] = {
 	{ "parent", FLDT_UINT1,
 	  OI(EOFF(flags) + bitsz(uint8_t) - XFS_ATTR_PARENT_BIT - 1), C1, 0,
 	  TYP_NONE },
+	{ "verity", FLDT_UINT1,
+	  OI(EOFF(flags) + bitsz(uint8_t) - XFS_ATTR_VERITY_BIT - 1), C1, 0,
+	  TYP_NONE },
 	{ "name", FLDT_CHARNS, OI(EOFF(nameval)), attr_sf_entry_name_count,
 	  FLD_COUNT, TYP_NONE },
 	{ "parent_dir", FLDT_PARENT_REC, attr_sf_entry_value_offset,
 	  attr_sf_entry_pptr_count, FLD_COUNT | FLD_OFFSET, TYP_NONE },
+	{ "merkle_pos", FLDT_UINT32X, OI(MKOFF(mk_pos)),
+	  attr_sf_entry_merkleoff_count, FLD_COUNT, TYP_NONE },
+	{ "merkle_data", FLDT_HEXSTRING, attr_sf_entry_value_offset,
+	  attr_sf_entry_merkledata_count, FLD_COUNT | FLD_OFFSET, TYP_NONE },
 	{ "value", FLDT_CHARNS, attr_sf_entry_value_offset,
 	  attr_sf_entry_value_count, FLD_COUNT|FLD_OFFSET, TYP_NONE },
 	{ NULL }
@@ -100,6 +112,10 @@ attr_sf_entry_value_count(
 	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) == XFS_ATTR_PARENT)
 		return 0;
 
+	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) == XFS_ATTR_VERITY &&
+	    e->namelen == sizeof(struct xfs_merkle_key))
+		return 0;
+
 	return e->valuelen;
 }
 
@@ -183,3 +199,37 @@ attr_sf_entry_pptr_count(
 
 	return 1;
 }
+
+static int
+attr_sf_entry_merkleoff_count(
+	void				*obj,
+	int				startoff)
+{
+	struct xfs_attr_sf_entry	*e;
+
+	ASSERT(bitoffs(startoff) == 0);
+	e = (struct xfs_attr_sf_entry *)((char *)obj + byteize(startoff));
+	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) != XFS_ATTR_VERITY)
+		return 0;
+
+	if (e->namelen != sizeof(struct xfs_merkle_key))
+		return 0;
+
+	return 1;
+}
+
+static int
+attr_sf_entry_merkledata_count(
+	void				*obj,
+	int				startoff)
+{
+	struct xfs_attr_sf_entry	*e;
+
+	ASSERT(bitoffs(startoff) == 0);
+	e = (struct xfs_attr_sf_entry *)((char *)obj + byteize(startoff));
+	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) == XFS_ATTR_VERITY &&
+	    e->namelen == sizeof(struct xfs_merkle_key))
+		return e->valuelen;
+
+	return 0;
+}


