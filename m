Return-Path: <linux-fsdevel+bounces-77033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGCzGT8JjmkT+wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:09:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2FD12FCEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00E11303C532
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 17:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC16332936C;
	Thu, 12 Feb 2026 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="e4SBdB/u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C4F21C16A;
	Thu, 12 Feb 2026 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770916152; cv=none; b=jFb5Ch6wfXgwMT0YCGVS7foID5PAWjPlmjy7woUmK3/l2LSKmeHP0ldG7uhb0H6jRhYfrMWzUoPLzaUVR94waSaepyCN51rkPglmdA0/mVl8SC+aFrkpx6wfcszhlX+Ybb29nHymeTelqBrk+wF9Hogh4CBc918gT3zABxjmDqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770916152; c=relaxed/simple;
	bh=BHjsxRqdsRs/JrOklu9fNqaQHc5Ur9sxVP+zyHZa4bE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bniOtXYlmzVPPBitRBwejXHABtuorebFVPfQB/Yq0lgidNcV4T/Oad03UVRrg32echq4uPncwsJX/+nzo1cuFyQTYwUJGqD3OxYcsOOa0UuH6ZqSiLz5uFJ8hgwV+rxOdqUG5yCmpHCyZL45WdQ/zGxnzEFrxLYCP1jBYGVdwkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=e4SBdB/u; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id E72D71D18;
	Thu, 12 Feb 2026 17:06:56 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=e4SBdB/u;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 0A4DA1FE6;
	Thu, 12 Feb 2026 17:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1770916140;
	bh=MrUrGr82iWjOI9jnDqprOLg1IsqOpxqbwgtwIaIHUjY=;
	h=From:To:CC:Subject:Date;
	b=e4SBdB/ucZ4KI0HwryKGuvqMZFThtT3FO0x4Ou4gn1Y+mUxiU4dIZKDX/I0xHe6wi
	 59he7vXqafGjxNewqM0WFYfP5MjscE9ObAOVslcFbtaC33Tr9g3043lJVH3QRwU0n/
	 xMFebKSSqE8aa8Te6kyA05NH9IbFjdYRnRiH6hiw=
