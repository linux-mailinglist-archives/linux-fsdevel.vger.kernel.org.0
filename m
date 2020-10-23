Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBD82972C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 17:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751101AbgJWPqm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 11:46:42 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:46858 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S463368AbgJWPon (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 11:44:43 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 00FB91D70;
        Fri, 23 Oct 2020 18:44:40 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1603467880;
        bh=16LFW0w+Mr0UJtkuOorUNLkD/DPXnNvgjFHJWTx6QmM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kpn3xO7jRF9RsCWgAl4e+43WCqjOC2frbTZ/aabJgnSMeLdMO9m2wLRzmvxQzGcCY
         8ZBTPAT/a/hTW+mzqldAp5jjMSQurMPpsCxTD71/W+n5N6y86nimTXxr0Z+od2cfah
         fN8BUAMRyEdWjo7vTrwsIoFx7z3UuFtq3wQW6F3Q=
Received: from fsd-lkpg.ufsd.paragon-software.com (172.30.114.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 23 Oct 2020 18:44:37 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>,
        <pali@kernel.org>, <dsterba@suse.cz>, <aaptel@suse.com>,
        <willy@infradead.org>, <rdunlap@infradead.org>, <joe@perches.com>,
        <mark@harmstone.com>, <nborisov@suse.com>,
        <linux-ntfs-dev@lists.sourceforge.net>, <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v10 05/10] fs/ntfs3: Add attrib operations
Date:   Fri, 23 Oct 2020 18:44:26 +0300
Message-ID: <20201023154431.1853715-6-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201023154431.1853715-1-almaz.alexandrovich@paragon-software.com>
References: <20201023154431.1853715-1-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.30.114.105]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds attrib operations

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c   | 1406 +++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/attrlist.c |  465 ++++++++++++++
 fs/ntfs3/xattr.c    | 1063 ++++++++++++++++++++++++++++++++
 3 files changed, 2934 insertions(+)
 create mode 100644 fs/ntfs3/attrib.c
 create mode 100644 fs/ntfs3/attrlist.c
 create mode 100644 fs/ntfs3/xattr.c

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
new file mode 100644
index 000000000000..1ea513fb41ad
--- /dev/null
+++ b/fs/ntfs3/attrib.c
@@ -0,0 +1,1406 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/attrib.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ * TODO: merge attr_set_size/attr_data_get_block/attr_allocate_frame?
+ */
+
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/fs.h>
+#include <linux/hash.h>
+#include <linux/nls.h>
+#include <linux/ratelimit.h>
+#include <linux/sched/signal.h>
+#include <linux/slab.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+/*
+ * You can set external NTFS_MIN_LOG2_OF_CLUMP/NTFS_MAX_LOG2_OF_CLUMP to manage
+ * preallocate algorithm
+ */
+#ifndef NTFS_MIN_LOG2_OF_CLUMP
+#define NTFS_MIN_LOG2_OF_CLUMP 16
+#endif
+
+#ifndef NTFS_MAX_LOG2_OF_CLUMP
+#define NTFS_MAX_LOG2_OF_CLUMP 26
+#endif
+
+// 16M
+#define NTFS_CLUMP_MIN (1 << (NTFS_MIN_LOG2_OF_CLUMP + 8))
+// 16G
+#define NTFS_CLUMP_MAX (1ull << (NTFS_MAX_LOG2_OF_CLUMP + 8))
+
+/*
+ * get_pre_allocated
+ *
+ */
+static inline u64 get_pre_allocated(u64 size)
+{
+	u32 clump;
+	u8 align_shift;
+	u64 ret;
+
+	if (size <= NTFS_CLUMP_MIN) {
+		clump = 1 << NTFS_MIN_LOG2_OF_CLUMP;
+		align_shift = NTFS_MIN_LOG2_OF_CLUMP;
+	} else if (size >= NTFS_CLUMP_MAX) {
+		clump = 1 << NTFS_MAX_LOG2_OF_CLUMP;
+		align_shift = NTFS_MAX_LOG2_OF_CLUMP;
+	} else {
+		align_shift = NTFS_MIN_LOG2_OF_CLUMP - 1 +
+			      __ffs(size >> (8 + NTFS_MIN_LOG2_OF_CLUMP));
+		clump = 1u << align_shift;
+	}
+
+	ret = (((size + clump - 1) >> align_shift)) << align_shift;
+
+	return ret;
+}
+
+/*
+ * attr_must_be_resident
+ *
+ * returns true if attribute must be resident
+ */
+static inline bool attr_must_be_resident(struct ntfs_sb_info *sbi,
+					 enum ATTR_TYPE type)
+{
+	const struct ATTR_DEF_ENTRY *de;
+
+	switch (type) {
+	case ATTR_STD:
+	case ATTR_NAME:
+	case ATTR_ID:
+	case ATTR_LABEL:
+	case ATTR_VOL_INFO:
+	case ATTR_ROOT:
+	case ATTR_EA_INFO:
+		return true;
+	default:
+		de = ntfs_query_def(sbi, type);
+		if (de && (de->flags & NTFS_ATTR_MUST_BE_RESIDENT))
+			return true;
+		return false;
+	}
+}
+
+/*
+ * attr_load_runs
+ *
+ * load all runs stored in 'attr'
+ */
+int attr_load_runs(struct ATTRIB *attr, struct ntfs_inode *ni,
+		   struct runs_tree *run, const CLST *vcn)
+{
+	int err;
+	CLST svcn = le64_to_cpu(attr->nres.svcn);
+	CLST evcn = le64_to_cpu(attr->nres.evcn);
+	u32 asize;
+	u16 run_off;
+
+	if (svcn >= evcn + 1 || run_is_mapped_full(run, svcn, evcn))
+		return 0;
+
+	if (vcn && (evcn < *vcn || *vcn < svcn))
+		return -EINVAL;
+
+	asize = le32_to_cpu(attr->size);
+	run_off = le16_to_cpu(attr->nres.run_off);
+	err = run_unpack_ex(run, ni->mi.sbi, ni->mi.rno, svcn, evcn,
+			    vcn ? *vcn : svcn, Add2Ptr(attr, run_off),
+			    asize - run_off);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+/*
+ * int run_deallocate_ex
+ *
+ * Deallocate clusters
+ */
+static int run_deallocate_ex(struct ntfs_sb_info *sbi, struct runs_tree *run,
+			     CLST vcn, CLST len, CLST *done, bool trim)
+{
+	int err = 0;
+	CLST vcn0 = vcn, lcn, clen, dn = 0;
+	size_t idx;
+
+	if (!len)
+		goto out;
+
+	if (!run_lookup_entry(run, vcn, &lcn, &clen, &idx)) {
+failed:
+		run_truncate(run, vcn0);
+		err = -EINVAL;
+		goto out;
+	}
+
+	for (;;) {
+		if (clen > len)
+			clen = len;
+
+		if (!clen) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (lcn != SPARSE_LCN) {
+			mark_as_free_ex(sbi, lcn, clen, trim);
+			dn += clen;
+		}
+
+		len -= clen;
+		if (!len)
+			break;
+
+		if (!run_get_entry(run, ++idx, &vcn, &lcn, &clen)) {
+			// save memory - don't load entire run
+			goto failed;
+		}
+	}
+
+out:
+	if (done)
+		*done = dn;
+
+	return err;
+}
+
+/*
+ * attr_allocate_clusters
+ *
+ * find free space, mark it as used and store in 'run'
+ */
+int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
+			   CLST vcn, CLST lcn, CLST len, CLST *pre_alloc,
+			   enum ALLOCATE_OPT opt, CLST *alen, const size_t fr,
+			   CLST *new_lcn)
+{
+	int err;
+	CLST flen, vcn0 = vcn, pre = pre_alloc ? *pre_alloc : 0;
+	struct wnd_bitmap *wnd = &sbi->used.bitmap;
+	size_t cnt = run->count;
+
+	for (;;) {
+		err = ntfs_look_for_free_space(sbi, lcn, len + pre, &lcn, &flen,
+					       opt);
+
+		if (err == -ENOSPC && pre) {
+			pre = 0;
+			if (*pre_alloc)
+				*pre_alloc = 0;
+			continue;
+		}
+
+		if (err)
+			goto out;
+
+		if (new_lcn && vcn == vcn0)
+			*new_lcn = lcn;
+
+		/* Add new fragment into run storage */
+		if (!run_add_entry(run, vcn, lcn, flen)) {
+			down_write_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
+			wnd_set_free(wnd, lcn, flen);
+			up_write(&wnd->rw_lock);
+			err = -ENOMEM;
+			goto out;
+		}
+
+		vcn += flen;
+
+		if (flen >= len || opt == ALLOCATE_MFT ||
+		    (fr && run->count - cnt >= fr)) {
+			*alen = vcn - vcn0;
+			return 0;
+		}
+
+		len -= flen;
+	}
+
+out:
+	/* undo */
+	run_deallocate_ex(sbi, run, vcn0, vcn - vcn0, NULL, false);
+	run_truncate(run, vcn0);
+
+	return err;
+}
+
+/*
+ * attr_set_size_res
+ *
+ * helper for attr_set_size
+ */
+static int attr_set_size_res(struct ntfs_inode *ni, struct ATTRIB *attr,
+			     struct ATTR_LIST_ENTRY *le, struct mft_inode *mi,
+			     u64 new_size, struct runs_tree *run,
+			     struct ATTRIB **ins_attr)
+{
+	int err = 0;
+	struct ntfs_sb_info *sbi = mi->sbi;
+	struct MFT_REC *rec = mi->mrec;
+	u32 used = le32_to_cpu(rec->used);
+	u32 asize = le32_to_cpu(attr->size);
+	u32 aoff = PtrOffset(rec, attr);
+	u32 rsize = le32_to_cpu(attr->res.data_size);
+	u32 tail = used - aoff - asize;
+	char *next = Add2Ptr(attr, asize);
+	int dsize = QuadAlign(new_size) - QuadAlign(rsize);
+	CLST len, alen;
+	struct ATTRIB *attr_s = NULL;
+	bool is_ext;
+
+	if (dsize < 0) {
+		memmove(next + dsize, next, tail);
+	} else if (dsize > 0) {
+		if (used + dsize > sbi->max_bytes_per_attr)
+			goto resident2nonresident;
+
+		memmove(next + dsize, next, tail);
+		memset(next, 0, dsize);
+	}
+
+	rec->used = cpu_to_le32(used + dsize);
+	attr->size = cpu_to_le32(asize + dsize);
+	attr->res.data_size = cpu_to_le32(new_size);
+	mi->dirty = true;
+	*ins_attr = attr;
+
+	return 0;
+
+resident2nonresident:
+	len = bytes_to_cluster(sbi, rsize);
+
+	run_init(run);
+
+	is_ext = is_attr_ext(attr);
+
+	if (!len) {
+		alen = 0;
+	} else if (is_ext) {
+		if (!run_add_entry(run, 0, SPARSE_LCN, len)) {
+			err = -ENOMEM;
+			goto out;
+		}
+		alen = len;
+	} else {
+		err = attr_allocate_clusters(sbi, run, 0, 0, len, NULL,
+					     ALLOCATE_DEF, &alen, 0, NULL);
+		if (err)
+			goto out;
+
+		err = ntfs_sb_write_run(sbi, run, 0, resident_data(attr),
+					rsize);
+		if (err)
+			goto out;
+	}
+
+	attr_s = ntfs_memdup(attr, asize);
+	if (!attr_s) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/*verify(mi_remove_attr(mi, attr));*/
+	used -= asize;
+	memmove(attr, Add2Ptr(attr, asize), used - aoff);
+	rec->used = cpu_to_le32(used);
+	mi->dirty = true;
+	if (le)
+		al_remove_le(ni, le);
+
+	err = ni_insert_nonresident(ni, attr_s->type, attr_name(attr_s),
+				    attr_s->name_len, run, 0, alen,
+				    attr_s->flags, &attr, NULL);
+	if (err)
+		goto out;
+
+	ntfs_free(attr_s);
+	attr->nres.data_size = cpu_to_le64(rsize);
+	attr->nres.valid_size = attr->nres.data_size;
+
+	*ins_attr = attr;
+
+	if (attr_s->type == ATTR_DATA && !attr_s->name_len &&
+	    run == &ni->file.run) {
+		ni->ni_flags &= ~NI_FLAG_RESIDENT;
+	}
+
+	/* Resident attribute becomes non resident */
+	return 0;
+
+out:
+	/* undo: do not trim new allocated clusters */
+	run_deallocate(sbi, run, false);
+	run_close(run);
+
+	if (attr_s) {
+		memmove(next, Add2Ptr(rec, aoff), used - aoff);
+		memcpy(Add2Ptr(rec, aoff), attr_s, asize);
+		rec->used = cpu_to_le32(used + asize);
+		mi->dirty = true;
+		ntfs_free(attr_s);
+		/*reinsert le*/
+	}
+
+	return err;
+}
+
+/*
+ * attr_set_size
+ *
+ * change the size of attribute
+ * Extend:
+ *   - sparse/compressed: no allocated clusters
+ *   - normal: append allocated and preallocated new clusters
+ * Shrink:
+ *   - no deallocate if keep_prealloc is set
+ */
+int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
+		  const __le16 *name, u8 name_len, struct runs_tree *run,
+		  u64 new_size, const u64 *new_valid, bool keep_prealloc,
+		  struct ATTRIB **ret)
+{
+	int err = 0;
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
+	u8 cluster_bits = sbi->cluster_bits;
+	bool is_mft =
+		ni->mi.rno == MFT_REC_MFT && type == ATTR_DATA && !name_len;
+	u64 old_valid, old_size, old_alloc, new_alloc, new_alloc_tmp;
+	struct ATTRIB *attr, *attr_b;
+	struct ATTR_LIST_ENTRY *le, *le_b;
+	struct mft_inode *mi, *mi_b;
+	CLST alen, vcn, lcn, new_alen, old_alen, svcn, evcn;
+	CLST next_svcn, pre_alloc = -1, done = 0;
+	bool is_ext;
+	u32 align;
+	struct MFT_REC *rec;
+
+again:
+	le_b = NULL;
+	attr_b = ni_find_attr(ni, NULL, &le_b, type, name, name_len, NULL,
+			      &mi_b);
+	if (!attr_b) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	if (!attr_b->non_res) {
+		err = attr_set_size_res(ni, attr_b, le_b, mi_b, new_size, run,
+					&attr_b);
+		if (err || !attr_b->non_res)
+			goto out;
+
+		/* layout of records may be changed, so do a full search */
+		goto again;
+	}
+
+	is_ext = is_attr_ext(attr_b);
+
+again_1:
+	if (is_ext) {
+		align = 1u << (attr_b->nres.c_unit + cluster_bits);
+		if (is_attr_sparsed(attr_b))
+			keep_prealloc = false;
+	} else {
+		align = sbi->cluster_size;
+	}
+
+	old_valid = le64_to_cpu(attr_b->nres.valid_size);
+	old_size = le64_to_cpu(attr_b->nres.data_size);
+	old_alloc = le64_to_cpu(attr_b->nres.alloc_size);
+	old_alen = old_alloc >> cluster_bits;
+
+	new_alloc = (new_size + align - 1) & ~(u64)(align - 1);
+	new_alen = new_alloc >> cluster_bits;
+
+	if (keep_prealloc && is_ext)
+		keep_prealloc = false;
+
+	if (keep_prealloc && new_size < old_size) {
+		attr_b->nres.data_size = cpu_to_le64(new_size);
+		mi_b->dirty = true;
+		goto ok;
+	}
+
+	vcn = old_alen - 1;
+
+	svcn = le64_to_cpu(attr_b->nres.svcn);
+	evcn = le64_to_cpu(attr_b->nres.evcn);
+
+	if (svcn <= vcn && vcn <= evcn) {
+		attr = attr_b;
+		le = le_b;
+		mi = mi_b;
+	} else if (!le_b) {
+		err = -EINVAL;
+		goto out;
+	} else {
+		le = le_b;
+		attr = ni_find_attr(ni, attr_b, &le, type, name, name_len, &vcn,
+				    &mi);
+		if (!attr) {
+			err = -EINVAL;
+			goto out;
+		}
+
+next_le_1:
+		svcn = le64_to_cpu(attr->nres.svcn);
+		evcn = le64_to_cpu(attr->nres.evcn);
+	}
+
+next_le:
+	rec = mi->mrec;
+
+	err = attr_load_runs(attr, ni, run, NULL);
+	if (err)
+		goto out;
+
+	if (new_size > old_size) {
+		CLST to_allocate;
+		size_t free;
+
+		if (new_alloc <= old_alloc) {
+			attr_b->nres.data_size = cpu_to_le64(new_size);
+			mi_b->dirty = true;
+			goto ok;
+		}
+
+		to_allocate = new_alen - old_alen;
+add_alloc_in_same_attr_seg:
+		lcn = 0;
+		if (is_mft) {
+			/* mft allocates clusters from mftzone */
+			pre_alloc = 0;
+		} else if (is_ext) {
+			/* no preallocate for sparse/compress */
+			pre_alloc = 0;
+		} else if (pre_alloc == -1) {
+			pre_alloc = 0;
+			if (type == ATTR_DATA && !name_len &&
+			    sbi->options.prealloc) {
+				CLST new_alen2 = bytes_to_cluster(
+					sbi, get_pre_allocated(new_size));
+				pre_alloc = new_alen2 - new_alen;
+			}
+
+			/* Get the last lcn to allocate from */
+			if (old_alen &&
+			    !run_lookup_entry(run, vcn, &lcn, NULL, NULL)) {
+				lcn = SPARSE_LCN;
+			}
+
+			if (lcn == SPARSE_LCN)
+				lcn = 0;
+			else if (lcn)
+				lcn += 1;
+
+			free = wnd_zeroes(&sbi->used.bitmap);
+			if (to_allocate > free) {
+				err = -ENOSPC;
+				goto out;
+			}
+
+			if (pre_alloc && to_allocate + pre_alloc > free)
+				pre_alloc = 0;
+		}
+
+		vcn = old_alen;
+
+		if (is_ext) {
+			if (!run_add_entry(run, vcn, SPARSE_LCN, to_allocate)) {
+				err = -ENOMEM;
+				goto out;
+			}
+			alen = to_allocate;
+		} else {
+			/* ~3 bytes per fragment */
+			err = attr_allocate_clusters(
+				sbi, run, vcn, lcn, to_allocate, &pre_alloc,
+				is_mft ? ALLOCATE_MFT : 0, &alen,
+				is_mft ? 0 :
+					 (sbi->record_size -
+					  le32_to_cpu(rec->used) + 8) /
+							 3 +
+						 1,
+				NULL);
+			if (err)
+				goto out;
+		}
+
+		done += alen;
+		vcn += alen;
+		if (to_allocate > alen)
+			to_allocate -= alen;
+		else
+			to_allocate = 0;
+
+pack_runs:
+		err = mi_pack_runs(mi, attr, run, vcn - svcn);
+		if (err)
+			goto out;
+
+		next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
+		new_alloc_tmp = (u64)next_svcn << cluster_bits;
+		attr_b->nres.alloc_size = cpu_to_le64(new_alloc_tmp);
+		mi_b->dirty = true;
+
+		if (next_svcn >= vcn && !to_allocate) {
+			/* Normal way. update attribute and exit */
+			attr_b->nres.data_size = cpu_to_le64(new_size);
+			goto ok;
+		}
+
+		/* at least two mft to avoid recursive loop*/
+		if (is_mft && next_svcn == vcn &&
+		    ((u64)done << sbi->cluster_bits) >= 2 * sbi->record_size) {
+			new_size = new_alloc_tmp;
+			attr_b->nres.data_size = attr_b->nres.alloc_size;
+			goto ok;
+		}
+
+		if (le32_to_cpu(rec->used) < sbi->record_size) {
+			old_alen = next_svcn;
+			evcn = old_alen - 1;
+			goto add_alloc_in_same_attr_seg;
+		}
+
+		attr_b->nres.data_size = attr_b->nres.alloc_size;
+		if (new_alloc_tmp < old_valid)
+			attr_b->nres.valid_size = attr_b->nres.data_size;
+
+		if (type == ATTR_LIST) {
+			err = ni_expand_list(ni);
+			if (err)
+				goto out;
+			if (next_svcn < vcn)
+				goto pack_runs;
+
+			/* layout of records is changed */
+			goto again;
+		}
+
+		if (!ni->attr_list.size) {
+			err = ni_create_attr_list(ni);
+			if (err)
+				goto out;
+			/* layout of records is changed */
+		}
+
+		if (next_svcn >= vcn) {
+			/* this is mft data, repeat */
+			goto again;
+		}
+
+		/* insert new attribute segment */
+		err = ni_insert_nonresident(ni, type, name, name_len, run,
+					    next_svcn, vcn - next_svcn,
+					    attr_b->flags, &attr, &mi);
+		if (err)
+			goto out;
+
+		if (!is_mft)
+			run_truncate_head(run, evcn + 1);
+
+		svcn = le64_to_cpu(attr->nres.svcn);
+		evcn = le64_to_cpu(attr->nres.evcn);
+
+		le_b = NULL;
+		/* layout of records maybe changed */
+		/* find base attribute to update*/
+		attr_b = ni_find_attr(ni, NULL, &le_b, type, name, name_len,
+				      NULL, &mi_b);
+		if (!attr_b) {
+			err = -ENOENT;
+			goto out;
+		}
+
+		attr_b->nres.alloc_size = cpu_to_le64((u64)vcn << cluster_bits);
+		attr_b->nres.data_size = attr_b->nres.alloc_size;
+		attr_b->nres.valid_size = attr_b->nres.alloc_size;
+		mi_b->dirty = true;
+		goto again_1;
+	}
+
+	if (new_size != old_size ||
+	    (new_alloc != old_alloc && !keep_prealloc)) {
+		vcn = max(svcn, new_alen);
+		new_alloc_tmp = (u64)vcn << cluster_bits;
+
+		err = run_deallocate_ex(sbi, run, vcn, evcn - vcn + 1, &alen,
+					true);
+		if (err)
+			goto out;
+
+		run_truncate(run, vcn);
+
+		if (vcn > svcn) {
+			err = mi_pack_runs(mi, attr, run, vcn - svcn);
+			if (err)
+				goto out;
+		} else if (le && le->vcn) {
+			u16 le_sz = le16_to_cpu(le->size);
+
+			/*
+			 * NOTE: list entries for one attribute are always
+			 * the same size. We deal with last entry (vcn==0)
+			 * and it is not first in entries array
+			 * (list entry for std attribute always first)
+			 * So it is safe to step back
+			 */
+			mi_remove_attr(mi, attr);
+
+			if (!al_remove_le(ni, le)) {
+				err = -EINVAL;
+				goto out;
+			}
+
+			le = (struct ATTR_LIST_ENTRY *)((u8 *)le - le_sz);
+		} else {
+			attr->nres.evcn = cpu_to_le64((u64)vcn - 1);
+			mi->dirty = true;
+		}
+
+		attr_b->nres.alloc_size = cpu_to_le64(new_alloc_tmp);
+
+		if (vcn == new_alen) {
+			attr_b->nres.data_size = cpu_to_le64(new_size);
+			if (new_size < old_valid)
+				attr_b->nres.valid_size =
+					attr_b->nres.data_size;
+		} else {
+			if (new_alloc_tmp <=
+			    le64_to_cpu(attr_b->nres.data_size))
+				attr_b->nres.data_size =
+					attr_b->nres.alloc_size;
+			if (new_alloc_tmp <
+			    le64_to_cpu(attr_b->nres.valid_size))
+				attr_b->nres.valid_size =
+					attr_b->nres.alloc_size;
+		}
+
+		if (is_ext)
+			le64_sub_cpu(&attr_b->nres.total_size,
+				     ((u64)alen << cluster_bits));
+
+		mi_b->dirty = true;
+
+		if (new_alloc_tmp <= new_alloc)
+			goto ok;
+
+		old_size = new_alloc_tmp;
+		vcn = svcn - 1;
+
+		if (le == le_b) {
+			attr = attr_b;
+			mi = mi_b;
+			evcn = svcn - 1;
+			svcn = 0;
+			goto next_le;
+		}
+
+		if (le->type != type || le->name_len != name_len ||
+		    memcmp(le_name(le), name, name_len * sizeof(short))) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		err = ni_load_mi(ni, le, &mi);
+		if (err)
+			goto out;
+
+		attr = mi_find_attr(mi, NULL, type, name, name_len, &le->id);
+		if (!attr) {
+			err = -EINVAL;
+			goto out;
+		}
+		goto next_le_1;
+	}
+
+ok:
+	if (new_valid) {
+		__le64 valid = cpu_to_le64(min(*new_valid, new_size));
+
+		if (attr_b->nres.valid_size != valid) {
+			attr_b->nres.valid_size = valid;
+			mi_b->dirty = true;
+		}
+	}
+
+out:
+	if (!err && attr_b && ret)
+		*ret = attr_b;
+
+	/* update inode_set_bytes*/
+	if (!err && attr_b && attr_b->non_res &&
+	    ((type == ATTR_DATA && !name_len) ||
+	     (type == ATTR_ALLOC && name == I30_NAME))) {
+		bool dirty = false;
+
+		if (ni->vfs_inode.i_size != new_size) {
+			ni->vfs_inode.i_size = new_size;
+			dirty = true;
+		}
+
+		new_alloc = le64_to_cpu(attr_b->nres.alloc_size);
+		if (inode_get_bytes(&ni->vfs_inode) != new_alloc) {
+			inode_set_bytes(&ni->vfs_inode, new_alloc);
+			dirty = true;
+		}
+
+		if (dirty) {
+			ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
+			mark_inode_dirty(&ni->vfs_inode);
+		}
+	}
+
+	return err;
+}
+
+int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
+			CLST *len, bool *new)
+{
+	int err = 0;
+	struct runs_tree *run = &ni->file.run;
+	struct ntfs_sb_info *sbi;
+	u8 cluster_bits;
+	struct ATTRIB *attr, *attr_b;
+	struct ATTR_LIST_ENTRY *le, *le_b;
+	struct mft_inode *mi, *mi_b;
+	CLST hint, svcn, to_alloc, evcn1, next_svcn, asize, end;
+	u64 new_size, total_size;
+	u32 clst_per_frame;
+	bool ok;
+
+	if (new)
+		*new = false;
+
+	down_read(&ni->file.run_lock);
+	ok = run_lookup_entry(run, vcn, lcn, len, NULL);
+	up_read(&ni->file.run_lock);
+
+	if (ok && (*lcn != SPARSE_LCN || !new)) {
+		/* normal way */
+		return 0;
+	}
+
+	if (!clen)
+		clen = 1;
+
+	if (ok && clen > *len)
+		clen = *len;
+
+	sbi = ni->mi.sbi;
+	cluster_bits = sbi->cluster_bits;
+	new_size = ((u64)vcn + clen) << cluster_bits;
+
+	ni_lock(ni);
+	down_write(&ni->file.run_lock);
+
+again:
+	le_b = NULL;
+	attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL, 0, NULL, &mi_b);
+	if (!attr_b) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	if (!attr_b->non_res) {
+		if (!new) {
+			*lcn = RESIDENT_LCN;
+			goto out;
+		}
+
+		err = attr_set_size_res(ni, attr_b, le_b, mi_b, new_size, run,
+					&attr_b);
+		if (err)
+			goto out;
+
+		if (!attr_b->non_res) {
+			/* Resident attribute still resident */
+			*lcn = RESIDENT_LCN;
+			goto out;
+		}
+
+		/* Resident attribute becomes non resident */
+		goto again;
+	}
+
+	asize = le64_to_cpu(attr_b->nres.alloc_size) >> sbi->cluster_bits;
+	if (vcn >= asize) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	clst_per_frame = 1u << attr_b->nres.c_unit;
+	to_alloc = (clen + clst_per_frame - 1) & ~(clst_per_frame - 1);
+
+	if (vcn + to_alloc > asize)
+		to_alloc = asize - vcn;
+
+	svcn = le64_to_cpu(attr_b->nres.svcn);
+	evcn1 = le64_to_cpu(attr_b->nres.evcn) + 1;
+
+	attr = attr_b;
+	le = le_b;
+	mi = mi_b;
+
+	if (le_b && (vcn < svcn || evcn1 <= vcn)) {
+		attr = ni_find_attr(ni, attr_b, &le, ATTR_DATA, NULL, 0, &vcn,
+				    &mi);
+		if (!attr) {
+			err = -EINVAL;
+			goto out;
+		}
+		svcn = le64_to_cpu(attr->nres.svcn);
+		evcn1 = le64_to_cpu(attr->nres.evcn) + 1;
+	}
+
+	err = attr_load_runs(attr, ni, run, NULL);
+	if (err)
+		goto out;
+
+	if (!ok) {
+		ok = run_lookup_entry(run, vcn, lcn, len, NULL);
+		if (ok && (*lcn != SPARSE_LCN || !new)) {
+			/* normal way */
+			err = 0;
+			goto ok;
+		}
+
+		if (!ok && !new) {
+			*len = 0;
+			err = 0;
+			goto ok;
+		}
+
+		if (ok && clen > *len) {
+			clen = *len;
+			new_size = ((u64)vcn + clen) << cluster_bits;
+			to_alloc = (clen + clst_per_frame - 1) &
+				   ~(clst_per_frame - 1);
+		}
+	}
+
+	if (!is_attr_ext(attr_b)) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* Get the last lcn to allocate from */
+	hint = 0;
+
+	if (vcn > evcn1) {
+		if (!run_add_entry(run, evcn1, SPARSE_LCN, vcn - evcn1)) {
+			err = -ENOMEM;
+			goto out;
+		}
+	} else if (vcn && !run_lookup_entry(run, vcn - 1, &hint, NULL, NULL)) {
+		hint = -1;
+	}
+
+	err = attr_allocate_clusters(
+		sbi, run, vcn, hint + 1, to_alloc, NULL, 0, len,
+		(sbi->record_size - le32_to_cpu(mi->mrec->used) + 8) / 3 + 1,
+		lcn);
+	if (err)
+		goto out;
+	*new = true;
+
+	end = vcn + *len;
+
+	total_size = le64_to_cpu(attr_b->nres.total_size) +
+		     ((u64)*len << cluster_bits);
+
+repack:
+	err = mi_pack_runs(mi, attr, run, max(end, evcn1) - svcn);
+	if (err)
+		goto out;
+
+	attr_b->nres.total_size = cpu_to_le64(total_size);
+	inode_set_bytes(&ni->vfs_inode, total_size);
+
+	mi_b->dirty = true;
+	mark_inode_dirty(&ni->vfs_inode);
+
+	/* stored [vcn : next_svcn) from [vcn : end) */
+	next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
+
+	if (end <= evcn1) {
+		if (next_svcn == evcn1) {
+			/* Normal way. update attribute and exit */
+			goto ok;
+		}
+		/* add new segment [next_svcn : evcn1 - next_svcn )*/
+		if (!ni->attr_list.size) {
+			err = ni_create_attr_list(ni);
+			if (err)
+				goto out;
+			/* layout of records is changed */
+			le_b = NULL;
+			attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL,
+					      0, NULL, &mi_b);
+			if (!attr_b) {
+				err = -ENOENT;
+				goto out;
+			}
+
+			attr = attr_b;
+			le = le_b;
+			mi = mi_b;
+			goto repack;
+		}
+	}
+
+	svcn = evcn1;
+
+	/* Estimate next attribute */
+	attr = ni_find_attr(ni, attr, &le, ATTR_DATA, NULL, 0, &svcn, &mi);
+
+	if (attr) {
+		CLST alloc = bytes_to_cluster(
+			sbi, le64_to_cpu(attr_b->nres.alloc_size));
+		CLST evcn = le64_to_cpu(attr->nres.evcn);
+
+		if (end < next_svcn)
+			end = next_svcn;
+		while (end > evcn) {
+			/* remove segment [svcn : evcn)*/
+			mi_remove_attr(mi, attr);
+
+			if (!al_remove_le(ni, le)) {
+				err = -EINVAL;
+				goto out;
+			}
+
+			if (evcn + 1 >= alloc) {
+				/* last attribute segment */
+				evcn1 = evcn + 1;
+				goto ins_ext;
+			}
+
+			if (ni_load_mi(ni, le, &mi)) {
+				attr = NULL;
+				goto out;
+			}
+
+			attr = mi_find_attr(mi, NULL, ATTR_DATA, NULL, 0,
+					    &le->id);
+			if (!attr) {
+				err = -EINVAL;
+				goto out;
+			}
+			svcn = le64_to_cpu(attr->nres.svcn);
+			evcn = le64_to_cpu(attr->nres.evcn);
+		}
+
+		if (end < svcn)
+			end = svcn;
+
+		err = attr_load_runs(attr, ni, run, &end);
+		if (err)
+			goto out;
+
+		evcn1 = evcn + 1;
+		attr->nres.svcn = cpu_to_le64(next_svcn);
+		err = mi_pack_runs(mi, attr, run, evcn1 - next_svcn);
+		if (err)
+			goto out;
+
+		le->vcn = cpu_to_le64(next_svcn);
+		ni->attr_list.dirty = true;
+		mi->dirty = true;
+
+		next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
+	}
+ins_ext:
+	if (evcn1 > next_svcn) {
+		err = ni_insert_nonresident(ni, ATTR_DATA, NULL, 0, run,
+					    next_svcn, evcn1 - next_svcn,
+					    attr_b->flags, &attr, &mi);
+		if (err)
+			goto out;
+	}
+ok:
+	run_truncate_around(run, vcn);
+out:
+	up_write(&ni->file.run_lock);
+	ni_unlock(ni);
+
+	return err;
+}
+
+/*
+ * attr_load_runs_vcn
+ *
+ * load runs with vcn
+ */
+int attr_load_runs_vcn(struct ntfs_inode *ni, enum ATTR_TYPE type,
+		       const __le16 *name, u8 name_len, struct runs_tree *run,
+		       CLST vcn)
+{
+	struct ATTRIB *attr;
+	int err;
+	CLST svcn, evcn;
+	u16 ro;
+
+	attr = ni_find_attr(ni, NULL, NULL, type, name, name_len, &vcn, NULL);
+	if (!attr)
+		return -ENOENT;
+
+	svcn = le64_to_cpu(attr->nres.svcn);
+	evcn = le64_to_cpu(attr->nres.evcn);
+
+	if (evcn < vcn || vcn < svcn)
+		return -EINVAL;
+
+	ro = le16_to_cpu(attr->nres.run_off);
+	err = run_unpack_ex(run, ni->mi.sbi, ni->mi.rno, svcn, evcn, svcn,
+			    Add2Ptr(attr, ro), le32_to_cpu(attr->size) - ro);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+/*
+ * attr_is_frame_compressed
+ *
+ * This function is used to detect compressed frame
+ */
+int attr_is_frame_compressed(struct ntfs_inode *ni, struct ATTRIB *attr,
+			     CLST frame, CLST *clst_data, bool *is_compr)
+{
+	int err;
+	u32 clst_frame;
+	CLST len, lcn, vcn, alen, slen, vcn1;
+	size_t idx;
+	struct runs_tree *run;
+
+	*clst_data = 0;
+	*is_compr = false;
+
+	if (!is_attr_compressed(attr))
+		return 0;
+
+	if (!attr->non_res)
+		return 0;
+
+	clst_frame = 1u << attr->nres.c_unit;
+	vcn = frame * clst_frame;
+	run = &ni->file.run;
+
+	if (!run_lookup_entry(run, vcn, &lcn, &len, &idx)) {
+		err = attr_load_runs_vcn(ni, attr->type, attr_name(attr),
+					 attr->name_len, run, vcn);
+		if (err)
+			return err;
+
+		if (!run_lookup_entry(run, vcn, &lcn, &len, &idx))
+			return -ENOENT;
+	}
+
+	if (lcn == SPARSE_LCN) {
+		/* The frame is sparsed if "clst_frame" clusters are sparsed */
+		*is_compr = true;
+		return 0;
+	}
+
+	if (len >= clst_frame) {
+		/*
+		 * The frame is not compressed 'cause
+		 * it does not contain any sparse clusters
+		 */
+		*clst_data = clst_frame;
+		return 0;
+	}
+
+	alen = bytes_to_cluster(ni->mi.sbi, le64_to_cpu(attr->nres.alloc_size));
+	slen = 0;
+	*clst_data = len;
+
+	/*
+	 * The frame is compressed if *clst_data + slen >= clst_frame
+	 * Check next fragments
+	 */
+	while ((vcn += len) < alen) {
+		vcn1 = vcn;
+
+		if (!run_get_entry(run, ++idx, &vcn, &lcn, &len) ||
+		    vcn1 != vcn) {
+			err = attr_load_runs_vcn(ni, attr->type,
+						 attr_name(attr),
+						 attr->name_len, run, vcn1);
+			if (err)
+				return err;
+			vcn = vcn1;
+
+			if (!run_lookup_entry(run, vcn, &lcn, &len, &idx))
+				return -ENOENT;
+		}
+
+		if (lcn == SPARSE_LCN) {
+			slen += len;
+		} else {
+			if (slen) {
+				/*
+				 * data_clusters + sparse_clusters =
+				 * not enough for frame
+				 */
+				return -EINVAL;
+			}
+			*clst_data += len;
+		}
+
+		if (*clst_data + slen >= clst_frame) {
+			if (!slen) {
+				/*
+				 * There is no sparsed clusters in this frame
+				 * So it is not compressed
+				 */
+				*clst_data = clst_frame;
+			} else {
+				*is_compr = *clst_data < clst_frame;
+			}
+			break;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * attr_allocate_frame
+ *
+ * allocate/free clusters for 'frame'
+ * assumed: down_write(&ni->file.run_lock);
+ */
+int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
+			u64 new_valid)
+{
+	int err = 0;
+	struct runs_tree *run = &ni->file.run;
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
+	struct ATTRIB *attr, *attr_b;
+	struct ATTR_LIST_ENTRY *le, *le_b;
+	struct mft_inode *mi, *mi_b;
+	CLST svcn, evcn1, next_svcn, lcn, len;
+	CLST vcn, end, clst_data;
+	u64 total_size, valid_size, data_size;
+	bool is_compr;
+
+	le_b = NULL;
+	attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL, 0, NULL, &mi_b);
+	if (!attr_b)
+		return -ENOENT;
+
+	if (!is_attr_ext(attr_b))
+		return -EINVAL;
+
+	vcn = frame << NTFS_LZNT_CUNIT;
+	total_size = le64_to_cpu(attr_b->nres.total_size);
+
+	svcn = le64_to_cpu(attr_b->nres.svcn);
+	evcn1 = le64_to_cpu(attr_b->nres.evcn) + 1;
+	data_size = le64_to_cpu(attr_b->nres.data_size);
+
+	if (svcn <= vcn && vcn < evcn1) {
+		attr = attr_b;
+		le = le_b;
+		mi = mi_b;
+	} else if (!le_b) {
+		err = -EINVAL;
+		goto out;
+	} else {
+		le = le_b;
+		attr = ni_find_attr(ni, attr_b, &le, ATTR_DATA, NULL, 0, &vcn,
+				    &mi);
+		if (!attr) {
+			err = -EINVAL;
+			goto out;
+		}
+		svcn = le64_to_cpu(attr->nres.svcn);
+		evcn1 = le64_to_cpu(attr->nres.evcn) + 1;
+	}
+
+	err = attr_load_runs(attr, ni, run, NULL);
+	if (err)
+		goto out;
+
+	err = attr_is_frame_compressed(ni, attr_b, frame, &clst_data,
+				       &is_compr);
+	if (err)
+		goto out;
+
+	total_size -= (u64)clst_data << sbi->cluster_bits;
+
+	len = bytes_to_cluster(sbi, compr_size);
+
+	if (len == clst_data)
+		goto out;
+
+	if (len < clst_data) {
+		err = run_deallocate_ex(sbi, run, vcn + len, clst_data - len,
+					NULL, true);
+		if (err)
+			goto out;
+
+		if (!run_add_entry(run, vcn + len, SPARSE_LCN,
+				   clst_data - len)) {
+			err = -ENOMEM;
+			goto out;
+		}
+		end = vcn + clst_data;
+		/* run contains updated range [vcn + len : end) */
+	} else {
+		CLST alen, hint;
+		/* Get the last lcn to allocate from */
+		if (vcn + clst_data &&
+		    !run_lookup_entry(run, vcn + clst_data - 1, &hint, NULL,
+				      NULL)) {
+			hint = -1;
+		}
+
+		err = attr_allocate_clusters(sbi, run, vcn + clst_data,
+					     hint + 1, len - clst_data, NULL, 0,
+					     &alen, 0, &lcn);
+		if (err)
+			goto out;
+
+		end = vcn + len;
+		/* run contains updated range [vcn + clst_data : end) */
+	}
+
+	total_size += (u64)len << sbi->cluster_bits;
+
+repack:
+	err = mi_pack_runs(mi, attr, run, max(end, evcn1) - svcn);
+	if (err)
+		goto out;
+
+	attr_b->nres.total_size = cpu_to_le64(total_size);
+	inode_set_bytes(&ni->vfs_inode, total_size);
+
+	mi_b->dirty = true;
+	mark_inode_dirty(&ni->vfs_inode);
+
+	/* stored [vcn : next_svcn) from [vcn : end) */
+	next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
+
+	if (end <= evcn1) {
+		if (next_svcn == evcn1) {
+			/* Normal way. update attribute and exit */
+			goto ok;
+		}
+		/* add new segment [next_svcn : evcn1 - next_svcn )*/
+		if (!ni->attr_list.size) {
+			err = ni_create_attr_list(ni);
+			if (err)
+				goto out;
+			/* layout of records is changed */
+			le_b = NULL;
+			attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL,
+					      0, NULL, &mi_b);
+			if (!attr_b) {
+				err = -ENOENT;
+				goto out;
+			}
+
+			attr = attr_b;
+			le = le_b;
+			mi = mi_b;
+			goto repack;
+		}
+	}
+
+	svcn = evcn1;
+
+	/* Estimate next attribute */
+	attr = ni_find_attr(ni, attr, &le, ATTR_DATA, NULL, 0, &svcn, &mi);
+
+	if (attr) {
+		CLST alloc = bytes_to_cluster(
+			sbi, le64_to_cpu(attr_b->nres.alloc_size));
+		CLST evcn = le64_to_cpu(attr->nres.evcn);
+
+		if (end < next_svcn)
+			end = next_svcn;
+		while (end > evcn) {
+			/* remove segment [svcn : evcn)*/
+			mi_remove_attr(mi, attr);
+
+			if (!al_remove_le(ni, le)) {
+				err = -EINVAL;
+				goto out;
+			}
+
+			if (evcn + 1 >= alloc) {
+				/* last attribute segment */
+				evcn1 = evcn + 1;
+				goto ins_ext;
+			}
+
+			if (ni_load_mi(ni, le, &mi)) {
+				attr = NULL;
+				goto out;
+			}
+
+			attr = mi_find_attr(mi, NULL, ATTR_DATA, NULL, 0,
+					    &le->id);
+			if (!attr) {
+				err = -EINVAL;
+				goto out;
+			}
+			svcn = le64_to_cpu(attr->nres.svcn);
+			evcn = le64_to_cpu(attr->nres.evcn);
+		}
+
+		if (end < svcn)
+			end = svcn;
+
+		err = attr_load_runs(attr, ni, run, &end);
+		if (err)
+			goto out;
+
+		evcn1 = evcn + 1;
+		attr->nres.svcn = cpu_to_le64(next_svcn);
+		err = mi_pack_runs(mi, attr, run, evcn1 - next_svcn);
+		if (err)
+			goto out;
+
+		le->vcn = cpu_to_le64(next_svcn);
+		ni->attr_list.dirty = true;
+		mi->dirty = true;
+
+		next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
+	}
+ins_ext:
+	if (evcn1 > next_svcn) {
+		err = ni_insert_nonresident(ni, ATTR_DATA, NULL, 0, run,
+					    next_svcn, evcn1 - next_svcn,
+					    attr_b->flags, &attr, &mi);
+		if (err)
+			goto out;
+	}
+ok:
+	run_truncate_around(run, vcn);
+out:
+	if (new_valid > data_size)
+		new_valid = data_size;
+
+	valid_size = le64_to_cpu(attr_b->nres.valid_size);
+	if (new_valid != valid_size) {
+		attr_b->nres.valid_size = cpu_to_le64(valid_size);
+		mi_b->dirty = true;
+	}
+
+	return err;
+}
diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
new file mode 100644
index 000000000000..d052033ecb19
--- /dev/null
+++ b/fs/ntfs3/attrlist.c
@@ -0,0 +1,465 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/attrib.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/fs.h>
+#include <linux/nls.h>
+#include <linux/sched/signal.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+/* Returns true if le is valid */
+static inline bool al_is_valid_le(const struct ntfs_inode *ni,
+				  struct ATTR_LIST_ENTRY *le)
+{
+	if (!le || !ni->attr_list.le || !ni->attr_list.size)
+		return false;
+
+	return PtrOffset(ni->attr_list.le, le) + le16_to_cpu(le->size) <=
+	       ni->attr_list.size;
+}
+
+void al_destroy(struct ntfs_inode *ni)
+{
+	run_close(&ni->attr_list.run);
+	ntfs_free(ni->attr_list.le);
+	ni->attr_list.le = NULL;
+	ni->attr_list.size = 0;
+	ni->attr_list.dirty = false;
+}
+
+/*
+ * ntfs_load_attr_list
+ *
+ * This method makes sure that the ATTRIB list, if present,
+ * has been properly set up.
+ */
+int ntfs_load_attr_list(struct ntfs_inode *ni, struct ATTRIB *attr)
+{
+	int err;
+	size_t lsize;
+	void *le = NULL;
+
+	if (ni->attr_list.size)
+		return 0;
+
+	if (!attr->non_res) {
+		lsize = le32_to_cpu(attr->res.data_size);
+		le = ntfs_alloc(al_aligned(lsize), 0);
+		if (!le) {
+			err = -ENOMEM;
+			goto out;
+		}
+		memcpy(le, resident_data(attr), lsize);
+	} else if (attr->nres.svcn) {
+		err = -EINVAL;
+		goto out;
+	} else {
+		u16 run_off = le16_to_cpu(attr->nres.run_off);
+
+		lsize = le64_to_cpu(attr->nres.data_size);
+
+		run_init(&ni->attr_list.run);
+
+		err = run_unpack_ex(&ni->attr_list.run, ni->mi.sbi, ni->mi.rno,
+				    0, le64_to_cpu(attr->nres.evcn), 0,
+				    Add2Ptr(attr, run_off),
+				    le32_to_cpu(attr->size) - run_off);
+		if (err < 0)
+			goto out;
+
+		le = ntfs_alloc(al_aligned(lsize), 0);
+		if (!le) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		err = ntfs_read_run_nb(ni->mi.sbi, &ni->attr_list.run, 0, le,
+				       lsize, NULL);
+		if (err)
+			goto out;
+	}
+
+	ni->attr_list.size = lsize;
+	ni->attr_list.le = le;
+
+	return 0;
+
+out:
+	ni->attr_list.le = le;
+	al_destroy(ni);
+
+	return err;
+}
+
+/*
+ * al_enumerate
+ *
+ * Returns the next list le
+ * if le is NULL then returns the first le
+ */
+struct ATTR_LIST_ENTRY *al_enumerate(struct ntfs_inode *ni,
+				     struct ATTR_LIST_ENTRY *le)
+{
+	size_t off;
+	u16 sz;
+
+	if (!le) {
+		le = ni->attr_list.le;
+	} else {
+		sz = le16_to_cpu(le->size);
+		if (sz < sizeof(struct ATTR_LIST_ENTRY)) {
+			/* Impossible 'cause we should not return such le */
+			return NULL;
+		}
+		le = Add2Ptr(le, sz);
+	}
+
+	/* Check boundary */
+	off = PtrOffset(ni->attr_list.le, le);
+	if (off + sizeof(struct ATTR_LIST_ENTRY) > ni->attr_list.size) {
+		// The regular end of list
+		return NULL;
+	}
+
+	sz = le16_to_cpu(le->size);
+
+	/* Check le for errors */
+	if (sz < sizeof(struct ATTR_LIST_ENTRY) ||
+	    off + sz > ni->attr_list.size ||
+	    sz < le->name_off + le->name_len * sizeof(short)) {
+		return NULL;
+	}
+
+	return le;
+}
+
+/*
+ * al_find_le
+ *
+ * finds the first le in the list which matches type, name and vcn
+ * Returns NULL if not found
+ */
+struct ATTR_LIST_ENTRY *al_find_le(struct ntfs_inode *ni,
+				   struct ATTR_LIST_ENTRY *le,
+				   const struct ATTRIB *attr)
+{
+	CLST svcn = attr_svcn(attr);
+
+	return al_find_ex(ni, le, attr->type, attr_name(attr), attr->name_len,
+			  &svcn);
+}
+
+/*
+ * al_find_ex
+ *
+ * finds the first le in the list which matches type, name and vcn
+ * Returns NULL if not found
+ */
+struct ATTR_LIST_ENTRY *al_find_ex(struct ntfs_inode *ni,
+				   struct ATTR_LIST_ENTRY *le,
+				   enum ATTR_TYPE type, const __le16 *name,
+				   u8 name_len, const CLST *vcn)
+{
+	struct ATTR_LIST_ENTRY *ret = NULL;
+	u32 type_in = le32_to_cpu(type);
+
+	while ((le = al_enumerate(ni, le))) {
+		u64 le_vcn;
+		int diff;
+
+		/* List entries are sorted by type, name and vcn */
+		diff = le32_to_cpu(le->type) - type_in;
+		if (diff < 0)
+			continue;
+
+		if (diff > 0)
+			return ret;
+
+		if (le->name_len != name_len)
+			continue;
+
+		if (name_len &&
+		    memcmp(le_name(le), name, name_len * sizeof(short)))
+			continue;
+
+		if (!vcn)
+			return le;
+
+		le_vcn = le64_to_cpu(le->vcn);
+		if (*vcn == le_vcn)
+			return le;
+
+		if (*vcn < le_vcn)
+			return ret;
+
+		ret = le;
+	}
+
+	return ret;
+}
+
+/*
+ * al_find_le_to_insert
+ *
+ * finds the first list entry which matches type, name and vcn
+ * Returns NULL if not found
+ */
+static struct ATTR_LIST_ENTRY *
+al_find_le_to_insert(struct ntfs_inode *ni, enum ATTR_TYPE type,
+		     const __le16 *name, u8 name_len, const CLST *vcn)
+{
+	struct ATTR_LIST_ENTRY *le = NULL, *prev;
+	u32 type_in = le32_to_cpu(type);
+	int diff;
+
+	/* List entries are sorted by type, name, vcn */
+next:
+	le = al_enumerate(ni, prev = le);
+	if (!le)
+		goto out;
+	diff = le32_to_cpu(le->type) - type_in;
+	if (diff < 0)
+		goto next;
+	if (diff > 0)
+		goto out;
+
+	if (ntfs_cmp_names(name, name_len, le_name(le), le->name_len, NULL) > 0)
+		goto next;
+
+	if (!vcn || *vcn > le64_to_cpu(le->vcn))
+		goto next;
+
+out:
+	if (!le)
+		le = prev ? Add2Ptr(prev, le16_to_cpu(prev->size)) :
+			    ni->attr_list.le;
+
+	return le;
+}
+
+/*
+ * al_add_le
+ *
+ * adds an "attribute list entry" to the list.
+ */
+int al_add_le(struct ntfs_inode *ni, enum ATTR_TYPE type, const __le16 *name,
+	      u8 name_len, CLST svcn, __le16 id, const struct MFT_REF *ref,
+	      struct ATTR_LIST_ENTRY **new_le)
+{
+	int err;
+	struct ATTRIB *attr;
+	struct ATTR_LIST_ENTRY *le;
+	size_t off;
+	u16 sz;
+	size_t asize, new_asize;
+	u64 new_size;
+	typeof(ni->attr_list) *al = &ni->attr_list;
+
+	/*
+	 * Compute the size of the new le and the new length of the
+	 * list with al le added.
+	 */
+	sz = le_size(name_len);
+	new_size = al->size + sz;
+	asize = al_aligned(al->size);
+	new_asize = al_aligned(new_size);
+
+	/* Scan forward to the point at which the new le should be inserted. */
+	le = al_find_le_to_insert(ni, type, name, name_len, &svcn);
+	off = PtrOffset(al->le, le);
+
+	if (new_size > asize) {
+		void *ptr = ntfs_alloc(new_asize, 0);
+
+		if (!ptr)
+			return -ENOMEM;
+
+		memcpy(ptr, al->le, off);
+		memcpy(Add2Ptr(ptr, off + sz), le, al->size - off);
+		le = Add2Ptr(ptr, off);
+		ntfs_free(al->le);
+		al->le = ptr;
+	} else {
+		memmove(Add2Ptr(le, sz), le, al->size - off);
+	}
+
+	al->size = new_size;
+
+	le->type = type;
+	le->size = cpu_to_le16(sz);
+	le->name_len = name_len;
+	le->name_off = offsetof(struct ATTR_LIST_ENTRY, name);
+	le->vcn = cpu_to_le64(svcn);
+	le->ref = *ref;
+	le->id = id;
+	memcpy(le->name, name, sizeof(short) * name_len);
+
+	al->dirty = true;
+
+	err = attr_set_size(ni, ATTR_LIST, NULL, 0, &al->run, new_size,
+			    &new_size, true, &attr);
+	if (err)
+		return err;
+
+	if (attr && attr->non_res) {
+		err = ntfs_sb_write_run(ni->mi.sbi, &al->run, 0, al->le,
+					al->size);
+		if (err)
+			return err;
+	}
+
+	al->dirty = false;
+	*new_le = le;
+
+	return 0;
+}
+
+/*
+ * al_remove_le
+ *
+ * removes 'le' from attribute list
+ */
+bool al_remove_le(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le)
+{
+	u16 size;
+	size_t off;
+	typeof(ni->attr_list) *al = &ni->attr_list;
+
+	if (!al_is_valid_le(ni, le))
+		return false;
+
+	/* Save on stack the size of le */
+	size = le16_to_cpu(le->size);
+	off = PtrOffset(al->le, le);
+
+	memmove(le, Add2Ptr(le, size), al->size - (off + size));
+
+	al->size -= size;
+	al->dirty = true;
+
+	return true;
+}
+
+/*
+ * al_delete_le
+ *
+ * deletes from the list the first le which matches its parameters.
+ */
+bool al_delete_le(struct ntfs_inode *ni, enum ATTR_TYPE type, CLST vcn,
+		  const __le16 *name, size_t name_len,
+		  const struct MFT_REF *ref)
+{
+	u16 size;
+	struct ATTR_LIST_ENTRY *le;
+	size_t off;
+	typeof(ni->attr_list) *al = &ni->attr_list;
+
+	/* Scan forward to the first le that matches the input */
+	le = al_find_ex(ni, NULL, type, name, name_len, &vcn);
+	if (!le)
+		return false;
+
+	off = PtrOffset(al->le, le);
+
+	if (!ref)
+		goto del;
+
+	/*
+	 * The caller specified a segment reference, so we have to
+	 * scan through the matching entries until we find that segment
+	 * reference or we run of matching entries.
+	 */
+next:
+	if (off + sizeof(struct ATTR_LIST_ENTRY) > al->size)
+		goto del;
+	if (le->type != type)
+		goto del;
+	if (le->name_len != name_len)
+		goto del;
+	if (name_len &&
+	    memcmp(name, Add2Ptr(le, le->name_off), name_len * sizeof(short)))
+		goto del;
+	if (le64_to_cpu(le->vcn) != vcn)
+		goto del;
+	if (!memcmp(ref, &le->ref, sizeof(*ref)))
+		goto del;
+
+	off += le16_to_cpu(le->size);
+	le = Add2Ptr(al->le, off);
+	goto next;
+
+del:
+	/*
+	 * If we've gone off the end of the list, or if the type, name,
+	 * and vcn don't match, then we don't have any matching records.
+	 */
+	if (off >= al->size)
+		return false;
+	if (le->type != type)
+		return false;
+	if (le->name_len != name_len)
+		return false;
+	if (name_len &&
+	    memcmp(name, Add2Ptr(le, le->name_off), name_len * sizeof(short)))
+		return false;
+	if (le64_to_cpu(le->vcn) != vcn)
+		return false;
+
+	/* Save on stack the size of le */
+	size = le16_to_cpu(le->size);
+	/* Delete the le. */
+	memmove(le, Add2Ptr(le, size), al->size - (off + size));
+
+	al->size -= size;
+	al->dirty = true;
+
+	return true;
+}
+
+/*
+ * al_update
+ */
+int al_update(struct ntfs_inode *ni)
+{
+	int err;
+	struct ATTRIB *attr;
+	typeof(ni->attr_list) *al = &ni->attr_list;
+
+	if (!al->dirty || !al->size)
+		return 0;
+
+	/*
+	 * attribute list increased on demand in al_add_le
+	 * attribute list decreased here
+	 */
+	err = attr_set_size(ni, ATTR_LIST, NULL, 0, &al->run, al->size, NULL,
+			    false, &attr);
+	if (err)
+		goto out;
+
+	if (!attr->non_res) {
+		memcpy(resident_data(attr), al->le, al->size);
+	} else {
+		err = ntfs_sb_write_run(ni->mi.sbi, &al->run, 0, al->le,
+					al->size);
+		if (err)
+			goto out;
+
+		attr->nres.valid_size = attr->nres.data_size;
+	}
+
+	ni->mi.dirty = true;
+	al->dirty = false;
+
+out:
+	return err;
+}
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
new file mode 100644
index 000000000000..432482cd1eeb
--- /dev/null
+++ b/fs/ntfs3/xattr.c
@@ -0,0 +1,1063 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/xattr.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/fs.h>
+#include <linux/nls.h>
+#include <linux/posix_acl.h>
+#include <linux/posix_acl_xattr.h>
+#include <linux/xattr.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+// clang-format off
+#define SYSTEM_DOS_ATTRIB    "system.dos_attrib"
+#define SYSTEM_NTFS_ATTRIB   "system.ntfs_attrib"
+#define SYSTEM_NTFS_SECURITY "system.ntfs_security"
+#define USER_DOSATTRIB       "user.DOSATTRIB"
+// clang-format on
+
+static inline size_t unpacked_ea_size(const struct EA_FULL *ea)
+{
+	return !ea->size ? DwordAlign(offsetof(struct EA_FULL, name) + 1 +
+				      ea->name_len + le16_to_cpu(ea->elength)) :
+			   le32_to_cpu(ea->size);
+}
+
+static inline size_t packed_ea_size(const struct EA_FULL *ea)
+{
+	return offsetof(struct EA_FULL, name) + 1 -
+	       offsetof(struct EA_FULL, flags) + ea->name_len +
+	       le16_to_cpu(ea->elength);
+}
+
+/*
+ * find_ea
+ *
+ * assume there is at least one xattr in the list
+ */
+static inline bool find_ea(const struct EA_FULL *ea_all, u32 bytes,
+			   const char *name, u8 name_len, u32 *off)
+{
+	*off = 0;
+
+	if (!ea_all || !bytes)
+		return false;
+
+	for (;;) {
+		const struct EA_FULL *ea = Add2Ptr(ea_all, *off);
+		u32 next_off = *off + unpacked_ea_size(ea);
+
+		if (next_off > bytes)
+			return false;
+
+		if (ea->name_len == name_len &&
+		    !memcmp(ea->name, name, name_len))
+			return true;
+
+		*off = next_off;
+		if (next_off >= bytes)
+			return false;
+	}
+}
+
+/*
+ * ntfs_read_ea
+ *
+ * reads all extended attributes
+ * ea - new allocated memory
+ * info - pointer into resident data
+ */
+static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
+			size_t add_bytes, const struct EA_INFO **info)
+{
+	int err;
+	struct ATTR_LIST_ENTRY *le = NULL;
+	struct ATTRIB *attr_info, *attr_ea;
+	void *ea_p;
+	u32 size;
+
+	static_assert(le32_to_cpu(ATTR_EA_INFO) < le32_to_cpu(ATTR_EA));
+
+	*ea = NULL;
+	*info = NULL;
+
+	attr_info =
+		ni_find_attr(ni, NULL, &le, ATTR_EA_INFO, NULL, 0, NULL, NULL);
+	attr_ea =
+		ni_find_attr(ni, attr_info, &le, ATTR_EA, NULL, 0, NULL, NULL);
+
+	if (!attr_ea || !attr_info)
+		return 0;
+
+	*info = resident_data_ex(attr_info, sizeof(struct EA_INFO));
+	if (!*info)
+		return -EINVAL;
+
+	/* Check Ea limit */
+	size = le32_to_cpu((*info)->size);
+	if (size > MAX_EA_DATA_SIZE || size + add_bytes > MAX_EA_DATA_SIZE)
+		return -EINVAL;
+
+	/* Allocate memory for packed Ea */
+	ea_p = ntfs_alloc(size + add_bytes, 0);
+	if (!ea_p)
+		return -ENOMEM;
+
+	if (attr_ea->non_res) {
+		struct runs_tree run;
+
+		run_init(&run);
+
+		err = attr_load_runs(attr_ea, ni, &run, NULL);
+		if (!err)
+			err = ntfs_read_run_nb(ni->mi.sbi, &run, 0, ea_p, size,
+					       NULL);
+		run_close(&run);
+
+		if (err)
+			goto out;
+	} else {
+		void *p = resident_data_ex(attr_ea, size);
+
+		if (!p) {
+			err = -EINVAL;
+			goto out;
+		}
+		memcpy(ea_p, p, size);
+	}
+
+	memset(Add2Ptr(ea_p, size), 0, add_bytes);
+	*ea = ea_p;
+	return 0;
+
+out:
+	ntfs_free(ea_p);
+	*ea = NULL;
+	return err;
+}
+
+/*
+ * ntfs_listxattr_hlp
+ *
+ * copy a list of xattrs names into the buffer
+ * provided, or compute the buffer size required
+ */
+static int ntfs_listxattr_hlp(struct ntfs_inode *ni, char *buffer,
+			      size_t bytes_per_buffer, size_t *bytes)
+{
+	const struct EA_INFO *info;
+	struct EA_FULL *ea_all = NULL;
+	const struct EA_FULL *ea;
+	u32 off, size;
+	int err;
+
+	*bytes = 0;
+
+	err = ntfs_read_ea(ni, &ea_all, 0, &info);
+	if (err)
+		return err;
+
+	if (!info || !ea_all)
+		return 0;
+
+	size = le32_to_cpu(info->size);
+
+	/* Enumerate all xattrs */
+	for (off = 0; off < size; off += unpacked_ea_size(ea)) {
+		ea = Add2Ptr(ea_all, off);
+
+		if (buffer) {
+			if (*bytes + ea->name_len + 1 > bytes_per_buffer) {
+				err = -ERANGE;
+				goto out;
+			}
+
+			memcpy(buffer + *bytes, ea->name, ea->name_len);
+			buffer[*bytes + ea->name_len] = 0;
+		}
+
+		*bytes += ea->name_len + 1;
+	}
+
+out:
+	ntfs_free(ea_all);
+	return err;
+}
+
+/*
+ * ntfs_get_ea
+ *
+ * reads xattr
+ */
+static int ntfs_get_ea(struct ntfs_inode *ni, const char *name, size_t name_len,
+		       void *buffer, size_t bytes_per_buffer, u32 *len)
+{
+	const struct EA_INFO *info;
+	struct EA_FULL *ea_all = NULL;
+	const struct EA_FULL *ea;
+	u32 off;
+	int err;
+
+	*len = 0;
+
+	if (name_len > 255) {
+		err = -ENAMETOOLONG;
+		goto out;
+	}
+
+	err = ntfs_read_ea(ni, &ea_all, 0, &info);
+	if (err)
+		goto out;
+
+	if (!info)
+		goto out;
+
+	/* Enumerate all xattrs */
+	if (!find_ea(ea_all, le32_to_cpu(info->size), name, name_len, &off)) {
+		err = -ENODATA;
+		goto out;
+	}
+	ea = Add2Ptr(ea_all, off);
+
+	*len = le16_to_cpu(ea->elength);
+	if (!buffer) {
+		err = 0;
+		goto out;
+	}
+
+	if (*len > bytes_per_buffer) {
+		err = -ERANGE;
+		goto out;
+	}
+	memcpy(buffer, ea->name + ea->name_len + 1, *len);
+	err = 0;
+
+out:
+	ntfs_free(ea_all);
+
+	return err;
+}
+
+static noinline int ntfs_getxattr_hlp(struct inode *inode, const char *name,
+				      void *value, size_t size,
+				      size_t *required)
+{
+	struct ntfs_inode *ni = ntfs_i(inode);
+	int err;
+	u32 len;
+
+	if (!(ni->ni_flags & NI_FLAG_EA))
+		return -ENODATA;
+
+	if (!required)
+		ni_lock(ni);
+
+	err = ntfs_get_ea(ni, name, strlen(name), value, size, &len);
+	if (!err)
+		err = len;
+	else if (-ERANGE == err && required)
+		*required = len;
+
+	if (!required)
+		ni_unlock(ni);
+
+	return err;
+}
+
+static noinline int ntfs_set_ea(struct inode *inode, const char *name,
+				const void *value, size_t val_size, int flags,
+				int locked)
+{
+	struct ntfs_inode *ni = ntfs_i(inode);
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
+	int err;
+	struct EA_INFO ea_info;
+	const struct EA_INFO *info;
+	struct EA_FULL *new_ea;
+	struct EA_FULL *ea_all = NULL;
+	size_t name_len, add;
+	u32 off, size;
+	__le16 size_pack;
+	struct ATTRIB *attr;
+	struct ATTR_LIST_ENTRY *le;
+	struct mft_inode *mi;
+	struct runs_tree ea_run;
+	u64 new_sz;
+	void *p;
+
+	if (!locked)
+		ni_lock(ni);
+
+	run_init(&ea_run);
+	name_len = strlen(name);
+
+	if (name_len > 255) {
+		err = -ENAMETOOLONG;
+		goto out;
+	}
+
+	add = DwordAlign(offsetof(struct EA_FULL, name) + 1 + name_len +
+			 val_size);
+
+	err = ntfs_read_ea(ni, &ea_all, add, &info);
+	if (err)
+		goto out;
+
+	if (!info) {
+		memset(&ea_info, 0, sizeof(ea_info));
+		size = 0;
+		size_pack = 0;
+	} else {
+		memcpy(&ea_info, info, sizeof(ea_info));
+		size = le32_to_cpu(ea_info.size);
+		size_pack = ea_info.size_pack;
+	}
+
+	if (info && find_ea(ea_all, size, name, name_len, &off)) {
+		struct EA_FULL *ea;
+		size_t ea_sz;
+
+		if (flags & XATTR_CREATE) {
+			err = -EEXIST;
+			goto out;
+		}
+
+		/* Remove current xattr */
+		ea = Add2Ptr(ea_all, off);
+		if (ea->flags & FILE_NEED_EA)
+			le16_add_cpu(&ea_info.count, -1);
+
+		ea_sz = unpacked_ea_size(ea);
+
+		le16_add_cpu(&ea_info.size_pack, 0 - packed_ea_size(ea));
+
+		memmove(ea, Add2Ptr(ea, ea_sz), size - off - ea_sz);
+
+		size -= ea_sz;
+		memset(Add2Ptr(ea_all, size), 0, ea_sz);
+
+		ea_info.size = cpu_to_le32(size);
+
+		if ((flags & XATTR_REPLACE) && !val_size)
+			goto update_ea;
+	} else {
+		if (flags & XATTR_REPLACE) {
+			err = -ENODATA;
+			goto out;
+		}
+
+		if (!ea_all) {
+			ea_all = ntfs_alloc(add, 1);
+			if (!ea_all) {
+				err = -ENOMEM;
+				goto out;
+			}
+		}
+	}
+
+	/* append new xattr */
+	new_ea = Add2Ptr(ea_all, size);
+	new_ea->size = cpu_to_le32(add);
+	new_ea->flags = 0;
+	new_ea->name_len = name_len;
+	new_ea->elength = cpu_to_le16(val_size);
+	memcpy(new_ea->name, name, name_len);
+	new_ea->name[name_len] = 0;
+	memcpy(new_ea->name + name_len + 1, value, val_size);
+
+	le16_add_cpu(&ea_info.size_pack, packed_ea_size(new_ea));
+	size += add;
+	ea_info.size = cpu_to_le32(size);
+
+update_ea:
+
+	if (!info) {
+		/* Create xattr */
+		if (!size) {
+			err = 0;
+			goto out;
+		}
+
+		err = ni_insert_resident(ni, sizeof(struct EA_INFO),
+					 ATTR_EA_INFO, NULL, 0, NULL, NULL);
+		if (err)
+			goto out;
+
+		err = ni_insert_resident(ni, 0, ATTR_EA, NULL, 0, NULL, NULL);
+		if (err)
+			goto out;
+	}
+
+	new_sz = size;
+	err = attr_set_size(ni, ATTR_EA, NULL, 0, &ea_run, new_sz, &new_sz,
+			    false, NULL);
+	if (err)
+		goto out;
+
+	le = NULL;
+	attr = ni_find_attr(ni, NULL, &le, ATTR_EA_INFO, NULL, 0, NULL, &mi);
+	if (!attr) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (!size) {
+		/* delete xattr, ATTR_EA_INFO */
+		err = ni_remove_attr_le(ni, attr, le);
+		if (err)
+			goto out;
+	} else {
+		p = resident_data_ex(attr, sizeof(struct EA_INFO));
+		if (!p) {
+			err = -EINVAL;
+			goto out;
+		}
+		memcpy(p, &ea_info, sizeof(struct EA_INFO));
+		mi->dirty = true;
+	}
+
+	le = NULL;
+	attr = ni_find_attr(ni, NULL, &le, ATTR_EA, NULL, 0, NULL, &mi);
+	if (!attr) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (!size) {
+		/* delete xattr, ATTR_EA */
+		err = ni_remove_attr_le(ni, attr, le);
+		if (err)
+			goto out;
+	} else if (attr->non_res) {
+		err = ntfs_sb_write_run(sbi, &ea_run, 0, ea_all, size);
+		if (err)
+			goto out;
+	} else {
+		p = resident_data_ex(attr, size);
+		if (!p) {
+			err = -EINVAL;
+			goto out;
+		}
+		memcpy(p, ea_all, size);
+		mi->dirty = true;
+	}
+
+	if (ea_info.size_pack != size_pack)
+		ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
+	mark_inode_dirty(&ni->vfs_inode);
+
+	/* Check if we delete the last xattr */
+	if (val_size || flags != XATTR_REPLACE ||
+	    ntfs_listxattr_hlp(ni, NULL, 0, &val_size) || val_size) {
+		ni->ni_flags |= NI_FLAG_EA;
+	} else {
+		ni->ni_flags &= ~NI_FLAG_EA;
+	}
+
+out:
+	if (!locked)
+		ni_unlock(ni);
+
+	run_close(&ea_run);
+	ntfs_free(ea_all);
+
+	return err;
+}
+
+static inline void ntfs_posix_acl_release(struct posix_acl *acl)
+{
+	if (acl && refcount_dec_and_test(&acl->a_refcount))
+		kfree(acl);
+}
+
+static struct posix_acl *ntfs_get_acl_ex(struct inode *inode, int type,
+					 int locked)
+{
+	struct ntfs_inode *ni = ntfs_i(inode);
+	const char *name;
+	struct posix_acl *acl;
+	size_t req;
+	int err;
+	void *buf;
+
+	/* allocate PATH_MAX bytes */
+	buf = __getname();
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	/* Possible values of 'type' was already checked above */
+	name = type == ACL_TYPE_ACCESS ? XATTR_NAME_POSIX_ACL_ACCESS :
+					 XATTR_NAME_POSIX_ACL_DEFAULT;
+
+	if (!locked)
+		ni_lock(ni);
+
+	err = ntfs_getxattr_hlp(inode, name, buf, PATH_MAX, &req);
+
+	if (!locked)
+		ni_unlock(ni);
+
+	/* Translate extended attribute to acl */
+	if (err > 0) {
+		acl = posix_acl_from_xattr(&init_user_ns, buf, err);
+		if (!IS_ERR(acl))
+			set_cached_acl(inode, type, acl);
+	} else {
+		acl = err == -ENODATA ? NULL : ERR_PTR(err);
+	}
+
+	__putname(buf);
+
+	return acl;
+}
+
+/*
+ * ntfs_get_acl
+ *
+ * inode_operations::get_acl
+ */
+struct posix_acl *ntfs_get_acl(struct inode *inode, int type)
+{
+	return ntfs_get_acl_ex(inode, type, 0);
+}
+
+static noinline int ntfs_set_acl_ex(struct inode *inode, struct posix_acl *acl,
+				    int type, int locked)
+{
+	const char *name;
+	size_t size;
+	void *value = NULL;
+	int err = 0;
+
+	if (S_ISLNK(inode->i_mode))
+		return -EOPNOTSUPP;
+
+	switch (type) {
+	case ACL_TYPE_ACCESS:
+		if (acl) {
+			umode_t mode = inode->i_mode;
+
+			err = posix_acl_equiv_mode(acl, &mode);
+			if (err < 0)
+				return err;
+
+			if (inode->i_mode != mode) {
+				inode->i_mode = mode;
+				mark_inode_dirty(inode);
+			}
+
+			if (!err) {
+				/*
+				 * acl can be exactly represented in the
+				 * traditional file mode permission bits
+				 */
+				acl = NULL;
+				goto out;
+			}
+		}
+		name = XATTR_NAME_POSIX_ACL_ACCESS;
+		break;
+
+	case ACL_TYPE_DEFAULT:
+		if (!S_ISDIR(inode->i_mode))
+			return acl ? -EACCES : 0;
+		name = XATTR_NAME_POSIX_ACL_DEFAULT;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (!acl)
+		goto out;
+
+	size = posix_acl_xattr_size(acl->a_count);
+	value = ntfs_alloc(size, 0);
+	if (!value)
+		return -ENOMEM;
+
+	err = posix_acl_to_xattr(&init_user_ns, acl, value, size);
+	if (err)
+		goto out;
+
+	err = ntfs_set_ea(inode, name, value, size, 0, locked);
+	if (err)
+		goto out;
+
+	inode->i_flags &= ~S_NOSEC;
+
+out:
+	if (!err)
+		set_cached_acl(inode, type, acl);
+
+	kfree(value);
+
+	return err;
+}
+
+/*
+ * ntfs_set_acl
+ *
+ * inode_operations::set_acl
+ */
+int ntfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+{
+	return ntfs_set_acl_ex(inode, acl, type, 0);
+}
+
+static int ntfs_xattr_get_acl(struct inode *inode, int type, void *buffer,
+			      size_t size)
+{
+	struct super_block *sb = inode->i_sb;
+	struct posix_acl *acl;
+	int err;
+
+	if (!(sb->s_flags & SB_POSIXACL))
+		return -EOPNOTSUPP;
+
+	acl = ntfs_get_acl(inode, type);
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
+
+	if (!acl)
+		return -ENODATA;
+
+	err = posix_acl_to_xattr(&init_user_ns, acl, buffer, size);
+	ntfs_posix_acl_release(acl);
+
+	return err;
+}
+
+static int ntfs_xattr_set_acl(struct inode *inode, int type, const void *value,
+			      size_t size)
+{
+	struct super_block *sb = inode->i_sb;
+	struct posix_acl *acl;
+	int err;
+
+	if (!(sb->s_flags & SB_POSIXACL))
+		return -EOPNOTSUPP;
+
+	if (!inode_owner_or_capable(inode))
+		return -EPERM;
+
+	if (!value)
+		return 0;
+
+	acl = posix_acl_from_xattr(&init_user_ns, value, size);
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
+
+	if (acl) {
+		err = posix_acl_valid(sb->s_user_ns, acl);
+		if (err)
+			goto release_and_out;
+	}
+
+	err = ntfs_set_acl(inode, acl, type);
+
+release_and_out:
+	ntfs_posix_acl_release(acl);
+	return err;
+}
+
+/*
+ * ntfs_acl_chmod
+ *
+ * helper for 'ntfs_setattr'
+ */
+int ntfs_acl_chmod(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	int err;
+
+	if (!(sb->s_flags & SB_POSIXACL))
+		return 0;
+
+	if (S_ISLNK(inode->i_mode))
+		return -EOPNOTSUPP;
+
+	err = posix_acl_chmod(inode, inode->i_mode);
+
+	return err;
+}
+
+/*
+ * ntfs_permission
+ *
+ * inode_operations::permission
+ */
+int ntfs_permission(struct inode *inode, int mask)
+{
+	struct super_block *sb = inode->i_sb;
+	struct ntfs_sb_info *sbi = sb->s_fs_info;
+	int err;
+
+	if (sbi->options.no_acs_rules) {
+		/* "no access rules" mode - allow all changes */
+		return 0;
+	}
+
+	err = generic_permission(inode, mask);
+
+	return err;
+}
+
+/*
+ * ntfs_listxattr
+ *
+ * inode_operations::listxattr
+ */
+ssize_t ntfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ntfs_inode *ni = ntfs_i(inode);
+	ssize_t ret = -1;
+	int err;
+
+	if (!(ni->ni_flags & NI_FLAG_EA)) {
+		ret = 0;
+		goto out;
+	}
+
+	ni_lock(ni);
+
+	err = ntfs_listxattr_hlp(ni, buffer, size, (size_t *)&ret);
+
+	ni_unlock(ni);
+
+	if (err)
+		ret = err;
+out:
+
+	return ret;
+}
+
+static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
+			 struct inode *inode, const char *name, void *buffer,
+			 size_t size)
+{
+	int err;
+	struct ntfs_inode *ni = ntfs_i(inode);
+	size_t name_len = strlen(name);
+
+	/* Dispatch request */
+	if (name_len == sizeof(SYSTEM_DOS_ATTRIB) - 1 &&
+	    !memcmp(name, SYSTEM_DOS_ATTRIB, sizeof(SYSTEM_DOS_ATTRIB))) {
+		/* system.dos_attrib */
+		if (!buffer) {
+			err = sizeof(u8);
+		} else if (size < sizeof(u8)) {
+			err = -ENODATA;
+		} else {
+			err = sizeof(u8);
+			*(u8 *)buffer = le32_to_cpu(ni->std_fa);
+		}
+		goto out;
+	}
+
+	if (name_len == sizeof(SYSTEM_NTFS_ATTRIB) - 1 &&
+	    !memcmp(name, SYSTEM_NTFS_ATTRIB, sizeof(SYSTEM_NTFS_ATTRIB))) {
+		/* system.ntfs_attrib */
+		if (!buffer) {
+			err = sizeof(u32);
+		} else if (size < sizeof(u32)) {
+			err = -ENODATA;
+		} else {
+			err = sizeof(u32);
+			*(u32 *)buffer = le32_to_cpu(ni->std_fa);
+		}
+		goto out;
+	}
+
+	if (name_len == sizeof(USER_DOSATTRIB) - 1 &&
+	    !memcmp(name, USER_DOSATTRIB, sizeof(USER_DOSATTRIB))) {
+		/* user.DOSATTRIB */
+		if (!buffer) {
+			err = 5;
+		} else if (size < 5) {
+			err = -ENODATA;
+		} else {
+			err = sprintf((char *)buffer, "0x%x",
+				      le32_to_cpu(ni->std_fa) & 0xff) +
+			      1;
+		}
+		goto out;
+	}
+
+	if (name_len == sizeof(SYSTEM_NTFS_SECURITY) - 1 &&
+	    !memcmp(name, SYSTEM_NTFS_SECURITY, sizeof(SYSTEM_NTFS_SECURITY))) {
+		/* system.ntfs_security*/
+		struct SECURITY_DESCRIPTOR_RELATIVE *sd = NULL;
+		size_t sd_size = 0;
+
+		if (!is_ntfs3(ni->mi.sbi)) {
+			/* we should get nt4 security */
+			err = -EINVAL;
+			goto out;
+		} else if (le32_to_cpu(ni->std_security_id) <
+			   SECURITY_ID_FIRST) {
+			err = -ENOENT;
+			goto out;
+		}
+
+		err = ntfs_get_security_by_id(ni->mi.sbi, ni->std_security_id,
+					      &sd, &sd_size);
+		if (err)
+			goto out;
+
+		if (!is_sd_valid(sd, sd_size)) {
+			ntfs_inode_warn(
+				inode,
+				"looks like you get incorrect security descriptor id=%u",
+				ni->std_security_id);
+		}
+
+		if (!buffer) {
+			err = sd_size;
+		} else if (size < sd_size) {
+			err = -ENODATA;
+		} else {
+			err = sd_size;
+			memcpy(buffer, sd, sd_size);
+		}
+		ntfs_free(sd);
+		goto out;
+	}
+
+	if ((name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1 &&
+	     !memcmp(name, XATTR_NAME_POSIX_ACL_ACCESS,
+		     sizeof(XATTR_NAME_POSIX_ACL_ACCESS))) ||
+	    (name_len == sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1 &&
+	     !memcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
+		     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT)))) {
+		err = ntfs_xattr_get_acl(
+			inode,
+			name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1 ?
+				ACL_TYPE_ACCESS :
+				ACL_TYPE_DEFAULT,
+			buffer, size);
+	} else {
+		err = ntfs_getxattr_hlp(inode, name, buffer, size, NULL);
+	}
+
+out:
+	return err;
+}
+
+/*
+ * ntfs_setxattr
+ *
+ * inode_operations::setxattr
+ */
+static noinline int ntfs_setxattr(const struct xattr_handler *handler,
+				  struct dentry *de, struct inode *inode,
+				  const char *name, const void *value,
+				  size_t size, int flags)
+{
+	int err = -EINVAL;
+	struct ntfs_inode *ni = ntfs_i(inode);
+	size_t name_len = strlen(name);
+	u32 attrib = 0; /* not necessary just to suppress warnings */
+	__le32 new_fa;
+
+	/* Dispatch request */
+	if (name_len == sizeof(SYSTEM_DOS_ATTRIB) - 1 &&
+	    !memcmp(name, SYSTEM_DOS_ATTRIB, sizeof(SYSTEM_DOS_ATTRIB))) {
+		if (sizeof(u8) != size)
+			goto out;
+		attrib = *(u8 *)value;
+		goto set_dos_attr;
+	}
+
+	if (name_len == sizeof(SYSTEM_NTFS_ATTRIB) - 1 &&
+	    !memcmp(name, SYSTEM_NTFS_ATTRIB, sizeof(SYSTEM_NTFS_ATTRIB))) {
+		if (sizeof(u32) != size)
+			goto out;
+		attrib = *(u32 *)value;
+		goto set_dos_attr;
+	}
+
+	if (name_len == sizeof(USER_DOSATTRIB) - 1 &&
+	    !memcmp(name, USER_DOSATTRIB, sizeof(USER_DOSATTRIB))) {
+		if (size < 4 || ((char *)value)[size - 1])
+			goto out;
+
+		/*
+		 * The input value must be string in form 0x%x with last zero
+		 * This means that the 'size' must be 4, 5, ...
+		 *  E.g: 0x1 - 4 bytes, 0x20 - 5 bytes
+		 */
+		if (sscanf((char *)value, "0x%x", &attrib) != 1)
+			goto out;
+
+set_dos_attr:
+		if (!value)
+			goto out;
+
+		/*
+		 * Thanks Mark Harmstone:
+		 * keep directory bit consistency
+		 */
+		new_fa = cpu_to_le32(attrib);
+		if (S_ISDIR(inode->i_mode))
+			new_fa |= FILE_ATTRIBUTE_DIRECTORY;
+		else
+			new_fa &= ~FILE_ATTRIBUTE_DIRECTORY;
+
+		if (ni->std_fa != new_fa) {
+			ni->std_fa = new_fa;
+			/* std attribute always in primary record */
+			ni->mi.dirty = true;
+			mark_inode_dirty(inode);
+		}
+		err = 0;
+
+		goto out;
+	}
+
+	if (name_len == sizeof(SYSTEM_NTFS_SECURITY) - 1 &&
+	    !memcmp(name, SYSTEM_NTFS_SECURITY, sizeof(SYSTEM_NTFS_SECURITY))) {
+		/* system.ntfs_security*/
+		__le32 security_id;
+		bool inserted;
+		struct ATTR_STD_INFO5 *std;
+
+		if (!is_ntfs3(ni->mi.sbi)) {
+			/*
+			 * we should replace ATTR_SECURE
+			 * Skip this way cause it is nt4 feature
+			 */
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (!is_sd_valid(value, size)) {
+			err = -EINVAL;
+			ntfs_inode_warn(
+				inode,
+				"you try to set invalid security descriptor");
+			goto out;
+		}
+
+		err = ntfs_insert_security(ni->mi.sbi, value, size,
+					   &security_id, &inserted);
+		if (err)
+			goto out;
+
+		ni_lock(ni);
+		std = ni_std5(ni);
+		if (!std) {
+			err = -EINVAL;
+		} else if (std->security_id != security_id) {
+			std->security_id = ni->std_security_id = security_id;
+			/* std attribute always in primary record */
+			ni->mi.dirty = true;
+			mark_inode_dirty(&ni->vfs_inode);
+		}
+		ni_unlock(ni);
+		goto out;
+	}
+
+	if ((name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1 &&
+	     !memcmp(name, XATTR_NAME_POSIX_ACL_ACCESS,
+		     sizeof(XATTR_NAME_POSIX_ACL_ACCESS))) ||
+	    (name_len == sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1 &&
+	     !memcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
+		     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT)))) {
+		err = ntfs_xattr_set_acl(
+			inode,
+			name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1 ?
+				ACL_TYPE_ACCESS :
+				ACL_TYPE_DEFAULT,
+			value, size);
+	} else {
+		err = ntfs_set_ea(inode, name, value, size, flags, 0);
+	}
+
+out:
+	return err;
+}
+
+/*
+ * Initialize the ACLs of a new inode. Called from ntfs_create_inode.
+ */
+int ntfs_init_acl(struct inode *inode, struct inode *dir)
+{
+	struct posix_acl *default_acl, *acl;
+	int err;
+
+	/*
+	 * TODO refactoring lock
+	 * ni_lock(dir) ... -> posix_acl_create(dir,...) -> ntfs_get_acl -> ni_lock(dir)
+	 */
+	inode->i_default_acl = NULL;
+
+	default_acl = ntfs_get_acl_ex(dir, ACL_TYPE_DEFAULT, 1);
+
+	if (!default_acl || default_acl == ERR_PTR(-EOPNOTSUPP)) {
+		inode->i_mode &= ~current_umask();
+		err = 0;
+		goto out;
+	}
+
+	if (IS_ERR(default_acl)) {
+		err = PTR_ERR(default_acl);
+		goto out;
+	}
+
+	acl = default_acl;
+	err = __posix_acl_create(&acl, GFP_NOFS, &inode->i_mode);
+	if (err < 0)
+		goto out1;
+	if (!err) {
+		posix_acl_release(acl);
+		acl = NULL;
+	}
+
+	if (!S_ISDIR(inode->i_mode)) {
+		posix_acl_release(default_acl);
+		default_acl = NULL;
+	}
+
+	if (default_acl)
+		err = ntfs_set_acl_ex(inode, default_acl, ACL_TYPE_DEFAULT, 1);
+
+	if (!acl)
+		inode->i_acl = NULL;
+	else if (!err)
+		err = ntfs_set_acl_ex(inode, acl, ACL_TYPE_ACCESS, 1);
+
+	posix_acl_release(acl);
+out1:
+	posix_acl_release(default_acl);
+
+out:
+	return err;
+}
+
+static bool ntfs_xattr_user_list(struct dentry *dentry)
+{
+	return 1;
+}
+
+static const struct xattr_handler ntfs_xattr_handler = {
+	.prefix = "",
+	.get = ntfs_getxattr,
+	.set = ntfs_setxattr,
+	.list = ntfs_xattr_user_list,
+};
+
+const struct xattr_handler *ntfs_xattr_handlers[] = {
+	&ntfs_xattr_handler,
+	NULL,
+};
-- 
2.25.4

