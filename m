Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40E0731C33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 17:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241701AbjFOPL7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 11:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241506AbjFOPL6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:11:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B233B26A2;
        Thu, 15 Jun 2023 08:11:56 -0700 (PDT)
Received: from [192.168.10.55] (unknown [119.155.33.163])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3C6876606F67;
        Thu, 15 Jun 2023 16:11:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686841914;
        bh=3MdXnp0rnSSfhyFgYUFW/54WeVSBpiq5xrBJ+WJvLTA=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=cvv4yiSDjEqgmaVk30lc/A1N18hlWQXP3t4XFBlUoaAfMgs9xX8+1fJ5yWk2NNoZj
         AJ5m9Lp/q9ZnW30G5WveI2rouU5wWSBuXVAsJKd4oImv66qsD9JWkacs4Vtd2rrkZJ
         cc1/RWaVKeHBPd9N62Ee7eClRJfHdeNtDZx6GTCQLp5cwipiuxWKv/lrPHoE99BxVI
         dOAQjfANwl/WlLvqh572WAxqxz4Ih3vvdqLhLl78MhDSDLAzyi00oQ2L+BsoxafukV
         42aI37Al5R1KTGWwek9J/wPw+dDcRmAewfO6178tNZDU9KlbEKJ22FKmqWZBvzHFTc
         JP+tS0tnOv6Bw==
Message-ID: <39bc8212-9ee8-dbc1-d468-f6be438b683b@collabora.com>
Date:   Thu, 15 Jun 2023 20:11:42 +0500
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
 <34203acf-7270-7ade-a60e-ae0f729dcf70@collabora.com>
 <CABb0KFFaXgJD99pWfx3MC+qrq5jUaPis_kZo6U8yL_8xdp0GJA@mail.gmail.com>
 <96b7cc00-d213-ad7d-1b48-b27f75b04d22@collabora.com>
 <CABb0KFEy_mRaT86TEOQ-BoTe_XOVw3Kp5VdzOfEEaiZJuT754g@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFEy_mRaT86TEOQ-BoTe_XOVw3Kp5VdzOfEEaiZJuT754g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/15/23 7:52 PM, Michał Mirosław wrote:
