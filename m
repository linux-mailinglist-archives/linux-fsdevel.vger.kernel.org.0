Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 960871715BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 12:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgB0LKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 06:10:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728876AbgB0LKp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:10:45 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RB9Tfo121501
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 06:10:44 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydkfab8hu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 06:10:44 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 27 Feb 2020 11:10:41 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Feb 2020 11:10:37 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01RBAaPL58196154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 11:10:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0A354203F;
        Thu, 27 Feb 2020 11:10:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7930E4204C;
        Thu, 27 Feb 2020 11:10:32 +0000 (GMT)
Received: from dhcp-9-199-158-169.in.ibm.com (unknown [9.199.158.169])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Feb 2020 11:10:32 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, hch@infradead.org, cmaiolino@redhat.com,
        david@fromorbit.com, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv4 1/6] ext4: Add IOMAP_F_MERGED for non-extent based mapping
Date:   Thu, 27 Feb 2020 16:40:22 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1582800839.git.riteshh@linux.ibm.com>
References: <cover.1582800839.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022711-0020-0000-0000-000003AE14F3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022711-0021-0000-0000-0000220633BA
Message-Id: <8bffe1aef219916d3962faffd2e75cd7e06060c2.1582800839.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_03:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=701
 suspectscore=3 malwarescore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270090
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

IOMAP_F_MERGED needs to be set in case of non-extent based mapping.
This is needed in later patches for conversion of ext4_fiemap to use iomap.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d035acab5b2a..6cf3b969dc86 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3335,6 +3335,10 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 	iomap->offset = (u64) map->m_lblk << blkbits;
 	iomap->length = (u64) map->m_len << blkbits;
 
+	if ((map->m_flags & EXT4_MAP_MAPPED) &&
+	    !ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		iomap->flags |= IOMAP_F_MERGED;
+
 	/*
 	 * Flags passed to ext4_map_blocks() for direct I/O writes can result
 	 * in m_flags having both EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN bits
-- 
2.21.0

