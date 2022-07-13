Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FB9573B7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 18:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbiGMQp7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 12:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbiGMQpu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:45:50 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E732C669;
        Wed, 13 Jul 2022 09:45:46 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id D2D3D1DDC;
        Wed, 13 Jul 2022 16:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657730676;
        bh=raVitv4uLmBGjDXXskOugDvCAIghEdNUkGSibLI4t/U=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=eiY/UG/C0YTT7vmRhpYY/EPQfI+Knv55P0QCl6iPDXKxBMOCCAwe+kiwDD60OP/GA
         KUWt3W/ePw5ni9uyXoMp+lBlL+j15KEMpQshiwGPYHKkdvKb1Cx2lPL/xG9NK3ayZe
         /kyHdlv3UMJCn1tLzwvsSqwXuUcCn3kqnCPjdMOU=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 5E7F1213E;
        Wed, 13 Jul 2022 16:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657730744;
        bh=raVitv4uLmBGjDXXskOugDvCAIghEdNUkGSibLI4t/U=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=JcsgYFS+dEUKN40DgtikQRFqVyM/0EfgEAssb7md2NTBFm06NQqBROHmhiycMKG9G
         i7x6UoIvf2NuTBUoiqdw9/h96cvN5zSqKrqFRKgF9CjZH7AuV5jc0/wY+RNeU8hIQD
         VGQHEzKMR2HPAwScfNfBLsfekyLWKP/7H8dBheW8=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 13 Jul 2022 19:45:43 +0300
Message-ID: <38c24791-2c5f-0784-efe5-c9055dc99848@paragon-software.com>
Date:   Wed, 13 Jul 2022 19:45:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 2/6] fs/ntfs3: Refactoring attr_set_size to restore after
 errors
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <2101d95b-be41-6e6d-e019-bc70f816b2e8@paragon-software.com>
In-Reply-To: <2101d95b-be41-6e6d-e019-bc70f816b2e8@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Added comments to code
Added two undo labels for restoring after errors

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c | 180 ++++++++++++++++++++++++++++++++--------------
  1 file changed, 126 insertions(+), 54 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index d096d77ea042..7bcae3094712 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -173,7 +173,6 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
  {
  	int err;
  	CLST flen, vcn0 = vcn, pre = pre_alloc ? *pre_alloc : 0;
-	struct wnd_bitmap *wnd = &sbi->used.bitmap;
  	size_t cnt = run->count;
  
  	for (;;) {
@@ -196,9 +195,7 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
  		/* Add new fragment into run storage. */
  		if (!run_add_entry(run, vcn, lcn, flen, opt == ALLOCATE_MFT)) {
  			/* Undo last 'ntfs_look_for_free_space' */
-			down_write_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
-			wnd_set_free(wnd, lcn, flen);
-			up_write(&wnd->rw_lock);
+			mark_as_free_ex(sbi, lcn, len, false);
  			err = -ENOMEM;
  			goto out;
  		}
@@ -419,40 +416,44 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  	struct mft_inode *mi, *mi_b;
  	CLST alen, vcn, lcn, new_alen, old_alen, svcn, evcn;
  	CLST next_svcn, pre_alloc = -1, done = 0;
-	bool is_ext;
+	bool is_ext, is_bad = false;
  	u32 align;
  	struct MFT_REC *rec;
  
  again:
+	alen = 0;
  	le_b = NULL;
  	attr_b = ni_find_attr(ni, NULL, &le_b, type, name, name_len, NULL,
  			      &mi_b);
  	if (!attr_b) {
  		err = -ENOENT;
-		goto out;
+		goto bad_inode;
  	}
  
  	if (!attr_b->non_res) {
  		err = attr_set_size_res(ni, attr_b, le_b, mi_b, new_size, run,
  					&attr_b);
-		if (err || !attr_b->non_res)
-			goto out;
+		if (err)
+			return err;
+
+		/* Return if file is still resident. */
+		if (!attr_b->non_res)
+			goto ok1;
  
  		/* Layout of records may be changed, so do a full search. */
  		goto again;
  	}
  
  	is_ext = is_attr_ext(attr_b);
-
-again_1:
  	align = sbi->cluster_size;
-
  	if (is_ext)
  		align <<= attr_b->nres.c_unit;
  
  	old_valid = le64_to_cpu(attr_b->nres.valid_size);
  	old_size = le64_to_cpu(attr_b->nres.data_size);
  	old_alloc = le64_to_cpu(attr_b->nres.alloc_size);
+
+again_1:
  	old_alen = old_alloc >> cluster_bits;
  
  	new_alloc = (new_size + align - 1) & ~(u64)(align - 1);
@@ -475,24 +476,27 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  		mi = mi_b;
  	} else if (!le_b) {
  		err = -EINVAL;
-		goto out;
+		goto bad_inode;
  	} else {
  		le = le_b;
  		attr = ni_find_attr(ni, attr_b, &le, type, name, name_len, &vcn,
  				    &mi);
  		if (!attr) {
  			err = -EINVAL;
-			goto out;
+			goto bad_inode;
  		}
  
  next_le_1:
  		svcn = le64_to_cpu(attr->nres.svcn);
  		evcn = le64_to_cpu(attr->nres.evcn);
  	}
-
+	/*
+	 * Here we have:
+	 * attr,mi,le - last attribute segment (containing 'vcn').
+	 * attr_b,mi_b,le_b - base (primary) attribute segment.
+	 */
  next_le:
  	rec = mi->mrec;
-
  	err = attr_load_runs(attr, ni, run, NULL);
  	if (err)
  		goto out;
@@ -507,6 +511,13 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  			goto ok;
  		}
  
