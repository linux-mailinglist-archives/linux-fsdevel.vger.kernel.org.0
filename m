Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06C26118CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 19:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiJ1RFO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 13:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiJ1REU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:04:20 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D32D22D5F0;
        Fri, 28 Oct 2022 10:03:56 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 9BA2D218D;
        Fri, 28 Oct 2022 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976475;
        bh=7CPKDDVsSnfhQv2FIDQRZDeSJd/QzjNRDoHBpF6DsHc=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=NHENqJ9QiBWV1u1KbsanQe8xs5FBr8mTnQhxFnENOfFJMFR3mLFu9crLcdCHSBHuH
         0dywRoB4lG8wZlfLFs4ad8ZiC/6j/Iki0Wc2aLbofhBI9fAqPCGPJ0bImQcqUwWEXh
         5UMefF0H9LrLoAieK/OQjaYQcF89i8H5rXFc1zXk=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 97A68DD;
        Fri, 28 Oct 2022 17:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976634;
        bh=7CPKDDVsSnfhQv2FIDQRZDeSJd/QzjNRDoHBpF6DsHc=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=ZtwaZy3jXCrm0t26DkS0rm4OCn2jQRYOZ/50MvH6FSnC1I05902RZAwzuTt22iS0n
         y2927ENmvKF44rdhcUtPpMdoEm0l7B00MjKSwopN/CT9Un/uAScaNI+MdkIrYDB+sS
         0NIVY9BTIykVJvLMpF8PQuPP8AJZHYCZKsxnOifE=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 28 Oct 2022 20:03:54 +0300
Message-ID: <5f006fed-743e-336a-ea14-699c376215e7@paragon-software.com>
Date:   Fri, 28 Oct 2022 20:03:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 05/14] fs/ntfs3: Fixing wrong logic in attr_set_size and
 ntfs_fallocate
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
In-Reply-To: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There were 2 problems:
- in some cases we lost dirty flag;
- cluster allocation can be called even when it wasn't needed.
Fixes xfstest generic/465

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c | 25 +++++++++++--------------
  fs/ntfs3/file.c   | 30 ++++++++++++++++++------------
  fs/ntfs3/index.c  |  9 +++++++++
  fs/ntfs3/inode.c  | 17 +++++------------
  4 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index eda83a37a0c3..91ea73e6f4fe 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -414,6 +414,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  	CLST alen, vcn, lcn, new_alen, old_alen, svcn, evcn;
  	CLST next_svcn, pre_alloc = -1, done = 0;
  	bool is_ext, is_bad = false;
+	bool dirty = false;
  	u32 align;
  	struct MFT_REC *rec;
  
@@ -434,8 +435,10 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  			return err;
  
  		/* Return if file is still resident. */
-		if (!attr_b->non_res)
+		if (!attr_b->non_res) {
+			dirty = true;
  			goto ok1;
+		}
  
  		/* Layout of records may be changed, so do a full search. */
  		goto again;
@@ -458,7 +461,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  
  	if (keep_prealloc && new_size < old_size) {
  		attr_b->nres.data_size = cpu_to_le64(new_size);
-		mi_b->dirty = true;
+		mi_b->dirty = dirty = true;
  		goto ok;
  	}
  
@@ -504,7 +507,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  
  		if (new_alloc <= old_alloc) {
  			attr_b->nres.data_size = cpu_to_le64(new_size);
-			mi_b->dirty = true;
+			mi_b->dirty = dirty = true;
  			goto ok;
  		}
  
@@ -595,7 +598,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  		next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
  		new_alloc_tmp = (u64)next_svcn << cluster_bits;
  		attr_b->nres.alloc_size = cpu_to_le64(new_alloc_tmp);
-		mi_b->dirty = true;
+		mi_b->dirty = dirty = true;
  
  		if (next_svcn >= vcn && !to_allocate) {
  			/* Normal way. Update attribute and exit. */
@@ -681,7 +684,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  		old_valid = old_size = old_alloc = (u64)vcn << cluster_bits;
  		attr_b->nres.valid_size = attr_b->nres.data_size =
  			attr_b->nres.alloc_size = cpu_to_le64(old_size);
-		mi_b->dirty = true;
+		mi_b->dirty = dirty = true;
  		goto again_1;
  	}
  
@@ -743,7 +746,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  				attr_b->nres.valid_size =
  					attr_b->nres.alloc_size;
  		}
-		mi_b->dirty = true;
+		mi_b->dirty = dirty = true;
  
  		err = run_deallocate_ex(sbi, run, vcn, evcn - vcn + 1, &dlen,
  					true);
@@ -804,16 +807,9 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  	if (ret)
  		*ret = attr_b;
  