> On Thu, 15 Jun 2023 at 15:58, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>> I'll send next revision now.
>> On 6/14/23 11:00 PM, Michał Mirosław wrote:
>>> (A quick reply to answer open questions in case they help the next version.)
>>>
>>> On Wed, 14 Jun 2023 at 19:10, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>> On 6/14/23 8:14 PM, Michał Mirosław wrote:
>>>>> On Wed, 14 Jun 2023 at 15:46, Muhammad Usama Anjum
>>>>> <usama.anjum@collabora.com> wrote:
>>>>>>
>>>>>> On 6/14/23 3:36 AM, Michał Mirosław wrote:
>>>>>>> On Tue, 13 Jun 2023 at 12:29, Muhammad Usama Anjum
>>>>>>> <usama.anjum@collabora.com> wrote:
>>> [...]
>>>>>>>> +       if (cur_buf->bitmap == bitmap &&
>>>>>>>> +           cur_buf->start + cur_buf->len * PAGE_SIZE == addr) {
>>>>>>>> +               cur_buf->len += n_pages;
>>>>>>>> +               p->found_pages += n_pages;
>>>>>>>> +       } else {
>>>>>>>> +               if (cur_buf->len && p->vec_buf_index >= p->vec_buf_len)
>>>>>>>> +                       return -ENOMEM;
>>>>>>>
>>>>>>> Shouldn't this be -ENOSPC? -ENOMEM usually signifies that the kernel
>>>>>>> ran out of memory when allocating, not that there is no space in a
>>>>>>> user-provided buffer.
>>>>>> There are 3 kinds of return values here:
>>>>>> * PM_SCAN_FOUND_MAX_PAGES (1) ---> max_pages have been found. Abort the
>>>>>> page walk from next entry
>>>>>> * 0 ---> continue the page walk
>>>>>> * -ENOMEM --> Abort the page walk from current entry, user buffer is full
>>>>>> which is not error, but only a stop signal. This -ENOMEM is just
>>>>>> differentiater from (1). This -ENOMEM is for internal use and isn't
>>>>>> returned to user.
>>>>>
>>>>> But why ENOSPC is not good here? I was used before, I think.
>>>> -ENOSPC is being returned in form of true error from
>>>> pagemap_scan_hugetlb_entry(). So I'd to remove -ENOSPC from here as it
>>>> wasn't true error here, it was only a way to abort the walk immediately.
>>>> I'm liking the following erturn code from here now:
>>>>
>>>> #define PM_SCAN_BUFFER_FULL     (-256)
>>>
>>> I guess this will be reworked anyway, but I'd prefer this didn't need
>>> custom errors etc. If we agree to decoupling the selection and GET
>>> output, it could be:
>>>
>>> bool is_interesting_page(p, flags); // this one does the
>>> required/anyof/excluded match
>>> size_t output_range(p, start, len, flags); // this one fills the
>>> output vector and returns how many pages were fit
>>>
>>> In this setup, `is_interesting_page() && (n_out = output_range()) <
>>> n_pages` means this is the final range, no more will fit. And if
>>> `n_out == 0` then no pages fit and no WP is needed (no other special
>>> cases).
>> Right now, pagemap_scan_output() performs the work of both of these two
>> functions. The part can be broken into is_interesting_pages() and we can
>> leave the remaining part as it is.
>>
>> Saying that n_out < n_pages tells us the buffer is full covers one case.
>> But there is case of maximum pages have been found and walk needs to be
>> aborted.
> 
> This case is exactly what `n_out < n_pages` will cover (if scan_output
> uses max_pages properly to limit n_out).
> Isn't it that when the buffer is full we want to abort the scan always
> (with WP if `n_out > 0`)?
Wouldn't it be duplication of condition if buffer is full inside
pagemap_scan_output() and just outside it. Inside pagemap_scan_output() we
check if we have space before putting data inside it. I'm using this same
condition to indicate that buffer is full.

> 
>>>>>>> For flags name: PM_REQUIRE_WRITE_ACCESS?
>>>>>>> Or Is it intended to be checked only if doing WP (as the current name
>>>>>>> suggests) and so it would be redundant as WP currently requires
>>>>>>> `p->required_mask = PAGE_IS_WRITTEN`?
>>>>>> This is intended to indicate that if userfaultfd is needed. If
>>>>>> PAGE_IS_WRITTEN is mentioned in any of mask, we need to check if
>>>>>> userfaultfd has been initialized for this memory. I'll rename to
>>>>>> PM_SCAN_REQUIRE_UFFD.
>>>>>
>>>>> Why do we need that check? Wouldn't `is_written = false` work for vmas
>>>>> not registered via uffd?
>>>> UFFD_FEATURE_WP_ASYNC and UNPOPULATED needs to be set on the memory region
>>>> for it to report correct written values on the memory region. Without UFFD
>>>> WP ASYNC and UNPOUPULATED defined on the memory, we consider UFFD_WP state
>>>> undefined. If user hasn't initialized memory with UFFD, he has no right to
>>>> set is_written = false.
>>>
>>> How about calculating `is_written = is_uffd_registered() &&
>>> is_uffd_wp()`? This would enable a user to apply GET+WP for the whole
>>> address space of a process regardless of whether all of it is
>>> registered.
>> I wouldn't want to check if uffd is registered again and again. This is why
>> we are doing it only once every walk in pagemap_scan_test_walk().
> 
> There is no need to do the checks repeatedly. If I understand the code
> correctly, uffd registration is per-vma, so it can be communicated
> from test_walk to entry/hole callbacks via a field in
> pagemap_scan_private.
> 
>>>>> While here, I wonder if we really need to fail the call if there are
>>>>> unknown bits in those masks set: if this bit set is expanded with
>>>>> another category flags, a newer userspace run on older kernel would
>>>>> get EINVAL even if the "treat unknown as 0" be what it requires.
>>>>> There is no simple way in the API to discover what bits the kernel
>>>>> supports. We could allow a no-op (no WP nor GET) call to help with
>>>>> that and then rejecting unknown bits would make sense.
>>>> I've not seen any examples of this. But I've seen examples of returning
>>>> error if kernel doesn't support a feature. Each new feature comes with a
>>>> kernel version, greater than this version support this feature. If user is
>>>> trying to use advanced feature which isn't present in a kernel, we should
>>>> return error and not proceed to confuse the user/kernel. In fact if we look
>>>> at userfaultfd_api(), we return error immediately if feature has some bit
>>>> set which kernel doesn't support.
>>>
>>> I think we should have a way of detecting the supported flags if we
>>> don't want a forward compatibility policy for flags here. Maybe it
>>> would be enough to allow all the no-op combinations for this purpose?
>> Again I don't think UFFD is doing anything like this.
> 
> If it's cheap and easy to provide a user with a way to detect the
> supported features - why not do it?
I'm sorry. But it would bring up something new and iterations will be
needed to just play around. I like the UFFD way.
> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
