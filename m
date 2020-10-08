Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C084C2876B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 17:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbgJHPHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 11:07:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34024 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729833AbgJHPHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:07:07 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098F6hqc005281;
        Thu, 8 Oct 2020 11:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=TU3Vv6Ga6bEzHHrK5lKsNSnFYGgobH1F9L4w1nv/Bug=;
 b=ILz1Hp1fJCeHNWYCPzqjNDQgcWurKlyVq4Q8THfbDcugVRWwLRGNsoIv0jqd1+qni6Af
 sVvp6SbRxOeUFjd6/Ng76Z/hCUhbh5oOPWvnDzuM6Qw6Z0iGrJ736cCoFnAOK5OotnMn
 n/1BGvXEipt19SdS1gxMryMHDcb4U5fGZwlDRT5itGzOq/9tgmjjE5+tJdHzleQZVA7W
 MgimL28z5BHpPD+JeyFUNvKNl583bjz9pkeBUNKiC2Bb24UkFT3J0zx7DKPYOD6CziRO
 dyKw81OudQ29W4JzWfNXEeA5+4jYWjXad98rXH+Wkv4/63xIj670l28sxfm2LxPOKj1e vw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3421ec084n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 11:06:58 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 098F2msC001928;
        Thu, 8 Oct 2020 15:02:56 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 33xgjh5f6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 15:02:55 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 098F2rLq30605688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Oct 2020 15:02:53 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EADD7A4053;
        Thu,  8 Oct 2020 15:02:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E801A4057;
        Thu,  8 Oct 2020 15:02:51 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.46.138])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Oct 2020 15:02:51 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        anju@linux.vnet.ibm.com, Ritesh Harjani <riteshh@linux.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 1/1] ext4: Fix bs < ps issue reported with dioread_nolock  mount opt
Date:   Thu,  8 Oct 2020 20:32:48 +0530
Message-Id: <af902b5db99e8b73980c795d84ad7bb417487e76.1602168865.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_08:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 impostorscore=0 suspectscore=1 phishscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080111
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

left shifting m_lblk by blkbits was causing value overflow and hence
it was not able to convert unwritten to written extent.
So, make sure we typecast it to loff_t before do left shift operation.
Also in func ext4_convert_unwritten_io_end_vec(), make sure to initialize
ret variable to avoid accidentally returning an uninitialized ret.

This patch fixes the issue reported in ext4 for bs < ps with
dioread_nolock mount option.

Fixes: c8cc88163f40df39e50c ("ext4: Add support for blocksize < pagesize in dioread_nolock")
Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/extents.c | 2 +-
 fs/ext4/inode.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index a0481582187a..32d610cc896d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4769,7 +4769,7 @@ int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
 
 int ext4_convert_unwritten_io_end_vec(handle_t *handle, ext4_io_end_t *io_end)
 {
-	int ret, err = 0;
+	int ret = 0, err = 0;
 	struct ext4_io_end_vec *io_end_vec;
 
 	/*
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bf596467c234..3021235deaa1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2254,7 +2254,7 @@ static int mpage_process_page(struct mpage_da_data *mpd, struct page *page,
 					err = PTR_ERR(io_end_vec);
 					goto out;
 				}
-				io_end_vec->offset = mpd->map.m_lblk << blkbits;
+				io_end_vec->offset = (loff_t)mpd->map.m_lblk << blkbits;
 			}
 			*map_bh = true;
 			goto out;
-- 
2.26.2

