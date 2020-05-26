Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCB11BB9E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 11:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgD1Jc4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 05:32:56 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:5562 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726477AbgD1Jc4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:32:56 -0400
X-IronPort-AV: E=Sophos;i="5.73,326,1583164800"; 
   d="scan'208";a="90638122"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Apr 2020 17:32:51 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 3DFFC50A9991;
        Tue, 28 Apr 2020 17:32:49 +0800 (CST)
Received: from [10.167.225.141] (10.167.225.141) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 28 Apr 2020 17:32:46 +0800
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogUmU6IFtSRkMgUEFUQ0ggMC84XSBkYXg6IEFkZCBh?=
 =?UTF-8?Q?_dax-rmap_tree_to_support_reflink?=
To:     Dave Chinner <david@fromorbit.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "Qi, Fuli" <qi.fuli@fujitsu.com>,
        "Gotou, Yasunori" <y-goto@fujitsu.com>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
 <20200427122836.GD29705@bombadil.infradead.org>
 <em33c55fa5-15ca-4c46-8c27-6b0300fa4e51@g08fnstd180058>
 <20200428064318.GG2040@dread.disaster.area>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <259fe633-e1ff-b279-cd8c-1a81eaa40941@cn.fujitsu.com>
Date:   Tue, 28 Apr 2020 17:32:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428064318.GG2040@dread.disaster.area>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 3DFFC50A9991.AE2A1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/4/28 下午2:43, Dave Chinner wrote:
> On Tue, Apr 28, 2020 at 06:09:47AM +0000, Ruan, Shiyang wrote:
>>
>> 在 2020/4/27 20:28:36, "Matthew Wilcox" <willy@infradead.org> 写道:
>>
>>> On Mon, Apr 27, 2020 at 04:47:42PM +0800, Shiyang Ruan wrote:
>>>>   This patchset is a try to resolve the shared 'page cache' problem for
>>>>   fsdax.
>>>>
>>>>   In order to track multiple mappings and indexes on one page, I
>>>>   introduced a dax-rmap rb-tree to manage the relationship.  A dax entry
>>>>   will be associated more than once if is shared.  At the second time we
>>>>   associate this entry, we create this rb-tree and store its root in
>>>>   page->private(not used in fsdax).  Insert (->mapping, ->index) when
>>>>   dax_associate_entry() and delete it when dax_disassociate_entry().
>>>
>>> Do we really want to track all of this on a per-page basis?  I would
>>> have thought a per-extent basis was more useful.  Essentially, create
>>> a new address_space for each shared extent.  Per page just seems like
>>> a huge overhead.
>>>
>> Per-extent tracking is a nice idea for me.  I haven't thought of it
>> yet...
>>
>> But the extent info is maintained by filesystem.  I think we need a way
>> to obtain this info from FS when associating a page.  May be a bit
>> complicated.  Let me think about it...
> 
> That's why I want the -user of this association- to do a filesystem
> callout instead of keeping it's own naive tracking infrastructure.
> The filesystem can do an efficient, on-demand reverse mapping lookup
> from it's own extent tracking infrastructure, and there's zero
> runtime overhead when there are no errors present.
> 
> At the moment, this "dax association" is used to "report" a storage
> media error directly to userspace. I say "report" because what it
> does is kill userspace processes dead. The storage media error
> actually needs to be reported to the owner of the storage media,
> which in the case of FS-DAX is the filesytem.

Understood.

BTW, this is the usage in memory-failure, so what about rmap?  I have 
not found how to use this tracking in rmap.  Do you have any ideas?

> 
> That way the filesystem can then look up all the owners of that bad
> media range (i.e. the filesystem block it corresponds to) and take
> appropriate action. e.g.

I tried writing a function to look up all the owners' info of one block 
in xfs for memory-failure use.  It was dropped in this patchset because 
I found out that this lookup function needs 'rmapbt' to be enabled when 
mkfs.  But by default, rmapbt is disabled.  I am not sure if it matters...

> 
> - if it falls in filesytem metadata, shutdown the filesystem
> - if it falls in user data, call the "kill userspace dead" routines
>    for each mapping/index tuple the filesystem finds for the given
>    LBA address that the media error occurred >
> Right now if the media error is in filesystem metadata, the
> filesystem isn't even told about it. The filesystem can't even shut
> down - the error is just dropped on the floor and it won't be until
> the filesystem next tries to reference that metadata that we notice
> there is an issue.

Understood.  Thanks.

> 
> Cheers,
> 
> Dave.
> 


--
Thanks,
Ruan Shiyang.