+		/*
+		 * Add clusters. In simple case we have to:
+		 *  - allocate space (vcn, lcn, len)
+		 *  - update packed run in 'mi'
+		 *  - update attr->nres.evcn
+		 *  - update attr_b->nres.data_size/attr_b->nres.alloc_size
+		 */
  		to_allocate = new_alen - old_alen;
  add_alloc_in_same_attr_seg:
  		lcn = 0;
@@ -520,9 +531,11 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  			pre_alloc = 0;
  			if (type == ATTR_DATA && !name_len &&
  			    sbi->options->prealloc) {
-				CLST new_alen2 = bytes_to_cluster(
-					sbi, get_pre_allocated(new_size));
-				pre_alloc = new_alen2 - new_alen;
+				pre_alloc =
+					bytes_to_cluster(
+						sbi,
+						get_pre_allocated(new_size)) -
+					new_alen;
  			}
  
  			/* Get the last LCN to allocate from. */
@@ -580,7 +593,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  pack_runs:
  		err = mi_pack_runs(mi, attr, run, vcn - svcn);
  		if (err)
-			goto out;
+			goto undo_1;
  
  		next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
  		new_alloc_tmp = (u64)next_svcn << cluster_bits;
@@ -614,7 +627,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  		if (type == ATTR_LIST) {
  			err = ni_expand_list(ni);
  			if (err)
-				goto out;
+				goto undo_2;
  			if (next_svcn < vcn)
  				goto pack_runs;
  
@@ -624,8 +637,9 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  
  		if (!ni->attr_list.size) {
  			err = ni_create_attr_list(ni);
+			/* In case of error layout of records is not changed. */
  			if (err)
-				goto out;
+				goto undo_2;
  			/* Layout of records is changed. */
  		}
  
@@ -638,47 +652,56 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  		err = ni_insert_nonresident(ni, type, name, name_len, run,
  					    next_svcn, vcn - next_svcn,
  					    attr_b->flags, &attr, &mi, NULL);
-		if (err)
-			goto out;
-
-		if (!is_mft)
-			run_truncate_head(run, evcn + 1);
  
-		svcn = le64_to_cpu(attr->nres.svcn);
-		evcn = le64_to_cpu(attr->nres.evcn);
-
-		le_b = NULL;
  		/*
  		 * Layout of records maybe changed.
  		 * Find base attribute to update.
  		 */
+		le_b = NULL;
  		attr_b = ni_find_attr(ni, NULL, &le_b, type, name, name_len,
  				      NULL, &mi_b);
  		if (!attr_b) {
-			err = -ENOENT;
-			goto out;
+			err = -EINVAL;
+			goto bad_inode;
  		}
  
-		attr_b->nres.alloc_size = cpu_to_le64((u64)vcn << cluster_bits);
-		attr_b->nres.data_size = attr_b->nres.alloc_size;
-		attr_b->nres.valid_size = attr_b->nres.alloc_size;
+		if (err) {
+			/* ni_insert_nonresident failed. */
+			attr = NULL;
+			goto undo_2;
+		}
+
+		if (!is_mft)
+			run_truncate_head(run, evcn + 1);
+
+		svcn = le64_to_cpu(attr->nres.svcn);
+		evcn = le64_to_cpu(attr->nres.evcn);
+
+		/*
+		 * Attribute is in consistency state.
+		 * Save this point to restore to if next steps fail.
+		 */
+		old_valid = old_size = old_alloc = (u64)vcn << cluster_bits;
+		attr_b->nres.valid_size = attr_b->nres.data_size =
+			attr_b->nres.alloc_size = cpu_to_le64(old_size);
  		mi_b->dirty = true;
  		goto again_1;
  	}
  
  	if (new_size != old_size ||
  	    (new_alloc != old_alloc && !keep_prealloc)) {
+		/*
+		 * Truncate clusters. In simple case we have to:
+		 *  - update packed run in 'mi'
+		 *  - update attr->nres.evcn
+		 *  - update attr_b->nres.data_size/attr_b->nres.alloc_size
+		 *  - mark and trim clusters as free (vcn, lcn, len)
+		 */
+		CLST dlen = 0;
+
  		vcn = max(svcn, new_alen);
  		new_alloc_tmp = (u64)vcn << cluster_bits;
  
-		alen = 0;
-		err = run_deallocate_ex(sbi, run, vcn, evcn - vcn + 1, &alen,
-					true);
-		if (err)
-			goto out;
-
-		run_truncate(run, vcn);
-
  		if (vcn > svcn) {
  			err = mi_pack_runs(mi, attr, run, vcn - svcn);
  			if (err)
@@ -697,7 +720,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  
  			if (!al_remove_le(ni, le)) {
  				err = -EINVAL;
-				goto out;
+				goto bad_inode;
  			}
  
  			le = (struct ATTR_LIST_ENTRY *)((u8 *)le - le_sz);
@@ -723,12 +746,20 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  				attr_b->nres.valid_size =
  					attr_b->nres.alloc_size;
  		}
+		mi_b->dirty = true;
  
-		if (is_ext)
+		err = run_deallocate_ex(sbi, run, vcn, evcn - vcn + 1, &dlen,
+					true);
+		if (err)
+			goto out;
+
+		if (is_ext) {
+			/* dlen - really deallocated clusters. */
  			le64_sub_cpu(&attr_b->nres.total_size,
-				     ((u64)alen << cluster_bits));
+				     ((u64)dlen << cluster_bits));
+		}
  
