Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E0555314D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 13:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347849AbiFULpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 07:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiFULpM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:45:12 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF5C29CB8;
        Tue, 21 Jun 2022 04:45:10 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id A52751D4B;
        Tue, 21 Jun 2022 11:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1655811859;
        bh=7NS4O+ZSA8MS21mYwjsrNrmn+TQh2D/GYXNbxwpoTLQ=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=U7940P36aC19+458PvCxUzYFY+kuPXBqBWx4fhwE4LoTBvQUVfjOXJlfq7BKpte+z
         T9CB1CtkLVQTCRDcIqJFF1UktfcCf+fiH4Ux1EAXAhrOisLY8HLwKQhFLtOmrp4V1Z
         Gqdaa6Sw3hNenEnYATWBwSF+Rwp4LusduyXqdkvU=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 6B7A31FED;
        Tue, 21 Jun 2022 11:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1655811908;
        bh=7NS4O+ZSA8MS21mYwjsrNrmn+TQh2D/GYXNbxwpoTLQ=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=ra7hTaJ18l8sz4GOzy9Yx2M8zSOzau4LynPQtpK3rfRBCLTOzvxvGA+LcPOc0ie34
         KeRA0nLY9PlzF8Ys4regr0bzbUUa/DT2UUZ/8rwCghoL6QQw6LxRUTO13sMt9MD3ZK
         MwVfcVd+8O8MDIEfD7okXSQ6fOQ/XkZ63gsGNYTU=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 21 Jun 2022 14:45:08 +0300
Message-ID: <15ef7c0e-32d4-d3db-0b22-d5f0c1341894@paragon-software.com>
Date:   Tue, 21 Jun 2022 14:45:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: [PATCH 1/2] fs/ntfs3: Fallocate (FALLOC_FL_INSERT_RANGE)
 implementation
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <ab1c8348-acde-114f-eb66-0074045731a4@paragon-software.com>
In-Reply-To: <ab1c8348-acde-114f-eb66-0074045731a4@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add functions for inserting hole in file and inserting range in run.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c  | 176 +++++++++++++++++++++++++++++++++++++++++++++
  fs/ntfs3/ntfs_fs.h |   4 +-
  fs/ntfs3/run.c     |  43 +++++++++++
  3 files changed, 222 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index fc0623b029e6..86e688b95ad5 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -2081,3 +2081,179 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
  
  	return err;
  }
+
+/*
+ * attr_insert_range - Insert range (hole) in file.
+ * Not for normal files.
+ */
+int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
+{
+	int err = 0;
+	struct runs_tree *run = &ni->file.run;
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
+	struct ATTRIB *attr = NULL, *attr_b;
+	struct ATTR_LIST_ENTRY *le, *le_b;
+	struct mft_inode *mi, *mi_b;
+	CLST vcn, svcn, evcn1, len, next_svcn;
+	u64 data_size, alloc_size;
+	u32 mask;
+	__le16 a_flags;
+
+	if (!bytes)
+		return 0;
+
+	le_b = NULL;
+	attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL, 0, NULL, &mi_b);
+	if (!attr_b)
+		return -ENOENT;
+
+	if (!is_attr_ext(attr_b)) {
+		/* It was checked above. See fallocate. */
+		return -EOPNOTSUPP;
+	}
+
+	if (!attr_b->non_res) {
+		data_size = le32_to_cpu(attr_b->res.data_size);
+		mask = sbi->cluster_mask; /* cluster_size - 1 */
+	} else {
+		data_size = le64_to_cpu(attr_b->nres.data_size);
+		mask = (sbi->cluster_size << attr_b->nres.c_unit) - 1;
+	}
+
+	if (vbo > data_size) {
+		/* Insert range after the file size is not allowed. */
+		return -EINVAL;
+	}
+
+	if ((vbo & mask) || (bytes & mask)) {
+		/* Allow to insert only frame aligned ranges. */
+		return -EINVAL;
+	}
+
+	vcn = vbo >> sbi->cluster_bits;
+	len = bytes >> sbi->cluster_bits;
+
+	down_write(&ni->file.run_lock);
+
+	if (!attr_b->non_res) {
+		err = attr_set_size(ni, ATTR_DATA, NULL, 0, run,
+				    data_size + bytes, NULL, false, &attr);
+		if (err)
+			goto out;
+		if (!attr->non_res) {
+			/* Still resident. */
+			char *data = Add2Ptr(attr, attr->res.data_off);
+
+			memmove(data + bytes, data, bytes);
+			memset(data, 0, bytes);
+			err = 0;
+			goto out;
+		}
+		/* Resident files becomes nonresident. */
+		le_b = NULL;
+		attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL, 0, NULL,
+				      &mi_b);
+		if (!attr_b)
+			return -ENOENT;
+		if (!attr_b->non_res) {
+			err = -EINVAL;
+			goto out;
+		}
+		data_size = le64_to_cpu(attr_b->nres.data_size);
+		alloc_size = le64_to_cpu(attr_b->nres.alloc_size);
+	}
+
+	/*
+	 * Enumerate all attribute segments and shift start vcn.
+	 */
+	a_flags = attr_b->flags;
+	svcn = le64_to_cpu(attr_b->nres.svcn);
+	evcn1 = le64_to_cpu(attr_b->nres.evcn) + 1;
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
+
+		svcn = le64_to_cpu(attr->nres.svcn);
+		evcn1 = le64_to_cpu(attr->nres.evcn) + 1;
+	}
+
+	run_truncate(run, 0); /* clear cached values. */
+	err = attr_load_runs(attr, ni, run, NULL);
+	if (err)
+		goto out;
+
+	if (!run_insert_range(run, vcn, len)) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* Try to pack in current record as much as possible. */
+	err = mi_pack_runs(mi, attr, run, evcn1 + len - svcn);
+	if (err)
+		goto out;
+
+	next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
+	run_truncate_head(run, next_svcn);
+
+	while ((attr = ni_enum_attr_ex(ni, attr, &le, &mi)) &&
+	       attr->type == ATTR_DATA && !attr->name_len) {
+		le64_add_cpu(&attr->nres.svcn, len);
+		le64_add_cpu(&attr->nres.evcn, len);
+		if (le) {
+			le->vcn = attr->nres.svcn;
+			ni->attr_list.dirty = true;
+		}
+		mi->dirty = true;
+	}
+
+	/*
+	 * Update primary attribute segment in advance.
+	 * pointer attr_b may become invalid (layout of mft is changed)
+	 */
+	if (vbo <= ni->i_valid)
+		ni->i_valid += bytes;
+
+	attr_b->nres.data_size = le64_to_cpu(data_size + bytes);
+	attr_b->nres.alloc_size = le64_to_cpu(alloc_size + bytes);
+
+	/* ni->valid may be not equal valid_size (temporary). */
+	if (ni->i_valid > data_size + bytes)
+		attr_b->nres.valid_size = attr_b->nres.data_size;
+	else
+		attr_b->nres.valid_size = cpu_to_le64(ni->i_valid);
+	mi_b->dirty = true;
+
+	if (next_svcn < evcn1 + len) {
+		err = ni_insert_nonresident(ni, ATTR_DATA, NULL, 0, run,
+					    next_svcn, evcn1 + len - next_svcn,
+					    a_flags, NULL, NULL);
+		if (err)
+			goto out;
+	}
+
+	ni->vfs_inode.i_size += bytes;
+	ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
+	mark_inode_dirty(&ni->vfs_inode);
+
+out:
+	run_truncate(run, 0); /* clear cached values. */
+
+	up_write(&ni->file.run_lock);
+	if (err)
+		make_bad_inode(&ni->vfs_inode);
+
+	return err;
+}
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index fb825059d488..1f92e3a05f61 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -440,6 +440,7 @@ int attr_is_frame_compressed(struct ntfs_inode *ni, struct ATTRIB *attr,
  int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
  			u64 new_valid);
  int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes);
