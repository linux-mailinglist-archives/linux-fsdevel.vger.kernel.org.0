Return-Path: <linux-fsdevel+bounces-14635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D9D87DEE2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DDB1F20FE5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5421CA96;
	Sun, 17 Mar 2024 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1QwWMLr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7BA1C695;
	Sun, 17 Mar 2024 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693511; cv=none; b=klBTwb4cuLLJIcwJ4NKtoWr2CM0fvvZ6+s9INhJnnKFTFTobG7GKR5K+VyDjtpQtIHiyY4QXyMR0qCFBuFWPX8g60dli4Ordxh1y90jlpWUJQQI5sexkZ5n1b8T16b0uaewQ/1ff30gqQ5snhErSGdQQ5k+uJLsZ4tvhFK8Qy/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693511; c=relaxed/simple;
	bh=SKNjAW7IOXroQvyBJmA0riw3nQ2K4jFMyqXxyHhe2XM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJWB7WrqYTxbz3Bp+RfYKkH43Bkr4nRRUSTmi3KiYpmZrK5S8Xn2ayT4+04+Pi/D2Yw5VRcCVJJqu6u8d4+1m3XhRZKJ+X9psPlJaO/CVALIFhUjgKe3N0hM2vvoxV2W/53HbVqutFJXcWqgHzzfi5ZFWm9pf7V+USEgO+kusoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1QwWMLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDACC433C7;
	Sun, 17 Mar 2024 16:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693511;
	bh=SKNjAW7IOXroQvyBJmA0riw3nQ2K4jFMyqXxyHhe2XM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=J1QwWMLrdTlUHeNEhn0x8jponuJNspk1v04tWXmTA9rnwXCB4bL6SUUrS7e8nAssh
	 DkIb2/51Hrn6b31FRptSOaAfokf9lcfvxCclMMd68N8sES8lr47pR6O3JTooBGGX/V
	 hjoPIM2i+gu3PxQhkaJg1uKHdzPn2+P/Au5JEktGTsaj8KM30T1H0oSEnTkmgstVkz
	 tE1aHqPyoSPuA8G3ojreYSE504WZKq79PDilFOhZw2UBd2bru5YqcWMMPlKh8Ky9P1
	 CfOdw5JBHHp5TZX5fkAg9S+Ag05XSUVY3ZoK/Dyj1Y5Vu7dSSgz41xyo3eXE9kPsj6
	 f3w7pfn2z97ZA==
Date: Sun, 17 Mar 2024 09:38:31 -0700
Subject: [PATCH 18/20] xfs_db: dump merkle tree data
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171069247924.2685643.16135242621398561444.stgit@frogsfrogsfrogs>
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

Teach the debugger to dump the specific fields in the fsverity xattr
blocks.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 db/attr.c      |   94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 db/attrshort.c |   22 +++++++++++++
 2 files changed, 115 insertions(+), 1 deletion(-)


diff --git a/db/attr.c b/db/attr.c
index ba722e14..d00bf921 100644
--- a/db/attr.c
+++ b/db/attr.c
@@ -33,6 +33,9 @@ static int	attr_remote_data_count(void *obj, int startoff);
 static int	attr3_remote_hdr_count(void *obj, int startoff);
 static int	attr3_remote_data_count(void *obj, int startoff);
 
