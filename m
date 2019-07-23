Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE6A713E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 10:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733201AbfGWIYf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 04:24:35 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:40412 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731544AbfGWIYf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:24:35 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Jul 2019 04:24:33 EDT
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 94D392E1485;
        Tue, 23 Jul 2019 11:16:52 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id zrWDbtFrST-GqNCGMan;
        Tue, 23 Jul 2019 11:16:52 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1563869812; bh=OCdChmHdfM6D9uf2VkQAqf8PnxrZ5zOIH6aLjOH+qUU=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=M0CVenrM9AC4JpNV2SXPm4QsXi07w0FwQKWvlGVbaH2JKs/RvqeojUHoTdlkMrkb6
         8CFoIYQtsn4RsPg8zd58p/Jtt/lPbqhJ2HhpLnLHI+NTKbR3m6d3bthLrDf6ZFMmun
         vcG5SDSMKJo7nRP3Se9wk2sTAFGcYTucOwL1nvjM=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:38b3:1cdf:ad1a:1fe1])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 7w6wmPdkO2-GpAejdNM;
        Tue, 23 Jul 2019 11:16:52 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH 1/2] mm/filemap: don't initiate writeback if mapping has
 no dirty pages
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <156378816804.1087.8607636317907921438.stgit@buzz>
 <20190722175230.d357d52c3e86dc87efbd4243@linux-foundation.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <bdc6c53d-a7bb-dcc4-20ba-6c7fa5c57dbd@yandex-team.ru>
Date:   Tue, 23 Jul 2019 11:16:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190722175230.d357d52c3e86dc87efbd4243@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 23.07.2019 3:52, Andrew Morton wrote:
> 
> (cc linux-fsdevel and Jan)
> 
> On Mon, 22 Jul 2019 12:36:08 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:
> 
>> Functions like filemap_write_and_wait_range() should do nothing if inode
>> has no dirty pages or pages currently under writeback. But they anyway
>> construct struct writeback_control and this does some atomic operations
>> if CONFIG_CGROUP_WRITEBACK=y - on fast path it locks inode->i_lock and
>> updates state of writeback ownership, on slow path might be more work.
>> Current this path is safely avoided only when inode mapping has no pages.
>>
>> For example generic_file_read_iter() calls filemap_write_and_wait_range()
>> at each O_DIRECT read - pretty hot path.
>>
>> This patch skips starting new writeback if mapping has no dirty tags set.
>> If writeback is already in progress filemap_write_and_wait_range() will
>> wait for it.
>>
>> ...
>>
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -408,7 +408,8 @@ int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
>>   		.range_end = end,
>>   	};
>>   
>> -	if (!mapping_cap_writeback_dirty(mapping))
>> +	if (!mapping_cap_writeback_dirty(mapping) ||
>> +	    !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
>>   		return 0;
>>   
>>   	wbc_attach_fdatawrite_inode(&wbc, mapping->host);
> 
> How does this play with tagged_writepages?  We assume that no tagging
> has been performed by any __filemap_fdatawrite_range() caller?
>

Checking also PAGECACHE_TAG_TOWRITE is cheap but seems redundant.

To-write tags are supposed to be a subset of dirty tags:
to-write is set only when dirty is set and cleared after starting writeback.

Special case set_page_writeback_keepwrite() which does not clear to-write
should be for dirty page thus dirty tag is not going to be cleared either.
Ext4 calls it after redirty_page_for_writepage()
XFS even without clear_page_dirty_for_io()

Anyway to-write tag without dirty tag or at clear page is confusing.
