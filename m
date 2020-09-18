Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B939C26F548
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 07:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIRFGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 01:06:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbgIRFGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 01:06:52 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08I52qrq136666;
        Fri, 18 Sep 2020 01:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=aKg0rRpn9njQPxYxFBecnCKsQMQFOguGyx4Y1/cCL74=;
 b=rUpM6aUuGV3UKhj/sl3flKUz1qEJc+kvH2+as2RXThLYf9T9oU6srdZOSqsvaQVk6vuL
 3hksfZ7UbluL+llDsf7G3YXDs/7vumPjfygeF9pWhg+FQsktvcw6DObJ6SPpvAdhclqb
 2lo5U4KwU0DXwV/oXaXCzQeF2tYIteW4Z4cxoZIFbmS/pOgs5aOxwfPdyFG5SG0AQ5s6
 dI+vg9MYWw23FOUJZTZ0ilHbGDEIUW6Tv4AoYZpSXqjB33FdvnP+JKeAatN+VgELRl6N
 QLmKUE+7upocs5IRbAs5o48br7iEpQZmhrM6C9akbk+CcTe9oE/n6mH5E3wBmh9WswcV xQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33mp96r87n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 01:06:46 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08I4w3V7024700;
        Fri, 18 Sep 2020 05:06:43 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 33k9geancy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 05:06:43 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08I557UD30998972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Sep 2020 05:05:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7442BA405C;
        Fri, 18 Sep 2020 05:06:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05033A4054;
        Fri, 18 Sep 2020 05:06:40 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.45.180])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Sep 2020 05:06:39 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, dan.j.williams@intel.com,
        anju@linux.vnet.ibm.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 1/1] ext4: Optimize file overwrites
Date:   Fri, 18 Sep 2020 10:36:35 +0530
Message-Id: <88e795d8a4d5cd22165c7ebe857ba91d68d8813e.1600401668.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1600401668.git.riteshh@linux.ibm.com>
References: <cover.1600401668.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-18_02:2020-09-16,2020-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 mlxlogscore=607 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=1 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009180037
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In case if the file already has underlying blocks/extents allocated
then we don't need to start a journal txn and can directly return
the underlying mapping. Currently ext4_iomap_begin() is used by
both DAX & DIO path. We can check if the write request is an
overwrite & then directly return the mapping information.

This could give a significant perf boost for multi-threaded writes
specially random overwrites.
On PPC64 VM with simulated pmem(DAX) device, ~10x perf improvement
could be seen in random writes (overwrite). Also bcoz this optimizes
away the spinlock contention during jbd2 slab cache allocation
(jbd2_journal_handle). On x86 VM, ~2x perf improvement was observed.

Reported-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 10dd470876b3..6eae17758ece 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3437,14 +3437,26 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
 			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
 
-	if (flags & IOMAP_WRITE)
+	if (flags & IOMAP_WRITE) {
+		/*
+		 * We check here if the blocks are already allocated, then we
+		 * don't need to start a journal txn and we can directly return
+		 * the mapping information. This could boost performance
+		 * especially in multi-threaded overwrite requests.
+		 */
+		if (offset + length <= i_size_read(inode)) {
+			ret = ext4_map_blocks(NULL, inode, &map, 0);
+			if (ret > 0 && (map.m_flags & EXT4_MAP_MAPPED))
+				goto out;
+		}
 		ret = ext4_iomap_alloc(inode, &map, flags);
-	else
+	} else {
 		ret = ext4_map_blocks(NULL, inode, &map, 0);
+	}
 
 	if (ret < 0)
 		return ret;
-
+out:
 	ext4_set_iomap(inode, iomap, &map, offset, length);
 
 	return 0;
-- 
2.26.2

