Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25B01C7244
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 15:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgEFN5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 09:57:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:36724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgEFN5v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 09:57:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 361C6AD26;
        Wed,  6 May 2020 13:57:52 +0000 (UTC)
Subject: Re: [fuse-devel] fuse: trying to steal weird page
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-mm <linux-mm@kvack.org>, miklos <mszeredi@redhat.com>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
References: <87a72qtaqk.fsf@vostro.rath.org> <877dxut8q7.fsf@vostro.rath.org>
 <20200503032613.GE29705@bombadil.infradead.org>
 <87368hz9vm.fsf@vostro.rath.org>
 <20200503102742.GF29705@bombadil.infradead.org>
 <85d07kkh4d.fsf@collabora.com> <87zhaoydeb.fsf@vostro.rath.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7087dfb7-6cb1-59fe-e758-a37d714802a0@suse.cz>
Date:   Wed, 6 May 2020 15:57:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87zhaoydeb.fsf@vostro.rath.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/3/20 10:25 PM, Nikolaus Rath wrote:
> On May 03 2020, Gabriel Krisman Bertazi <krisman@collabora.com> wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>>
>>> On Sun, May 03, 2020 at 09:43:41AM +0100, Nikolaus Rath wrote:
>>>> Here's what I got:
>>>> 
>>>> [  221.277260] page:ffffec4bbd639880 refcount:1 mapcount:0 mapping:0000000000000000 index:0xd9
>>>> [  221.277265] flags: 0x17ffffc0000097(locked|waiters|referenced|uptodate|lru)
>>>> [  221.277269] raw: 0017ffffc0000097 ffffec4bbd62f048 ffffec4bbd619308 0000000000000000
>>>> [  221.277271] raw: 00000000000000d9 0000000000000000 00000001ffffffff ffff9aec11beb000
>>>> [  221.277272] page dumped because: fuse: trying to steal weird page
>>>> [  221.277273] page->mem_cgroup:ffff9aec11beb000
>>>
>>> Great!  Here's the condition:
>>>
>>>         if (page_mapcount(page) ||
>>>             page->mapping != NULL ||
>>>             page_count(page) != 1 ||
>>>             (page->flags & PAGE_FLAGS_CHECK_AT_PREP &
>>>              ~(1 << PG_locked |
>>>                1 << PG_referenced |
>>>                1 << PG_uptodate |
>>>                1 << PG_lru |
>>>                1 << PG_active |
>>>                1 << PG_reclaim))) {
>>>
>>> mapcount is 0, mapping is NULL, refcount is 1, so that's all fine.
>>> flags has 'waiters' set, which is not in the allowed list.  I don't
>>> know the internals of FUSE, so I don't know why that is.
>>>
>>
>> On the first message, Nikolaus sent the following line:
>>
>>>> [ 2333.009937] fuse: page=00000000dd1750e3 index=2022240 flags=17ffffc0000097, count=1,
>>>> mapcount=0, mapping=00000000125079ad
>>
>> It should be noted that on the second run, where we got the dump_page
>> log, it indeed had a null mapping, which is similar to what Nikolaus
>> asked on the previous thread he linked to, but looks like this wasn't
>> the case on at least some of the reproductions of the issue.  On the
>> line above, the condition that triggered the warning was page->mapping
>> != NULL.  I don't know what to do with this information, though.
> 
> Indeed, that's curious. I've modified the patch slightly to print both
> the old and the new message to confirm. And indeed:
> 
> [  260.882873] fuse: trying to steal weird page
> [  260.882879] fuse:   page=00000000813e7570 index=2010048 flags=17ffffc0000097, count=1, mapcount=0, mapping=0000000094844a11

fuse_check_page() is using %p for these, so they are hashed (IIRC that means the
upper part is zeroed and the lower hashed)

> [  260.882882] page:ffffe13431bcc000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x1eabc0

__dump_page() in 5.6 uses %px so they are unmodified. Thus it's really a NULL
pointer.

For extra fun, __dump_page() in 5.7 will also print page pointer unmodified, but
mapping will become hashed too.
Yeah it would be nice if NULLish values were treated specially, as
0000000094844a11 instead of NULL is really misleading. __dump_page() is fine
thanks to the raw dump, but other places perhaps not.