Received: from localhost.localdomain (172.30.20.174) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 12 Feb 2026 20:08:58 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: add delayed-allocation (delalloc) support
Date: Thu, 12 Feb 2026 18:08:49 +0100
Message-ID: <20260212170849.12455-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[paragon-software.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[paragon-software.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77033-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almaz.alexandrovich@paragon-software.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[paragon-software.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,paragon-software.com:mid,paragon-software.com:dkim,paragon-software.com:email]
X-Rspamd-Queue-Id: 9F2FD12FCEC
X-Rspamd-Action: no action

This patch implements delayed allocation (delalloc) in ntfs3 driver.

It introduces an in-memory delayed-runlist (run_da) and the helpers to
track, reserve and later convert those delayed reservations into real
clusters at writeback time. The change keeps on-disk formats untouched and
focuses on pagecache integration, correctness and safe interaction with
fallocate, truncate, and dio/iomap paths.

Key points:

- add run_da (delay-allocated run tree) and bookkeeping for delayed clusters.

- mark ranges as delalloc (DELALLOC_LCN) instead of immediately allocating.
  Actual allocation performed later (writeback / attr_set_size_ex / explicit
  flush paths).

- direct i/o / iomap paths updated to avoid dio collisions with
  delalloc: dio falls back or forces allocation of delayed blocks before
  proceeding.

- punch/collapse/truncate/fallocate check and cancel delay-alloc reservations.
  Sparse/compressed files handled specially.

- free-space checks updated (ntfs_check_free_space) to account for reserved
  delalloc clusters and MFT record budgeting.

- delayed allocations are committed on last writer (file release) and on
  explicit allocation flush paths.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c   | 333 ++++++++++++++++++++++++++++++++------------
 fs/ntfs3/attrlist.c |   8 +-
 fs/ntfs3/file.c     | 304 +++++++++++++++++++++-------------------
 fs/ntfs3/frecord.c  |  72 +++++++++-
 fs/ntfs3/fsntfs.c   |  53 +++++--
 fs/ntfs3/index.c    |  23 ++-
 fs/ntfs3/inode.c    | 161 ++++++++++++++-------
 fs/ntfs3/ntfs.h     |   3 +
 fs/ntfs3/ntfs_fs.h  |  91 ++++++++++--
 fs/ntfs3/run.c      | 150 ++++++++++++++++++--
 fs/ntfs3/super.c    |  28 +++-
 fs/ntfs3/xattr.c    |   2 +-
 12 files changed, 886 insertions(+), 342 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index aa745fb226f5..6cb9bc5d605c 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -91,7 +91,8 @@ static int attr_load_runs(struct ATTRIB *attr, struct ntfs_inode *ni,
  * run_deallocate_ex - Deallocate clusters.
  */
 static int run_deallocate_ex(struct ntfs_sb_info *sbi, struct runs_tree *run,
-			     CLST vcn, CLST len, CLST *done, bool trim)
+			     CLST vcn, CLST len, CLST *done, bool trim,
+			     struct runs_tree *run_da)
 {
 	int err = 0;
 	CLST vcn_next, vcn0 = vcn, lcn, clen, dn = 0;
@@ -120,6 +121,16 @@ static int run_deallocate_ex(struct ntfs_sb_info *sbi, struct runs_tree *run,
 			if (sbi) {
 				/* mark bitmap range [lcn + clen) as free and trim clusters. */
 				mark_as_free_ex(sbi, lcn, clen, trim);
+
+				if (run_da) {
+					CLST da_len;
+					if (!run_remove_range(run_da, vcn, clen,
+							      &da_len)) {
+						err = -ENOMEM;
+						goto failed;
+					}
+					ntfs_sub_da(sbi, da_len);
+				}
 			}
 			dn += clen;
 		}
@@ -147,9 +158,10 @@ static int run_deallocate_ex(struct ntfs_sb_info *sbi, struct runs_tree *run,
  * attr_allocate_clusters - Find free space, mark it as used and store in @run.
  */
 int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
-			   CLST vcn, CLST lcn, CLST len, CLST *pre_alloc,
-			   enum ALLOCATE_OPT opt, CLST *alen, const size_t fr,
-			   CLST *new_lcn, CLST *new_len)
+			   struct runs_tree *run_da, CLST vcn, CLST lcn,
+			   CLST len, CLST *pre_alloc, enum ALLOCATE_OPT opt,
+			   CLST *alen, const size_t fr, CLST *new_lcn,
+			   CLST *new_len)
 {
 	int err;
 	CLST flen, vcn0 = vcn, pre = pre_alloc ? *pre_alloc : 0;
@@ -185,12 +197,21 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 
 		/* Add new fragment into run storage. */
 		if (!run_add_entry(run, vcn, lcn, flen, opt & ALLOCATE_MFT)) {
+undo_alloc:
 			/* Undo last 'ntfs_look_for_free_space' */
 			mark_as_free_ex(sbi, lcn, len, false);
 			err = -ENOMEM;
 			goto out;
 		}
 
+		if (run_da) {
+			CLST da_len;
+			if (!run_remove_range(run_da, vcn, flen, &da_len)) {
+				goto undo_alloc;
+			}
+			ntfs_sub_da(sbi, da_len);
+		}
+
 		if (opt & ALLOCATE_ZERO) {
 			u8 shift = sbi->cluster_bits - SECTOR_SHIFT;
 
@@ -205,7 +226,7 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 		vcn += flen;
 
 		if (flen >= len || (opt & ALLOCATE_MFT) ||
-		    (fr && run->count - cnt >= fr)) {
+		    (opt & ALLOCATE_ONE_FR) || (fr && run->count - cnt >= fr)) {
 			*alen = vcn - vcn0;
 			return 0;
 		}
@@ -216,7 +237,8 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 out:
 	/* Undo 'ntfs_look_for_free_space' */
 	if (vcn - vcn0) {
-		run_deallocate_ex(sbi, run, vcn0, vcn - vcn0, NULL, false);
+		run_deallocate_ex(sbi, run, vcn0, vcn - vcn0, NULL, false,
+				  run_da);
 		run_truncate(run, vcn0);
 	}
 
@@ -281,7 +303,7 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 	} else {
 		const char *data = resident_data(attr);
 
-		err = attr_allocate_clusters(sbi, run, 0, 0, len, NULL,
+		err = attr_allocate_clusters(sbi, run, NULL, 0, 0, len, NULL,
 					     ALLOCATE_DEF, &alen, 0, NULL,
 					     NULL);
 		if (err)
@@ -397,7 +419,7 @@ static int attr_set_size_res(struct ntfs_inode *ni, struct ATTRIB *attr,
 }
 
 /*
- * attr_set_size - Change the size of attribute.
+ * attr_set_size_ex - Change the size of attribute.
  *
  * Extend:
  *   - Sparse/compressed: No allocated clusters.
@@ -405,24 +427,28 @@ static int attr_set_size_res(struct ntfs_inode *ni, struct ATTRIB *attr,
  * Shrink:
  *   - No deallocate if @keep_prealloc is set.
  */
-int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
-		  const __le16 *name, u8 name_len, struct runs_tree *run,
-		  u64 new_size, const u64 *new_valid, bool keep_prealloc,
-		  struct ATTRIB **ret)
+int attr_set_size_ex(struct ntfs_inode *ni, enum ATTR_TYPE type,
+		     const __le16 *name, u8 name_len, struct runs_tree *run,
+		     u64 new_size, const u64 *new_valid, bool keep_prealloc,
+		     struct ATTRIB **ret, bool no_da)
 {
 	int err = 0;
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	u8 cluster_bits = sbi->cluster_bits;
 	bool is_mft = ni->mi.rno == MFT_REC_MFT && type == ATTR_DATA &&
 		      !name_len;
-	u64 old_valid, old_size, old_alloc, new_alloc, new_alloc_tmp;
+	u64 old_valid, old_size, old_alloc, new_alloc_tmp;
+	u64 new_alloc = 0;
 	struct ATTRIB *attr = NULL, *attr_b;
 	struct ATTR_LIST_ENTRY *le, *le_b;
 	struct mft_inode *mi, *mi_b;
 	CLST alen, vcn, lcn, new_alen, old_alen, svcn, evcn;
 	CLST next_svcn, pre_alloc = -1, done = 0;
-	bool is_ext, is_bad = false;
+	bool is_ext = false, is_bad = false;
 	bool dirty = false;
+	struct runs_tree *run_da = run == &ni->file.run ? &ni->file.run_da :
+							  NULL;
+	bool da = !is_mft && sbi->options->delalloc && run_da && !no_da;
 	u32 align;
 	struct MFT_REC *rec;
 
@@ -457,6 +483,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	if (is_ext) {
 		align <<= attr_b->nres.c_unit;
 		keep_prealloc = false;
+		da = false;
 	}
 
 	old_valid = le64_to_cpu(attr_b->nres.valid_size);
@@ -475,6 +502,37 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		goto ok;
 	}
 
+	if (da &&
+	    (vcn = old_alen + run_len(&ni->file.run_da), new_alen > vcn)) {
+		/* Resize up normal file. Delay new clusters allocation. */
+		alen = new_alen - vcn;
+
+		if (ntfs_check_free_space(sbi, alen, 0, true)) {
+			if (!run_add_entry(&ni->file.run_da, vcn, SPARSE_LCN,
+					   alen, false)) {
+				err = -ENOMEM;
+				goto out;
+			}
+
+			ntfs_add_da(sbi, alen);
+			goto ok1;
+		}
+	}
+
+	if (!keep_prealloc && run_da && run_da->count &&
+	    (vcn = run_get_max_vcn(run_da), new_alen < vcn)) {
+		/* Shrink delayed clusters. */
+
+		/* Try to remove fragment from delay allocated run. */
+		if (!run_remove_range(run_da, new_alen, vcn - new_alen,
+				      &alen)) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		ntfs_sub_da(sbi, alen);
+	}
+
 	vcn = old_alen - 1;
 
 	svcn = le64_to_cpu(attr_b->nres.svcn);
@@ -580,7 +638,8 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		} else {
 			/* ~3 bytes per fragment. */
 			err = attr_allocate_clusters(
-				sbi, run, vcn, lcn, to_allocate, &pre_alloc,
+				sbi, run, run_da, vcn, lcn, to_allocate,
+				&pre_alloc,
 				is_mft ? ALLOCATE_MFT : ALLOCATE_DEF, &alen,
 				is_mft ? 0 :
 					 (sbi->record_size -
@@ -759,14 +818,14 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		mi_b->dirty = dirty = true;
 
 		err = run_deallocate_ex(sbi, run, vcn, evcn - vcn + 1, &dlen,
-					true);
+					true, run_da);
 		if (err)
 			goto out;
 
 		if (is_ext) {
 			/* dlen - really deallocated clusters. */
 			le64_sub_cpu(&attr_b->nres.total_size,
-				     ((u64)dlen << cluster_bits));
+				     (u64)dlen << cluster_bits);
 		}
 
 		run_truncate(run, vcn);
@@ -821,14 +880,14 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	if (((type == ATTR_DATA && !name_len) ||
 	     (type == ATTR_ALLOC && name == I30_NAME))) {
 		/* Update inode_set_bytes. */
-		if (attr_b->non_res) {
-			new_alloc = le64_to_cpu(attr_b->nres.alloc_size);
-			if (inode_get_bytes(&ni->vfs_inode) != new_alloc) {
-				inode_set_bytes(&ni->vfs_inode, new_alloc);
-				dirty = true;
-			}
+		if (attr_b->non_res &&
+		    inode_get_bytes(&ni->vfs_inode) != new_alloc) {
+			inode_set_bytes(&ni->vfs_inode, new_alloc);
+			dirty = true;
 		}
 
+		i_size_write(&ni->vfs_inode, new_size);
+
 		/* Don't forget to update duplicate information in parent. */
 		if (dirty) {
 			ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
@@ -869,7 +928,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		is_bad = true;
 
 undo_1:
-	run_deallocate_ex(sbi, run, vcn, alen, NULL, false);
+	run_deallocate_ex(sbi, run, vcn, alen, NULL, false, run_da);
 
 	run_truncate(run, vcn);
 out:
@@ -892,20 +951,9 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  *  - new allocated clusters are zeroed via blkdev_issue_zeroout.
  */
 int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
-			CLST *len, bool *new, bool zero, void **res)
+			CLST *len, bool *new, bool zero, void **res, bool no_da)
 {
-	int err = 0;
-	struct runs_tree *run = &ni->file.run;
-	struct ntfs_sb_info *sbi;
-	u8 cluster_bits;
-	struct ATTRIB *attr, *attr_b;
-	struct ATTR_LIST_ENTRY *le, *le_b;
-	struct mft_inode *mi, *mi_b;
-	CLST hint, svcn, to_alloc, evcn1, next_svcn, asize, end, vcn0, alen;
-	CLST alloc, evcn;
-	unsigned fr;
-	u64 total_size, total_size0;
-	int step = 0;
+	int err;
 
 	if (new)
 		*new = false;
@@ -914,23 +962,63 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 
 	/* Try to find in cache. */
 	down_read(&ni->file.run_lock);
-	if (!run_lookup_entry(run, vcn, lcn, len, NULL))
+	if (!no_da && run_lookup_entry(&ni->file.run_da, vcn, lcn, len, NULL)) {
+		/* The requested vcn is delay allocated. */
+		*lcn = DELALLOC_LCN;
+	} else if (run_lookup_entry(&ni->file.run, vcn, lcn, len, NULL)) {
+		/* The requested vcn is known in current run. */
+	} else {
 		*len = 0;
+	}
 	up_read(&ni->file.run_lock);
 
 	if (*len && (*lcn != SPARSE_LCN || !new))
 		return 0; /* Fast normal way without allocation. */
 
 	/* No cluster in cache or we need to allocate cluster in hole. */
-	sbi = ni->mi.sbi;
-	cluster_bits = sbi->cluster_bits;
-
 	ni_lock(ni);
 	down_write(&ni->file.run_lock);
 
-	/* Repeat the code above (under write lock). */
-	if (!run_lookup_entry(run, vcn, lcn, len, NULL))
+	err = attr_data_get_block_locked(ni, vcn, clen, lcn, len, new, zero,
+					 res, no_da);
+
+	up_write(&ni->file.run_lock);
+	ni_unlock(ni);
+
+	return err;
+}
+
+/*
+ * attr_data_get_block_locked - Helper for attr_data_get_block.
+ */
+int attr_data_get_block_locked(struct ntfs_inode *ni, CLST vcn, CLST clen,
+			       CLST *lcn, CLST *len, bool *new, bool zero,
+			       void **res, bool no_da)
+{
+	int err = 0;
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
+	struct runs_tree *run = &ni->file.run;
+	struct runs_tree *run_da = &ni->file.run_da;
+	bool da = sbi->options->delalloc && !no_da;
+	u8 cluster_bits;
+	struct ATTRIB *attr, *attr_b;
+	struct ATTR_LIST_ENTRY *le, *le_b;
+	struct mft_inode *mi, *mi_b;
+	CLST hint, svcn, to_alloc, evcn1, next_svcn, asize, end, vcn0;
+	CLST alloc, evcn;
+	unsigned fr;
+	u64 total_size, total_size0;
+	int step;
+
+again:
+	if (da && run_lookup_entry(run_da, vcn, lcn, len, NULL)) {
+		/* The requested vcn is delay allocated. */
+		*lcn = DELALLOC_LCN;
+	} else if (run_lookup_entry(run, vcn, lcn, len, NULL)) {
+		/* The requested vcn is known in current run. */
+	} else {
 		*len = 0;
+	}
 
 	if (*len) {
 		if (*lcn != SPARSE_LCN || !new)
@@ -939,6 +1027,9 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 			clen = *len;
 	}
 
+	cluster_bits = sbi->cluster_bits;
+	step = 0;
+
 	le_b = NULL;
 	attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL, 0, NULL, &mi_b);
 	if (!attr_b) {
@@ -1061,11 +1152,38 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 			if (err)
 				goto out;
 		}
+		da = false; /* no delalloc for compressed file. */
 	}
 
 	if (vcn + to_alloc > asize)
 		to_alloc = asize - vcn;
 
+	if (da) {
+		CLST rlen1, rlen2;
+		if (!ntfs_check_free_space(sbi, to_alloc, 0, true)) {
+			err = ni_allocate_da_blocks_locked(ni);
+			if (err)
+				goto out;
+			/* Layout of records may be changed. Start again without 'da'. */
+			da = false;
+			goto again;
+		}
+
+		/* run_add_entry consolidates existed ranges. */
+		rlen1 = run_len(run_da);
+		if (!run_add_entry(run_da, vcn, SPARSE_LCN, to_alloc, false)) {
+			err = -ENOMEM;
+			goto out;
+		}
+		rlen2 = run_len(run_da);
+
+		/* new added delay clusters = rlen2 - rlen1. */
+		ntfs_add_da(sbi, rlen2 - rlen1);
+		*len = to_alloc;
+		*lcn = DELALLOC_LCN;
+		goto ok;
+	}
+
 	/* Get the last LCN to allocate from. */
 	hint = 0;
 
@@ -1080,18 +1198,19 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 	}
 
 	/* Allocate and zeroout new clusters. */
-	err = attr_allocate_clusters(sbi, run, vcn, hint + 1, to_alloc, NULL,
-				     zero ? ALLOCATE_ZERO : ALLOCATE_DEF, &alen,
-				     fr, lcn, len);
+	err = attr_allocate_clusters(sbi, run, run_da, vcn, hint + 1, to_alloc,
+				     NULL,
+				     zero ? ALLOCATE_ZERO : ALLOCATE_ONE_FR,
+				     len, fr, lcn, len);
 	if (err)
 		goto out;
 	*new = true;
 	step = 1;
 
-	end = vcn + alen;
+	end = vcn + *len;
 	/* Save 'total_size0' to restore if error. */
 	total_size0 = le64_to_cpu(attr_b->nres.total_size);
-	total_size = total_size0 + ((u64)alen << cluster_bits);
+	total_size = total_size0 + ((u64)*len << cluster_bits);
 
 	if (vcn != vcn0) {
 		if (!run_lookup_entry(run, vcn0, lcn, len, NULL)) {
@@ -1157,7 +1276,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 	 * in 'ni_insert_nonresident'.
 	 * Return in advance -ENOSPC here if there are no free cluster and no free MFT.
 	 */
-	if (!ntfs_check_for_free_space(sbi, 1, 1)) {
+	if (!ntfs_check_free_space(sbi, 1, 1, false)) {
 		/* Undo step 1. */
 		err = -ENOSPC;
 		goto undo1;
@@ -1242,8 +1361,6 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 		/* Too complex to restore. */
 		_ntfs_bad_inode(&ni->vfs_inode);
 	}
-	up_write(&ni->file.run_lock);
-	ni_unlock(ni);
 
 	return err;
 
@@ -1252,8 +1369,8 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 	attr_b->nres.total_size = cpu_to_le64(total_size0);
 	inode_set_bytes(&ni->vfs_inode, total_size0);
 
-	if (run_deallocate_ex(sbi, run, vcn, alen, NULL, false) ||
-	    !run_add_entry(run, vcn, SPARSE_LCN, alen, false) ||
+	if (run_deallocate_ex(sbi, run, vcn, *len, NULL, false, run_da) ||
+	    !run_add_entry(run, vcn, SPARSE_LCN, *len, false) ||
 	    mi_pack_runs(mi, attr, run, max(end, evcn1) - svcn)) {
 		_ntfs_bad_inode(&ni->vfs_inode);
 	}
@@ -1688,7 +1805,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 
 	if (len < clst_data) {
 		err = run_deallocate_ex(sbi, run, vcn + len, clst_data - len,
-					NULL, true);
+					NULL, true, NULL);
 		if (err)
 			goto out;
 
@@ -1708,7 +1825,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 			hint = -1;
 		}
 
-		err = attr_allocate_clusters(sbi, run, vcn + clst_data,
+		err = attr_allocate_clusters(sbi, run, NULL, vcn + clst_data,
 					     hint + 1, len - clst_data, NULL,
 					     ALLOCATE_DEF, &alen, 0, NULL,
 					     NULL);
@@ -1863,6 +1980,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 	CLST vcn, end;
 	u64 valid_size, data_size, alloc_size, total_size;
 	u32 mask;
+	u64 i_size;
 	__le16 a_flags;
 
 	if (!bytes)
@@ -1878,52 +1996,79 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 		return 0;
 	}
 
-	data_size = le64_to_cpu(attr_b->nres.data_size);
-	alloc_size = le64_to_cpu(attr_b->nres.alloc_size);
-	a_flags = attr_b->flags;
-
-	if (is_attr_ext(attr_b)) {
-		total_size = le64_to_cpu(attr_b->nres.total_size);
-		mask = (sbi->cluster_size << attr_b->nres.c_unit) - 1;
-	} else {
-		total_size = alloc_size;
-		mask = sbi->cluster_mask;
-	}
-
-	if ((vbo & mask) || (bytes & mask)) {
+	mask = is_attr_ext(attr_b) ?
+		       ((sbi->cluster_size << attr_b->nres.c_unit) - 1) :
+		       sbi->cluster_mask;
+	if ((vbo | bytes) & mask) {
 		/* Allow to collapse only cluster aligned ranges. */
 		return -EINVAL;
 	}
 
-	if (vbo > data_size)
+	/* i_size - size of file with delay allocated clusters. */
+	i_size = ni->vfs_inode.i_size;
+
+	if (vbo > i_size)
 		return -EINVAL;
 
 	down_write(&ni->file.run_lock);
 
-	if (vbo + bytes >= data_size) {
-		u64 new_valid = min(ni->i_valid, vbo);
+	if (vbo + bytes >= i_size) {
+		valid_size = min(ni->i_valid, vbo);
 
 		/* Simple truncate file at 'vbo'. */
 		truncate_setsize(&ni->vfs_inode, vbo);
 		err = attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run, vbo,
-				    &new_valid, true, NULL);
+				    &valid_size, true);
 
-		if (!err && new_valid < ni->i_valid)
-			ni->i_valid = new_valid;
+		if (!err && valid_size < ni->i_valid)
+			ni->i_valid = valid_size;
 
 		goto out;
 	}
 
-	/*
-	 * Enumerate all attribute segments and collapse.
-	 */
-	alen = alloc_size >> sbi->cluster_bits;
 	vcn = vbo >> sbi->cluster_bits;
 	len = bytes >> sbi->cluster_bits;
 	end = vcn + len;
 	dealloc = 0;
 	done = 0;
 
+	/*
+	 * Check delayed clusters.
+	 */
+	if (ni->file.run_da.count) {
+		struct runs_tree *run_da = &ni->file.run_da;
+		if (run_is_mapped_full(run_da, vcn, end - 1)) {
+			/*
+			 * The requested range is full in delayed clusters.
+			 */
+			err = attr_set_size_ex(ni, ATTR_DATA, NULL, 0, run,
+					       i_size - bytes, NULL, false,
+					       NULL, true);
+			goto out;
+		}
+
+		/* Collapse request crosses real and delayed clusters. */
+		err = ni_allocate_da_blocks_locked(ni);
+		if (err)
+			goto out;
+
+		/* Layout of records maybe changed. */
+		le_b = NULL;
+		attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL, 0, NULL,
+				      &mi_b);
+		if (!attr_b || !attr_b->non_res) {
+			err = -ENOENT;
+			goto out;
+		}
+	}
+
+	data_size = le64_to_cpu(attr_b->nres.data_size);
+	alloc_size = le64_to_cpu(attr_b->nres.alloc_size);
+	total_size = is_attr_ext(attr_b) ?
+			     le64_to_cpu(attr_b->nres.total_size) :
+			     alloc_size;
+	alen = alloc_size >> sbi->cluster_bits;
+	a_flags = attr_b->flags;
 	svcn = le64_to_cpu(attr_b->nres.svcn);
 	evcn1 = le64_to_cpu(attr_b->nres.evcn) + 1;
 
@@ -1946,6 +2091,9 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 		goto out;
 	}
 
+	/*
+	 * Enumerate all attribute segments and collapse.
+	 */
 	for (;;) {
 		CLST vcn1, eat, next_svcn;
 
@@ -1973,13 +2121,13 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 		vcn1 = vcn + done; /* original vcn in attr/run. */
 		eat = min(end, evcn1) - vcn1;
 
-		err = run_deallocate_ex(sbi, run, vcn1, eat, &dealloc, true);
+		err = run_deallocate_ex(sbi, run, vcn1, eat, &dealloc, true,
+					NULL);
 		if (err)
 			goto out;
 
 		if (svcn + eat < evcn1) {
 			/* Collapse a part of this attribute segment. */
-
 			if (!run_collapse_range(run, vcn1, eat, done)) {
 				err = -ENOMEM;
 				goto out;
@@ -2160,9 +2308,9 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
 		bytes = alloc_size;
 	bytes -= vbo;
 
-	if ((vbo & mask) || (bytes & mask)) {
+	if ((vbo | bytes) & mask) {
 		/* We have to zero a range(s). */
-		if (frame_size == NULL) {
+		if (!frame_size) {
 			/* Caller insists range is aligned. */
 			return -EINVAL;
 		}
@@ -2221,7 +2369,8 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
 		 * Calculate how many clusters there are.
 		 * Don't do any destructive actions.
 		 */
-		err = run_deallocate_ex(NULL, run, vcn1, zero, &hole2, false);
+		err = run_deallocate_ex(NULL, run, vcn1, zero, &hole2, false,
+					NULL);
 		if (err)
 			goto done;
 
@@ -2259,7 +2408,8 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
 		}
 
 		/* Real deallocate. Should not fail. */
-		run_deallocate_ex(sbi, &run2, vcn1, zero, &hole, true);
+		run_deallocate_ex(sbi, &run2, vcn1, zero, &hole, true,
+				  &ni->file.run_da);
 
 next_attr:
 		/* Free all allocated memory. */
@@ -2371,7 +2521,7 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 		return -EINVAL;
 	}
 
-	if ((vbo & mask) || (bytes & mask)) {
+	if ((vbo | bytes) & mask) {
 		/* Allow to insert only frame aligned ranges. */
 		return -EINVAL;
 	}
@@ -2390,7 +2540,7 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 
 	if (!attr_b->non_res) {
 		err = attr_set_size(ni, ATTR_DATA, NULL, 0, run,
-				    data_size + bytes, NULL, false, NULL);
+				    data_size + bytes, NULL, false);
 
 		le_b = NULL;
 		attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL, 0, NULL,
@@ -2413,7 +2563,7 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 			goto done;
 		}
 
-		/* Resident files becomes nonresident. */
+		/* Resident file becomes nonresident. */
 		data_size = le64_to_cpu(attr_b->nres.data_size);
 		alloc_size = le64_to_cpu(attr_b->nres.alloc_size);
 	}
@@ -2450,10 +2600,13 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 	if (err)
 		goto out;
 
-	if (!run_insert_range(run, vcn, len)) {
-		err = -ENOMEM;
+	err = run_insert_range(run, vcn, len);
+	if (err)
+		goto out;
+
+	err = run_insert_range_da(&ni->file.run_da, vcn, len);
+	if (err)
 		goto out;
-	}
 
 	/* Try to pack in current record as much as possible. */
 	err = mi_pack_runs(mi, attr, run, evcn1 + len - svcn);
diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 098bd7e8c3d6..270a29323530 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -345,8 +345,8 @@ int al_add_le(struct ntfs_inode *ni, enum ATTR_TYPE type, const __le16 *name,
 	le->id = id;
 	memcpy(le->name, name, sizeof(short) * name_len);
 
-	err = attr_set_size(ni, ATTR_LIST, NULL, 0, &al->run, new_size,
-			    &new_size, true, &attr);
+	err = attr_set_size_ex(ni, ATTR_LIST, NULL, 0, &al->run, new_size,
+			       &new_size, true, &attr, false);
 	if (err) {
 		/* Undo memmove above. */
 		memmove(le, Add2Ptr(le, sz), old_size - off);
@@ -404,8 +404,8 @@ int al_update(struct ntfs_inode *ni, int sync)
 	 * Attribute list increased on demand in al_add_le.
 	 * Attribute list decreased here.
 	 */
-	err = attr_set_size(ni, ATTR_LIST, NULL, 0, &al->run, al->size, NULL,
-			    false, &attr);
+	err = attr_set_size_ex(ni, ATTR_LIST, NULL, 0, &al->run, al->size, NULL,
+			       false, &attr, false);
 	if (err)
 		goto out;
 
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 1be77f865d78..df54430a89ca 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -26,6 +26,38 @@
  */
 #define NTFS3_IOC_SHUTDOWN _IOR('X', 125, __u32)
 
+/*
+ * Helper for ntfs_should_use_dio.
+ */
+static u32 ntfs_dio_alignment(struct inode *inode)
+{
+	struct ntfs_inode *ni = ntfs_i(inode);
+
+	if (is_resident(ni)) {
+		/* Check delalloc. */
+		if (!ni->file.run_da.count)
+			return 0;
+	}
+
+	/* In most cases this is bdev_logical_block_size(bdev). */
+	return ni->mi.sbi->bdev_blocksize;
+}
+
+/*
+ * Returns %true if the given DIO request should be attempted with DIO, or
+ * %false if it should fall back to buffered I/O.
+ */
+static bool ntfs_should_use_dio(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	u32 dio_align = ntfs_dio_alignment(inode);
+
+	if (!dio_align)
+		return false;
+
+	return IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(iter), dio_align);
+}
+
 static int ntfs_ioctl_fitrim(struct ntfs_sb_info *sbi, unsigned long arg)
 {
 	struct fstrim_range __user *user_range;
@@ -186,10 +218,10 @@ int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 static int ntfs_extend_initialized_size(struct file *file,
 					struct ntfs_inode *ni,
-					const loff_t valid,
 					const loff_t new_valid)
 {
 	struct inode *inode = &ni->vfs_inode;
+	const loff_t valid = ni->i_valid;
 	int err;
 
 	if (valid >= new_valid)
@@ -291,7 +323,7 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 			for (; vcn < end; vcn += len) {
 				err = attr_data_get_block(ni, vcn, 1, &lcn,
 							  &len, &new, true,
-							  NULL);
+							  NULL, false);
 				if (err)
 					goto out;
 			}
@@ -302,8 +334,7 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 				err = -EAGAIN;
 				goto out;
 			}
-			err = ntfs_extend_initialized_size(file, ni,
-							   ni->i_valid, to);
+			err = ntfs_extend_initialized_size(file, ni, to);
 			inode_unlock(inode);
 			if (err)
 				goto out;
@@ -333,55 +364,23 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
 	ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_DIRTY);
 
 	if (end > inode->i_size) {
+		/*
+		 * Normal files: increase file size, allocate space.
+		 * Sparse/Compressed: increase file size. No space allocated.
+		 */
 		err = ntfs_set_size(inode, end);
 		if (err)
 			goto out;
 	}
 
 	if (extend_init && !is_compressed(ni)) {
-		err = ntfs_extend_initialized_size(file, ni, ni->i_valid, pos);
+		err = ntfs_extend_initialized_size(file, ni, pos);
 		if (err)
 			goto out;
 	} else {
 		err = 0;
 	}
 
-	if (file && is_sparsed(ni)) {
-		/*
-		 * This code optimizes large writes to sparse file.
-		 * TODO: merge this fragment with fallocate fragment.
-		 */
-		struct ntfs_sb_info *sbi = ni->mi.sbi;
-		CLST vcn = pos >> sbi->cluster_bits;
-		CLST cend = bytes_to_cluster(sbi, end);
-		CLST cend_v = bytes_to_cluster(sbi, ni->i_valid);
-		CLST lcn, clen;
-		bool new;
-
-		if (cend_v > cend)
-			cend_v = cend;
-
-		/*
-		 * Allocate and zero new clusters.
-		 * Zeroing these clusters may be too long.
-		 */
-		for (; vcn < cend_v; vcn += clen) {
-			err = attr_data_get_block(ni, vcn, cend_v - vcn, &lcn,
-						  &clen, &new, true, NULL);
-			if (err)
-				goto out;
-		}
-		/*
-		 * Allocate but not zero new clusters.
-		 */
-		for (; vcn < cend; vcn += clen) {
-			err = attr_data_get_block(ni, vcn, cend - vcn, &lcn,
-						  &clen, &new, false, NULL);
-			if (err)
-				goto out;
-		}
-	}
-
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 
@@ -414,8 +413,9 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
 	ni_lock(ni);
 
 	down_write(&ni->file.run_lock);
-	err = attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run, new_size,
-			    &new_valid, ni->mi.sbi->options->prealloc, NULL);
+	err = attr_set_size_ex(ni, ATTR_DATA, NULL, 0, &ni->file.run, new_size,
+			       &new_valid, ni->mi.sbi->options->prealloc, NULL,
+			       false);
 	up_write(&ni->file.run_lock);
 
 	ni->i_valid = new_valid;
@@ -507,7 +507,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 
 	if (mode & FALLOC_FL_PUNCH_HOLE) {
 		u32 frame_size;
-		loff_t mask, vbo_a, end_a, tmp;
+		loff_t mask, vbo_a, end_a, tmp, from;
 
 		err = filemap_write_and_wait_range(mapping, vbo_down,
 						   LLONG_MAX);
@@ -527,28 +527,24 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 
 		/* Process not aligned punch. */
 		err = 0;
+		if (end > i_size)
+			end = i_size;
 		mask = frame_size - 1;
 		vbo_a = (vbo + mask) & ~mask;
 		end_a = end & ~mask;
 
 		tmp = min(vbo_a, end);
-		if (tmp > vbo) {
-			err = iomap_zero_range(inode, vbo, tmp - vbo, NULL,
+		from = min_t(loff_t, ni->i_valid, vbo);
+		/* Zero head of punch. */
+		if (tmp > from) {
+			err = iomap_zero_range(inode, from, tmp - from, NULL,
 					       &ntfs_iomap_ops,
 					       &ntfs_iomap_folio_ops, NULL);
 			if (err)
 				goto out;
 		}
 
-		if (vbo < end_a && end_a < end) {
-			err = iomap_zero_range(inode, end_a, end - end_a, NULL,
-					       &ntfs_iomap_ops,
-					       &ntfs_iomap_folio_ops, NULL);
-			if (err)
-				goto out;
-		}
-
-		/* Aligned punch_hole */
+		/* Aligned punch_hole. Deallocate clusters. */
 		if (end_a > vbo_a) {
 			ni_lock(ni);
 			err = attr_punch_hole(ni, vbo_a, end_a - vbo_a, NULL);
@@ -556,6 +552,15 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 			if (err)
 				goto out;
 		}
+
+		/* Zero tail of punch. */
+		if (vbo < end_a && end_a < end) {
+			err = iomap_zero_range(inode, end_a, end - end_a, NULL,
+					       &ntfs_iomap_ops,
+					       &ntfs_iomap_folio_ops, NULL);
+			if (err)
+				goto out;
+		}
 	} else if (mode & FALLOC_FL_COLLAPSE_RANGE) {
 		/*
 		 * Write tail of the last page before removed range since
@@ -653,17 +658,26 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 			for (; vcn < cend_v; vcn += clen) {
 				err = attr_data_get_block(ni, vcn, cend_v - vcn,
 							  &lcn, &clen, &new,
-							  true, NULL);
+							  true, NULL, false);
 				if (err)
 					goto out;
 			}
+
+			/*
+			 * Moving up 'valid size'.
+			 */
+			err = ntfs_extend_initialized_size(
+				file, ni, (u64)cend_v << cluster_bits);
+			if (err)
+				goto out;
+
 			/*
 			 * Allocate but not zero new clusters.
 			 */
 			for (; vcn < cend; vcn += clen) {
 				err = attr_data_get_block(ni, vcn, cend - vcn,
 							  &lcn, &clen, &new,
-							  false, NULL);
+							  false, NULL, false);
 				if (err)
 					goto out;
 			}
@@ -674,7 +688,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 			/* True - Keep preallocated. */
 			err = attr_set_size(ni, ATTR_DATA, NULL, 0,
 					    &ni->file.run, i_size, &ni->i_valid,
-					    true, NULL);
+					    true);
 			ni_unlock(ni);
 			if (err)
 				goto out;
@@ -816,6 +830,8 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct inode *inode = file_inode(file);
 	struct ntfs_inode *ni = ntfs_i(inode);
 	size_t bytes = iov_iter_count(iter);
+	loff_t valid, i_size, vbo, end;
+	unsigned int dio_flags;
 	ssize_t err;
 
 	err = check_read_restriction(inode);
@@ -835,62 +851,63 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		file->f_ra.ra_pages = 0;
 	}
 
-	/* Check minimum alignment for dio. */
-	if ((iocb->ki_flags & IOCB_DIRECT) &&
-	    (is_resident(ni) || ((iocb->ki_pos | iov_iter_alignment(iter)) &
-				 ni->mi.sbi->bdev_blocksize_mask))) {
-		/* Fallback to buffered I/O */
+	/* Fallback to buffered I/O if the inode does not support direct I/O. */
+	if (!(iocb->ki_flags & IOCB_DIRECT) ||
+	    !ntfs_should_use_dio(iocb, iter)) {
 		iocb->ki_flags &= ~IOCB_DIRECT;
+		return generic_file_read_iter(iocb, iter);
 	}
 
-	if (iocb->ki_flags & IOCB_DIRECT) {
-		loff_t valid, i_size;
-		loff_t vbo = iocb->ki_pos;
-		loff_t end = vbo + bytes;
-		unsigned int dio_flags = IOMAP_DIO_PARTIAL;
-
-		if (iocb->ki_flags & IOCB_NOWAIT) {
-			if (!inode_trylock_shared(inode))
-				return -EAGAIN;
-		} else {
-			inode_lock_shared(inode);
-		}
-
-		valid = ni->i_valid;
-		i_size = inode->i_size;
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock_shared(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock_shared(inode);
+	}
 
-		if (vbo < valid) {
-			if (valid < end) {
-				/* read cross 'valid' size. */
-				dio_flags |= IOMAP_DIO_FORCE_WAIT;
-			}
+	vbo = iocb->ki_pos;
+	end = vbo + bytes;
+	dio_flags = 0;
+	valid = ni->i_valid;
+	i_size = inode->i_size;
 
-			err = iomap_dio_rw(iocb, iter, &ntfs_iomap_ops, NULL,
-					   dio_flags, NULL, 0);
+	if (vbo < valid) {
+		if (valid < end) {
+			/* read cross 'valid' size. */
+			dio_flags |= IOMAP_DIO_FORCE_WAIT;
+		}
 
-			if (err > 0) {
-				end = vbo + err;
-				if (valid < end) {
-					size_t to_zero = end - valid;
-					/* Fix iter. */
-					iov_iter_revert(iter, to_zero);
-					iov_iter_zero(to_zero, iter);
-				}
-			}
-		} else if (vbo < i_size) {
-			if (end > i_size)
-				bytes = i_size - vbo;
-			iov_iter_zero(bytes, iter);
-			iocb->ki_pos += bytes;
-			err = bytes;
+		if (ni->file.run_da.count) {
+			/* Direct I/O is not compatible with delalloc. */
+			err = ni_allocate_da_blocks(ni);
+			if (err)
+				goto out;
 		}
 
-		inode_unlock_shared(inode);
-		file_accessed(iocb->ki_filp);
-		return err;
+		err = iomap_dio_rw(iocb, iter, &ntfs_iomap_ops, NULL, dio_flags,
+				   NULL, 0);
+
+		if (err <= 0)
+			goto out;
+		end = vbo + err;
+		if (valid < end) {
+			size_t to_zero = end - valid;
+			/* Fix iter. */
+			iov_iter_revert(iter, to_zero);
+			iov_iter_zero(to_zero, iter);
+		}
+	} else if (vbo < i_size) {
+		if (end > i_size)
+			bytes = i_size - vbo;
+		iov_iter_zero(bytes, iter);
+		iocb->ki_pos += bytes;
+		err = bytes;
 	}
 
-	return generic_file_read_iter(iocb, iter);
+out:
+	inode_unlock_shared(inode);
+	file_accessed(iocb->ki_filp);
+	return err;
 }
 
 /*
@@ -1011,17 +1028,13 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		off = valid & (frame_size - 1);
 
 		err = attr_data_get_block(ni, frame << NTFS_LZNT_CUNIT, 1, &lcn,
-					  &clen, NULL, false, NULL);
+					  &clen, NULL, false, NULL, false);
 		if (err)
 			goto out;
 
 		if (lcn == SPARSE_LCN) {
-			valid = frame_vbo + ((u64)clen << sbi->cluster_bits);
-			if (ni->i_valid == valid) {
-				err = -EINVAL;
-				goto out;
-			}
-			ni->i_valid = valid;
+			ni->i_valid = valid =
+				frame_vbo + ((u64)clen << sbi->cluster_bits);
 			continue;
 		}
 
@@ -1207,6 +1220,9 @@ static int check_write_restriction(struct inode *inode)
 		return -EOPNOTSUPP;
 	}
 
+	if (unlikely(IS_IMMUTABLE(inode)))
+		return -EPERM;
+
 	return 0;
 }
 
@@ -1218,8 +1234,6 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct ntfs_inode *ni = ntfs_i(inode);
-	struct super_block *sb = inode->i_sb;
-	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	ssize_t ret, err;
 
 	if (!inode_trylock(inode)) {
@@ -1263,15 +1277,11 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}
 
-	/* Check minimum alignment for dio. */
-	if ((iocb->ki_flags & IOCB_DIRECT) &&
-	    (is_resident(ni) || ((iocb->ki_pos | iov_iter_alignment(from)) &
-				 sbi->bdev_blocksize_mask))) {
-		/* Fallback to buffered I/O */
+	/* Fallback to buffered I/O if the inode does not support direct I/O. */
+	if (!(iocb->ki_flags & IOCB_DIRECT) ||
+	    !ntfs_should_use_dio(iocb, from)) {
 		iocb->ki_flags &= ~IOCB_DIRECT;
-	}
 
-	if (!(iocb->ki_flags & IOCB_DIRECT)) {
 		ret = iomap_file_buffered_write(iocb, from, &ntfs_iomap_ops,
 						&ntfs_iomap_folio_ops, NULL);
 		inode_unlock(inode);
@@ -1282,8 +1292,14 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		return ret;
 	}
 
-	ret = iomap_dio_rw(iocb, from, &ntfs_iomap_ops, NULL, IOMAP_DIO_PARTIAL,
-			   NULL, 0);
+	if (ni->file.run_da.count) {
+		/* Direct I/O is not compatible with delalloc. */
+		ret = ni_allocate_da_blocks(ni);
+		if (ret)
+			goto out;
+	}
+
+	ret = iomap_dio_rw(iocb, from, &ntfs_iomap_ops, NULL, 0, NULL, 0);
 
 	if (ret == -ENOTBLK) {
 		/* Returns -ENOTBLK in case of a page invalidation failure for writes.*/
@@ -1370,34 +1386,42 @@ int ntfs_file_open(struct inode *inode, struct file *file)
 
 /*
  * ntfs_file_release - file_operations::release
+ *
+ * Called when an inode is released. Note that this is different
+ * from ntfs_file_open: open gets called at every open, but release
+ * gets called only when /all/ the files are closed.
  */
 static int ntfs_file_release(struct inode *inode, struct file *file)
 {
-	struct ntfs_inode *ni = ntfs_i(inode);
-	struct ntfs_sb_info *sbi = ni->mi.sbi;
-	int err = 0;
-
-	/* If we are last writer on the inode, drop the block reservation. */
-	if (sbi->options->prealloc &&
-	    ((file->f_mode & FMODE_WRITE) &&
-	     atomic_read(&inode->i_writecount) == 1)
-	    /*
-	    * The only file when inode->i_fop = &ntfs_file_operations and
-	    * init_rwsem(&ni->file.run_lock) is not called explicitly is MFT.
-	    *
-	    * Add additional check here.
-	    */
-	    && inode->i_ino != MFT_REC_MFT) {
+	int err;
+	struct ntfs_inode *ni;
+
+	if (!(file->f_mode & FMODE_WRITE) ||
+	    atomic_read(&inode->i_writecount) != 1 ||
+	    inode->i_ino == MFT_REC_MFT) {
+		return 0;
+	}
+
+	/* Close the last writer on the inode. */
+	ni = ntfs_i(inode);
+
+	/* Allocate delayed blocks (clusters). */
+	err = ni_allocate_da_blocks(ni);
+	if (err)
+		goto out;
+
+	if (ni->mi.sbi->options->prealloc) {
 		ni_lock(ni);
 		down_write(&ni->file.run_lock);
 
+		/* Deallocate preallocated. */
 		err = attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run,
-				    i_size_read(inode), &ni->i_valid, false,
-				    NULL);
+				    inode->i_size, &ni->i_valid, false);
 
 		up_write(&ni->file.run_lock);
 		ni_unlock(ni);
 	}
+out:
 	return err;
 }
 
@@ -1506,7 +1530,7 @@ static loff_t ntfs_llseek(struct file *file, loff_t offset, int whence)
 
 	if (whence == SEEK_DATA || whence == SEEK_HOLE) {
 		inode_lock_shared(inode);
-		/* Scan fragments for hole or data. */
+		/* Scan file for hole or data. */
 		ret = ni_seek_data_or_hole(ni, offset, whence == SEEK_DATA);
 		inode_unlock_shared(inode);
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 0dc28815331e..bd0fa481e4b3 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -123,6 +123,8 @@ void ni_clear(struct ntfs_inode *ni)
 		indx_clear(&ni->dir);
 	else {
 		run_close(&ni->file.run);
+		ntfs_sub_da(ni->mi.sbi, run_len(&ni->file.run_da));
+		run_close(&ni->file.run_da);
 #ifdef CONFIG_NTFS3_LZX_XPRESS
 		if (ni->file.offs_folio) {
 			/* On-demand allocated page for offsets. */
@@ -2014,7 +2016,8 @@ int ni_decompress_file(struct ntfs_inode *ni)
 
 		for (vcn = vbo >> sbi->cluster_bits; vcn < end; vcn += clen) {
 			err = attr_data_get_block(ni, vcn, cend - vcn, &lcn,
-						  &clen, &new, false, NULL);
+						  &clen, &new, false, NULL,
+						  false);
 			if (err)
 				goto out;
 		}
@@ -2235,7 +2238,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 	struct runs_tree *run = &ni->file.run;
 	u64 valid_size = ni->i_valid;
 	u64 vbo_disk;
-	size_t unc_size;
+	size_t unc_size = 0;
 	u32 frame_size, i, ondisk_size;
 	struct page *pg;
 	struct ATTRIB *attr;
@@ -2846,7 +2849,7 @@ loff_t ni_seek_data_or_hole(struct ntfs_inode *ni, loff_t offset, bool data)
 	/* Enumerate all fragments. */
 	for (vcn = offset >> cluster_bits;; vcn += clen) {
 		err = attr_data_get_block(ni, vcn, 1, &lcn, &clen, NULL, false,
-					  NULL);
+					  NULL, false);
 		if (err) {
 			return err;
 		}
@@ -2886,9 +2889,9 @@ loff_t ni_seek_data_or_hole(struct ntfs_inode *ni, loff_t offset, bool data)
 			}
 		} else {
 			/*
-			 * Adjust the file offset to the next hole in the file greater than or 
+			 * Adjust the file offset to the next hole in the file greater than or
 			 * equal to offset. If offset points into the middle of a hole, then the
-			 * file offset is set to offset. If there is no hole past offset, then the 
+			 * file offset is set to offset. If there is no hole past offset, then the
 			 * file offset is adjusted to the end of the file
 			 * (i.e., there is an implicit hole at the end of any file).
 			 */
@@ -3235,3 +3238,62 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 
 	return 0;
 }
+
+/*
+ * Force to allocate all delay allocated clusters.
+ */
+int ni_allocate_da_blocks(struct ntfs_inode *ni)
+{
+	int err;
+
+	ni_lock(ni);
+	down_write(&ni->file.run_lock);
+
+	err = ni_allocate_da_blocks_locked(ni);
+
+	up_write(&ni->file.run_lock);
+	ni_unlock(ni);
+
+	return err;
+}
+
+/*
+ * Force to allocate all delay allocated clusters.
+ */
+int ni_allocate_da_blocks_locked(struct ntfs_inode *ni)
+{
+	int err;
+
+	if (!ni->file.run_da.count)
+		return 0;
+
+	if (is_sparsed(ni)) {
+		CLST vcn, lcn, clen, alen;
+		bool new;
+
+		/*
+		 * Sparse file allocates clusters in 'attr_data_get_block_locked'
+		 */
+		while (run_get_entry(&ni->file.run_da, 0, &vcn, &lcn, &clen)) {
+			/* TODO: zero=true? */
+			err = attr_data_get_block_locked(ni, vcn, clen, &lcn,
+							 &alen, &new, true,
+							 NULL, true);
+			if (err)
+				break;
+			if (!new) {
+				err = -EINVAL;
+				break;
+			}
+		}
+	} else {
+		/*
+		 * Normal file allocates clusters in 'attr_set_size'
+		 */
+		err = attr_set_size_ex(ni, ATTR_DATA, NULL, 0, &ni->file.run,
+				       ni->vfs_inode.i_size, &ni->i_valid,
+				       false, NULL, true);
+	}
+
+	return err;
+}
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 2ef500f1a9fa..5f44e91d7997 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -445,36 +445,59 @@ int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
 }
 
 /*
- * ntfs_check_for_free_space
+ * ntfs_check_free_space
  *
  * Check if it is possible to allocate 'clen' clusters and 'mlen' Mft records
  */
-bool ntfs_check_for_free_space(struct ntfs_sb_info *sbi, CLST clen, CLST mlen)
+bool ntfs_check_free_space(struct ntfs_sb_info *sbi, CLST clen, CLST mlen,
+			   bool da)
 {
 	size_t free, zlen, avail;
 	struct wnd_bitmap *wnd;
+	CLST da_clusters = ntfs_get_da(sbi);
 
 	wnd = &sbi->used.bitmap;
 	down_read_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
 	free = wnd_zeroes(wnd);
+
+	if (free >= da_clusters) {
+		free -= da_clusters;
+	} else {
+		free = 0;
+	}
+
 	zlen = min_t(size_t, NTFS_MIN_MFT_ZONE, wnd_zone_len(wnd));
 	up_read(&wnd->rw_lock);
 
-	if (free < zlen + clen)
+	if (free < zlen + clen) {
 		return false;
+	}
 
 	avail = free - (zlen + clen);
 
-	wnd = &sbi->mft.bitmap;
-	down_read_nested(&wnd->rw_lock, BITMAP_MUTEX_MFT);
-	free = wnd_zeroes(wnd);
-	zlen = wnd_zone_len(wnd);
-	up_read(&wnd->rw_lock);
+	/* 
+	 * When delalloc is active then keep in mind some reserved space.
+	 * The worst case: 1 mft record per each ~500 clusters.
+	 */
+	if (da) {
+		/* 1 mft record per each 1024 clusters. */
+		mlen += da_clusters >> 10;
+	}
+
+	if (mlen || !avail) {
+		wnd = &sbi->mft.bitmap;
+		down_read_nested(&wnd->rw_lock, BITMAP_MUTEX_MFT);
+		free = wnd_zeroes(wnd);
+		zlen = wnd_zone_len(wnd);
+		up_read(&wnd->rw_lock);
 
-	if (free >= zlen + mlen)
-		return true;
+		if (free < zlen + mlen &&
+		    avail < bytes_to_cluster(sbi, mlen << sbi->record_bits)) {
+			return false;
+		}
+	}
 
-	return avail >= bytes_to_cluster(sbi, mlen << sbi->record_bits);
+	return true;
 }
 
 /*
@@ -509,8 +532,8 @@ static int ntfs_extend_mft(struct ntfs_sb_info *sbi)
 
 	/* Step 1: Resize $MFT::DATA. */
 	down_write(&ni->file.run_lock);
-	err = attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run,
-			    new_mft_bytes, NULL, false, &attr);
+	err = attr_set_size_ex(ni, ATTR_DATA, NULL, 0, &ni->file.run,
+			       new_mft_bytes, NULL, false, &attr, false);
 
 	if (err) {
 		up_write(&ni->file.run_lock);
@@ -525,7 +548,7 @@ static int ntfs_extend_mft(struct ntfs_sb_info *sbi)
 	new_bitmap_bytes = ntfs3_bitmap_size(new_mft_total);
 
 	err = attr_set_size(ni, ATTR_BITMAP, NULL, 0, &sbi->mft.bitmap.run,
-			    new_bitmap_bytes, &new_bitmap_bytes, true, NULL);
+			    new_bitmap_bytes, &new_bitmap_bytes, true);
 
 	/* Refresh MFT Zone if necessary. */
 	down_write_nested(&sbi->used.bitmap.rw_lock, BITMAP_MUTEX_CLUSTERS);
@@ -2191,7 +2214,7 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
 	if (new_sds_size > ni->vfs_inode.i_size) {
 		err = attr_set_size(ni, ATTR_DATA, SDS_NAME,
 				    ARRAY_SIZE(SDS_NAME), &ni->file.run,
-				    new_sds_size, &new_sds_size, false, NULL);
+				    new_sds_size, &new_sds_size, false);
 		if (err)
 			goto out;
 	}
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index d08bee3c20fa..2416c61050f1 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1446,8 +1446,8 @@ static int indx_create_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 
 	run_init(&run);
 
-	err = attr_allocate_clusters(sbi, &run, 0, 0, len, NULL, ALLOCATE_DEF,
-				     &alen, 0, NULL, NULL);
+	err = attr_allocate_clusters(sbi, &run, NULL, 0, 0, len, NULL,
+				     ALLOCATE_DEF, &alen, 0, NULL, NULL);
 	if (err)
 		goto out;
 
@@ -1531,8 +1531,7 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 		/* Increase bitmap. */
 		err = attr_set_size(ni, ATTR_BITMAP, in->name, in->name_len,
 				    &indx->bitmap_run,
-				    ntfs3_bitmap_size(bit + 1), NULL, true,
-				    NULL);
+				    ntfs3_bitmap_size(bit + 1), NULL, true);
 		if (err)
 			goto out1;
 	}
@@ -1553,8 +1552,7 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 
 	/* Increase allocation. */
 	err = attr_set_size(ni, ATTR_ALLOC, in->name, in->name_len,
-			    &indx->alloc_run, data_size, &data_size, true,
-			    NULL);
+			    &indx->alloc_run, data_size, &data_size, true);
 	if (err) {
 		if (bmp)
 			goto out2;
@@ -1572,7 +1570,7 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 out2:
 	/* Ops. No space? */
 	attr_set_size(ni, ATTR_BITMAP, in->name, in->name_len,
-		      &indx->bitmap_run, bmp_size, &bmp_size_v, false, NULL);
+		      &indx->bitmap_run, bmp_size, &bmp_size_v, false);
 
 out1:
 	return err;
@@ -2106,7 +2104,7 @@ static int indx_shrink(struct ntfs_index *indx, struct ntfs_inode *ni,
 	new_data = (u64)bit << indx->index_bits;
 
 	err = attr_set_size(ni, ATTR_ALLOC, in->name, in->name_len,
-			    &indx->alloc_run, new_data, &new_data, false, NULL);
+			    &indx->alloc_run, new_data, &new_data, false);
 	if (err)
 		return err;
 
@@ -2118,7 +2116,7 @@ static int indx_shrink(struct ntfs_index *indx, struct ntfs_inode *ni,
 		return 0;
 
 	err = attr_set_size(ni, ATTR_BITMAP, in->name, in->name_len,
-			    &indx->bitmap_run, bpb, &bpb, false, NULL);
+			    &indx->bitmap_run, bpb, &bpb, false);
 
 	return err;
 }
@@ -2333,6 +2331,7 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 		hdr = &root->ihdr;
 		e = fnd->root_de;
 		n = NULL;
+		ib = NULL;
 	}
 
 	e_size = le16_to_cpu(e->size);
@@ -2355,7 +2354,7 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 		 * Check to see if removing that entry made
 		 * the leaf empty.
 		 */
-		if (ib_is_leaf(ib) && ib_is_empty(ib)) {
+		if (ib && ib_is_leaf(ib) && ib_is_empty(ib)) {
 			fnd_pop(fnd);
 			fnd_push(fnd2, n, e);
 		}
@@ -2603,7 +2602,7 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 		in = &s_index_names[indx->type];
 
 		err = attr_set_size(ni, ATTR_ALLOC, in->name, in->name_len,
-				    &indx->alloc_run, 0, NULL, false, NULL);
+				    &indx->alloc_run, 0, NULL, false);
 		if (in->name == I30_NAME)
 			i_size_write(&ni->vfs_inode, 0);
 
@@ -2612,7 +2611,7 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 		run_close(&indx->alloc_run);
 
 		err = attr_set_size(ni, ATTR_BITMAP, in->name, in->name_len,
-				    &indx->bitmap_run, 0, NULL, false, NULL);
+				    &indx->bitmap_run, 0, NULL, false);
 		err = ni_remove_attr(ni, ATTR_BITMAP, in->name, in->name_len,
 				     false, NULL);
 		run_close(&indx->bitmap_run);
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 2147fce8e0b2..aca774f1aed1 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -40,7 +40,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	u32 rp_fa = 0, asize, t32;
 	u16 roff, rsize, names = 0, links = 0;
 	const struct ATTR_FILE_NAME *fname = NULL;
