Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC9E3145D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 02:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhBIBv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 20:51:56 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:25938 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229797AbhBIBvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:51:54 -0500
X-IronPort-AV: E=Sophos;i="5.81,163,1610380800"; 
   d="scan'208";a="104350489"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Feb 2021 09:51:05 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 3C2874CE6F87;
        Tue,  9 Feb 2021 09:51:04 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 9 Feb
 2021 09:51:02 +0800
Subject: Re: [PATCH 0/7] fsdax,xfs: Add reflink&dedupe support for fsdax
To:     Jan Kara <jack@suse.cz>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <viro@zeniv.linux.org.uk>,
        <linux-btrfs@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
 <20210208153911.GE30081@quack2.suse.cz>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <31e9aa48-7830-efe2-837f-e31cba2da491@cn.fujitsu.com>
Date:   Tue, 9 Feb 2021 09:50:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208153911.GE30081@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 3C2874CE6F87.AC9A2
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/2/8 下午11:39, Jan Kara wrote:
> On Mon 08-02-21 01:09:17, Shiyang Ruan wrote:
>> This patchset is attempt to add CoW support for fsdax, and take XFS,
>> which has both reflink and fsdax feature, as an example.
>>
>> One of the key mechanism need to be implemented in fsdax is CoW.  Copy
>> the data from srcmap before we actually write data to the destance
>> iomap.  And we just copy range in which data won't be changed.
>>
>> Another mechanism is range comparison .  In page cache case, readpage()
>> is used to load data on disk to page cache in order to be able to
>> compare data.  In fsdax case, readpage() does not work.  So, we need
>> another compare data with direct access support.
>>
>> With the two mechanism implemented in fsdax, we are able to make reflink
>> and fsdax work together in XFS.
>>
>> Some of the patches are picked up from Goldwyn's patchset.  I made some
>> changes to adapt to this patchset.
> 
> How do you deal with HWPoison code trying to reverse-map struct page back
> to inode-offset pair? This also needs to be fixed for reflink to work with
> DAX.
> 

I have posted v3 patchset to add reverse-map support for dax page 
yesterday.  Please take a look at this:

   https://lkml.org/lkml/2021/2/8/347


--
Thanks,
Ruan Shiyang.

> 								Honza
> 
>>
>> (Rebased on v5.10)
>> ==
>>
>> Shiyang Ruan (7):
>>    fsdax: Output address in dax_iomap_pfn() and rename it
>>    fsdax: Introduce dax_copy_edges() for CoW
>>    fsdax: Copy data before write
>>    fsdax: Replace mmap entry in case of CoW
>>    fsdax: Dedup file range to use a compare function
>>    fs/xfs: Handle CoW for fsdax write() path
>>    fs/xfs: Add dedupe support for fsdax
>>
>>   fs/btrfs/reflink.c     |   3 +-
>>   fs/dax.c               | 188 ++++++++++++++++++++++++++++++++++++++---
>>   fs/ocfs2/file.c        |   2 +-
>>   fs/remap_range.c       |  14 +--
>>   fs/xfs/xfs_bmap_util.c |   6 +-
>>   fs/xfs/xfs_file.c      |  30 ++++++-
>>   fs/xfs/xfs_inode.c     |   8 +-
>>   fs/xfs/xfs_inode.h     |   1 +
>>   fs/xfs/xfs_iomap.c     |   3 +-
>>   fs/xfs/xfs_iops.c      |  11 ++-
>>   fs/xfs/xfs_reflink.c   |  23 ++++-
>>   include/linux/dax.h    |   5 ++
>>   include/linux/fs.h     |   9 +-
>>   13 files changed, 270 insertions(+), 33 deletions(-)
>>
>> -- 
>> 2.30.0
>>
>>
>>


