Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5555F73280E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 08:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjFPG5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 02:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbjFPG5k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:57:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61991FF5;
        Thu, 15 Jun 2023 23:57:38 -0700 (PDT)
Received: from [192.168.10.55] (unknown [119.155.33.163])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C34F56606F1A;
        Fri, 16 Jun 2023 07:57:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686898657;
        bh=Omzo0pLNcXzbmnJ6mj+hFNJQNMry5y1BPxh4GdO6tsE=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=fuhb4Evg3aejWQIX4CKPzco+2hgCL3d6CyC4qsV3igE3nOOZKISrKbp0AbrkKHnlX
         ijAYqKE4+v19IQsFGYoAbaYk5GVXdvGlAcQza+BBCNqTQFJFNlUOyvPq4CQDxmAN7H
         4CxItF6P4ZlHecWC2qfhrBIz2HmTDaabArJ8in7K8PiIRc3NYp6yIlnm9Fn0pUwIK1
         /G2ZC8HkUSco0P4gTBMmvaOEH13ZrR8jeh0dbY1LU9MdvozBv829fCfOdKQlZs74XU
         nKihSFE3NtHpqQg/sYM4j/Rvg5WJxlgKt5vJ+QMa7srQfrqTnECJ2ROQT7xdt9KF/G
         eegFGSxYPvvrQ==
Message-ID: <2e1b80f1-0385-0674-ae5f-9703a6ef975d@collabora.com>
Date:   Fri, 16 Jun 2023 11:57:27 +0500
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
 <39bc8212-9ee8-dbc1-d468-f6be438b683b@collabora.com>
 <CABb0KFHx2hV9M7oinCdKnagRmcrGHagH9eAO3TkVTQH+o9x=5A@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFHx2hV9M7oinCdKnagRmcrGHagH9eAO3TkVTQH+o9x=5A@mail.gmail.com>
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

