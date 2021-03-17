Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B32C33E74B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 04:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhCQDAF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 23:00:05 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3041 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhCQC77 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 22:59:59 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4F0ZYw6BYpzWMHZ;
        Wed, 17 Mar 2021 10:56:52 +0800 (CST)
Received: from DGGEML509-MBS.china.huawei.com ([169.254.4.125]) by
 DGGEML404-HUB.china.huawei.com ([fe80::b177:a243:7a69:5ab8%31]) with mapi id
 14.03.0513.000; Wed, 17 Mar 2021 10:59:44 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>,
        "lizhe (Y)" <lizhe67@huawei.com>, yangerkun <yangerkun@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Subject: Re: [question] Panic in dax_writeback_one
Thread-Topic: [question] Panic in dax_writeback_one
Thread-Index: AdcWSusQwspXlegvQqCtsylm2CuWCw==
Date:   Wed, 17 Mar 2021 02:59:43 +0000
Message-ID: <CE1E7D7EFA066443B6454A6A5063B50220D12A8A@dggeml509-mbs.china.huawei.com>
References: <CE1E7D7EFA066443B6454A6A5063B50220D0B849@dggeml509-mbs.china.huawei.com>
 <20210311121923.GU3479805@casper.infradead.org>
 <CAPcyv4jz7-uq+T-sd_U3O_C7SB9nYWVJDnhVsaM0VNR207m8xA@mail.gmail.com>
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

在 2021/3/12 1:25, Dan Williams 写道:
> On Thu, Mar 11, 2021 at 4:20 AM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Thu, Mar 11, 2021 at 07:48:25AM +0000, chenjun (AM) wrote:
>>> static int dax_writeback_one(struct xa_state *xas, struct dax_device
>>> *dax_dev, struct address_space *mapping, void *entry)
>>> ----dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_SIZE);
>>> The pfn is returned by the driver. In my case, the pfn does not have
>>> struct page. so pfn_to_page(pfn) return a wrong address.
>>
>> I wasn't involved, but I think the right solution here is simply to
>> replace page_address(pfn_to_page(pfn)) with pfn_to_virt(pfn).  I don't
>> know why Dan decided to do this in the more complicated way.
> 
> pfn_to_virt() only works for the direct-map. If pages are not mapped I
> don't see how pfn_to_virt() is expected to work.
> 
> The real question Chenjun is why are you writing a new simulator of
> memory as a block-device vs reusing the pmem driver or brd?
> 

Hi Dan

In my case, I do not want to take memory to create the struct page of 
the memory my driver used.

And, I think this is also a problem for DCSSBLK.

So I want to go back the older way if CONFIG_FS_DAX_LIMITED

diff --git a/fs/dax.c b/fs/dax.c
index b3d27fd..6395e84 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -867,6 +867,9 @@ static int dax_writeback_one(struct xa_state *xas, 
struct dax_device *dax_dev,
  {
  	unsigned long pfn, index, count;
  	long ret = 0;
+	void *kaddr;
+	pfn_t new_pfn_t;
+	pgoff_t pgoff;

  	/*
  	 * A page got tagged dirty in DAX mapping? Something is seriously
@@ -926,7 +929,25 @@ static int dax_writeback_one(struct xa_state *xas, 
struct dax_device *dax_dev,
  	index = xas->xa_index & ~(count - 1);

  	dax_entry_mkclean(mapping, index, pfn);
-	dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_SIZE);
+
+	if (!IS_ENABLED(CONFIG_FS_DAX_LIMITED) || pfn_valid(pfn))
+		kaddr = page_address(pfn_to_page(pfn));
+	else {
+		ret = bdev_dax_pgoff(mapping->host->i_sb->s_bdev, pfn << 
PFN_SECTION_SHIFT, count << PAGE_SHIFT, &pgoff);
+		if (ret)
+			goto put_unlocked;
+
+		ret = dax_direct_access(dax_dev, pgoff, count, &kaddr, &new_pfn_t);
+		if (ret < 0)
+			goto put_unlocked;
+
+		if (WARN_ON_ONCE(ret < count) || WARN_ON_ONCE(pfn_t_to_pfn(new_pfn_t) 
!= pfn)) {
+			ret = -EIO;
+		        goto put_unlocked;
+		}
+	}
+
+	dax_flush(dax_dev, kaddr, count * PAGE_SIZE);
  	/*
  	 * After we have flushed the cache, we can clear the dirty tag. There
  	 * cannot be new dirty data in the pfn after the flush has completed as
-- 

-- 
Regards
Chen Jun
