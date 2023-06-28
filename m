Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E01740B9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbjF1Idu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:33:50 -0400
Received: from madras.collabora.co.uk ([46.235.227.172]:32772 "EHLO
        madras.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbjF1Ibj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:31:39 -0400
Received: from [192.168.10.54] (unknown [182.179.162.32])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 52947660716D;
        Wed, 28 Jun 2023 07:03:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687932238;
        bh=Mnlsggp9LUoS8ve7lv1HuoaS0bmkESWlf5OUJi5Yvkg=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=mtwgShxLJXCcwEam7M0PfR4SvBpDh8abUYPjYTamu74SIzmR2joyzzavKdoArvNuB
         nRSob2PXk934h4fvu2vLMtqfmEH257l2n5sSuLNTcht9AjHnEBIEA4X9b2iD7s6Kdp
         oyLtdDgOsFk1pwIGepOZCkT0WiuzwivKJVDQ1pZ9WzWzytIRWyhufS6hgn6UVTSys+
         iwH9DPNXEw6t5FZ1bKlSPXEBxg3jTg4miZptd7d63NVeFHuLTYhcpLhpS84vbUnX0w
         IlsCZCstDQQ+LinINZe5gE5lY2Il64nYqc4HtIPtZludnhDTh9+qzMIbtaBDMR836V
         y2vShbeIgCJvQ==
Message-ID: <bbba2568-2b40-d2ef-0622-47cd21c95fec@collabora.com>
Date:   Wed, 28 Jun 2023 11:03:46 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v21 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>
References: <20230626113156.1274521-1-usama.anjum@collabora.com>
 <20230626113156.1274521-3-usama.anjum@collabora.com>
 <ZJo/gOnTmwEQPLF8@gmail.com>
 <13ea54c0-25a3-285c-f47e-d6da11c91795@collabora.com>
 <CABb0KFGn=3oAYa+wsf=iWr1Ss=en9+m11JOijEibXJLFDAkvjQ@mail.gmail.com>
 <6ac9c60e-0a6b-110a-cace-97afbd9708a0@collabora.com>
 <CABb0KFH60U5RE9dLfCOEGp5=wLwwxpKaMdzQL8drYEmL3T_itw@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFH60U5RE9dLfCOEGp5=wLwwxpKaMdzQL8drYEmL3T_itw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/23 12:54 AM, Michał Mirosław wrote:
> On Tue, 27 Jun 2023 at 21:20, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>> Thanks Michał for replying.
>>
>> On 6/27/23 11:52 PM, Michał Mirosław wrote:
>>> On Tue, 27 Jun 2023 at 11:00, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>>
>>>> Hi Andrei and Michal,
>>>>
>>>> Lets resolve last two points. Please reply below.
>>>>
>>>> On 6/27/23 6:46 AM, Andrei Vagin wrote:
>>> [...]
>>>>> And we need to report an address where it stopped scanning.
>>>>> We can do that by adding zero length vector.
>>>> I don't want to do multiplexing the ending address in vec. Can we add
>>>> end_addr variable in struct pm_scan_arg to always return the ending address?
>>>>
>>>> struct pm_scan_arg {
>>>>         ...
>>>>         _u64 end_addr;
>>>> };
>>>
>>> The idea to emit a zero-length entry for the end looks nice. This has
>>> the disadvantage that we'd need to either reserve one entry for the
>>> ending marker or stop the walk after the last entry is no longer
>>> matching.
>> This is ambiguous.
> 
> Can you explain? Both solutions would allow to return the restart
> point back to the caller (the second one would need to stop the walk
> as soon as the matching page range finishes -- that creates
> discontinuity).
> 
>>> Another solution would be to rewrite 'start' and 'len'. The caller
>>> would be forced to use non-const `pm_scan_arg`, but I expect the `vec`
>>> pointer would normally be written anyway (unless using only a
>>> statically-allocated buffer).
>>> Also, if the 'len' is replaced with 'end' that would make the ioctl
>>> easily restartable (just call again if start != end).
>> Nice idea. But returning ending address in len seems a bit strange.
> 
> I mean that it would update `start` = start value for next call' and
> `len` = `len` - (new `start` - original `start`).
> 
> By replacing `len` I meant to remove the field and add `end` instead
> to make the requested range use begin .. end (iterator range) style
> instead of start + len (buffer and length). In this version you only
> need to update `start` (or `begin` if you prefer).
The `start` and `end` with updating the `start` with ending address seems
most appropriate. I'll make updates.

> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
