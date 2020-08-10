Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9B0240348
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 10:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHJIQH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 04:16:07 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54452 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726021AbgHJIQH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:16:07 -0400
X-IronPort-AV: E=Sophos;i="5.75,456,1589212800"; 
   d="scan'208";a="97927751"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 10 Aug 2020 16:16:05 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 1A5144CE34E6;
        Mon, 10 Aug 2020 16:16:00 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 10 Aug
 2020 16:16:02 +0800
Subject: Re: [RFC PATCH 0/8] fsdax: introduce FS query interface to support
 reflink
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <darrick.wong@oracle.com>,
        <dan.j.williams@intel.com>, <david@fromorbit.com>, <hch@lst.de>,
        <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
References: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
 <20200807133857.GC17456@casper.infradead.org>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <9673ed3c-9e42-3d01-000b-b01cda9832ce@cn.fujitsu.com>
Date:   Mon, 10 Aug 2020 16:15:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807133857.GC17456@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 1A5144CE34E6.AAE60
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/8/7 下午9:38, Matthew Wilcox wrote:
> On Fri, Aug 07, 2020 at 09:13:28PM +0800, Shiyang Ruan wrote:
>> This patchset is a try to resolve the problem of tracking shared page
>> for fsdax.
>>
>> Instead of per-page tracking method, this patchset introduces a query
>> interface: get_shared_files(), which is implemented by each FS, to
>> obtain the owners of a shared page.  It returns an owner list of this
>> shared page.  Then, the memory-failure() iterates the list to be able
>> to notify each process using files that sharing this page.
>>
>> The design of the tracking method is as follow:
>> 1. dax_assocaite_entry() associates the owner's info to this page
> 
> I think that's the first problem with this design.  dax_associate_entry is
> a horrendous idea which needs to be ripped out, not made more important.
> It's all part of the general problem of trying to do something on a
> per-page basis instead of per-extent basis.
> 

The memory-failure needs to track owners info from a dax page, so I 
should associate the owner with this page.  In this version, I associate 
the block device to the dax page, so that the memory-failure is able to 
iterate the owners by the query interface provided by filesystem.


--
Thanks,
Ruan Shiyang.
> 
> 