-	const struct INDEX_ROOT *root;
+	const struct INDEX_ROOT *root = NULL;
 	struct REPARSE_DATA_BUFFER rp; // 0x18 bytes
 	u64 t64;
 	struct MFT_REC *rec;
@@ -556,6 +556,25 @@ struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
 
 static sector_t ntfs_bmap(struct address_space *mapping, sector_t block)
 {
+	struct inode *inode = mapping->host;
+	struct ntfs_inode *ni = ntfs_i(inode);
+
+	/*
+	 * We can get here for an inline file via the FIBMAP ioctl
+	 */
+	if (is_resident(ni))
+		return 0;
+
+	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) &&
+	    !run_is_empty(&ni->file.run_da)) {
+		/*
+		 * With delalloc data we want to sync the file so
+		 * that we can make sure we allocate blocks for file and data
+		 * is in place for the user to see it
+		 */
+		ni_allocate_da_blocks(ni);
+	}
+
 	return iomap_bmap(mapping, block, &ntfs_iomap_ops);
 }
 
@@ -722,7 +741,7 @@ int ntfs_set_size(struct inode *inode, u64 new_size)
 	down_write(&ni->file.run_lock);
 
 	err = attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run, new_size,
-			    &ni->i_valid, true, NULL);
+			    &ni->i_valid, true);
 
 	if (!err) {
 		i_size_write(inode, new_size);
@@ -735,6 +754,10 @@ int ntfs_set_size(struct inode *inode, u64 new_size)
 	return err;
 }
 
