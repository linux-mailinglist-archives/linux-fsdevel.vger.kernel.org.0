Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83E8488986
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jan 2022 14:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiAINPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jan 2022 08:15:19 -0500
Received: from pv50p00im-hyfv10011601.me.com ([17.58.6.43]:53294 "EHLO
        pv50p00im-hyfv10011601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233345AbiAINPR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jan 2022 08:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1641733538; bh=Pa3d1sSuEEMcS6MIUinhQIpzwlyMz3dkhDvMnS4GXFQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=nRtTdQOYVfyDUjIThebLuxCHdZIcoVH1/lBWyly41egO75IBXQHd2WQ1BGuvtpdZF
         OcyIoD2jV8E+7mWwvbQa7JZzJFMLvq5tB10GuEv8MBBvrosKFzGXDdYv2Oa9h9T2MY
         fmhnm2H2wsExB/j4MnhWJuEzCAGKTkK5RLMcaE9kh14xGHrnCWobmnKZVP6wwgmAz/
         1vsFw/XdZeYx6F4Jb2xRUEU6BIOMekA1FaL21J2trQ/NJFlcBD7NOv9hKnHPgmPsKt
         5IjBEdym8NMLB6kKgXyDvDyCOYAWvQelq0yRX/570fJxpnNCtPnP/ASit/MgxGOQ00
         WXOKGqYl5yfIg==
Received: from xiongwei.. (unknown [120.245.2.119])
        by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id D21CD96016F;
        Sun,  9 Jan 2022 13:05:33 +0000 (UTC)
From:   sxwjean@me.com
To:     akpm@linux-foundation.org, david@redhat.com, mhocko@suse.com,
        dan.j.williams@intel.com, osalvador@suse.de,
        naoya.horiguchi@nec.com, thunder.leizhen@huawei.com
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH 0/2] Add support for getting page info of ZONE_DEVICE by /proc/kpage*
Date:   Sun,  9 Jan 2022 21:05:13 +0800
Message-Id: <20220109130515.140092-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2022-01-09_04:2022-01-06,2022-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=417 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2201090096
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

Patch 1 is adding pfn_to_devmap_page() function to get page of ZONE_DEVICE
by pfn. It checks the sections that is offline but valid or is online but
parts of pfns is offline. Then checks if dev_pagemap is valid, if yes,
return page pointer.

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

Xiongwei Song (2):
  mm/memremap.c: Add pfn_to_devmap_page() to get page in ZONE_DEVICE
  proc: Add getting pages info of ZONE_DEVICE support

 fs/proc/page.c           | 35 ++++++++++++++++++++-------------
 include/linux/memremap.h |  8 ++++++++
 mm/memremap.c            | 42 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 13 deletions(-)

-- 
2.30.2

