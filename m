Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BE64D13DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 10:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345501AbiCHJxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 04:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345585AbiCHJxJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:53:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D703B4198D;
        Tue,  8 Mar 2022 01:52:13 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2288GoSs007823;
        Tue, 8 Mar 2022 09:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=WM6Qf/k39OV7NTPzqsRekO0Zxro6Fcz/vyXRYcDLL2U=;
 b=RT4G2ffxcQh1Z2zSZNS16vvy9CXsbNdcAYQYJw5CC7Q6CeYGT8Ob89LBttqKnhuaTlZ1
 pHxrQqEtmPIEuYNFqt++IpKeJYKq0DUFQ/u0CNS9JzpcS7RGcFG4K7tSazmJPDEqfbdG
 PeGWCsfD+816rYUOA+l8SJBLsSXV/45bXM/JtPMg3mGT76gqDHLSFx/krQD8skqTFeRS
 oZu68fNgfO/k+sk1FxhCDp5OVtUXckCb/wVV6g2y4I/x/CP9ymH8CEJIz8D+fxZMdOPW
 Az0/XrUR/Mu9upVPQYo9cb1P+kq5Gx31932PX0yEZ4RlrrPK91BgU1Cj02ky8Kp8RhsV DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ep0hfd970-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 09:52:11 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2289mvDj030756;
        Tue, 8 Mar 2022 09:52:11 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ep0hfd96j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 09:52:11 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2289g3Ej005740;
        Tue, 8 Mar 2022 09:52:09 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3eky4j62t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 09:52:09 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2289q6gQ57803074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 09:52:06 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C676DA405C;
        Tue,  8 Mar 2022 09:52:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74BC4A405F;
        Tue,  8 Mar 2022 09:52:04 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.83.182])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Mar 2022 09:52:04 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ext4: Make mb_optimize_scan option work with set/unset mount cmd
Date:   Tue,  8 Mar 2022 15:22:00 +0530
Message-Id: <c98970fe99f26718586d02e942f293300fb48ef3.1646732698.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XqNFAGE4dnT6UjJKckdvpzGY40jSVrsA
X-Proofpoint-ORIG-GUID: X9tOMWz5TEmvvnvJSK7ES0311wrjsdWq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_03,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203080049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After moving to the new mount API, mb_optimize_scan mount option
handling was not working as expected due to the parsed value always
being overwritten by default. Refactor and fix this to the expected
behavior described below:

*  mb_optimize_scan=1 - On
*  mb_optimize_scan=0 - Off
*  mb_optimize_scan not passed - On if no. of BGs > threshold else off
*  Remounts retain previous value unless we explicitly pass the option
   with a new value

Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/super.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c5021ca0a28a..cd0547fabd79 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2021,12 +2021,12 @@ static int ext4_set_test_dummy_encryption(struct super_block *sb, char *arg)
 #define EXT4_SPEC_s_commit_interval		(1 << 16)
 #define EXT4_SPEC_s_fc_debug_max_replay		(1 << 17)
 #define EXT4_SPEC_s_sb_block			(1 << 18)
+#define EXT4_SPEC_mb_optimize_scan		(1 << 19)
 
 struct ext4_fs_context {
 	char		*s_qf_names[EXT4_MAXQUOTAS];
 	char		*test_dummy_enc_arg;
 	int		s_jquota_fmt;	/* Format of quota to use */
-	int		mb_optimize_scan;
 #ifdef CONFIG_EXT4_DEBUG
 	int s_fc_debug_max_replay;
 #endif
@@ -2451,12 +2451,17 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			ctx_clear_mount_opt(ctx, m->mount_opt);
 		return 0;
 	case Opt_mb_optimize_scan:
-		if (result.int_32 != 0 && result.int_32 != 1) {
+		if (result.int_32 == 1) {
+			ctx_set_mount_opt2(ctx, EXT4_MOUNT2_MB_OPTIMIZE_SCAN);
+			ctx->spec |= EXT4_SPEC_mb_optimize_scan;
+		} else if (result.int_32 == 0) {
+			ctx_clear_mount_opt2(ctx, EXT4_MOUNT2_MB_OPTIMIZE_SCAN);
+			ctx->spec |= EXT4_SPEC_mb_optimize_scan;
+		} else {
 			ext4_msg(NULL, KERN_WARNING,
 				 "mb_optimize_scan should be set to 0 or 1.");
 			return -EINVAL;
 		}
-		ctx->mb_optimize_scan = result.int_32;
 		return 0;
 	}
 
@@ -4369,7 +4374,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	/* Set defaults for the variables that will be set during parsing */
 	ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
-	ctx->mb_optimize_scan = DEFAULT_MB_OPTIMIZE_SCAN;
 
 	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
 	sbi->s_sectors_written_start =
@@ -5320,12 +5324,12 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 * turned off by passing "mb_optimize_scan=0". This can also be
 	 * turned on forcefully by passing "mb_optimize_scan=1".
 	 */
-	if (ctx->mb_optimize_scan == 1)
-		set_opt2(sb, MB_OPTIMIZE_SCAN);
-	else if (ctx->mb_optimize_scan == 0)
-		clear_opt2(sb, MB_OPTIMIZE_SCAN);
-	else if (sbi->s_groups_count >= MB_DEFAULT_LINEAR_SCAN_THRESHOLD)
-		set_opt2(sb, MB_OPTIMIZE_SCAN);
+	if (!(ctx->spec & EXT4_SPEC_mb_optimize_scan)) {
+		if (sbi->s_groups_count >= MB_DEFAULT_LINEAR_SCAN_THRESHOLD)
+			set_opt2(sb, MB_OPTIMIZE_SCAN);
+		else
+			clear_opt2(sb, MB_OPTIMIZE_SCAN);
+	}
 
 	err = ext4_mb_init(sb);
 	if (err) {
-- 
2.27.0