On 6/16/23 1:07 AM, Michał Mirosław wrote:
> On Thu, 15 Jun 2023 at 17:11, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>> On 6/15/23 7:52 PM, Michał Mirosław wrote:
>>> On Thu, 15 Jun 2023 at 15:58, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>> I'll send next revision now.
>>>> On 6/14/23 11:00 PM, Michał Mirosław wrote:
>>>>> (A quick reply to answer open questions in case they help the next version.)
>>>>>
>>>>> On Wed, 14 Jun 2023 at 19:10, Muhammad Usama Anjum
>>>>> <usama.anjum@collabora.com> wrote:
>>>>>> On 6/14/23 8:14 PM, Michał Mirosław wrote:
>>>>>>> On Wed, 14 Jun 2023 at 15:46, Muhammad Usama Anjum
>>>>>>> <usama.anjum@collabora.com> wrote:
>>>>>>>>
>>>>>>>> On 6/14/23 3:36 AM, Michał Mirosław wrote:
>>>>>>>>> On Tue, 13 Jun 2023 at 12:29, Muhammad Usama Anjum
>>>>>>>>> <usama.anjum@collabora.com> wrote:
>>>>> [...]
>>>>>>>>>> +       if (cur_buf->bitmap == bitmap &&
>>>>>>>>>> +           cur_buf->start + cur_buf->len * PAGE_SIZE == addr) {
>>>>>>>>>> +               cur_buf->len += n_pages;
>>>>>>>>>> +               p->found_pages += n_pages;
>>>>>>>>>> +       } else {
>>>>>>>>>> +               if (cur_buf->len && p->vec_buf_index >= p->vec_buf_len)
>>>>>>>>>> +                       return -ENOMEM;
>>>>>>>>>
>>>>>>>>> Shouldn't this be -ENOSPC? -ENOMEM usually signifies that the kernel
>>>>>>>>> ran out of memory when allocating, not that there is no space in a
>>>>>>>>> user-provided buffer.
>>>>>>>> There are 3 kinds of return values here:
>>>>>>>> * PM_SCAN_FOUND_MAX_PAGES (1) ---> max_pages have been found. Abort the
>>>>>>>> page walk from next entry
>>>>>>>> * 0 ---> continue the page walk
>>>>>>>> * -ENOMEM --> Abort the page walk from current entry, user buffer is full
>>>>>>>> which is not error, but only a stop signal. This -ENOMEM is just
>>>>>>>> differentiater from (1). This -ENOMEM is for internal use and isn't
>>>>>>>> returned to user.
>>>>>>>
>>>>>>> But why ENOSPC is not good here? I was used before, I think.
>>>>>> -ENOSPC is being returned in form of true error from
>>>>>> pagemap_scan_hugetlb_entry(). So I'd to remove -ENOSPC from here as it
>>>>>> wasn't true error here, it was only a way to abort the walk immediately.
>>>>>> I'm liking the following erturn code from here now:
>>>>>>
>>>>>> #define PM_SCAN_BUFFER_FULL     (-256)
>>>>>
>>>>> I guess this will be reworked anyway, but I'd prefer this didn't need
>>>>> custom errors etc. If we agree to decoupling the selection and GET
>>>>> output, it could be:
>>>>>
>>>>> bool is_interesting_page(p, flags); // this one does the
>>>>> required/anyof/excluded match
>>>>> size_t output_range(p, start, len, flags); // this one fills the
>>>>> output vector and returns how many pages were fit
>>>>>
>>>>> In this setup, `is_interesting_page() && (n_out = output_range()) <
>>>>> n_pages` means this is the final range, no more will fit. And if
>>>>> `n_out == 0` then no pages fit and no WP is needed (no other special
>>>>> cases).
>>>> Right now, pagemap_scan_output() performs the work of both of these two
>>>> functions. The part can be broken into is_interesting_pages() and we can
>>>> leave the remaining part as it is.
>>>>
>>>> Saying that n_out < n_pages tells us the buffer is full covers one case.
>>>> But there is case of maximum pages have been found and walk needs to be
>>>> aborted.
>>>
>>> This case is exactly what `n_out < n_pages` will cover (if scan_output
>>> uses max_pages properly to limit n_out).
>>> Isn't it that when the buffer is full we want to abort the scan always
>>> (with WP if `n_out > 0`)?
>> Wouldn't it be duplication of condition if buffer is full inside
>> pagemap_scan_output() and just outside it. Inside pagemap_scan_output() we
>> check if we have space before putting data inside it. I'm using this same
>> condition to indicate that buffer is full.
> 
> I'm not sure what do you mean? The buffer-full conditions would be
> checked in ..scan_output() and communicated to the caller by returning
> N less than `n_pages` passed in. This is exactly how e.g. read()
> works: if you get less than requested you've hit the end of the file.
> If the file happens to have size that is equal to the provided buffer
> length, the next read() will return 0.
Right now we have:

pagemap_scan_output():
	if (p->vec_buf_index >= p->vec_buf_len)
		return PM_SCAN_BUFFER_FULL;
	if (p->found_pages == p->max_pages)
		return PM_SCAN_FOUND_MAX_PAGES;

pagemap_scan_pmd_entry():
	ret = pagemap_scan_output(bitmap, p, start, n_pages);
	if (ret >= 0) // success
		make_UFFD_WP and flush
	else
		buffer_error

You are asking me to do:

pagemap_scan_output():
	if (p->vec_buf_index >= p->vec_buf_len)
		return 0;
	if (p->found_pages == p->max_pages)
		return PM_SCAN_FOUND_MAX_PAGES;

pagemap_scan_pmd_entry():
	ret = pagemap_scan_output(bitmap, p, start, n_pages);
	if (ret > 0) // success
		make_UFFD_WP and flush
	else if (ret == 0) // buffer full
		return PM_SCAN_BUFFER_FULL;	
	else //other errors
		buffer_error

So you are asking me to go from consie code to write more lines of code. I
would write more lines without any issue if it improves readability and
logical sense. But I don't see here any benefit.

> 
>>>>>>> While here, I wonder if we really need to fail the call if there are
>>>>>>> unknown bits in those masks set: if this bit set is expanded with
>>>>>>> another category flags, a newer userspace run on older kernel would
>>>>>>> get EINVAL even if the "treat unknown as 0" be what it requires.
>>>>>>> There is no simple way in the API to discover what bits the kernel
>>>>>>> supports. We could allow a no-op (no WP nor GET) call to help with
>>>>>>> that and then rejecting unknown bits would make sense.
>>>>>> I've not seen any examples of this. But I've seen examples of returning
>>>>>> error if kernel doesn't support a feature. Each new feature comes with a
>>>>>> kernel version, greater than this version support this feature. If user is
>>>>>> trying to use advanced feature which isn't present in a kernel, we should
>>>>>> return error and not proceed to confuse the user/kernel. In fact if we look
>>>>>> at userfaultfd_api(), we return error immediately if feature has some bit
>>>>>> set which kernel doesn't support.
>>>>>
>>>>> I think we should have a way of detecting the supported flags if we
>>>>> don't want a forward compatibility policy for flags here. Maybe it
>>>>> would be enough to allow all the no-op combinations for this purpose?
>>>> Again I don't think UFFD is doing anything like this.
>>>
>>> If it's cheap and easy to provide a user with a way to detect the
>>> supported features - why not do it?
>> I'm sorry. But it would bring up something new and iterations will be
>> needed to just play around. I like the UFFD way.
> 
> Let's then first agree on what would have to be changed. I guess we
> could leverage that `scan_len = 0` doesn't make much sense otherwise
> and let it be used to check the other fields for support.
We are making things more and more complex. I don't like multi-plexing
variables. Can you give examples where multi-plexing has been done on
variables inside linux kernel? Muti-plexing means user gives input and
takes output from same variable. It makes variable double meaning.

> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
