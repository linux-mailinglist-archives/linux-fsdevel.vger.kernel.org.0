Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92714D4DF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 17:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbiCJQBC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 11:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbiCJQAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:00:54 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F410184B49;
        Thu, 10 Mar 2022 07:59:53 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22AEoCpw021880;
        Thu, 10 Mar 2022 15:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CSUT6pIjLyOTgjjwE2X2ANvG4kbdjFI6Ow4e1sGwPSw=;
 b=K+c9BHMF0yCia/LuAY57gDLdUGZ8u2JY6RfrehHtoMXhxWMHV4D8lye7LJxKP98Y47vo
 65EAKM4sg9O37IpfN0LCjRb/YxF6m2c7xfcTGFyXB06HMLiwEVCkBQebmizF2LQ8pecE
 NpRg2Mzjadc6AUCPLpW17OTAyt1c7tMxt5zST45Bm99KHn6qc9qTbelcBXoz3dCt9vze
 TU+MPu4d3O6FWyon+moi9SiGhuDMg6/snOZOL3MtohZ5zUilfOKkXd2aRz6Np3SZC+CO
 4A5rEAw1HoGrAR2NNTBIs9Hfk0GPQaS0V98VX0msSQ5pDGDtv9OO+YSPSuaWpV2oM3we Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqg9rxpcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:49 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22AF4gjx005375;
        Thu, 10 Mar 2022 15:59:49 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqg9rxpbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:49 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22AFw9nE025107;
        Thu, 10 Mar 2022 15:59:46 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3eqk8604bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:46 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22AFxiiE20120056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 15:59:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46330A404D;
        Thu, 10 Mar 2022 15:59:44 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA855A4059;
        Thu, 10 Mar 2022 15:59:43 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Mar 2022 15:59:43 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 10/10] ext4: Fix remaining two trace events to use same printk convention
Date:   Thu, 10 Mar 2022 21:29:04 +0530
Message-Id: <3825e0a76056de8b1cddc8a318160263b4a77b61.1646922487.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1646922487.git.riteshh@linux.ibm.com>
References: <cover.1646922487.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z9pJTNzezuG0VXYQA58VbjUaVOIrSlHj
X-Proofpoint-ORIG-GUID: 9Bx5AV4yq3lfCn03XERSHzE2Qc-1fXda
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_06,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=763 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All ext4 & jbd2 trace events starts with "dev Major:Minor".
While we are still improving/adding the ftrace events for FC,
let's fix last two remaining trace events to follow the same
convention.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 include/trace/events/ext4.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 09766eb56988..2137911a9392 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2653,7 +2653,7 @@ TRACE_EVENT(ext4_fc_replay_scan,
 		__entry->off = off;
 	),
 
-	TP_printk("FC scan pass on dev %d,%d: error %d, off %d",
+	TP_printk("dev %d,%d error %d, off %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->error, __entry->off)
 );
@@ -2679,7 +2679,7 @@ TRACE_EVENT(ext4_fc_replay,
 		__entry->priv2 = priv2;
 	),
 
-	TP_printk("FC Replay %d,%d: tag %d, ino %d, data1 %d, data2 %d",
+	TP_printk("dev %d,%d: tag %d, ino %d, data1 %d, data2 %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->tag, __entry->ino, __entry->priv1, __entry->priv2)
 );
-- 
2.31.1

