Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A244AA947
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 15:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380080AbiBEOKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 09:10:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239567AbiBEOKO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 09:10:14 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 215BS81r026407;
        Sat, 5 Feb 2022 14:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=bc/h4F7BvpNu68Vq90rz47Cw3bkhinbHD+/KbJlV7/o=;
 b=JVOi+v8DNWoWiPIAErhTk4PG5ogNZMf1VEMHSKre54I/AQFb8AxtKUZmh60a5AsH14rP
 EwTI99c/0l3I17CU/9OETn8+RJwZfoqt01GdL5Iz7mvG+THbAkKNlDh5r+JbF0IbjoHY
 fgB3zd11sX/IBuK88bc/BhgySewV6fCDI2Ncv44g4vHqcl/SlQGysiFhfDWE9+aSjg1e
 qJKOrjH17GNonsXUd2C4sF7Hx5eZ/njPT2AqAwZhLfgWjZqDsIcgGXJH+IWKagEJXboF
 XgyQAhdbRxhHary1XNOpcUzfWM4Ip8yCkPYaiSheOyK5lGVWzWRpEHrcs3iejpJHXeZv Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1j7merad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:10 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 215E2HKX030475;
        Sat, 5 Feb 2022 14:10:10 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1j7mera1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:09 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 215E3jhn015562;
        Sat, 5 Feb 2022 14:10:07 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3e1gv9j1a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:07 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 215EA3ko32833854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 14:10:03 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72D81A4060;
        Sat,  5 Feb 2022 14:10:03 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C061A4064;
        Sat,  5 Feb 2022 14:10:02 +0000 (GMT)
Received: from localhost (unknown [9.43.12.205])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  5 Feb 2022 14:10:01 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv1 0/9] ext4: fast_commit fixes, stricter block checking & cleanups
Date:   Sat,  5 Feb 2022 19:39:49 +0530
Message-Id: <cover.1644062450.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fw3Dru_MgA7xikbrtIYkvjyL_XqMCKIJ
X-Proofpoint-GUID: t5r66ciS1VKY2vZfU1GRoZ0dKCy4CxJP
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-05_10,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202050095
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Please find v1 of this patch series aimed at fixing some of the issues
identified in fast_commit. This also adds some stricter checking of
blocks to be freed in ext4_mb_clear_bb(), ext4_group_add_blocks() &
ext4_mb_mark_bb().

I have tested this with few different fast_commit configs and normal 4k config
with -g log,quick. Haven't seen any surprises there.

RFC -> v1:
==========
1. Added Patch-1 which correctly accounts for flex_bg->free_clusters.
2. Addressed review comments from Jan
3. Might have changed the order of patches a bit.

[RFC] - https://lore.kernel.org/all/a9770b46522c03989bdd96f63f7d0bfb2cf499ab.1643642105.git.riteshh@linux.ibm.com/


Ritesh Harjani (9):
  ext4: Correct cluster len and clusters changed accounting in ext4_mb_mark_bb
  ext4: Fixes ext4_mb_mark_bb() with flex_bg with fast_commit
  ext4: Refactor ext4_free_blocks() to pull out ext4_mb_clear_bb()
  ext4: Use in_range() for range checking in ext4_fc_replay_check_excluded
  ext4: Rename ext4_set_bits to mb_set_bits
  ext4: No need to test for block bitmap bits in ext4_mb_mark_bb()
  ext4: Add ext4_sb_block_valid() refactored out of ext4_inode_block_valid()
  ext4: Add strict range checks while freeing blocks
  ext4: Add extra check in ext4_mb_mark_bb() to prevent against possible
    corruption

 fs/ext4/block_validity.c |  25 +--
 fs/ext4/ext4.h           |   5 +-
 fs/ext4/fast_commit.c    |   4 +-
 fs/ext4/mballoc.c        | 342 ++++++++++++++++++++++-----------------
 fs/ext4/resize.c         |   4 +-
 5 files changed, 219 insertions(+), 161 deletions(-)

--
2.31.1

