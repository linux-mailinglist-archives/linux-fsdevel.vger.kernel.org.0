Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C144C032D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 21:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbiBVUgT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 15:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbiBVUfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:35:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7411405C4;
        Tue, 22 Feb 2022 12:35:17 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MIfwPr020928;
        Tue, 22 Feb 2022 20:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1g0aHCdCwOc5+t85WCg3bNlpfnZhH3J1IY+a0Jc4/7w=;
 b=MxLUMxhDM+oaE/2t9i5SAN0MRqrIoIblV9N2cMnZpjlyU1P3A/Umvl9z9ww7aLuz4RDR
 oMVDAo52WVcHlWSA8WLZvRQytZIvTCG/Ebcz0kYI1lNe2XnR6FB06jyBuqEeUWVjc7u4
 5o1jq1ldZymANoS7pHCMbeQVvuwn0Nsl+IRuZowPkPRTO0mi4u5wxeSzkkzE/hGWTbRf
 YT9LJ+2HE9BAiYZMnYPSLr1ziRkfW2txhlfutwEVrREOGk2PFzIyy+Vx7cENN3kIj7Fz
 6Evlc8qn+R+r1iJtEqC5UTuxVZ5Hy/FX6lCmsjHmjOFzIkQScH2EIUxb3feZhyLGe41e Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed5b5tk5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:35:12 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21MKGUaW024130;
        Tue, 22 Feb 2022 20:35:12 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed5b5tk4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:35:12 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21MKJqin025668;
        Tue, 22 Feb 2022 20:35:10 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3ear695ph7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:35:09 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21MKZ7AP37028208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 20:35:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9336952054;
        Tue, 22 Feb 2022 20:35:07 +0000 (GMT)
Received: from localhost (unknown [9.43.75.136])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 061305204E;
        Tue, 22 Feb 2022 20:35:05 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 7/9] ext4: Fix remaining two trace events to use same printk convention
Date:   Wed, 23 Feb 2022 02:04:15 +0530
Message-Id: <9cc1f9ac12ff3dca6b0c18d0bda2245a1264595e.1645558375.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1645558375.git.riteshh@linux.ibm.com>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lFesB8vxn0jpDly8bBtW-goYkevDvvkH
X-Proofpoint-ORIG-GUID: jWawSpIsMV_RWCyDKlZW3aQoiq_0u4-X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_07,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=850 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220126
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
---
 include/trace/events/ext4.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 6e66cb7ce624..233dbffa5ceb 100644
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