+/*
+ * Special value to detect ntfs_writeback_range call
+ */
+#define WB_NO_DA (struct iomap *)1
 /*
  * Function to get mapping vbo -> lbo.
  * used with:
@@ -760,22 +783,40 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	loff_t endbyte = offset + length;
 	void *res = NULL;
 	int err;
-	CLST lcn, clen, clen_max;
+	CLST lcn, clen, clen_max = 1;
 	bool new_clst = false;
+	bool no_da;
+	bool zero = false;
 	if (unlikely(ntfs3_forced_shutdown(sbi->sb)))
 		return -EIO;
 
-	if ((flags & IOMAP_REPORT) && offset > ntfs_get_maxbytes(ni)) {
-		/* called from fiemap/bmap. */
-		return -EINVAL;
+	if (flags & IOMAP_REPORT) {
+		if (offset > ntfs_get_maxbytes(ni)) {
+			/* called from fiemap/bmap. */
+			return -EINVAL;
+		}
+
+		if (offset >= inode->i_size) {
+			/* special code for report. */
+			return -ENOENT;
+		}
 	}
 
-	clen_max = rw ? (bytes_to_cluster(sbi, endbyte) - vcn) : 1;
+	if (IOMAP_ZERO == flags && (endbyte & sbi->cluster_mask)) {
+		rw = true;
+	} else if (rw) {
+		clen_max = bytes_to_cluster(sbi, endbyte) - vcn;
+	}
 