-	/* Update inode_set_bytes. */
  	if (((type == ATTR_DATA && !name_len) ||
  	     (type == ATTR_ALLOC && name == I30_NAME))) {
-		bool dirty = false;
-
-		if (ni->vfs_inode.i_size != new_size) {
-			ni->vfs_inode.i_size = new_size;
-			dirty = true;
-		}
-
+		/* Update inode_set_bytes. */
  		if (attr_b->non_res) {
  			new_alloc = le64_to_cpu(attr_b->nres.alloc_size);
  			if (inode_get_bytes(&ni->vfs_inode) != new_alloc) {
@@ -822,6 +818,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  			}
  		}
  
+		/* Don't forget to update duplicate information in parent. */
  		if (dirty) {
  			ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
  			mark_inode_dirty(&ni->vfs_inode);
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 63aef132e529..511e58f2b0f8 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -337,7 +337,6 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
  		err = ntfs_set_size(inode, end);
  		if (err)
  			goto out;
-		inode->i_size = end;
  	}
  
  	if (extend_init && !is_compressed(ni)) {
@@ -588,12 +587,14 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
  		if (err)
  			goto out;
  
-		/*
-		 * Allocate clusters, do not change 'valid' size.
-		 */
-		err = ntfs_set_size(inode, new_size);
-		if (err)
-			goto out;
+		if (new_size > i_size) {
+			/*
+			 * Allocate clusters, do not change 'valid' size.
+			 */
+			err = ntfs_set_size(inode, new_size);
+			if (err)
+				goto out;
+		}
  
  		if (is_supported_holes) {
  			CLST vcn = vbo >> sbi->cluster_bits;
@@ -635,6 +636,8 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
  					    &ni->file.run, i_size, &ni->i_valid,
  					    true, NULL);
  			ni_unlock(ni);
+		} else if (new_size > i_size) {
+			inode->i_size = new_size;
  		}
  	}
  
@@ -678,7 +681,7 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
  		goto out;
  
  	if (ia_valid & ATTR_SIZE) {
-		loff_t oldsize = inode->i_size;
+		loff_t newsize, oldsize;
  
  		if (WARN_ON(ni->ni_flags & NI_FLAG_COMPRESSED_MASK)) {
  			/* Should never be here, see ntfs_file_open(). */
@@ -686,16 +689,19 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
  			goto out;
  		}
  		inode_dio_wait(inode);
+		oldsize = inode->i_size;
+		newsize = attr->ia_size;
  
-		if (attr->ia_size <= oldsize)
-			err = ntfs_truncate(inode, attr->ia_size);
-		else if (attr->ia_size > oldsize)
-			err = ntfs_extend(inode, attr->ia_size, 0, NULL);
+		if (newsize <= oldsize)
+			err = ntfs_truncate(inode, newsize);
+		else
+			err = ntfs_extend(inode, newsize, 0, NULL);
  
  		if (err)
  			goto out;
  
  		ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
+		inode->i_size = newsize;
  	}
  
  	setattr_copy(mnt_userns, inode, attr);
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index a2e1e07b5bb8..35369ae5c438 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1445,6 +1445,9 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
  		goto out1;
  	}
  
+	if (in->name == I30_NAME)
+		ni->vfs_inode.i_size = data_size;
+
  	*vbn = bit << indx->idx2vbn_bits;
  
  	return 0;
@@ -1978,6 +1981,9 @@ static int indx_shrink(struct ntfs_index *indx, struct ntfs_inode *ni,
  	if (err)
  		return err;
  
+	if (in->name == I30_NAME)
+		ni->vfs_inode.i_size = new_data;
+
  	bpb = bitmap_size(bit);
  	if (bpb * 8 == nbits)
  		return 0;
@@ -2461,6 +2467,9 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
  
  		err = attr_set_size(ni, ATTR_ALLOC, in->name, in->name_len,
  				    &indx->alloc_run, 0, NULL, false, NULL);
+		if (in->name == I30_NAME)
+			ni->vfs_inode.i_size = 0;
+
  		err = ni_remove_attr(ni, ATTR_ALLOC, in->name, in->name_len,
  				     false, NULL);
  		run_close(&indx->alloc_run);
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 405afb54cc19..78ec3e6bbf67 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -550,17 +550,6 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
  	clear_buffer_new(bh);
  	clear_buffer_uptodate(bh);
  
-	/* Direct write uses 'create=0'. */
-	if (!create && vbo >= ni->i_valid) {
-		/* Out of valid. */
-		return 0;
-	}
-
-	if (vbo >= inode->i_size) {
-		/* Out of size. */
-		return 0;
-	}
-
  	if (is_resident(ni)) {
  		ni_lock(ni);
  		err = attr_data_read_resident(ni, page);
@@ -624,7 +613,6 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
  		}
  	} else if (vbo >= valid) {
  		/* Read out of valid data. */
-		/* Should never be here 'cause already checked. */
  		clear_buffer_mapped(bh);
  	} else if (vbo + bytes <= valid) {
  		/* Normal read. */
@@ -974,6 +962,11 @@ int ntfs_write_end(struct file *file, struct address_space *mapping,
  			dirty = true;
  		}
  
+		if (pos + err > inode->i_size) {
+			inode->i_size = pos + err;
+			dirty = true;
+		}
+
  		if (dirty)
  			mark_inode_dirty(inode);
  	}
-- 
2.37.0


