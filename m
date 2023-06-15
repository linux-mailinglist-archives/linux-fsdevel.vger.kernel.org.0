Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA47731C44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 17:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345029AbjFOPQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 11:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345038AbjFOPQ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:16:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315B22D5D;
        Thu, 15 Jun 2023 08:16:22 -0700 (PDT)
Received: from [192.168.10.55] (unknown [119.155.33.163])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E82676606F67;
        Thu, 15 Jun 2023 16:16:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686842180;
        bh=C0LEQtiOTpGeaCKA+5bOCExcFaAsKTYF2+EXB06sxLI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=biOA/gL+FCKC1STuGTkA27txM7KGqLoOY5QAg/CEkPhfmvwgSp4HyueREBL5JRNqo
         qj12DWxyl8+iwhbx1is/3rVI2TgwihjblFnKhEiwT0CRQe3bsZ3A7MLBi5IYFik1CN
         bWkEmO3IjEfyzzb4s4qY6hubBX69vPgsH1+O+Tarr0UCdZyItIpbnGFzdV4YDfksk8
         NqAoN9vn37M6FC8PW9CQdX98oLmDNfisTmkUh5PmujzhkiCnydIez85QLaRm9IvmpL
         u2atqKkAwbY2FkCQs5XbUXDoZYn6hm32m9VEfdXIvulNOYgh4UaDN+Cmu/vG2VaUM/
         +x8t9wZ93KyZA==
Message-ID: <43c96533-8009-e42f-721c-4b2d1e142f5d@collabora.com>
Date:   Thu, 15 Jun 2023 20:16:10 +0500
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
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFGuqoDh-+FKcsZXxpSFWSM3mcLVQkotGE3RcNiFKh-a2g@mail.gmail.com>
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

Please review the v19. I hope to get your reviewed by tag soon.

On 6/15/23 7:58 PM, Michał Mirosław wrote:
> On Thu, 15 Jun 2023 at 16:52, Michał Mirosław <emmir@google.com> wrote:
>> On Thu, 15 Jun 2023 at 15:58, Muhammad Usama Anjum
>> <usama.anjum@collabora.com> wrote:
>>> I'll send next revision now.
>>> On 6/14/23 11:00 PM, Michał Mirosław wrote:
>>>> (A quick reply to answer open questions in case they help the next version.)
>>>>
>>>> On Wed, 14 Jun 2023 at 19:10, Muhammad Usama Anjum
>>>> <usama.anjum@collabora.com> wrote:
>>>>> On 6/14/23 8:14 PM, Michał Mirosław wrote:
>>>>>> On Wed, 14 Jun 2023 at 15:46, Muhammad Usama Anjum
>>>>>> <usama.anjum@collabora.com> wrote:
>>>>>>>
>>>>>>> On 6/14/23 3:36 AM, Michał Mirosław wrote:
>>>>>>>> On Tue, 13 Jun 2023 at 12:29, Muhammad Usama Anjum
>>>>>>>> <usama.anjum@collabora.com> wrote:
>>>>>>>> For flags name: PM_REQUIRE_WRITE_ACCESS?
>>>>>>>> Or Is it intended to be checked only if doing WP (as the current name
>>>>>>>> suggests) and so it would be redundant as WP currently requires
>>>>>>>> `p->required_mask = PAGE_IS_WRITTEN`?
>>>>>>> This is intended to indicate that if userfaultfd is needed. If
>>>>>>> PAGE_IS_WRITTEN is mentioned in any of mask, we need to check if
>>>>>>> userfaultfd has been initialized for this memory. I'll rename to
>>>>>>> PM_SCAN_REQUIRE_UFFD.
>>>>>>
>>>>>> Why do we need that check? Wouldn't `is_written = false` work for vmas
>>>>>> not registered via uffd?
>>>>> UFFD_FEATURE_WP_ASYNC and UNPOPULATED needs to be set on the memory region
>>>>> for it to report correct written values on the memory region. Without UFFD
>>>>> WP ASYNC and UNPOUPULATED defined on the memory, we consider UFFD_WP state
>>>>> undefined. If user hasn't initialized memory with UFFD, he has no right to
>>>>> set is_written = false.
>>>>
>>>> How about calculating `is_written = is_uffd_registered() &&
>>>> is_uffd_wp()`? This would enable a user to apply GET+WP for the whole
>>>> address space of a process regardless of whether all of it is
>>>> registered.
>>> I wouldn't want to check if uffd is registered again and again. This is why
>>> we are doing it only once every walk in pagemap_scan_test_walk().
>>
>> There is no need to do the checks repeatedly. If I understand the code
>> correctly, uffd registration is per-vma, so it can be communicated
>> from test_walk to entry/hole callbacks via a field in
>> pagemap_scan_private.
> 
> Actually... this could be exposed as a page category for the filter
> (e.g. PAGE_USES_UFFD_WP) and then you could just make the ioctl() to
> work for your usecase without tracking the ranges at the userspace
> side.
I'm not sure about page category. ASAIK the current check isn't bad when we
already mention in documentation that memory must be registered with UFFD
WP before using write feature of the IOCTL.

Just like mincore mentions in documentation that user buffer will be filled
with values based on the length of the region. Kernel doesn't care if user
had provided smaller buffer and kernel overwrites because of user's own
issue. I want to follow the same path. If user doesn't read documentation
and follow it, he should be punished with the error.

> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
