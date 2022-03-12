Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A5B4D6CE5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 06:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiCLFmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 00:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiCLFlr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 00:41:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0F425ECA2;
        Fri, 11 Mar 2022 21:40:33 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22C4V0Mv011819;
        Sat, 12 Mar 2022 05:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Gp+Rqx+qL68po/xpbj82yg+GvhS3dYdzTESi/QIHXmw=;
 b=msOcNU6eJSa+J5abmREY7h9zMNltPy+vOmqMYNiJ+s4IYlmEW0wF2gYLaAwc1WdiUhYh
 uHiuPj54FBT3bWjSMHBqqRkWlF499hY4/Vgz/A7bguhtTp3tFGLpE8bxayaURh6YnEfn
 rfLfRhiH7DDMdVOzi5XWbG3koKRYr0fFmICA5A1nDie05IYEZxgWBQr1z3HQ712coQK1
 OWEZkwiC6hW9KfaQV/f3cfa3EhzkhjsJmYi03+NN2uDlCI5HPt8C4+XseYAGqGwLVf9S
 RahBNJSnfRgXb8kXOnuEluZh+XPs+8Pul9Scto6T3TuP42UNGMB6ChF2wVXOtr7QYAie sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3erm58h1um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:28 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22C5XqYX002394;
        Sat, 12 Mar 2022 05:40:28 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3erm58h1ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:27 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22C5TvJS011933;
        Sat, 12 Mar 2022 05:40:26 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3erk58g639-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:26 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22C5eOxV34734366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 05:40:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0C4B4C04A;
        Sat, 12 Mar 2022 05:40:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 337B34C044;
        Sat, 12 Mar 2022 05:40:23 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 12 Mar 2022 05:40:22 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 10/10] ext4: Fix remaining two trace events to use same printk convention
Date:   Sat, 12 Mar 2022 11:09:55 +0530
Message-Id: <8f33b163f0f29df2491c03b79f8ac96890ea5184.1647057583.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1647057583.git.riteshh@linux.ibm.com>
References: <cover.1647057583.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eqYdgLh6ojQ3styW3VTfOY11WjUGtw5U
X-Proofpoint-ORIG-GUID: UZw1hbxZ6Kjcj2z5TObIEcPGO_yd7dUA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-12_02,2022-03-11_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=763 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203120032
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
index aad97376e032..ce2b3ad0ee86 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2654,7 +2654,7 @@ TRACE_EVENT(ext4_fc_replay_scan,
 		__entry->off = off;
 	),
 
-	TP_printk("FC scan pass on dev %d,%d: error %d, off %d",
+	TP_printk("dev %d,%d error %d, off %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->error, __entry->off)
 );
@@ -2680,7 +2680,7 @@ TRACE_EVENT(ext4_fc_replay,
 		__entry->priv2 = priv2;
 	),
 
-	TP_printk("FC Replay %d,%d: tag %d, ino %d, data1 %d, data2 %d",
+	TP_printk("dev %d,%d: tag %d, ino %d, data1 %d, data2 %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->tag, __entry->ino, __entry->priv1, __entry->priv2)
 );
-- 
2.31.1