-		mi_b->dirty = true;
+		run_truncate(run, vcn);
  
  		if (new_alloc_tmp <= new_alloc)
  			goto ok;
@@ -747,7 +778,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  		if (le->type != type || le->name_len != name_len ||
  		    memcmp(le_name(le), name, name_len * sizeof(short))) {
  			err = -EINVAL;
-			goto out;
+			goto bad_inode;
  		}
  
  		err = ni_load_mi(ni, le, &mi);
@@ -757,7 +788,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  		attr = mi_find_attr(mi, NULL, type, name, name_len, &le->id);
  		if (!attr) {
  			err = -EINVAL;
-			goto out;
+			goto bad_inode;
  		}
  		goto next_le_1;
  	}
@@ -772,13 +803,13 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  		}
  	}
  
-out:
-	if (!err && attr_b && ret)
+ok1:
+	if (ret)
  		*ret = attr_b;
  
  	/* Update inode_set_bytes. */
-	if (!err && ((type == ATTR_DATA && !name_len) ||
-		     (type == ATTR_ALLOC && name == I30_NAME))) {
+	if (((type == ATTR_DATA && !name_len) ||
+	     (type == ATTR_ALLOC && name == I30_NAME))) {
  		bool dirty = false;
  
  		if (ni->vfs_inode.i_size != new_size) {
@@ -786,7 +817,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  			dirty = true;
  		}
  
-		if (attr_b && attr_b->non_res) {
+		if (attr_b->non_res) {
  			new_alloc = le64_to_cpu(attr_b->nres.alloc_size);
  			if (inode_get_bytes(&ni->vfs_inode) != new_alloc) {
  				inode_set_bytes(&ni->vfs_inode, new_alloc);
@@ -800,6 +831,47 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  		}
  	}
  
+	return 0;
+
+undo_2:
+	vcn -= alen;
+	attr_b->nres.data_size = cpu_to_le64(old_size);
+	attr_b->nres.valid_size = cpu_to_le64(old_valid);
+	attr_b->nres.alloc_size = cpu_to_le64(old_alloc);
+
+	/* Restore 'attr' and 'mi'. */
+	if (attr)
+		goto restore_run;
+
+	if (le64_to_cpu(attr_b->nres.svcn) <= svcn &&
+	    svcn <= le64_to_cpu(attr_b->nres.evcn)) {
+		attr = attr_b;
+		le = le_b;
+		mi = mi_b;
+	} else if (!le_b) {
+		err = -EINVAL;
+		goto bad_inode;
+	} else {
+		le = le_b;
+		attr = ni_find_attr(ni, attr_b, &le, type, name, name_len,
+				    &svcn, &mi);
+		if (!attr)
+			goto bad_inode;
+	}
+
+restore_run:
+	if (mi_pack_runs(mi, attr, run, evcn - svcn + 1))
+		is_bad = true;
+
+undo_1:
+	run_deallocate_ex(sbi, run, vcn, alen, NULL, false);
+
+	run_truncate(run, vcn);
+out:
+	if (is_bad) {
+bad_inode:
+		_ntfs_bad_inode(&ni->vfs_inode);
+	}
  	return err;
  }
  
-- 
2.37.0


