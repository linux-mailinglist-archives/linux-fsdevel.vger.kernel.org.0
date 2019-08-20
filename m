Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADBC95F71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 15:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfHTNG6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 09:06:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728731AbfHTNG6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:06:58 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KD6VRV015432
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2019 09:06:56 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ughf4r0xy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2019 09:06:56 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 20 Aug 2019 14:06:54 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 20 Aug 2019 14:06:50 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7KD6nka26870016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 13:06:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B26DB11C064;
        Tue, 20 Aug 2019 13:06:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EAA111C05B;
        Tue, 20 Aug 2019 13:06:48 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.31.57])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Aug 2019 13:06:48 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, jack@suse.cz, tytso@mit.edu,
        mbobrowski@mbobrowski.org, linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 0/2] ext4: bmap & fiemap conversion to use iomap
Date:   Tue, 20 Aug 2019 18:36:32 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19082013-0012-0000-0000-00000340B5D6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082013-0013-0000-0000-0000217ADA00
Message-Id: <20190820130634.25954-1-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=642 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200137
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

These are RFC patches to get community view on converting
ext4 bmap & fiemap to iomap infrastructure. This reduces the users
of ext4_get_block API and thus a step towards getting rid of
buffer_heads from ext4. Also reduces the line of code by making
use of iomap infrastructure (ex4_iomap_begin) which is already
used for other operations.

This gets rid of special implementation of ext4_fill_fiemap_extents
& ext4_find_delayed_extent and thus only relies upon ext4_map_blocks
& iomap_fiemap (ext4_iomap_begin) for mapping. It looked more logical
thing to do, but I appreciate if anyone has any review/feedback
comments about this part.

Didn't get any regression on some basic xfstests in tests/ext4/
with mkfs option of "-b 4096". Please let me know if I should also test
any special configurations?

Patches can be cleanly applied over Linux 5.3-rc5.


Ritesh Harjani (2):
  ext4: Move ext4 bmap to use iomap infrastructure.
  ext4: Move ext4_fiemap to iomap infrastructure

 fs/ext4/extents.c | 294 +++++++---------------------------------------
 fs/ext4/inline.c  |  41 -------
 fs/ext4/inode.c   |  17 ++-
 3 files changed, 53 insertions(+), 299 deletions(-)

-- 
2.21.0

