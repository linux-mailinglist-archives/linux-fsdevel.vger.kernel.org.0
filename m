Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785B94D9D86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 15:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349208AbiCOOa3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 10:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349186AbiCOOa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:30:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949625520A;
        Tue, 15 Mar 2022 07:29:13 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FDC4QX014500;
        Tue, 15 Mar 2022 14:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3EXxyCI0HB+4wSF/cZmEZ8owPZNvxiI2fMDKOB98uBg=;
 b=XSfK2iXx4/oxoUCPxxT0O2/Gn9xKN6pn99XKGaldc8hNQCsPBDaqkVCeCy8RTCkSlacp
 nRRDGq4fMKXh+tjSrnNiXXX4c5afZFBt9vdXOuYn8KFrd8wLeL1AuGo3OjwHgf2UyVqI
 JgpQBxcKWumPe9TcGONTZhfZb6ijB0eZeK9tdF4bOpOH1OrrMDOB8oDGjTO5YmblJO4P
 pNZn8eJpZev7QZp0X5cf6hhvXEc7HO2TQ1ls+rieX6wB5qmzvROGip+wPa5l6TTHY8/4
 ohKKD80jjt1S8ToE/ZGKfppL81S1bUTeW/Ywc1G/QhmuYXcs7iUPqbRe0wIV/sBKJUPX Kw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3etufj9wfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 14:29:13 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22FE9H89024788;
        Tue, 15 Mar 2022 14:29:10 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3erk58nu6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 14:29:10 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22FET8Wu50069834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 14:29:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E150AE04D;
        Tue, 15 Mar 2022 14:29:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4A2FAE045;
        Tue, 15 Mar 2022 14:29:07 +0000 (GMT)
Received: from localhost (unknown [9.43.32.151])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Mar 2022 14:29:07 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 2/4] common/punch: Add block_size argument to _filter_fiemap_**
Date:   Tue, 15 Mar 2022 19:58:57 +0530
Message-Id: <074f560c97fba2be9ff367ab9b4b7963ba23fe4b.1647342932.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1647342932.git.riteshh@linux.ibm.com>
References: <cover.1647342932.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: axTh6xouKiiJXxcFxMNE4Pkp__nzDRpP
X-Proofpoint-GUID: axTh6xouKiiJXxcFxMNE4Pkp__nzDRpP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_03,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add block_size paramter to _filter_fiemap_flags() and
_filter_hole_fiemap(). This is used in next patches

Also this fixes some of the end of line whitespace issues while we are
at it.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 common/punch | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/common/punch b/common/punch
index b6b8a0b9..f99e21ad 100644
--- a/common/punch
+++ b/common/punch
@@ -109,6 +109,7 @@ _filter_fiemap()

 _filter_fiemap_flags()
 {
+	block_size=$1
 	$AWK_PROG '
 		$3 ~ /hole/ {
 			print $1, $2, $3;
@@ -135,23 +136,24 @@ _filter_fiemap_flags()
 			}
 			print $1, $2, flag_str
 		}' |
-	_coalesce_extents
+	_coalesce_extents $block_size
 }

-# Filters fiemap output to only print the
+# Filters fiemap output to only print the
 # file offset column and whether or not
 # it is an extent or a hole
 _filter_hole_fiemap()
 {
+	block_size=$1
 	$AWK_PROG '
 		$3 ~ /hole/ {
-			print $1, $2, $3;
+			print $1, $2, $3;
 			next;
-		}
+		}
 		$5 ~ /0x[[:xdigit:]]+/ {
 			print $1, $2, "extent";
 		}' |
-	_coalesce_extents
+	_coalesce_extents $block_size
 }

 #     10000 Unwritten preallocated extent
--
2.31.1

