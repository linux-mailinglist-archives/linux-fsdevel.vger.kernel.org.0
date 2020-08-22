Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9449624E71A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 13:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgHVLfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 07:35:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726920AbgHVLfB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 07:35:01 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07MBVdhD140106;
        Sat, 22 Aug 2020 07:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JoSzpGKZktZepI2WPW3YZ+KFJZY13W5BEURnHztssno=;
 b=AD5+qjO5XeP7yzRYtq/pOrQ3FlvYZHWTv4V5hIFNuLvqHJWjsDCjeIw4/VhpdgonM4Vf
 ZHYhpiKYojal7JCM0Mi/QgFyXaAbAOF9VeAA/OdtN9V6jRFW1vBCIuBHsID7h5X1t2k1
 n8xpi7Bkrhc0WKEmmuEulioLVpZYnsUp0z4GqwtbpRW+I0uEAw4qS7kZpXuMhCfaGkeU
 gbrhYhXM9a54Qsvh2yVF8AXIAuipgFFx8tdmUzKXiAdrHlOc7YeutJH/ssKidPbxTznt
 K1S0VLT0gd6MODYV6+FPmxCpGdSL9UaUWx+9bo9+YKHzGV2PkhxqtLnHJIDySNUQYa19 BQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 332yj2tvgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Aug 2020 07:34:54 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07MBX3W7021785;
        Sat, 22 Aug 2020 11:34:52 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 332utsrara-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Aug 2020 11:34:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07MBXKqE64618988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Aug 2020 11:33:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B69052054;
        Sat, 22 Aug 2020 11:34:50 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.33.217])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EB9825204E;
        Sat, 22 Aug 2020 11:34:48 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     jack@suse.cz, tytso@mit.edu,
        Dan Williams <dan.j.williams@intel.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 3/3] ext4: Optimize ext4 DAX overwrites
Date:   Sat, 22 Aug 2020 17:04:37 +0530
Message-Id: <e455ec054a295d9ffde41b8ec1183325f0426162.1598094830.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1598094830.git.riteshh@linux.ibm.com>
References: <cover.1598094830.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-22_07:2020-08-21,2020-08-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=792 adultscore=0 mlxscore=0 suspectscore=1 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008220120
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently in case of DAX, we are starting a journal txn everytime for
IOMAP_WRITE case. This can be optimized away in case of an overwrite
(where the blocks were already allocated).

This could give a significant performance boost for multi-threaded writes
specially random writes.
On PPC64 VM with simulated pmem device, ~10x perf improvement could be
seen in random writes (overwrite). Also bcoz this optimizes away the
spinlock contention during jbd2 slab cache allocation (jbd2_journal_handle)
On x86 VM, ~2x perf improvement was observed.

Reported-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 10dd470876b3..c18009c91e68 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3437,6 +3437,14 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
 			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
 
+	/*
+	 * In case of DAX write, we check if this is overwrite request, to avoid
+	 * starting a journal txn in ext4_iomap_alloc()
+	 */
+	if ((flags & IOMAP_WRITE) && IS_DAX(inode) &&
+	    ext4_overwrite_io(inode, &map, true))
+		goto out_set;
+
 	if (flags & IOMAP_WRITE)
 		ret = ext4_iomap_alloc(inode, &map, flags);
 	else
@@ -3444,9 +3452,8 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 
 	if (ret < 0)
 		return ret;
-
+out_set:
 	ext4_set_iomap(inode, iomap, &map, offset, length);
-
 	return 0;
 }
 
-- 
2.25.4

