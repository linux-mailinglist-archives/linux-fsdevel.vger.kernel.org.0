Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5902373005C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 15:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245113AbjFNNrA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 09:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbjFNNqy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:46:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C771FFA;
        Wed, 14 Jun 2023 06:46:51 -0700 (PDT)
Received: from [192.168.10.54] (unknown [119.155.33.163])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DC7DE6606F20;
        Wed, 14 Jun 2023 14:46:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686750409;
        bh=Cq5M4lwyqoBqWQ1eWw0gmvlCQBKHVEqfvS5019IznPE=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=UXHcDCmSSzzVdfy/KhFc9BPZiTOcUSzjFZq7g92WQvr9nygUV5XsCLnpfJh4G+XqF
         QrGZkkSASv9ttJ7rvHhwCUfb5IgEnNbSIpS/BJoUTX/kaNOJjN6lg3+tk3GWeCW2cc
         TnXl5hu5wAWzU5QclKwi9KlzmUmtvXKpiRTWl/dhyLDzCYbzGhMOveptJmYR1X03gc
         MAKQO5lCXIV6e1YxYuUq9IJjCrY43wYO6PI/wE8rzD893Ouaht/UkpnvXNuzGAPdAa
         lart6D6tGa5i6y5zUr/GtEcveae1ktpSfRHXCUtjOQZoXAgLFbatVTR0SvB0MegCuh
         N78ixIbGBcpaA==
Message-ID: <0db01d90-09d6-08a4-bbb8-70670d3baa94@collabora.com>
Date:   Wed, 14 Jun 2023 18:46:37 +0500
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
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFHWnbrf2ythvO0OKsd1ZS9b4D9BNzwBCbn6g9OX4n6ZOg@mail.gmail.com>
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

On 6/14/23 3:36 AM, Michał Mirosław wrote:
> On Tue, 13 Jun 2023 at 12:29, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
>> the info about page table entries. The following operations are supported
>> in this ioctl:
>> - Get the information if the pages have been written-to (PAGE_IS_WRITTEN),
>>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
>>   (PAGE_IS_SWAPPED).
>> - Find pages which have been written-to and/or write protect the pages
>>   (atomic PM_SCAN_OP_GET + PM_SCAN_OP_WP)
>>
>> This IOCTL can be extended to get information about more PTE bits.
> [...]
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
> [...]
>> +static int pagemap_scan_output(bool wt, bool file, bool pres, bool swap,
>> +                              struct pagemap_scan_private *p,
>> +                              unsigned long addr, unsigned int n_pages)
>> +{
>> +       unsigned long bitmap = PM_SCAN_BITMAP(wt, file, pres, swap);
>> +       struct page_region *cur_buf = &p->cur_buf;
> 
> Maybe we can go a step further and say here `cur_buf =
> &p->vec_buf[p->vec_buf_index];` and remove `p->cur_buf` entirely?
No, this cannot be done. vec_buf_index represents overall index in vec_buf
which is a user buffer. We cannot access it conveniently. This is why I'd
added cur_buf in the fisrt place.

> 
>> +
>> +       if (!n_pages)
>> +               return -EINVAL;
>> +
>> +       if ((p->required_mask & bitmap) != p->required_mask)
>> +               return 0;
>> +       if (p->anyof_mask && !(p->anyof_mask & bitmap))
>> +               return 0;
>> +       if (p->excluded_mask & bitmap)
>> +               return 0;
>> +
>> +       bitmap &= p->return_mask;
>> +       if (!bitmap)
>> +               return 0;
>> +
>> +       if (cur_buf->bitmap == bitmap &&
>> +           cur_buf->start + cur_buf->len * PAGE_SIZE == addr) {
>> +               cur_buf->len += n_pages;
>> +               p->found_pages += n_pages;
>> +       } else {
>> +               if (cur_buf->len && p->vec_buf_index >= p->vec_buf_len)
>> +                       return -ENOMEM;
> 
> Shouldn't this be -ENOSPC? -ENOMEM usually signifies that the kernel
> ran out of memory when allocating, not that there is no space in a
> user-provided buffer.
There are 3 kinds of return values here:
* PM_SCAN_FOUND_MAX_PAGES (1) ---> max_pages have been found. Abort the
page walk from next entry
* 0 ---> continue the page walk
* -ENOMEM --> Abort the page walk from current entry, user buffer is full
which is not error, but only a stop signal. This -ENOMEM is just
differentiater from (1). This -ENOMEM is for internal use and isn't
returned to user.

I think it would be better to use following in place of -ENOMEM:
#define PM_SCAN_BUFFER_FULL	(-256)

I'll update.

> 
> BTW, the check could be inside the if() below for easier reading and
> less redundancy.
Sure.

> 
>> +               if (cur_buf->len) {
>> +                       memcpy(&p->vec_buf[p->vec_buf_index], cur_buf,
>> +                              sizeof(*p->vec_buf));
>> +                       p->vec_buf_index++;
>> +               }
>> +
>> +               cur_buf->start = addr;
>> +               cur_buf->len = n_pages;
>> +               cur_buf->bitmap = bitmap;
>> +               p->found_pages += n_pages;
>> +       }
>> +
>> +       if (p->max_pages && (p->found_pages == p->max_pages))
> 
> Since `p->found_pages > 0` holds here, the first check is redundant.
I didn't get it. As the max_pages is optional, its validity needs to be
checked first.

> Nit: the parentheses around == are not needed.
Sure, I'll update.

> 
>> +               return PM_SCAN_FOUND_MAX_PAGES;
>> +
>> +       return 0;
>> +}
> [...]
>> +static inline unsigned long pagemap_scan_check_page_written(struct pagemap_scan_private *p)
>> +{
>> +       return ((p->required_mask | p->anyof_mask | p->excluded_mask) &
>> +               PAGE_IS_WRITTEN) ? PM_SCAN_OP_WRITE : 0;
>> +}
> 
> Please inline at the single callsite.
Sure.

