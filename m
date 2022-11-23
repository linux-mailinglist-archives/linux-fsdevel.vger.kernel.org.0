Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8146361D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 15:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbiKWOag (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 09:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbiKWOaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:30:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C93290580;
        Wed, 23 Nov 2022 06:28:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60E9E61D3B;
        Wed, 23 Nov 2022 14:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B521C433D6;
        Wed, 23 Nov 2022 14:28:28 +0000 (UTC)
Message-ID: <0da1813a-7e37-bc35-cf8d-8c41590f3b1a@xs4all.nl>
Date:   Wed, 23 Nov 2022 15:28:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH mm-unstable v1 16/20] mm/frame-vector: remove FOLL_FORCE
 usage
Content-Language: en-US
From:   Hans Verkuil <hverkuil@xs4all.nl>
To:     David Hildenbrand <david@redhat.com>,
        Tomasz Figa <tfiga@chromium.org>
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
        Andrew Morton <akpm@linux-foundation.org>,
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
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-17-david@redhat.com>
 <36dd800b-d96b-af39-d0de-a5a8ca1034dd@xs4all.nl>
In-Reply-To: <36dd800b-d96b-af39-d0de-a5a8ca1034dd@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/11/2022 14:26, Hans Verkuil wrote:
> Hi David, Tomasz,
> 
> On 16/11/2022 11:26, David Hildenbrand wrote:
>> FOLL_FORCE is really only for ptrace access. According to commit
>> 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are always
>> writable"), get_vaddr_frames() currently pins all pages writable as a
>> workaround for issues with read-only buffers.
> 
> I've decided to revert 707947247e95: I have not been able to reproduce the problem
> described in that commit, and Tomasz reported that it caused problems with a
> specific use-case they encountered. I'll post that patch soon and I expect it
> to land in 6.2. It will cause a conflict with this patch, though.
> 
> If the problem described in that patch occurs again, then I will revisit it
> and hopefully do a better job than I did before. That commit was not my
> finest moment.

In any case, for this patch:

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans

> 
> Regards,
> 
> 	Hans
> 
>>
>> FOLL_FORCE, however, seems to be a legacy leftover as it predates
>> commit 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are
>> always writable"). Let's just remove it.
>>
>> Once the read-only buffer issue has been resolved, FOLL_WRITE could
>> again be set depending on the DMA direction.
>>
>> Cc: Hans Verkuil <hverkuil@xs4all.nl>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Cc: Tomasz Figa <tfiga@chromium.org>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  drivers/media/common/videobuf2/frame_vector.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/common/videobuf2/frame_vector.c
>> index 542dde9d2609..062e98148c53 100644
>> --- a/drivers/media/common/videobuf2/frame_vector.c
>> +++ b/drivers/media/common/videobuf2/frame_vector.c
>> @@ -50,7 +50,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
>>  	start = untagged_addr(start);
>>  
>>  	ret = pin_user_pages_fast(start, nr_frames,
>> -				  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
>> +				  FOLL_WRITE | FOLL_LONGTERM,
>>  				  (struct page **)(vec->ptrs));
>>  	if (ret > 0) {
>>  		vec->got_ref = true;
> 

