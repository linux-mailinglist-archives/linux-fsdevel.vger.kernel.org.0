Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06996336C8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 07:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhCKGyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 01:54:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231422AbhCKGyk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 01:54:40 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12B6XJj4122582;
        Thu, 11 Mar 2021 01:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=mTIMi43/GTtLzUHp2kZekoxQOWkeIPI9HxCCfOarsbQ=;
 b=DMoqoKYXB8ILIhrzHhGwwuIuzS4mEDCtovpWAU5bsXj1vJnZHBYPkXYobNb0BKdiEZqY
 iecQcbg2o8SxBsLElNFV5RHccBckkEVtXYN1eOOblk6GnK0qOyirkCrMb4frBs1wAVv5
 9vJy4zW62NaW7/1/CEtE113ibAoM/tH2Naddws5mnjw0PESNBK7mRXHtcOi5r/3n0iWx
 ZVClR+fyaGwv9RLSeo8+Ed3RDifa+BURMnY96qKHVH2HdueVuC9OcbzkaQL2jXatAwuT
 UCx0tZGoRhZlW4PfSuUvL1exHM0avDwaSC9ZAjYtpIzuMoVibX1uU+ZDCRcS4eZw9d5K 7Q== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3774mpwauh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 01:54:37 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12B6gGsr015262;
        Thu, 11 Mar 2021 06:54:36 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 376aqsrtm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 06:54:36 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12B6sIbV33227170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 06:54:18 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE5FA4C040;
        Thu, 11 Mar 2021 06:54:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99EB94C050;
        Thu, 11 Mar 2021 06:54:32 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.38.114])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Mar 2021 06:54:32 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, anju@linux.vnet.ibm.com,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2] iomap: Fix negative assignment to unsigned sis->pages in iomap_swapfile_activate
Date:   Thu, 11 Mar 2021 12:24:26 +0530
Message-Id: <93fa3d674cda41261e529e1e9b75c2efb2e325be.1615445004.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-11_01:2021-03-10,2021-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103110037
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In case if isi.nr_pages is 0, we are making sis->pages (which is
unsigned int) a huge value in iomap_swapfile_activate() by assigning -1.
This could cause a kernel crash in kernel v4.18 (with below signature).
This also crashes the upstream kernel with below signature, if the big fake
swap gets used.

Fix this issue by returning -EINVAL in case of nr_pages is 0, since it
is anyway a invalid swapfile. Looks like this issue will be hit when
we have blocksize < pagesize type of configuration.

I was able to hit the issue in case of a tiny swap file with below
test script.
https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/scripts/swap-issue.sh

<kernel crash on upstream kernel>
===============================
[  120.682527] XFS (loop2): Mounting V5 Filesystem
[  120.688448] XFS (loop2): Ending clean mount
[  120.690555] xfs filesystem being mounted at /mnt1/test supports timestamps until 2038 (0x7fffffff)
[  120.885793] Adding 4294967232k swap on /mnt1/test/swapfile.  Priority:-2 extents:1 across:274877906880k
<...>
[  186.068492] __swap_info_get: Bad swap offset entry 00000001
[  186.071704] __swap_info_get: Bad swap offset entry 00000043
<...>
[  453.756321] Faulting instruction address: 0xc0000000005b6c50
cpu 0x6: Vector: 300 (Data Access) at [c00000002a8b6f80]
    pc: c0000000005b6c50: __mark_inode_dirty+0x40/0x870
    lr: c0000000006435b0: iomap_set_page_dirty+0x170/0x1b0
    pid   = 4635, comm = stress
Linux version 5.12.0-rc1-00021-g23cdd4c7150 (gcc (Ubuntu 8.4.0-1ubuntu1~18.04)
iomap_set_page_dirty+0x170/0x1b0
swap_set_page_dirty+0xec/0x140
set_page_dirty+0x1b4/0x2d0
add_to_swap+0x178/0x1d0
shrink_page_list+0xe78/0x2120
shrink_inactive_list+0x2b0/0x640
shrink_lruvec+0x710/0x7b0
shrink_node+0x584/0x8e0
do_try_to_free_pages+0x2f8/0x5d0
<...>

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
[ 8291.723351] XFS (loop2): Unmounting Filesystem
[ 8292.123104] XFS (loop2): Mounting V5 Filesystem
[ 8292.132451] XFS (loop2): Ending clean mount
[ 8292.263362] Adding 4294967232k swap on /mnt1/test/swapfile.  Priority:-2 extents:1 across:274877906880k
[ 8292.277834] Unable to handle kernel paging request for instruction fetch
[ 8292.278677] Faulting instruction address: 0x00000000
cpu 0x19: Vector: 400 (Instruction Access) at [c0000009dd5b7ad0]
    pc: 0000000000000000
    lr: c0000000003eb9dc: destroy_swap_extents+0xfc/0x120
    pid   = 5604, comm = swapoff
Linux version 4.18.0 (riteshh@xxxxxxx) (gcc version 8.4.0 (Ubuntu 8.4.0-1ubuntu1~18.04)) #57 SMP Wed Mar 3 01:33:04 CST 2021
[link register   ] c0000000003eb9dc destroy_swap_extents+0xfc/0x120
[c0000009dd5b7d50] c0000000025a7058 proc_poll_event+0x0/0x4 (unreliable)
[c0000009dd5b7da0] c0000000003f0498 sys_swapoff+0x3f8/0x910
[c0000009dd5b7e30] c00000000000bbe4 system_call+0x5c/0x70
--- Exception: c01 (System Call) at 00007ffff7d208d8

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/iomap/swapfile.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index a648dbf6991e..23e44bf97c65 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -170,6 +170,16 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 			return ret;
 	}

+	/*
+	 * If this swapfile doesn't contain even a single page-aligned
+	 * contiguous range of blocks, reject this useless swapfile to
+	 * prevent confusion later on.
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

