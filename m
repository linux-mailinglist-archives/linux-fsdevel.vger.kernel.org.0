Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1966724DAF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 18:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgHUQ3w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 12:29:52 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:56478 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727843AbgHUQZi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:25:38 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 4B7A1455;
        Fri, 21 Aug 2020 19:25:22 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598027122;
        bh=h0Vx0Uwc9jIqcsIS7jAHAU5koRi+myalDtiaFGksg2Y=;
        h=From:To:CC:Subject:Date;
        b=eulgS7EkjWz6v+64GjicMUqIb9cZTOSchejnAuGBkrcYcIUHxInu0VkuKY++b6ELW
         xHMiT+rXY/0JzKrEgrRaIfk0WZmOBgPZHtCrJ62snnUJgzcCFtWK2oVvmhvkB9U/B5
         L1HLZQTuLyFtAhXOPJdA61+4ThzVd38s7a8SO3Dw=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 21 Aug 2020 19:25:21 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 21 Aug 2020 19:25:21 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
Subject: [PATCH v2 05/10] fs/ntfs3: Add attrib operations
Thread-Topic: [PATCH v2 05/10] fs/ntfs3: Add attrib operations
Thread-Index: AdZ30y6FatEcY85OSAufRNT3XuT5ZQ==
Date:   Fri, 21 Aug 2020 16:25:21 +0000
Message-ID: <c1cb597c14594bd28141cfc1650841e0@paragon-software.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds attrib operations

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com=
>
---
 fs/ntfs3/attrib.c   | 1285 +++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/attrlist.c |  455 +++++++++++++++
 fs/ntfs3/xattr.c    |  968 ++++++++++++++++++++++++++++++++
 3 files changed, 2708 insertions(+)
 create mode 100644 fs/ntfs3/attrib.c
 create mode 100644 fs/ntfs3/attrlist.c
 create mode 100644 fs/ntfs3/xattr.c

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
new file mode 100644
index 000000000000..fdf72211efea
--- /dev/null
+++ b/fs/ntfs3/attrib.c
@@ -0,0 +1,1285 @@
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
+#ifdef NTFS3_PREALLOCATE
+/*
+ * You can set external NTFS_MIN_LOG2_OF_CLUMP/NTFS_MAX_LOG2_OF_CLUMP to m=
anage
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
+	if (size <=3D NTFS_CLUMP_MIN) {
+		clump =3D 1 << NTFS_MIN_LOG2_OF_CLUMP;
+		align_shift =3D NTFS_MIN_LOG2_OF_CLUMP;
+	} else if (size >=3D NTFS_CLUMP_MAX) {
+		clump =3D 1 << NTFS_MAX_LOG2_OF_CLUMP;
+		align_shift =3D NTFS_MAX_LOG2_OF_CLUMP;
+	} else {
+		align_shift =3D NTFS_MIN_LOG2_OF_CLUMP - 1 +
+			      __ffs(size >> (8 + NTFS_MIN_LOG2_OF_CLUMP));
+		clump =3D 1u << align_shift;
+	}
+
+	ret =3D (((size + clump - 1) >> align_shift)) << align_shift;
+
+	return ret;
+}
+#endif
+
+/*
+ * attr_must_be_resident
+ *
+ * returns true if attribute must be resident
+ */
+static inline bool attr_must_be_resident(ntfs_sb_info *sbi, ATTR_TYPE type=
)
+{
+	const ATTR_DEF_ENTRY *de;
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
+		de =3D ntfs_query_def(sbi, type);
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
+int attr_load_runs(ATTRIB *attr, ntfs_inode *ni, struct runs_tree *run)
+{
+	int err;
+	CLST svcn =3D le64_to_cpu(attr->nres.svcn);
+	CLST evcn =3D le64_to_cpu(attr->nres.evcn);
+	u32 asize;
+	u16 run_off;
+
+	if (svcn >=3D evcn + 1 || run_is_mapped_full(run, svcn, evcn))
+		return 0;
+
+	asize =3D le32_to_cpu(attr->size);
+	run_off =3D le16_to_cpu(attr->nres.run_off);
+	err =3D run_unpack_ex(run, ni->mi.sbi, ni->mi.rno, svcn, evcn,
+			    Add2Ptr(attr, run_off), asize - run_off);
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
+static int run_deallocate_ex(ntfs_sb_info *sbi, struct runs_tree *run, CLS=
T vcn,
+			     CLST len, CLST *done, bool trim)
+{
+	int err =3D 0;
+	CLST vcn0 =3D vcn, lcn, clen, dn =3D 0;
+	size_t idx;
+
+	if (!len)
+		goto out;
+
+	if (!run_lookup_entry(run, vcn, &lcn, &clen, &idx)) {
+failed:
+		run_truncate(run, vcn0);
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	for (;;) {
+		if (clen > len)
+			clen =3D len;
+
+		if (!clen) {
+			err =3D -EINVAL;
+			goto out;
+		}
+
+		if (lcn !=3D SPARSE_LCN) {
+			mark_as_free_ex(sbi, lcn, clen, trim);
+			dn +=3D clen;
+		}
+
+		len -=3D clen;
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
+		*done =3D dn;
+
+	return err;
+}
+
+/*
+ * attr_allocate_clusters
+ *
+ * find free space, mark it as used and store in 'run'
+ */
+int attr_allocate_clusters(ntfs_sb_info *sbi, struct runs_tree *run, CLST =
vcn,
+			   CLST lcn, CLST len, CLST *pre_alloc,
+			   enum ALLOCATE_OPT opt, CLST *alen, const size_t fr,
+			   CLST *new_lcn)
+{
+	int err;
+	CLST flen, vcn0 =3D vcn, pre =3D pre_alloc ? *pre_alloc : 0;
+	wnd_bitmap *wnd =3D &sbi->used.bitmap;
+	size_t cnt =3D run->count;
+
+	for (;;) {
+		err =3D ntfs_look_for_free_space(sbi, lcn, len + pre, &lcn, &flen,
+					       opt);
+
+#ifdef NTFS3_PREALLOCATE
+		if (err =3D=3D -ENOSPC && pre) {
+			pre =3D 0;
+			if (*pre_alloc)
+				*pre_alloc =3D 0;
+			continue;
+		}
+#endif
+
+		if (err)
+			goto out;
+
+		if (new_lcn && vcn =3D=3D vcn0)
+			*new_lcn =3D lcn;
+
+		/* Add new fragment into run storage */
+		if (!run_add_entry(run, vcn, lcn, flen)) {
+			down_write_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
+			wnd_set_free(wnd, lcn, flen);
+			up_write(&wnd->rw_lock);
+			err =3D -ENOMEM;
+			goto out;
+		}
+
+		vcn +=3D flen;
+
+		if (flen >=3D len || opt =3D=3D ALLOCATE_MFT ||
+		    (fr && run->count - cnt >=3D fr)) {
+			*alen =3D vcn - vcn0;
+			return 0;
+		}
+
+		len -=3D flen;
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
+static int attr_set_size_res(ntfs_inode *ni, ATTRIB *attr, u64 new_size,
+			     struct runs_tree *run, ATTRIB **ins_attr)
+{
+	int err =3D 0;
+	mft_inode *mi =3D &ni->mi;
+	ntfs_sb_info *sbi =3D mi->sbi;
+	MFT_REC *rec =3D mi->mrec;
+	u32 used =3D le32_to_cpu(rec->used);
+	u32 asize =3D le32_to_cpu(attr->size);
+	u32 aoff =3D PtrOffset(rec, attr);
+	u32 rsize =3D le32_to_cpu(attr->res.data_size);
+	u32 tail =3D used - aoff - asize;
+	char *next =3D Add2Ptr(attr, asize);
+	int dsize;
+	CLST len, alen;
+	ATTRIB *attr_s =3D NULL;
+	bool is_ext;
+
+	if (new_size >=3D sbi->max_bytes_per_attr)
+		goto resident2nonresident;
+
+	dsize =3D QuadAlign(new_size) - QuadAlign(rsize);
+
+	if (dsize < 0) {
+		char *end =3D Add2Ptr(rec, sbi->record_size);
+
+		/*TODO: is it necessary? check range in case of bad record*/
+		if (next <=3D (char *)rec || next > end ||
+		    next + dsize <=3D (char *)rec || next + dsize + tail > end) {
+			return -EINVAL;
+		}
+
+		memmove(next + dsize, next, tail);
+	} else if (dsize > 0) {
+		if (used + dsize > sbi->max_bytes_per_attr)
+			goto resident2nonresident;
+		memmove(next + dsize, next, tail);
+		memset(next, 0, dsize);
+	}
+
+	rec->used =3D cpu_to_le32(used + dsize);
+	attr->size =3D cpu_to_le32(asize + dsize);
+	attr->res.data_size =3D cpu_to_le32(new_size);
+	mi->dirty =3D true;
+	*ins_attr =3D attr;
+
+	return 0;
+
+resident2nonresident:
+	len =3D bytes_to_cluster(sbi, rsize);
+
+	run_init(run);
+
+	is_ext =3D is_attr_ext(attr);
+
+	if (!len) {
+		alen =3D 0;
+	} else if (is_ext) {
+		if (!run_add_entry(run, 0, SPARSE_LCN, len)) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+		alen =3D len;
+	} else {
+		err =3D attr_allocate_clusters(sbi, run, 0, 0, len, NULL,
+					     ALLOCATE_DEF, &alen, 0, NULL);
+		if (err)
+			goto out;
+
+		err =3D ntfs_sb_write_run(sbi, run, 0, resident_data(attr),
+					rsize);
+		if (err)
+			goto out;
+	}
+
+	attr_s =3D ntfs_memdup(attr, asize);
+	if (!attr_s) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	/*verify(mi_remove_attr(mi, attr));*/
+	used -=3D asize;
+	memmove(attr, Add2Ptr(attr, asize), used - aoff);
+	rec->used =3D cpu_to_le32(used);
+	mi->dirty =3D true;
+
+	err =3D ni_insert_nonresident(ni, attr_s->type, attr_name(attr_s),
+				    attr_s->name_len, run, 0, alen,
+				    attr_s->flags, &attr, NULL);
+	if (err)
+		goto out;
+
+	ntfs_free(attr_s);
+	attr->nres.data_size =3D cpu_to_le64(rsize);
+	attr->nres.valid_size =3D attr->nres.data_size;
+
+	*ins_attr =3D attr;
+
+	if (attr_s->type =3D=3D ATTR_DATA && !attr_s->name_len &&
+	    run =3D=3D &ni->file.run) {
+		ni->ni_flags &=3D ~NI_FLAG_RESIDENT;
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
+		rec->used =3D cpu_to_le32(used + asize);
+		mi->dirty =3D true;
+		ntfs_free(attr_s);
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
+int attr_set_size(ntfs_inode *ni, ATTR_TYPE type, const __le16 *name,
+		  u8 name_len, struct runs_tree *run, u64 new_size,
+		  const u64 *new_valid, bool keep_prealloc, ATTRIB **ret)
+{
+	int err =3D 0;
+	ntfs_sb_info *sbi =3D ni->mi.sbi;
+	u8 cluster_bits =3D sbi->cluster_bits;
+	bool is_mft =3D
+		ni->mi.rno =3D=3D MFT_REC_MFT && type =3D=3D ATTR_DATA && !name_len;
+	u64 old_valid, old_size, old_alloc, new_alloc, new_alloc_tmp;
+	ATTRIB *attr, *attr_b;
+	ATTR_LIST_ENTRY *le, *le_b;
+	mft_inode *mi, *mi_b;
+	CLST alen, vcn, lcn, new_alen, old_alen, svcn, evcn;
+	CLST next_svcn, pre_alloc =3D -1, done =3D 0;
+	bool is_ext;
+	u32 align;
+	MFT_REC *rec;
+
+again:
+	le_b =3D NULL;
+	attr_b =3D ni_find_attr(ni, NULL, &le_b, type, name, name_len, NULL,
+			      &mi_b);
+	if (!attr_b) {
+		err =3D -ENOENT;
+		goto out;
+	}
+
+	if (!attr_b->non_res) {
+		err =3D attr_set_size_res(ni, attr_b, new_size, run, &attr_b);
+		if (err)
+			goto out;
+
+		if (!attr_b->non_res)
+			goto out;
+
+		/* Resident attribute becomes non resident */
+		goto again;
+	}
+
+	is_ext =3D is_attr_ext(attr_b);
+
+again_1:
+
+	if (is_ext) {
+		align =3D 1u << (attr_b->nres.c_unit + cluster_bits);
+		if (is_attr_sparsed(attr_b))
+			keep_prealloc =3D false;
+	} else {
+		align =3D sbi->cluster_size;
+	}
+
+	old_valid =3D le64_to_cpu(attr_b->nres.valid_size);
+	old_size =3D le64_to_cpu(attr_b->nres.data_size);
+	old_alloc =3D le64_to_cpu(attr_b->nres.alloc_size);
+	old_alen =3D old_alloc >> cluster_bits;
+
+	new_alloc =3D (new_size + align - 1) & ~(u64)(align - 1);
+	new_alen =3D new_alloc >> cluster_bits;
+
+	if (keep_prealloc && is_ext)
+		keep_prealloc =3D false;
+
+	if (keep_prealloc && new_size < old_size) {
+		attr_b->nres.data_size =3D cpu_to_le64(new_size);
+		mi_b->dirty =3D true;
+		goto ok;
+	}
+
+	vcn =3D old_alen - 1;
+
+	svcn =3D le64_to_cpu(attr_b->nres.svcn);
+	evcn =3D le64_to_cpu(attr_b->nres.evcn);
+
+	if (svcn <=3D vcn && vcn <=3D evcn) {
+		attr =3D attr_b;
+		le =3D le_b;
+		mi =3D mi_b;
+	} else if (!le_b) {
+		err =3D -EINVAL;
+		goto out;
+	} else {
+		le =3D le_b;
+		attr =3D ni_find_attr(ni, attr_b, &le, type, name, name_len, &vcn,
+				    &mi);
+		if (!attr) {
+			err =3D -EINVAL;
+			goto out;
+		}
+
+next_le_1:
+		svcn =3D le64_to_cpu(attr->nres.svcn);
+		evcn =3D le64_to_cpu(attr->nres.evcn);
+	}
+
+next_le:
+	rec =3D mi->mrec;
+
+	err =3D attr_load_runs(attr, ni, run);
+	if (err)
+		goto out;
+
+	if (new_size > old_size) {
+		CLST to_allocate;
+		size_t cnt, free;
+
+		if (new_alloc <=3D old_alloc) {
+			attr_b->nres.data_size =3D cpu_to_le64(new_size);
+			mi_b->dirty =3D true;
+			goto ok;
+		}
+
+		to_allocate =3D new_alen - old_alen;
+add_alloc_in_same_attr_seg:
+		lcn =3D 0;
+		if (is_mft) {
+			/* mft allocates clusters from mftzone */
+			pre_alloc =3D 0;
+		} else if (is_ext) {
+			/* no preallocate for sparse/compress */
+			pre_alloc =3D 0;
+		} else if (pre_alloc =3D=3D -1) {
+			pre_alloc =3D 0;
+#ifdef NTFS3_PREALLOCATE
+			if (type =3D=3D ATTR_DATA && !name_len) {
+				CLST new_alen2 =3D bytes_to_cluster(
+					sbi, get_pre_allocated(new_size));
+				pre_alloc =3D new_alen2 - new_alen;
+			}
+#endif
+			/* Get the last lcn to allocate from */
+			if (old_alen &&
+			    !run_lookup_entry(run, vcn, &lcn, NULL, NULL)) {
+				lcn =3D SPARSE_LCN;
+			}
+
+			if (lcn =3D=3D SPARSE_LCN)
+				lcn =3D 0;
+			else if (lcn)
+				lcn +=3D 1;
+
+			free =3D wnd_zeroes(&sbi->used.bitmap);
+			if (to_allocate > free) {
+				err =3D -ENOSPC;
+				goto out;
+			}
+
+			if (pre_alloc && to_allocate + pre_alloc > free)
+				pre_alloc =3D 0;
+		}
+
+		vcn =3D old_alen;
+		cnt =3D run->count;
+
+		if (is_ext) {
+			if (!run_add_entry(run, vcn, SPARSE_LCN, to_allocate)) {
+				err =3D -ENOMEM;
+				goto out;
+			}
+			alen =3D to_allocate;
+		} else {
+			/* ~3 bytes per fragment */
+			err =3D attr_allocate_clusters(
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
+		done +=3D alen;
+		vcn +=3D alen;
+		if (to_allocate > alen)
+			to_allocate -=3D alen;
+		else
+			to_allocate =3D 0;
+
+pack_runs:
+		err =3D mi_pack_runs(mi, attr, run, vcn - svcn);
+		if (err)
+			goto out;
+
+		next_svcn =3D le64_to_cpu(attr->nres.evcn) + 1;
+		new_alloc_tmp =3D (u64)next_svcn << cluster_bits;
+		attr_b->nres.alloc_size =3D cpu_to_le64(new_alloc_tmp);
+		mi_b->dirty =3D true;
+
+		if (next_svcn >=3D vcn && !to_allocate) {
+			/* Normal way. update attribute and exit */
+			attr_b->nres.data_size =3D cpu_to_le64(new_size);
+			goto ok;
+		}
+
+		/* at least two mft to avoid recursive loop*/
+		if (is_mft && next_svcn =3D=3D vcn &&
+		    (done << sbi->cluster_bits) >=3D 2 * sbi->record_size) {
+			new_size =3D new_alloc_tmp;
+			attr_b->nres.data_size =3D attr_b->nres.alloc_size;
+			goto ok;
+		}
+
+		if (le32_to_cpu(rec->used) < sbi->record_size) {
+			old_alen =3D next_svcn;
+			evcn =3D old_alen - 1;
+			goto add_alloc_in_same_attr_seg;
+		}
+
+		if (type =3D=3D ATTR_LIST) {
+			err =3D ni_expand_list(ni);
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
+			err =3D ni_create_attr_list(ni);
+			if (err)
+				goto out;
+			/* layout of records is changed */
+		}
+
+		if (next_svcn >=3D vcn)
+			goto again;
+
+		/* insert new attribute segment */
+		err =3D ni_insert_nonresident(ni, type, name, name_len, run,
+					    next_svcn, vcn - next_svcn,
+					    attr_b->flags, &attr, &mi);
+		if (err)
+			goto out;
+
+		if (!is_mft)
+			run_truncate_head(run, evcn + 1);
+
+		svcn =3D le64_to_cpu(attr->nres.svcn);
+		evcn =3D le64_to_cpu(attr->nres.evcn);
+
+		le_b =3D NULL;
+		/* layout of records maybe changed */
+		/* find base attribute to update*/
+		attr_b =3D ni_find_attr(ni, NULL, &le_b, type, name, name_len,
+				      NULL, &mi_b);
+		if (!attr_b) {
+			err =3D -ENOENT;
+			goto out;
+		}
+
+		attr_b->nres.alloc_size =3D cpu_to_le64(vcn << cluster_bits);
+		attr_b->nres.data_size =3D attr_b->nres.alloc_size;
+		attr_b->nres.valid_size =3D attr_b->nres.alloc_size;
+		mi_b->dirty =3D true;
+		goto again_1;
+	}
+
+	if (new_size !=3D old_size ||
+	    (new_alloc !=3D old_alloc && !keep_prealloc)) {
+		vcn =3D max(svcn, new_alen);
+		new_alloc_tmp =3D (u64)vcn << cluster_bits;
+
+		err =3D run_deallocate_ex(sbi, run, vcn, evcn - vcn + 1, &alen,
+					true);
+		if (err)
+			goto out;
+
+		run_truncate(run, vcn);
+
+		if (vcn > svcn) {
+			err =3D mi_pack_runs(mi, attr, run, vcn - svcn);
+			if (err < 0)
+				goto out;
+		} else if (le && le->vcn) {
+			u16 le_sz =3D le16_to_cpu(le->size);
+
+			/*
+			 * NOTE: list entries for one attribute are always
+			 * the same size. We deal with last entry (vcn=3D=3D0)
+			 * and it is not first in entries array
+			 * (list entry for std attribute always first)
+			 * So it is safe to step back
+			 */
+			mi_remove_attr(mi, attr);
+
+			if (!al_remove_le(ni, le)) {
+				err =3D -EINVAL;
+				goto out;
+			}
+
+			le =3D (ATTR_LIST_ENTRY *)((u8 *)le - le_sz);
+		} else {
+			attr->nres.evcn =3D cpu_to_le64((u64)vcn - 1);
+			mi->dirty =3D true;
+		}
+
+		attr_b->nres.alloc_size =3D cpu_to_le64(new_alloc_tmp);
+
+		if (vcn =3D=3D new_alen) {
+			attr_b->nres.data_size =3D cpu_to_le64(new_size);
+			if (new_size < old_valid)
+				attr_b->nres.valid_size =3D
+					attr_b->nres.data_size;
+		} else {
+			if (new_alloc_tmp <=3D
+			    le64_to_cpu(attr_b->nres.data_size))
+				attr_b->nres.data_size =3D
+					attr_b->nres.alloc_size;
+			if (new_alloc_tmp <
+			    le64_to_cpu(attr_b->nres.valid_size))
+				attr_b->nres.valid_size =3D
+					attr_b->nres.alloc_size;
+		}
+
+		if (is_ext)
+			le64_sub_cpu(&attr_b->nres.total_size,
+				     ((u64)alen << cluster_bits));
+
+		mi_b->dirty =3D true;
+
+		if (new_alloc_tmp <=3D new_alloc)
+			goto ok;
+
+		old_size =3D new_alloc_tmp;
+		vcn =3D svcn - 1;
+
+		if (le =3D=3D le_b) {
+			attr =3D attr_b;
+			mi =3D mi_b;
+			evcn =3D svcn - 1;
+			svcn =3D 0;
+			goto next_le;
+		}
+
+		if (le->type !=3D type || le->name_len !=3D name_len ||
+		    memcmp(le_name(le), name, name_len * sizeof(short))) {
+			err =3D -EINVAL;
+			goto out;
+		}
+
+		err =3D ni_load_mi(ni, le, &mi);
+		if (err)
+			goto out;
+
+		attr =3D mi_find_attr(mi, NULL, type, name, name_len, &le->id);
+		if (!attr) {
+			err =3D -EINVAL;
+			goto out;
+		}
+		goto next_le_1;
+	}
+
+ok:
+	if (new_valid) {
+		__le64 valid =3D cpu_to_le64(min(*new_valid, new_size));
+
+		if (attr_b->nres.valid_size !=3D valid) {
+			attr_b->nres.valid_size =3D valid;
+			mi_b->dirty =3D true;
+		}
+	}
+
+out:
+	if (!err && attr_b && ret)
+		*ret =3D attr_b;
+
+	/* update inode_set_bytes*/
+	if (!err && attr_b && attr_b->non_res &&
+	    ((type =3D=3D ATTR_DATA && !name_len) ||
+	     (type =3D=3D ATTR_ALLOC && name =3D=3D I30_NAME))) {
+		ni->vfs_inode.i_size =3D new_size;
+		inode_set_bytes(&ni->vfs_inode,
+				le64_to_cpu(attr_b->nres.alloc_size));
+	}
+
+	return err;
+}
+
+int attr_data_get_block(ntfs_inode *ni, CLST vcn, CLST *lcn, CLST *len,
+			bool *new)
+{
+	int err =3D 0;
+	struct runs_tree *run =3D &ni->file.run;
+	ntfs_sb_info *sbi;
+	u8 cluster_bits;
+	ATTRIB *attr, *attr_b;
+	ATTR_LIST_ENTRY *le, *le_b;
+	mft_inode *mi, *mi_b;
+	CLST hint, svcn, evcn1, new_evcn1, next_svcn;
+	u64 new_size, total_size, new_alloc;
+	u32 clst_per_frame, frame_size;
+	bool ok;
+
+	if (new)
+		*new =3D false;
+
+	down_read(&ni->file.run_lock);
+	ok =3D run_lookup_entry(run, vcn, lcn, len, NULL);
+	up_read(&ni->file.run_lock);
+
+	if (ok && (*lcn !=3D SPARSE_LCN || !new)) {
+		/* normal way */
+		return 0;
+	}
+
+	sbi =3D ni->mi.sbi;
+	cluster_bits =3D sbi->cluster_bits;
+	new_size =3D ((u64)vcn + 1) << cluster_bits;
+
+	ni_lock(ni);
+	down_write(&ni->file.run_lock);
+
+again:
+	le_b =3D NULL;
+	attr_b =3D ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL, 0, NULL, &mi_b)=
;
+	if (!attr_b) {
+		err =3D -ENOENT;
+		goto out;
+	}
+
+	if (!attr_b->non_res) {
+		if (!new) {
+			*lcn =3D RESIDENT_LCN;
+			goto out;
+		}
+
+		err =3D attr_set_size_res(ni, attr_b, new_size, run, &attr_b);
+		if (err)
+			goto out;
+
+		if (!attr_b->non_res) {
+			/* Resident attribute still resident */
+			*lcn =3D RESIDENT_LCN;
+			goto out;
+		}
+
+		/* Resident attribute becomes non resident */
+		goto again;
+	}
+
+	clst_per_frame =3D 1u << attr_b->nres.c_unit;
+	frame_size =3D clst_per_frame << cluster_bits;
+	new_alloc =3D (new_size + frame_size - 1) & ~(u64)(frame_size - 1);
+
+	svcn =3D le64_to_cpu(attr_b->nres.svcn);
+	evcn1 =3D le64_to_cpu(attr_b->nres.evcn) + 1;
+
+	attr =3D attr_b;
+	le =3D le_b;
+	mi =3D mi_b;
+
+	if (le_b && (vcn < svcn || evcn1 <=3D vcn)) {
+		attr =3D ni_find_attr(ni, attr_b, &le, ATTR_DATA, NULL, 0, &vcn,
+				    &mi);
+		if (!attr) {
+			err =3D -EINVAL;
+			goto out;
+		}
+		svcn =3D le64_to_cpu(attr->nres.svcn);
+		evcn1 =3D le64_to_cpu(attr->nres.evcn) + 1;
+	}
+
+	err =3D attr_load_runs(attr, ni, run);
+	if (err)
+		goto out;
+
+	if (!ok) {
+		ok =3D run_lookup_entry(run, vcn, lcn, len, NULL);
+		if (ok && (*lcn !=3D SPARSE_LCN || !new)) {
+			/* normal way */
+			err =3D 0;
+			goto out;
+		}
+	}
+
+	if (!is_attr_ext(attr_b)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	/* Get the last lcn to allocate from */
+	hint =3D 0;
+
+	if (vcn > evcn1) {
+		if (!run_add_entry(run, evcn1, SPARSE_LCN, vcn - evcn1)) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+	} else if (vcn && !run_lookup_entry(run, vcn - 1, &hint, NULL, NULL)) {
+		hint =3D -1;
+	}
+
+	err =3D attr_allocate_clusters(sbi, run, vcn, hint + 1, clst_per_frame,
+				     NULL, 0, len, 0, lcn);
+	if (err)
+		goto out;
+
+	*new =3D true;
+
+	new_evcn1 =3D vcn + clst_per_frame;
+	if (new_evcn1 < evcn1)
+		new_evcn1 =3D evcn1;
+
+	total_size =3D le64_to_cpu(attr_b->nres.total_size) + frame_size;
+
+repack:
+
+	err =3D mi_pack_runs(mi, attr, run, new_evcn1 - svcn);
+	if (err < 0)
+		goto out;
+
+	attr_b->nres.total_size =3D cpu_to_le64(total_size);
+	inode_set_bytes(&ni->vfs_inode, total_size);
+
+	mi_b->dirty =3D true;
+	mark_inode_dirty(&ni->vfs_inode);
+
+	next_svcn =3D le64_to_cpu(attr->nres.evcn) + 1;
+
+	if (next_svcn >=3D evcn1) {
+		/* Normal way. update attribute and exit */
+		goto out;
+	}
+
+	if (!ni->attr_list.le) {
+		err =3D ni_create_attr_list(ni);
+		if (err)
+			goto out;
+		/* layout of records is changed */
+		le_b =3D NULL;
+		attr_b =3D ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL, 0, NULL,
+				      &mi_b);
+		if (!attr_b) {
+			err =3D -ENOENT;
+			goto out;
+		}
+
+		attr =3D attr_b;
+		le =3D le_b;
+		mi =3D mi_b;
+		goto repack;
+	}
+
+	/* Estimate next attribute */
+	attr =3D ni_find_attr(ni, attr, &le, ATTR_DATA, NULL, 0, &evcn1, &mi);
+
+	if (attr && le32_to_cpu(mi->mrec->used) + 8 <=3D sbi->record_size) {
+		svcn =3D next_svcn;
+		evcn1 =3D le64_to_cpu(attr->nres.evcn) + 1;
+
+		err =3D attr_load_runs(attr, ni, run);
+		if (err)
+			goto out;
+
+		attr->nres.svcn =3D cpu_to_le64(svcn);
+		err =3D mi_pack_runs(mi, attr, run, evcn1 - svcn);
+		if (err < 0)
+			goto out;
+
+		le->vcn =3D cpu_to_le64(svcn);
+
+		mi->dirty =3D true;
+
+		next_svcn =3D le64_to_cpu(attr->nres.evcn) + 1;
+
+		if (next_svcn >=3D evcn1) {
+			/* Normal way. update attribute and exit */
+			goto out;
+		}
+	}
+
+	err =3D ni_insert_nonresident(ni, ATTR_DATA, NULL, 0, run, next_svcn,
+				    evcn1 - next_svcn, attr_b->flags, &attr,
+				    &mi);
+	if (err)
+		goto out;
+
+	run_truncate_head(run, vcn);
+
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
+int attr_load_runs_vcn(ntfs_inode *ni, ATTR_TYPE type, const __le16 *name,
+		       u8 name_len, struct runs_tree *run, CLST vcn)
+{
+	ATTRIB *attr;
+	int err;
+	CLST svcn, evcn;
+	u16 ro;
+
+	attr =3D ni_find_attr(ni, NULL, NULL, type, name, name_len, &vcn, NULL);
+	if (!attr)
+		return -ENOENT;
+
+	svcn =3D le64_to_cpu(attr->nres.svcn);
+	evcn =3D le64_to_cpu(attr->nres.evcn);
+
+	if (evcn < vcn || vcn < svcn)
+		return -EINVAL;
+
+	ro =3D le16_to_cpu(attr->nres.run_off);
+	err =3D run_unpack_ex(run, ni->mi.sbi, ni->mi.rno, svcn, evcn,
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
+int attr_is_frame_compressed(ntfs_inode *ni, ATTRIB *attr, CLST frame,
+			     CLST *clst_data, bool *is_compr)
+{
+	int err;
+	u32 clst_frame;
+	CLST len, lcn, vcn, alen, slen, vcn1;
+	size_t idx;
+	struct runs_tree *run;
+
+	*clst_data =3D 0;
+	*is_compr =3D false;
+
+	if (!is_attr_compressed(attr))
+		return 0;
+
+	if (!attr->non_res)
+		return 0;
+
+	clst_frame =3D 1u << attr->nres.c_unit;
+	vcn =3D frame * clst_frame;
+	run =3D &ni->file.run;
+
+	if (!run_lookup_entry(run, vcn, &lcn, &len, &idx)) {
+		err =3D attr_load_runs_vcn(ni, attr->type, attr_name(attr),
+					 attr->name_len, run, vcn);
+		if (err)
+			return err;
+
+		if (!run_lookup_entry(run, vcn, &lcn, &len, &idx))
+			return -ENOENT;
+	}
+
+	if (lcn =3D=3D SPARSE_LCN) {
+		/* The frame is sparsed if "clst_frame" clusters are sparsed */
+		*is_compr =3D true;
+		return 0;
+	}
+
+	if (len >=3D clst_frame) {
+		/*
+		 * The frame is not compressed 'cause
+		 * it does not contain any sparse clusters
+		 */
+		*clst_data =3D clst_frame;
+		return 0;
+	}
+
+	alen =3D bytes_to_cluster(ni->mi.sbi, le64_to_cpu(attr->nres.alloc_size))=
;
+	slen =3D 0;
+	*clst_data =3D len;
+
+	/*
+	 * The frame is compressed if *clst_data + slen >=3D clst_frame
+	 * Check next fragments
+	 */
+	while ((vcn +=3D len) < alen) {
+		vcn1 =3D vcn;
+
+		if (!run_get_entry(run, ++idx, &vcn, &lcn, &len) ||
+		    vcn1 !=3D vcn) {
+			err =3D attr_load_runs_vcn(ni, attr->type,
+						 attr_name(attr),
+						 attr->name_len, run, vcn1);
+			if (err)
+				return err;
+			vcn =3D vcn1;
+
+			if (!run_lookup_entry(run, vcn, &lcn, &len, &idx))
+				return -ENOENT;
+		}
+
+		if (lcn =3D=3D SPARSE_LCN)
+			slen +=3D len;
+		else {
+			if (slen) {
+				/*
+				 * data_clusters + sparse_clusters =3D
+				 * not enough for frame
+				 */
+				return -EINVAL;
+			}
+			*clst_data +=3D len;
+		}
+
+		if (*clst_data + slen >=3D clst_frame) {
+			if (!slen) {
+				/*
+				 * There is no sparsed clusters in this frame
+				 * So it is not compressed
+				 */
+				*clst_data =3D clst_frame;
+			} else
+				*is_compr =3D *clst_data < clst_frame;
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
+ */
+int attr_allocate_frame(ntfs_inode *ni, CLST frame, size_t compr_size,
+			u64 new_valid)
+{
+	int err =3D 0;
+	struct runs_tree *run =3D &ni->file.run;
+	ntfs_sb_info *sbi =3D ni->mi.sbi;
+	ATTRIB *attr, *attr_b;
+	ATTR_LIST_ENTRY *le, *le_b;
+	mft_inode *mi, *mi_b;
+	CLST svcn, evcn1, next_svcn, lcn, len;
+	CLST vcn, clst_data;
+	u64 total_size, valid_size, data_size;
+	bool is_compr;
+
+	le_b =3D NULL;
+	attr_b =3D ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL, 0, NULL, &mi_b)=
;
+	if (!attr_b)
+		return -ENOENT;
+
+	if (!is_attr_ext(attr_b))
+		return -EINVAL;
+
+	vcn =3D frame << NTFS_LZNT_CUNIT;
+	total_size =3D le64_to_cpu(attr_b->nres.total_size);
+
+	svcn =3D le64_to_cpu(attr_b->nres.svcn);
+	evcn1 =3D le64_to_cpu(attr_b->nres.evcn) + 1;
+	data_size =3D le64_to_cpu(attr_b->nres.data_size);
+
+	if (svcn <=3D vcn && vcn < evcn1) {
+		attr =3D attr_b;
+		le =3D le_b;
+		mi =3D mi_b;
+	} else if (!le_b) {
+		err =3D -EINVAL;
+		goto out;
+	} else {
+		le =3D le_b;
+		attr =3D ni_find_attr(ni, attr_b, &le, ATTR_DATA, NULL, 0, &vcn,
+				    &mi);
+		if (!attr) {
+			err =3D -EINVAL;
+			goto out;
+		}
+
+		svcn =3D le64_to_cpu(attr->nres.svcn);
+		evcn1 =3D le64_to_cpu(attr->nres.evcn) + 1;
+	}
+
+	err =3D attr_load_runs(attr, ni, run);
+	if (err)
+		goto out;
+
+	err =3D attr_is_frame_compressed(ni, attr_b, frame, &clst_data,
+				       &is_compr);
+	if (err)
+		goto out;
+
+	total_size -=3D clst_data << sbi->cluster_bits;
+
+	len =3D bytes_to_cluster(sbi, compr_size);
+
+	if (len =3D=3D clst_data)
+		goto out;
+
+	if (len < clst_data) {
+		err =3D run_deallocate_ex(sbi, run, vcn + len, clst_data - len,
+					NULL, true);
+		if (err)
+			goto out;
+
+		if (!run_add_entry(run, vcn + len, SPARSE_LCN,
+				   clst_data - len)) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+	} else {
+		CLST alen, hint;
+		/* Get the last lcn to allocate from */
+		if (vcn + clst_data &&
+		    !run_lookup_entry(run, vcn + clst_data - 1, &hint, NULL,
+				      NULL)) {
+			hint =3D -1;
+		}
+
+		err =3D attr_allocate_clusters(sbi, run, vcn + clst_data,
+					     hint + 1, len - clst_data, NULL, 0,
+					     &alen, 0, &lcn);
+		if (err)
+			goto out;
+	}
+
+	total_size +=3D len << sbi->cluster_bits;
+
+repack:
+	err =3D mi_pack_runs(mi, attr, run, evcn1 - svcn);
+	if (err < 0)
+		goto out;
+
+	attr_b->nres.total_size =3D cpu_to_le64(total_size);
+	inode_set_bytes(&ni->vfs_inode, total_size);
+
+	mi_b->dirty =3D true;
+	mark_inode_dirty(&ni->vfs_inode);
+
+	next_svcn =3D le64_to_cpu(attr->nres.evcn) + 1;
+
+	if (next_svcn >=3D evcn1) {
+		/* Normal way. update attribute and exit */
+		goto out;
+	}
+
+	if (!ni->attr_list.size) {
+		err =3D ni_create_attr_list(ni);
+		if (err)
+			goto out;
+		/* layout of records is changed */
+		le_b =3D NULL;
+		attr_b =3D ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL, 0, NULL,
+				      &mi_b);
+		if (!attr_b) {
+			err =3D -ENOENT;
+			goto out;
+		}
+
+		attr =3D attr_b;
+		le =3D le_b;
+		mi =3D mi_b;
+		goto repack;
+	}
+
+	/* Estimate next attribute */
+	attr =3D ni_find_attr(ni, attr, &le, ATTR_DATA, NULL, 0, &evcn1, &mi);
+
+	if (attr && le32_to_cpu(mi->mrec->used) + 8 <=3D sbi->record_size) {
+		svcn =3D next_svcn;
+		evcn1 =3D le64_to_cpu(attr->nres.evcn) + 1;
+
+		err =3D attr_load_runs(attr, ni, run);
+		if (err)
+			goto out;
+
+		attr->nres.svcn =3D cpu_to_le64(svcn);
+		err =3D mi_pack_runs(mi, attr, run, evcn1 - svcn);
+		if (err < 0)
+			goto out;
+
+		le->vcn =3D cpu_to_le64(svcn);
+
+		mi->dirty =3D true;
+
+		next_svcn =3D le64_to_cpu(attr->nres.evcn) + 1;
+
+		if (next_svcn >=3D evcn1) {
+			/* Normal way. update attribute and exit */
+			goto out;
+		}
+	}
+
+	err =3D ni_insert_nonresident(ni, ATTR_DATA, NULL, 0, run, next_svcn,
+				    evcn1 - next_svcn, attr_b->flags, &attr,
+				    &mi);
+	if (err)
+		goto out;
+
+	run_truncate_head(run, vcn);
+
+out:
+	if (new_valid > data_size)
+		new_valid =3D data_size;
+
+	valid_size =3D le64_to_cpu(attr_b->nres.valid_size);
+	if (new_valid !=3D valid_size) {
+		attr_b->nres.valid_size =3D cpu_to_le64(valid_size);
+		mi_b->dirty =3D true;
+	}
+
+	return err;
+}
diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
new file mode 100644
index 000000000000..3b86572a2585
--- /dev/null
+++ b/fs/ntfs3/attrlist.c
@@ -0,0 +1,455 @@
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
+static inline bool al_is_valid_le(const ntfs_inode *ni, ATTR_LIST_ENTRY *l=
e)
+{
+	if (!le || !ni->attr_list.le || !ni->attr_list.size)
+		return false;
+
+	return PtrOffset(ni->attr_list.le, le) + le16_to_cpu(le->size) <=3D
+	       ni->attr_list.size;
+}
+
+void al_destroy(ntfs_inode *ni)
+{
+	run_close(&ni->attr_list.run);
+	ntfs_free(ni->attr_list.le);
+	ni->attr_list.le =3D NULL;
+	ni->attr_list.size =3D 0;
+	ni->attr_list.dirty =3D false;
+}
+
+/*
+ * ntfs_load_attr_list
+ *
+ * This method makes sure that the ATTRIB list, if present,
+ * has been properly set up.
+ */
+int ntfs_load_attr_list(ntfs_inode *ni, ATTRIB *attr)
+{
+	int err;
+	size_t lsize;
+	void *le =3D NULL;
+
+	if (ni->attr_list.size)
+		return 0;
+
+	if (!attr->non_res) {
+		lsize =3D le32_to_cpu(attr->res.data_size);
+		le =3D ntfs_alloc(al_aligned(lsize), 0);
+		if (!le) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+		memcpy(le, resident_data(attr), lsize);
+	} else if (attr->nres.svcn) {
+		err =3D -EINVAL;
+		goto out;
+	} else {
+		u16 run_off =3D le16_to_cpu(attr->nres.run_off);
+
+		lsize =3D le64_to_cpu(attr->nres.data_size);
+
+		run_init(&ni->attr_list.run);
+
+		err =3D run_unpack_ex(&ni->attr_list.run, ni->mi.sbi, ni->mi.rno,
+				    0, le64_to_cpu(attr->nres.evcn),
+				    Add2Ptr(attr, run_off),
+				    le32_to_cpu(attr->size) - run_off);
+		if (err < 0)
+			goto out;
+
+		le =3D ntfs_alloc(al_aligned(lsize), 0);
+		if (!le) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+
+		err =3D ntfs_read_run_nb(ni->mi.sbi, &ni->attr_list.run, 0, le,
+				       lsize, NULL);
+		if (err)
+			goto out;
+	}
+
+	ni->attr_list.size =3D lsize;
+	ni->attr_list.le =3D le;
+
+	return 0;
+
+out:
+	ni->attr_list.le =3D le;
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
+ATTR_LIST_ENTRY *al_enumerate(ntfs_inode *ni, ATTR_LIST_ENTRY *le)
+{
+	size_t off;
+	u16 sz;
+
+	if (!le) {
+		le =3D ni->attr_list.le;
+	} else {
+		sz =3D le16_to_cpu(le->size);
+		if (sz < sizeof(ATTR_LIST_ENTRY)) {
+			/* Impossible 'cause we should not return such le */
+			return NULL;
+		}
+		le =3D Add2Ptr(le, sz);
+	}
+
+	/* Check boundary */
+	off =3D PtrOffset(ni->attr_list.le, le);
+	if (off + sizeof(ATTR_LIST_ENTRY) > ni->attr_list.size) {
+		// The regular end of list
+		return NULL;
+	}
+
+	sz =3D le16_to_cpu(le->size);
+
+	/* Check le for errors */
+	if (sz < sizeof(ATTR_LIST_ENTRY) || off + sz > ni->attr_list.size ||
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
+ATTR_LIST_ENTRY *al_find_le(ntfs_inode *ni, ATTR_LIST_ENTRY *le,
+			    const ATTRIB *attr)
+{
+	CLST svcn =3D attr_svcn(attr);
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
+ATTR_LIST_ENTRY *al_find_ex(ntfs_inode *ni, ATTR_LIST_ENTRY *le, ATTR_TYPE=
 type,
+			    const __le16 *name, u8 name_len, const CLST *vcn)
+{
+	ATTR_LIST_ENTRY *ret =3D NULL;
+	u32 type_in =3D le32_to_cpu(type);
+
+	while ((le =3D al_enumerate(ni, le))) {
+		u64 le_vcn;
+		int diff;
+
+		/* List entries are sorted by type, name and vcn */
+		diff =3D le32_to_cpu(le->type) - type_in;
+		if (diff < 0)
+			continue;
+
+		if (diff > 0)
+			return ret;
+
+		if (le->name_len !=3D name_len)
+			continue;
+
+		if (name_len &&
+		    memcmp(le_name(le), name, name_len * sizeof(short)))
+			continue;
+
+		if (!vcn)
+			return le;
+
+		le_vcn =3D le64_to_cpu(le->vcn);
+		if (*vcn =3D=3D le_vcn)
+			return le;
+
+		if (*vcn < le_vcn)
+			return ret;
+
+		ret =3D le;
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
+static ATTR_LIST_ENTRY *al_find_le_to_insert(ntfs_inode *ni, ATTR_TYPE typ=
e,
+					     const __le16 *name, u8 name_len,
+					     const CLST *vcn)
+{
+	ATTR_LIST_ENTRY *le =3D NULL, *prev;
+	u32 type_in =3D le32_to_cpu(type);
+	int diff;
+
+	/* List entries are sorted by type, name, vcn */
+next:
+	le =3D al_enumerate(ni, prev =3D le);
+	if (!le)
+		goto out;
+	diff =3D le32_to_cpu(le->type) - type_in;
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
+		le =3D prev ? Add2Ptr(prev, le16_to_cpu(prev->size)) :
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
+int al_add_le(ntfs_inode *ni, ATTR_TYPE type, const __le16 *name, u8 name_=
len,
+	      CLST svcn, __le16 id, const MFT_REF *ref,
+	      ATTR_LIST_ENTRY **new_le)
+{
+	int err;
+	ATTRIB *attr;
+	ATTR_LIST_ENTRY *le;
+	size_t off;
+	u16 sz;
+	size_t asize, new_asize;
+	u64 new_size;
+	typeof(ni->attr_list) *al =3D &ni->attr_list;
+
+	/*
+	 * Compute the size of the new le and the new length of the
+	 * list with al le added.
+	 */
+	sz =3D le_size(name_len);
+	new_size =3D al->size + sz;
+	asize =3D al_aligned(al->size);
+	new_asize =3D al_aligned(new_size);
+
+	/* Scan forward to the point at which the new le should be inserted. */
+	le =3D al_find_le_to_insert(ni, type, name, name_len, &svcn);
+	off =3D PtrOffset(al->le, le);
+
+	if (new_size > asize) {
+		void *ptr =3D ntfs_alloc(new_asize, 0);
+
+		if (!ptr)
+			return -ENOMEM;
+
+		memcpy(ptr, al->le, off);
+		memcpy(Add2Ptr(ptr, off + sz), le, al->size - off);
+		le =3D Add2Ptr(ptr, off);
+		ntfs_free(al->le);
+		al->le =3D ptr;
+	} else {
+		memmove(Add2Ptr(le, sz), le, al->size - off);
+	}
+
+	al->size =3D new_size;
+
+	le->type =3D type;
+	le->size =3D cpu_to_le16(sz);
+	le->name_len =3D name_len;
+	le->name_off =3D offsetof(ATTR_LIST_ENTRY, name);
+	le->vcn =3D cpu_to_le64(svcn);
+	le->ref =3D *ref;
+	le->id =3D id;
+	memcpy(le->name, name, sizeof(short) * name_len);
+
+	al->dirty =3D true;
+
+	err =3D attr_set_size(ni, ATTR_LIST, NULL, 0, &al->run, new_size,
+			    &new_size, true, &attr);
+	if (err)
+		return err;
+
+	if (attr && attr->non_res) {
+		err =3D ntfs_sb_write_run(ni->mi.sbi, &al->run, 0, al->le,
+					al->size);
+		if (err)
+			return err;
+	}
+
+	al->dirty =3D false;
+	*new_le =3D le;
+
+	return 0;
+}
+
+/*
+ * al_remove_le
+ *
+ * removes 'le' from attribute list
+ */
+bool al_remove_le(ntfs_inode *ni, ATTR_LIST_ENTRY *le)
+{
+	u16 size;
+	size_t off;
+	typeof(ni->attr_list) *al =3D &ni->attr_list;
+
+	if (!al_is_valid_le(ni, le))
+		return false;
+
+	/* Save on stack the size of le */
+	size =3D le16_to_cpu(le->size);
+	off =3D PtrOffset(al->le, le);
+
+	memmove(le, Add2Ptr(le, size), al->size - (off + size));
+
+	al->size -=3D size;
+	al->dirty =3D true;
+
+	return true;
+}
+
+/*
+ * al_delete_le
+ *
+ * deletes from the list the first le which matches its parameters.
+ */
+bool al_delete_le(ntfs_inode *ni, ATTR_TYPE type, CLST vcn, const __le16 *=
name,
+		  size_t name_len, const MFT_REF *ref)
+{
+	u16 size;
+	ATTR_LIST_ENTRY *le;
+	size_t off;
+	typeof(ni->attr_list) *al =3D &ni->attr_list;
+
+	/* Scan forward to the first le that matches the input */
+	le =3D al_find_ex(ni, NULL, type, name, name_len, &vcn);
+	if (!le)
+		return false;
+
+	off =3D PtrOffset(al->le, le);
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
+	if (off + sizeof(ATTR_LIST_ENTRY) > al->size)
+		goto del;
+	if (le->type !=3D type)
+		goto del;
+	if (le->name_len !=3D name_len)
+		goto del;
+	if (name_len &&
+	    memcmp(name, Add2Ptr(le, le->name_off), name_len * sizeof(short)))
+		goto del;
+	if (le64_to_cpu(le->vcn) !=3D vcn)
+		goto del;
+	if (!memcmp(ref, &le->ref, sizeof(*ref)))
+		goto del;
+
+	off +=3D le16_to_cpu(le->size);
+	le =3D Add2Ptr(al->le, off);
+	goto next;
+
+del:
+	/*
+	 * If we've gone off the end of the list, or if the type, name,
+	 * and vcn don't match, then we don't have any matching records.
+	 */
+	if (off >=3D al->size)
+		return false;
+	if (le->type !=3D type)
+		return false;
+	if (le->name_len !=3D name_len)
+		return false;
+	if (name_len &&
+	    memcmp(name, Add2Ptr(le, le->name_off), name_len * sizeof(short)))
+		return false;
+	if (le64_to_cpu(le->vcn) !=3D vcn)
+		return false;
+
+	/* Save on stack the size of le */
+	size =3D le16_to_cpu(le->size);
+	/* Delete the le. */
+	memmove(le, Add2Ptr(le, size), al->size - (off + size));
+
+	al->size -=3D size;
+	al->dirty =3D true;
+	return true;
+}
+
+/*
+ * al_update
+ *
+ *
+ */
+int al_update(ntfs_inode *ni)
+{
+	int err;
+	ntfs_sb_info *sbi =3D ni->mi.sbi;
+	ATTRIB *attr;
+	typeof(ni->attr_list) *al =3D &ni->attr_list;
+
+	if (!al->dirty)
+		return 0;
+
+	err =3D attr_set_size(ni, ATTR_LIST, NULL, 0, &al->run, al->size, NULL,
+			    false, &attr);
+	if (err)
+		goto out;
+
+	if (!attr->non_res)
+		memcpy(resident_data(attr), al->le, al->size);
+	else {
+		err =3D ntfs_sb_write_run(sbi, &al->run, 0, al->le, al->size);
+		if (err)
+			goto out;
+
+		attr->nres.valid_size =3D attr->nres.data_size;
+	}
+
+	ni->mi.dirty =3D true;
+	al->dirty =3D false;
+
+out:
+	return err;
+}
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
new file mode 100644
index 000000000000..c26e6b141b64
--- /dev/null
+++ b/fs/ntfs3/xattr.c
@@ -0,0 +1,968 @@
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
+#define SYSTEM_DOS_ATTRIB "system.dos_attrib"
+#define SYSTEM_NTFS_ATTRIB "system.ntfs_attrib"
+#define SYSTEM_NTFS_ATTRIB_BE "system.ntfs_attrib_be"
+#define SAMBA_PROCESS_NAME "smbd"
+#define USER_DOSATTRIB "user.DOSATTRIB"
+
+static inline size_t unpacked_ea_size(const EA_FULL *ea)
+{
+	return !ea->size ? DwordAlign(offsetof(EA_FULL, name) + 1 +
+				      ea->name_len + le16_to_cpu(ea->elength)) :
+			   le32_to_cpu(ea->size);
+}
+
+static inline size_t packed_ea_size(const EA_FULL *ea)
+{
+	return offsetof(EA_FULL, name) + 1 - offsetof(EA_FULL, flags) +
+	       ea->name_len + le16_to_cpu(ea->elength);
+}
+
+/*
+ * find_ea
+ *
+ * assume there is at least one xattr in the list
+ */
+static inline bool find_ea(const EA_FULL *ea_all, u32 bytes, const char *n=
ame,
+			   u8 name_len, u32 *off)
+{
+	*off =3D 0;
+
+	if (!ea_all || !bytes)
+		return false;
+
+	for (;;) {
+		const EA_FULL *ea =3D Add2Ptr(ea_all, *off);
+		u32 next_off =3D *off + unpacked_ea_size(ea);
+
+		if (next_off > bytes)
+			return false;
+
+		if (ea->name_len =3D=3D name_len &&
+		    !memcmp(ea->name, name, name_len))
+			return true;
+
+		*off =3D next_off;
+		if (next_off >=3D bytes)
+			return false;
+	}
+}
+
+/*
+ * ntfs_read_ea
+ *
+ * reads all xattrs
+ * ea - new allocated memory
+ * info - pointer into resident data
+ */
+static int ntfs_read_ea(ntfs_inode *ni, EA_FULL **ea, size_t add_bytes,
+			const EA_INFO **info)
+{
+	int err;
+	ATTR_LIST_ENTRY *le =3D NULL;
+	ATTRIB *attr_info, *attr_ea;
+	void *ea_p;
+	u32 size;
+
+	static_assert(le32_to_cpu(ATTR_EA_INFO) < le32_to_cpu(ATTR_EA));
+
+	*ea =3D NULL;
+	*info =3D NULL;
+
+	attr_info =3D
+		ni_find_attr(ni, NULL, &le, ATTR_EA_INFO, NULL, 0, NULL, NULL);
+	attr_ea =3D
+		ni_find_attr(ni, attr_info, &le, ATTR_EA, NULL, 0, NULL, NULL);
+
+	if (!attr_ea || !attr_info)
+		return 0;
+
+	*info =3D resident_data_ex(attr_info, sizeof(EA_INFO));
+	if (!*info)
+		return -EINVAL;
+
+	/* Check Ea limit */
+	size =3D le32_to_cpu((*info)->size);
+	if (size > MAX_EA_DATA_SIZE || size + add_bytes > MAX_EA_DATA_SIZE)
+		return -EINVAL;
+
+	/* Allocate memory for packed Ea */
+	ea_p =3D ntfs_alloc(size + add_bytes, 0);
+	if (!ea_p)
+		return -ENOMEM;
+
+	if (attr_ea->non_res) {
+		struct runs_tree run;
+
+		run_init(&run);
+
+		err =3D attr_load_runs(attr_ea, ni, &run);
+		if (!err)
+			err =3D ntfs_read_run_nb(ni->mi.sbi, &run, 0, ea_p, size,
+					       NULL);
+		run_close(&run);
+
+		if (err)
+			goto out;
+	} else {
+		void *p =3D resident_data_ex(attr_ea, size);
+
+		if (!p) {
+			err =3D -EINVAL;
+			goto out;
+		}
+		memcpy(ea_p, p, size);
+	}
+
+	memset(Add2Ptr(ea_p, size), 0, add_bytes);
+	*ea =3D ea_p;
+	return 0;
+
+out:
+	ntfs_free(ea_p);
+	*ea =3D NULL;
+	return err;
+}
+
+/*
+ * ntfs_listxattr_hlp
+ *
+ * copy a list of xattrs names into the buffer
+ * provided, or compute the buffer size required
+ */
+static int ntfs_listxattr_hlp(ntfs_inode *ni, char *buffer,
+			      size_t bytes_per_buffer, size_t *bytes)
+{
+	const EA_INFO *info;
+	EA_FULL *ea_all =3D NULL;
+	const EA_FULL *ea;
+	u32 off, size;
+	int err;
+
+	*bytes =3D 0;
+
+	err =3D ntfs_read_ea(ni, &ea_all, 0, &info);
+	if (err)
+		return err;
+
+	if (!info)
+		return 0;
+
+	size =3D le32_to_cpu(info->size);
+
+	if (!ea_all)
+		return 0;
+
+	/* Enumerate all xattrs */
+	off =3D 0;
+next_ea:
+	if (off >=3D size)
+		goto out;
+
+	ea =3D Add2Ptr(ea_all, off);
+
+	if (!buffer)
+		goto skip_ea;
+
+	if (*bytes + ea->name_len + 1 > bytes_per_buffer) {
+		err =3D -ERANGE;
+		goto out;
+	}
+
+	memcpy(buffer + *bytes, ea->name, ea->name_len);
+	buffer[*bytes + ea->name_len] =3D 0;
+
+skip_ea:
+	*bytes +=3D ea->name_len + 1;
+	off +=3D unpacked_ea_size(ea);
+	goto next_ea;
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
+static int ntfs_get_ea(ntfs_inode *ni, const char *name, size_t name_len,
+		       void *buffer, size_t bytes_per_buffer, u32 *len)
+{
+	const EA_INFO *info;
+	EA_FULL *ea_all =3D NULL;
+	const EA_FULL *ea;
+	u32 off;
+	int err;
+
+	*len =3D 0;
+
+	if (name_len > 255) {
+		err =3D -ENAMETOOLONG;
+		goto out;
+	}
+
+	err =3D ntfs_read_ea(ni, &ea_all, 0, &info);
+	if (err)
+		goto out;
+
+	if (!info)
+		goto out;
+
+	/* Enumerate all xattrs */
+	if (!find_ea(ea_all, le32_to_cpu(info->size), name, name_len, &off)) {
+		err =3D -ENODATA;
+		goto out;
+	}
+	ea =3D Add2Ptr(ea_all, off);
+
+	*len =3D le16_to_cpu(ea->elength);
+	if (!buffer) {
+		err =3D 0;
+		goto out;
+	}
+
+	if (*len > bytes_per_buffer) {
+		err =3D -ERANGE;
+		goto out;
+	}
+	memcpy(buffer, ea->name + ea->name_len + 1, *len);
+	err =3D 0;
+
+out:
+	ntfs_free(ea_all);
+
+	return err;
+}
+
+static noinline int ntfs_getxattr_hlp(struct inode *inode, const char *nam=
e,
+				      void *value, size_t size,
+				      size_t *required)
+{
+	ntfs_inode *ni =3D ntfs_i(inode);
+	int err;
+	u32 len;
+
+	if (!(ni->ni_flags & NI_FLAG_EA))
+		return -ENODATA;
+
+	if (!required)
+		ni_lock(ni);
+
+	err =3D ntfs_get_ea(ni, name, strlen(name), value, size, &len);
+	if (!err)
+		err =3D len;
+	else if (-ERANGE =3D=3D err && required)
+		*required =3D len;
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
+	ntfs_inode *ni =3D ntfs_i(inode);
+	ntfs_sb_info *sbi =3D ni->mi.sbi;
+	int err;
+	EA_INFO ea_info;
+	const EA_INFO *info;
+	EA_FULL *new_ea;
+	EA_FULL *ea_all =3D NULL;
+	size_t name_len, add;
+	u32 off, size;
+	ATTRIB *attr;
+	ATTR_LIST_ENTRY *le;
+	mft_inode *mi;
+	struct runs_tree ea_run;
+	u64 new_sz;
+	void *p;
+
+	if (!locked)
+		ni_lock(ni);
+
+	run_init(&ea_run);
+	name_len =3D strlen(name);
+
+	if (name_len > 255) {
+		err =3D -ENAMETOOLONG;
+		goto out;
+	}
+
+	add =3D DwordAlign(offsetof(EA_FULL, name) + 1 + name_len + val_size);
+
+	err =3D ntfs_read_ea(ni, &ea_all, add, &info);
+	if (err)
+		goto out;
+
+	if (!info) {
+		memset(&ea_info, 0, sizeof(ea_info));
+		size =3D 0;
+	} else {
+		memcpy(&ea_info, info, sizeof(ea_info));
+		size =3D le32_to_cpu(ea_info.size);
+	}
+
+	if (info && find_ea(ea_all, size, name, name_len, &off)) {
+		EA_FULL *ea;
+		size_t ea_sz;
+
+		if (flags & XATTR_CREATE) {
+			err =3D -EEXIST;
+			goto out;
+		}
+
+		/* Remove current xattr */
+		ea =3D Add2Ptr(ea_all, off);
+		if (ea->flags & FILE_NEED_EA)
+			le16_add_cpu(&ea_info.count, -1);
+
+		ea_sz =3D unpacked_ea_size(ea);
+
+		le16_add_cpu(&ea_info.size_pack, 0 - packed_ea_size(ea));
+
+		memmove(ea, Add2Ptr(ea, ea_sz), size - off - ea_sz);
+
+		size -=3D ea_sz;
+		memset(Add2Ptr(ea_all, size), 0, ea_sz);
+
+		ea_info.size =3D cpu_to_le32(size);
+
+		if ((flags & XATTR_REPLACE) && !val_size)
+			goto update_ea;
+	} else {
+		if (flags & XATTR_REPLACE) {
+			err =3D -ENODATA;
+			goto out;
+		}
+
+		if (!ea_all) {
+			ea_all =3D ntfs_alloc(add, 1);
+			if (!ea_all) {
+				err =3D -ENOMEM;
+				goto out;
+			}
+		}
+	}
+
+	/* append new xattr */
+	new_ea =3D Add2Ptr(ea_all, size);
+	new_ea->size =3D cpu_to_le32(add);
+	new_ea->flags =3D 0;
+	new_ea->name_len =3D name_len;
+	new_ea->elength =3D cpu_to_le16(val_size);
+	memcpy(new_ea->name, name, name_len);
+	new_ea->name[name_len] =3D 0;
+	memcpy(new_ea->name + name_len + 1, value, val_size);
+
+	le16_add_cpu(&ea_info.size_pack, packed_ea_size(new_ea));
+	size +=3D add;
+	ea_info.size =3D cpu_to_le32(size);
+
+update_ea:
+
+	if (!info) {
+		/* Create xattr */
+		if (!size) {
+			err =3D 0;
+			goto out;
+		}
+
+		err =3D ni_insert_resident(ni, sizeof(EA_INFO), ATTR_EA_INFO,
+					 NULL, 0, NULL, NULL);
+		if (err)
+			goto out;
+
+		err =3D ni_insert_resident(ni, 0, ATTR_EA, NULL, 0, NULL, NULL);
+		if (err)
+			goto out;
+	}
+
+	new_sz =3D size;
+	err =3D attr_set_size(ni, ATTR_EA, NULL, 0, &ea_run, new_sz, &new_sz,
+			    false, NULL);
+	if (err)
+		goto out;
+
+	le =3D NULL;
+	attr =3D ni_find_attr(ni, NULL, &le, ATTR_EA_INFO, NULL, 0, NULL, &mi);
+	if (!attr) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	if (!size) {
+		/* delete xattr, ATTR_EA_INFO */
+		err =3D ni_remove_attr_le(ni, attr, le);
+		if (err)
+			goto out;
+	} else {
+		p =3D resident_data_ex(attr, sizeof(EA_INFO));
+		if (!p) {
+			err =3D -EINVAL;
+			goto out;
+		}
+		memcpy(p, &ea_info, sizeof(EA_INFO));
+		mi->dirty =3D true;
+	}
+
+	le =3D NULL;
+	attr =3D ni_find_attr(ni, NULL, &le, ATTR_EA, NULL, 0, NULL, &mi);
+	if (!attr) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	if (!size) {
+		/* delete xattr, ATTR_EA */
+		err =3D ni_remove_attr_le(ni, attr, le);
+		if (err)
+			goto out;
+	} else if (attr->non_res) {
+		err =3D ntfs_sb_write_run(sbi, &ea_run, 0, ea_all, size);
+		if (err)
+			goto out;
+	} else {
+		p =3D resident_data_ex(attr, size);
+		if (!p) {
+			err =3D -EINVAL;
+			goto out;
+		}
+		memcpy(p, ea_all, size);
+		mi->dirty =3D true;
+	}
+
+	ni->ni_flags |=3D NI_FLAG_UPDATE_PARENT;
+	mark_inode_dirty(&ni->vfs_inode);
+
+	/* Check if we delete the last xattr */
+	if (val_size || flags !=3D XATTR_REPLACE ||
+	    ntfs_listxattr_hlp(ni, NULL, 0, &val_size) || val_size) {
+		ni->ni_flags |=3D NI_FLAG_EA;
+	} else {
+		ni->ni_flags &=3D ~NI_FLAG_EA;
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
+	ntfs_inode *ni =3D ntfs_i(inode);
+	const char *name;
+	struct posix_acl *acl;
+	size_t req;
+	int err;
+	void *buf;
+
+	buf =3D __getname();
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	/* Possible values of 'type' was already checked above */
+	name =3D type =3D=3D ACL_TYPE_ACCESS ? XATTR_NAME_POSIX_ACL_ACCESS :
+					 XATTR_NAME_POSIX_ACL_DEFAULT;
+
+	if (!locked)
+		ni_lock(ni);
+
+	err =3D ntfs_getxattr_hlp(inode, name, buf, PATH_MAX, &req);
+
+	if (!locked)
+		ni_unlock(ni);
+
+	/* Translate extended attribute to acl */
+	if (err > 0) {
+		acl =3D posix_acl_from_xattr(&init_user_ns, buf, err);
+		if (!IS_ERR(acl))
+			set_cached_acl(inode, type, acl);
+	} else {
+		acl =3D err =3D=3D -ENODATA ? NULL : ERR_PTR(err);
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
+	struct posix_acl *acl;
+	ntfs_inode *ni =3D ntfs_i(inode);
+
+	ni_lock(ni);
+
+	acl =3D ntfs_get_acl_ex(inode, type, 0);
+
+	ni_unlock(ni);
+
+	return acl;
+}
+
+static int ntfs_set_acl_ex(struct inode *inode, struct posix_acl *acl, int=
 type,
+			   int locked)
+{
+	const char *name;
+	size_t size;
+	void *value =3D NULL;
+	int err =3D 0;
+
+	if (S_ISLNK(inode->i_mode))
+		return -EOPNOTSUPP;
+
+	switch (type) {
+	case ACL_TYPE_ACCESS:
+		if (acl) {
+			umode_t mode =3D inode->i_mode;
+
+			err =3D posix_acl_equiv_mode(acl, &mode);
+			if (err < 0)
+				return err;
+
+			if (inode->i_mode !=3D mode) {
+				inode->i_mode =3D mode;
+				mark_inode_dirty(inode);
+			}
+
+			if (!err) {
+				/*
+				 * acl can be exactly represented in the
+				 * traditional file mode permission bits
+				 */
+				acl =3D NULL;
+				goto out;
+			}
+		}
+		name =3D XATTR_NAME_POSIX_ACL_ACCESS;
+		break;
+
+	case ACL_TYPE_DEFAULT:
+		if (!S_ISDIR(inode->i_mode))
+			return acl ? -EACCES : 0;
+		name =3D XATTR_NAME_POSIX_ACL_DEFAULT;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (!acl)
+		goto out;
+
+	size =3D posix_acl_xattr_size(acl->a_count);
+	value =3D ntfs_alloc(size, 0);
+	if (!value)
+		return -ENOMEM;
+
+	err =3D posix_acl_to_xattr(&init_user_ns, acl, value, size);
+	if (err)
+		goto out;
+
+	err =3D ntfs_set_ea(inode, name, value, size, 0, locked);
+	if (err)
+		goto out;
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
+	int err;
+	ntfs_inode *ni =3D ntfs_i(inode);
+
+	ni_lock(ni);
+
+	err =3D ntfs_set_acl_ex(inode, acl, type, 0);
+
+	ni_unlock(ni);
+
+	return err;
+}
+
+static int ntfs_xattr_get_acl(struct inode *inode, int type, void *buffer,
+			      size_t size)
+{
+	struct super_block *sb =3D inode->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	struct posix_acl *acl;
+	int err;
+
+	if (!sbi->options.acl)
+		return -EOPNOTSUPP;
+
+	acl =3D ntfs_get_acl(inode, type);
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
+
+	if (!acl)
+		return -ENODATA;
+
+	err =3D posix_acl_to_xattr(&init_user_ns, acl, buffer, size);
+	ntfs_posix_acl_release(acl);
+
+	return err;
+}
+
+static int ntfs_xattr_set_acl(struct inode *inode, int type, const void *v=
alue,
+			      size_t size)
+{
+	struct super_block *sb =3D inode->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	struct posix_acl *acl;
+	int err;
+
+	if (!sbi->options.acl)
+		return -EOPNOTSUPP;
+
+	if (!inode_owner_or_capable(inode))
+		return -EPERM;
+
+	if (!value)
+		return 0;
+
+	acl =3D posix_acl_from_xattr(&init_user_ns, value, size);
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
+
+	if (acl) {
+		err =3D posix_acl_valid(sb->s_user_ns, acl);
+		if (err)
+			goto release_and_out;
+	}
+
+	err =3D ntfs_set_acl(inode, acl, type);
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
+	struct super_block *sb =3D inode->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	int err;
+
+	if (!sbi->options.acl)
+		return 0;
+
+	if (S_ISLNK(inode->i_mode))
+		return -EOPNOTSUPP;
+
+	err =3D posix_acl_chmod(inode, inode->i_mode);
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
+	struct super_block *sb =3D inode->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	int err;
+
+	if (sbi->options.no_acs_rules) {
+		/* "no access rules" mode - allow all changes */
+		return 0;
+	}
+
+	err =3D generic_permission(inode, mask);
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
+	struct inode *inode =3D d_inode(dentry);
+	ntfs_inode *ni =3D ntfs_i(inode);
+	ssize_t ret =3D -1;
+	int err;
+
+	if (!(ni->ni_flags & NI_FLAG_EA)) {
+		ret =3D 0;
+		goto out;
+	}
+
+	ni_lock(ni);
+
+	err =3D ntfs_listxattr_hlp(ni, buffer, size, (size_t *)&ret);
+
+	ni_unlock(ni);
+
+	if (err)
+		ret =3D err;
+out:
+
+	return ret;
+}
+
+static int ntfs_getxattr(const struct xattr_handler *handler, struct dentr=
y *de,
+			 struct inode *inode, const char *name, void *buffer,
+			 size_t size)
+{
+	int err;
+	ntfs_inode *ni =3D ntfs_i(inode);
+	struct super_block *sb =3D inode->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	size_t name_len =3D strlen(name);
+
+	/* Dispatch request */
+	if (name_len =3D=3D sizeof(SYSTEM_DOS_ATTRIB) - 1 &&
+	    !memcmp(name, SYSTEM_DOS_ATTRIB, sizeof(SYSTEM_DOS_ATTRIB))) {
+		/* system.dos_attrib */
+		if (!buffer)
+			err =3D sizeof(u8);
+		else if (size < sizeof(u8))
+			err =3D -ENODATA;
+		else {
+			err =3D sizeof(u8);
+			*(u8 *)buffer =3D le32_to_cpu(ni->std_fa);
+		}
+		goto out;
+	}
+
+	if (name_len =3D=3D sizeof(SYSTEM_NTFS_ATTRIB) - 1 &&
+	    !memcmp(name, SYSTEM_NTFS_ATTRIB, sizeof(SYSTEM_NTFS_ATTRIB))) {
+		/* system.ntfs_attrib */
+		if (!buffer)
+			err =3D sizeof(u32);
+		else if (size < sizeof(u32))
+			err =3D -ENODATA;
+		else {
+			err =3D sizeof(u32);
+			*(u32 *)buffer =3D le32_to_cpu(ni->std_fa);
+		}
+		goto out;
+	}
+
+	if (name_len =3D=3D sizeof(SYSTEM_NTFS_ATTRIB_BE) - 1 &&
+	    !memcmp(name, SYSTEM_NTFS_ATTRIB_BE,
+		    sizeof(SYSTEM_NTFS_ATTRIB_BE))) {
+		/* system.ntfs_attrib_be */
+		if (!buffer)
+			err =3D sizeof(u32);
+		else if (size < sizeof(u32))
+			err =3D -ENODATA;
+		else {
+			err =3D sizeof(u32);
+			*(__be32 *)buffer =3D
+				cpu_to_be32(le32_to_cpu(ni->std_fa));
+		}
+		goto out;
+	}
+
+	if (name_len =3D=3D sizeof(USER_DOSATTRIB) - 1 &&
+	    !memcmp(current->comm, SAMBA_PROCESS_NAME,
+		    sizeof(SAMBA_PROCESS_NAME)) &&
+	    !memcmp(name, USER_DOSATTRIB, sizeof(USER_DOSATTRIB))) {
+		/* user.DOSATTRIB */
+		if (!buffer)
+			err =3D 5;
+		else if (size < 5)
+			err =3D -ENODATA;
+		else {
+			err =3D sprintf((char *)buffer, "0x%x",
+				      le32_to_cpu(ni->std_fa) & 0xff) +
+			      1;
+		}
+		goto out;
+	}
+
+	if ((name_len =3D=3D sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1 &&
+	     !memcmp(name, XATTR_NAME_POSIX_ACL_ACCESS,
+		     sizeof(XATTR_NAME_POSIX_ACL_ACCESS))) ||
+	    (name_len =3D=3D sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1 &&
+	     !memcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
+		     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT)))) {
+		err =3D sbi->options.acl ?
+			      ntfs_xattr_get_acl(
+				      inode,
+				      name_len =3D=3D sizeof(XATTR_NAME_POSIX_ACL_ACCESS) -
+							      1 ?
+					      ACL_TYPE_ACCESS :
+					      ACL_TYPE_DEFAULT,
+				      buffer, size) :
+			      -EOPNOTSUPP;
+		goto out;
+	}
+
+	err =3D ntfs_getxattr_hlp(inode, name, buffer, size, NULL);
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
+	int err =3D -EINVAL;
+	ntfs_inode *ni =3D ntfs_i(inode);
+	size_t name_len =3D strlen(name);
+	u32 attrib =3D 0; /* not necessary just to suppress warnings */
+	struct super_block *sb =3D inode->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+
+	/* Dispatch request */
+	if (name_len =3D=3D sizeof(SYSTEM_DOS_ATTRIB) - 1 &&
+	    !memcmp(name, SYSTEM_DOS_ATTRIB, sizeof(SYSTEM_DOS_ATTRIB))) {
+		if (sizeof(u8) !=3D size)
+			goto out;
+		attrib =3D *(u8 *)value;
+		goto set_dos_attr;
+	}
+
+	if (name_len =3D=3D sizeof(SYSTEM_NTFS_ATTRIB) - 1 &&
+	    !memcmp(name, SYSTEM_NTFS_ATTRIB, sizeof(SYSTEM_NTFS_ATTRIB))) {
+		if (sizeof(u32) !=3D size)
+			goto out;
+		attrib =3D *(u32 *)value;
+		goto set_dos_attr;
+	}
+
+	if (name_len =3D=3D sizeof(SYSTEM_NTFS_ATTRIB_BE) - 1 &&
+	    !memcmp(name, SYSTEM_NTFS_ATTRIB_BE,
+		    sizeof(SYSTEM_NTFS_ATTRIB_BE))) {
+		if (sizeof(u32) !=3D size)
+			goto out;
+		attrib =3D be32_to_cpu(*(__be32 *)value);
+		goto set_dos_attr;
+	}
+
+	if (name_len =3D=3D sizeof(USER_DOSATTRIB) - 1 &&
+	    !memcmp(current->comm, SAMBA_PROCESS_NAME,
+		    sizeof(SAMBA_PROCESS_NAME)) &&
+	    !memcmp(name, USER_DOSATTRIB, sizeof(USER_DOSATTRIB))) {
+		if (size < 4 || ((char *)value)[size - 1])
+			goto out;
+
+		/*
+		 * The input value must be string in form 0x%x with last zero
+		 * This means that the 'size' must be 4, 5, ...
+		 *  E.g: 0x1 - 4 bytes, 0x20 - 5 bytes
+		 */
+		if (sscanf((char *)value, "0x%x", &attrib) !=3D 1)
+			goto out;
+
+set_dos_attr:
+		if (!value)
+			goto out;
+
+		ni->std_fa =3D cpu_to_le32(attrib);
+		mark_inode_dirty(inode);
+		err =3D 0;
+
+		goto out;
+	}
+
+	if ((name_len =3D=3D sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1 &&
+	     !memcmp(name, XATTR_NAME_POSIX_ACL_ACCESS,
+		     sizeof(XATTR_NAME_POSIX_ACL_ACCESS))) ||
+	    (name_len =3D=3D sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1 &&
+	     !memcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
+		     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT)))) {
+		err =3D sbi->options.acl ?
+			      ntfs_xattr_set_acl(
+				      inode,
+				      name_len =3D=3D sizeof(XATTR_NAME_POSIX_ACL_ACCESS) -
+							      1 ?
+					      ACL_TYPE_ACCESS :
+					      ACL_TYPE_DEFAULT,
+				      value, size) :
+			      -EOPNOTSUPP;
+		goto out;
+	}
+
+	err =3D ntfs_set_ea(inode, name, value, size, flags, 0);
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
+static const struct xattr_handler ntfs_xattr_handler =3D {
+	.prefix =3D "",
+	.get =3D ntfs_getxattr,
+	.set =3D ntfs_setxattr,
+	.list =3D ntfs_xattr_user_list,
+};
+
+const struct xattr_handler *ntfs_xattr_handlers[] =3D { &ntfs_xattr_handle=
r,
+						      NULL };
--=20
2.25.2

