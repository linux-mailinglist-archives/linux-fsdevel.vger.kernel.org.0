Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14FF51748B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 19:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgB2Sip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 13:38:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55408 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbgB2Sip (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 13:38:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01TIMqIE139707;
        Sat, 29 Feb 2020 18:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=SstNiZG/IgJgtisAPxalJp4ap7r31mc4oYTLi31dNcM=;
 b=tEJUfkQv7rLqJyveon6cm9WgH0VhBm7Y6bN0h5dIb5OAt4lg104/1zy2UWM8QiIVjC1t
 z/ZfNkIP4qdkEJBVfycA+aZUKUcMmOTWMVllmzMEreix1tTloM+i9w4O5PQc8fHirkf1
 PT1ibbocUOf4E9blHv8D9+1Ma6ai1ulYP2BUVOR7ICs/j1w/0oVjxnlaCPUC/hgJ/jyK
 CrFjr0j6Nd5lAzFZWlIP8KcGKWqDK9uVEX9mlbKTHS6e5eh25bIon1ZdjA3QwjJB3Ywb
 puiFAFJ3V3kYzjqImuOPZZM/lV7cFBl6teT2o3AVFn3vPT5qKGecTq7DVIcTlX7bVGTc Lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yfgkr9j28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Feb 2020 18:38:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01TIcPXe066667;
        Sat, 29 Feb 2020 18:38:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2yfd2wyjvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Feb 2020 18:38:25 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01TIcLWK003027;
        Sat, 29 Feb 2020 18:38:21 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 29 Feb 2020 10:38:21 -0800
Date:   Sat, 29 Feb 2020 10:38:20 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, mkleinsoft@gmail.com, hch@lst.de,
        akpm@linux-foundation.org, rjw@rjwysocki.net, len.brown@intel.com,
        pavel@ucw.cz
Subject: Re: [PATCH] hibernate: unlock swap bdev for writing when uswsusp is
 active
Message-ID: <20200229183820.GA8037@magnolia>
References: <20200229170825.GX8045@magnolia>
 <20200229180716.GA31323@dumbo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229180716.GA31323@dumbo>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9546 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=2
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002290143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9546 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 malwarescore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002290142
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 29, 2020 at 07:07:16PM +0100, Domenico Andreoli wrote:
> On Sat, Feb 29, 2020 at 09:08:25AM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > It turns out that there /is/ one use case for programs being able to
> > write to swap devices, and that is the userspace hibernation code.  The
> > uswsusp ioctls allow userspace to lease parts of swap devices, so turn
> > S_SWAPFILE off when invoking suspend.
> > 
> > Fixes: 1638045c3677 ("mm: set S_SWAPFILE on blockdev swap devices")
> > Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
> > Reported-by: Marian Klein <mkleinsoft@gmail.com>
> 
> I also tested it yesterday but was not satisfied, unfortunately I did
> not come with my comment in time.
> 
> Yes, I confirm that the uswsusp works again but also checked that
> swap_relockall() is not triggered at all and therefore after the first
> hibernation cycle the S_SWAPFILE bit remains cleared and the whole
> swap_relockall() is useless.
> 
> I'm not sure this patch should be merged in the current form.

NNGGHHGGHGH /me is rapidly losing his sanity and will soon just revert
the whole security feature because I'm getting fed up with people
yelling at me *while I'm on vacation* trying to *restore* my sanity.  I
really don't want to be QAing userspace-directed hibernation right now.

...right, the patch is broken because we have to relock the swapfiles in
whatever code executes after we jump back to the restored kernel, not in
the one that's doing the restoring.  Does this help?

OTOH, maybe we should just leave the swapfiles unlocked after resume.
Userspace has clearly demonstrated the one usecase for writing to the
swapfile, which means anyone could have jumped in while uswsusp was
running and written whatever crap they wanted to the parts of the swap
file that weren't leased for the hibernate image.

--D

From: Darrick J. Wong <darrick.wong@oracle.com>
Subject: [PATCH] hibernate: unlock swap bdev for writing when uswsusp is active

It turns out that there /is/ one use case for programs being able to
write to swap devices, and that is the userspace hibernation code.  The
uswsusp ioctls allow userspace to lease parts of swap devices, so turn
S_SWAPFILE off when invoking suspend.

Fixes: 1638045c3677 ("mm: set S_SWAPFILE on blockdev swap devices")
Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
Reported-by: Marian Klein <mkleinsoft@gmail.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 include/linux/swap.h     |    1 +
 kernel/power/hibernate.c |    4 ++++
 kernel/power/user.c      |    9 ++++++++-
 mm/swapfile.c            |   26 ++++++++++++++++++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)

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
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 6dbeedb7354c..aa5a6701614d 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -31,6 +31,7 @@
 #include <linux/genhd.h>
 #include <linux/ktime.h>
 #include <linux/security.h>
+#include <linux/swap.h>
 #include <trace/events/power.h>
 
 #include "power.h"
@@ -399,6 +400,9 @@ int hibernation_snapshot(int platform_mode)
 	 * image creation has failed and (2) after a successful restore.
 	 */
 
+	/* Lock the swap files, just in case uswsusp was active. */
+	swap_relockall();
+
 	/* We may need to release the preallocated image pages here. */
 	if (error || !in_suspend)
 		swsusp_free();
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 77438954cc2b..a3ae9cbbfcf0 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -372,10 +372,17 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
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
