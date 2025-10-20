Return-Path: <linux-fsdevel+bounces-64642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F8ABEF11A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 04:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD953E2C18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 02:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3B823C50F;
	Mon, 20 Oct 2025 02:13:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535052367D7
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 02:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760926394; cv=none; b=grph0BB8tqtGKBpBhCcBwHQbsg54rQgzYoPCqVoMiiQ69y2PjqvYp6DJz5rIDHHvJyhczOQQJhs66AiWSq9s/DqwhCaXeYUPctS1Fd1+FXnxMElrdUR0IFNXQARz27CGEe1Vp3YWYlQ9Z8XM/y1mNz0JSO0UNTSsSd+TNI/yCqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760926394; c=relaxed/simple;
	bh=OFH7CX5Gdi8+z7q9CpigYOvVMDmPQ/qqfincJVSpP9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oxz0S5+5/vq1lYNHXBqlJEidS7UzN9VRSSePbyoYttdiFgb3AabhAmTUhDECWs0mvlP+NeURRZAnPJFNYDPNLNwexYgysPc1a4O7ph17gfA2/e6pmK6ZZB4MrJoF4IALsy+Gp5xuKViS1hkQ7lI/Iv4NBQ81G8SebTujT9O7I+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33c4252c3c5so2252410a91.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 19:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760926385; x=1761531185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4OZAvDNkm9Ox2/s/3XGg2S04Vx/drqGA8tjkJAvcmg=;
        b=clbsUgVd3zADjMNvy2JF7B3slnrxhisXuuNBgcYmrrUO5tMTgVDFzXH+fABPXF+Z7S
         DiO4jAvVJW08CJ1nPfAiAkTgezfOkXJlFGA6R0WgRZhVxVXok3M9J1hVpfT8IVpT0OxD
         vrm+vgx/bZEIjrTgb8mgEad6F/dcHu9LZ1cJTdv2fua0Tb5HIXqzf2P2AltZclkSojSK
         cvNFWdBz/zbbSDgW0N4To92aZ/ZF4aX2+JyXj7yD7ZI/l+mw4f/vMRztoEQ6B+ncw3Pf
         4p+QCFYcMrha7o4BQs64ozGZIHiODJKMbbqdtcK/GbNhLOy7kzFaXy4XCqvy8iY333lq
         QIBA==
X-Gm-Message-State: AOJu0YyPESdhEqbMjF1fIlNJy/51Q36F86ToQM/O0/NBjDgeLYUfEyK4
	uVrgiUvYWvbLRttDholAiSB8rkaVKP0mLlTwq075tezv8eGw8ttCZyXF
X-Gm-Gg: ASbGncs8gVXVekv9b2FMYvl/L0mQPsXHZruTduHxtDYDWhGniv2LxukyrsiTI/p9mCN
	jDPKok61Xniu4hkWa6tunhRJLRmhx/iQ8hYO/eDDD0CP7AL0S5NuIh801k7QvFiMb7ctf5U3H2i
	qFVgSz3onmfw0BdJo2Nh2vcy1xKupuQlEgHBPT9pIc2Oz2aAT8I+pUwleiKc9SsALC7BfZkaIvI
	2P8+SZveChb7Hzdy1Hfew7OkOXlFcGu7gk/2aOVxrjRgjfdISO3sGt/taIt0nYEjl7Zx57225+C
	h9brt7PfMxAQIy9Ht+GDD4ivUVENqKR4hVdjR1RuFEwE6nG6TavpdNfMMzdGdR3BO2j9IeA9/Sh
	jJV4ckEPW4QohclZv3Qkhdt/MAUU35M/wMEEWQfjOyypZWIo67oWexayzGljd7qD7R6hX0Vy58Y
	WNJW5JTUd70r6tBuVU8fjEU2N7PQ==
X-Google-Smtp-Source: AGHT+IG1QdOKYPz3Oz4TAuiB3QGgFtqbDLqYsS99fkhbxDVfhAebtTtsxUTtpeG15TihUBp6b+PFtg==
X-Received: by 2002:a17:90b:4fc6:b0:330:6d5e:f17e with SMTP id 98e67ed59e1d1-33bcf8faaeamr14496743a91.24.1760926383934;
        Sun, 19 Oct 2025 19:13:03 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a764508b0sm6406849a12.0.2025.10.19.19.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 19:13:03 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@infradead.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 08/11] ntfsplus: add runlist handling and cluster allocator
Date: Mon, 20 Oct 2025 11:12:24 +0900
Message-Id: <20251020021227.5965-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251020021227.5965-1-linkinjeon@kernel.org>
References: <20251020021227.5965-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the implementation of runlist handling and cluster allocator
for ntfsplus.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfsplus/bitmap.c   |  193 ++++
 fs/ntfsplus/lcnalloc.c |  993 ++++++++++++++++++++
 fs/ntfsplus/runlist.c  | 1995 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 3181 insertions(+)
 create mode 100644 fs/ntfsplus/bitmap.c
 create mode 100644 fs/ntfsplus/lcnalloc.c
 create mode 100644 fs/ntfsplus/runlist.c

