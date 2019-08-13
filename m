Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152818BCCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 17:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfHMPOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 11:14:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47830 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbfHMPOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:14:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7DFDZPP144029;
        Tue, 13 Aug 2019 15:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=B0IXVIWTgC5KuQ0UOjnkr6JuhHw37n++FSZaBbPoZb4=;
 b=pqfr3LXucy/L0BweZKuiiR5WHsMajKu75fGZdufMkJTskK1oQCAtT0towXam4nQ9ozH2
 Ji6LbXSo+7krbTVyo9qZxSg//Q/0iEkd4AGoelJl/vjIIeOS/c8R0YWBUBATK+CfbjDr
 DltXzamkw3tZxqxJ37pfZLrgCi2VDmfSvoWu4VtBWKHf3UXn87de9VGGUMp/1UiVVIIX
 wOaHZhqZkPgzu0cc/kbFZdw61jH1L8spyVxbuHWXbDMVDedd+3AcnkjQi/+qo1/3FDVX
 vZHO6s0rVSCpOBI4dQzGdHQPMFxFEpG0C5h4qUXOuxBhT2FEzLinBmwE1VktxdRBagcd tQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2u9nvp72f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 15:14:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7DFDSwd029361;
        Tue, 13 Aug 2019 15:14:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ubwqrw47g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 15:14:37 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7DFEZjb029456;
        Tue, 13 Aug 2019 15:14:35 GMT
Received: from localhost (/10.159.254.26)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Aug 2019 08:14:35 -0700
Date:   Tue, 13 Aug 2019 08:14:34 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v3] vfs: fix page locking deadlocks when deduping files
Message-ID: <20190813151434.GQ7138@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130158
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

When dedupe wants to use the page cache to compare parts of two files
for dedupe, we must be very careful to handle locking correctly.  The
current code doesn't do this.  It must lock and unlock the page only
once if the two pages are the same, since the overlapping range check
doesn't catch this when blocksize < pagesize.  If the pages are distinct
but from the same file, we must observe page locking order and lock them
in order of increasing offset to avoid clashing with writeback locking.

Fixes: 876bec6f9bbfcb3 ("vfs: refactor clone/dedupe_file_range common functions")
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Bill O'Donnell <billodo@redhat.com>
---
v3: revalidate page after locking it
v2: provide an unlock helper
---
 fs/read_write.c |   50 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 1f5088dec566..da341eb3033c 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1811,10 +1811,7 @@ static int generic_remap_check_len(struct inode *inode_in,
 	return (remap_flags & REMAP_FILE_DEDUP) ? -EBADE : -EINVAL;
 }
 
-/*
- * Read a page's worth of file data into the page cache.  Return the page
- * locked.
- */
+/* Read a page's worth of file data into the page cache. */
 static struct page *vfs_dedupe_get_page(struct inode *inode, loff_t offset)
 {
 	struct page *page;
@@ -1826,10 +1823,32 @@ static struct page *vfs_dedupe_get_page(struct inode *inode, loff_t offset)
 		put_page(page);
 		return ERR_PTR(-EIO);
 	}
-	lock_page(page);
 	return page;
 }
 
+/*
+ * Lock two pages, ensuring that we lock in offset order if the pages are from
+ * the same file.
+ */
+static void vfs_lock_two_pages(struct page *page1, struct page *page2)
+{
+	/* Always lock in order of increasing index. */
+	if (page1->index > page2->index)
+		swap(page1, page2);
+
+	lock_page(page1);
+	if (page1 != page2)
+		lock_page(page2);
+}
+
+/* Unlock two pages, being careful not to unlock the same page twice. */
+static void vfs_unlock_two_pages(struct page *page1, struct page *page2)
+{
+	unlock_page(page1);
+	if (page1 != page2)
+		unlock_page(page2);
+}
+
 /*
  * Compare extents of two files to see if they are the same.
  * Caller must have locked both inodes to prevent write races.
@@ -1867,10 +1886,25 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 		dest_page = vfs_dedupe_get_page(dest, destoff);
 		if (IS_ERR(dest_page)) {
 			error = PTR_ERR(dest_page);
-			unlock_page(src_page);
 			put_page(src_page);
 			goto out_error;
 		}
+
+		vfs_lock_two_pages(src_page, dest_page);
+
+		/*
+		 * Now that we've locked both pages, make sure they still
+		 * represent the data we're interested in.  If not, someone
+		 * is invalidating pages on us and we lose.
+		 */
+		if (src_page->mapping != src->i_mapping ||
+		    src_page->index != srcoff >> PAGE_SHIFT ||
+		    dest_page->mapping != dest->i_mapping ||
+		    dest_page->index != destoff >> PAGE_SHIFT) {
+			same = false;
+			goto unlock;
+		}
+
 		src_addr = kmap_atomic(src_page);
 		dest_addr = kmap_atomic(dest_page);
 
@@ -1882,8 +1916,8 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 
 		kunmap_atomic(dest_addr);
 		kunmap_atomic(src_addr);
-		unlock_page(dest_page);
-		unlock_page(src_page);
+unlock:
+		vfs_unlock_two_pages(src_page, dest_page);
 		put_page(dest_page);
 		put_page(src_page);
 
