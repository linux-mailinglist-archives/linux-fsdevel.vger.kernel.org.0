Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B2B7BB9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 10:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfGaIZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 04:25:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59498 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfGaIZi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:25:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6V8O2rn081021;
        Wed, 31 Jul 2019 08:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=VzY9DtvcuYA0baJP6t/Benjg0AjHRQ2iCGpw97K47d4=;
 b=rVzjxOKLZYfncMJWM6YjSqp66vZz7Im9L9AWAq0M/1J1TSTOCQjdkPZzvqksQg3BDtbc
 nJsPa1E/SBHFmxcYmm+DS/oSaFMoyfQkqq1klkdzSBL5QD1IVniDBMrK86fNeeXZo+I1
 MitK1+U2rUnN19Eov28HOCs3UZlSsOhNkOqlY3KuHdLOTWWbkka9MGyly9Vq5PU9dtYQ
 p26QpaXYxH5xVxroX5K584wyuVmBcUCjaRQNIgaiNxa98T+sflxQUcwIuMYOjE1cUvLQ
 ZmWqK0OmFnRW9b+xFwvmN2euQ+jfySlnKzjDA5SjCE4REh0uQD83bVEuxTvwL4/w3UYt zw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2u0ejpkkuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 08:25:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6V8Mu9M055712;
        Wed, 31 Jul 2019 08:25:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2u2exbbmha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 08:25:22 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6V8PJ4X004270;
        Wed, 31 Jul 2019 08:25:19 GMT
Received: from localhost.localdomain (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Jul 2019 01:25:19 -0700
From:   William Kucharski <william.kucharski@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 0/2] mm,thp: Add filemap_huge_fault() for THP
Date:   Wed, 31 Jul 2019 02:25:11 -0600
Message-Id: <20190731082513.16957-1-william.kucharski@oracle.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=820
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907310090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=874 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907310090
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This set of patches is the first step towards a mechanism for automatically
mapping read-only text areas of appropriate size and alignment to THPs
whenever possible.

For now, the central routine, filemap_huge_fault(), amd various support
routines are only included if the experimental kernel configuration option

	RO_EXEC_FILEMAP_HUGE_FAULT_THP

is enabled.

This is because filemap_huge_fault() is dependent upon the
address_space_operations vector readpage() pointing to a routine that will
read and fill an entire large page at a time without poulluting the page
cache with PAGESIZE entries for the large page being mapped or performing
readahead that would pollute the page cache entries for succeeding large
pages. Unfortunately, there is no good way to determine how many bytes
were read by readpage(). At present, if filemap_huge_fault() were to call
a conventional readpage() routine, it would only fill the first PAGESIZE
bytes of the large page, which is definitely NOT the desired behavior.

However, by making the code available now it is hoped that filesystem
maintainers who have pledged to provide such a mechanism will do so more
rapidly.

The first part of the patch adds an order field to __page_cache_alloc(),
allowing callers to directly request page cache pages of various sizes.
This code was provided by Matthew Wilcox.

The second part of the patch implements the filemap_huge_fault() mechanism
as described above.

Changes since v2:
1. FGP changes were pulled out to enable submission as an independent
   patch
2. Inadvertent tab spacing and comment changes were reverted

Changes since v1:
1. Fix improperly generated patch for v1 PATCH 1/2

Matthew Wilcox (1):
  mm: Allow the page cache to allocate large pages

William Kucharski (1):
  Add filemap_huge_fault() to attempt to satisfy page faults on
    memory-mapped read-only text pages using THP when possible.

 fs/afs/dir.c            |   2 +-
 fs/btrfs/compression.c  |   2 +-
 fs/cachefiles/rdwr.c    |   4 +-
 fs/ceph/addr.c          |   2 +-
 fs/ceph/file.c          |   2 +-
 include/linux/huge_mm.h |  16 +-
 include/linux/mm.h      |   6 +
 include/linux/pagemap.h |  10 +-
 mm/Kconfig              |  15 ++
 mm/filemap.c            | 320 ++++++++++++++++++++++++++++++++++++++--
 mm/huge_memory.c        |   3 +
 mm/mmap.c               |  36 ++++-
 mm/readahead.c          |   2 +-
 mm/rmap.c               |   8 +
 net/ceph/pagelist.c     |   4 +-
 net/ceph/pagevec.c      |   2 +-
 16 files changed, 401 insertions(+), 33 deletions(-)

-- 
2.21.0

