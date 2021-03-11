Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D01D336D4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 08:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhCKHsv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 02:48:51 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:5087 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhCKHsg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:48:36 -0500
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Dx1HM4FXxzYHwB;
        Thu, 11 Mar 2021 15:46:55 +0800 (CST)
Received: from DGGEML509-MBS.china.huawei.com ([169.254.4.125]) by
 DGGEML402-HUB.china.huawei.com ([fe80::fca6:7568:4ee3:c776%31]) with mapi id
 14.03.0513.000; Thu, 11 Mar 2021 15:48:25 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>,
        "lizhe (Y)" <lizhe67@huawei.com>, yangerkun <yangerkun@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Subject: [question] Panic in dax_writeback_one
Thread-Topic: [question] Panic in dax_writeback_one
Thread-Index: AdcWSusQwspXlegvQqCtsylm2CuWCw==
Date:   Thu, 11 Mar 2021 07:48:25 +0000
Message-ID: <CE1E7D7EFA066443B6454A6A5063B50220D0B849@dggeml509-mbs.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.53]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi

I write a driver to simulate memory as a block device (like a ramdisk). 
and I hope the memory used would not be observed by kernel, becasue of 
the struct page will take many memory.

When I mount ext2 with dax on my ramdisk. Panic will happen when fsync.
Call trace：
  dax_writeback_one+0x330/0x3e4
  dax_writeback_mapping_range+0x15c/0x318
  ext2_dax_writepages+0x38/0x44
....

static int dax_writeback_one(struct xa_state *xas, struct dax_device 
*dax_dev, struct address_space *mapping, void *entry)
----dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_SIZE);
The pfn is returned by the driver. In my case, the pfn does not have
struct page. so pfn_to_page(pfn) return a wrong address.

I noticed the following changes may related to my problem:
1. Before 3fe0791c295cfd3cd735de7a32cc0780949c009f (dax: store pfns in 
the radix), the radix tree stroes sectors. address which would be 
flushed is got from driver by passing sector.
And the commit assume that all pfn have struct page.

2. CONFIG_FS_DAX_LIMITED （Selected by DCSSBLK [=n] && BLK_DEV [=y] && 
S390 && BLOCK [=y]) is added to avoid access struct page of pfn.

Does anyone have any idea about my problem.

-- 
Regards
Chen Jun
