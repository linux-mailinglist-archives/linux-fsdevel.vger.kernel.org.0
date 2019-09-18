Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC69AB6732
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 17:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbfIRPfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 11:35:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729873AbfIRPfS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:35:18 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8IFWEuf092920
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 11:35:17 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v3pcrthga-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 11:35:16 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <maier@linux.ibm.com>;
        Wed, 18 Sep 2019 16:35:14 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Sep 2019 16:35:08 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8IFZ7e259703518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 15:35:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAD8E5205A;
        Wed, 18 Sep 2019 15:35:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 458B352063;
        Wed, 18 Sep 2019 15:35:06 +0000 (GMT)
From:   Steffen Maier <maier@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>
Cc:     linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org,
        Benjamin Block <bblock@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Steffen Maier <maier@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        linux-next@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        dm-devel@redhat.com
Subject: [PATCH] compat_ioctl: fix reimplemented SG_IO handling causing -EINVAL from sg_io()
Date:   Wed, 18 Sep 2019 17:34:45 +0200
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19091815-0020-0000-0000-0000036E9CA7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091815-0021-0000-0000-000021C4468C
Message-Id: <20190918153445.1241-1-maier@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-18_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909180152
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

scsi_cmd_ioctl() had hdr as on stack auto variable and called
copy_{from,to}_user with the address operator &hdr and sizeof(hdr).

After the refactoring, {get,put}_sg_io_hdr() takes a pointer &hdr.
So the copy_{from,to}_user within the new helper functions should
just take the given pointer argument hdr and sizeof(*hdr).

I saw -EINVAL from sg_io() done by /usr/lib/udev/scsi_id which could
in turn no longer whitelist SCSI disks for devicemapper multipath.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Fixes: 4f45155c29fd ("compat_ioctl: reimplement SG_IO handling")
---

Arnd, I'm not sure about the sizeof(hdr32) change in the compat part in
put_sg_io_hdr().

This is for next, probably via Arnd's y2038/y2038,
and it fixes next-20190917 for me regarding SCSI generic.

 block/scsi_ioctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index cbeb629ee917..650bade5ea5a 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -607,14 +607,14 @@ int put_sg_io_hdr(const struct sg_io_hdr *hdr, void __user *argp)
 			.info		 = hdr->info,
 		};
 
-		if (copy_to_user(argp, &hdr32, sizeof(hdr)))
+		if (copy_to_user(argp, &hdr32, sizeof(hdr32)))
 			return -EFAULT;
 
 		return 0;
 	}
 #endif
 
-	if (copy_to_user(argp, &hdr, sizeof(hdr)))
+	if (copy_to_user(argp, hdr, sizeof(*hdr)))
 		return -EFAULT;
 
 	return 0;
@@ -659,7 +659,7 @@ int get_sg_io_hdr(struct sg_io_hdr *hdr, const void __user *argp)
 	}
 #endif
 
-	if (copy_from_user(&hdr, argp, sizeof(hdr)))
+	if (copy_from_user(hdr, argp, sizeof(*hdr)))
 		return -EFAULT;
 
 	return 0;
-- 
2.17.1

