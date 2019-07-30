Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA6ED7AB8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 16:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbfG3O5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 10:57:23 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:44028 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727129AbfG3O5X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:57:23 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 3DC5F2E149D;
        Tue, 30 Jul 2019 17:57:19 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id WNehyI4MZ5-vIm4YE3J;
        Tue, 30 Jul 2019 17:57:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1564498639; bh=dHW6AIzVqZ+BtB7OKS/RSaqFVfjBjJYiEElqTiNSJSw=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=nRcfxXoJOFApXtdgJwbWyzJxu18sBhC97J+b0XUkbFKbeyF+czKvEWkER4dD4PvpM
         Kx/kWcdfC8+qhUZCnfAK7DgD6b7CRVZVU0aEanWgO1MM6GjH/xuz0fqsz9Qx261iQ4
         tVpiYuJxxjpZMd1yQzLk/Q6wtTeCxfDCimRo8B7E=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:6454:ac35:2758:ad6a])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 1ayIe6tgdX-vIQKqeKg;
        Tue, 30 Jul 2019 17:57:18 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH 1/2] mm/filemap: don't initiate writeback if mapping has
 no dirty pages
To:     Jan Kara <jack@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org
References: <156378816804.1087.8607636317907921438.stgit@buzz>
 <20190722175230.d357d52c3e86dc87efbd4243@linux-foundation.org>
 <bdc6c53d-a7bb-dcc4-20ba-6c7fa5c57dbd@yandex-team.ru>
 <20190730141457.GE28829@quack2.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <51ba7304-06bd-a50d-cb14-6dc41b92fab5@yandex-team.ru>
Date:   Tue, 30 Jul 2019 17:57:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190730141457.GE28829@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30.07.2019 17:14, Jan Kara wrote:
> On Tue 23-07-19 11:16:51, Konstantin Khlebnikov wrote:
>> On 23.07.2019 3:52, Andrew Morton wrote:
>>>
>>> (cc linux-fsdevel and Jan)
> 
> Thanks for CC Andrew.
> 
>>> On Mon, 22 Jul 2019 12:36:08 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:
>>>
>>>> Functions like filemap_write_and_wait_range() should do nothing if inode
>>>> has no dirty pages or pages currently under writeback. But they anyway
>>>> construct struct writeback_control and this does some atomic operations
>>>> if CONFIG_CGROUP_WRITEBACK=y - on fast path it locks inode->i_lock and
>>>> updates state of writeback ownership, on slow path might be more work.
>>>> Current this path is safely avoided only when inode mapping has no pages.
>>>>
>>>> For example generic_file_read_iter() calls filemap_write_and_wait_range()
>>>> at each O_DIRECT read - pretty hot path.
> 
> Yes, but in common case mapping_needs_writeback() is false for files you do
> direct IO to (exactly the case with no pages in the mapping). So you
> shouldn't see the overhead at all. So which case you really care about?
> 
>>>> This patch skips starting new writeback if mapping has no dirty tags set.
>>>> If writeback is already in progress filemap_write_and_wait_range() will
>>>> wait for it.
>>>>
>>>> ...
>>>>
>>>> --- a/mm/filemap.c
>>>> +++ b/mm/filemap.c
>>>> @@ -408,7 +408,8 @@ int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
>>>>    		.range_end = end,
>>>>    	};
>>>> -	if (!mapping_cap_writeback_dirty(mapping))
>>>> +	if (!mapping_cap_writeback_dirty(mapping) ||
>>>> +	    !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
>>>>    		return 0;
>>>>    	wbc_attach_fdatawrite_inode(&wbc, mapping->host);
>>>
>>> How does this play with tagged_writepages?  We assume that no tagging
>>> has been performed by any __filemap_fdatawrite_range() caller?
>>>
>>
>> Checking also PAGECACHE_TAG_TOWRITE is cheap but seems redundant.
>>
>> To-write tags are supposed to be a subset of dirty tags:
>> to-write is set only when dirty is set and cleared after starting writeback.
>>
>> Special case set_page_writeback_keepwrite() which does not clear to-write
>> should be for dirty page thus dirty tag is not going to be cleared either.
>> Ext4 calls it after redirty_page_for_writepage()
>> XFS even without clear_page_dirty_for_io()
>>
>> Anyway to-write tag without dirty tag or at clear page is confusing.
> 
> Yeah, TOWRITE tag is intended to be internal to writepages logic so your
> patch is fine in that regard. Overall the patch looks good to me so I'm
> just wondering a bit about the motivation...

In our case file mixes cached pages and O_DIRECT read. Kind of database
were index header is memory mapped while the rest data read via O_DIRECT.
I suppose for sharing index between multiple instances.

On this path we also hit this bug:
https://lore.kernel.org/lkml/156355839560.2063.5265687291430814589.stgit@buzz/
so that's why I've started looking into this code.
