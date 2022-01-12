Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EB848C632
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 15:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354190AbiALOlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 09:41:35 -0500
Received: from mr85p00im-zteg06011501.me.com ([17.58.23.182]:38906 "EHLO
        mr85p00im-zteg06011501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354168AbiALOla (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1641998159; bh=EWWKfVgilmC0dqI8sxvVo3je/AQaM8kMo+v7DmfXU00=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Je5Lm8EjmqsJhqCI++fd103kq7VPZDZ+YPDbDkSjVlZSt749VicwpgwcX4l+UmXPK
         xb1uWvZ791Egu3O7WXd/688yZd7hcMaKvG/tBMkxxmljYt3ZBB+l/hMXLERDdlTt8C
         5PiCZ214TdXRtPN37VMguGsmk67PXMG2qEiXGD+33sTzuJBBbwxAjlVfbLGwUYMMIt
         nX0sdAoSrgZUuB/uPnwI0iSgGYELEv9YAJaPPI57Uq5GcIl9dLu/CSK+XwtcZqGuTo
         zdGWanQ/AbNKox2JWhHyyfWhO60zdhTnVZA237upp0G7w6WZflVZOt4lZZ0MapNjbp
         ciSGIHHOYW3ZQ==
Received: from xiongwei.. (unknown [120.245.2.88])
        by mr85p00im-zteg06011501.me.com (Postfix) with ESMTPSA id BE46E480EFF;
        Wed, 12 Jan 2022 14:35:40 +0000 (UTC)
From:   sxwjean@me.com
To:     akpm@linux-foundation.org, david@redhat.com, mhocko@suse.com,
        dan.j.williams@intel.com, osalvador@suse.de,
        naoya.horiguchi@nec.com, thunder.leizhen@huawei.com
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH v3 0/2] Add support for getting page info of ZONE_DEVICE by /proc/kpage*
Date:   Wed, 12 Jan 2022 22:35:15 +0800
Message-Id: <20220112143517.262143-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F04:2022-01-11=5F01,2022-01-12=5F04,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=528 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2201120095
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

Patch 1 is adding pfn_to_devmap_page() function to get page of ZONE_DEVICE
by pfn. It checks if dev_pagemap is valid, if yes, return page pointer.

Patch 2 is finishing supporting /proc/kpage* in exposing pages info of
ZONE_DEVICE to userspace.

The unit test has been done by "page-types -r", which ran in qemu with the
below arguments:
    -object memory-backend-file,id=mem2,share,mem-path=./virtio_pmem.img,size=2G
    -device virtio-pmem-pci,memdev=mem2,id=nv1
, which is used to emulate pmem device with 2G memory space.

As we know, the pages in ZONE_DEVICE are only set PG_reserved flag. So
before the serires,
	run "page-types -r", the result is:
	             flags      page-count       MB  symbolic-flags                     long-symbolic-flags
	0x0000000100000000           24377       95  ___________________________r________________       reserved
	, which means the only PG_reserved set of pages in system wide have 24377.
	
	run "cat /proc/zoneinfo" to get the ZONE_DEVICE info:
	Node 1, zone   Device
	    pages free     0
	    boost    0
	    min      0
	    low      0
	    high     0
	    spanned  0
	    present  0
	    managed  0
	    cma      0
	    protection: (0, 0, 0, 0, 0)

After this series,
	run "page-types -r", the result is:
	             flags      page-count       MB  symbolic-flags                     long-symbolic-flags
	0x0000000100000000          548665     2143  ___________________________r________________       reserved
	, which means the only PG_reserved set of pages in system wide have 548665.
	
	Run "cat /proc/zoneinfo" to get the ZONE_DEVICE info:
	Node 1, zone   Device
	pages free     0
	    boost    0
	    min      0
	    low      0
	    high     0
	    spanned  524288
	    present  0
	    managed  0
	    cma      0
	    protection: (0, 0, 0, 0, 0)

, these added pages number is 524288 in ZONE_DEVICE as spanned field
showed. Meanwhile, we can do 548665 - 24377 = 524288 that is increment
of the reserved pages, it equals to the spanned field of ZONE_DEVICE.
Hence it looks like the patchset works well.

v2 -> v3:
  * Before returning page pointer, check validity of page by
    pgmap_pfn_valid(). https://lkml.org/lkml/2022/1/10/853 .

v1 -> v2:
  * Take David's suggestion to simplify the implementation of
    pfn_to_devmap_page(). Please take a look at
    https://lkml.org/lkml/2022/1/10/320 .

Xiongwei Song (2):
  mm/memremap.c: Add pfn_to_devmap_page() to get page in ZONE_DEVICE
  proc: Add getting pages info of ZONE_DEVICE support

 fs/proc/page.c           | 35 ++++++++++++++++++++-------------
 include/linux/memremap.h |  8 ++++++++
 mm/memremap.c            | 42 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 13 deletions(-)

-- 
2.30.2

