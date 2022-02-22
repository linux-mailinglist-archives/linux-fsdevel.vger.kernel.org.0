Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41534C0309
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 21:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbiBVUfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 15:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiBVUfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:35:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC40878042;
        Tue, 22 Feb 2022 12:34:37 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MItHh0008673;
        Tue, 22 Feb 2022 20:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=hMea9uduwb9bjCvLXXOBoz4/k4QC2MrrWULG7C7iOlI=;
 b=KrTwCpKuGDuBCvg1X1WlSVSWbmLeeB7pxpcQdiO2UYF3RvoTpXcXLLdpGLEDlzfDliGQ
 LWPIiXBJawU9EZngtSyBjMTnt7lAkOYta9moHH8oVO/6k3qGJeGYrfyqlDBZgIR9Xu9G
 jp7tEOU+PAFcM81ndF4rlXzRrf8oULs9p2VmPsdR6KYIv1bqNbi6XI2IugX/lInmqlc7
 EbakhB7H7wcbm3iKyEZlKlnz2ZDOwOnmHpBAVwXN7CPh8XZpSSZ24PydQLj7OKrpAwgA
 AhaAxMNOutmlxeF3vGmEa+hCloscL/yMHb3ftLU5Sr61ylksNotiVUnbSOMw0Dx3hvQk jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed34ueetv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:34:33 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21MJFD3h014896;
        Tue, 22 Feb 2022 20:34:32 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed34ueet0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:34:32 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21MKJBnu014899;
        Tue, 22 Feb 2022 20:34:30 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3ear694chk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:34:29 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21MKYRn350069924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 20:34:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5898C42041;
        Tue, 22 Feb 2022 20:34:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFD024203F;
        Tue, 22 Feb 2022 20:34:24 +0000 (GMT)
Received: from localhost (unknown [9.43.75.136])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Feb 2022 20:34:24 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 0/9] ext4: Improve FC trace events and discuss one FC failure
Date:   Wed, 23 Feb 2022 02:04:08 +0530
Message-Id: <cover.1645558375.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GrsoOnylZi7RJx6GrBZcsCmyEdgZZ3Di
X-Proofpoint-ORIG-GUID: YCuYLMcRtreZgTdQ4L7cqH1iRhui65Oz
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_07,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=727 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202220126
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

Sending this RFC out for getting some review comments/suggestions on the
problem listed in this cover letter. It would be helpful if someone has any
pointers around these.

1. Patch-2 fixes the problem reported by Steven about dereferencing pointers from
   the ring buffer [1].
	One of the problem in this patch which I might need some help is, how to
	expose EXT4_FC_REASON_MAX enum for
	+	__array(unsigned int, fc_ineligible_rc, EXT4_FC_REASON_MAX)

	My observation is that this trace_event is correctly printing the array
	values when called from cat /sys/kernel/debug/tracing/trace_pipe.

	But when I am using perf record -e ext4:ext4_fc_stats to record these trace
	events, I am seeing the array values to be all 0.

	Do you know what will be the right and easy way to fix above, so that this works
	properly for perf tools too? And we should be able to backport this too.

2. Patch-9 discusses one of the problem where FC might miss to track/commit
   inode's update. This also needs some discussion. I have added my observations
   on the commit log of patch-9 itself.

3. Remaining are FC trace event improvement patches, which I found useful while
   debugging some of the recent fast_commit issues.

Also a careful review of patches is always helpful :)


[1]: https://lore.kernel.org/linux-ext4/20220221160916.333e6491@rorschach.local.home/T/#u

Ritesh Harjani (9):
  ext4: Remove unused enum EXT4_FC_COMMIT_FAILED
  ext4: Fix ext4_fc_stats trace point
  ext4: Add couple of more fast_commit tracepoints
  ext4: Do not call FC trace event if FS does not support FC
  ext4: Add commit_tid info in jbd debug log
  ext4: Add commit tid info in ext4_fc_commit_start/stop trace events
  ext4: Fix remaining two trace events to use same printk convention
  ext4: Convert ext4_fc_track_dentry type events to use event class
  ext4: fast_commit missing tracking updates to a file

 fs/ext4/fast_commit.c       |  30 +++--
 fs/ext4/fast_commit.h       |   1 -
 include/trace/events/ext4.h | 229 +++++++++++++++++++++++++-----------
 3 files changed, 182 insertions(+), 78 deletions(-)

--
2.31.1

