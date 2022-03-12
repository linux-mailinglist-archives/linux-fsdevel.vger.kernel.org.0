Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2524D6CCB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 06:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiCLFlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 00:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiCLFlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 00:41:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD226DF96;
        Fri, 11 Mar 2022 21:40:15 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22C4UrA8016270;
        Sat, 12 Mar 2022 05:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=S0udOomX7A88+HjlEFeYaF2egh+u3+xiQssjMYUyDGA=;
 b=qy5tjCjPp6yNWYgKjGSqOgvxOyqitwW2xnigHVlRLyY3in1cwBMYgXY+DPjTc9NUoN1Q
 cB5ayHeNv3xvR2jdq+96SAbkDM6hhgjxRCCqTevOm0LMO2M9G5OuqNtPNm0wCyUZVit6
 4smDZjvWXg+iwWqXub8zy5nVv4T0+7Fz4IL8hwH3Ww69GNMDzB53Tma/gpxUF0RVibkj
 x4itsAPU2fc8JlDK5p6TvNbLrLwlVbOHBwBwkJKKVNCdNMA7wVkLmBZIQDx2/eKxL1nJ
 +oea2HXEqFtdI9XGQPj+MZCWZUAf20OWITCbtY3CfJllWMDVKOM0ljLmbmVVqP0N6QXx 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ermgn0s5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:11 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22C5YM6f031120;
        Sat, 12 Mar 2022 05:40:11 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ermgn0s4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:11 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22C5U1CV027864;
        Sat, 12 Mar 2022 05:40:09 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3erk58g62h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22C5SnOW49217810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 05:28:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 886224203F;
        Sat, 12 Mar 2022 05:40:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B0A24204F;
        Sat, 12 Mar 2022 05:40:06 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 12 Mar 2022 05:40:05 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 00/10] ext4: Improve FC trace events
Date:   Sat, 12 Mar 2022 11:09:45 +0530
Message-Id: <cover.1647057583.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VRyKI5qIedx3W-3YIqNHe8zexIL0u_gb
X-Proofpoint-ORIG-GUID: YNhC12IspoN2pNp0RQ4j8OA7jOXWTRcL
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-12_02,2022-03-11_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=584 bulkscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203120030
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

Please find the v3 of this patch series. I have included Reviewed-by tag
on all patches, except in [5-7] which were later added to address review
comments from Jan [1].

Changes since v2
================
v2 -> v3
1. Defined TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX) in [Patch 02/10]


Changes since RFC
================
RFC -> v2
1. Added new patch-5 ("ext4: Return early for non-eligible fast_commit track events")
2. Removed a trace event in ext4_fc_track_template() (which was added in RFC)
   from patch-6 and added patch-7 to add the tid info in callers of
   ext4_fc_track_template(). (As per review comments from Jan)


Testing
=========
Tested this with xfstests -g "quick"

Thanks again to Jan, Harshad for helping with reviews and Steve for helping with
TRACE_DEFINE_ENUM part in kernel trace events.


[RFC]: https://lore.kernel.org/linux-ext4/cover.1645558375.git.riteshh@linux.ibm.com/
[v2]: https://lore.kernel.org/linux-ext4/cover.1646922487.git.riteshh@linux.ibm.com/
[1]: https://lore.kernel.org/linux-ext4/20220223115313.3s73bu7p454bodvl@quack3.lan/

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
 include/trace/events/ext4.h | 298 +++++++++++++++++++++++-------------
 3 files changed, 258 insertions(+), 136 deletions(-)

--
2.31.1

