Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A104AA958
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 15:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380110AbiBEOKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 09:10:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380104AbiBEOKu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 09:10:50 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 215B7WVB006898;
        Sat, 5 Feb 2022 14:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=aI4vEeTNOg9v1dM63azd4oTJbPVlwfR5PDX//Ogqchk=;
 b=sjNLgI1sUZRL2LMhP0mDmbOClbwzc2bgenieP8AtOVbHaFl0P9tTwx8SJbBiyV1/3Kvs
 qk5gMAactf4I/tbCWntdPUVKMymIpEtYvaDRndzQzWhGyKglF3LKffMJ3Cgm8LVoFWB4
 YieOUnbmfBf6FW/a3KWDSYlNaHGsqEcgWnjJlLr/bitaE/VbEwR6T5Chh6vs/Z3B4YCI
 Er9476RiAxMk7hNUcvB3tIlhlxn35yzCU1ylCgejWD4Clw/nuT8I222fde3WsE+ulaRm
 y8tynY5Orcl+RUmm4h5V3tfmZXzLmso3VpGWjb4mWC+Ujmh3phIgcCbpMS7S63V0E1Yn GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1hvby3q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:39 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 215EAdvV023132;
        Sat, 5 Feb 2022 14:10:39 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1hvby3pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:38 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 215E2rtr026680;
        Sat, 5 Feb 2022 14:10:36 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3e1gv8t0tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:36 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 215EAY3M32244050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 14:10:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E2A1A4055;
        Sat,  5 Feb 2022 14:10:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CB6DA4040;
        Sat,  5 Feb 2022 14:10:33 +0000 (GMT)
Received: from localhost (unknown [9.43.12.205])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  5 Feb 2022 14:10:32 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv1 6/9] ext4: No need to test for block bitmap bits in ext4_mb_mark_bb()
Date:   Sat,  5 Feb 2022 19:39:55 +0530
Message-Id: <40b6efa3a8333ec411d05fe5390f0977f7576d64.1644062450.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644062450.git.riteshh@linux.ibm.com>
References: <cover.1644062450.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pZZh8IPiGJt26LKF67pM7wq_67aL9OQO
X-Proofpoint-ORIG-GUID: 6R7XRIpKBxBlTnT09cmA6EYi4Pb-ST6Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-05_10,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=718 malwarescore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202050095
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We don't need the return value of mb_test_and_clear_bits() in ext4_mb_mark_bb()
So simply use mb_clear_bits() instead.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f80af108d05e..23313963bb56 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3941,7 +3941,7 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 		if (state)
 			mb_set_bits(bitmap_bh->b_data, blkoff, clen);
 		else
-			mb_test_and_clear_bits(bitmap_bh->b_data, blkoff, clen);
+			mb_clear_bits(bitmap_bh->b_data, blkoff, clen);
 		if (ext4_has_group_desc_csum(sb) &&
 		    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
 			gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
-- 
2.31.1

