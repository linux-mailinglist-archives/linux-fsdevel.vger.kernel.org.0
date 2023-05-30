Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BE8715FE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 14:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjE3MgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 08:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjE3MgD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 08:36:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A3DE4C;
        Tue, 30 May 2023 05:35:31 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UBrV6o013352;
        Tue, 30 May 2023 12:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=l31TWPx7iQqEtqCIwTjdkarFhVmshfo03Z6bbRpQAto=;
 b=LqL8ekO01xkqai7C/h746+s6yMwbCZCfRbgTWMJpAH0Z6FA8mz8UsBQjsP6+EbXAuLDa
 t6HxPna/JKH94cEMa3JUukqejrRe3dREAYYITCuW+1i+aysRN0E2666gVhBJ9A89gRZF
 CCPpOCmmKYwVvPnavq+NG1WnJ7gDw7ob0O44ps5lKH85jb5BF/rUpKLM1v+78pAF87LK
 Zyihd8exjvA6sxGk3tf4EX/f9NYeXT8dKR02Ju+MIj7TNKr/kLD62EoY7bZ4gENtcEYw
 MZOJc0+YshMwZlkuicBPbSDC2FbjuiSETKVTDY+aycAUUex4Zhd5qHz4MofbDl+AJFR7 AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwbst1e3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:15 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UCGA1C030172;
        Tue, 30 May 2023 12:34:14 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwbst1e1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:14 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U5k672032052;
        Tue, 30 May 2023 12:34:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3qu9g5183y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34UCY9Cm43123344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 12:34:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B65E320043;
        Tue, 30 May 2023 12:34:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D52720040;
        Tue, 30 May 2023 12:34:07 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 30 May 2023 12:34:07 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v2 07/12] ext4: Avoid scanning smaller extents in BG during CR1
Date:   Tue, 30 May 2023 18:03:45 +0530
Message-Id: <a5473df4517c53ec940bc9b603ef83a547032a32.1685449706.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685449706.git.ojaswin@linux.ibm.com>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Vi_Y8PMUwyEL3MLzPKwnEdq4EdBl5_D7
X-Proofpoint-GUID: TQTdXStfxejj1jI504QkJrQjoEY-EJV9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_08,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=800 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we are inside ext4_mb_complex_scan_group() in CR1, we can be sure
that this group has atleast 1 big enough continuous free extent to satisfy
our request because (free / fragments) > goal length.

Hence, instead of wasting time looping over smaller free extents, only
try to consider the free extent if we are sure that it has enough
continuous free space to satisfy goal length. This is particularly
useful when scanning highly fragmented BGs in CR1 as, without this
patch, the allocator might stop scanning early before reaching the big
enough free extent (due to ac_found > mb_max_to_scan) which causes us to
uncessarily trim the request.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 73e98a4d01f5..c86565606359 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2308,7 +2308,7 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
 	struct super_block *sb = ac->ac_sb;
 	void *bitmap = e4b->bd_bitmap;
 	struct ext4_free_extent ex;
-	int i;
+	int i, j, freelen;
 	int free;
 
 	free = e4b->bd_info->bb_free;
@@ -2335,6 +2335,23 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
 			break;
 		}
 
+		if (ac->ac_criteria < CR2) {
+			/*
+			 * In CR1, we are sure that this group will
+			 * have a large enough continuous free extent, so skip
+			 * over the smaller free extents
+			 */
+			j = mb_find_next_bit(bitmap,
+						EXT4_CLUSTERS_PER_GROUP(sb), i);
+			freelen = j - i;
+
+			if (freelen < ac->ac_g_ex.fe_len) {
+				i = j;
+				free -= freelen;
+				continue;
+			}
+		}
+
 		mb_find_extent(e4b, i, ac->ac_g_ex.fe_len, &ex);
 		if (WARN_ON(ex.fe_len <= 0))
 			break;
-- 
2.31.1

