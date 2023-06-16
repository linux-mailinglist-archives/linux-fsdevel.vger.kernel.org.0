Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E577327BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 08:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbjFPGhq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 02:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbjFPGhp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:37:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD0D294E;
        Thu, 15 Jun 2023 23:37:43 -0700 (PDT)
Received: from [192.168.10.55] (unknown [119.155.33.163])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3F4E36606F79;
        Fri, 16 Jun 2023 07:37:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686897461;
        bh=oi7kcW/MH0K5SRnKY57domar7n22lk4AWinBLcFzc2Y=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=XHJdr0Nfi3TmYUy9talcVsP2kNainfnuLZ+cQUlJSMvVBd5K2RzKq+QjL/iO+0erh
         rlieeQA5y2IgtBmWL9z4xmlnKABdf2l/Je6XNY8uM+jWVm+r85jk4Wg1c6O6eANm0F
         NPBThlYsIW9Vz+4qMTow9j1/jniZGGaokzKVJ85A63Fdj83FLl1n0gPP2cCNKUrRjH
         5+4oUvLQ5pHETxdRdQleozuwKZly81uIUc33VKJKOKei+mOH1TZ1+W8CUTTblGuE8c
         MZ+3fh+2lqT+GgUKTOJM1jxgG36wqTAKpfUixUAU2dvIHAzL2y9nn8ODhljK1kdfre
         z3niSZM9oDFug==
Message-ID: <41d3bdd4-cd69-0e15-cec4-720804bf3580@collabora.com>
Date:   Fri, 16 Jun 2023 11:37:31 +0500
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
 <CABb0KFGuqoDh-+FKcsZXxpSFWSM3mcLVQkotGE3RcNiFKh-a2g@mail.gmail.com>
 <43c96533-8009-e42f-721c-4b2d1e142f5d@collabora.com>
 <CABb0KFF5LCmvdY_hVmH0SSCOdyeT1dAA=Kh=T7wUSx=9eLLy=g@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFF5LCmvdY_hVmH0SSCOdyeT1dAA=Kh=T7wUSx=9eLLy=g@mail.gmail.com>
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

On 6/16/23 1:00 AM, Michał Mirosław wrote:
> On Thu, 15 Jun 2023 at 17:16, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> Please review the v19. I hope to get your reviewed by tag soon.
>>
>> On 6/15/23 7:58 PM, Michał Mirosław wrote:
>>> On Thu, 15 Jun 2023 at 16:52, Michał Mirosław <emmir@google.com> wrote:
>>>> On Thu, 15 Jun 2023 at 15:58, Muhammad Usama Anjum
>>>> <usama.anjum@collabora.com> wrote:
>>>>> I'll send next revision now.
>>>>> On 6/14/23 11:00 PM, Michał Mirosław wrote:
>>>>>> (A quick reply to answer open questions in case they help the next version.)
>>>>>>
>>>>>> On Wed, 14 Jun 2023 at 19:10, Muhammad Usama Anjum
>>>>>> <usama.anjum@collabora.com> wrote:
>>>>>>> On 6/14/23 8:14 PM, Michał Mirosław wrote:
>>>>>>>> On Wed, 14 Jun 2023 at 15:46, Muhammad Usama Anjum
>>>>>>>> <usama.anjum@collabora.com> wrote:
>>>>>>>>>
>>>>>>>>> On 6/14/23 3:36 AM, Michał Mirosław wrote:
>>>>>>>>>> On Tue, 13 Jun 2023 at 12:29, Muhammad Usama Anjum
>>>>>>>>>> <usama.anjum@collabora.com> wrote:
>>>>>>>>>> For flags name: PM_REQUIRE_WRITE_ACCESS?
>>>>>>>>>> Or Is it intended to be checked only if doing WP (as the current name
>>>>>>>>>> suggests) and so it would be redundant as WP currently requires
>>>>>>>>>> `p->required_mask = PAGE_IS_WRITTEN`?
>>>>>>>>> This is intended to indicate that if userfaultfd is needed. If
>>>>>>>>> PAGE_IS_WRITTEN is mentioned in any of mask, we need to check if
>>>>>>>>> userfaultfd has been initialized for this memory. I'll rename to
>>>>>>>>> PM_SCAN_REQUIRE_UFFD.
>>>>>>>>
>>>>>>>> Why do we need that check? Wouldn't `is_written = false` work for vmas
>>>>>>>> not registered via uffd?
>>>>>>> UFFD_FEATURE_WP_ASYNC and UNPOPULATED needs to be set on the memory region
>>>>>>> for it to report correct written values on the memory region. Without UFFD
>>>>>>> WP ASYNC and UNPOUPULATED defined on the memory, we consider UFFD_WP state
>>>>>>> undefined. If user hasn't initialized memory with UFFD, he has no right to
>>>>>>> set is_written = false.
>>>>>>
>>>>>> How about calculating `is_written = is_uffd_registered() &&
>>>>>> is_uffd_wp()`? This would enable a user to apply GET+WP for the whole
>>>>>> address space of a process regardless of whether all of it is
>>>>>> registered.
>>>>> I wouldn't want to check if uffd is registered again and again. This is why
>>>>> we are doing it only once every walk in pagemap_scan_test_walk().
>>>>
>>>> There is no need to do the checks repeatedly. If I understand the code
>>>> correctly, uffd registration is per-vma, so it can be communicated
>>>> from test_walk to entry/hole callbacks via a field in
>>>> pagemap_scan_private.
>>>
>>> Actually... this could be exposed as a page category for the filter
>>> (e.g. PAGE_USES_UFFD_WP) and then you could just make the ioctl() to
>>> work for your usecase without tracking the ranges at the userspace
>>> side.
>> I'm not sure about page category. ASAIK the current check isn't bad when we
>> already mention in documentation that memory must be registered with UFFD
>> WP before using write feature of the IOCTL.
> 
> You could relax the (documentation) rule to be "WP works only on
> ranges registeder via UFFD for ASYNC_WP". That way you allow people,
> who don't read documentation to shoot their foot, 
They'll shoot their foot and have no idea why they are getting false
results. Isn't it better that they get error and they go read the
documentation and then register with UFFD first? I think, returning error
is way better than not returning anything.

> but don't block
> people that know what they are doing from exploiting the nice feature
> that they don't need to track all the WP-registered ranges calling the
> ioctl() for each one and instead can just call it once for the whole
> address space.
> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
