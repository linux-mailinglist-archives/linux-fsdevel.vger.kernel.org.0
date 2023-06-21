Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4AA737A68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 06:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjFUEoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 00:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjFUEoe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:44:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA5F1730;
        Tue, 20 Jun 2023 21:44:32 -0700 (PDT)
Received: from [192.168.10.54] (unknown [119.155.63.248])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CB8C8660296C;
        Wed, 21 Jun 2023 05:44:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687322671;
        bh=GMo8qOz67u7jFTir2W0Vb2JjW6eOFryP62A0pb2a4vg=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=mECV2qzaIw2HDiIJoHLohz28PMiMooPxorgX7oPAO79aAUmwROJXPamG+FHYH5riW
         UHRd6Gn7UF9YnMklRpwuep3lbxIQgX4skqbCqWdNDQ4pW3fiXpY0aLznKuawlHzfIf
         +xiOfoWxnQc4UTA6jsYu+JFdnKJiXgIAuBhibcgFMbOri7gI39ykB74+7ps7Hs2TMG
         uTcaHz2QyQaqyDSLhTuljXEexQG0XpsOUy/TFv+bRNjwlglnjRhQSGBEXlFX6cgO2P
         JloN4BReLPrD979jg0E8sEQ5USoRMTr2qKZXzkytNmNze5RSv7vRXBX2p6Av92j3dr
         0Cd9WXqgyE/Xg==
Message-ID: <9b6d55e3-1f5f-04e1-d68f-0591a0f4f60c@collabora.com>
Date:   Wed, 21 Jun 2023 09:44:19 +0500
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
 <444ed144-a2ee-cb16-880a-128383c83a08@collabora.com>
 <CABb0KFEqJasf9nM3wL1oaK9ObcYzwzjtrRBcWRc3wGqdZRUpXg@mail.gmail.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFEqJasf9nM3wL1oaK9ObcYzwzjtrRBcWRc3wGqdZRUpXg@mail.gmail.com>
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

