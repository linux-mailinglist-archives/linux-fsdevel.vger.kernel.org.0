Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69EB64A398
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 15:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbiLLOmD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 09:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiLLOl7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 09:41:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B6E6477;
        Mon, 12 Dec 2022 06:41:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ABE7B80A09;
        Mon, 12 Dec 2022 14:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CE0C433EF;
        Mon, 12 Dec 2022 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670856114;
        bh=49yiOOZXNHxawLGdF5jaeIemWnDUH+xC0nzErDnYjL4=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=n8xLMOU0bLG+06pQhoH9AbcOhe69C8Zly9RLAQ10uYBXbidwiMeWjZOvalz0iy3SD
         bheByXSHQ+WLsHN9KFYet/HV67Uj437+Q5xUEZP4ATjRAn0VGj8QOEm04zMRlp8MPe
         faogHkgm3YP1getVruEGkC4Lh1MR86MRnQJND1kfBzaQRawe5X3zL9S8LmY8RGBwya
         igwos3kMQ4claGjqRPg/VcBFUMKS3jOOwAnrAvdZ/1hX61RtYcwBA6LW86t7ksM/rc
         UW0Vnz7D5hGc38jpAX6MiZ31A969eZ+YuzJlUYUOG1or01nYfPtY2cU4bYkDtv/MS3
         0vUsMTm8qvbCw==
Message-ID: <0a95ba7b-9335-ce03-0f47-5d9f4cce988f@kernel.org>
Date:   Mon, 12 Dec 2022 22:41:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     Vishal Moola <vishal.moola@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        fengnan chang <fengnanchang@gmail.com>,
        linux-fsdevel@vger.kernel.org
References: <20221017202451.4951-1-vishal.moola@gmail.com>
 <20221017202451.4951-15-vishal.moola@gmail.com>
 <9c01bb74-97b3-d1c0-6a5f-dc8b11113e1a@kernel.org>
 <CAOzc2pweRFtsUj65=U-N-+ASf3cQybwMuABoVB+ciHzD1gKWhQ@mail.gmail.com>
 <CAOzc2pzoG1CN3Bpx5oe37GwRv71TpTQmFH6m58kTqOmeW7KLOw@mail.gmail.com>
 <CAOzc2pzp0JEanJTgzSrRt3ziRCrR6rGCjpwJvAD8uCqsHqXnHg@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v3 14/23] f2fs: Convert
 f2fs_write_cache_pages() to use filemap_get_folios_tag()
In-Reply-To: <CAOzc2pzp0JEanJTgzSrRt3ziRCrR6rGCjpwJvAD8uCqsHqXnHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Vishal,

Sorry for the delay reply.

On 2022/12/6 4:34, Vishal Moola wrote:
> On Tue, Nov 22, 2022 at 6:26 PM Vishal Moola <vishal.moola@gmail.com> wrote:
>>
>> On Mon, Nov 14, 2022 at 1:38 PM Vishal Moola <vishal.moola@gmail.com> wrote:
>>>
>>> On Sun, Nov 13, 2022 at 11:02 PM Chao Yu <chao@kernel.org> wrote:
>>>>
>>>> On 2022/10/18 4:24, Vishal Moola (Oracle) wrote:
>>>>> Converted the function to use a folio_batch instead of pagevec. This is in
>>>>> preparation for the removal of find_get_pages_range_tag().
>>>>>
>>>>> Also modified f2fs_all_cluster_page_ready to take in a folio_batch instead
>>>>> of pagevec. This does NOT support large folios. The function currently
>>>>
>>>> Vishal,
>>>>
>>>> It looks this patch tries to revert Fengnan's change:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=01fc4b9a6ed8eacb64e5609bab7ac963e1c7e486
>>>>
>>>> How about doing some tests to evaluate its performance effect?
>>>
>>> Yeah I'll play around with it to see how much of a difference it makes.
>>
>> I did some testing. Looks like reverting Fengnan's change allows for
>> occasional, but significant, spikes in write latency. I'll work on a variation
>> of the patch that maintains the use of F2FS_ONSTACK_PAGES and send
>> that in the next version of the patch series. Thanks for pointing that out!
> 
> Following Matthew's comment, I'm thinking we should go with this patch
> as is. The numbers between both variations did not have substantial
> differences with regard to latency.
> 
> While the new variant would maintain the use of F2FS_ONSTACK_PAGES,
> the code becomes messier and would end up limiting the number of
> folios written back once large folio support is added. This means it would
> have to be converted down to this version later anyways.
> 
> Does leaving this patch as is sound good to you?
> 
> For reference, here's what the version continuing to use a page
> array of size F2FS_ONSTACK_PAGES would change:
> 
> +               nr_pages = 0;
> +again:
> +               nr_folios = filemap_get_folios_tag(mapping, &index, end,
> +                               tag, &fbatch);
> +               if (nr_folios == 0) {
> +                       if (nr_pages)
> +                               goto write;
> +                               goto write;

Duplicated code.

>                          break;
> +               }
> 
> +               for (i = 0; i < nr_folios; i++) {
> +                       struct folio* folio = fbatch.folios[i];
> +
> +                       idx = 0;
> +                       p = folio_nr_pages(folio);
> +add_more:
> +                       pages[nr_pages] = folio_page(folio,idx);
> +                       folio_ref_inc(folio);
> +                       if (++nr_pages == F2FS_ONSTACK_PAGES) {
> +                               index = folio->index + idx + 1;
> +                               folio_batch_release(&fbatch);
> +                               goto write;
> +                       }
> +                       if (++idx < p)
> +                               goto add_more;
> +               }
> +               folio_batch_release(&fbatch);
> +               goto again;
> +write:

Looks fine to me, can you please send a formal patch?

Thanks,

> 
>> How do the remaining f2fs patches in the series look to you?
>> Patch 16/23 f2fs_sync_meta_pages() in particular seems like it may
>> be prone to problems. If there are any changes that need to be made to
>> it I can include those in the next version as well.
> 
> Thanks for reviewing the patches so far. I wanted to follow up on asking
> for review of the last couple of patches.
