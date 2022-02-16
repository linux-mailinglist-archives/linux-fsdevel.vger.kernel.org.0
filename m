Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0927F4B81D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 08:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiBPHii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 02:38:38 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiBPHih (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:38:37 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8314165C13;
        Tue, 15 Feb 2022 23:38:07 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21G682dT016202;
        Wed, 16 Feb 2022 07:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TpsHkllhQVJnJIT0A6YTGPF+I17MsKdAGNCCvlaIYsY=;
 b=rU0GtUZTBkwTMI2WcQvRk35dqmVxnKNI/aC+NRmx1ms+/tuIXJ6L1DVXcTInTjZCHaOq
 R3ZLPeenvv3laKq6piyQSCnP5UiDOLEQS6pEdZm+liGqSztefvOe1ygg1v7SG2oRvnik
 bS3XN3JoJBEmMHidC3pIZ+w1GCt+IRVhg6R9euwSjYrnoq5R2KRvuRmiC83S75ZsAQnl
 hGW/hTHHQCmukafx2y5EOFICIfzf6LoZlrpS1GTjp4B+7iyShFDIPakhpO/OXJiBnmsW
 APjaSbOuy3C48dRqajaAfeh06ARhHZDuPrWma6BLC0gl2Jxl8y4p0MmtrfohTpXCybz0 IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e8q1ax2r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:03:11 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21G71SuX011408;
        Wed, 16 Feb 2022 07:03:11 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e8q1ax2qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:03:11 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21G71rSX014795;
        Wed, 16 Feb 2022 07:03:09 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3e64ha41kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:03:09 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21G7373S46858658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 07:03:07 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06485AE053;
        Wed, 16 Feb 2022 07:03:07 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DD59AE058;
        Wed, 16 Feb 2022 07:03:06 +0000 (GMT)
Received: from localhost (unknown [9.43.85.173])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Feb 2022 07:03:06 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 6/9] ext4: No need to test for block bitmap bits in ext4_mb_mark_bb()
Date:   Wed, 16 Feb 2022 12:32:48 +0530
Message-Id: <a971935306dafb124da0193c7dad1aa485210b62.1644992610.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644992609.git.riteshh@linux.ibm.com>
References: <cover.1644992609.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: alegA_YNuZZYEoRlQHC1TKi-ZBf2osSd
X-Proofpoint-ORIG-GUID: tRcHnovDgAgiQRG5Q7sNDWdXg-od8Xa1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_02,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=715 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202160038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index c2a6f924b456..bb3cfcd545ce 100644
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

