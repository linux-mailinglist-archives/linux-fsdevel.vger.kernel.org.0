Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D64B489B26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 15:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbiAJOUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 09:20:31 -0500
Received: from pv50p00im-ztdg10021901.me.com ([17.58.6.55]:50244 "EHLO
        pv50p00im-ztdg10021901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235173AbiAJOUa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1641824430; bh=atnhxdqiaPj43jOxoHr8rp5eHBMHDE4/iyg8VGRmxUU=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=URBmdaN8lUAaIx5lPzarbfLNKsg6TYSIwMCtvAfUs4SH8O5AJ3LPMtqvwVfOnqkZH
         zo+J7VtwlGyygV84CHmyqOqPR34BImyPFBt8WDUGWYbTE+j7hOv/roTCKo6UBma7jv
         TVGSoMpRyn215vQZE19spSG9Ujtn/h1OV42m+NwBdS3lAsMUndi5pkuwMK49XV0Vgx
         Ep7Rr5TOBS/TT3j5gMpSoPEyidJCr3eCfghUKX0lfFYf9fcRH1WuinjE+GYGh7LQBH
         i6yTMQEVZLplpKvOrlBi9+P79bGiHgAd3V8t3mXICWtDHH4ivK6ku3vVoUQkGjFNXT
         fY3GLpVmAH80w==
Received: from xiongwei.. (unknown [120.245.2.119])
        by pv50p00im-ztdg10021901.me.com (Postfix) with ESMTPSA id B9DDD81A2E;
        Mon, 10 Jan 2022 14:20:25 +0000 (UTC)
From:   sxwjean@me.com
To:     akpm@linux-foundation.org, david@redhat.com, mhocko@suse.com,
        dan.j.williams@intel.com, osalvador@suse.de,
        naoya.horiguchi@nec.com, thunder.leizhen@huawei.com
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH v2 0/2] Add support for getting page info of ZONE_DEVICE by /proc/kpage*
Date:   Mon, 10 Jan 2022 22:19:55 +0800
Message-Id: <20220110141957.259022-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2022-01-10_06:2022-01-10,2022-01-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=482 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2201100101
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

