Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D1B3383BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 03:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhCLClp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 21:41:45 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:3359 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhCLClO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 21:41:14 -0500
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DxVPN6yhtz5bFp;
        Fri, 12 Mar 2021 10:38:48 +0800 (CST)
Received: from DGGEML423-HUB.china.huawei.com (10.1.199.40) by
 DGGEML402-HUB.china.huawei.com (10.3.17.38) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 12 Mar 2021 10:41:05 +0800
Received: from DGGEML509-MBS.china.huawei.com ([169.254.4.125]) by
 dggeml423-hub.china.huawei.com ([10.1.199.40]) with mapi id 14.03.0513.000;
 Fri, 12 Mar 2021 10:40:57 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>,
        "lizhe (Y)" <lizhe67@huawei.com>, yangerkun <yangerkun@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Subject: Re: [question] Panic in dax_writeback_one
Thread-Topic: [question] Panic in dax_writeback_one
Thread-Index: AdcWSusQwspXlegvQqCtsylm2CuWCw==
Date:   Fri, 12 Mar 2021 02:40:56 +0000
Message-ID: <CE1E7D7EFA066443B6454A6A5063B50220D0E4E7@dggeml509-mbs.china.huawei.com>
References: <CE1E7D7EFA066443B6454A6A5063B50220D0B849@dggeml509-mbs.china.huawei.com>
 <20210311121923.GU3479805@casper.infradead.org>
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

在 2021/3/11 20:20, Matthew Wilcox 写道:
> On Thu, Mar 11, 2021 at 07:48:25AM +0000, chenjun (AM) wrote:
>> static int dax_writeback_one(struct xa_state *xas, struct dax_device
>> *dax_dev, struct address_space *mapping, void *entry)
>> ----dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_SIZE);
>> The pfn is returned by the driver. In my case, the pfn does not have
>> struct page. so pfn_to_page(pfn) return a wrong address.
> 
> I wasn't involved, but I think the right solution here is simply to
> replace page_address(pfn_to_page(pfn)) with pfn_to_virt(pfn).  I don't
> know why Dan decided to do this in the more complicated way.
> 

Thanks Mattherw

I think pfn_to_virt could not work in my case. Because of the pfn is not 
in memory block.

-- 
Regards
Chen Jun