-	err = attr_data_get_block(
-		ni, vcn, clen_max, &lcn, &clen, rw ? &new_clst : NULL,
-		flags == IOMAP_WRITE && (off || (endbyte & sbi->cluster_mask)),
-		&res);
+	/* 
+	 * Force to allocate clusters if directIO(write) or writeback_range.
+	 * NOTE: attr_data_get_block allocates clusters only for sparse file.
+	 * Normal file allocates clusters in attr_set_size.
+	*/
+	no_da = flags == (IOMAP_DIRECT | IOMAP_WRITE) || srcmap == WB_NO_DA;
+
+	err = attr_data_get_block(ni, vcn, clen_max, &lcn, &clen,
+				  rw ? &new_clst : NULL, zero, &res, no_da);
 
 	if (err) {
 		return err;
@@ -795,6 +836,8 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		lcn = SPARSE_LCN;
 	}
 
+	iomap->flags = new_clst ? IOMAP_F_NEW : 0;
+
 	if (lcn == RESIDENT_LCN) {
 		if (offset >= clen) {
 			kfree(res);
@@ -809,7 +852,6 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->type = IOMAP_INLINE;
 		iomap->offset = 0;
 		iomap->length = clen; /* resident size in bytes. */
-		iomap->flags = 0;
 		return 0;
 	}
 
@@ -818,42 +860,52 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		return -EINVAL;
 	}
 
