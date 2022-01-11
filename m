Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF92A48B70A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350765AbiAKTRn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350773AbiAKTRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:17:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D32C028BE6;
        Tue, 11 Jan 2022 11:16:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F6CAB81D0D;
        Tue, 11 Jan 2022 19:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03BEC36AEF;
        Tue, 11 Jan 2022 19:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928602;
        bh=lb0hIJXnUERbuCcp81ScPIuiAvngf/WqftG6PhyYlew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HIboi3dgaNZGniVpj1b05jXCr84uoE9QcdD91UQzhleWByFdm3TcSX1WUhxibOF0i
         sUQ3o9/kWo+IqWWzpyABeSo0Wq5zV2eMlEJtXlQcHgMPoOJx+Jrl2MP4sGxp2Dtvxa
         geJVlXtigFiEOLnSEyB4JY/26kGQ9prcEKUah5jbahPYM1YxP84nLuxRmP9D5v4uaA
         Zjt/ZZ5ggUBC69EeJXTL+XpdGaG0c6exeXkecwCZIUcmyNKwOPrsuD6Ii22+ejwJGH
         /Gic/+eivxjwdEkv2C7vyL12k+eyTwjDyiq+eVVy+TgITAnTq55HQ167+/NTi0e1ag
         q6Od5jItLJJBg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 44/48] ceph: plumb in decryption during sync reads
Date:   Tue, 11 Jan 2022 14:16:04 -0500
Message-Id: <20220111191608.88762-45-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Note that the crypto block may be smaller than a page, but the reverse
cannot be true.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c | 94 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 25 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 41766b2012e9..b4f2fcd33837 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -926,9 +926,17 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 		bool more;
 		int idx;
 		size_t left;
+		u64 read_off = off;
+		u64 read_len = len;
+
+		/* determine new offset/length if encrypted */
+		fscrypt_adjust_off_and_len(inode, &read_off, &read_len);
+
+		dout("sync_read orig %llu~%llu reading %llu~%llu",
+		     off, len, read_off, read_len);
 
 		req = ceph_osdc_new_request(osdc, &ci->i_layout,
-					ci->i_vino, off, &len, 0, 1,
+					ci->i_vino, read_off, &read_len, 0, 1,
 					CEPH_OSD_OP_READ, CEPH_OSD_FLAG_READ,
 					NULL, ci->i_truncate_seq,
 					ci->i_truncate_size, false);
@@ -937,10 +945,13 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 			break;
 		}
 
+		/* adjust len downward if the request truncated the len */
+		if (off + len > read_off + read_len)
+			len = read_off + read_len - off;
 		more = len < iov_iter_count(to);
 
-		num_pages = calc_pages_for(off, len);
-		page_off = off & ~PAGE_MASK;
+		num_pages = calc_pages_for(read_off, read_len);
+		page_off = offset_in_page(off);
 		pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
 		if (IS_ERR(pages)) {
 			ceph_osdc_put_request(req);
@@ -948,7 +959,8 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 			break;
 		}
 
-		osd_req_op_extent_osd_data_pages(req, 0, pages, len, page_off,
+		osd_req_op_extent_osd_data_pages(req, 0, pages, read_len,
+						 offset_in_page(read_off),
 						 false, false);
 		ret = ceph_osdc_start_request(osdc, req, false);
 		if (!ret)
@@ -957,23 +969,50 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 		ceph_update_read_metrics(&fsc->mdsc->metric,
 					 req->r_start_latency,
 					 req->r_end_latency,
-					 len, ret);
+					 read_len, ret);
 
 		if (ret > 0)
 			objver = req->r_version;
 		ceph_osdc_put_request(req);
-
 		i_size = i_size_read(inode);
 		dout("sync_read %llu~%llu got %zd i_size %llu%s\n",
 		     off, len, ret, i_size, (more ? " MORE" : ""));
 
-		if (ret == -ENOENT)
+		if (ret == -ENOENT) {
+			/* No object? Then this is a hole */
 			ret = 0;
+		} else if (ret > 0 && IS_ENCRYPTED(inode)) {
+			int fret;
+
+			fret = ceph_fscrypt_decrypt_pages(inode, pages, read_off, ret);
+			if (fret < 0) {
+				ceph_release_page_vector(pages, num_pages);
+				ret = fret;
+				break;
+			}
+
+			dout("sync_read decrypted fret %d\n", fret);
+
+			/* account for any partial block at the beginning */
+			fret -= (off - read_off);
+
+			/*
+			 * Short read after big offset adjustment?
+			 * Nothing is usable, just call it a zero
+			 * len read.
+			 */
+			fret = max(fret, 0);
+
+			/* account for partial block at the end */
+			ret = min_t(ssize_t, fret, len);
+		}
+
+		/* Short read but not EOF? Zero out the remainder. */
 		if (ret >= 0 && ret < len && (off + ret < i_size)) {
 			int zlen = min(len - ret, i_size - off - ret);
 			int zoff = page_off + ret;
 			dout("sync_read zero gap %llu~%llu\n",
-                             off + ret, off + ret + zlen);
+			     off + ret, off + ret + zlen);
 			ceph_zero_page_vector_range(zoff, zlen, pages);
 			ret += zlen;
 		}
@@ -981,15 +1020,15 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 		idx = 0;
 		left = ret > 0 ? ret : 0;
 		while (left > 0) {
-			size_t len, copied;
-			page_off = off & ~PAGE_MASK;
-			len = min_t(size_t, left, PAGE_SIZE - page_off);
+			size_t plen, copied;
+			plen = min_t(size_t, left, PAGE_SIZE - page_off);
 			SetPageUptodate(pages[idx]);
 			copied = copy_page_to_iter(pages[idx++],
-						   page_off, len, to);
+						   page_off, plen, to);
 			off += copied;
 			left -= copied;
-			if (copied < len) {
+			page_off = 0;
+			if (copied < plen) {
 				ret = -EFAULT;
 				break;
 			}
@@ -1006,20 +1045,21 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 			break;
 	}
 
-	if (off > *ki_pos) {
-		if (off >= i_size) {
-			*retry_op = CHECK_EOF;
-			ret = i_size - *ki_pos;
-			*ki_pos = i_size;
-		} else {
-			ret = off - *ki_pos;
-			*ki_pos = off;
+	if (ret > 0) {
+		if (off > *ki_pos) {
+			if (off >= i_size) {
+				*retry_op = CHECK_EOF;
+				ret = i_size - *ki_pos;
+				*ki_pos = i_size;
+			} else {
+				ret = off - *ki_pos;
+				*ki_pos = off;
+			}
 		}
-	}
-
-	if (last_objver && ret > 0)
-		*last_objver = objver;
 
+		if (last_objver)
+			*last_objver = objver;
+	}
 	dout("sync_read result %zd retry_op %d\n", ret, *retry_op);
 	return ret;
 }
@@ -1532,6 +1572,9 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		last = (pos + len) != (write_pos + write_len);
 		rmw = first || last;
 
+		dout("sync_write ino %llx %lld~%llu adjusted %lld~%llu -- %srmw\n",
+		     ci->i_vino.ino, pos, len, write_pos, write_len, rmw ? "" : "no ");
+
 		/*
 		 * The data is emplaced into the page as it would be if it were in
 		 * an array of pagecache pages.
@@ -1761,6 +1804,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		ceph_clear_error_write(ci);
 		pos += len;
 		written += len;
+		dout("sync_write written %d\n", written);
 		if (pos > i_size_read(inode)) {
 			check_caps = ceph_inode_set_size(inode, pos);
 			if (check_caps)
-- 
2.34.1