+static int	attr_leaf_name_local_merkle_count(void *obj, int startoff);
+static int	attr_leaf_name_remote_merkle_count(void *obj, int startoff);
+
 const field_t	attr_hfld[] = {
 	{ "", FLDT_ATTR, OI(0), C1, 0, TYP_NONE },
 	{ NULL }
@@ -82,6 +85,9 @@ const field_t	attr_leaf_entry_flds[] = {
 	{ "local", FLDT_UINT1,
 	  OI(LEOFF(flags) + bitsz(uint8_t) - XFS_ATTR_LOCAL_BIT - 1), C1, 0,
 	  TYP_NONE },
+	{ "verity", FLDT_UINT1,
+	  OI(LEOFF(flags) + bitsz(uint8_t) - XFS_ATTR_VERITY_BIT - 1), C1, 0,
+	  TYP_NONE },
 	{ "pad2", FLDT_UINT8X, OI(LEOFF(pad2)), C1, FLD_SKIPALL, TYP_NONE },
 	{ NULL }
 };
@@ -108,6 +114,10 @@ const field_t	attr_leaf_map_flds[] = {
 
 #define	LNOFF(f)	bitize(offsetof(xfs_attr_leaf_name_local_t, f))
 #define	LVOFF(f)	bitize(offsetof(xfs_attr_leaf_name_remote_t, f))
+#define	MKLOFF(f)	bitize(offsetof(xfs_attr_leaf_name_local_t, nameval) + \
+			       offsetof(struct xfs_verity_merkle_key, f))
+#define	MKROFF(f)	bitize(offsetof(xfs_attr_leaf_name_remote_t, name) + \
+			       offsetof(struct xfs_verity_merkle_key, f))
 const field_t	attr_leaf_name_flds[] = {
 	{ "valuelen", FLDT_UINT16D, OI(LNOFF(valuelen)),
 	  attr_leaf_name_local_count, FLD_COUNT, TYP_NONE },
@@ -115,6 +125,8 @@ const field_t	attr_leaf_name_flds[] = {
 	  attr_leaf_name_local_count, FLD_COUNT, TYP_NONE },
 	{ "name", FLDT_CHARNS, OI(LNOFF(nameval)),
 	  attr_leaf_name_local_name_count, FLD_COUNT, TYP_NONE },
+	{ "merkle_off", FLDT_UINT64X, OI(MKLOFF(vi_merkleoff)),
+	  attr_leaf_name_local_merkle_count, FLD_COUNT, TYP_NONE },
 	{ "value", FLDT_CHARNS, attr_leaf_name_local_value_offset,
 	  attr_leaf_name_local_value_count, FLD_COUNT|FLD_OFFSET, TYP_NONE },
 	{ "valueblk", FLDT_UINT32X, OI(LVOFF(valueblk)),
@@ -125,6 +137,8 @@ const field_t	attr_leaf_name_flds[] = {
 	  attr_leaf_name_remote_count, FLD_COUNT, TYP_NONE },
 	{ "name", FLDT_CHARNS, OI(LVOFF(name)),
 	  attr_leaf_name_remote_name_count, FLD_COUNT, TYP_NONE },
+	{ "merkle_off", FLDT_UINT64X, OI(MKROFF(vi_merkleoff)),
+	  attr_leaf_name_remote_merkle_count, FLD_COUNT, TYP_NONE },
 	{ NULL }
 };
 
@@ -258,7 +272,19 @@ __attr_leaf_name_local_count(
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
+		if (l->namelen == sizeof(struct xfs_verity_merkle_key))
+			return 0;
+	}
+
+	return 1;
 }
 
 static int
@@ -270,6 +296,64 @@ attr_leaf_name_local_count(
 				    __attr_leaf_name_local_count);
 }
 
+static int
+__attr_leaf_name_local_merkle_count(
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
+	if (l->namelen != sizeof(struct xfs_verity_merkle_key))
+		return 0;
+
+	return 1;
+}
+
+static int
+attr_leaf_name_local_merkle_count(
+	void				*obj,
+	int				startoff)
+{
+	return attr_leaf_entry_walk(obj, startoff,
+			__attr_leaf_name_local_merkle_count);
+}
+
+static int
+__attr_leaf_name_remote_merkle_count(
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
+	if (r->namelen != sizeof(struct xfs_verity_merkle_key))
+		return 0;
+
+	return 1;
+}
+
+static int
+attr_leaf_name_remote_merkle_count(
+	void				*obj,
+	int				startoff)
+{
+	return attr_leaf_entry_walk(obj, startoff,
+			__attr_leaf_name_remote_merkle_count);
+}
+
 static int
 __attr_leaf_name_local_name_count(
 	struct xfs_attr_leafblock	*leaf,
@@ -282,6 +366,10 @@ __attr_leaf_name_local_name_count(
 		return 0;
 
 	l = xfs_attr3_leaf_name_local(leaf, i);
+	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) == XFS_ATTR_VERITY &&
+	    l->namelen == sizeof(struct xfs_verity_merkle_key))
+		return 0;
+
 	return l->namelen;
 }
 
