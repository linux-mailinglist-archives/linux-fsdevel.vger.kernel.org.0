Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DEB4D4DED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 17:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbiCJQBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 11:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239805AbiCJQAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:00:54 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0CE184636;
        Thu, 10 Mar 2022 07:59:52 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22AFeApK021863;
        Thu, 10 Mar 2022 15:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=CP0U+j6h4uZqGjLy0jQWcXoqaVQquNBOxqL4TXvRt9g=;
 b=CG//XyovQ5WlIuNJx+0PTPQ4u7oJJdFBoa4+DvpVR9/jVJDbvTDQsxFDPW7S++nxswGj
 I449EjNKuhIAndZJwkrtCefxKsslWK+BGzKH7HJ09nF/9k9Lo/xvE7ulvcEpS6EwQzkK
 k4FU4w1iGp2lOWTR3I5hiWa8AAn78CixsV/Ul2nbp7r3YNydD3oJba9kA/HwS8vo1JFp
 hVGRcrhZzNwJBPscQa76fdEPwJKfOGSW3DmnbUIcItlks/agaFdNU8N9l9zYVLfp9VTp
 1bLTnXCyK+AudR9RFcQ64H1F6tfwbVFGPng+vZp8X1QJtIhUtegm6MFx5zzA8cY/i78C CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqg9rxp4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:31 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22ADTwhn013695;
        Thu, 10 Mar 2022 15:59:31 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqg9rxp4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:31 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22AFvLpA022398;
        Thu, 10 Mar 2022 15:59:29 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3eky4j55m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:29 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22AFxR8A13763068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 15:59:27 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B78EA406F;
        Thu, 10 Mar 2022 15:59:27 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB1C8A4054;
        Thu, 10 Mar 2022 15:59:26 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Mar 2022 15:59:26 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCHv2 00/10] ext4: Improve FC trace events
Date:   Thu, 10 Mar 2022 21:28:54 +0530
Message-Id: <cover.1646922487.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8SAM30P4rlt-HXmkFXrCoeUBzub8hXjX
X-Proofpoint-ORIG-GUID: C5Y7M0ic7wovz2_omucnyhbpSEUsiV-V
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_06,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=837 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
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

Hello,

Please find the v2 of this patch series.

Note:- I still couldn't figure out how to expose EXT4_FC_REASON_MAX in patch-2
which (I think) might be (only) needed by trace-cmd or perf record for trace_ext4_fc_stats.
But it seems "cat /sys/kernel/debug/tracing/trace_pipe" gives the right output
for ext4_fc_stats trace event (as shown below).

So with above reasoning, do you think we should take these patches in?
And we can later see how to provide EXT4_FC_REASON_MAX definition available to
libtraceevent?

Either ways, please let me know your opinion around this.

<output of cat /sys/kernel/debug/tracing/trace_pipe> (shows FALLOC_RANGE:5)
=====================================================
jbd2/loop2-8-2219    [000] .....  1883.771539: ext4_fc_stats: dev 7,2 fc ineligible reasons:
XATTR:0, CROSS_RENAME:0, JOURNAL_FLAG_CHANGE:0, NO_MEM:0, SWAP_BOOT:0, RESIZE:0, RENAME_DIR:0, FALLOC_RANGE:5, INODE_JOURNAL_DATA:0 num_commits:22, ineligible: 4, numblks: 22


Changes since RFC
================
RFC -> v2
1. Added new patch-5 ("ext4: Return early for non-eligible fast_commit track events")
2. Removed a trace event in ext4_fc_track_template() (which was added in RFC)
   from patch-6 and added patch-7 to add the tid info in callers of
   ext4_fc_track_template(). (As per review comments from Jan)

Tested this with xfstests -g "quick"


[RFC]: https://lore.kernel.org/linux-ext4/cover.1645558375.git.riteshh@linux.ibm.com/

Ritesh Harjani (10):
  ext4: Remove unused enum EXT4_FC_COMMIT_FAILED
  ext4: Fix ext4_fc_stats trace point
  ext4: Convert ext4_fc_track_dentry type events to use event class
  ext4: Do not call FC trace event in ext4_fc_commit() if FS does not support FC
  ext4: Return early for non-eligible fast_commit track events
  ext4: Add new trace event in ext4_fc_cleanup
  ext4: Add transaction tid info in fc_track events
  ext4: Add commit_tid info in jbd debug log
  ext4: Add commit tid info in ext4_fc_commit_start/stop trace events
  ext4: Fix remaining two trace events to use same printk convention

 fs/ext4/fast_commit.c       |  95 ++++++++----
 fs/ext4/fast_commit.h       |   1 -
 include/trace/events/ext4.h | 297 +++++++++++++++++++++++-------------
 3 files changed, 257 insertions(+), 136 deletions(-)

Cc: Steven Rostedt <rostedt@goodmis.org>

--
2.31.1