> 
> For flags name: PM_REQUIRE_WRITE_ACCESS?
> Or Is it intended to be checked only if doing WP (as the current name
> suggests) and so it would be redundant as WP currently requires
> `p->required_mask = PAGE_IS_WRITTEN`?
This is intended to indicate that if userfaultfd is needed. If
PAGE_IS_WRITTEN is mentioned in any of mask, we need to check if
userfaultfd has been initialized for this memory. I'll rename to
PM_SCAN_REQUIRE_UFFD.

> 
>> +static int pagemap_scan_args_valid(struct pm_scan_arg *arg, unsigned long start,
>> +                                  struct page_region __user *vec)
>> +{
>> +       /* Detect illegal size, flags, len and masks */
>> +       if (arg->size != sizeof(struct pm_scan_arg))
>> +               return -EINVAL;
>> +       if (arg->flags & ~PM_SCAN_OPS)
>> +               return -EINVAL;
>> +       if (!arg->len)
>> +               return -EINVAL;
>> +       if ((arg->required_mask | arg->anyof_mask | arg->excluded_mask |
>> +            arg->return_mask) & ~PM_SCAN_BITS_ALL)
>> +               return -EINVAL;
>> +       if (!arg->required_mask && !arg->anyof_mask &&
>> +           !arg->excluded_mask)
>> +               return -EINVAL;
>> +       if (!arg->return_mask)
>> +               return -EINVAL;
> 
> I just noticed that `!arg->return_mask == !IS_PM_SCAN_GET()`. So the
> OP_GET is redundant and can be removed from the `flags` if checking
> `return_mask` instead. That way there won't be a "flags-encoded ops"
> thing as it would be a 'scan' with optional 'write-protect'.
I know it makes flags checking easier if we remove PM_SCAN_OP_GET. But
it'll created complications later if more OPs are added to the IOCTL. Lets
not remove it.

Some history:
I'd PM_SCAN_OP_GET. Then someone asked me to remove it. Then someone asked
me to add it back.

> 
>> +
>> +       /* Validate memory range */
>> +       if (!IS_ALIGNED(start, PAGE_SIZE))
>> +               return -EINVAL;
>> +       if (!access_ok((void __user *)start, arg->len))
>> +               return -EFAULT;
>> +
>> +       if (IS_PM_SCAN_GET(arg->flags)) {
>> +               if (!arg->vec)
>> +                       return -EINVAL;
> 
> access_ok() -> -EFAULT (an early fail-check) (the vec_len should be
> checked first then, failing with -EINVAL if 0)
I'd access_ok() for vec. But I removed it after discussion with you. Now I
only check that vec shouldn't be NULL:
https://lore.kernel.org/all/CABb0KFGru9xFCxyVHBcE+dkXe58=5wiCbvZGSWhuTfr4gn=MRQ@mail.gmail.com


[...]
>>> +       if (!access_ok((void __user *)vec,
>>> +                      arg->vec_len * sizeof(struct page_region)))
>>> +               return false;
>>
>> Is there a provision that userspace threads are all blocked from
>> manipulating mmaps during this ioctl()? If not, this is a TOCTOU bug
>> and the writes should be checked each time as another userspace thread
>> could remap the memory while the ioctl() is working.
> mincore() syscall is doing in the same way. It checks the validity in the
> start only. What provision should I add? Isn't it obvious that the user
> should not remap such memory?

On the second look, I think the code already checks that while doing
copy_to_user(), so this check is redundant and can be removed.


> 
>> +               if (arg->vec_len == 0)
>> +                       return -EINVAL;
>> +       }
>> +
>> +       if (IS_PM_SCAN_WP(arg->flags)) {
>> +               if (!IS_PM_SCAN_GET(arg->flags) && arg->max_pages)
>> +                       return -EINVAL;
>> +
>> +               if ((arg->required_mask | arg->anyof_mask | arg->excluded_mask) &
>> +                   ~PAGE_IS_WRITTEN)
> 
> Is `excluded_mask = PAGE_IS_WRITTEN` intended to be allowed? It would
> make WP do nothing, unless the required/anyof/excluded masks are not
> supposed to limit WP?
My intention is that no other flag than PAGE_IS_WRITTEN must be specified
in all masks if WP op is specified.

If exluded_mask = PAGE_IS_WRITTEN,
* the page would be rejected if page is written. No need to WP these.
* Only those pages would be allowed which aren't written. Then would also
not write protected.

So write protect operation wouldn't happen logically. It is on user for not
comprehending the combined meaning of WP op and excluded mask.

Do you agree or do you want me to reject WP op if excluded = PAGE_IS_WRITTEN?

> 
> 
>> +                       return -EINVAL;
>> +       }
> 
> If `flags == 0` (and `return_mask == 0` in case my earlier comment is
> applied) it should fail with -EINVAL.
I'll add flags==0 condition.

> 
> [...]
>> --- a/include/uapi/linux/fs.h
>> +++ b/include/uapi/linux/fs.h
>> +/*
>> + * struct page_region - Page region with bitmap flags
>> + * @start:     Start of the region
>> + * @len:       Length of the region in pages
>> + * bitmap:     Bits sets for the region
> 
> '@' is missing for the third field. BTW, maybe we can call it
> something like `flags` or `category` (something that hints at the
> meaning of the value instead of its data representation).
The deification of this struct says, "with bitmap flags". Bitmap was a
different name. I'll update it to flags.

> 
>> +/*
>> + * struct pm_scan_arg - Pagemap ioctl argument
>> + * @size:              Size of the structure
>> + * @flags:             Flags for the IOCTL
>> + * @start:             Starting address of the region
>> + * @len:               Length of the region (All the pages in this length are included)
> 
> Maybe `scan_start`, `scan_len` - so that there is a better distinction
> from the structure's `size` field?
As start and len already communicate the meaning. We are making things more
verbose.

> 
>> + * @vec:               Address of page_region struct array for output
>> + * @vec_len:           Length of the page_region struct array
>> + * @max_pages:         Optional max return pages
>> + * @required_mask:     Required mask - All of these bits have to be set in the PTE
>> + * @anyof_mask:                Any mask - Any of these bits are set in the PTE
>> + * @excluded_mask:     Exclude mask - None of these bits are set in the PTE
>> + * @return_mask:       Bits that are to be reported in page_region
>> + */
> 
> I skipped most of the page walk implementation as maybe the comments
> above could make it simpler. Reading this patch and the documentation
> I still feel confused about how the filtering/limiting parameters
I'm really sad to hear this. I've been working on making this series from
so many revisions. I was hopping that it would make complete sense to
reviewers and later to users.

What do you think is missing which is restricting these patches getting
accepted to upstream?

> should affect GET, WP and WP+GET. Should they limit the pages walked
> (and WP-ed)? Or only the GET's output? How about GET+WP case?
The address range needs to be walked until max pages pages are found, user
buffer is full or whole range is walked. If the page will be added to user
buffer or not depends on the selection criteria (*masks). There is no
difference in case of walk for GET, WP and GET+WP. Only that WP doesn't
take any user buffer and just WPs the whole region.


> 
> Best Regards
> 
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
