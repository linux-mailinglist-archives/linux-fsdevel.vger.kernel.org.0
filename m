Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5528032CCC5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 07:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbhCDGWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 01:22:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234859AbhCDGWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 01:22:30 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12464ApJ002003;
        Thu, 4 Mar 2021 01:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=C/UEZBuZ9fJJJjUOHrXxdlo2KGgCtmOmAhhi4GZjqCc=;
 b=ETbxTAUwAH7uDT5rvPYB+0e4r5hFEWCOan8oowg79DqeDGOM+D3upCsLOHzN0LkBkEHS
 F8gjQBi4qL5Tr34pQ8T72LwqktYDvo0MB1qQ91RVkywPP59cKp964OT79UBFlafuB8dx
 lbtHlF18OABqXZoqKEMT/UB8Oyrt7xsYWOONkwQWuXbaiBzusWnN2y3TdCu7gVz2JrNi
 eT1uW4I+O3nNfp2+p3X4+vfMM/d+4Ro3eFDRG2OA7obakNhqs99bJMQtUa1+DgYkZEnf
 zW4oZKrBQJ1YwEvfmNwXuCu8H42JsPCOsXelFwtxKyko12GCDX4RFOCOhFZ3bfulMg9U MA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 372squs1r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 01:21:49 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1246IrUs021627;
        Thu, 4 Mar 2021 06:21:47 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 371a8es4u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 06:21:47 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1246LjS036766176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Mar 2021 06:21:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13ADBA4057;
        Thu,  4 Mar 2021 06:21:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D8D2A4051;
        Thu,  4 Mar 2021 06:21:44 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.35.80])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Mar 2021 06:21:43 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, anju@linux.vnet.ibm.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH] iomap: Fix negative assignment to unsigned sis->pages in iomap_swapfile_activate
Date:   Thu,  4 Mar 2021 11:51:26 +0530
Message-Id: <b39319ab99d9c5541b2cdc172a4b25f39cbaad50.1614838615.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_01:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040025
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In case if isi.nr_pages is 0, we are making sis->pages (which is
unsigned int) a huge value in iomap_swapfile_activate() by assigning -1.
This could cause a kernel crash in kernel v4.18 (with below signature).
Or could lead to unknown issues on latest kernel if the fake big swap gets
used.

Fix this issue by returning -EINVAL in case of nr_pages is 0, since it
is anyway a invalid swapfile. Looks like this issue will be hit when
we have pagesize < blocksize type of configuration.

I was able to hit the issue in case of a tiny swap file with below
test script.
https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/scripts/swap-issue.sh

kernel crash analysis on v4.18
==============================
On v4.18 kernel, it causes a kernel panic, since sis->pages becomes
a huge value and isi.nr_extents is 0. When 0 is returned it is
considered as a swapfile over NFS and SWP_FILE is set (sis->flags |= SWP_FILE).
Then when swapoff was getting called it was calling a_ops->swap_deactivate()
if (sis->flags & SWP_FILE) is true. Since a_ops->swap_deactivate() is
NULL in case of XFS, it causes below panic.

Panic signature on v4.18 kernel:
=======================================
root@qemu:/home/qemu# [ 8291.723351] XFS (loop2): Unmounting Filesystem
[ 8292.123104] XFS (loop2): Mounting V5 Filesystem
[ 8292.132451] XFS (loop2): Ending clean mount
[ 8292.263362] Adding 4294967232k swap on /mnt1/test/swapfile.  Priority:-2 extents:1 across:274877906880k
[ 8292.277834] Unable to handle kernel paging request for instruction fetch
[ 8292.278677] Faulting instruction address: 0x00000000
cpu 0x19: Vector: 400 (Instruction Access) at [c0000009dd5b7ad0]
    pc: 0000000000000000
    lr: c0000000003eb9dc: destroy_swap_extents+0xfc/0x120
    sp: c0000009dd5b7d50
   msr: 8000000040009033
  current = 0xc0000009b6710080
  paca    = 0xc00000003ffcb280   irqmask: 0x03   irq_happened: 0x01
    pid   = 5604, comm = swapoff
Linux version 4.18.0 (riteshh@xxxxxxx) (gcc version 8.4.0 (Ubuntu 8.4.0-1ubuntu1~18.04)) #57 SMP Wed Mar 3 01:33:04 CST 2021
enter ? for help
[link register   ] c0000000003eb9dc destroy_swap_extents+0xfc/0x120
[c0000009dd5b7d50] c0000000025a7058 proc_poll_event+0x0/0x4 (unreliable)
[c0000009dd5b7da0] c0000000003f0498 sys_swapoff+0x3f8/0x910
[c0000009dd5b7e30] c00000000000bbe4 system_call+0x5c/0x70
--- Exception: c01 (System Call) at 00007ffff7d208d8

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/iomap/swapfile.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index a648dbf6991e..67953678c99f 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -170,6 +170,15 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 			return ret;
 	}

+	/*
+	 * In case if nr_pages is 0 then we better return -EINVAL
+	 * since it is anyway an empty swapfile.
+	 */
+	if (isi.nr_pages == 0) {
+		pr_warn("swapon: Empty swap-file\n");
+		return -EINVAL;
+	}
+
 	*pagespan = 1 + isi.highest_ppage - isi.lowest_ppage;
 	sis->max = isi.nr_pages;
 	sis->pages = isi.nr_pages - 1;
--
2.26.2

