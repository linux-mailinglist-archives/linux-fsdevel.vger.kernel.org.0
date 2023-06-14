Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B771B7305B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 19:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbjFNRKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 13:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjFNRKE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:10:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A327B3;
        Wed, 14 Jun 2023 10:10:02 -0700 (PDT)
Received: from [192.168.10.54] (unknown [119.155.33.163])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0AA396606F4D;
        Wed, 14 Jun 2023 18:09:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686762600;
        bh=i//yUwg9cZmm6JXgaBOTPjFxGE4Mq20F952UrtKkCy0=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=j45KUe28n8Ol8ieVyhGc0CU3gNdinTktWOA/bE1xOpriKO+y7X0E5xIQmYcrumswf
         WqCPKRNt2MtbdV4EX3REDYezqdSw/j62Igjb4HZuMGbqv9GIMLG++3MVqhVFscXS9D
         Yvrx62+/T43RxH6LfB96e9lUgqobVDFjHfAEx+l16OLDbr+SLATw7Z1wX3LoVmz6GP
         DVP/bswtDw8bq/1dJJIe2gJsKXQO2u743oDGpyPgIFg9YxHDkxfD81teghIORTJu1e
         O/XbI9gasAX3omgUEr2xEgGkEkcZOlU7I8Z7CTsWvW2pL28V0LIDCdTWuYA9o7Nrvg
         Gj0/OBRLLHkvg==
Message-ID: <34203acf-7270-7ade-a60e-ae0f729dcf70@collabora.com>
Date:   Wed, 14 Jun 2023 22:09:46 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v18 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230613102905.2808371-1-usama.anjum@collabora.com>
 <20230613102905.2808371-3-usama.anjum@collabora.com>
 <CABb0KFHWnbrf2ythvO0OKsd1ZS9b4D9BNzwBCbn6g9OX4n6ZOg@mail.gmail.com>
 <0db01d90-09d6-08a4-bbb8-70670d3baa94@collabora.com>
 <CABb0KFEn5TU480A=YiN82nLRtGyKMABi8cZjuiGUU_jFZZo+8g@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFEn5TU480A=YiN82nLRtGyKMABi8cZjuiGUU_jFZZo+8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/14/23 8:14 PM, Michał Mirosław wrote:
