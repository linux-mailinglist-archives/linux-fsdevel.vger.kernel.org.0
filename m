Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A08FD89DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 09:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbfJPHhY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 03:37:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbfJPHhX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:37:23 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9G7bAdw081770
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 03:37:23 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vnx1u2303-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 03:37:22 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 16 Oct 2019 08:37:20 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Oct 2019 08:37:17 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9G7bGjx42926300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 07:37:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12729AE04D;
        Wed, 16 Oct 2019 07:37:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80811AE05D;
        Wed, 16 Oct 2019 07:37:14 +0000 (GMT)
Received: from dhcp-9-199-158-105.in.ibm.com (unknown [9.199.158.105])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Oct 2019 07:37:14 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     tytso@mit.edu, jack@suse.cz, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org,
        riteshh@linux.ibm.com
Subject: [RFC 0/5] Ext4: Add support for blocksize < pagesize for dioread_nolock
Date:   Wed, 16 Oct 2019 13:07:06 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101607-0012-0000-0000-000003587C9A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101607-0013-0000-0000-0000219394D2
Message-Id: <20191016073711.4141-1-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=549 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160071
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series adds the support for blocksize < pagesize for
dioread_nolock feature.

Since in case of blocksize < pagesize, we can have multiple
small buffers of page as unwritten extents, we need to
maintain a vector of these unwritten extents which needs
the conversion after the IO is complete. Thus, we maintain
a list of tuple <offset, size> pair (io_end_vec) for this &
traverse this list to do the unwritten to written conversion.

Appreciate any reviews/comments on this patches.

Tests completed
===============

All (which also passes in default config) "quick" group xfstests
are passing. Tested xfstests with below configurations.
	dioread_nolock with blocksize < pagesize
	dioread_nolock with blocksize == pagesize
	without dioread_nolock with blocksize < pagesize
	without dioread_nolock with blocksize == pagesize
ltp/fsx test with multiple iterations of 1 million ops
did not show any error.


About patches
=============

Patch 1 - 3: These are some cleanup and refactoring patches.
Patch 4: This patch adds the required support.
Patch 5: This patch removes the checks which was not allowing to mount
with dioread_nolock when blocksize != pagesize was true.

_Patches can be cleanly applied on today's linus tree master branch_

Ritesh Harjani (5):
  ext4: keep uniform naming convention for io & io_end variables
  ext4: Add API to bring in support for unwritten io_end_vec conversion
  ext4: Refactor mpage_map_and_submit_buffers function
  ext4: Add support for blocksize < pagesize in dioread_nolock
  ext4: Enable blocksize < pagesize for dioread_nolock

 fs/ext4/ext4.h    |  13 ++++-
 fs/ext4/extents.c |  49 ++++++++++++-----
 fs/ext4/inode.c   | 136 ++++++++++++++++++++++++++++++----------------
 fs/ext4/page-io.c | 110 ++++++++++++++++++++++++-------------
 fs/ext4/super.c   |  10 ----
 5 files changed, 208 insertions(+), 110 deletions(-)

-- 
2.21.0

