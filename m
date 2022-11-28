Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB7663A2E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 09:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiK1I0S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 03:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiK1I0Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:26:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EC2C07;
        Mon, 28 Nov 2022 00:26:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31BB0B80B8E;
        Mon, 28 Nov 2022 08:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F8BC433D6;
        Mon, 28 Nov 2022 08:26:05 +0000 (UTC)
Message-ID: <0a52ed02-cf9d-eb67-8d68-e3d9dbe4e7b2@xs4all.nl>
Date:   Mon, 28 Nov 2022 09:26:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mm-unstable v1 16/20] mm/frame-vector: remove FOLL_FORCE
 usage
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-17-david@redhat.com>
 <81fb0fa3-2e06-b765-56ac-a7d981194e59@redhat.com>
 <08b65ac6-6786-1080-18f8-d2be109c85fc@xs4all.nl>
 <9d0bf98a-3d6a-1082-e992-1338e1525935@redhat.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <9d0bf98a-3d6a-1082-e992-1338e1525935@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/11/2022 09:18, David Hildenbrand wrote:
> On 28.11.22 09:17, Hans Verkuil wrote:
>> Hi David,
>>
>> On 27/11/2022 11:35, David Hildenbrand wrote:
>>> On 16.11.22 11:26, David Hildenbrand wrote:
>>>> FOLL_FORCE is really only for ptrace access. According to commit
>>>> 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are always
>>>> writable"), get_vaddr_frames() currently pins all pages writable as a
>>>> workaround for issues with read-only buffers.
>>>>
>>>> FOLL_FORCE, however, seems to be a legacy leftover as it predates
>>>> commit 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are
>>>> always writable"). Let's just remove it.
>>>>
>>>> Once the read-only buffer issue has been resolved, FOLL_WRITE could
>>>> again be set depending on the DMA direction.
>>>>
>>>> Cc: Hans Verkuil <hverkuil@xs4all.nl>
>>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> Cc: Tomasz Figa <tfiga@chromium.org>
>>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>    drivers/media/common/videobuf2/frame_vector.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/common/videobuf2/frame_vector.c
>>>> index 542dde9d2609..062e98148c53 100644
>>>> --- a/drivers/media/common/videobuf2/frame_vector.c
>>>> +++ b/drivers/media/common/videobuf2/frame_vector.c
>>>> @@ -50,7 +50,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
>>>>        start = untagged_addr(start);
>>>>          ret = pin_user_pages_fast(start, nr_frames,
>>>> -                  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
>>>> +                  FOLL_WRITE | FOLL_LONGTERM,
>>>>                      (struct page **)(vec->ptrs));
>>>>        if (ret > 0) {
>>>>            vec->got_ref = true;
>>>
>>>
>>> Hi Andrew,
>>>
>>> see the discussion at [1] regarding a conflict and how to proceed with
>>> upstreaming. The conflict would be easy to resolve, however, also
>>> the patch description doesn't make sense anymore with [1].
>>
>> Might it be easier and less confusing if you post a v2 of this series
>> with my patch first? That way it is clear that 1) my patch has to come
>> first, and 2) that it is part of a single series and should be merged
>> by the mm subsystem.
>>
>> Less chances of things going wrong that way.
>>
>> Just mention in the v2 cover letter that the first patch was added to
>> make it easy to backport that fix without being hampered by merge
>> conflicts if it was added after your frame_vector.c patch.
> 
> Yes, that's the way I would naturally do, it, however, Andrew prefers delta updates for minor changes.
> 
> @Andrew, whatever you prefer!

Andrew, I've resent my patch, this time with you CCed as well.

Regards,

	Hans

> 
> Thanks!
> 