+int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes);
  int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size);
  
  /* Functions from attrlist.c */
@@ -775,10 +776,11 @@ bool run_lookup_entry(const struct runs_tree *run, CLST vcn, CLST *lcn,
  void run_truncate(struct runs_tree *run, CLST vcn);
  void run_truncate_head(struct runs_tree *run, CLST vcn);
  void run_truncate_around(struct runs_tree *run, CLST vcn);
-bool run_lookup(const struct runs_tree *run, CLST vcn, size_t *Index);
+bool run_lookup(const struct runs_tree *run, CLST vcn, size_t *index);
  bool run_add_entry(struct runs_tree *run, CLST vcn, CLST lcn, CLST len,
  		   bool is_mft);
  bool run_collapse_range(struct runs_tree *run, CLST vcn, CLST len);
+bool run_insert_range(struct runs_tree *run, CLST vcn, CLST len);
  bool run_get_entry(const struct runs_tree *run, size_t index, CLST *vcn,
  		   CLST *lcn, CLST *len);
  bool run_is_mapped_full(const struct runs_tree *run, CLST svcn, CLST evcn);
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index a8fec651f973..7609d45a2d72 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -547,6 +547,49 @@ bool run_collapse_range(struct runs_tree *run, CLST vcn, CLST len)
  	return true;
  }
  
+/* run_insert_range
+ *
+ * Helper for attr_insert_range(),
+ * which is helper for fallocate(insert_range).
+ */
+bool run_insert_range(struct runs_tree *run, CLST vcn, CLST len)
+{
+	size_t index;
+	struct ntfs_run *r, *e;
+
+	if (WARN_ON(!run_lookup(run, vcn, &index)))
+		return false; /* Should never be here. */
+
+	e = run->runs + run->count;
+	r = run->runs + index;
+
+	r = run->runs + index;
+	if (vcn > r->vcn)
+		r += 1;
+
+	for (; r < e; r++)
+		r->vcn += len;
+
+	r = run->runs + index;
+
+	if (vcn > r->vcn) {
+		/* split fragment. */
+		CLST len1 = vcn - r->vcn;
+		CLST len2 = r->len - len1;
+		CLST lcn2 = r->lcn == SPARSE_LCN ? SPARSE_LCN : (r->lcn + len1);
+
+		r->len = len1;
+
+		if (!run_add_entry(run, vcn + len, lcn2, len2, false))
+			return false;
+	}
+
+	if (!run_add_entry(run, vcn, SPARSE_LCN, len, false))
+		return false;
+
+	return true;
+}
+
  /*
   * run_get_entry - Return index-th mapped region.
   */
-- 
2.36.1