On 6/21/23 3:05 AM, Michał Mirosław wrote:
> On Tue, 20 Jun 2023 at 13:16, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>> On 6/19/23 1:16 PM, Michał Mirosław wrote:
>>> On Fri, 16 Jun 2023 at 08:57, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>>
>>>> On 6/16/23 1:07 AM, Michał Mirosław wrote:
>>>>> On Thu, 15 Jun 2023 at 17:11, Muhammad Usama Anjum
>>>>> <usama.anjum@collabora.com> wrote:
>>>>>> On 6/15/23 7:52 PM, Michał Mirosław wrote:
>>>>>>> On Thu, 15 Jun 2023 at 15:58, Muhammad Usama Anjum
>>>>>>> <usama.anjum@collabora.com> wrote:
>>>>>>>> I'll send next revision now.
>>>>>>>> On 6/14/23 11:00 PM, Michał Mirosław wrote:
>>>>>>>>> (A quick reply to answer open questions in case they help the next version.)
>>> [...]
>>>>>>>>> I guess this will be reworked anyway, but I'd prefer this didn't need
>>>>>>>>> custom errors etc. If we agree to decoupling the selection and GET
>>>>>>>>> output, it could be:
>>>>>>>>>
>>>>>>>>> bool is_interesting_page(p, flags); // this one does the
>>>>>>>>> required/anyof/excluded match
>>>>>>>>> size_t output_range(p, start, len, flags); // this one fills the
>>>>>>>>> output vector and returns how many pages were fit
>>>>>>>>>
>>>>>>>>> In this setup, `is_interesting_page() && (n_out = output_range()) <
>>>>>>>>> n_pages` means this is the final range, no more will fit. And if
>>>>>>>>> `n_out == 0` then no pages fit and no WP is needed (no other special
>>>>>>>>> cases).
>>>>>>>> Right now, pagemap_scan_output() performs the work of both of these two
>>>>>>>> functions. The part can be broken into is_interesting_pages() and we can
>>>>>>>> leave the remaining part as it is.
>>>>>>>>
>>>>>>>> Saying that n_out < n_pages tells us the buffer is full covers one case.
>>>>>>>> But there is case of maximum pages have been found and walk needs to be
>>>>>>>> aborted.
>>>>>>>
>>>>>>> This case is exactly what `n_out < n_pages` will cover (if scan_output
>>>>>>> uses max_pages properly to limit n_out).
>>>>>>> Isn't it that when the buffer is full we want to abort the scan always
>>>>>>> (with WP if `n_out > 0`)?
>>>>>> Wouldn't it be duplication of condition if buffer is full inside
>>>>>> pagemap_scan_output() and just outside it. Inside pagemap_scan_output() we
>>>>>> check if we have space before putting data inside it. I'm using this same
>>>>>> condition to indicate that buffer is full.
>>>>>
>>>>> I'm not sure what do you mean? The buffer-full conditions would be
>>>>> checked in ..scan_output() and communicated to the caller by returning
>>>>> N less than `n_pages` passed in. This is exactly how e.g. read()
>>>>> works: if you get less than requested you've hit the end of the file.
>>>>> If the file happens to have size that is equal to the provided buffer
>>>>> length, the next read() will return 0.
>>>> Right now we have:
>>>>
>>>> pagemap_scan_output():
>>>>         if (p->vec_buf_index >= p->vec_buf_len)
>>>>                 return PM_SCAN_BUFFER_FULL;
>>>>         if (p->found_pages == p->max_pages)
>>>>                 return PM_SCAN_FOUND_MAX_PAGES;
>>>
>>> Why do you need to differentiate between those cases?
>>>
>>>> pagemap_scan_pmd_entry():
>>>>         ret = pagemap_scan_output(bitmap, p, start, n_pages);
>>>>         if (ret >= 0) // success
>>>>                 make_UFFD_WP and flush
>>>>         else
>>>>                 buffer_error
>>>>
>>>> You are asking me to do:
>>>>
>>>> pagemap_scan_output():
>>>>         if (p->vec_buf_index >= p->vec_buf_len)
>>>>                 return 0;
>>>
>>>>         if (p->found_pages == p->max_pages)
>>>>                 return PM_SCAN_FOUND_MAX_PAGES;
>>>
>>> This should be instead:
>>>
>>> n_pages = min(p->max_pags - p_found_pages, n_pages)
>>> ...
>>> return n_pages;
>> You are missing the optimization here that we check for full buffer every
>> time adding to user buffer. This was added to remove extra iteration of
>> page walk if buffer is full already. The way you are suggesting will remove it.
>>
>> So you are returning remaining pages to be found now. This doesn't seem
>> right. If max_pages is 520, found_pages is 0 and n_pages is 512 before
>> calling pagemap_scan_output(). found_pages would become 512 after adding
>> 512 pages to output buffer. But n_pages would return 8 instead of 512. You
>> were saying we should return the number of pages added to the output buffer.
> 
> Ok, if we want this optimization, then i'd rework it so that we have:
> 
> bool pagemap_scan_output(..., int *n_pages)
> {
>    limit n_pages;
>   ...
>   return have_more_room_in_output;
> }
This is becoming more and more closer to what I have in the code. The only
difference now is that you are asking me to not return the buffer full
status from inside this function and instead there should be a input+output
pointer to n_pages and the caller would return the buffer full status. As
compared to the suggestion, the current form looks simpler. My earlier
point (
https://lore.kernel.org/all/2e1b80f1-0385-0674-ae5f-9703a6ef975d@collabora.com
) is valid again. I don't want to bring logic out of pagemap_scan_output().
This is internal function. There could be thousand ways how internal code
can be written. I've really liked so many optimizations which you have
advised. This isn't something worth doing. It would increase lines of code
with no added readability benefit.

-- 
BR,
Muhammad Usama Anjum
