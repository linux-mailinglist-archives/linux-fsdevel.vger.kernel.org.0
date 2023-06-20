Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADD2736AB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 13:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjFTLQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 07:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjFTLQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:16:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81130E41;
        Tue, 20 Jun 2023 04:16:07 -0700 (PDT)
Received: from [192.168.10.54] (unknown [119.155.63.248])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 625B56606F8B;
        Tue, 20 Jun 2023 12:15:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687259765;
        bh=9GLoBafzRKep+sfRcHSOXwHpBcUQH7mDHyYgcZt+Ayo=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=nuRdlc/dlE4e+aZlxWLESNo2ASmaZ9pydw7shRqKbOuVl6ZV2pE7U+gUqVBjVjmqE
         XKrx1Fi8LV5uvNBV7NzQcQA+FlyVHDifO4VuB50ITuTeqjQxbXyBF+T+kA+nu+9KnP
         eEnfoUPlAlMkw5ELiNCnI+gCVnTPw4zl6uFzI8aKeqr/B4SpVDz1mZMiBxyG9qTo+p
         cVubvh598HIQVoF0HMAEHsvvHqe8Wgu1ieFCf6y21KRvwIdVt8W3G262bFPOu7GX2/
         u47jq44EqqR2k+MaUSV2BBDlx/7d5xwDa4380MFiMfITvxCXPD8RoC3DlTZQpThO+0
         QiUUrZYoND6pg==
Message-ID: <444ed144-a2ee-cb16-880a-128383c83a08@collabora.com>
Date:   Tue, 20 Jun 2023 16:15:55 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
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
 <2e1b80f1-0385-0674-ae5f-9703a6ef975d@collabora.com>
 <CABb0KFGOx69Sz6w9JenYUwSTFmW-Cmcns3X-oDyWsC+H57vkvg@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFGOx69Sz6w9JenYUwSTFmW-Cmcns3X-oDyWsC+H57vkvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/19/23 1:16 PM, Michał Mirosław wrote:
> On Fri, 16 Jun 2023 at 08:57, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> On 6/16/23 1:07 AM, Michał Mirosław wrote:
>>> On Thu, 15 Jun 2023 at 17:11, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>> On 6/15/23 7:52 PM, Michał Mirosław wrote:
>>>>> On Thu, 15 Jun 2023 at 15:58, Muhammad Usama Anjum
>>>>> <usama.anjum@collabora.com> wrote:
>>>>>> I'll send next revision now.
>>>>>> On 6/14/23 11:00 PM, Michał Mirosław wrote:
>>>>>>> (A quick reply to answer open questions in case they help the next version.)
> [...]
>>>>>>> I guess this will be reworked anyway, but I'd prefer this didn't need
>>>>>>> custom errors etc. If we agree to decoupling the selection and GET
>>>>>>> output, it could be:
>>>>>>>
>>>>>>> bool is_interesting_page(p, flags); // this one does the
>>>>>>> required/anyof/excluded match
>>>>>>> size_t output_range(p, start, len, flags); // this one fills the
>>>>>>> output vector and returns how many pages were fit
>>>>>>>
>>>>>>> In this setup, `is_interesting_page() && (n_out = output_range()) <
>>>>>>> n_pages` means this is the final range, no more will fit. And if
>>>>>>> `n_out == 0` then no pages fit and no WP is needed (no other special
>>>>>>> cases).
>>>>>> Right now, pagemap_scan_output() performs the work of both of these two
>>>>>> functions. The part can be broken into is_interesting_pages() and we can
>>>>>> leave the remaining part as it is.
>>>>>>
>>>>>> Saying that n_out < n_pages tells us the buffer is full covers one case.
>>>>>> But there is case of maximum pages have been found and walk needs to be
>>>>>> aborted.
>>>>>
>>>>> This case is exactly what `n_out < n_pages` will cover (if scan_output
>>>>> uses max_pages properly to limit n_out).
>>>>> Isn't it that when the buffer is full we want to abort the scan always
>>>>> (with WP if `n_out > 0`)?
>>>> Wouldn't it be duplication of condition if buffer is full inside
>>>> pagemap_scan_output() and just outside it. Inside pagemap_scan_output() we
>>>> check if we have space before putting data inside it. I'm using this same
>>>> condition to indicate that buffer is full.
>>>
>>> I'm not sure what do you mean? The buffer-full conditions would be
>>> checked in ..scan_output() and communicated to the caller by returning
>>> N less than `n_pages` passed in. This is exactly how e.g. read()
>>> works: if you get less than requested you've hit the end of the file.
>>> If the file happens to have size that is equal to the provided buffer
>>> length, the next read() will return 0.
>> Right now we have:
>>
>> pagemap_scan_output():
>>         if (p->vec_buf_index >= p->vec_buf_len)
>>                 return PM_SCAN_BUFFER_FULL;
>>         if (p->found_pages == p->max_pages)
>>                 return PM_SCAN_FOUND_MAX_PAGES;
> 
> Why do you need to differentiate between those cases?
> 
>> pagemap_scan_pmd_entry():
>>         ret = pagemap_scan_output(bitmap, p, start, n_pages);
>>         if (ret >= 0) // success
>>                 make_UFFD_WP and flush
>>         else
>>                 buffer_error
>>
>> You are asking me to do:
>>
>> pagemap_scan_output():
>>         if (p->vec_buf_index >= p->vec_buf_len)
>>                 return 0;
> 
>>         if (p->found_pages == p->max_pages)
>>                 return PM_SCAN_FOUND_MAX_PAGES;
> 
> This should be instead:
> 
> n_pages = min(p->max_pags - p_found_pages, n_pages)
> ...
> return n_pages;
You are missing the optimization here that we check for full buffer every
time adding to user buffer. This was added to remove extra iteration of
page walk if buffer is full already. The way you are suggesting will remove it.

So you are returning remaining pages to be found now. This doesn't seem
right. If max_pages is 520, found_pages is 0 and n_pages is 512 before
calling pagemap_scan_output(). found_pages would become 512 after adding
512 pages to output buffer. But n_pages would return 8 instead of 512. You
were saying we should return the number of pages added to the output buffer.

> 
>> pagemap_scan_pmd_entry():
>>         ret = pagemap_scan_output(bitmap, p, start, n_pages);
>>         if (ret > 0) // success
>>                 make_UFFD_WP and flush
>>         else if (ret == 0) // buffer full
>>                 return PM_SCAN_BUFFER_FULL;
>>         else //other errors
>>                 buffer_error
> 
> And this would be:
> 
> if (ret > 0 && WP)
>    WP + flush
> 
> if (ret < n_pages)
>    return -ENOSPC;
> 
>> So you are asking me to go from consie code to write more lines of code. I
>> would write more lines without any issue if it improves readability and
>> logical sense. But I don't see here any benefit.
> 
> Please see the clarifications above.
> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
