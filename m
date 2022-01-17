Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D52490868
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 13:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbiAQMMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 07:12:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239654AbiAQMMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:12:17 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20HAw0nx008699;
        Mon, 17 Jan 2022 12:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yZF6/VC61RuhhzAdKtb2V4MjJfh5hgy1HqYC11csIvA=;
 b=IwrAixKb+9G12FaZI2hzVb1RjLI3azEovVgdo7prHKE3Om/ssI7zF9Zv3yuqfDSQtdnn
 YbBgQNAk14DePUjp19hy+RFbGV0lAe1HzARDhLg+skXHNZ18rdiudrDJXaDbaUr3UbOq
 2tQYuh4VEuRsXU3ipJ9zP6/xNW7b8jDwjpB+cBSrnoukyMwutKbOeAKMbBuT9v4YI/ND
 NKdPzCGElYi+wARphzbGcbJ1p4qQm2kKKpJLpSl5WSm/oScRaUG+mY0BjA3bNU/hjpKU
 N0v8Sbuan2TqzRQc7WtSgcXCPdwa0lUYWAwPyGzwBcH0pD7mV7Bu2HOOZmtGgrrTqLYI Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dn75vsj5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:12:07 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20HB1Kat021559;
        Mon, 17 Jan 2022 12:12:06 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dn75vsj4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:12:06 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20HC71ZC007832;
        Mon, 17 Jan 2022 12:12:05 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3dknw8jwqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:12:05 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20HCC2Gw42008858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 12:12:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91063A404D;
        Mon, 17 Jan 2022 12:12:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B191A405E;
        Mon, 17 Jan 2022 12:12:02 +0000 (GMT)
Received: from localhost (unknown [9.43.45.117])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jan 2022 12:12:01 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: [PATCHv2 2/5] ext4: Remove redundant max inline_size check in ext4_da_write_inline_data_begin()
Date:   Mon, 17 Jan 2022 17:41:48 +0530
Message-Id: <cdd1654128d5105550c65fd13ca5da53b2162cc4.1642416995.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642416995.git.riteshh@linux.ibm.com>
References: <cover.1642416995.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: efIZuGDWsOUStvoBvl7uX2Cu3_GJyhJN
X-Proofpoint-GUID: nWIRPvrCUGFfqQCFPn4rV1rUh8BBz6pA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-17_04,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0
 clxscore=1015 mlxlogscore=625 impostorscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201170077
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ext4_prepare_inline_data() already checks for ext4_get_max_inline_size()
and returns -ENOSPC. So there is no need to check it twice within
ext4_da_write_inline_data_begin(). This patch removes the extra check.

It also makes it more clean.

No functionality change in this patch.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inline.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index d091133a4b46..cbdd84e49f2c 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -911,7 +911,7 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 				    struct page **pagep,
 				    void **fsdata)
 {
-	int ret, inline_size;
+	int ret;
 	handle_t *handle;
 	struct page *page;
 	struct ext4_iloc iloc;
@@ -928,14 +928,9 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 		goto out;
 	}
 
-	inline_size = ext4_get_max_inline_size(inode);
-
-	ret = -ENOSPC;
-	if (inline_size >= pos + len) {
-		ret = ext4_prepare_inline_data(handle, inode, pos + len);
-		if (ret && ret != -ENOSPC)
-			goto out_journal;
-	}
+	ret = ext4_prepare_inline_data(handle, inode, pos + len);
+	if (ret && ret != -ENOSPC)
+		goto out_journal;
 
 	/*
 	 * We cannot recurse into the filesystem as the transaction
-- 
2.31.1

