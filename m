Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98649D89E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 09:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbfJPHhb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 03:37:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732851AbfJPHha (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:37:30 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9G7bAe1081770
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 03:37:30 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vnx1u232d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 03:37:29 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 16 Oct 2019 08:37:26 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Oct 2019 08:37:24 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9G7bNn743647184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 07:37:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71629AE053;
        Wed, 16 Oct 2019 07:37:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 252DBAE045;
        Wed, 16 Oct 2019 07:37:21 +0000 (GMT)
Received: from dhcp-9-199-158-105.in.ibm.com (unknown [9.199.158.105])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Oct 2019 07:37:20 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     tytso@mit.edu, jack@suse.cz, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org,
        riteshh@linux.ibm.com
Subject: [RFC 3/5] ext4: Refactor mpage_map_and_submit_buffers function
Date:   Wed, 16 Oct 2019 13:07:09 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016073711.4141-1-riteshh@linux.ibm.com>
References: <20191016073711.4141-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101607-0016-0000-0000-000002B87A70
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101607-0017-0000-0000-000033199BBC
Message-Id: <20191016073711.4141-4-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=751 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160071
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch refactors mpage_map_and_submit_buffers to take
out the page buffers processing, as a separate function.
This will be required to add support for blocksize < pagesize
for dioread_nolock feature.

No functionality change in this patch.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 125 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 83 insertions(+), 42 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 123e3dee7733..3204a7d35581 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2340,6 +2340,75 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
 	return lblk < blocks;
 }
 
+/*
+ * mpage_process_page - update page buffers corresponding to changed extent and
+ *		       may submit fully mapped page for IO
+ *
+ * @mpd		- description of extent to map, on return next extent to map
+ * @m_lblk	- logical block mapping.
+ * @m_pblk	- corresponding physical mapping.
+ * @map_bh	- determines on return whether this page requires any further
+ *		  mapping or not.
+ * Scan given page buffers corresponding to changed extent and update buffer
+ * state according to new extent state.
+ * We map delalloc buffers to their physical location, clear unwritten bits.
+ * If the given page is not fully mapped, we update @map to the next extent in
+ * the given page that needs mapping & return @map_bh as true.
+ */
+static int mpage_process_page(struct mpage_da_data *mpd, struct page *page,
+			      ext4_lblk_t *m_lblk, ext4_fsblk_t *m_pblk,
+			      bool *map_bh)
+{
+	struct buffer_head *head, *bh;
+	ext4_io_end_t *io_end = mpd->io_submit.io_end;
+	ext4_lblk_t lblk = *m_lblk;
+	ext4_fsblk_t pblock = *m_pblk;
+	int err = 0;
+
+	bh = head = page_buffers(page);
+	do {
+		if (lblk < mpd->map.m_lblk)
+			continue;
+		if (lblk >= mpd->map.m_lblk + mpd->map.m_len) {
+			/*
+			 * Buffer after end of mapped extent.
+			 * Find next buffer in the page to map.
+			 */
+			mpd->map.m_len = 0;
+			mpd->map.m_flags = 0;
+
+			/*
+			 * FIXME: If dioread_nolock supports
+			 * blocksize < pagesize, we need to make
+			 * sure we add size mapped so far to
+			 * io_end->size as the following call
+			 * can submit the page for IO.
+			 */
+			err = mpage_process_page_bufs(mpd, head, bh, lblk);
+			if (err > 0)
+				err = 0;
+			*map_bh = true;
+			goto out;
+		}
+		if (buffer_delay(bh)) {
+			clear_buffer_delay(bh);
+			bh->b_blocknr = pblock++;
+		}
+		clear_buffer_unwritten(bh);
+	} while (lblk++, (bh = bh->b_this_page) != head);
+	/*
+	 * FIXME: This is going to break if dioread_nolock
+	 * supports blocksize < pagesize as we will try to
+	 * convert potentially unmapped parts of inode.
+	 */
+	io_end->size += PAGE_SIZE;
+	*map_bh = false;
+out:
+	*m_lblk = lblk;
+	*m_pblk = pblock;
+	return err;
+}
+
 /*
  * mpage_map_buffers - update buffers corresponding to changed extent and
  *		       submit fully mapped pages for IO
@@ -2359,12 +2428,12 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 	struct pagevec pvec;
 	int nr_pages, i;
 	struct inode *inode = mpd->inode;
-	struct buffer_head *head, *bh;
 	int bpp_bits = PAGE_SHIFT - inode->i_blkbits;
 	pgoff_t start, end;
 	ext4_lblk_t lblk;
-	sector_t pblock;
+	ext4_fsblk_t pblock;
 	int err;
+	bool map_bh = false;
 
 	start = mpd->map.m_lblk >> bpp_bits;
 	end = (mpd->map.m_lblk + mpd->map.m_len - 1) >> bpp_bits;
@@ -2380,50 +2449,19 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 
-			bh = head = page_buffers(page);
-			do {
-				if (lblk < mpd->map.m_lblk)
-					continue;
-				if (lblk >= mpd->map.m_lblk + mpd->map.m_len) {
-					/*
-					 * Buffer after end of mapped extent.
-					 * Find next buffer in the page to map.
-					 */
-					mpd->map.m_len = 0;
-					mpd->map.m_flags = 0;
-					/*
-					 * FIXME: If dioread_nolock supports
-					 * blocksize < pagesize, we need to make
-					 * sure we add size mapped so far to
-					 * io_end->size as the following call
-					 * can submit the page for IO.
-					 */
-					err = mpage_process_page_bufs(mpd, head,
-								      bh, lblk);
-					pagevec_release(&pvec);
-					if (err > 0)
-						err = 0;
-					return err;
-				}
-				if (buffer_delay(bh)) {
-					clear_buffer_delay(bh);
-					bh->b_blocknr = pblock++;
-				}
-				clear_buffer_unwritten(bh);
-			} while (lblk++, (bh = bh->b_this_page) != head);
-
+			err = mpage_process_page(mpd, page, &lblk, &pblock,
+						 &map_bh);
 			/*
-			 * FIXME: This is going to break if dioread_nolock
-			 * supports blocksize < pagesize as we will try to
-			 * convert potentially unmapped parts of inode.
+			 * If map_bh is true, means page may require further bh
+			 * mapping, or maybe the page was submitted for IO.
+			 * So we return to call further extent mapping.
 			 */
-			mpd->io_submit.io_end->size += PAGE_SIZE;
+			if (err < 0 || map_bh == true)
+				goto out;
 			/* Page fully mapped - let IO run! */
 			err = mpage_submit_page(mpd, page);
-			if (err < 0) {
-				pagevec_release(&pvec);
-				return err;
-			}
+			if (err < 0)
+				goto out;
 		}
 		pagevec_release(&pvec);
 	}
@@ -2431,6 +2469,9 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 	mpd->map.m_len = 0;
 	mpd->map.m_flags = 0;
 	return 0;
+out:
+	pagevec_release(&pvec);
+	return err;
 }
 
 static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
-- 
2.21.0

