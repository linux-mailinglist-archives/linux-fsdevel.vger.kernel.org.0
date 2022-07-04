Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044A6564D6D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jul 2022 07:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiGDFqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jul 2022 01:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiGDFqQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jul 2022 01:46:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51687658F;
        Sun,  3 Jul 2022 22:46:14 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2643LbrL003589;
        Mon, 4 Jul 2022 05:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=PwndybbU5St62Xaa17A+kFodMrjT7D2lRUFJja/O3A4=;
 b=NFnjF+rqrwl0Cvo/xVNxiRg5Z9eXjq6/fIbFdOxcrtyFC9dma8B84g2LzTQ7tIzi+9yS
 wLsZ8MWZidAwjGLbKKjPSweY9YEQ93Zoojo4+K81AdMeqIMt/Ipj2mGfVF4ET2wwVho9
 zH+CMqdBN01Krl4g+94np1vy/8mdwb0Qp8xB2dR5GVmGIKdKDkvtZ6f1IKVbv3xkHgc/
 WzbTpATRZmqHRcYvBprfXzsZIi7BwdNvLAFAs1iri1eSW2oPm2k+AB4rQmxGj651MC9T
 6mRN5Uy0+WrlYwwRH1PJkPV3ZFhbUN6P/t0KnvFuMBzRNrq1F9yeyte73Ga2rk6SfISs lA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3r7yja69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 05:46:12 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2645aH2l005963;
        Mon, 4 Jul 2022 05:46:10 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3h2dn8sn2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 05:46:10 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2645k8jH19005922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Jul 2022 05:46:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46A4442042;
        Mon,  4 Jul 2022 05:46:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6804E4203F;
        Mon,  4 Jul 2022 05:46:06 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.91.160])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Jul 2022 05:46:06 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: Reflect mb_optimize_scan value in options file
Date:   Mon,  4 Jul 2022 11:16:03 +0530
Message-Id: <20220704054603.21462-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l3BjGiAVlvRLgJqbWgWrlkSH0gmQC_IM
X-Proofpoint-ORIG-GUID: l3BjGiAVlvRLgJqbWgWrlkSH0gmQC_IM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_05,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 spamscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2207040023
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support to display the mb_optimize_scan value in
/proc/fs/ext4/<dev>/options file. The option is only
displayed when the value is non default.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/super.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 845f2f8aee5f..e3fd50b0d6b7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3011,6 +3011,15 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 	} else if (test_opt2(sb, DAX_INODE)) {
 		SEQ_OPTS_PUTS("dax=inode");
 	}
+
+	if (sbi->s_groups_count >= MB_DEFAULT_LINEAR_SCAN_THRESHOLD &&
+			!test_opt2(sb, MB_OPTIMIZE_SCAN)) {
+		SEQ_OPTS_PUTS("mb_optimize_scan=0");
+	} else if (sbi->s_groups_count < MB_DEFAULT_LINEAR_SCAN_THRESHOLD &&
+			test_opt2(sb, MB_OPTIMIZE_SCAN)) {
+		SEQ_OPTS_PUTS("mb_optimize_scan=1");
+	}
+
 	ext4_show_quota_options(seq, sb);
 	return 0;
 }
-- 
2.27.0

