Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE6D1B6EE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 09:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgDXHWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 03:22:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19234 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726078AbgDXHWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 03:22:44 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O72E7X082044;
        Fri, 24 Apr 2020 03:22:35 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30kppdr52f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 03:22:35 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03O7KSgY013238;
        Fri, 24 Apr 2020 07:22:32 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 30fs658ufd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 07:22:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03O7MUNh11927828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 07:22:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0169A4062;
        Fri, 24 Apr 2020 07:22:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0A7BA4060;
        Fri, 24 Apr 2020 07:22:27 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.79.185.245])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Apr 2020 07:22:27 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 2/2] iomap: bmap: Remove the WARN and return the proper block address
Date:   Fri, 24 Apr 2020 12:52:18 +0530
Message-Id: <e2e09c5d840458b4ace6f9b31429ceefd9c1df01.1587670914.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1587670914.git.riteshh@linux.ibm.com>
References: <cover.1587670914.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_02:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004240048
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap_bmap() could be called from either of these two paths.
Either when a user is calling an ioctl_fibmap() interface to get
the block mapping address or by some filesystem via use of bmap()
internal kernel API.
bmap() kernel API is well equipped with handling of u64 addresses.

WARN condition in iomap_bmap_actor() was mainly added to warn all
the fibmap users. But now that in previous patch we have directly added
this WARN condition for all fibmap users and also made sure to return 0
as block map address in case if addr > INT_MAX. 
So we can now remove this logic from here.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/iomap/fiemap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index bccf305ea9ce..d55e8f491a5e 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -117,10 +117,7 @@ iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
 
 	if (iomap->type == IOMAP_MAPPED) {
 		addr = (pos - iomap->offset + iomap->addr) >> inode->i_blkbits;
-		if (addr > INT_MAX)
-			WARN(1, "would truncate bmap result\n");
-		else
-			*bno = addr;
+		*bno = addr;
 	}
 	return 0;
 }
-- 
2.21.0