diff --git a/fs/ntfsplus/bitmap.c b/fs/ntfsplus/bitmap.c
new file mode 100644
index 000000000000..9454c9d64be2
--- /dev/null
+++ b/fs/ntfsplus/bitmap.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NTFS kernel bitmap handling. Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2004-2005 Anton Altaparmakov
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#include "bitmap.h"
+#include "aops.h"
+#include "ntfs.h"
+
+/**
+ * __ntfs_bitmap_set_bits_in_run - set a run of bits in a bitmap to a value
+ * @vi:			vfs inode describing the bitmap
+ * @start_bit:		first bit to set
+ * @count:		number of bits to set
+ * @value:		value to set the bits to (i.e. 0 or 1)
+ * @is_rollback:	if 'true' this is a rollback operation
+ *
+ * Set @count bits starting at bit @start_bit in the bitmap described by the
+ * vfs inode @vi to @value, where @value is either 0 or 1.
+ *
+ * @is_rollback should always be 'false', it is for internal use to rollback
+ * errors.  You probably want to use ntfs_bitmap_set_bits_in_run() instead.
+ */
+int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
+		const s64 count, const u8 value, const bool is_rollback)
+{
+	s64 cnt = count;
+	pgoff_t index, end_index;
+	struct address_space *mapping;
+	struct folio *folio;
+	u8 *kaddr;
+	int pos, len;
+	u8 bit;
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_volume *vol = ni->vol;
+
+	BUG_ON(!vi);
+	ntfs_debug("Entering for i_ino 0x%lx, start_bit 0x%llx, count 0x%llx, value %u.%s",
+			vi->i_ino, (unsigned long long)start_bit,
+			(unsigned long long)cnt, (unsigned int)value,
+			is_rollback ? " (rollback)" : "");
+	BUG_ON(start_bit < 0);
+	BUG_ON(cnt < 0);
+	BUG_ON(value > 1);
+	/*
+	 * Calculate the indices for the pages containing the first and last
+	 * bits, i.e. @start_bit and @start_bit + @cnt - 1, respectively.
+	 */
+	index = start_bit >> (3 + PAGE_SHIFT);
+	end_index = (start_bit + cnt - 1) >> (3 + PAGE_SHIFT);
+
+	/* Get the page containing the first bit (@start_bit). */
+	mapping = vi->i_mapping;
+	folio = ntfs_read_mapping_folio(mapping, index);
+	if (IS_ERR(folio)) {
+		if (!is_rollback)
+			ntfs_error(vi->i_sb,
+				"Failed to map first page (error %li), aborting.",
+				PTR_ERR(folio));
+		return PTR_ERR(folio);
+	}
+
+	folio_lock(folio);
+	kaddr = kmap_local_folio(folio, 0);
+
+	/* Set @pos to the position of the byte containing @start_bit. */
+	pos = (start_bit >> 3) & ~PAGE_MASK;
+
+	/* Calculate the position of @start_bit in the first byte. */
+	bit = start_bit & 7;
+
+	/* If the first byte is partial, modify the appropriate bits in it. */
+	if (bit) {
+		u8 *byte = kaddr + pos;
+
+		if (ni->mft_no == FILE_Bitmap)
+			ntfs_set_lcn_empty_bits(vol, index, value, min_t(s64, 8 - bit, cnt));
+		while ((bit & 7) && cnt) {
+			cnt--;
+			if (value)
+				*byte |= 1 << bit++;
+			else
+				*byte &= ~(1 << bit++);
+		}
+		/* If we are done, unmap the page and return success. */
+		if (!cnt)
+			goto done;
+
+		/* Update @pos to the new position. */
+		pos++;
+	}
+	/*
+	 * Depending on @value, modify all remaining whole bytes in the page up
+	 * to @cnt.
+	 */
+	len = min_t(s64, cnt >> 3, PAGE_SIZE - pos);
+	memset(kaddr + pos, value ? 0xff : 0, len);
+	cnt -= len << 3;
+	if (ni->mft_no == FILE_Bitmap)
+		ntfs_set_lcn_empty_bits(vol, index, value, len << 3);
+
+	/* Update @len to point to the first not-done byte in the page. */
+	if (cnt < 8)
+		len += pos;
+
+	/* If we are not in the last page, deal with all subsequent pages. */
+	while (index < end_index) {
+		BUG_ON(cnt <= 0);
+
+		/* Update @index and get the next folio. */
+		flush_dcache_folio(folio);
+		folio_mark_dirty(folio);
+		folio_unlock(folio);
+		ntfs_unmap_folio(folio, kaddr);
+		folio = ntfs_read_mapping_folio(mapping, ++index);
+		if (IS_ERR(folio)) {
+			ntfs_error(vi->i_sb,
+				   "Failed to map subsequent page (error %li), aborting.",
+				   PTR_ERR(folio));
+			goto rollback;
+		}
+
+		folio_lock(folio);
+		kaddr = kmap_local_folio(folio, 0);
+		/*
+		 * Depending on @value, modify all remaining whole bytes in the
+		 * page up to @cnt.
+		 */
+		len = min_t(s64, cnt >> 3, PAGE_SIZE);
+		memset(kaddr, value ? 0xff : 0, len);
+		cnt -= len << 3;
+		if (ni->mft_no == FILE_Bitmap)
+			ntfs_set_lcn_empty_bits(vol, index, value, len << 3);
+	}
+	/*
+	 * The currently mapped page is the last one.  If the last byte is
+	 * partial, modify the appropriate bits in it.  Note, @len is the
+	 * position of the last byte inside the page.
+	 */
+	if (cnt) {
+		u8 *byte;
+
+		BUG_ON(cnt > 7);
+
+		bit = cnt;
+		byte = kaddr + len;
+		if (ni->mft_no == FILE_Bitmap)
+			ntfs_set_lcn_empty_bits(vol, index, value, bit);
+		while (bit--) {
+			if (value)
+				*byte |= 1 << bit;
+			else
+				*byte &= ~(1 << bit);
+		}
+	}
+done:
+	/* We are done.  Unmap the folio and return success. */
+	flush_dcache_folio(folio);
+	folio_mark_dirty(folio);
+	folio_unlock(folio);
+	ntfs_unmap_folio(folio, kaddr);
+	ntfs_debug("Done.");
+	return 0;
+rollback:
+	/*
+	 * Current state:
+	 *	- no pages are mapped
+	 *	- @count - @cnt is the number of bits that have been modified
+	 */
+	if (is_rollback)
+		return PTR_ERR(folio);
+	if (count != cnt)
+		pos = __ntfs_bitmap_set_bits_in_run(vi, start_bit, count - cnt,
+				value ? 0 : 1, true);
+	else
+		pos = 0;
+	if (!pos) {
+		/* Rollback was successful. */
+		ntfs_error(vi->i_sb,
+			"Failed to map subsequent page (error %li), aborting.",
+			PTR_ERR(folio));
+	} else {
+		/* Rollback failed. */
+		ntfs_error(vi->i_sb,
+			"Failed to map subsequent page (error %li) and rollback failed (error %i). Aborting and leaving inconsistent metadata. Unmount and run chkdsk.",
+			PTR_ERR(folio), pos);
+		NVolSetErrors(NTFS_SB(vi->i_sb));
+	}
+	return PTR_ERR(folio);
+}
diff --git a/fs/ntfsplus/lcnalloc.c b/fs/ntfsplus/lcnalloc.c
new file mode 100644
index 000000000000..bac93a896c03
--- /dev/null
+++ b/fs/ntfsplus/lcnalloc.c
@@ -0,0 +1,993 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Cluster (de)allocation code. Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2004-2005 Anton Altaparmakov
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ *
+ * Part of this file is based on code from the NTFS-3G project.
+ * and is copyrighted by the respective authors below:
+ * Copyright (c) 2002-2004 Anton Altaparmakov
+ * Copyright (c) 2004 Yura Pakhuchiy
+ * Copyright (c) 2004-2008 Szabolcs Szakacsits
+ * Copyright (c) 2008-2009 Jean-Pierre Andre
+ */
+
+#include "lcnalloc.h"
+#include "bitmap.h"
+#include "misc.h"
+#include "aops.h"
+#include "ntfs.h"
+
+/**
+ * ntfs_cluster_free_from_rl_nolock - free clusters from runlist
+ * @vol:	mounted ntfs volume on which to free the clusters
+ * @rl:		runlist describing the clusters to free
+ *
+ * Free all the clusters described by the runlist @rl on the volume @vol.  In
+ * the case of an error being returned, at least some of the clusters were not
+ * freed.
+ *
+ * Return 0 on success and -errno on error.
+ *
+ * Locking: - The volume lcn bitmap must be locked for writing on entry and is
+ *	      left locked on return.
+ */
+int ntfs_cluster_free_from_rl_nolock(struct ntfs_volume *vol,
+		const struct runlist_element *rl)
+{
+	struct inode *lcnbmp_vi = vol->lcnbmp_ino;
+	int ret = 0;
+	s64 nr_freed = 0;
+
+	ntfs_debug("Entering.");
+	if (!rl)
+		return 0;
+
+	if (!NVolFreeClusterKnown(vol))
+		wait_event(vol->free_waitq, NVolFreeClusterKnown(vol));
+
+	for (; rl->length; rl++) {
+		int err;
+
+		if (rl->lcn < 0)
+			continue;
+		err = ntfs_bitmap_clear_run(lcnbmp_vi, rl->lcn, rl->length);
+		if (unlikely(err && (!ret || ret == -ENOMEM) && ret != err))
+			ret = err;
+		else
+			nr_freed += rl->length;
+	}
+	ntfs_inc_free_clusters(vol, nr_freed);
+	ntfs_debug("Done.");
+	return ret;
+}
+
+static s64 max_empty_bit_range(unsigned char *buf, int size)
+{
+	int i, j, run = 0;
+	int max_range = 0;
+	s64 start_pos = -1;
+
+	ntfs_debug("Entering\n");
+
+	i = 0;
+	while (i < size) {
+		switch (*buf) {
+		case 0:
+			do {
+				buf++;
+				run += 8;
+				i++;
+			} while ((i < size) && !*buf);
+			break;
+		case 255:
+			if (run > max_range) {
+				max_range = run;
+				start_pos = (s64)i * 8 - run;
+			}
+			run = 0;
+			do {
+				buf++;
+				i++;
+			} while ((i < size) && (*buf == 255));
+			break;
+		default:
+			for (j = 0; j < 8; j++) {
+				int bit = *buf & (1 << j);
+
+				if (bit) {
+					if (run > max_range) {
+						max_range = run;
+						start_pos = (s64)i * 8 + (j - run);
+					}
+					run = 0;
+				} else
+					run++;
+			}
+			i++;
+			buf++;
+		}
+	}
+
+	if (run > max_range)
+		start_pos = (s64)i * 8 - run;
+
+	return start_pos;
+}
+
+/**
+ * ntfs_cluster_alloc - allocate clusters on an ntfs volume
+ *
+ * Allocate @count clusters preferably starting at cluster @start_lcn or at the
+ * current allocator position if @start_lcn is -1, on the mounted ntfs volume
+ * @vol. @zone is either DATA_ZONE for allocation of normal clusters or
+ * MFT_ZONE for allocation of clusters for the master file table, i.e. the
+ * $MFT/$DATA attribute.
+ *
+ * @start_vcn specifies the vcn of the first allocated cluster.  This makes
+ * merging the resulting runlist with the old runlist easier.
+ *
+ * If @is_extension is 'true', the caller is allocating clusters to extend an
+ * attribute and if it is 'false', the caller is allocating clusters to fill a
+ * hole in an attribute.  Practically the difference is that if @is_extension
+ * is 'true' the returned runlist will be terminated with LCN_ENOENT and if
+ * @is_extension is 'false' the runlist will be terminated with
+ * LCN_RL_NOT_MAPPED.
+ *
+ * You need to check the return value with IS_ERR().  If this is false, the
+ * function was successful and the return value is a runlist describing the
+ * allocated cluster(s).  If IS_ERR() is true, the function failed and
+ * PTR_ERR() gives you the error code.
+ *
+ * Notes on the allocation algorithm
+ * =================================
+ *
+ * There are two data zones.  First is the area between the end of the mft zone
+ * and the end of the volume, and second is the area between the start of the
+ * volume and the start of the mft zone.  On unmodified/standard NTFS 1.x
+ * volumes, the second data zone does not exist due to the mft zone being
+ * expanded to cover the start of the volume in order to reserve space for the
+ * mft bitmap attribute.
+ *
+ * This is not the prettiest function but the complexity stems from the need of
+ * implementing the mft vs data zoned approach and from the fact that we have
+ * access to the lcn bitmap in portions of up to 8192 bytes at a time, so we
+ * need to cope with crossing over boundaries of two buffers.  Further, the
+ * fact that the allocator allows for caller supplied hints as to the location
+ * of where allocation should begin and the fact that the allocator keeps track
+ * of where in the data zones the next natural allocation should occur,
+ * contribute to the complexity of the function.  But it should all be
+ * worthwhile, because this allocator should: 1) be a full implementation of
+ * the MFT zone approach used by Windows NT, 2) cause reduction in
+ * fragmentation, and 3) be speedy in allocations (the code is not optimized
+ * for speed, but the algorithm is, so further speed improvements are probably
+ * possible).
+ *
+ * Locking: - The volume lcn bitmap must be unlocked on entry and is unlocked
+ *	      on return.
+ *	    - This function takes the volume lcn bitmap lock for writing and
+ *	      modifies the bitmap contents.
+ */
+struct runlist_element *ntfs_cluster_alloc(struct ntfs_volume *vol, const s64 start_vcn,
+		const s64 count, const s64 start_lcn,
+		const int zone,
+		const bool is_extension,
+		const bool is_contig,
+		const bool is_dealloc)
+{
+	s64 zone_start, zone_end, bmp_pos, bmp_initial_pos, last_read_pos, lcn;
+	s64 prev_lcn = 0, prev_run_len = 0, mft_zone_size;
+	s64 clusters, free_clusters;
+	loff_t i_size;
+	struct inode *lcnbmp_vi;
+	struct runlist_element *rl = NULL;
+	struct address_space *mapping;
+	struct folio *folio = NULL;
+	u8 *buf = NULL, *byte;
+	int err = 0, rlpos, rlsize, buf_size, pg_off;
+	u8 pass, done_zones, search_zone, need_writeback = 0, bit;
+	unsigned int memalloc_flags;
+	u8 has_guess;
+	pgoff_t index;
+
+	ntfs_debug("Entering for start_vcn 0x%llx, count 0x%llx, start_lcn 0x%llx, zone %s_ZONE.",
+			start_vcn, count, start_lcn,
+			zone == MFT_ZONE ? "MFT" : "DATA");
+	BUG_ON(!vol);
+	lcnbmp_vi = vol->lcnbmp_ino;
+	BUG_ON(!lcnbmp_vi);
+	BUG_ON(start_vcn < 0);
+	BUG_ON(count < 0);
+	BUG_ON(start_lcn < LCN_HOLE);
+	BUG_ON(zone < FIRST_ZONE);
+	BUG_ON(zone > LAST_ZONE);
+
+	/* Return NULL if @count is zero. */
+	if (!count)
+		return ERR_PTR(-EINVAL);
+
+	memalloc_flags = memalloc_nofs_save();
+
+	if (!NVolFreeClusterKnown(vol))
+		wait_event(vol->free_waitq, NVolFreeClusterKnown(vol));
+	free_clusters = atomic64_read(&vol->free_clusters);
+
+	/* Take the lcnbmp lock for writing. */
+	down_write(&vol->lcnbmp_lock);
+	if (is_dealloc == false)
+		free_clusters -= atomic64_read(&vol->dirty_clusters);
+
+	if (free_clusters < count) {
+		up_write(&vol->lcnbmp_lock);
+		return ERR_PTR(-ENOSPC);
+	}
+
+	/*
+	 * If no specific @start_lcn was requested, use the current data zone
+	 * position, otherwise use the requested @start_lcn but make sure it
+	 * lies outside the mft zone.  Also set done_zones to 0 (no zones done)
+	 * and pass depending on whether we are starting inside a zone (1) or
+	 * at the beginning of a zone (2).  If requesting from the MFT_ZONE,
+	 * we either start at the current position within the mft zone or at
+	 * the specified position.  If the latter is out of bounds then we start
+	 * at the beginning of the MFT_ZONE.
+	 */
+	done_zones = 0;
+	pass = 1;
+	/*
+	 * zone_start and zone_end are the current search range.  search_zone
+	 * is 1 for mft zone, 2 for data zone 1 (end of mft zone till end of
+	 * volume) and 4 for data zone 2 (start of volume till start of mft
+	 * zone).
+	 */
+	has_guess = 1;
+	zone_start = start_lcn;
+
+	if (zone_start < 0) {
+		if (zone == DATA_ZONE)
+			zone_start = vol->data1_zone_pos;
+		else
+			zone_start = vol->mft_zone_pos;
+		if (!zone_start) {
+			/*
+			 * Zone starts at beginning of volume which means a
+			 * single pass is sufficient.
+			 */
+			pass = 2;
+		}
+		has_guess = 0;
+	} else if (zone == DATA_ZONE && zone_start >= vol->mft_zone_start &&
+			zone_start < vol->mft_zone_end) {
+		zone_start = vol->mft_zone_end;
+		/*
+		 * Starting at beginning of data1_zone which means a single
+		 * pass in this zone is sufficient.
+		 */
+		pass = 2;
+	} else if (zone == MFT_ZONE && (zone_start < vol->mft_zone_start ||
+			zone_start >= vol->mft_zone_end)) {
+		zone_start = vol->mft_lcn;
+		if (!vol->mft_zone_end)
+			zone_start = 0;
+		/*
+		 * Starting at beginning of volume which means a single pass
+		 * is sufficient.
+		 */
+		pass = 2;
+	}
+
+	if (zone == MFT_ZONE) {
+		zone_end = vol->mft_zone_end;
+		search_zone = 1;
+	} else /* if (zone == DATA_ZONE) */ {
+		/* Skip searching the mft zone. */
+		done_zones |= 1;
+		if (zone_start >= vol->mft_zone_end) {
+			zone_end = vol->nr_clusters;
+			search_zone = 2;
+		} else {
+			zone_end = vol->mft_zone_start;
+			search_zone = 4;
+		}
+	}
+	/*
+	 * bmp_pos is the current bit position inside the bitmap.  We use
+	 * bmp_initial_pos to determine whether or not to do a zone switch.
+	 */
+	bmp_pos = bmp_initial_pos = zone_start;
+
+	/* Loop until all clusters are allocated, i.e. clusters == 0. */
+	clusters = count;
+	rlpos = rlsize = 0;
+	mapping = lcnbmp_vi->i_mapping;
+	i_size = i_size_read(lcnbmp_vi);
+	while (1) {
+		ntfs_debug("Start of outer while loop: done_zones 0x%x, search_zone %i, pass %i, zone_start 0x%llx, zone_end 0x%llx, bmp_initial_pos 0x%llx, bmp_pos 0x%llx, rlpos %i, rlsize %i.",
+				done_zones, search_zone, pass,
+				zone_start, zone_end, bmp_initial_pos,
+				bmp_pos, rlpos, rlsize);
+		/* Loop until we run out of free clusters. */
+		last_read_pos = bmp_pos >> 3;
+		ntfs_debug("last_read_pos 0x%llx.", last_read_pos);
+		if (last_read_pos >= i_size) {
+			ntfs_debug("End of attribute reached. Skipping to zone_pass_done.");
+			goto zone_pass_done;
+		}
+		if (likely(folio)) {
+			if (need_writeback) {
+				ntfs_debug("Marking page dirty.");
+				flush_dcache_folio(folio);
+				folio_mark_dirty(folio);
+				need_writeback = 0;
+			}
+			folio_unlock(folio);
+			ntfs_unmap_folio(folio, buf);
+			folio = NULL;
+		}
+
+		index = last_read_pos >> PAGE_SHIFT;
+		pg_off = last_read_pos & ~PAGE_MASK;
+		buf_size = PAGE_SIZE - pg_off;
+		if (unlikely(last_read_pos + buf_size > i_size))
+			buf_size = i_size - last_read_pos;
+		buf_size <<= 3;
+		lcn = bmp_pos & 7;
+		bmp_pos &= ~(s64)7;
+
+		if (vol->lcn_empty_bits_per_page[index] == 0)
+			goto next_bmp_pos;
+
+		folio = ntfs_read_mapping_folio(mapping, index);
+		if (IS_ERR(folio)) {
+			err = PTR_ERR(folio);
+			ntfs_error(vol->sb, "Failed to map page.");
+			goto out;
+		}
+
+		folio_lock(folio);
+		buf = kmap_local_folio(folio, 0) + pg_off;
+		ntfs_debug("Before inner while loop: buf_size %i, lcn 0x%llx, bmp_pos 0x%llx, need_writeback %i.",
+				buf_size, lcn, bmp_pos, need_writeback);
+		while (lcn < buf_size && lcn + bmp_pos < zone_end) {
+			byte = buf + (lcn >> 3);
+			ntfs_debug("In inner while loop: buf_size %i, lcn 0x%llx, bmp_pos 0x%llx, need_writeback %i, byte ofs 0x%x, *byte 0x%x.",
+					buf_size, lcn, bmp_pos, need_writeback,
+					(unsigned int)(lcn >> 3),
+					(unsigned int)*byte);
+			bit = 1 << (lcn & 7);
+			ntfs_debug("bit 0x%x.", bit);
+
+			if (has_guess) {
+				if (*byte & bit) {
+					if (is_contig == true && prev_run_len > 0)
+						goto done;
+
+					has_guess = 0;
+					break;
+				}
+			} else {
+				lcn = max_empty_bit_range(buf, buf_size >> 3);
+				if (lcn < 0)
+					break;
+				has_guess = 1;
+				continue;
+			}
+			/*
+			 * Allocate more memory if needed, including space for
+			 * the terminator element.
+			 * ntfs_malloc_nofs() operates on whole pages only.
+			 */
+			if ((rlpos + 2) * sizeof(*rl) > rlsize) {
+				struct runlist_element *rl2;
+
+				ntfs_debug("Reallocating memory.");
+				if (!rl)
+					ntfs_debug("First free bit is at s64 0x%llx.",
+							lcn + bmp_pos);
+				rl2 = ntfs_malloc_nofs(rlsize + (int)PAGE_SIZE);
+				if (unlikely(!rl2)) {
+					err = -ENOMEM;
+					ntfs_error(vol->sb, "Failed to allocate memory.");
+					goto out;
+				}
+				memcpy(rl2, rl, rlsize);
+				ntfs_free(rl);
+				rl = rl2;
+				rlsize += PAGE_SIZE;
+				ntfs_debug("Reallocated memory, rlsize 0x%x.",
+						rlsize);
+			}
+			/* Allocate the bitmap bit. */
+			*byte |= bit;
+			/* We need to write this bitmap page to disk. */
+			need_writeback = 1;
+			ntfs_debug("*byte 0x%x, need_writeback is set.",
+					(unsigned int)*byte);
+			ntfs_dec_free_clusters(vol, 1);
+			ntfs_set_lcn_empty_bits(vol, index, 1, 1);
+
+			/*
+			 * Coalesce with previous run if adjacent LCNs.
+			 * Otherwise, append a new run.
+			 */
+			ntfs_debug("Adding run (lcn 0x%llx, len 0x%llx), prev_lcn 0x%llx, lcn 0x%llx, bmp_pos 0x%llx, prev_run_len 0x%llx, rlpos %i.",
+					lcn + bmp_pos, 1ULL, prev_lcn,
+					lcn, bmp_pos, prev_run_len, rlpos);
+			if (prev_lcn == lcn + bmp_pos - prev_run_len && rlpos) {
+				ntfs_debug("Coalescing to run (lcn 0x%llx, len 0x%llx).",
+						rl[rlpos - 1].lcn,
+						rl[rlpos - 1].length);
+				rl[rlpos - 1].length = ++prev_run_len;
+				ntfs_debug("Run now (lcn 0x%llx, len 0x%llx), prev_run_len 0x%llx.",
+						rl[rlpos - 1].lcn,
+						rl[rlpos - 1].length,
+						prev_run_len);
+			} else {
+				if (likely(rlpos)) {
+					ntfs_debug("Adding new run, (previous run lcn 0x%llx, len 0x%llx).",
+							rl[rlpos - 1].lcn, rl[rlpos - 1].length);
+					rl[rlpos].vcn = rl[rlpos - 1].vcn +
+							prev_run_len;
+				} else {
+					ntfs_debug("Adding new run, is first run.");
+					rl[rlpos].vcn = start_vcn;
+				}
+				rl[rlpos].lcn = prev_lcn = lcn + bmp_pos;
+				rl[rlpos].length = prev_run_len = 1;
+				rlpos++;
+			}
+			/* Done? */
+			if (!--clusters) {
+				s64 tc;
+done:
+				/*
+				 * Update the current zone position.  Positions
+				 * of already scanned zones have been updated
+				 * during the respective zone switches.
+				 */
+				tc = lcn + bmp_pos + 1;
+				ntfs_debug("Done. Updating current zone position, tc 0x%llx, search_zone %i.",
+						tc, search_zone);
+				switch (search_zone) {
+				case 1:
+					ntfs_debug("Before checks, vol->mft_zone_pos 0x%llx.",
+							vol->mft_zone_pos);
+					if (tc >= vol->mft_zone_end) {
+						vol->mft_zone_pos =
+								vol->mft_lcn;
+						if (!vol->mft_zone_end)
+							vol->mft_zone_pos = 0;
+					} else if ((bmp_initial_pos >=
+							vol->mft_zone_pos ||
+							tc > vol->mft_zone_pos)
+							&& tc >= vol->mft_lcn)
+						vol->mft_zone_pos = tc;
+					ntfs_debug("After checks, vol->mft_zone_pos 0x%llx.",
+							vol->mft_zone_pos);
+					break;
+				case 2:
+					ntfs_debug("Before checks, vol->data1_zone_pos 0x%llx.",
+							vol->data1_zone_pos);
+					if (tc >= vol->nr_clusters)
+						vol->data1_zone_pos =
+							     vol->mft_zone_end;
+					else if ((bmp_initial_pos >=
+						    vol->data1_zone_pos ||
+						    tc > vol->data1_zone_pos)
+						    && tc >= vol->mft_zone_end)
+						vol->data1_zone_pos = tc;
+					ntfs_debug("After checks, vol->data1_zone_pos 0x%llx.",
+							vol->data1_zone_pos);
+					break;
+				case 4:
+					ntfs_debug("Before checks, vol->data2_zone_pos 0x%llx.",
+							vol->data2_zone_pos);
+					if (tc >= vol->mft_zone_start)
+						vol->data2_zone_pos = 0;
+					else if (bmp_initial_pos >=
+						      vol->data2_zone_pos ||
+						      tc > vol->data2_zone_pos)
+						vol->data2_zone_pos = tc;
+					ntfs_debug("After checks, vol->data2_zone_pos 0x%llx.",
+							vol->data2_zone_pos);
+					break;
+				default:
+					BUG();
+				}
+				ntfs_debug("Finished.  Going to out.");
+				goto out;
+			}
+			lcn++;
+		}
+next_bmp_pos:
+		bmp_pos += buf_size;
+		ntfs_debug("After inner while loop: buf_size 0x%x, lcn 0x%llx, bmp_pos 0x%llx, need_writeback %i.",
+				buf_size, lcn, bmp_pos, need_writeback);
+		if (bmp_pos < zone_end) {
+			ntfs_debug("Continuing outer while loop, bmp_pos 0x%llx, zone_end 0x%llx.",
+					bmp_pos, zone_end);
+			continue;
+		}
+zone_pass_done:	/* Finished with the current zone pass. */
+		ntfs_debug("At zone_pass_done, pass %i.", pass);
+		if (pass == 1) {
+			/*
+			 * Now do pass 2, scanning the first part of the zone
+			 * we omitted in pass 1.
+			 */
+			pass = 2;
+			zone_end = zone_start;
+			switch (search_zone) {
+			case 1: /* mft_zone */
+				zone_start = vol->mft_zone_start;
+				break;
+			case 2: /* data1_zone */
+				zone_start = vol->mft_zone_end;
+				break;
+			case 4: /* data2_zone */
+				zone_start = 0;
+				break;
+			default:
+				BUG();
+			}
+			/* Sanity check. */
+			if (zone_end < zone_start)
+				zone_end = zone_start;
+			bmp_pos = zone_start;
+			ntfs_debug("Continuing outer while loop, pass 2, zone_start 0x%llx, zone_end 0x%llx, bmp_pos 0x%llx.",
+					zone_start, zone_end, bmp_pos);
+			continue;
+		} /* pass == 2 */
+done_zones_check:
+		ntfs_debug("At done_zones_check, search_zone %i, done_zones before 0x%x, done_zones after 0x%x.",
+				search_zone, done_zones,
+				done_zones | search_zone);
+		done_zones |= search_zone;
+		if (done_zones < 7) {
+			ntfs_debug("Switching zone.");
+			/* Now switch to the next zone we haven't done yet. */
+			pass = 1;
+			switch (search_zone) {
+			case 1:
+				ntfs_debug("Switching from mft zone to data1 zone.");
+				/* Update mft zone position. */
+				if (rlpos) {
+					s64 tc;
+
+					ntfs_debug("Before checks, vol->mft_zone_pos 0x%llx.",
+							vol->mft_zone_pos);
+					tc = rl[rlpos - 1].lcn +
+							rl[rlpos - 1].length;
+					if (tc >= vol->mft_zone_end) {
+						vol->mft_zone_pos =
+								vol->mft_lcn;
+						if (!vol->mft_zone_end)
+							vol->mft_zone_pos = 0;
+					} else if ((bmp_initial_pos >=
+							vol->mft_zone_pos ||
+							tc > vol->mft_zone_pos)
+							&& tc >= vol->mft_lcn)
+						vol->mft_zone_pos = tc;
+					ntfs_debug("After checks, vol->mft_zone_pos 0x%llx.",
+							vol->mft_zone_pos);
+				}
+				/* Switch from mft zone to data1 zone. */
+switch_to_data1_zone:		search_zone = 2;
+				zone_start = bmp_initial_pos =
+						vol->data1_zone_pos;
+				zone_end = vol->nr_clusters;
+				if (zone_start == vol->mft_zone_end)
+					pass = 2;
+				if (zone_start >= zone_end) {
+					vol->data1_zone_pos = zone_start =
+							vol->mft_zone_end;
+					pass = 2;
+				}
+				break;
+			case 2:
+				ntfs_debug("Switching from data1 zone to data2 zone.");
+				/* Update data1 zone position. */
+				if (rlpos) {
+					s64 tc;
+
+					ntfs_debug("Before checks, vol->data1_zone_pos 0x%llx.",
+							vol->data1_zone_pos);
+					tc = rl[rlpos - 1].lcn +
+							rl[rlpos - 1].length;
+					if (tc >= vol->nr_clusters)
+						vol->data1_zone_pos =
+							     vol->mft_zone_end;
+					else if ((bmp_initial_pos >=
+						    vol->data1_zone_pos ||
+						    tc > vol->data1_zone_pos)
+						    && tc >= vol->mft_zone_end)
+						vol->data1_zone_pos = tc;
+					ntfs_debug("After checks, vol->data1_zone_pos 0x%llx.",
+							vol->data1_zone_pos);
+				}
+				/* Switch from data1 zone to data2 zone. */
+				search_zone = 4;
+				zone_start = bmp_initial_pos =
+						vol->data2_zone_pos;
+				zone_end = vol->mft_zone_start;
+				if (!zone_start)
+					pass = 2;
+				if (zone_start >= zone_end) {
+					vol->data2_zone_pos = zone_start =
+							bmp_initial_pos = 0;
+					pass = 2;
+				}
+				break;
+			case 4:
+				ntfs_debug("Switching from data2 zone to data1 zone.");
+				/* Update data2 zone position. */
+				if (rlpos) {
+					s64 tc;
+
+					ntfs_debug("Before checks, vol->data2_zone_pos 0x%llx.",
+							vol->data2_zone_pos);
+					tc = rl[rlpos - 1].lcn +
+							rl[rlpos - 1].length;
+					if (tc >= vol->mft_zone_start)
+						vol->data2_zone_pos = 0;
+					else if (bmp_initial_pos >=
+						      vol->data2_zone_pos ||
+						      tc > vol->data2_zone_pos)
+						vol->data2_zone_pos = tc;
+					ntfs_debug("After checks, vol->data2_zone_pos 0x%llx.",
+							vol->data2_zone_pos);
+				}
+				/* Switch from data2 zone to data1 zone. */
+				goto switch_to_data1_zone;
+			default:
+				BUG();
+			}
+			ntfs_debug("After zone switch, search_zone %i, pass %i, bmp_initial_pos 0x%llx, zone_start 0x%llx, zone_end 0x%llx.",
+					search_zone, pass,
+					bmp_initial_pos,
+					zone_start,
+					zone_end);
+			bmp_pos = zone_start;
+			if (zone_start == zone_end) {
+				ntfs_debug("Empty zone, going to done_zones_check.");
+				/* Empty zone. Don't bother searching it. */
+				goto done_zones_check;
+			}
+			ntfs_debug("Continuing outer while loop.");
+			continue;
+		} /* done_zones == 7 */
+		ntfs_debug("All zones are finished.");
+		/*
+		 * All zones are finished!  If DATA_ZONE, shrink mft zone.  If
+		 * MFT_ZONE, we have really run out of space.
+		 */
+		mft_zone_size = vol->mft_zone_end - vol->mft_zone_start;
+		ntfs_debug("vol->mft_zone_start 0x%llx, vol->mft_zone_end 0x%llx, mft_zone_size 0x%llx.",
+				vol->mft_zone_start, vol->mft_zone_end,
+				mft_zone_size);
+		if (zone == MFT_ZONE || mft_zone_size <= 0) {
+			ntfs_debug("No free clusters left, going to out.");
+			/* Really no more space left on device. */
+			err = -ENOSPC;
+			goto out;
+		} /* zone == DATA_ZONE && mft_zone_size > 0 */
+		ntfs_debug("Shrinking mft zone.");
+		zone_end = vol->mft_zone_end;
+		mft_zone_size >>= 1;
+		if (mft_zone_size > 0)
+			vol->mft_zone_end = vol->mft_zone_start + mft_zone_size;
+		else /* mft zone and data2 zone no longer exist. */
+			vol->data2_zone_pos = vol->mft_zone_start =
+					vol->mft_zone_end = 0;
+		if (vol->mft_zone_pos >= vol->mft_zone_end) {
+			vol->mft_zone_pos = vol->mft_lcn;
+			if (!vol->mft_zone_end)
+				vol->mft_zone_pos = 0;
+		}
+		bmp_pos = zone_start = bmp_initial_pos =
+				vol->data1_zone_pos = vol->mft_zone_end;
+		search_zone = 2;
+		pass = 2;
+		done_zones &= ~2;
+		ntfs_debug("After shrinking mft zone, mft_zone_size 0x%llx, vol->mft_zone_start 0x%llx, vol->mft_zone_end 0x%llx, vol->mft_zone_pos 0x%llx, search_zone 2, pass 2, dones_zones 0x%x, zone_start 0x%llx, zone_end 0x%llx, vol->data1_zone_pos 0x%llx, continuing outer while loop.",
+				mft_zone_size, vol->mft_zone_start,
+				vol->mft_zone_end, vol->mft_zone_pos,
+				done_zones, zone_start, zone_end,
+				vol->data1_zone_pos);
+	}
+	ntfs_debug("After outer while loop.");
+out:
+	ntfs_debug("At out.");
+	/* Add runlist terminator element. */
+	if (likely(rl)) {
+		rl[rlpos].vcn = rl[rlpos - 1].vcn + rl[rlpos - 1].length;
+		rl[rlpos].lcn = is_extension ? LCN_ENOENT : LCN_RL_NOT_MAPPED;
+		rl[rlpos].length = 0;
+	}
+	if (likely(folio && !IS_ERR(folio))) {
+		if (need_writeback) {
+			ntfs_debug("Marking page dirty.");
+			flush_dcache_folio(folio);
+			folio_mark_dirty(folio);
+			need_writeback = 0;
+		}
+		folio_unlock(folio);
+		ntfs_unmap_folio(folio, buf);
+	}
+	if (likely(!err)) {
+		if (is_dealloc == true)
+			ntfs_release_dirty_clusters(vol, rl->length);
+		up_write(&vol->lcnbmp_lock);
+		memalloc_nofs_restore(memalloc_flags);
+		ntfs_debug("Done.");
+		return rl == NULL ? ERR_PTR(-EIO) : rl;
+	}
+	if (err != -ENOSPC)
+		ntfs_error(vol->sb,
+			"Failed to allocate clusters, aborting (error %i).",
+			err);
+	if (rl) {
+		int err2;
+
+		if (err == -ENOSPC)
+			ntfs_debug("Not enough space to complete allocation, err -ENOSPC, first free lcn 0x%llx, could allocate up to 0x%llx clusters.",
+					rl[0].lcn, count - clusters);
+		/* Deallocate all allocated clusters. */
+		ntfs_debug("Attempting rollback...");
+		err2 = ntfs_cluster_free_from_rl_nolock(vol, rl);
+		if (err2) {
+			ntfs_error(vol->sb,
+				"Failed to rollback (error %i). Leaving inconsistent metadata! Unmount and run chkdsk.",
+				err2);
+			NVolSetErrors(vol);
+		}
+		/* Free the runlist. */
+		ntfs_free(rl);
+	} else if (err == -ENOSPC)
+		ntfs_debug("No space left at all, err = -ENOSPC, first free lcn = 0x%llx.",
+				vol->data1_zone_pos);
+	atomic64_set(&vol->dirty_clusters, 0);
+	up_write(&vol->lcnbmp_lock);
+	memalloc_nofs_restore(memalloc_flags);
+	return ERR_PTR(err);
+}
+
+/**
+ * __ntfs_cluster_free - free clusters on an ntfs volume
+ * @ni:		ntfs inode whose runlist describes the clusters to free
+ * @start_vcn:	vcn in the runlist of @ni at which to start freeing clusters
+ * @count:	number of clusters to free or -1 for all clusters
+ * @ctx:	active attribute search context if present or NULL if not
+ * @is_rollback:	true if this is a rollback operation
+ *
+ * Free @count clusters starting at the cluster @start_vcn in the runlist
+ * described by the vfs inode @ni.
+ *
+ * If @count is -1, all clusters from @start_vcn to the end of the runlist are
+ * deallocated.  Thus, to completely free all clusters in a runlist, use
+ * @start_vcn = 0 and @count = -1.
+ *
+ * If @ctx is specified, it is an active search context of @ni and its base mft
+ * record.  This is needed when __ntfs_cluster_free() encounters unmapped
+ * runlist fragments and allows their mapping.  If you do not have the mft
+ * record mapped, you can specify @ctx as NULL and __ntfs_cluster_free() will
+ * perform the necessary mapping and unmapping.
+ *
+ * Note, __ntfs_cluster_free() saves the state of @ctx on entry and restores it
+ * before returning.  Thus, @ctx will be left pointing to the same attribute on
+ * return as on entry.  However, the actual pointers in @ctx may point to
+ * different memory locations on return, so you must remember to reset any
+ * cached pointers from the @ctx, i.e. after the call to __ntfs_cluster_free(),
+ * you will probably want to do:
+ *	m = ctx->mrec;
+ *	a = ctx->attr;
+ * Assuming you cache ctx->attr in a variable @a of type attr_record * and that
+ * you cache ctx->mrec in a variable @m of type struct mft_record *.
+ *
+ * @is_rollback should always be 'false', it is for internal use to rollback
+ * errors.  You probably want to use ntfs_cluster_free() instead.
+ *
+ * Note, __ntfs_cluster_free() does not modify the runlist, so you have to
+ * remove from the runlist or mark sparse the freed runs later.
+ *
+ * Return the number of deallocated clusters (not counting sparse ones) on
+ * success and -errno on error.
+ *
+ * WARNING: If @ctx is supplied, regardless of whether success or failure is
+ *	    returned, you need to check IS_ERR(@ctx->mrec) and if 'true' the @ctx
+ *	    is no longer valid, i.e. you need to either call
+ *	    ntfs_attr_reinit_search_ctx() or ntfs_attr_put_search_ctx() on it.
+ *	    In that case PTR_ERR(@ctx->mrec) will give you the error code for
+ *	    why the mapping of the old inode failed.
+ *
+ * Locking: - The runlist described by @ni must be locked for writing on entry
+ *	      and is locked on return.  Note the runlist may be modified when
+ *	      needed runlist fragments need to be mapped.
+ *	    - The volume lcn bitmap must be unlocked on entry and is unlocked
+ *	      on return.
+ *	    - This function takes the volume lcn bitmap lock for writing and
+ *	      modifies the bitmap contents.
+ *	    - If @ctx is NULL, the base mft record of @ni must not be mapped on
+ *	      entry and it will be left unmapped on return.
+ *	    - If @ctx is not NULL, the base mft record must be mapped on entry
+ *	      and it will be left mapped on return.
+ */
+s64 __ntfs_cluster_free(struct ntfs_inode *ni, const s64 start_vcn, s64 count,
+		struct ntfs_attr_search_ctx *ctx, const bool is_rollback)
+{
+	s64 delta, to_free, total_freed, real_freed;
+	struct ntfs_volume *vol;
+	struct inode *lcnbmp_vi;
+	struct runlist_element *rl;
+	int err;
+	unsigned int memalloc_flags;
+
+	BUG_ON(!ni);
+	ntfs_debug("Entering for i_ino 0x%lx, start_vcn 0x%llx, count 0x%llx.%s",
+			ni->mft_no, start_vcn, count,
+			is_rollback ? " (rollback)" : "");
+	vol = ni->vol;
+	lcnbmp_vi = vol->lcnbmp_ino;
+	BUG_ON(!lcnbmp_vi);
+	BUG_ON(start_vcn < 0);
+	BUG_ON(count < -1);
+
+	if (!NVolFreeClusterKnown(vol))
+		wait_event(vol->free_waitq, NVolFreeClusterKnown(vol));
+
+	/*
+	 * Lock the lcn bitmap for writing but only if not rolling back.  We
+	 * must hold the lock all the way including through rollback otherwise
+	 * rollback is not possible because once we have cleared a bit and
+	 * dropped the lock, anyone could have set the bit again, thus
+	 * allocating the cluster for another use.
+	 */
+	if (likely(!is_rollback)) {
+		memalloc_flags = memalloc_nofs_save();
+		down_write(&vol->lcnbmp_lock);
+	}
+
+	total_freed = real_freed = 0;
+
+	rl = ntfs_attr_find_vcn_nolock(ni, start_vcn, ctx);
+	if (IS_ERR(rl)) {
+		err = PTR_ERR(rl);
+		if (err == -ENOENT) {
+			if (likely(!is_rollback)) {
+				up_write(&vol->lcnbmp_lock);
+				memalloc_nofs_restore(memalloc_flags);
+			}
+			return 0;
+		}
+
+		if (!is_rollback)
+			ntfs_error(vol->sb,
+				"Failed to find first runlist element (error %d), aborting.",
+				err);
+		goto err_out;
+	}
+	if (unlikely(rl->lcn < LCN_HOLE)) {
+		if (!is_rollback)
+			ntfs_error(vol->sb, "First runlist element has invalid lcn, aborting.");
+		err = -EIO;
+		goto err_out;
+	}
+	/* Find the starting cluster inside the run that needs freeing. */
+	delta = start_vcn - rl->vcn;
+
+	/* The number of clusters in this run that need freeing. */
+	to_free = rl->length - delta;
+	if (count >= 0 && to_free > count)
+		to_free = count;
+
+	if (likely(rl->lcn >= 0)) {
+		/* Do the actual freeing of the clusters in this run. */
+		err = ntfs_bitmap_set_bits_in_run(lcnbmp_vi, rl->lcn + delta,
+				to_free, likely(!is_rollback) ? 0 : 1);
+		if (unlikely(err)) {
+			if (!is_rollback)
+				ntfs_error(vol->sb,
+					"Failed to clear first run (error %i), aborting.",
+					err);
+			goto err_out;
+		}
+		/* We have freed @to_free real clusters. */
+		real_freed = to_free;
+	}
+	/* Go to the next run and adjust the number of clusters left to free. */
+	++rl;
+	if (count >= 0)
+		count -= to_free;
+
+	/* Keep track of the total "freed" clusters, including sparse ones. */
+	total_freed = to_free;
+	/*
+	 * Loop over the remaining runs, using @count as a capping value, and
+	 * free them.
+	 */
+	for (; rl->length && count != 0; ++rl) {
+		if (unlikely(rl->lcn < LCN_HOLE)) {
+			s64 vcn;
+
+			/* Attempt to map runlist. */
+			vcn = rl->vcn;
+			rl = ntfs_attr_find_vcn_nolock(ni, vcn, ctx);
+			if (IS_ERR(rl)) {
+				err = PTR_ERR(rl);
+				if (!is_rollback)
+					ntfs_error(vol->sb,
+						"Failed to map runlist fragment or failed to find subsequent runlist element.");
+				goto err_out;
+			}
+			if (unlikely(rl->lcn < LCN_HOLE)) {
+				if (!is_rollback)
+					ntfs_error(vol->sb,
+						"Runlist element has invalid lcn (0x%llx).",
+						rl->lcn);
+				err = -EIO;
+				goto err_out;
+			}
+		}
+		/* The number of clusters in this run that need freeing. */
+		to_free = rl->length;
+		if (count >= 0 && to_free > count)
+			to_free = count;
+
+		if (likely(rl->lcn >= 0)) {
+			/* Do the actual freeing of the clusters in the run. */
+			err = ntfs_bitmap_set_bits_in_run(lcnbmp_vi, rl->lcn,
+					to_free, likely(!is_rollback) ? 0 : 1);
+			if (unlikely(err)) {
+				if (!is_rollback)
+					ntfs_error(vol->sb, "Failed to clear subsequent run.");
+				goto err_out;
+			}
+			/* We have freed @to_free real clusters. */
+			real_freed += to_free;
+		}
+		/* Adjust the number of clusters left to free. */
+		if (count >= 0)
+			count -= to_free;
+
+		/* Update the total done clusters. */
+		total_freed += to_free;
+	}
+	ntfs_inc_free_clusters(vol, real_freed);
+	if (likely(!is_rollback)) {
+		up_write(&vol->lcnbmp_lock);
+		memalloc_nofs_restore(memalloc_flags);
+	}
+
+	BUG_ON(count > 0);
+
+	/* We are done.  Return the number of actually freed clusters. */
+	ntfs_debug("Done.");
+	return real_freed;
+err_out:
+	if (is_rollback)
+		return err;
+	/* If no real clusters were freed, no need to rollback. */
+	if (!real_freed) {
+		up_write(&vol->lcnbmp_lock);
+		memalloc_nofs_restore(memalloc_flags);
+		return err;
+	}
+	/*
+	 * Attempt to rollback and if that succeeds just return the error code.
+	 * If rollback fails, set the volume errors flag, emit an error
+	 * message, and return the error code.
+	 */
+	delta = __ntfs_cluster_free(ni, start_vcn, total_freed, ctx, true);
+	if (delta < 0) {
+		ntfs_error(vol->sb,
+			"Failed to rollback (error %i).  Leaving inconsistent metadata!  Unmount and run chkdsk.",
+			(int)delta);
+		NVolSetErrors(vol);
+	}
+	ntfs_dec_free_clusters(vol, delta);
+	up_write(&vol->lcnbmp_lock);
+	memalloc_nofs_restore(memalloc_flags);
+	ntfs_error(vol->sb, "Aborting (error %i).", err);
+	return err;
+}
diff --git a/fs/ntfsplus/runlist.c b/fs/ntfsplus/runlist.c
new file mode 100644
index 000000000000..32ad32989be0
--- /dev/null
+++ b/fs/ntfsplus/runlist.c
@@ -0,0 +1,1995 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/**
+ * NTFS runlist handling code.
+ * Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2001-2007 Anton Altaparmakov
+ * Copyright (c) 2002-2005 Richard Russon
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ *
+ * Part of this file is based on code from the NTFS-3G project.
+ * and is copyrighted by the respective authors below:
+ * Copyright (c) 2002-2005 Anton Altaparmakov
+ * Copyright (c) 2002-2005 Richard Russon
+ * Copyright (c) 2002-2008 Szabolcs Szakacsits
+ * Copyright (c) 2004 Yura Pakhuchiy
+ * Copyright (c) 2007-2022 Jean-Pierre Andre
+ */
+
+#include "misc.h"
+#include "ntfs.h"
+#include "attrib.h"
+
+/**
+ * ntfs_rl_mm - runlist memmove
+ *
+ * It is up to the caller to serialize access to the runlist @base.
+ */
+static inline void ntfs_rl_mm(struct runlist_element *base, int dst, int src, int size)
+{
+	if (likely((dst != src) && (size > 0)))
+		memmove(base + dst, base + src, size * sizeof(*base));
+}
+
+/**
+ * ntfs_rl_mc - runlist memory copy
+ *
+ * It is up to the caller to serialize access to the runlists @dstbase and
+ * @srcbase.
+ */
+static inline void ntfs_rl_mc(struct runlist_element *dstbase, int dst,
+		struct runlist_element *srcbase, int src, int size)
+{
+	if (likely(size > 0))
+		memcpy(dstbase + dst, srcbase + src, size * sizeof(*dstbase));
+}
+
+/**
+ * ntfs_rl_realloc - Reallocate memory for runlists
+ * @rl:		original runlist
+ * @old_size:	number of runlist elements in the original runlist @rl
+ * @new_size:	number of runlist elements we need space for
+ *
+ * As the runlists grow, more memory will be required.  To prevent the
+ * kernel having to allocate and reallocate large numbers of small bits of
+ * memory, this function returns an entire page of memory.
+ *
+ * It is up to the caller to serialize access to the runlist @rl.
+ *
+ * N.B.  If the new allocation doesn't require a different number of pages in
+ *       memory, the function will return the original pointer.
+ */
+struct runlist_element *ntfs_rl_realloc(struct runlist_element *rl,
+		int old_size, int new_size)
+{
+	struct runlist_element *new_rl;
+
+	old_size = PAGE_ALIGN(old_size * sizeof(*rl));
+	new_size = PAGE_ALIGN(new_size * sizeof(*rl));
+	if (old_size == new_size)
+		return rl;
+
+	new_rl = ntfs_malloc_nofs(new_size);
+	if (unlikely(!new_rl))
+		return ERR_PTR(-ENOMEM);
+
+	if (likely(rl != NULL)) {
+		if (unlikely(old_size > new_size))
+			old_size = new_size;
+		memcpy(new_rl, rl, old_size);
+		ntfs_free(rl);
+	}
+	return new_rl;
+}
+
+/**
+ * ntfs_rl_realloc_nofail - Reallocate memory for runlists
+ * @rl:		original runlist
+ * @old_size:	number of runlist elements in the original runlist @rl
+ * @new_size:	number of runlist elements we need space for
+ *
+ * As the runlists grow, more memory will be required.  To prevent the
+ * kernel having to allocate and reallocate large numbers of small bits of
+ * memory, this function returns an entire page of memory.
+ *
+ * This function guarantees that the allocation will succeed.  It will sleep
+ * for as long as it takes to complete the allocation.
+ *
+ * It is up to the caller to serialize access to the runlist @rl.
+ *
+ * N.B.  If the new allocation doesn't require a different number of pages in
+ *       memory, the function will return the original pointer.
+ */
+static inline struct runlist_element *ntfs_rl_realloc_nofail(struct runlist_element *rl,
+		int old_size, int new_size)
+{
+	struct runlist_element *new_rl;
+
+	old_size = PAGE_ALIGN(old_size * sizeof(*rl));
+	new_size = PAGE_ALIGN(new_size * sizeof(*rl));
+	if (old_size == new_size)
+		return rl;
+
+	new_rl = ntfs_malloc_nofs_nofail(new_size);
+	BUG_ON(!new_rl);
+
+	if (likely(rl != NULL)) {
+		if (unlikely(old_size > new_size))
+			old_size = new_size;
+		memcpy(new_rl, rl, old_size);
+		ntfs_free(rl);
+	}
+	return new_rl;
+}
+
+/**
+ * ntfs_are_rl_mergeable - test if two runlists can be joined together
+ * @dst:	original runlist
+ * @src:	new runlist to test for mergeability with @dst
+ *
+ * Test if two runlists can be joined together. For this, their VCNs and LCNs
+ * must be adjacent.
+ *
+ * It is up to the caller to serialize access to the runlists @dst and @src.
+ *
+ * Return: true   Success, the runlists can be merged.
+ *	   false  Failure, the runlists cannot be merged.
+ */
+static inline bool ntfs_are_rl_mergeable(struct runlist_element *dst,
+		struct runlist_element *src)
+{
+	BUG_ON(!dst);
+	BUG_ON(!src);
+
+	/* We can merge unmapped regions even if they are misaligned. */
+	if ((dst->lcn == LCN_RL_NOT_MAPPED) && (src->lcn == LCN_RL_NOT_MAPPED))
+		return true;
+	/* If the runs are misaligned, we cannot merge them. */
+	if ((dst->vcn + dst->length) != src->vcn)
+		return false;
+	/* If both runs are non-sparse and contiguous, we can merge them. */
+	if ((dst->lcn >= 0) && (src->lcn >= 0) &&
+			((dst->lcn + dst->length) == src->lcn))
+		return true;
+	/* If we are merging two holes, we can merge them. */
+	if ((dst->lcn == LCN_HOLE) && (src->lcn == LCN_HOLE))
+		return true;
+	/* If we are merging two dealloc, we can merge them. */
+	if ((dst->lcn == LCN_DELALLOC) && (src->lcn == LCN_DELALLOC))
+		return true;
+	/* Cannot merge. */
+	return false;
+}
+
+/**
+ * __ntfs_rl_merge - merge two runlists without testing if they can be merged
+ * @dst:	original, destination runlist
+ * @src:	new runlist to merge with @dst
+ *
+ * Merge the two runlists, writing into the destination runlist @dst. The
+ * caller must make sure the runlists can be merged or this will corrupt the
+ * destination runlist.
+ *
+ * It is up to the caller to serialize access to the runlists @dst and @src.
+ */
+static inline void __ntfs_rl_merge(struct runlist_element *dst, struct runlist_element *src)
+{
+	dst->length += src->length;
+}
+
+/**
+ * ntfs_rl_append - append a runlist after a given element
+ *
+ * Append the runlist @src after element @loc in @dst.  Merge the right end of
+ * the new runlist, if necessary. Adjust the size of the hole before the
+ * appended runlist.
+ *
+ * It is up to the caller to serialize access to the runlists @dst and @src.
+ *
+ * On success, return a pointer to the new, combined, runlist. Note, both
+ * runlists @dst and @src are deallocated before returning so you cannot use
+ * the pointers for anything any more. (Strictly speaking the returned runlist
+ * may be the same as @dst but this is irrelevant.)
+ */
+static inline struct runlist_element *ntfs_rl_append(struct runlist_element *dst,
+		int dsize, struct runlist_element *src, int ssize, int loc,
+		size_t *new_size)
+{
+	bool right = false;	/* Right end of @src needs merging. */
+	int marker;		/* End of the inserted runs. */
+
+	BUG_ON(!dst);
+	BUG_ON(!src);
+
+	/* First, check if the right hand end needs merging. */
+	if ((loc + 1) < dsize)
+		right = ntfs_are_rl_mergeable(src + ssize - 1, dst + loc + 1);
+
+	/* Space required: @dst size + @src size, less one if we merged. */
+	dst = ntfs_rl_realloc(dst, dsize, dsize + ssize - right);
+	if (IS_ERR(dst))
+		return dst;
+
+	*new_size = dsize + ssize - right;
+	/*
+	 * We are guaranteed to succeed from here so can start modifying the
+	 * original runlists.
+	 */
+
+	/* First, merge the right hand end, if necessary. */
+	if (right)
+		__ntfs_rl_merge(src + ssize - 1, dst + loc + 1);
+
+	/* First run after the @src runs that have been inserted. */
+	marker = loc + ssize + 1;
+
+	/* Move the tail of @dst out of the way, then copy in @src. */
+	ntfs_rl_mm(dst, marker, loc + 1 + right, dsize - (loc + 1 + right));
+	ntfs_rl_mc(dst, loc + 1, src, 0, ssize);
+
+	/* Adjust the size of the preceding hole. */
+	dst[loc].length = dst[loc + 1].vcn - dst[loc].vcn;
+
+	/* We may have changed the length of the file, so fix the end marker */
+	if (dst[marker].lcn == LCN_ENOENT)
+		dst[marker].vcn = dst[marker - 1].vcn + dst[marker - 1].length;
+
+	return dst;
+}
+
+/**
+ * ntfs_rl_insert - insert a runlist into another
+ *
+ * Insert the runlist @src before element @loc in the runlist @dst. Merge the
+ * left end of the new runlist, if necessary. Adjust the size of the hole
+ * after the inserted runlist.
+ *
+ * It is up to the caller to serialize access to the runlists @dst and @src.
+ *
+ * On success, return a pointer to the new, combined, runlist. Note, both
+ * runlists @dst and @src are deallocated before returning so you cannot use
+ * the pointers for anything any more. (Strictly speaking the returned runlist
+ * may be the same as @dst but this is irrelevant.)
+ */
+static inline struct runlist_element *ntfs_rl_insert(struct runlist_element *dst,
+		int dsize, struct runlist_element *src, int ssize, int loc,
+		size_t *new_size)
+{
+	bool left = false;	/* Left end of @src needs merging. */
+	bool disc = false;	/* Discontinuity between @dst and @src. */
+	int marker;		/* End of the inserted runs. */
+
+	BUG_ON(!dst);
+	BUG_ON(!src);
+
+	/*
+	 * disc => Discontinuity between the end of @dst and the start of @src.
+	 *	   This means we might need to insert a "not mapped" run.
+	 */
+	if (loc == 0)
+		disc = (src[0].vcn > 0);
+	else {
+		s64 merged_length;
+
+		left = ntfs_are_rl_mergeable(dst + loc - 1, src);
+
+		merged_length = dst[loc - 1].length;
+		if (left)
+			merged_length += src->length;
+
+		disc = (src[0].vcn > dst[loc - 1].vcn + merged_length);
+	}
+	/*
+	 * Space required: @dst size + @src size, less one if we merged, plus
+	 * one if there was a discontinuity.
+	 */
+	dst = ntfs_rl_realloc(dst, dsize, dsize + ssize - left + disc);
+	if (IS_ERR(dst))
+		return dst;
+
+	*new_size = dsize + ssize - left + disc;
+	/*
+	 * We are guaranteed to succeed from here so can start modifying the
+	 * original runlist.
+	 */
+	if (left)
+		__ntfs_rl_merge(dst + loc - 1, src);
+	/*
+	 * First run after the @src runs that have been inserted.
+	 * Nominally,  @marker equals @loc + @ssize, i.e. location + number of
+	 * runs in @src.  However, if @left, then the first run in @src has
+	 * been merged with one in @dst.  And if @disc, then @dst and @src do
+	 * not meet and we need an extra run to fill the gap.
+	 */
+	marker = loc + ssize - left + disc;
+
+	/* Move the tail of @dst out of the way, then copy in @src. */
+	ntfs_rl_mm(dst, marker, loc, dsize - loc);
+	ntfs_rl_mc(dst, loc + disc, src, left, ssize - left);
+
+	/* Adjust the VCN of the first run after the insertion... */
+	dst[marker].vcn = dst[marker - 1].vcn + dst[marker - 1].length;
+	/* ... and the length. */
+	if (dst[marker].lcn == LCN_HOLE || dst[marker].lcn == LCN_RL_NOT_MAPPED ||
+	    dst[marker].lcn == LCN_DELALLOC)
+		dst[marker].length = dst[marker + 1].vcn - dst[marker].vcn;
+
+	/* Writing beyond the end of the file and there is a discontinuity. */
+	if (disc) {
+		if (loc > 0) {
+			dst[loc].vcn = dst[loc - 1].vcn + dst[loc - 1].length;
+			dst[loc].length = dst[loc + 1].vcn - dst[loc].vcn;
+		} else {
+			dst[loc].vcn = 0;
+			dst[loc].length = dst[loc + 1].vcn;
+		}
+		dst[loc].lcn = LCN_RL_NOT_MAPPED;
+	}
+	return dst;
+}
+
+/**
+ * ntfs_rl_replace - overwrite a runlist element with another runlist
+ *
+ * Replace the runlist element @dst at @loc with @src. Merge the left and
+ * right ends of the inserted runlist, if necessary.
+ *
+ * It is up to the caller to serialize access to the runlists @dst and @src.
+ *
+ * On success, return a pointer to the new, combined, runlist. Note, both
+ * runlists @dst and @src are deallocated before returning so you cannot use
+ * the pointers for anything any more. (Strictly speaking the returned runlist
+ * may be the same as @dst but this is irrelevant.)
+ */
+static inline struct runlist_element *ntfs_rl_replace(struct runlist_element *dst,
+		int dsize, struct runlist_element *src, int ssize, int loc,
+		size_t *new_size)
+{
+	int delta;
+	bool left = false;	/* Left end of @src needs merging. */
+	bool right = false;	/* Right end of @src needs merging. */
+	int tail;		/* Start of tail of @dst. */
+	int marker;		/* End of the inserted runs. */
+
+	BUG_ON(!dst);
+	BUG_ON(!src);
+
+	/* First, see if the left and right ends need merging. */
+	if ((loc + 1) < dsize)
+		right = ntfs_are_rl_mergeable(src + ssize - 1, dst + loc + 1);
+	if (loc > 0)
+		left = ntfs_are_rl_mergeable(dst + loc - 1, src);
+	/*
+	 * Allocate some space.  We will need less if the left, right, or both
+	 * ends get merged.  The -1 accounts for the run being replaced.
+	 */
+	delta = ssize - 1 - left - right;
+	if (delta > 0) {
+		dst = ntfs_rl_realloc(dst, dsize, dsize + delta);
+		if (IS_ERR(dst))
+			return dst;
+	}
+
+	*new_size = dsize + delta;
+	/*
+	 * We are guaranteed to succeed from here so can start modifying the
+	 * original runlists.
+	 */
+
+	/* First, merge the left and right ends, if necessary. */
+	if (right)
+		__ntfs_rl_merge(src + ssize - 1, dst + loc + 1);
+	if (left)
+		__ntfs_rl_merge(dst + loc - 1, src);
+	/*
+	 * Offset of the tail of @dst.  This needs to be moved out of the way
+	 * to make space for the runs to be copied from @src, i.e. the first
+	 * run of the tail of @dst.
+	 * Nominally, @tail equals @loc + 1, i.e. location, skipping the
+	 * replaced run.  However, if @right, then one of @dst's runs is
+	 * already merged into @src.
+	 */
+	tail = loc + right + 1;
+	/*
+	 * First run after the @src runs that have been inserted, i.e. where
+	 * the tail of @dst needs to be moved to.
+	 * Nominally, @marker equals @loc + @ssize, i.e. location + number of
+	 * runs in @src.  However, if @left, then the first run in @src has
+	 * been merged with one in @dst.
+	 */
+	marker = loc + ssize - left;
+
+	/* Move the tail of @dst out of the way, then copy in @src. */
+	ntfs_rl_mm(dst, marker, tail, dsize - tail);
+	ntfs_rl_mc(dst, loc, src, left, ssize - left);
+
+	/* We may have changed the length of the file, so fix the end marker. */
+	if (dsize - tail > 0 && dst[marker].lcn == LCN_ENOENT)
+		dst[marker].vcn = dst[marker - 1].vcn + dst[marker - 1].length;
+	return dst;
+}
+
+/**
+ * ntfs_rl_split - insert a runlist into the centre of a hole
+ *
+ * Split the runlist @dst at @loc into two and insert @new in between the two
+ * fragments. No merging of runlists is necessary. Adjust the size of the
+ * holes either side.
+ *
+ * It is up to the caller to serialize access to the runlists @dst and @src.
+ *
+ * On success, return a pointer to the new, combined, runlist. Note, both
+ * runlists @dst and @src are deallocated before returning so you cannot use
+ * the pointers for anything any more. (Strictly speaking the returned runlist
+ * may be the same as @dst but this is irrelevant.)
+ */
+static inline struct runlist_element *ntfs_rl_split(struct runlist_element *dst, int dsize,
+		struct runlist_element *src, int ssize, int loc,
+		size_t *new_size)
+{
+	BUG_ON(!dst);
+	BUG_ON(!src);
+
+	/* Space required: @dst size + @src size + one new hole. */
+	dst = ntfs_rl_realloc(dst, dsize, dsize + ssize + 1);
+	if (IS_ERR(dst))
+		return dst;
+
+	*new_size = dsize + ssize + 1;
+	/*
+	 * We are guaranteed to succeed from here so can start modifying the
+	 * original runlists.
+	 */
+
+	/* Move the tail of @dst out of the way, then copy in @src. */
+	ntfs_rl_mm(dst, loc + 1 + ssize, loc, dsize - loc);
+	ntfs_rl_mc(dst, loc + 1, src, 0, ssize);
+
+	/* Adjust the size of the holes either size of @src. */
+	dst[loc].length		= dst[loc+1].vcn       - dst[loc].vcn;
+	dst[loc+ssize+1].vcn    = dst[loc+ssize].vcn   + dst[loc+ssize].length;
+	dst[loc+ssize+1].length = dst[loc+ssize+2].vcn - dst[loc+ssize+1].vcn;
+
+	return dst;
+}
+
+/**
+ * ntfs_runlists_merge - merge two runlists into one
+ *
+ * First we sanity check the two runlists @srl and @drl to make sure that they
+ * are sensible and can be merged. The runlist @srl must be either after the
+ * runlist @drl or completely within a hole (or unmapped region) in @drl.
+ *
+ * It is up to the caller to serialize access to the runlists @drl and @srl.
+ *
+ * Merging of runlists is necessary in two cases:
+ *   1. When attribute lists are used and a further extent is being mapped.
+ *   2. When new clusters are allocated to fill a hole or extend a file.
+ *
+ * There are four possible ways @srl can be merged. It can:
+ *	- be inserted at the beginning of a hole,
+ *	- split the hole in two and be inserted between the two fragments,
+ *	- be appended at the end of a hole, or it can
+ *	- replace the whole hole.
+ * It can also be appended to the end of the runlist, which is just a variant
+ * of the insert case.
+ *
+ * On success, return a pointer to the new, combined, runlist. Note, both
+ * runlists @drl and @srl are deallocated before returning so you cannot use
+ * the pointers for anything any more. (Strictly speaking the returned runlist
+ * may be the same as @dst but this is irrelevant.)
+ */
+struct runlist_element *ntfs_runlists_merge(struct runlist *d_runlist,
+				     struct runlist_element *srl, size_t s_rl_count,
+				     size_t *new_rl_count)
+{
+	int di, si;		/* Current index into @[ds]rl. */
+	int sstart;		/* First index with lcn > LCN_RL_NOT_MAPPED. */
+	int dins;		/* Index into @drl at which to insert @srl. */
+	int dend, send;		/* Last index into @[ds]rl. */
+	int dfinal, sfinal;	/* The last index into @[ds]rl with lcn >= LCN_HOLE. */
+	int marker = 0;
+	s64 marker_vcn = 0;
+	struct runlist_element *drl = d_runlist->rl, *rl;
+
+#ifdef DEBUG
+	ntfs_debug("dst:");
+	ntfs_debug_dump_runlist(drl);
+	ntfs_debug("src:");
+	ntfs_debug_dump_runlist(srl);
+#endif
+
+	/* Check for silly calling... */
+	if (unlikely(!srl))
+		return drl;
+	if (IS_ERR(srl) || IS_ERR(drl))
+		return ERR_PTR(-EINVAL);
+
+	if (s_rl_count == 0) {
+		for (; srl[s_rl_count].length; s_rl_count++)
+			;
+		s_rl_count++;
+	}
+
+	/* Check for the case where the first mapping is being done now. */
+	if (unlikely(!drl)) {
+		drl = srl;
+		/* Complete the source runlist if necessary. */
+		if (unlikely(drl[0].vcn)) {
+			/* Scan to the end of the source runlist. */
+			drl = ntfs_rl_realloc(drl, s_rl_count, s_rl_count + 1);
+			if (IS_ERR(drl))
+				return drl;
+			/* Insert start element at the front of the runlist. */
+			ntfs_rl_mm(drl, 1, 0, s_rl_count);
+			drl[0].vcn = 0;
+			drl[0].lcn = LCN_RL_NOT_MAPPED;
+			drl[0].length = drl[1].vcn;
+			s_rl_count++;
+		}
+
+		*new_rl_count = s_rl_count;
+		goto finished;
+	}
+
+	if (d_runlist->count < 1 || s_rl_count < 2)
+		return ERR_PTR(-EINVAL);
+
+	si = di = 0;
+
+	/* Skip any unmapped start element(s) in the source runlist. */
+	while (srl[si].length && srl[si].lcn < LCN_HOLE)
+		si++;
+
+	/* Can't have an entirely unmapped source runlist. */
+	BUG_ON(!srl[si].length);
+
+	/* Record the starting points. */
+	sstart = si;
+
+	/*
+	 * Skip forward in @drl until we reach the position where @srl needs to
+	 * be inserted. If we reach the end of @drl, @srl just needs to be
+	 * appended to @drl.
+	 */
+	rl = __ntfs_attr_find_vcn_nolock(d_runlist, srl[sstart].vcn);
+	if (IS_ERR(rl))
+		di = (int)d_runlist->count - 1;
+	else
+		di = (int)(rl - d_runlist->rl);
+	dins = di;
+
+	/* Sanity check for illegal overlaps. */
+	if ((drl[di].vcn == srl[si].vcn) && (drl[di].lcn >= 0) &&
+			(srl[si].lcn >= 0)) {
+		ntfs_error(NULL, "Run lists overlap. Cannot merge!");
+		return ERR_PTR(-ERANGE);
+	}
+
+	/* Scan to the end of both runlists in order to know their sizes. */
+	send = (int)s_rl_count - 1;
+	dend = (int)d_runlist->count - 1;
+
+	if (srl[send].lcn == LCN_ENOENT)
+		marker_vcn = srl[marker = send].vcn;
+
+	/* Scan to the last element with lcn >= LCN_HOLE. */
+	for (sfinal = send; sfinal >= 0 && srl[sfinal].lcn < LCN_HOLE; sfinal--)
+		;
+	for (dfinal = dend; dfinal >= 0 && drl[dfinal].lcn < LCN_HOLE; dfinal--)
+		;
+
+	{
+	bool start;
+	bool finish;
+	int ds = dend + 1;		/* Number of elements in drl & srl */
+	int ss = sfinal - sstart + 1;
+
+	start  = ((drl[dins].lcn <  LCN_RL_NOT_MAPPED) ||    /* End of file   */
+		  (drl[dins].vcn == srl[sstart].vcn));	     /* Start of hole */
+	finish = ((drl[dins].lcn >= LCN_RL_NOT_MAPPED) &&    /* End of file   */
+		 ((drl[dins].vcn + drl[dins].length) <=      /* End of hole   */
+		  (srl[send - 1].vcn + srl[send - 1].length)));
+
+	/* Or we will lose an end marker. */
+	if (finish && !drl[dins].length)
+		ss++;
+	if (marker && (drl[dins].vcn + drl[dins].length > srl[send - 1].vcn))
+		finish = false;
+
+	if (start) {
+		if (finish)
+			drl = ntfs_rl_replace(drl, ds, srl + sstart, ss, dins, new_rl_count);
+		else
+			drl = ntfs_rl_insert(drl, ds, srl + sstart, ss, dins, new_rl_count);
+	} else {
+		if (finish)
+			drl = ntfs_rl_append(drl, ds, srl + sstart, ss, dins, new_rl_count);
+		else
+			drl = ntfs_rl_split(drl, ds, srl + sstart, ss, dins, new_rl_count);
+	}
+	if (IS_ERR(drl)) {
+		ntfs_error(NULL, "Merge failed.");
+		return drl;
+	}
+	ntfs_free(srl);
+	if (marker) {
+		ntfs_debug("Triggering marker code.");
+		for (ds = dend; drl[ds].length; ds++)
+			;
+		/* We only need to care if @srl ended after @drl. */
+		if (drl[ds].vcn <= marker_vcn) {
+			int slots = 0;
+
+			if (drl[ds].vcn == marker_vcn) {
+				ntfs_debug("Old marker = 0x%llx, replacing with LCN_ENOENT.",
+						drl[ds].lcn);
+				drl[ds].lcn = LCN_ENOENT;
+				goto finished;
+			}
+			/*
+			 * We need to create an unmapped runlist element in
+			 * @drl or extend an existing one before adding the
+			 * ENOENT terminator.
+			 */
+			if (drl[ds].lcn == LCN_ENOENT) {
+				ds--;
+				slots = 1;
+			}
+			if (drl[ds].lcn != LCN_RL_NOT_MAPPED) {
+				/* Add an unmapped runlist element. */
+				if (!slots) {
+					drl = ntfs_rl_realloc_nofail(drl, ds,
+							ds + 2);
+					slots = 2;
+					*new_rl_count += 2;
+				}
+				ds++;
+				/* Need to set vcn if it isn't set already. */
+				if (slots != 1)
+					drl[ds].vcn = drl[ds - 1].vcn +
+							drl[ds - 1].length;
+				drl[ds].lcn = LCN_RL_NOT_MAPPED;
+				/* We now used up a slot. */
+				slots--;
+			}
+			drl[ds].length = marker_vcn - drl[ds].vcn;
+			/* Finally add the ENOENT terminator. */
+			ds++;
+			if (!slots) {
+				drl = ntfs_rl_realloc_nofail(drl, ds, ds + 1);
+				*new_rl_count += 1;
+			}
+			drl[ds].vcn = marker_vcn;
+			drl[ds].lcn = LCN_ENOENT;
+			drl[ds].length = (s64)0;
+		}
+	}
+	}
+
+finished:
+	/* The merge was completed successfully. */
+	ntfs_debug("Merged runlist:");
+	ntfs_debug_dump_runlist(drl);
+	return drl;
+}
+
+/**
+ * ntfs_mapping_pairs_decompress - convert mapping pairs array to runlist
+ *
+ * It is up to the caller to serialize access to the runlist @old_rl.
+ *
+ * Decompress the attribute @attr's mapping pairs array into a runlist. On
+ * success, return the decompressed runlist.
+ *
+ * If @old_rl is not NULL, decompressed runlist is inserted into the
+ * appropriate place in @old_rl and the resultant, combined runlist is
+ * returned. The original @old_rl is deallocated.
+ *
+ * On error, return -errno. @old_rl is left unmodified in that case.
+ */
+struct runlist_element *ntfs_mapping_pairs_decompress(const struct ntfs_volume *vol,
+		const struct attr_record *attr, struct runlist *old_runlist,
+		size_t *new_rl_count)
+{
+	s64 vcn;		/* Current vcn. */
+	s64 lcn;		/* Current lcn. */
+	s64 deltaxcn;		/* Change in [vl]cn. */
+	struct runlist_element *rl, *new_rl;	/* The output runlist. */
+	u8 *buf;		/* Current position in mapping pairs array. */
+	u8 *attr_end;		/* End of attribute. */
+	int rlsize;		/* Size of runlist buffer. */
+	u16 rlpos;		/* Current runlist position in units of struct runlist_elements. */
+	u8 b;			/* Current byte offset in buf. */
+
+#ifdef DEBUG
+	/* Make sure attr exists and is non-resident. */
+	if (!attr || !attr->non_resident ||
+	    le64_to_cpu(attr->data.non_resident.lowest_vcn) < 0) {
+		ntfs_error(vol->sb, "Invalid arguments.");
+		return ERR_PTR(-EINVAL);
+	}
+#endif
+	/* Start at vcn = lowest_vcn and lcn 0. */
+	vcn = le64_to_cpu(attr->data.non_resident.lowest_vcn);
+	lcn = 0;
+	/* Get start of the mapping pairs array. */
+	buf = (u8 *)attr +
+		le16_to_cpu(attr->data.non_resident.mapping_pairs_offset);
+	attr_end = (u8 *)attr + le32_to_cpu(attr->length);
+	if (unlikely(buf < (u8 *)attr || buf > attr_end)) {
+		ntfs_error(vol->sb, "Corrupt attribute.");
+		return ERR_PTR(-EIO);
+	}
+
+	/* Current position in runlist array. */
+	rlpos = 0;
+	/* Allocate first page and set current runlist size to one page. */
+	rl = ntfs_malloc_nofs(rlsize = PAGE_SIZE);
+	if (unlikely(!rl))
+		return ERR_PTR(-ENOMEM);
+	/* Insert unmapped starting element if necessary. */
+	if (vcn) {
+		rl->vcn = 0;
+		rl->lcn = LCN_RL_NOT_MAPPED;
+		rl->length = vcn;
+		rlpos++;
+	}
+	while (buf < attr_end && *buf) {
+		/*
+		 * Allocate more memory if needed, including space for the
+		 * not-mapped and terminator elements. ntfs_malloc_nofs()
+		 * operates on whole pages only.
+		 */
+		if (((rlpos + 3) * sizeof(*rl)) > rlsize) {
+			struct runlist_element *rl2;
+
+			rl2 = ntfs_malloc_nofs(rlsize + (int)PAGE_SIZE);
+			if (unlikely(!rl2)) {
+				ntfs_free(rl);
+				return ERR_PTR(-ENOMEM);
+			}
+			memcpy(rl2, rl, rlsize);
+			ntfs_free(rl);
+			rl = rl2;
+			rlsize += PAGE_SIZE;
+		}
+		/* Enter the current vcn into the current runlist element. */
+		rl[rlpos].vcn = vcn;
+		/*
+		 * Get the change in vcn, i.e. the run length in clusters.
+		 * Doing it this way ensures that we signextend negative values.
+		 * A negative run length doesn't make any sense, but hey, I
+		 * didn't make up the NTFS specs and Windows NT4 treats the run
+		 * length as a signed value so that's how it is...
+		 */
+		b = *buf & 0xf;
+		if (b) {
+			if (unlikely(buf + b > attr_end))
+				goto io_error;
+			for (deltaxcn = (s8)buf[b--]; b; b--)
+				deltaxcn = (deltaxcn << 8) + buf[b];
+		} else { /* The length entry is compulsory. */
+			ntfs_error(vol->sb, "Missing length entry in mapping pairs array.");
+			deltaxcn = (s64)-1;
+		}
+		/*
+		 * Assume a negative length to indicate data corruption and
+		 * hence clean-up and return NULL.
+		 */
+		if (unlikely(deltaxcn < 0)) {
+			ntfs_error(vol->sb, "Invalid length in mapping pairs array.");
+			goto err_out;
+		}
+		/*
+		 * Enter the current run length into the current runlist
+		 * element.
+		 */
+		rl[rlpos].length = deltaxcn;
+		/* Increment the current vcn by the current run length. */
+		vcn += deltaxcn;
+		/*
+		 * There might be no lcn change at all, as is the case for
+		 * sparse clusters on NTFS 3.0+, in which case we set the lcn
+		 * to LCN_HOLE.
+		 */
+		if (!(*buf & 0xf0))
+			rl[rlpos].lcn = LCN_HOLE;
+		else {
+			/* Get the lcn change which really can be negative. */
+			u8 b2 = *buf & 0xf;
+
+			b = b2 + ((*buf >> 4) & 0xf);
+			if (buf + b > attr_end)
+				goto io_error;
+			for (deltaxcn = (s8)buf[b--]; b > b2; b--)
+				deltaxcn = (deltaxcn << 8) + buf[b];
+			/* Change the current lcn to its new value. */
+			lcn += deltaxcn;
+#ifdef DEBUG
+			/*
+			 * On NTFS 1.2-, apparently can have lcn == -1 to
+			 * indicate a hole. But we haven't verified ourselves
+			 * whether it is really the lcn or the deltaxcn that is
+			 * -1. So if either is found give us a message so we
+			 * can investigate it further!
+			 */
+			if (vol->major_ver < 3) {
+				if (unlikely(deltaxcn == -1))
+					ntfs_error(vol->sb, "lcn delta == -1");
+				if (unlikely(lcn == -1))
+					ntfs_error(vol->sb, "lcn == -1");
+			}
+#endif
+			/* Check lcn is not below -1. */
+			if (unlikely(lcn < -1)) {
+				ntfs_error(vol->sb, "Invalid s64 < -1 in mapping pairs array.");
+				goto err_out;
+			}
+
+			/* chkdsk accepts zero-sized runs only for holes */
+			if ((lcn != -1) && !rl[rlpos].length) {
+				ntfs_error(vol->sb, "Invalid zero-sized data run.\n");
+				goto err_out;
+			}
+
+			/* Enter the current lcn into the runlist element. */
+			rl[rlpos].lcn = lcn;
+		}
+		/* Get to the next runlist element, skipping zero-sized holes */
+		if (rl[rlpos].length)
+			rlpos++;
+		/* Increment the buffer position to the next mapping pair. */
+		buf += (*buf & 0xf) + ((*buf >> 4) & 0xf) + 1;
+	}
+	if (unlikely(buf >= attr_end))
+		goto io_error;
+	/*
+	 * If there is a highest_vcn specified, it must be equal to the final
+	 * vcn in the runlist - 1, or something has gone badly wrong.
+	 */
+	deltaxcn = le64_to_cpu(attr->data.non_resident.highest_vcn);
+	if (unlikely(deltaxcn && vcn - 1 != deltaxcn)) {
+mpa_err:
+		ntfs_error(vol->sb, "Corrupt mapping pairs array in non-resident attribute.");
+		goto err_out;
+	}
+	/* Setup not mapped runlist element if this is the base extent. */
+	if (!attr->data.non_resident.lowest_vcn) {
+		s64 max_cluster;
+
+		max_cluster = ((le64_to_cpu(attr->data.non_resident.allocated_size) +
+				vol->cluster_size - 1) >>
+				vol->cluster_size_bits) - 1;
+		/*
+		 * A highest_vcn of zero means this is a single extent
+		 * attribute so simply terminate the runlist with LCN_ENOENT).
+		 */
+		if (deltaxcn) {
+			/*
+			 * If there is a difference between the highest_vcn and
+			 * the highest cluster, the runlist is either corrupt
+			 * or, more likely, there are more extents following
+			 * this one.
+			 */
+			if (deltaxcn < max_cluster) {
+				ntfs_debug("More extents to follow; deltaxcn = 0x%llx, max_cluster = 0x%llx",
+						deltaxcn, max_cluster);
+				rl[rlpos].vcn = vcn;
+				vcn += rl[rlpos].length = max_cluster -
+						deltaxcn;
+				rl[rlpos].lcn = LCN_RL_NOT_MAPPED;
+				rlpos++;
+			} else if (unlikely(deltaxcn > max_cluster)) {
+				ntfs_error(vol->sb,
+					   "Corrupt attribute. deltaxcn = 0x%llx, max_cluster = 0x%llx",
+					   deltaxcn, max_cluster);
+				goto mpa_err;
+			}
+		}
+		rl[rlpos].lcn = LCN_ENOENT;
+	} else /* Not the base extent. There may be more extents to follow. */
+		rl[rlpos].lcn = LCN_RL_NOT_MAPPED;
+
+	/* Setup terminating runlist element. */
+	rl[rlpos].vcn = vcn;
+	rl[rlpos].length = (s64)0;
+	/* If no existing runlist was specified, we are done. */
+	if (!old_runlist || !old_runlist->rl) {
+		*new_rl_count = rlpos + 1;
+		ntfs_debug("Mapping pairs array successfully decompressed:");
+		ntfs_debug_dump_runlist(rl);
+		return rl;
+	}
+	/* Now combine the new and old runlists checking for overlaps. */
+	new_rl = ntfs_runlists_merge(old_runlist, rl, rlpos + 1, new_rl_count);
+	if (!IS_ERR(new_rl))
+		return new_rl;
+	ntfs_free(rl);
+	ntfs_error(vol->sb, "Failed to merge runlists.");
+	return new_rl;
+io_error:
+	ntfs_error(vol->sb, "Corrupt attribute.");
+err_out:
+	ntfs_free(rl);
+	return ERR_PTR(-EIO);
+}
+
+/**
+ * ntfs_rl_vcn_to_lcn - convert a vcn into a lcn given a runlist
+ * @rl:		runlist to use for conversion
+ * @vcn:	vcn to convert
+ *
+ * Convert the virtual cluster number @vcn of an attribute into a logical
+ * cluster number (lcn) of a device using the runlist @rl to map vcns to their
+ * corresponding lcns.
+ *
+ * It is up to the caller to serialize access to the runlist @rl.
+ *
+ * Since lcns must be >= 0, we use negative return codes with special meaning:
+ *
+ * Return code		Meaning / Description
+ * ==================================================
+ *  LCN_HOLE		Hole / not allocated on disk.
+ *  LCN_RL_NOT_MAPPED	This is part of the runlist which has not been
+ *			inserted into the runlist yet.
+ *  LCN_ENOENT		There is no such vcn in the attribute.
+ *
+ * Locking: - The caller must have locked the runlist (for reading or writing).
+ *	    - This function does not touch the lock, nor does it modify the
+ *	      runlist.
+ */
+s64 ntfs_rl_vcn_to_lcn(const struct runlist_element *rl, const s64 vcn)
+{
+	int i;
+
+	BUG_ON(vcn < 0);
+	/*
+	 * If rl is NULL, assume that we have found an unmapped runlist. The
+	 * caller can then attempt to map it and fail appropriately if
+	 * necessary.
+	 */
+	if (unlikely(!rl))
+		return LCN_RL_NOT_MAPPED;
+
+	/* Catch out of lower bounds vcn. */
+	if (unlikely(vcn < rl[0].vcn))
+		return LCN_ENOENT;
+
+	for (i = 0; likely(rl[i].length); i++) {
+		if (vcn < rl[i+1].vcn) {
+			if (likely(rl[i].lcn >= 0))
+				return rl[i].lcn + (vcn - rl[i].vcn);
+			return rl[i].lcn;
+		}
+	}
+	/*
+	 * The terminator element is setup to the correct value, i.e. one of
+	 * LCN_HOLE, LCN_RL_NOT_MAPPED, or LCN_ENOENT.
+	 */
+	if (likely(rl[i].lcn < 0))
+		return rl[i].lcn;
+	/* Just in case... We could replace this with BUG() some day. */
+	return LCN_ENOENT;
+}
+
+/**
+ * ntfs_rl_find_vcn_nolock - find a vcn in a runlist
+ * @rl:		runlist to search
+ * @vcn:	vcn to find
+ *
+ * Find the virtual cluster number @vcn in the runlist @rl and return the
+ * address of the runlist element containing the @vcn on success.
+ *
+ * Return NULL if @rl is NULL or @vcn is in an unmapped part/out of bounds of
+ * the runlist.
+ *
+ * Locking: The runlist must be locked on entry.
+ */
+struct runlist_element *ntfs_rl_find_vcn_nolock(struct runlist_element *rl, const s64 vcn)
+{
+	BUG_ON(vcn < 0);
+	if (unlikely(!rl || vcn < rl[0].vcn))
+		return NULL;
+	while (likely(rl->length)) {
+		if (unlikely(vcn < rl[1].vcn)) {
+			if (likely(rl->lcn >= LCN_HOLE))
+				return rl;
+			return NULL;
+		}
+		rl++;
+	}
+	if (likely(rl->lcn == LCN_ENOENT))
+		return rl;
+	return NULL;
+}
+
+/**
+ * ntfs_get_nr_significant_bytes - get number of bytes needed to store a number
+ * @n:		number for which to get the number of bytes for
+ *
+ * Return the number of bytes required to store @n unambiguously as
+ * a signed number.
+ *
+ * This is used in the context of the mapping pairs array to determine how
+ * many bytes will be needed in the array to store a given logical cluster
+ * number (lcn) or a specific run length.
+ *
+ * Return the number of bytes written.  This function cannot fail.
+ */
+static inline int ntfs_get_nr_significant_bytes(const s64 n)
+{
+	s64 l = n;
+	int i;
+	s8 j;
+
+	i = 0;
+	do {
+		l >>= 8;
+		i++;
+	} while (l != 0 && l != -1);
+	j = (n >> 8 * (i - 1)) & 0xff;
+	/* If the sign bit is wrong, we need an extra byte. */
+	if ((n < 0 && j >= 0) || (n > 0 && j < 0))
+		i++;
+	return i;
+}
+
+/**
+ * ntfs_get_size_for_mapping_pairs - get bytes needed for mapping pairs array
+ *
+ * Walk the locked runlist @rl and calculate the size in bytes of the mapping
+ * pairs array corresponding to the runlist @rl, starting at vcn @first_vcn and
+ * finishing with vcn @last_vcn.
+ *
+ * A @last_vcn of -1 means end of runlist and in that case the size of the
+ * mapping pairs array corresponding to the runlist starting at vcn @first_vcn
+ * and finishing at the end of the runlist is determined.
+ *
+ * This for example allows us to allocate a buffer of the right size when
+ * building the mapping pairs array.
+ *
+ * If @rl is NULL, just return 1 (for the single terminator byte).
+ *
+ * Return the calculated size in bytes on success.  On error, return -errno.
+ */
+int ntfs_get_size_for_mapping_pairs(const struct ntfs_volume *vol,
+		const struct runlist_element *rl, const s64 first_vcn,
+		const s64 last_vcn, int max_mp_size)
+{
+	s64 prev_lcn;
+	int rls;
+	bool the_end = false;
+
+	BUG_ON(first_vcn < 0);
+	BUG_ON(last_vcn < -1);
+	BUG_ON(last_vcn >= 0 && first_vcn > last_vcn);
+	if (!rl) {
+		BUG_ON(first_vcn);
+		BUG_ON(last_vcn > 0);
+		return 1;
+	}
+	if (max_mp_size <= 0)
+		max_mp_size = INT_MAX;
+	/* Skip to runlist element containing @first_vcn. */
+	while (rl->length && first_vcn >= rl[1].vcn)
+		rl++;
+	if (unlikely((!rl->length && first_vcn > rl->vcn) ||
+			first_vcn < rl->vcn))
+		return -EINVAL;
+	prev_lcn = 0;
+	/* Always need the termining zero byte. */
+	rls = 1;
+	/* Do the first partial run if present. */
+	if (first_vcn > rl->vcn) {
+		s64 delta, length = rl->length;
+
+		/* We know rl->length != 0 already. */
+		if (unlikely(length < 0 || rl->lcn < LCN_HOLE))
+			goto err_out;
+		/*
+		 * If @stop_vcn is given and finishes inside this run, cap the
+		 * run length.
+		 */
+		if (unlikely(last_vcn >= 0 && rl[1].vcn > last_vcn)) {
+			s64 s1 = last_vcn + 1;
+
+			if (unlikely(rl[1].vcn > s1))
+				length = s1 - rl->vcn;
+			the_end = true;
+		}
+		delta = first_vcn - rl->vcn;
+		/* Header byte + length. */
+		rls += 1 + ntfs_get_nr_significant_bytes(length - delta);
+		/*
+		 * If the logical cluster number (lcn) denotes a hole and we
+		 * are on NTFS 3.0+, we don't store it at all, i.e. we need
+		 * zero space.  On earlier NTFS versions we just store the lcn.
+		 * Note: this assumes that on NTFS 1.2-, holes are stored with
+		 * an lcn of -1 and not a delta_lcn of -1 (unless both are -1).
+		 */
+		if (likely(rl->lcn >= 0 || vol->major_ver < 3)) {
+			prev_lcn = rl->lcn;
+			if (likely(rl->lcn >= 0))
+				prev_lcn += delta;
+			/* Change in lcn. */
+			rls += ntfs_get_nr_significant_bytes(prev_lcn);
+		}
+		/* Go to next runlist element. */
+		rl++;
+	}
+	/* Do the full runs. */
+	for (; rl->length && !the_end; rl++) {
+		s64 length = rl->length;
+
+		if (unlikely(length < 0 || rl->lcn < LCN_HOLE))
+			goto err_out;
+		/*
+		 * If @stop_vcn is given and finishes inside this run, cap the
+		 * run length.
+		 */
+		if (unlikely(last_vcn >= 0 && rl[1].vcn > last_vcn)) {
+			s64 s1 = last_vcn + 1;
+
+			if (unlikely(rl[1].vcn > s1))
+				length = s1 - rl->vcn;
+			the_end = true;
+		}
+		/* Header byte + length. */
+		rls += 1 + ntfs_get_nr_significant_bytes(length);
+		/*
+		 * If the logical cluster number (lcn) denotes a hole and we
+		 * are on NTFS 3.0+, we don't store it at all, i.e. we need
+		 * zero space.  On earlier NTFS versions we just store the lcn.
+		 * Note: this assumes that on NTFS 1.2-, holes are stored with
+		 * an lcn of -1 and not a delta_lcn of -1 (unless both are -1).
+		 */
+		if (likely(rl->lcn >= 0 || vol->major_ver < 3)) {
+			/* Change in lcn. */
+			rls += ntfs_get_nr_significant_bytes(rl->lcn -
+					prev_lcn);
+			prev_lcn = rl->lcn;
+		}
+
+		if (rls > max_mp_size)
+			break;
+	}
+	return rls;
+err_out:
+	if (rl->lcn == LCN_RL_NOT_MAPPED)
+		rls = -EINVAL;
+	else
+		rls = -EIO;
+	return rls;
+}
+
+/**
+ * ntfs_write_significant_bytes - write the significant bytes of a number
+ * @dst:	destination buffer to write to
+ * @dst_max:	pointer to last byte of destination buffer for bounds checking
+ * @n:		number whose significant bytes to write
+ *
+ * Store in @dst, the minimum bytes of the number @n which are required to
+ * identify @n unambiguously as a signed number, taking care not to exceed
+ * @dest_max, the maximum position within @dst to which we are allowed to
+ * write.
+ *
+ * This is used when building the mapping pairs array of a runlist to compress
+ * a given logical cluster number (lcn) or a specific run length to the minimum
+ * size possible.
+ *
+ * Return the number of bytes written on success.  On error, i.e. the
+ * destination buffer @dst is too small, return -ENOSPC.
+ */
+static inline int ntfs_write_significant_bytes(s8 *dst, const s8 *dst_max,
+		const s64 n)
+{
+	s64 l = n;
+	int i;
+	s8 j;
+
+	i = 0;
+	do {
+		if (unlikely(dst > dst_max))
+			goto err_out;
+		*dst++ = l & 0xffll;
+		l >>= 8;
+		i++;
+	} while (l != 0 && l != -1);
+	j = (n >> 8 * (i - 1)) & 0xff;
+	/* If the sign bit is wrong, we need an extra byte. */
+	if (n < 0 && j >= 0) {
+		if (unlikely(dst > dst_max))
+			goto err_out;
+		i++;
+		*dst = (s8)-1;
+	} else if (n > 0 && j < 0) {
+		if (unlikely(dst > dst_max))
+			goto err_out;
+		i++;
+		*dst = (s8)0;
+	}
+	return i;
+err_out:
+	return -ENOSPC;
+}
+
+/**
+ * ntfs_mapping_pairs_build - build the mapping pairs array from a runlist
+ *
+ * Create the mapping pairs array from the locked runlist @rl, starting at vcn
+ * @first_vcn and finishing with vcn @last_vcn and save the array in @dst.
+ * @dst_len is the size of @dst in bytes and it should be at least equal to the
+ * value obtained by calling ntfs_get_size_for_mapping_pairs().
+ *
+ * A @last_vcn of -1 means end of runlist and in that case the mapping pairs
+ * array corresponding to the runlist starting at vcn @first_vcn and finishing
+ * at the end of the runlist is created.
+ *
+ * If @rl is NULL, just write a single terminator byte to @dst.
+ *
+ * On success or -ENOSPC error, if @stop_vcn is not NULL, *@stop_vcn is set to
+ * the first vcn outside the destination buffer.  Note that on error, @dst has
+ * been filled with all the mapping pairs that will fit, thus it can be treated
+ * as partial success, in that a new attribute extent needs to be created or
+ * the next extent has to be used and the mapping pairs build has to be
+ * continued with @first_vcn set to *@stop_vcn.
+ */
+int ntfs_mapping_pairs_build(const struct ntfs_volume *vol, s8 *dst,
+		const int dst_len, const struct runlist_element *rl,
+		const s64 first_vcn, const s64 last_vcn, s64 *const stop_vcn,
+		struct runlist_element **stop_rl, unsigned int *de_cluster_count)
+{
+	s64 prev_lcn;
+	s8 *dst_max, *dst_next;
+	int err = -ENOSPC;
+	bool the_end = false;
+	s8 len_len, lcn_len;
+	unsigned int de_cnt = 0;
+
+	BUG_ON(first_vcn < 0);
+	BUG_ON(last_vcn < -1);
+	BUG_ON(last_vcn >= 0 && first_vcn > last_vcn);
+	BUG_ON(dst_len < 1);
+	if (!rl) {
+		BUG_ON(first_vcn);
+		BUG_ON(last_vcn > 0);
+		if (stop_vcn)
+			*stop_vcn = 0;
+		/* Terminator byte. */
+		*dst = 0;
+		return 0;
+	}
+	/* Skip to runlist element containing @first_vcn. */
+	while (rl->length && first_vcn >= rl[1].vcn)
+		rl++;
+	if (unlikely((!rl->length && first_vcn > rl->vcn) ||
+			first_vcn < rl->vcn))
+		return -EINVAL;
+	/*
+	 * @dst_max is used for bounds checking in
+	 * ntfs_write_significant_bytes().
+	 */
+	dst_max = dst + dst_len - 1;
+	prev_lcn = 0;
+	/* Do the first partial run if present. */
+	if (first_vcn > rl->vcn) {
+		s64 delta, length = rl->length;
+
+		/* We know rl->length != 0 already. */
+		if (unlikely(length < 0 || rl->lcn < LCN_HOLE))
+			goto err_out;
+		/*
+		 * If @stop_vcn is given and finishes inside this run, cap the
+		 * run length.
+		 */
+		if (unlikely(last_vcn >= 0 && rl[1].vcn > last_vcn)) {
+			s64 s1 = last_vcn + 1;
+
+			if (unlikely(rl[1].vcn > s1))
+				length = s1 - rl->vcn;
+			the_end = true;
+		}
+		delta = first_vcn - rl->vcn;
+		/* Write length. */
+		len_len = ntfs_write_significant_bytes(dst + 1, dst_max,
+				length - delta);
+		if (unlikely(len_len < 0))
+			goto size_err;
+		/*
+		 * If the logical cluster number (lcn) denotes a hole and we
+		 * are on NTFS 3.0+, we don't store it at all, i.e. we need
+		 * zero space.  On earlier NTFS versions we just write the lcn
+		 * change.
+		 */
+		if (likely(rl->lcn >= 0 || vol->major_ver < 3)) {
+			prev_lcn = rl->lcn;
+			if (likely(rl->lcn >= 0))
+				prev_lcn += delta;
+			/* Write change in lcn. */
+			lcn_len = ntfs_write_significant_bytes(dst + 1 +
+					len_len, dst_max, prev_lcn);
+			if (unlikely(lcn_len < 0))
+				goto size_err;
+		} else
+			lcn_len = 0;
+		dst_next = dst + len_len + lcn_len + 1;
+		if (unlikely(dst_next > dst_max))
+			goto size_err;
+		/* Update header byte. */
+		*dst = lcn_len << 4 | len_len;
+		/* Position at next mapping pairs array element. */
+		dst = dst_next;
+		/* Go to next runlist element. */
+		rl++;
+	}
+	/* Do the full runs. */
+	for (; rl->length && !the_end; rl++) {
+		s64 length = rl->length;
+
+		if (unlikely(length < 0 || rl->lcn < LCN_HOLE))
+			goto err_out;
+		/*
+		 * If @stop_vcn is given and finishes inside this run, cap the
+		 * run length.
+		 */
+		if (unlikely(last_vcn >= 0 && rl[1].vcn > last_vcn)) {
+			s64 s1 = last_vcn + 1;
+
+			if (unlikely(rl[1].vcn > s1))
+				length = s1 - rl->vcn;
+			the_end = true;
+		}
+		/* Write length. */
+		len_len = ntfs_write_significant_bytes(dst + 1, dst_max,
+				length);
+		if (unlikely(len_len < 0))
+			goto size_err;
+		/*
+		 * If the logical cluster number (lcn) denotes a hole and we
+		 * are on NTFS 3.0+, we don't store it at all, i.e. we need
+		 * zero space.  On earlier NTFS versions we just write the lcn
+		 * change.
+		 */
+		if (likely(rl->lcn >= 0 || vol->major_ver < 3)) {
+			/* Write change in lcn. */
+			lcn_len = ntfs_write_significant_bytes(dst + 1 +
+					len_len, dst_max, rl->lcn - prev_lcn);
+			if (unlikely(lcn_len < 0))
+				goto size_err;
+			prev_lcn = rl->lcn;
+		} else {
+			if (rl->lcn == LCN_DELALLOC)
+				de_cnt += rl->length;
+			lcn_len = 0;
+		}
+		dst_next = dst + len_len + lcn_len + 1;
+		if (unlikely(dst_next > dst_max))
+			goto size_err;
+		/* Update header byte. */
+		*dst = lcn_len << 4 | len_len;
+		/* Position at next mapping pairs array element. */
+		dst = dst_next;
+	}
+	/* Success. */
+	if (de_cluster_count)
+		*de_cluster_count = de_cnt;
+	err = 0;
+size_err:
+	/* Set stop vcn. */
+	if (stop_vcn)
+		*stop_vcn = rl->vcn;
+	if (stop_rl)
+		*stop_rl = (struct runlist_element *)rl;
+	/* Add terminator byte. */
+	*dst = 0;
+	return err;
+err_out:
+	if (rl->lcn == LCN_RL_NOT_MAPPED)
+		err = -EINVAL;
+	else
+		err = -EIO;
+	return err;
+}
+
+/**
+ * ntfs_rl_truncate_nolock - truncate a runlist starting at a specified vcn
+ * @vol:	ntfs volume (needed for error output)
+ * @runlist:	runlist to truncate
+ * @new_length:	the new length of the runlist in VCNs
+ *
+ * Truncate the runlist described by @runlist as well as the memory buffer
+ * holding the runlist elements to a length of @new_length VCNs.
+ *
+ * If @new_length lies within the runlist, the runlist elements with VCNs of
+ * @new_length and above are discarded.  As a special case if @new_length is
+ * zero, the runlist is discarded and set to NULL.
+ *
+ * If @new_length lies beyond the runlist, a sparse runlist element is added to
+ * the end of the runlist @runlist or if the last runlist element is a sparse
+ * one already, this is extended.
+ *
+ * Note, no checking is done for unmapped runlist elements.  It is assumed that
+ * the caller has mapped any elements that need to be mapped already.
+ *
+ * Return 0 on success and -errno on error.
+ */
+int ntfs_rl_truncate_nolock(const struct ntfs_volume *vol, struct runlist *const runlist,
+		const s64 new_length)
+{
+	struct runlist_element *rl;
+	int old_size;
+
+	ntfs_debug("Entering for new_length 0x%llx.", (long long)new_length);
+	BUG_ON(!runlist);
+	BUG_ON(new_length < 0);
+	rl = runlist->rl;
+
+	BUG_ON(new_length < rl->vcn);
+	/* Find @new_length in the runlist. */
+	while (likely(rl->length && new_length >= rl[1].vcn))
+		rl++;
+	/*
+	 * If not at the end of the runlist we need to shrink it.
+	 * If at the end of the runlist we need to expand it.
+	 */
+	if (rl->length) {
+		struct runlist_element *trl;
+		bool is_end;
+
+		ntfs_debug("Shrinking runlist.");
+		/* Determine the runlist size. */
+		trl = rl + 1;
+		while (likely(trl->length))
+			trl++;
+		old_size = trl - runlist->rl + 1;
+		/* Truncate the run. */
+		rl->length = new_length - rl->vcn;
+		/*
+		 * If a run was partially truncated, make the following runlist
+		 * element a terminator.
+		 */
+		is_end = false;
+		if (rl->length) {
+			rl++;
+			if (!rl->length)
+				is_end = true;
+			rl->vcn = new_length;
+			rl->length = 0;
+		}
+		rl->lcn = LCN_ENOENT;
+		runlist->count = rl - runlist->rl + 1;
+		/* Reallocate memory if necessary. */
+		if (!is_end) {
+			int new_size = rl - runlist->rl + 1;
+
+			rl = ntfs_rl_realloc(runlist->rl, old_size, new_size);
+			if (IS_ERR(rl))
+				ntfs_warning(vol->sb,
+					"Failed to shrink runlist buffer.  This just wastes a bit of memory temporarily so we ignore it and return success.");
+			else
+				runlist->rl = rl;
+		}
+	} else if (likely(/* !rl->length && */ new_length > rl->vcn)) {
+		ntfs_debug("Expanding runlist.");
+		/*
+		 * If there is a previous runlist element and it is a sparse
+		 * one, extend it.  Otherwise need to add a new, sparse runlist
+		 * element.
+		 */
+		if ((rl > runlist->rl) && ((rl - 1)->lcn == LCN_HOLE))
+			(rl - 1)->length = new_length - (rl - 1)->vcn;
+		else {
+			/* Determine the runlist size. */
+			old_size = rl - runlist->rl + 1;
+			/* Reallocate memory if necessary. */
+			rl = ntfs_rl_realloc(runlist->rl, old_size,
+					old_size + 1);
+			if (IS_ERR(rl)) {
+				ntfs_error(vol->sb, "Failed to expand runlist buffer, aborting.");
+				return PTR_ERR(rl);
+			}
+			runlist->rl = rl;
+			/*
+			 * Set @rl to the same runlist element in the new
+			 * runlist as before in the old runlist.
+			 */
+			rl += old_size - 1;
+			/* Add a new, sparse runlist element. */
+			rl->lcn = LCN_HOLE;
+			rl->length = new_length - rl->vcn;
+			/* Add a new terminator runlist element. */
+			rl++;
+			rl->length = 0;
+			runlist->count = old_size + 1;
+		}
+		rl->vcn = new_length;
+		rl->lcn = LCN_ENOENT;
+	} else /* if (unlikely(!rl->length && new_length == rl->vcn)) */ {
+		/* Runlist already has same size as requested. */
+		rl->lcn = LCN_ENOENT;
+	}
+	ntfs_debug("Done.");
+	return 0;
+}
+
+/**
+ * ntfs_rl_sparse - check whether runlist have sparse regions or not.
+ * @rl:         runlist to check
+ *
+ * Return 1 if have, 0 if not, -errno on error.
+ */
+int ntfs_rl_sparse(struct runlist_element *rl)
+{
+	struct runlist_element *rlc;
+
+	if (!rl)
+		return -EINVAL;
+
+	for (rlc = rl; rlc->length; rlc++)
+		if (rlc->lcn < 0) {
+			if (rlc->lcn != LCN_HOLE && rlc->lcn != LCN_DELALLOC) {
+				pr_err("%s: bad runlist", __func__);
+				return -EINVAL;
+			}
+			return 1;
+		}
+	return 0;
+}
+
+/**
+ * ntfs_rl_get_compressed_size - calculate length of non sparse regions
+ * @vol:        ntfs volume (need for cluster size)
+ * @rl:         runlist to calculate for
+ *
+ * Return compressed size or -errno on error.
+ */
+s64 ntfs_rl_get_compressed_size(struct ntfs_volume *vol, struct runlist_element *rl)
+{
+	struct runlist_element *rlc;
+	s64 ret = 0;
+
+	if (!rl)
+		return -EINVAL;
+
+	for (rlc = rl; rlc->length; rlc++) {
+		if (rlc->lcn < 0) {
+			if (rlc->lcn != LCN_HOLE && rlc->lcn != LCN_DELALLOC) {
+				ntfs_error(vol->sb, "%s: bad runlist, rlc->lcn : %lld",
+						__func__, rlc->lcn);
+				return -EINVAL;
+			}
+		} else
+			ret += rlc->length;
+	}
+	return ret << vol->cluster_size_bits;
+}
+
+static inline bool ntfs_rle_lcn_contiguous(struct runlist_element *left_rle,
+					   struct runlist_element *right_rle)
+{
+	if (left_rle->lcn > LCN_HOLE &&
+	    left_rle->lcn + left_rle->length == right_rle->lcn)
+		return true;
+	else if (left_rle->lcn == LCN_HOLE && right_rle->lcn == LCN_HOLE)
+		return true;
+	else
+		return false;
+}
+
+static inline bool ntfs_rle_contain(struct runlist_element *rle, s64 vcn)
+{
+	if (rle->length > 0 &&
+	    vcn >= rle->vcn && vcn < rle->vcn + rle->length)
+		return true;
+	else
+		return false;
+}
+
+struct runlist_element *ntfs_rl_insert_range(struct runlist_element *dst_rl, int dst_cnt,
+				      struct runlist_element *src_rl, int src_cnt,
+				      size_t *new_rl_cnt)
+{
+	struct runlist_element *i_rl, *new_rl, *src_rl_origin = src_rl;
+	struct runlist_element dst_rl_split;
+	s64 start_vcn = src_rl[0].vcn;
+	int new_1st_cnt, new_2nd_cnt, new_3rd_cnt, new_cnt;
+
+	if (!dst_rl || !src_rl || !new_rl_cnt)
+		return ERR_PTR(-EINVAL);
+	if (dst_cnt <= 0 || src_cnt <= 0)
+		return ERR_PTR(-EINVAL);
+	if (!(dst_rl[dst_cnt - 1].lcn == LCN_ENOENT &&
+	      dst_rl[dst_cnt - 1].length == 0) ||
+	    src_rl[src_cnt - 1].lcn < LCN_HOLE)
+		return ERR_PTR(-EINVAL);
+
+	start_vcn = src_rl[0].vcn;
+
+	i_rl = ntfs_rl_find_vcn_nolock(dst_rl, start_vcn);
+	if (!i_rl ||
+	    (i_rl->lcn == LCN_ENOENT && i_rl->vcn != start_vcn) ||
+	    (i_rl->lcn != LCN_ENOENT && !ntfs_rle_contain(i_rl, start_vcn)))
+		return ERR_PTR(-EINVAL);
+
+	new_1st_cnt = (int)(i_rl - dst_rl);
+	if (new_1st_cnt > dst_cnt)
+		return ERR_PTR(-EINVAL);
+	new_3rd_cnt = dst_cnt - new_1st_cnt;
+	if (new_3rd_cnt < 1)
+		return ERR_PTR(-EINVAL);
+
+	if (i_rl[0].vcn != start_vcn) {
+		if (i_rl[0].lcn == LCN_HOLE && src_rl[0].lcn == LCN_HOLE)
+			goto merge_src_rle;
+
+		/* split @i_rl[0] and create @dst_rl_split */
+		dst_rl_split.vcn = i_rl[0].vcn;
+		dst_rl_split.length = start_vcn - i_rl[0].vcn;
+		dst_rl_split.lcn = i_rl[0].lcn;
+
+		i_rl[0].vcn = start_vcn;
+		i_rl[0].length -= dst_rl_split.length;
+		i_rl[0].lcn += dst_rl_split.length;
+	} else {
+		struct runlist_element *dst_rle, *src_rle;
+merge_src_rle:
+
+		/* not split @i_rl[0] */
+		dst_rl_split.lcn = LCN_ENOENT;
+
+		/* merge @src_rl's first run and @i_rl[0]'s left run if possible */
+		dst_rle = &dst_rl[new_1st_cnt - 1];
+		src_rle = &src_rl[0];
+		if (new_1st_cnt > 0 && ntfs_rle_lcn_contiguous(dst_rle, src_rle)) {
+			BUG_ON(dst_rle->vcn + dst_rle->length != src_rle->vcn);
+			dst_rle->length += src_rle->length;
+			src_rl++;
+			src_cnt--;
+		} else {
+			/* merge @src_rl's last run and @i_rl[0]'s right if possible */
+			dst_rle = &dst_rl[new_1st_cnt];
+			src_rle = &src_rl[src_cnt - 1];
+
+			if (ntfs_rle_lcn_contiguous(dst_rle, src_rle)) {
+				dst_rle->length += src_rle->length;
+				src_cnt--;
+			}
+		}
+	}
+
+	new_2nd_cnt = src_cnt;
+	new_cnt = new_1st_cnt + new_2nd_cnt + new_3rd_cnt;
+	new_cnt += dst_rl_split.lcn >= LCN_HOLE ? 1 : 0;
+	new_rl = ntfs_malloc_nofs(new_cnt * sizeof(*new_rl));
+	if (!new_rl)
+		return ERR_PTR(-ENOMEM);
+
+	/* Copy the @dst_rl's first half to @new_rl */
+	ntfs_rl_mc(new_rl, 0, dst_rl, 0, new_1st_cnt);
+	if (dst_rl_split.lcn >= LCN_HOLE) {
+		ntfs_rl_mc(new_rl, new_1st_cnt, &dst_rl_split, 0, 1);
+		new_1st_cnt++;
+	}
+	/* Copy the @src_rl to @new_rl */
+	ntfs_rl_mc(new_rl, new_1st_cnt, src_rl, 0, new_2nd_cnt);
+	/* Copy the @dst_rl's second half to @new_rl */
+	if (new_3rd_cnt >= 1) {
+		struct runlist_element *rl, *rl_3rd;
+		int dst_1st_cnt = dst_rl_split.lcn >= LCN_HOLE ?
+			new_1st_cnt - 1 : new_1st_cnt;
+
+		ntfs_rl_mc(new_rl, new_1st_cnt + new_2nd_cnt,
+			   dst_rl, dst_1st_cnt, new_3rd_cnt);
+		/* Update vcn of the @dst_rl's second half runs to reflect
+		 * appended @src_rl.
+		 */
+		if (new_1st_cnt + new_2nd_cnt == 0) {
+			rl_3rd = &new_rl[new_1st_cnt + new_2nd_cnt + 1];
+			rl = &new_rl[new_1st_cnt + new_2nd_cnt];
+		} else {
+			rl_3rd = &new_rl[new_1st_cnt + new_2nd_cnt];
+			rl = &new_rl[new_1st_cnt + new_2nd_cnt - 1];
+		}
+		do {
+			rl_3rd->vcn = rl->vcn + rl->length;
+			if (rl_3rd->length <= 0)
+				break;
+			rl = rl_3rd;
+			rl_3rd++;
+		} while (1);
+	}
+	*new_rl_cnt = new_1st_cnt + new_2nd_cnt + new_3rd_cnt;
+
+	ntfs_free(dst_rl);
+	ntfs_free(src_rl_origin);
+	return new_rl;
+}
+
+struct runlist_element *ntfs_rl_punch_hole(struct runlist_element *dst_rl, int dst_cnt,
+				    s64 start_vcn, s64 len,
+				    struct runlist_element **punch_rl,
+				    size_t *new_rl_cnt)
+{
+	struct runlist_element *s_rl, *e_rl, *new_rl, *dst_3rd_rl, hole_rl[1];
+	s64 end_vcn;
+	int new_1st_cnt, dst_3rd_cnt, new_cnt, punch_cnt, merge_cnt;
+	bool begin_split, end_split, one_split_3;
+
+	if (dst_cnt < 2 ||
+	    !(dst_rl[dst_cnt - 1].lcn == LCN_ENOENT &&
+	      dst_rl[dst_cnt - 1].length == 0))
+		return ERR_PTR(-EINVAL);
+
+	end_vcn = min(start_vcn + len - 1,
+		      dst_rl[dst_cnt - 2].vcn + dst_rl[dst_cnt - 2].length - 1);
+
+	s_rl = ntfs_rl_find_vcn_nolock(dst_rl, start_vcn);
+	if (!s_rl ||
+	    s_rl->lcn <= LCN_ENOENT ||
+	    !ntfs_rle_contain(s_rl, start_vcn))
+		return ERR_PTR(-EINVAL);
+
+	begin_split = s_rl->vcn != start_vcn ? true : false;
+
+	e_rl = ntfs_rl_find_vcn_nolock(dst_rl, end_vcn);
+	if (!e_rl ||
+	    e_rl->lcn <= LCN_ENOENT ||
+	    !ntfs_rle_contain(e_rl, end_vcn))
+		return ERR_PTR(-EINVAL);
+
+	end_split = e_rl->vcn + e_rl->length - 1 != end_vcn ? true : false;
+
+	/* @s_rl has to be split into left, punched hole, and right */
+	one_split_3 = e_rl == s_rl && begin_split && end_split ? true : false;
+
+	punch_cnt = (int)(e_rl - s_rl) + 1;
+
+	*punch_rl = ntfs_malloc_nofs((punch_cnt + 1) * sizeof(struct runlist_element));
+	if (!*punch_rl)
+		return ERR_PTR(-ENOMEM);
+
+	new_cnt = dst_cnt - (int)(e_rl - s_rl + 1) + 3;
+	new_rl = ntfs_malloc_nofs(new_cnt * sizeof(struct runlist_element));
+	if (!new_rl) {
+		ntfs_free(*punch_rl);
+		*punch_rl = NULL;
+		return ERR_PTR(-ENOMEM);
+	}
+
+	new_1st_cnt = (int)(s_rl - dst_rl) + 1;
+	ntfs_rl_mc(*punch_rl, 0, dst_rl, new_1st_cnt - 1, punch_cnt);
+
+	(*punch_rl)[punch_cnt].lcn = LCN_ENOENT;
+	(*punch_rl)[punch_cnt].length = 0;
+
+	if (!begin_split)
+		new_1st_cnt--;
+	dst_3rd_rl = e_rl;
+	dst_3rd_cnt = (int)(&dst_rl[dst_cnt - 1] - e_rl) + 1;
+	if (!end_split) {
+		dst_3rd_rl++;
+		dst_3rd_cnt--;
+	}
+
+	/* Copy the 1st part of @dst_rl into @new_rl */
+	ntfs_rl_mc(new_rl, 0, dst_rl, 0, new_1st_cnt);
+	if (begin_split) {
+		/* the @e_rl has to be splited and copied into the last of @new_rl
+		 * and the first of @punch_rl
+		 */
+		s64 first_cnt = start_vcn - dst_rl[new_1st_cnt - 1].vcn;
+
+		if (new_1st_cnt)
+			new_rl[new_1st_cnt - 1].length = first_cnt;
+
+		(*punch_rl)[0].vcn = start_vcn;
+		(*punch_rl)[0].length -= first_cnt;
+		if ((*punch_rl)[0].lcn > LCN_HOLE)
+			(*punch_rl)[0].lcn += first_cnt;
+	}
+
+	/* Copy a hole into @new_rl */
+	hole_rl[0].vcn = start_vcn;
+	hole_rl[0].length = (s64)len;
+	hole_rl[0].lcn = LCN_HOLE;
+	ntfs_rl_mc(new_rl, new_1st_cnt, hole_rl, 0, 1);
+
+	/* Copy the 3rd part of @dst_rl into @new_rl */
+	ntfs_rl_mc(new_rl, new_1st_cnt + 1, dst_3rd_rl, 0, dst_3rd_cnt);
+	if (end_split) {
+		/* the @e_rl has to be splited and copied into the first of
+		 * @new_rl and the last of @punch_rl
+		 */
+		s64 first_cnt = end_vcn - dst_3rd_rl[0].vcn + 1;
+
+		new_rl[new_1st_cnt + 1].vcn = end_vcn + 1;
+		new_rl[new_1st_cnt + 1].length -= first_cnt;
+		if (new_rl[new_1st_cnt + 1].lcn > LCN_HOLE)
+			new_rl[new_1st_cnt + 1].lcn += first_cnt;
+
+		if (one_split_3)
+			(*punch_rl)[punch_cnt - 1].length -=
+				new_rl[new_1st_cnt + 1].length;
+		else
+			(*punch_rl)[punch_cnt - 1].length = first_cnt;
+	}
+
+	/* Merge left and hole, or hole and right in @new_rl, if left or right
+	 * consists of holes.
+	 */
+	merge_cnt = 0;
+	if (new_1st_cnt > 0 && new_rl[new_1st_cnt - 1].lcn == LCN_HOLE) {
+		/* Merge right and hole */
+		s_rl =  &new_rl[new_1st_cnt - 1];
+		s_rl->length += s_rl[1].length;
+		merge_cnt = 1;
+		/* Merge left and right */
+		if (new_1st_cnt + 1 < new_cnt &&
+		    new_rl[new_1st_cnt + 1].lcn == LCN_HOLE) {
+			s_rl->length += s_rl[2].length;
+			merge_cnt++;
+		}
+	} else if (new_1st_cnt + 1 < new_cnt &&
+		   new_rl[new_1st_cnt + 1].lcn == LCN_HOLE) {
+		/* Merge left and hole */
+		s_rl = &new_rl[new_1st_cnt];
+		s_rl->length += s_rl[1].length;
+		merge_cnt = 1;
+	}
+	if (merge_cnt) {
+		struct runlist_element *d_rl, *src_rl;
+
+		d_rl = s_rl + 1;
+		src_rl = s_rl + 1 + merge_cnt;
+		ntfs_rl_mm(new_rl, (int)(d_rl - new_rl), (int)(src_rl - new_rl),
+			   (int)(&new_rl[new_cnt - 1] - src_rl) + 1);
+	}
+
+	(*punch_rl)[punch_cnt].vcn = (*punch_rl)[punch_cnt - 1].vcn +
+		(*punch_rl)[punch_cnt - 1].length;
+
+	/* punch_cnt elements of dst are replaced with one hole */
+	*new_rl_cnt = dst_cnt - (punch_cnt - (int)begin_split - (int)end_split) +
+		1 - merge_cnt;
+	ntfs_free(dst_rl);
+	return new_rl;
+}
+
+struct runlist_element *ntfs_rl_collapse_range(struct runlist_element *dst_rl, int dst_cnt,
+					s64 start_vcn, s64 len,
+					struct runlist_element **punch_rl,
+					size_t *new_rl_cnt)
+{
+	struct runlist_element *s_rl, *e_rl, *new_rl, *dst_3rd_rl;
+	s64 end_vcn;
+	int new_1st_cnt, dst_3rd_cnt, new_cnt, punch_cnt, merge_cnt, i;
+	bool begin_split, end_split, one_split_3;
+
+	if (dst_cnt < 2 ||
+	    !(dst_rl[dst_cnt - 1].lcn == LCN_ENOENT &&
+	      dst_rl[dst_cnt - 1].length == 0))
+		return ERR_PTR(-EINVAL);
+
+	end_vcn = min(start_vcn + len - 1,
+			dst_rl[dst_cnt - 1].vcn - 1);
+
+	s_rl = ntfs_rl_find_vcn_nolock(dst_rl, start_vcn);
+	if (!s_rl ||
+	    s_rl->lcn <= LCN_ENOENT ||
+	    !ntfs_rle_contain(s_rl, start_vcn))
+		return ERR_PTR(-EINVAL);
+
+	begin_split = s_rl->vcn != start_vcn ? true : false;
+
+	e_rl = ntfs_rl_find_vcn_nolock(dst_rl, end_vcn);
+	if (!e_rl ||
+	    e_rl->lcn <= LCN_ENOENT ||
+	    !ntfs_rle_contain(e_rl, end_vcn))
+		return ERR_PTR(-EINVAL);
+
+	end_split = e_rl->vcn + e_rl->length - 1 != end_vcn ? true : false;
+
+	/* @s_rl has to be split into left, collapsed, and right */
+	one_split_3 = e_rl == s_rl && begin_split && end_split ? true : false;
+
+	punch_cnt = (int)(e_rl - s_rl) + 1;
+	*punch_rl = ntfs_malloc_nofs((punch_cnt + 1) * sizeof(struct runlist_element));
+	if (!*punch_rl)
+		return ERR_PTR(-ENOMEM);
+
+	new_cnt = dst_cnt - (int)(e_rl - s_rl + 1) + 3;
+	new_rl = ntfs_malloc_nofs(new_cnt * sizeof(struct runlist_element));
+	if (!new_rl) {
+		ntfs_free(*punch_rl);
+		*punch_rl = NULL;
+		return ERR_PTR(-ENOMEM);
+	}
+
+	new_1st_cnt = (int)(s_rl - dst_rl) + 1;
+	ntfs_rl_mc(*punch_rl, 0, dst_rl, new_1st_cnt - 1, punch_cnt);
+	(*punch_rl)[punch_cnt].lcn = LCN_ENOENT;
+	(*punch_rl)[punch_cnt].length = 0;
+
+	if (!begin_split)
+		new_1st_cnt--;
+	dst_3rd_rl = e_rl;
+	dst_3rd_cnt = (int)(&dst_rl[dst_cnt - 1] - e_rl) + 1;
+	if (!end_split) {
+		dst_3rd_rl++;
+		dst_3rd_cnt--;
+	}
+
+	/* Copy the 1st part of @dst_rl into @new_rl */
+	ntfs_rl_mc(new_rl, 0, dst_rl, 0, new_1st_cnt);
+	if (begin_split) {
+		/* the @e_rl has to be splited and copied into the last of @new_rl
+		 * and the first of @punch_rl
+		 */
+		s64 first_cnt = start_vcn - dst_rl[new_1st_cnt - 1].vcn;
+
+		new_rl[new_1st_cnt - 1].length = first_cnt;
+
+		(*punch_rl)[0].vcn = start_vcn;
+		(*punch_rl)[0].length -= first_cnt;
+		if ((*punch_rl)[0].lcn > LCN_HOLE)
+			(*punch_rl)[0].lcn += first_cnt;
+	}
+
+	/* Copy the 3rd part of @dst_rl into @new_rl */
+	ntfs_rl_mc(new_rl, new_1st_cnt, dst_3rd_rl, 0, dst_3rd_cnt);
+	if (end_split) {
+		/* the @e_rl has to be splited and copied into the first of
+		 * @new_rl and the last of @punch_rl
+		 */
+		s64 first_cnt = end_vcn - dst_3rd_rl[0].vcn + 1;
+
+		new_rl[new_1st_cnt].vcn = end_vcn + 1;
+		new_rl[new_1st_cnt].length -= first_cnt;
+		if (new_rl[new_1st_cnt].lcn > LCN_HOLE)
+			new_rl[new_1st_cnt].lcn += first_cnt;
+
+		if (one_split_3)
+			(*punch_rl)[punch_cnt - 1].length -=
+				new_rl[new_1st_cnt].length;
+		else
+			(*punch_rl)[punch_cnt - 1].length = first_cnt;
+	}
+
+	/* Adjust vcn */
+	if (new_1st_cnt == 0)
+		new_rl[new_1st_cnt].vcn = 0;
+	for (i = new_1st_cnt == 0 ? 1 : new_1st_cnt; new_rl[i].length; i++)
+		new_rl[i].vcn = new_rl[i - 1].vcn + new_rl[i - 1].length;
+	new_rl[i].vcn = new_rl[i - 1].vcn + new_rl[i - 1].length;
+
+	/* Merge left and hole, or hole and right in @new_rl, if left or right
+	 * consists of holes.
+	 */
+	merge_cnt = 0;
+	i = new_1st_cnt == 0 ? 1 : new_1st_cnt;
+	if (ntfs_rle_lcn_contiguous(&new_rl[i - 1], &new_rl[i])) {
+		/* Merge right and left */
+		s_rl =  &new_rl[new_1st_cnt - 1];
+		s_rl->length += s_rl[1].length;
+		merge_cnt = 1;
+	}
+	if (merge_cnt) {
+		struct runlist_element *d_rl, *src_rl;
+
+		d_rl = s_rl + 1;
+		src_rl = s_rl + 1 + merge_cnt;
+		ntfs_rl_mm(new_rl, (int)(d_rl - new_rl), (int)(src_rl - new_rl),
+			   (int)(&new_rl[new_cnt - 1] - src_rl) + 1);
+	}
+
+	(*punch_rl)[punch_cnt].vcn = (*punch_rl)[punch_cnt - 1].vcn +
+		(*punch_rl)[punch_cnt - 1].length;
+
+	/* punch_cnt elements of dst are extracted */
+	*new_rl_cnt = dst_cnt - (punch_cnt - (int)begin_split - (int)end_split) -
+		merge_cnt;
+
+	ntfs_free(dst_rl);
+	return new_rl;
+}
-- 
2.34.1