+	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->offset = offset;
+	iomap->length = ((loff_t)clen << cluster_bits) - off;
+
 	if (lcn == COMPRESSED_LCN) {
 		/* should never be here. */
 		return -EOPNOTSUPP;
 	}
 
-	iomap->flags = new_clst ? IOMAP_F_NEW : 0;
-	iomap->bdev = inode->i_sb->s_bdev;
-
-	/* Translate clusters into bytes. */
-	iomap->offset = offset;
-	iomap->addr = ((loff_t)lcn << cluster_bits) + off;
-	iomap->length = ((loff_t)clen << cluster_bits) - off;
-	if (length && iomap->length > length)
-		iomap->length = length;
-	else
-		endbyte = offset + iomap->length;
-
-	if (lcn == SPARSE_LCN) {
+	if (lcn == DELALLOC_LCN) {
+		iomap->type = IOMAP_DELALLOC;
 		iomap->addr = IOMAP_NULL_ADDR;
-		iomap->type = IOMAP_HOLE;
-	} else if (endbyte <= ni->i_valid) {
-		iomap->type = IOMAP_MAPPED;
-	} else if (offset < ni->i_valid) {
-		iomap->type = IOMAP_MAPPED;
-		if (flags & IOMAP_REPORT)
-			iomap->length = ni->i_valid - offset;
-	} else if (rw || (flags & IOMAP_ZERO)) {
-		iomap->type = IOMAP_MAPPED;
 	} else {
-		iomap->type = IOMAP_UNWRITTEN;
+
+		/* Translate clusters into bytes. */
+		iomap->addr = ((loff_t)lcn << cluster_bits) + off;
+		if (length && iomap->length > length)
+			iomap->length = length;
+		else
+			endbyte = offset + iomap->length;
+
+		if (lcn == SPARSE_LCN) {
+			iomap->addr = IOMAP_NULL_ADDR;
+			iomap->type = IOMAP_HOLE;
+			//			if (IOMAP_ZERO == flags && !off) {
+			//				iomap->length = (endbyte - offset) &
+			//						sbi->cluster_mask_inv;
+			//			}
+		} else if (endbyte <= ni->i_valid) {
+			iomap->type = IOMAP_MAPPED;
+		} else if (offset < ni->i_valid) {
+			iomap->type = IOMAP_MAPPED;
+			if (flags & IOMAP_REPORT)
+				iomap->length = ni->i_valid - offset;
+		} else if (rw || (flags & IOMAP_ZERO)) {
+			iomap->type = IOMAP_MAPPED;
+		} else {
+			iomap->type = IOMAP_UNWRITTEN;
+		}
 	}
 
-	if ((flags & IOMAP_ZERO) && iomap->type == IOMAP_MAPPED) {
+	if ((flags & IOMAP_ZERO) &&
+	    (iomap->type == IOMAP_MAPPED || iomap->type == IOMAP_DELALLOC)) {
 		/* Avoid too large requests. */
 		u32 tail;
-		u32 off_a = iomap->addr & (PAGE_SIZE - 1);
+		u32 off_a = offset & (PAGE_SIZE - 1);
 		if (off_a)
 			tail = PAGE_SIZE - off_a;
 		else
@@ -904,7 +956,9 @@ static int ntfs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		}
 	}
 
-	if ((flags & IOMAP_ZERO) && iomap->type == IOMAP_MAPPED) {
+	if ((flags & IOMAP_ZERO) &&
+	    (iomap->type == IOMAP_MAPPED || iomap->type == IOMAP_DELALLOC)) {
+		/* Pair for code in ntfs_iomap_begin. */
 		balance_dirty_pages_ratelimited(inode->i_mapping);
 		cond_resched();
 	}
@@ -933,7 +987,7 @@ static void ntfs_iomap_put_folio(struct inode *inode, loff_t pos,
 	loff_t f_pos = folio_pos(folio);
 	loff_t f_end = f_pos + f_size;
 
-	if (ni->i_valid < end && end < f_end) {
+	if (ni->i_valid <= end && end < f_end) {
 		/* zero range [end - f_end). */
 		/* The only thing ntfs_iomap_put_folio used for. */
 		folio_zero_segment(folio, offset_in_folio(folio, end), f_size);
@@ -942,23 +996,31 @@ static void ntfs_iomap_put_folio(struct inode *inode, loff_t pos,
 	folio_put(folio);
 }
 
+/*
+ * iomap_writeback_ops::writeback_range
+ */
 static ssize_t ntfs_writeback_range(struct iomap_writepage_ctx *wpc,
 				    struct folio *folio, u64 offset,
 				    unsigned int len, u64 end_pos)
 {
 	struct iomap *iomap = &wpc->iomap;
-	struct inode *inode = wpc->inode;
-
 	/* Check iomap position. */
-	if (!(iomap->offset <= offset &&
-	      offset < iomap->offset + iomap->length)) {
+	if (iomap->offset + iomap->length <= offset || offset < iomap->offset) {
 		int err;
+		struct inode *inode = wpc->inode;
+		struct ntfs_inode *ni = ntfs_i(inode);
 		struct ntfs_sb_info *sbi = ntfs_sb(inode->i_sb);
 		loff_t i_size_up = ntfs_up_cluster(sbi, inode->i_size);
 		loff_t len_max = i_size_up - offset;
 
-		err = ntfs_iomap_begin(inode, offset, len_max, IOMAP_WRITE,
-				       iomap, NULL);
+		err = ni->file.run_da.count ? ni_allocate_da_blocks(ni) : 0;
+
+		if (!err) {
+			/* Use local special value 'WB_NO_DA' to disable delalloc. */
+			err = ntfs_iomap_begin(inode, offset, len_max,
+					       IOMAP_WRITE, iomap, WB_NO_DA);
+		}
+
 		if (err) {
 			ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
 			return err;
@@ -1532,9 +1594,10 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 			attr->nres.alloc_size =
 				cpu_to_le64(ntfs_up_cluster(sbi, nsize));
 
-			err = attr_allocate_clusters(sbi, &ni->file.run, 0, 0,
-						     clst, NULL, ALLOCATE_DEF,
-						     &alen, 0, NULL, NULL);
+			err = attr_allocate_clusters(sbi, &ni->file.run, NULL,
+						     0, 0, clst, NULL,
+						     ALLOCATE_DEF, &alen, 0,
+						     NULL, NULL);
 			if (err)
 				goto out5;
 
@@ -1675,7 +1738,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		/* Delete ATTR_EA, if non-resident. */
 		struct runs_tree run;
 		run_init(&run);
-		attr_set_size(ni, ATTR_EA, NULL, 0, &run, 0, NULL, false, NULL);
+		attr_set_size(ni, ATTR_EA, NULL, 0, &run, 0, NULL, false);
 		run_close(&run);
 	}
 
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index ae0a6ba102c0..892f13e65d42 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -77,11 +77,14 @@ static_assert(sizeof(size_t) == 8);
 typedef u32 CLST;
 #endif
 
+/* On-disk sparsed cluster is marked as -1. */
 #define SPARSE_LCN64   ((u64)-1)
 #define SPARSE_LCN     ((CLST)-1)
+/* Below is virtual (not on-disk) values. */
 #define RESIDENT_LCN   ((CLST)-2)
 #define COMPRESSED_LCN ((CLST)-3)
 #define EOF_LCN       ((CLST)-4)
+#define DELALLOC_LCN   ((CLST)-5)
 
 enum RECORD_NUM {
 	MFT_REC_MFT		= 0,
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index b7017dd4d7cd..a705923de75e 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -108,6 +108,7 @@ struct ntfs_mount_options {
 	unsigned force : 1; /* RW mount dirty volume. */
 	unsigned prealloc : 1; /* Preallocate space when file is growing. */
 	unsigned nocase : 1; /* case insensitive. */
+	unsigned delalloc : 1; /* delay allocation. */
 };
 
 /* Special value to unpack and deallocate. */
@@ -132,7 +133,8 @@ struct ntfs_buffers {
 enum ALLOCATE_OPT {
 	ALLOCATE_DEF = 0, // Allocate all clusters.
 	ALLOCATE_MFT = 1, // Allocate for MFT.
-	ALLOCATE_ZERO = 2, // Zeroout new allocated clusters
+	ALLOCATE_ZERO = 2, // Zeroout new allocated clusters.
+	ALLOCATE_ONE_FR = 4, // Allocate one fragment only.
 };
 
 enum bitmap_mutex_classes {
@@ -213,7 +215,7 @@ struct ntfs_sb_info {
 
 	u32 discard_granularity;
 	u64 discard_granularity_mask_inv; // ~(discard_granularity_mask_inv-1)
-	u32 bdev_blocksize_mask; // bdev_logical_block_size(bdev) - 1;
+	u32 bdev_blocksize; // bdev_logical_block_size(bdev)
 
 	u32 cluster_size; // bytes per cluster
 	u32 cluster_mask; // == cluster_size - 1
@@ -272,6 +274,12 @@ struct ntfs_sb_info {
 	struct {
 		struct wnd_bitmap bitmap; // $Bitmap::Data
 		CLST next_free_lcn;
+		/* Total sum of delay allocated clusters in all files. */
+#ifdef CONFIG_NTFS3_64BIT_CLUSTER
+		atomic64_t da;
+#else
+		atomic_t da;
+#endif
 	} used;
 
 	struct {
@@ -379,7 +387,7 @@ struct ntfs_inode {
 	 */
 	u8 mi_loaded;
 
-	/* 
+	/*
 	 * Use this field to avoid any write(s).
 	 * If inode is bad during initialization - use make_bad_inode
 	 * If inode is bad during operations - use this field
@@ -390,7 +398,14 @@ struct ntfs_inode {
 		struct ntfs_index dir;
 		struct {
 			struct rw_semaphore run_lock;
+			/* Unpacked runs from just one record. */
 			struct runs_tree run;
+			/* 
+			 * Pairs [vcn, len] for all delay allocated clusters.
+			 * Normal file always contains delayed clusters in one fragment.
+			 * TODO: use 2 CLST per pair instead of 3.
+			 */
+			struct runs_tree run_da;
 #ifdef CONFIG_NTFS3_LZX_XPRESS
 			struct folio *offs_folio;
 #endif
@@ -430,19 +445,32 @@ enum REPARSE_SIGN {
 
 /* Functions from attrib.c */
 int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
-			   CLST vcn, CLST lcn, CLST len, CLST *pre_alloc,
-			   enum ALLOCATE_OPT opt, CLST *alen, const size_t fr,
-			   CLST *new_lcn, CLST *new_len);
+			   struct runs_tree *run_da, CLST vcn, CLST lcn,
+			   CLST len, CLST *pre_alloc, enum ALLOCATE_OPT opt,
+			   CLST *alen, const size_t fr, CLST *new_lcn,
+			   CLST *new_len);
 int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 			  struct ATTR_LIST_ENTRY *le, struct mft_inode *mi,
 			  u64 new_size, struct runs_tree *run,
 			  struct ATTRIB **ins_attr, struct page *page);
-int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
-		  const __le16 *name, u8 name_len, struct runs_tree *run,
-		  u64 new_size, const u64 *new_valid, bool keep_prealloc,
-		  struct ATTRIB **ret);
+int attr_set_size_ex(struct ntfs_inode *ni, enum ATTR_TYPE type,
+		     const __le16 *name, u8 name_len, struct runs_tree *run,
+		     u64 new_size, const u64 *new_valid, bool keep_prealloc,
+		     struct ATTRIB **ret, bool no_da);
+static inline int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
+				const __le16 *name, u8 name_len,
+				struct runs_tree *run, u64 new_size,
+				const u64 *new_valid, bool keep_prealloc)
+{
+	return attr_set_size_ex(ni, type, name, name_len, run, new_size,
+				new_valid, keep_prealloc, NULL, false);
+}
 int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
-			CLST *len, bool *new, bool zero, void **res);
+			CLST *len, bool *new, bool zero, void **res,
+			bool no_da);
+int attr_data_get_block_locked(struct ntfs_inode *ni, CLST vcn, CLST clen,
+			       CLST *lcn, CLST *len, bool *new, bool zero,
+			       void **res, bool no_da);
 int attr_data_write_resident(struct ntfs_inode *ni, struct folio *folio);
 int attr_load_runs_vcn(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		       const __le16 *name, u8 name_len, struct runs_tree *run,
@@ -590,6 +618,8 @@ int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
 bool ni_is_dirty(struct inode *inode);
 loff_t ni_seek_data_or_hole(struct ntfs_inode *ni, loff_t offset, bool data);
 int ni_write_parents(struct ntfs_inode *ni, int sync);
+int ni_allocate_da_blocks(struct ntfs_inode *ni);
+int ni_allocate_da_blocks_locked(struct ntfs_inode *ni);
 
 /* Globals from fslog.c */
 bool check_index_header(const struct INDEX_HDR *hdr, size_t bytes);
@@ -605,7 +635,8 @@ int ntfs_loadlog_and_replay(struct ntfs_inode *ni, struct ntfs_sb_info *sbi);
 int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
 			     CLST *new_lcn, CLST *new_len,
 			     enum ALLOCATE_OPT opt);
-bool ntfs_check_for_free_space(struct ntfs_sb_info *sbi, CLST clen, CLST mlen);
+bool ntfs_check_free_space(struct ntfs_sb_info *sbi, CLST clen, CLST mlen,
+			   bool da);
 int ntfs_look_free_mft(struct ntfs_sb_info *sbi, CLST *rno, bool mft,
 		       struct ntfs_inode *ni, struct mft_inode **mi);
 void ntfs_mark_rec_free(struct ntfs_sb_info *sbi, CLST rno, bool is_mft);
@@ -831,7 +862,8 @@ void run_truncate_around(struct runs_tree *run, CLST vcn);
 bool run_add_entry(struct runs_tree *run, CLST vcn, CLST lcn, CLST len,
 		   bool is_mft);
 bool run_collapse_range(struct runs_tree *run, CLST vcn, CLST len, CLST sub);
-bool run_insert_range(struct runs_tree *run, CLST vcn, CLST len);
+int run_insert_range(struct runs_tree *run, CLST vcn, CLST len);
+int run_insert_range_da(struct runs_tree *run, CLST vcn, CLST len);
 bool run_get_entry(const struct runs_tree *run, size_t index, CLST *vcn,
 		   CLST *lcn, CLST *len);
 bool run_is_mapped_full(const struct runs_tree *run, CLST svcn, CLST evcn);
@@ -851,6 +883,9 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 #endif
 int run_get_highest_vcn(CLST vcn, const u8 *run_buf, u64 *highest_vcn);
 int run_clone(const struct runs_tree *run, struct runs_tree *new_run);
+bool run_remove_range(struct runs_tree *run, CLST vcn, CLST len, CLST *done);
+CLST run_len(const struct runs_tree *run);
+CLST run_get_max_vcn(const struct runs_tree *run);
 
 /* Globals from super.c */
 void *ntfs_set_shared(void *ptr, u32 bytes);
@@ -1027,6 +1062,36 @@ static inline int ntfs3_forced_shutdown(struct super_block *sb)
 	return test_bit(NTFS_FLAGS_SHUTDOWN_BIT, &ntfs_sb(sb)->flags);
 }
 
+/* Returns total sum of delay allocated clusters in all files. */
+static inline CLST ntfs_get_da(struct ntfs_sb_info *sbi)
+{
+#ifdef CONFIG_NTFS3_64BIT_CLUSTER
+	return atomic64_read(&sbi->used.da);
+#else
+	return atomic_read(&sbi->used.da);
+#endif
+}
+
+/* Update total count of delay allocated clusters. */
+static inline void ntfs_add_da(struct ntfs_sb_info *sbi, CLST da)
+{
+#ifdef CONFIG_NTFS3_64BIT_CLUSTER
+	atomic64_add(da, &sbi->used.da);
+#else
+	atomic_add(da, &sbi->used.da);
+#endif
+}
+
+/* Update total count of delay allocated clusters. */
+static inline void ntfs_sub_da(struct ntfs_sb_info *sbi, CLST da)
+{
+#ifdef CONFIG_NTFS3_64BIT_CLUSTER
+	atomic64_sub(da, &sbi->used.da);
+#else
+	atomic_sub(da, &sbi->used.da);
+#endif
+}
+
 /*
  * ntfs_up_cluster - Align up on cluster boundary.
  */
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index dc59cad4fa37..c0324cdc174d 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -454,7 +454,7 @@ bool run_add_entry(struct runs_tree *run, CLST vcn, CLST lcn, CLST len,
 
 		/*
 		 * If existing range fits then were done.
-		 * Otherwise extend found one and fall back to range jocode.
+		 * Otherwise extend found one and fall back to range join code.
 		 */
 		if (r->vcn + r->len < vcn + len)
 			r->len += len - ((r->vcn + r->len) - vcn);
@@ -482,7 +482,8 @@ bool run_add_entry(struct runs_tree *run, CLST vcn, CLST lcn, CLST len,
 	return true;
 }
 
-/* run_collapse_range
+/*
+ * run_collapse_range
  *
  * Helper for attr_collapse_range(),
  * which is helper for fallocate(collapse_range).
@@ -493,8 +494,9 @@ bool run_collapse_range(struct runs_tree *run, CLST vcn, CLST len, CLST sub)
 	struct ntfs_run *r, *e, *eat_start, *eat_end;
 	CLST end;
 
-	if (WARN_ON(!run_lookup(run, vcn, &index)))
-		return true; /* Should never be here. */
+	if (!run_lookup(run, vcn, &index) && index >= run->count) {
+		return true;
+	}
 
 	e = run->runs + run->count;
 	r = run->runs + index;
@@ -560,13 +562,13 @@ bool run_collapse_range(struct runs_tree *run, CLST vcn, CLST len, CLST sub)
  * Helper for attr_insert_range(),
  * which is helper for fallocate(insert_range).
  */
-bool run_insert_range(struct runs_tree *run, CLST vcn, CLST len)
+int run_insert_range(struct runs_tree *run, CLST vcn, CLST len)
 {
 	size_t index;
 	struct ntfs_run *r, *e;
 
 	if (WARN_ON(!run_lookup(run, vcn, &index)))
-		return false; /* Should never be here. */
+		return -EINVAL; /* Should never be here. */
 
 	e = run->runs + run->count;
 	r = run->runs + index;
@@ -588,13 +590,49 @@ bool run_insert_range(struct runs_tree *run, CLST vcn, CLST len)
 		r->len = len1;
 
 		if (!run_add_entry(run, vcn + len, lcn2, len2, false))
-			return false;
+			return -ENOMEM;
 	}
 
 	if (!run_add_entry(run, vcn, SPARSE_LCN, len, false))
-		return false;
+		return -ENOMEM;
 
-	return true;
+	return 0;
+}
+
+/* run_insert_range_da
+ *
+ * Helper for attr_insert_range(),
+ * which is helper for fallocate(insert_range).
+ */
+int run_insert_range_da(struct runs_tree *run, CLST vcn, CLST len)
+{
+	struct ntfs_run *r, *r0 = NULL, *e = run->runs + run->count;
+	;
+
+	for (r = run->runs; r < e; r++) {
+		CLST end = r->vcn + r->len;
+
+		if (vcn >= end)
+			continue;
+
+		if (!r0 && r->vcn < vcn) {
+			r0 = r;
+		} else {
+			r->vcn += len;
+		}
+	}
+
+	if (r0) {
+		/* split fragment. */
+		CLST len1 = vcn - r0->vcn;
+		CLST len2 = r0->len - len1;
+
+		r0->len = len1;
+		if (!run_add_entry(run, vcn + len, SPARSE_LCN, len2, false))
+			return -ENOMEM;
+	}
+
+	return 0;
 }
 
 /*
@@ -1209,3 +1247,97 @@ int run_clone(const struct runs_tree *run, struct runs_tree *new_run)
 	new_run->count = run->count;
 	return 0;
 }
+
+/*
+ * run_remove_range
+ *
+ */
+bool run_remove_range(struct runs_tree *run, CLST vcn, CLST len, CLST *done)
+{
+	size_t index, eat;
+	struct ntfs_run *r, *e, *eat_start, *eat_end;
+	CLST end, d;
+
+	*done = 0;
+
+	/* Fast check. */
+	if (!run->count)
+		return true;
+
+	if (!run_lookup(run, vcn, &index) && index >= run->count) {
+		/* No entries in this run. */
+		return true;
+	}
+
+
+	e = run->runs + run->count;
+	r = run->runs + index;
+	end = vcn + len;
+
+	if (vcn > r->vcn) {
+		CLST r_end = r->vcn + r->len;
+		d = vcn - r->vcn;
+
+		if (r_end > end) {
+			/* Remove a middle part, split. */
+			*done += len;
+			r->len = d;
+			return run_add_entry(run, end, r->lcn, r_end - end,
+					     false);
+		}
+		/* Remove tail of run .*/
+		*done += r->len - d;
+		r->len = d;
+		r += 1;
+	}
+
+	eat_start = r;
+	eat_end = r;
+
+	for (; r < e; r++) {
+		if (r->vcn >= end)
+			continue;
+
+		if (r->vcn + r->len <= end) {
+			/* Eat this run. */
+			*done += r->len;
+			eat_end = r + 1;
+			continue;
+		}
+
+		d = end - r->vcn;
+		*done += d;
+		if (r->lcn != SPARSE_LCN)
+			r->lcn += d;
+		r->len -= d;
+		r->vcn = end;
+	}
+
+	eat = eat_end - eat_start;
+	memmove(eat_start, eat_end, (e - eat_end) * sizeof(*r));
+	run->count -= eat;
+
+	return true;
+}
+
+CLST run_len(const struct runs_tree *run)
+{
+	const struct ntfs_run *r, *e;
+	CLST len = 0;
+
+	for (r = run->runs, e = r + run->count; r < e; r++) {
+		len += r->len;
+	}
+
+	return len;
+}
+
+CLST run_get_max_vcn(const struct runs_tree *run)
+{
+	const struct ntfs_run *r;
+	if (!run->count)
+		return 0;
+
+	r = run->runs + run->count - 1;
+	return r->vcn + r->len;
+}
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index a3c07f2b604f..27411203082a 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -269,6 +269,8 @@ enum Opt {
 	Opt_prealloc,
 	Opt_prealloc_bool,
 	Opt_nocase,
+	Opt_delalloc,
+	Opt_delalloc_bool,
 	Opt_err,
 };
 
@@ -293,6 +295,8 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
 	fsparam_flag("prealloc",	Opt_prealloc),
 	fsparam_bool("prealloc",	Opt_prealloc_bool),
 	fsparam_flag("nocase",		Opt_nocase),
+	fsparam_flag("delalloc",	Opt_delalloc),
+	fsparam_bool("delalloc",	Opt_delalloc_bool),
 	{}
 };
 // clang-format on
@@ -410,6 +414,12 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 	case Opt_nocase:
 		opts->nocase = 1;
 		break;
+	case Opt_delalloc:
+		opts->delalloc = 1;
+		break;
+	case Opt_delalloc_bool:
+		opts->delalloc = result.boolean;
+		break;
 	default:
 		/* Should not be here unless we forget add case. */
 		return -EINVAL;
@@ -726,14 +736,22 @@ static int ntfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct super_block *sb = dentry->d_sb;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	struct wnd_bitmap *wnd = &sbi->used.bitmap;
+	CLST da_clusters = ntfs_get_da(sbi);
 
 	buf->f_type = sb->s_magic;
-	buf->f_bsize = sbi->cluster_size;
+	buf->f_bsize = buf->f_frsize = sbi->cluster_size;
 	buf->f_blocks = wnd->nbits;
 
-	buf->f_bfree = buf->f_bavail = wnd_zeroes(wnd);
+	buf->f_bfree = wnd_zeroes(wnd);
+	if (buf->f_bfree > da_clusters) {
+		buf->f_bfree -= da_clusters;
+	} else {
+		buf->f_bfree = 0;
+	}
+	buf->f_bavail = buf->f_bfree;
+
 	buf->f_fsid.val[0] = sbi->volume.ser_num;
-	buf->f_fsid.val[1] = (sbi->volume.ser_num >> 32);
+	buf->f_fsid.val[1] = sbi->volume.ser_num >> 32;
 	buf->f_namelen = NTFS_NAME_LEN;
 
 	return 0;
@@ -778,6 +796,8 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",prealloc");
 	if (opts->nocase)
 		seq_puts(m, ",nocase");
+	if (opts->delalloc)
+		seq_puts(m, ",delalloc");
 
 	return 0;
 }
@@ -1088,7 +1108,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 		dev_size += sector_size - 1;
 	}
 
-	sbi->bdev_blocksize_mask = max(boot_sector_size, sector_size) - 1;
+	sbi->bdev_blocksize = max(boot_sector_size, sector_size);
 	sbi->mft.lbo = mlcn << cluster_bits;
 	sbi->mft.lbo2 = mlcn2 << cluster_bits;
 
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index c93df55e98d0..2302539852ef 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -460,7 +460,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 
 	new_sz = size;
 	err = attr_set_size(ni, ATTR_EA, NULL, 0, &ea_run, new_sz, &new_sz,
-			    false, NULL);
+			    false);
 	if (err)
 		goto out;
 
-- 
2.43.0


