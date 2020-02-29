Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9C617484F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 18:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgB2RJB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 12:09:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50490 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbgB2RJA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 12:09:00 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01TH3XjC135390;
        Sat, 29 Feb 2020 17:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Aziub7tqyinjoq6gQPjP+xzoq0HBrul3VA7U0lGzdxA=;
 b=b2gE7a1ju958Q/zu/uaHVrnhznRlU2qCYwMa8fm+5EmYsrrQC+K5lnE8rO2FwirYHMRC
 S118iU/lAulJxEdWQ+NsUYw6xWF5MtfrXJPA0r7y4+mnDLSAfsg/zTnD64dQcu+HVZxc
 MDHF93YpH8paDPcGtd6o6jrPdag5sSU23pNZy3EN+1Lqu5XXSqtDoEeRpg4LpoKaDbJZ
 /Lwe8RgrIMEEOV+BKHVDfccsCUDbAJSzm1h2jwag+hat+emHP9oENhMulbfdVXBZxQZt
 H2lceYI2f0773+8DnV7Ciqdhdjl1Ari2dz6Hns/8UJIj6CjXMxspJxNjJduxDQzhLAvI vg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2yffcu1hmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Feb 2020 17:08:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01TH2RkW101511;
        Sat, 29 Feb 2020 17:08:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2yffs6y8gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Feb 2020 17:08:42 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01TH8R4u030776;
        Sat, 29 Feb 2020 17:08:27 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 29 Feb 2020 09:08:27 -0800
Date:   Sat, 29 Feb 2020 09:08:25 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     domenico.andreoli@linux.com, mkleinsoft@gmail.com, hch@lst.de,
        akpm@linux-foundation.org, rjw@rjwysocki.net, len.brown@intel.com,
        pavel@ucw.cz
Subject: [PATCH] hibernate: unlock swap bdev for writing when uswsusp is
 active
Message-ID: <20200229170825.GX8045@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9546 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=2 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002290131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9546 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=2 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002290131
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

It turns out that there /is/ one use case for programs being able to
write to swap devices, and that is the userspace hibernation code.  The
uswsusp ioctls allow userspace to lease parts of swap devices, so turn
S_SWAPFILE off when invoking suspend.

Fixes: 1638045c3677 ("mm: set S_SWAPFILE on blockdev swap devices")
Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
Reported-by: Marian Klein <mkleinsoft@gmail.com>
Tested-by: Marian Klein <mkleinsoft@gmail.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 include/linux/swap.h |    1 +
 kernel/power/user.c  |   11 ++++++++++-
 mm/swapfile.c        |   26 ++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1e99f7ac1d7e..add93e205850 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -458,6 +458,7 @@ extern void swap_free(swp_entry_t);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
 extern int free_swap_and_cache(swp_entry_t);
 extern int swap_type_of(dev_t, sector_t, struct block_device **);
+extern void swap_relockall(void);
 extern unsigned int count_swap_pages(int, int);
 extern sector_t map_swap_page(struct page *, struct block_device **);
 extern sector_t swapdev_block(int, pgoff_t);
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 77438954cc2b..b11f7037ce5e 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -271,6 +271,8 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			break;
 		}
 		error = hibernation_restore(data->platform_support);
+		if (!error)
+			swap_relockall();
 		break;
 
 	case SNAPSHOT_FREE:
@@ -372,10 +374,17 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			 */
 			swdev = new_decode_dev(swap_area.dev);
 			if (swdev) {
+				struct block_device *bd;
+
 				offset = swap_area.offset;
-				data->swap = swap_type_of(swdev, offset, NULL);
+				data->swap = swap_type_of(swdev, offset, &bd);
 				if (data->swap < 0)
 					error = -ENODEV;
+
+				inode_lock(bd->bd_inode);
+				bd->bd_inode->i_flags &= ~S_SWAPFILE;
+				inode_unlock(bd->bd_inode);
+				bdput(bd);
 			} else {
 				data->swap = -1;
 				error = -EINVAL;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index b2a2e45c9a36..439bfb7263d3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1799,6 +1799,32 @@ int swap_type_of(dev_t device, sector_t offset, struct block_device **bdev_p)
 	return -ENODEV;
 }
 
+/* Re-lock swap devices after resuming from userspace suspend. */
+void swap_relockall(void)
+{
+	int type;
+
+	spin_lock(&swap_lock);
+	for (type = 0; type < nr_swapfiles; type++) {
+		struct swap_info_struct *sis = swap_info[type];
+		struct block_device *bdev = bdgrab(sis->bdev);
+
+		/*
+		 * uswsusp only knows how to suspend to block devices, so we
+		 * can skip swap files.
+		 */
+		if (!(sis->flags & SWP_WRITEOK) ||
+		    !(sis->flags & SWP_BLKDEV))
+			continue;
+
+		inode_lock(bdev->bd_inode);
+		bdev->bd_inode->i_flags |= S_SWAPFILE;
+		inode_unlock(bdev->bd_inode);
+		bdput(bdev);
+	}
+	spin_unlock(&swap_lock);
+}
+
 /*
  * Get the (PAGE_SIZE) block corresponding to given offset on the swapdev
  * corresponding to given index in swap_info (swap type).