> On Wed, 14 Jun 2023 at 15:46, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> On 6/14/23 3:36 AM, Michał Mirosław wrote:
>>> On Tue, 13 Jun 2023 at 12:29, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>>
>>>> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
>>>> the info about page table entries. The following operations are supported
>>>> in this ioctl:
>>>> - Get the information if the pages have been written-to (PAGE_IS_WRITTEN),
>>>>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
>>>>   (PAGE_IS_SWAPPED).
>>>> - Find pages which have been written-to and/or write protect the pages
>>>>   (atomic PM_SCAN_OP_GET + PM_SCAN_OP_WP)
>>>>
>>>> This IOCTL can be extended to get information about more PTE bits.
>>> [...]
>>>> --- a/fs/proc/task_mmu.c
>>>> +++ b/fs/proc/task_mmu.c
>>> [...]
>>>> +static int pagemap_scan_output(bool wt, bool file, bool pres, bool swap,
>>>> +                              struct pagemap_scan_private *p,
>>>> +                              unsigned long addr, unsigned int n_pages)
>>>> +{
>>>> +       unsigned long bitmap = PM_SCAN_BITMAP(wt, file, pres, swap);
>>>> +       struct page_region *cur_buf = &p->cur_buf;
>>>
>>> Maybe we can go a step further and say here `cur_buf =
>>> &p->vec_buf[p->vec_buf_index];` and remove `p->cur_buf` entirely?
>> No, this cannot be done. vec_buf_index represents overall index in vec_buf
>> which is a user buffer. We cannot access it conveniently. This is why I'd
>> added cur_buf in the fisrt place.
Sorry, vec_buf_index starts from 0 in each smaller page walk. Whatever we
put in vec_buf is copied to user buffer and cur_buf isn't copied until we
walk over next pages. This seems straight forward to me. But in case as you
are saying that we start putting cur_buf inside vec_buf itself, we'll have
to be careful that we don't copy the last element to the user as we'll be
readjusting it and may be doing addition in next small page walk.

> 
> Wasn't this the case only before the intermediate p->vec_buf array was
> added? It is now a kmalloc()ed temporary and it isn't copied to
> userspace until the walk iteration finishes.
> 
> [...]
>>>> +       if (cur_buf->bitmap == bitmap &&
>>>> +           cur_buf->start + cur_buf->len * PAGE_SIZE == addr) {
>>>> +               cur_buf->len += n_pages;
>>>> +               p->found_pages += n_pages;
>>>> +       } else {
>>>> +               if (cur_buf->len && p->vec_buf_index >= p->vec_buf_len)
>>>> +                       return -ENOMEM;
>>>
>>> Shouldn't this be -ENOSPC? -ENOMEM usually signifies that the kernel
>>> ran out of memory when allocating, not that there is no space in a
>>> user-provided buffer.
>> There are 3 kinds of return values here:
>> * PM_SCAN_FOUND_MAX_PAGES (1) ---> max_pages have been found. Abort the
>> page walk from next entry
>> * 0 ---> continue the page walk
>> * -ENOMEM --> Abort the page walk from current entry, user buffer is full
>> which is not error, but only a stop signal. This -ENOMEM is just
>> differentiater from (1). This -ENOMEM is for internal use and isn't
>> returned to user.
> 
> But why ENOSPC is not good here? I was used before, I think.
-ENOSPC is being returned in form of true error from
pagemap_scan_hugetlb_entry(). So I'd to remove -ENOSPC from here as it
wasn't true error here, it was only a way to abort the walk immediately.
I'm liking the following erturn code from here now:

#define PM_SCAN_BUFFER_FULL	(-256)


> 
>>>> +               if (cur_buf->len) {
>>>> +                       memcpy(&p->vec_buf[p->vec_buf_index], cur_buf,
>>>> +                              sizeof(*p->vec_buf));
>>>> +                       p->vec_buf_index++;
>>>> +               }
>>>> +
>>>> +               cur_buf->start = addr;
>>>> +               cur_buf->len = n_pages;
>>>> +               cur_buf->bitmap = bitmap;
>>>> +               p->found_pages += n_pages;
>>>> +       }
>>>> +
>>>> +       if (p->max_pages && (p->found_pages == p->max_pages))
>>>
>>> Since `p->found_pages > 0` holds here, the first check is redundant.
>> I didn't get it. As the max_pages is optional, its validity needs to be
>> checked first.
> 
> I mean that `p->max_pages`, if 0, will never compare equal to
> `p->found_pages` here.
Okay, I'll update.

> 
>>> For flags name: PM_REQUIRE_WRITE_ACCESS?
>>> Or Is it intended to be checked only if doing WP (as the current name
>>> suggests) and so it would be redundant as WP currently requires
>>> `p->required_mask = PAGE_IS_WRITTEN`?
>> This is intended to indicate that if userfaultfd is needed. If
>> PAGE_IS_WRITTEN is mentioned in any of mask, we need to check if
>> userfaultfd has been initialized for this memory. I'll rename to
>> PM_SCAN_REQUIRE_UFFD.
> 
> Why do we need that check? Wouldn't `is_written = false` work for vmas
> not registered via uffd?
UFFD_FEATURE_WP_ASYNC and UNPOPULATED needs to be set on the memory region
for it to report correct written values on the memory region. Without UFFD
WP ASYNC and UNPOUPULATED defined on the memory, we consider UFFD_WP state
undefined. If user hasn't initialized memory with UFFD, he has no right to
set is_written = false.

> 
>>>> +static int pagemap_scan_args_valid(struct pm_scan_arg *arg, unsigned long start,
>>>> +                                  struct page_region __user *vec)
>>>> +{
>>>> +       /* Detect illegal size, flags, len and masks */
>>>> +       if (arg->size != sizeof(struct pm_scan_arg))
>>>> +               return -EINVAL;
>>>> +       if (arg->flags & ~PM_SCAN_OPS)
>>>> +               return -EINVAL;
>>>> +       if (!arg->len)
>>>> +               return -EINVAL;
>>>> +       if ((arg->required_mask | arg->anyof_mask | arg->excluded_mask |
>>>> +            arg->return_mask) & ~PM_SCAN_BITS_ALL)
>>>> +               return -EINVAL;
>>>> +       if (!arg->required_mask && !arg->anyof_mask &&
>>>> +           !arg->excluded_mask)
>>>> +               return -EINVAL;
>>>> +       if (!arg->return_mask)
>>>> +               return -EINVAL;
>>>
>>> I just noticed that `!arg->return_mask == !IS_PM_SCAN_GET()`. So the
>>> OP_GET is redundant and can be removed from the `flags` if checking
>>> `return_mask` instead. That way there won't be a "flags-encoded ops"
>>> thing as it would be a 'scan' with optional 'write-protect'.
>> I know it makes flags checking easier if we remove PM_SCAN_OP_GET. But
>> it'll created complications later if more OPs are added to the IOCTL. Lets
>> not remove it.
>>
>> Some history:
>> I'd PM_SCAN_OP_GET. Then someone asked me to remove it. Then someone asked
>> me to add it back.
>>
>>>
>>>> +
>>>> +       /* Validate memory range */
>>>> +       if (!IS_ALIGNED(start, PAGE_SIZE))
>>>> +               return -EINVAL;
>>>> +       if (!access_ok((void __user *)start, arg->len))
>>>> +               return -EFAULT;
>>>> +
>>>> +       if (IS_PM_SCAN_GET(arg->flags)) {
>>>> +               if (!arg->vec)
>>>> +                       return -EINVAL;
>>>
>>> access_ok() -> -EFAULT (an early fail-check) (the vec_len should be
>>> checked first then, failing with -EINVAL if 0)
>> I'd access_ok() for vec. But I removed it after discussion with you. Now I
>> only check that vec shouldn't be NULL:
>> https://lore.kernel.org/all/CABb0KFGru9xFCxyVHBcE+dkXe58=5wiCbvZGSWhuTfr4gn=MRQ@mail.gmail.com
> 
> Oh, indeed. It seems I then misunderstood what `access_ok()` does. It
> is only doing a sanity check on the pointer (range) and not actually
> verifying memory mapping validity. So as a early-fail check it's ok.
I'll re-add.

> 
> [...]
>>>> +               if (arg->vec_len == 0)
>>>> +                       return -EINVAL;
>>>> +       }
>>>> +
>>>> +       if (IS_PM_SCAN_WP(arg->flags)) {
>>>> +               if (!IS_PM_SCAN_GET(arg->flags) && arg->max_pages)
>>>> +                       return -EINVAL;
>>>> +
>>>> +               if ((arg->required_mask | arg->anyof_mask | arg->excluded_mask) &
>>>> +                   ~PAGE_IS_WRITTEN)
>>>
>>> Is `excluded_mask = PAGE_IS_WRITTEN` intended to be allowed? It would
>>> make WP do nothing, unless the required/anyof/excluded masks are not
>>> supposed to limit WP?
>> My intention is that no other flag than PAGE_IS_WRITTEN must be specified
>> in all masks if WP op is specified.
>>
>> If exluded_mask = PAGE_IS_WRITTEN,
>> * the page would be rejected if page is written. No need to WP these.
>> * Only those pages would be allowed which aren't written. Then would also
>> not write protected.
>>
>> So write protect operation wouldn't happen logically. It is on user for not
>> comprehending the combined meaning of WP op and excluded mask.
>>
>> Do you agree or do you want me to reject WP op if excluded = PAGE_IS_WRITTEN?
> 
> I see a bit of inconsistency here in that in some parts of the API we
> disallow nonsensical (no-op) parameters (like output_mask == 0 or
> required_mask == excluded_mask), but in others do not. I'd prefer to
> have it one way and if I had to choose I'd allow trivial no-ops to
> reduce the kernel-side code overhead.
> 
> The other topic is whether we should limit the page selection to
> PAGE_IS_WRITTEN for WP op. I don't see any benefit from that.
> 
> Maybe we should go back to the drawing board for a quick review: Can
> we decouple the responsibilities of the page selection from WP
> operation? I'd think yes - are there downsides to having the
> required/any/excluded masks limit the pages presented to GET and/or WP
> and have GET use returned_mask, max_pages, vec_buf+len and stop the
> scan after the limit is hit? WP would just act on whatever pages were
> accepted by the walk filter and (if enabled) GET output buffer.
No, we only take read mm lock. We need to WP only those pages which have
been noted to be written, the page passed the filtering with all the masks
and page successfully got added to user buffer. This would break if we try
to decouple.

> 
> Nit: I'd prefer the excluded_mask be replaced by inverted_mask, but we
> already discussed that so feel free to ignore. This would remove a bit
> of logic from the filtering code, and userspace could always wrap the
> ioctl in a function that converts from required+excluded into
> required+inverted.
> 
> While here, I wonder if we really need to fail the call if there are
> unknown bits in those masks set: if this bit set is expanded with
> another category flags, a newer userspace run on older kernel would
> get EINVAL even if the "treat unknown as 0" be what it requires.
> There is no simple way in the API to discover what bits the kernel
> supports. We could allow a no-op (no WP nor GET) call to help with
> that and then rejecting unknown bits would make sense.
I've not seen any examples of this. But I've seen examples of returning
error if kernel doesn't support a feature. Each new feature comes with a
kernel version, greater than this version support this feature. If user is
trying to use advanced feature which isn't present in a kernel, we should
return error and not proceed to confuse the user/kernel. In fact if we look
at userfaultfd_api(), we return error immediately if feature has some bit
set which kernel doesn't support.

> 
>>> [...]
>>>> --- a/include/uapi/linux/fs.h
>>>> +++ b/include/uapi/linux/fs.h
>>>> +/*
>>>> + * struct page_region - Page region with bitmap flags
>>>> + * @start:     Start of the region
>>>> + * @len:       Length of the region in pages
>>>> + * bitmap:     Bits sets for the region
>>>
>>> '@' is missing for the third field. BTW, maybe we can call it
>>> something like `flags` or `category` (something that hints at the
>>> meaning of the value instead of its data representation).
>> The deification of this struct says, "with bitmap flags". Bitmap was a
>> different name. I'll update it to flags.
> 
> From the implementation and our discussions I guess the
> `bitmap`/`flags` field is holding a set of matching categories: a bit
> value 1 = pages are in this category, value 0 = pages are not in this
> category.
> 
>>>> +/*
>>>> + * struct pm_scan_arg - Pagemap ioctl argument
>>>> + * @size:              Size of the structure
>>>> + * @flags:             Flags for the IOCTL
>>>> + * @start:             Starting address of the region
>>>> + * @len:               Length of the region (All the pages in this length are included)
>>>
>>> Maybe `scan_start`, `scan_len` - so that there is a better distinction
>>> from the structure's `size` field?
>> As start and len already communicate the meaning. We are making things more
>> verbose.
> 
> We are describing (in the name) only that it is a range, but not of
> what or what purpose. That information is only in the docstring, but
> it is harder to get by someone just reading the code.
Agreed. But I'm using same names, start and len which mincore (a historic
syscall) is using. I've followed mincore here.

> 
>>>> + * @vec:               Address of page_region struct array for output
>>>> + * @vec_len:           Length of the page_region struct array
>>>> + * @max_pages:         Optional max return pages
>>>> + * @required_mask:     Required mask - All of these bits have to be set in the PTE
>>>> + * @anyof_mask:                Any mask - Any of these bits are set in the PTE
>>>> + * @excluded_mask:     Exclude mask - None of these bits are set in the PTE
>>>> + * @return_mask:       Bits that are to be reported in page_region
>>>> + */
>>>
>>> I skipped most of the page walk implementation as maybe the comments
>>> above could make it simpler. Reading this patch and the documentation
>>> I still feel confused about how the filtering/limiting parameters
>> I'm really sad to hear this. I've been working on making this series from
>> so many revisions. I was hopping that it would make complete sense to
>> reviewers and later to users.
>>
>> What do you think is missing which is restricting these patches getting
>> accepted to upstream?
>>
>>> should affect GET, WP and WP+GET. Should they limit the pages walked
>>> (and WP-ed)? Or only the GET's output? How about GET+WP case?
>> The address range needs to be walked until max pages pages are found, user
>> buffer is full or whole range is walked. If the page will be added to user
>> buffer or not depends on the selection criteria (*masks). There is no
>> difference in case of walk for GET, WP and GET+WP. Only that WP doesn't
>> take any user buffer and just WPs the whole region.
> 
> Ok, then this intent (if I understand correctly) does not entirely
> match the implementation. Let's split up the conditions:
> 
> 1. The address range needs to be walked until max pages pages are found
> 
> current implementation: the address range is walked until max pages
> matching masks (incl. return_mask) are reported by GET (or until end
> of range if GET is not requested).
> Maybe we need to describe what "found" means here?
Found means all the pages which are found to be fulfilling the masks and we
have added it to the user buffer. I can add the comment on top of
pagemap_scan_private struct? But I don't think that it is difficult to
understand the meaning of found_pages and also we compare it with max_pages
which makes things very easy to understand.

> 
> 2. user buffer is full
> 
> Matches implementation except in GET+WP edge cases.
I'm not sure which edge case you are referring to? Probably for hugetlb
error return case?

> 
> 3. or whole range is walked
> 
> Matches implementation.
> 
> 4.  If the page will be added to user buffer or not depends on the
> selection criteria (*masks).
> 
> Is `return_mask` a selection criterion? The implementation does skip
> (counting and outputting) pages where (category_mask & return_mask) ==
> 0.
No, it shouldn't be a selection criterion. I guess, right now I've wrong
implementation of this mask. Return mask should just mask the flags:

@@ -1894,8 +1894,8 @@ static int pagemap_scan_output(bool wt, bool file,
bool pres, bool swap,
                return 0;

        flags &= p->return_mask;
-       if (!flags)
-               return 0;

If user want to find the write status of all PRESENT pages, required_mask =
PRESENT and RETURN_MASK = WRITTEN. Thoughts?

> 
> 5. There is no difference in case of walk for GET, WP and GET+WP.
> 
> I'm not sure I understand this condition: Is it that the sequence of
> pages walked does not depend on the operations? If so, then I think
> the implementation matches (not entirely sure, though).
Yeah, correct.

> 
> 6. Only that WP doesn't take any user buffer
> 
> Matches implementation (trivial).
> 
> 7. ... and just WPs the whole region.
> 
> Follows from current implementation for #1.
> 
> But there is an additional restriction:
> - if using WP, masks can only contain IS_WRITTEN.
> 
> Summing this up: I think the number of interactions between various
> parameters can be reduced:
> a. required/anyof/excluded masks apply to the operation as a whole
> (selecting pages to act on); and
> b. returned_mask, max_pages, vec_buf+len apply to GET and stop the
> walk early if limits are hit (checked before WP is done)
> 
> That way we can conceptually decouple WP from the selection of pages
> and don't need to restrict the page masks to IS_WRITTEN. This makes
> the operation basically a GET (SCAN as the ioctl name suggests) with
> an auxiliary and optional WP (IOW: pages walked don't depend on WP
> operation being requested or not). This also matches the current
> implementation, where plain WP can be done via UFFD-specific call.
Your explanation is very thoughtful. Decoupling will surely help in making
things simpler and very easy to understand. I'll make the change to
decouple WP op from masks.

@@ -2141,9 +2141,9 @@ static int pagemap_scan_args_valid(struct pm_scan_arg
*arg, unsigned long start,
                if (!IS_PM_SCAN_GET(arg->flags) && arg->max_pages)
                        return -EINVAL;

-               if ((arg->required_mask | arg->anyof_mask |
arg->excluded_mask) &
-                   ~PAGE_IS_WRITTEN)
-                       return -EINVAL;


> (BTW, why the UFFD one has to be slower?)
Probably the worse case of 6ce64428d6 is hitting and making writes slower:
https://lore.kernel.org/all/ZG4Xb3rYK0p8BoB9@x1n

> 
> (Note: my intent in this discussion is to minimise the effort needed
> to understand how to use and what are the restrictions of the API -
> and doing this by minimizing the number and size of rules that one has
> to apply. Nb. this is proportional to number of rules in
> ...args_validate().)
> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
