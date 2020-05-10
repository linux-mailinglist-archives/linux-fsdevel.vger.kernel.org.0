Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EA11CC724
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 08:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgEJGZa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 02:25:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54744 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725779AbgEJGZa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 02:25:30 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04A62Asl074332;
        Sun, 10 May 2020 02:25:23 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30xa4gab5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 02:25:23 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04A6K077003362;
        Sun, 10 May 2020 06:25:22 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 30wm55a12q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 06:25:21 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04A6PJGb61997502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 06:25:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF11042042;
        Sun, 10 May 2020 06:25:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B7484203F;
        Sun, 10 May 2020 06:25:17 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.61.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 May 2020 06:25:17 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 00/16] ext4: mballoc/extents: Code cleanup and debug improvements
Date:   Sun, 10 May 2020 11:54:40 +0530
Message-Id: <cover.1589086800.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_01:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 suspectscore=3 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005100050
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello All,

This series does some code refactoring/cleanups and debug logs improvements
around mb_debug() and ext_debug(). These were found when working over
improving mballoc ENOSPC handling in ext4.
These should be small and stright forward patches for reviewing.

Ritesh Harjani (16):
  ext4: mballoc: Do print bb_free info even when it is 0
  ext4: mballoc: Refactor ext4_mb_show_ac()
  ext4: mballoc: Add more mb_debug() msgs
  ext4: mballoc: Correct the mb_debug() format specifier for pa_len var
  ext4: mballoc: Fix few other format specifier in mb_debug()
  ext4: mballoc: Simplify error handling in ext4_init_mballoc()
  ext4: mballoc: Make ext4_mb_use_preallocated() return type as bool
  ext4: mballoc: Refactor code inside DOUBLE_CHECK into separate function
  ext4: mballoc: Fix possible NULL ptr & remove BUG_ONs from DOUBLE_CHECK
  ext4: balloc: Use task_pid_nr() helper
  ext4: Use BIT() macro for BH_** state bits
  ext4: Improve ext_debug() msg in case of block allocation failure
  ext4: Replace EXT_DEBUG with __maybe_unused in ext4_ext_handle_unwritten_extents()
  ext4: mballoc: Make mb_debug() implementation to use pr_debug()
  ext4: Make ext_debug() implementation to use pr_debug()
  ext4: Add process name and pid in ext4_msg()

 fs/ext4/Kconfig   |   3 +-
 fs/ext4/balloc.c  |   5 +-
 fs/ext4/ext4.h    |  26 +++--
 fs/ext4/extents.c | 150 +++++++++++++-------------
 fs/ext4/inode.c   |  15 +--
 fs/ext4/mballoc.c | 265 ++++++++++++++++++++++++++--------------------
 fs/ext4/mballoc.h |  16 ++-
 fs/ext4/super.c   |   3 +-
 8 files changed, 261 insertions(+), 222 deletions(-)

-- 
2.21.0