@@ -373,6 +461,10 @@ __attr_leaf_name_remote_name_count(
 		return 0;
 
 	r = xfs_attr3_leaf_name_remote(leaf, i);
+	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) == XFS_ATTR_VERITY &&
+	    r->namelen == sizeof(struct xfs_verity_merkle_key))
+		return 0;
+
 	return r->namelen;
 }
 
diff --git a/db/attrshort.c b/db/attrshort.c
index 7c386d46..4a850016 100644
--- a/db/attrshort.c
+++ b/db/attrshort.c
@@ -13,6 +13,7 @@
 #include "attrshort.h"
 
 static int	attr_sf_entry_name_count(void *obj, int startoff);
+static int	attr_sf_entry_merkle_count(void *obj, int startoff);
 static int	attr_sf_entry_value_count(void *obj, int startoff);
 static int	attr_sf_entry_value_offset(void *obj, int startoff, int idx);
 static int	attr_shortform_list_count(void *obj, int startoff);
@@ -33,6 +34,8 @@ const field_t	attr_sf_hdr_flds[] = {
 };
 
 #define	EOFF(f)	bitize(offsetof(struct xfs_attr_sf_entry, f))
+#define	MKOFF(f) bitize(offsetof(struct xfs_attr_sf_entry, nameval) + \
+			offsetof(struct xfs_verity_merkle_key, f))
 const field_t	attr_sf_entry_flds[] = {
 	{ "namelen", FLDT_UINT8D, OI(EOFF(namelen)), C1, 0, TYP_NONE },
 	{ "valuelen", FLDT_UINT8D, OI(EOFF(valuelen)), C1, 0, TYP_NONE },
@@ -43,13 +46,32 @@ const field_t	attr_sf_entry_flds[] = {
 	{ "secure", FLDT_UINT1,
 	  OI(EOFF(flags) + bitsz(uint8_t) - XFS_ATTR_SECURE_BIT - 1), C1, 0,
 	  TYP_NONE },
+	{ "verity", FLDT_UINT1,
+	  OI(EOFF(flags) + bitsz(uint8_t) - XFS_ATTR_VERITY_BIT - 1), C1, 0,
+	  TYP_NONE },
 	{ "name", FLDT_CHARNS, OI(EOFF(nameval)), attr_sf_entry_name_count,
 	  FLD_COUNT, TYP_NONE },
+	{ "merkle_off", FLDT_UINT32X, OI(MKOFF(vi_merkleoff)),
+	  attr_sf_entry_merkle_count, FLD_COUNT, TYP_NONE },
 	{ "value", FLDT_CHARNS, attr_sf_entry_value_offset,
 	  attr_sf_entry_value_count, FLD_COUNT|FLD_OFFSET, TYP_NONE },
 	{ NULL }
 };
 
+static int
+attr_sf_entry_merkle_count(
+	void				*obj,
+	int				startoff)
+{
+	struct xfs_attr_sf_entry	*e;
+
+	ASSERT(bitoffs(startoff) == 0);
+	e = (struct xfs_attr_sf_entry *)((char *)obj + byteize(startoff));
+	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) == XFS_ATTR_VERITY)
+		return 1;
+	return 0;
+}
+
 static int
 attr_sf_entry_name_count(
 	void				*obj,


