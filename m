Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB49514B272
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 11:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgA1KSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 05:18:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725965AbgA1KSw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:18:52 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SABEcc044648
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 05:18:51 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xtfgy829q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 05:18:50 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 28 Jan 2020 10:18:48 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Jan 2020 10:18:44 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00SAIhoU47710238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 10:18:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2F89AE045;
        Tue, 28 Jan 2020 10:18:43 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1089AE053;
        Tue, 28 Jan 2020 10:18:41 +0000 (GMT)
Received: from dhcp-9-199-158-40.in.ibm.com (unknown [9.199.158.40])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jan 2020 10:18:41 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        hch@infradead.org, cmaiolino@redhat.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFCv2 3/4] ext4: Move ext4 bmap to use iomap infrastructure.
Date:   Tue, 28 Jan 2020 15:48:27 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1580121790.git.riteshh@linux.ibm.com>
References: <cover.1580121790.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012810-0020-0000-0000-000003A4B391
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012810-0021-0000-0000-000021FC5D67
Message-Id: <fd7dce26e380a398e70d91d49384b40cda7f5271.1580121790.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_02:2020-01-24,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=3 mlxlogscore=532 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001280083
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ext4_iomap_begin is already implemented which provides
ext4_map_blocks, so just move the API from
generic_block_bmap to iomap_bmap for iomap conversion.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3b4230cf0bc2..0f8a196d8a61 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3214,7 +3214,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
 			return 0;
 	}
 
-	return generic_block_bmap(mapping, block, ext4_get_block);
+	return iomap_bmap(mapping, block, &ext4_iomap_ops);
 }
 
 static int ext4_readpage(struct file *file, struct page *page)
-- 
2.21.0

