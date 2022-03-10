Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0094C4D4DF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 17:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239810AbiCJQA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 11:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239628AbiCJQAr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:00:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208F21662F3;
        Thu, 10 Mar 2022 07:59:46 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22AEEVPf019181;
        Thu, 10 Mar 2022 15:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0F2FOwExd2Ea4ovVYWwwmkVaqju6DMGNME9jECMU+B8=;
 b=ktUb8O8bfsvTW2xMEudlMuscAD9a3ngTkR2o4tuZKdZdPNZAK0cVXz0Zf7/X/RS/L8H9
 Un274WNyIXJHrpbk5u/bmO9e6moqF8j9ufeZ1XpVHXQ2nqboLZsXE+jThr8sUkcBnT5x
 dHmxwy+/78DiYa69gKhj7pflMzqAMwBNcUfCHM7FefjfuyewZTXT6PTc6y9vF5lOV6rg
 fbbO4vzP4c5sNv64H0pCtGLkO7F5wTKbRGGij26hnnVZhr6RxaONdJD5oEt3YPRNkucs
 85ohY4l5HcYX8phGD+XmzidgxsdYU10pnk8eJVHO2fkHX5JziFA5y+s2Lw4y/YjQYEFw FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqjx0jk4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:40 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22AFB7Uj005663;
        Thu, 10 Mar 2022 15:59:40 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqjx0jk3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:40 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22AFwfqd013408;
        Thu, 10 Mar 2022 15:59:38 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3enpk2xpee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:37 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22AFxZqp38863348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 15:59:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98EE452057;
        Thu, 10 Mar 2022 15:59:35 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2DF285204E;
        Thu, 10 Mar 2022 15:59:34 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 05/10] ext4: Return early for non-eligible fast_commit track events
Date:   Thu, 10 Mar 2022 21:28:59 +0530
Message-Id: <3fefc1de1268303c02b2504295994203aa9fafef.1646922487.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1646922487.git.riteshh@linux.ibm.com>
References: <cover.1646922487.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8q68s0jJsJxa19vMP-Ijt60NN5_WQNIM
X-Proofpoint-GUID: AvHg04dtyZoWmalCikQCvIZO_uyS5_tQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_06,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 adultscore=0 mlxlogscore=776
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Currently ext4_fc_track_template() checks, whether the trace event
path belongs to replay or does sb has ineligible set, if yes it simply
returns. This patch pulls those checks before calling
ext4_fc_track_template() in the callers of ext4_fc_track_template().

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/fast_commit.c | 59 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 55d33f296cae..6990429daa0e 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -379,13 +379,6 @@ static int ext4_fc_track_template(
 	tid_t tid = 0;
 	int ret;
 
-	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
-	    (sbi->s_mount_state & EXT4_FC_REPLAY))
-		return -EOPNOTSUPP;
-
-	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
-		return -EINVAL;
-
 	tid = handle->h_transaction->t_tid;
 	mutex_lock(&ei->i_fc_lock);
 	if (tid == ei->i_sync_tid) {
@@ -499,7 +492,17 @@ void __ext4_fc_track_unlink(handle_t *handle,
 
 void ext4_fc_track_unlink(handle_t *handle, struct dentry *dentry)
 {
-	__ext4_fc_track_unlink(handle, d_inode(dentry), dentry);
+	struct inode *inode = d_inode(dentry);
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+
+	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
+	    (sbi->s_mount_state & EXT4_FC_REPLAY))
+		return;
+
+	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
+		return;
+
+	__ext4_fc_track_unlink(handle, inode, dentry);
 }
 
 void __ext4_fc_track_link(handle_t *handle,
@@ -518,7 +521,17 @@ void __ext4_fc_track_link(handle_t *handle,
 
 void ext4_fc_track_link(handle_t *handle, struct dentry *dentry)
 {
-	__ext4_fc_track_link(handle, d_inode(dentry), dentry);
+	struct inode *inode = d_inode(dentry);
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+
+	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
+	    (sbi->s_mount_state & EXT4_FC_REPLAY))
+		return;
+
+	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
+		return;
+
+	__ext4_fc_track_link(handle, inode, dentry);
 }
 
 void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
@@ -537,7 +550,17 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
 
 void ext4_fc_track_create(handle_t *handle, struct dentry *dentry)
 {
-	__ext4_fc_track_create(handle, d_inode(dentry), dentry);
+	struct inode *inode = d_inode(dentry);
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+
+	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
+	    (sbi->s_mount_state & EXT4_FC_REPLAY))
+		return;
+
+	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
+		return;
+
+	__ext4_fc_track_create(handle, inode, dentry);
 }
 
 /* __track_fn for inode tracking */
@@ -553,6 +576,7 @@ static int __track_inode(struct inode *inode, void *arg, bool update)
 
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 {
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	int ret;
 
 	if (S_ISDIR(inode->i_mode))
@@ -564,6 +588,13 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 		return;
 	}
 
+	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
+	    (sbi->s_mount_state & EXT4_FC_REPLAY))
+		return;
+
+	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
+		return;
+
 	ret = ext4_fc_track_template(handle, inode, __track_inode, NULL, 1);
 	trace_ext4_fc_track_inode(inode, ret);
 }
@@ -603,12 +634,20 @@ static int __track_range(struct inode *inode, void *arg, bool update)
 void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t start,
 			 ext4_lblk_t end)
 {
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct __track_range_args args;
 	int ret;
 
 	if (S_ISDIR(inode->i_mode))
 		return;
 
+	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
+	    (sbi->s_mount_state & EXT4_FC_REPLAY))
+		return;
+
+	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
+		return;
+
 	args.start = start;
 	args.end = end;
 
-- 
2.31.1

