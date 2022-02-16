Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FC84B824C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 08:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiBPHwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 02:52:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiBPHwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:52:11 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5050199D66;
        Tue, 15 Feb 2022 23:51:51 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21G6gMF6026170;
        Wed, 16 Feb 2022 07:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=btNZXY3xxivb+OrNznhfAD3oDtbupGNk5Hd6K3mKbNs=;
 b=FUOcuBciKRCMXR8EM//X/s6c3vHnhAcN2Vg0aYPYDyBoaSsCUfBmRADRjWeSqJRhLFO6
 jM5WxxPGFfmaxz1FUXaLcVhx28acP0Epz69sFf6O28tW0uoxQEpK7FNMn33Hj9Rzjic8
 Tim8kfQyPreQrXaGd2vbl5ZN8a8lCJnw6iK+Ms1xTNFKvCl+/1ZHvxjvo6Z8s8J9l398
 oN34qhJnnpgAq7DsJDKzix9j5rTsHEAEnCwnFrrXFU+tphQFppabh5ICYTtp5DPV4Obx
 OaWxLia1EuAND3krOrCYJhhrSiLh0iqCMhRva+COrXYjjKqwzWDtS75iXay1W52xSDmR Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8v7m8bpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:03:02 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21G6jWcL005407;
        Wed, 16 Feb 2022 07:03:02 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8v7m8bnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:03:01 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21G72cGf021835;
        Wed, 16 Feb 2022 07:02:59 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3e64h9v18j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:02:59 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21G72usB40042812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 07:02:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF9D552063;
        Wed, 16 Feb 2022 07:02:56 +0000 (GMT)
Received: from localhost (unknown [9.43.85.173])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 424EE5204E;
        Wed, 16 Feb 2022 07:02:56 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 0/9] ext4: fast_commit fixes, stricter block checking & cleanups
Date:   Wed, 16 Feb 2022 12:32:42 +0530
Message-Id: <cover.1644992609.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CfvKUO41AtNlxfmBFLu-lZ3A3XerL9ZQ
X-Proofpoint-GUID: 74BZf4gZpVEiuDbX1E66X0yWveCSK8GZ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_02,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1011 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160038
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

Please find the v2 of this patch series which addresses the review comments from
Jan on PATCH-2 & PATCH-7. No changes other than that.

Summary
========
This patch series aimes at fixing some of the issues identified in fast_commit
with flex_bg. This also adds some stricter checking of blocks to be freed in
ext4_mb_clear_bb(), ext4_group_add_blocks() & ext4_mb_mark_bb()

Testing
=========
I have run xfstests with -g log,metadata,auto group with 4k & 4k_fc
configs. I have not found any regression due to these patches alone.

But I have found few issues like generic/047 occasionally failing even w/o this
patch series. I do have some fixes for those too in my tree. I will send those
fixes later after figuring out few more things around couple other failures.


References
===========
[v1]: https://lore.kernel.org/all/cover.1644062450.git.riteshh@linux.ibm.com/
[RFC]: https://lore.kernel.org/all/a9770b46522c03989bdd96f63f7d0bfb2cf499ab.1643642105.git.riteshh@linux.ibm.com/

Ritesh Harjani (9):
  ext4: Correct cluster len and clusters changed accounting in ext4_mb_mark_bb
  ext4: Fixes ext4_mb_mark_bb() with flex_bg with fast_commit
  ext4: Refactor ext4_free_blocks() to pull out ext4_mb_clear_bb()
  ext4: Use in_range() for range checking in ext4_fc_replay_check_excluded
  ext4: Rename ext4_set_bits to mb_set_bits
  ext4: No need to test for block bitmap bits in ext4_mb_mark_bb()
  ext4: Add ext4_sb_block_valid() refactored out of ext4_inode_block_valid()
  ext4: Add strict range checks while freeing blocks
  ext4: Add extra check in ext4_mb_mark_bb() to prevent against possible corruption

 fs/ext4/block_validity.c |  26 +--
 fs/ext4/ext4.h           |   5 +-
 fs/ext4/fast_commit.c    |   4 +-
 fs/ext4/mballoc.c        | 342 ++++++++++++++++++++++-----------------
 fs/ext4/resize.c         |   4 +-
 5 files changed, 220 insertions(+), 161 deletions(-)

--
2.31.1

