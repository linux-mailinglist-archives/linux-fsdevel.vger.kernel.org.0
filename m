Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CA637AE30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 20:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhEKSRb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 14:17:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60422 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhEKSRb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 14:17:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14BIEMO7057702;
        Tue, 11 May 2021 18:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=hgctH0oSitkyxZDTbkS3bn45JVyf//Hvn92WkrPimiU=;
 b=UUgI++rPmxv6cZ480QfwrUN5SzWvs2Fq8Oa8O+oXeHtDQ1WWqYeecrj6Lz6G4XJJCvDu
 +f/0uLGufR4Jjh/iEqZwggeqvVI0aeF7oAOZvRTSdvtbaCoP/WPB9laQLFPArEypikG+
 uekjNXrXRklZyfmDnvasg7tD0YNx/o7JamdW7Fgn76UIfcQ9f2LBre29sV7v7uqkIKPt
 2E+dtrzumH817c0PZSEyhO6M+yYoGwn3VSZ9E3Y3ySZG0m5MewCSKciGj77uei0wLYC+
 sVoCfKiGT8sPcII8+yO6adWLrSI0feqHNV095/edWDbBfWT5y4iwQdaA2Uvm5+MNXJUr Bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 38djkmfnk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 18:16:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14BIG17J067879;
        Tue, 11 May 2021 18:16:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38fh3x4ejw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 18:16:19 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14BIGI1W069108;
        Tue, 11 May 2021 18:16:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 38fh3x4eje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 18:16:18 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14BIGE9X020661;
        Tue, 11 May 2021 18:16:14 GMT
Received: from gms-ol8-2.osdevelopmeniad.oraclevcn.com (/100.100.234.63)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 May 2021 11:16:14 -0700
From:   Gulam Mohamed <gulam.mohamed@oracle.com>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de,
        martin.petersen@oracle.com
Cc:     junxiao.bi@oracle.com, gulam.mohamed@oracle.com
Subject: [PATCH V1 1/1] Fix race between iscsi logout and systemd-udevd
Date:   Tue, 11 May 2021 18:15:58 +0000
Message-Id: <20210511181558.380764-1-gulam.mohamed@oracle.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 70ILg2-xPJRuhusHpsPZNpijzkulSzTZ
X-Proofpoint-ORIG-GUID: 70ILg2-xPJRuhusHpsPZNpijzkulSzTZ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9981 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1011 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110123
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Problem description:

During the kernel patching, customer was switching between the iscsi
disks. To switch between the iscsi disks, it was logging out the
currently connected iscsi disk and then logging in to the new iscsi
disk. This was being done using a script. Customer was also using the
"parted" command in the script to list the partition details just
before the iscsi logout. This usage of "parted" command was creating
an issue and we were seeing stale links of the
disks in /sys/class/block.

Analysis:

As part of iscsi logout, the partitions and the disk will be removed
in the function del_gendisk() which is done through a kworker. The
parted command, used to list the partitions, will open the disk in
RW mode which results in systemd-udevd re-reading the partitions. The
ioctl used to re-read partitions is BLKRRPART. This will trigger the
rescanning of partitions which will also delete and re-add the
partitions. So, both iscsi logout processing (through kworker) and the
"parted" command (through systemd-udevd) will be involved in
add/delete of partitions. In our case, the following sequence of
operations happened (the iscsi device is /dev/sdb with partition sdb1):

1. sdb1 was removed by PARTED
2. kworker, as part of iscsi logout, couldn't remove sdb1 as it was
   already removed by PARTED
3. sdb1 was added by parted
4. sdb was NOW removed as part of iscsi logout (the last part of the
   device removal after remoing the partitions)

Since the symlink /sys/class/block/sdb1 points to
/sys/class/devices/platform/hostx/sessionx/targetx:x/block/sdb/sdb1
and since sdb is already removed, the symlink /sys/class/block/sdb1
will be orphan and stale. So, this stale link is a result of the race
condition in kernel between the systemd-udevd and iscsi-logout
processing as described above. We were able to reproduce this even
with latest upstream kernel.

Fix:

While Dropping/Adding partitions as part of BLKRRPART ioctl, take the
read lock for "bdev_lookup_sem" to sync with del_gendisk().

Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
---
 fs/block_dev.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 09d6f7229db9..e903a7edfd63 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1245,9 +1245,17 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 	lockdep_assert_held(&bdev->bd_mutex);
 
 rescan:
+	down_read(&bdev_lookup_sem);
+	if (!(disk->flags & GENHD_FL_UP)) {
+		up_read(&bdev_lookup_sem);
+		return -ENXIO;
+	}
+
 	ret = blk_drop_partitions(bdev);
-	if (ret)
+	if (ret) {
+		up_read(&bdev_lookup_sem);
 		return ret;
+	}
 
 	clear_bit(GD_NEED_PART_SCAN, &disk->state);
 
@@ -1270,8 +1278,10 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 
 	if (get_capacity(disk)) {
 		ret = blk_add_partitions(disk, bdev);
-		if (ret == -EAGAIN)
+		if (ret == -EAGAIN) {
+			up_read(&bdev_lookup_sem);
 			goto rescan;
+		}
 	} else if (invalidate) {
 		/*
 		 * Tell userspace that the media / partition table may have
@@ -1280,6 +1290,7 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
 	}
 
+	up_read(&bdev_lookup_sem);
 	return ret;
 }
 /*
-- 
2.27.0

