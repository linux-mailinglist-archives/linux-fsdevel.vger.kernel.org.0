Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B70A5F2F86
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 13:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiJCLVq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 07:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJCLVi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 07:21:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749514B4B1;
        Mon,  3 Oct 2022 04:21:31 -0700 (PDT)
Received: from [192.168.10.9] (unknown [39.45.148.204])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 599CA6601AED;
        Mon,  3 Oct 2022 12:21:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664796089;
        bh=QjQysDtg/rfCjFri/iGM14++at29jMbV+/m5tzwz0yg=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=ILSxcT+t83n9BjP6pk9g0NC7uAYX/7KBTjTv2Gr3bt0nxGWDer5H+pITpueEVLU7w
         jvsLqoN+IxRZ6rlYW3ZfK1AvHC8c3X4nODl6RgybJTQ3AXOm72h6N5vq4w2BmqYSwi
         GtLWNYjG6ZXEPLaKe6ohalW4zemKyV6+eZynl2q0AFJALzQ18rzHwbLbuhEXzycluA
         vtj86c+OhGkPJTOss8JWOOzEQTpX5sMWsqJDi+9VlMcxomERGxR+Lw1rhZXnUT/vE4
         jITAOMOf4wQ/3lSggteA1y+GahekEQC9tpS6lyTlbE0ulUl6lbYHwrAwZHUhiLlw3K
         G+Y8P7KajIbcQ==
Message-ID: <2e1c33c8-a201-0f7f-17cf-22fec555c7ff@collabora.com>
Date:   Mon, 3 Oct 2022 16:21:22 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Cc:     usama.anjum@collabora.com, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 0/4] Implement IOCTL to get and clear soft dirty PTE
Content-Language: en-US
To:     Andrei Vagin <avagin@gmail.com>
References: <20220826064535.1941190-1-usama.anjum@collabora.com>
 <YyiDg79flhWoMDZB@gmail.com>
 <2c8b7116-56e9-3202-c47e-e42078c85793@collabora.com>
 <CANaxB-xDiTRCuWxBmrSH1u3e_ADbxCoQKmEoSsYfm4yW7k=v4A@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CANaxB-xDiTRCuWxBmrSH1u3e_ADbxCoQKmEoSsYfm4yW7k=v4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/28/22 10:24 PM, Andrei Vagin wrote:
> On Wed, Sep 21, 2022 at 11:26 AM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> Hi,
>>
>> Thank you for reviewing.
>>
>> On 9/19/22 7:58 PM, Andrei Vagin wrote:
>>>> This ioctl can be used by the CRIU project and other applications which
>>>> require soft-dirty PTE bit information. The following operations are
>>>> supported in this ioctl:
>>>> - Get the pages that are soft-dirty.
>>>
>>> I think this interface doesn't have to be limited by the soft-dirty
>>> bits only. For example, CRIU needs to know whether file, present and swap bits
>>> are set or not.
>> These operations can be performed by pagemap procfs file. Definitely
>> performing them through IOCTL will be faster. But I'm trying to add a
>> simple IOCTL by which some specific PTE bit can be read and cleared
>> atomically. This IOCTL can be extended to include other bits like file,
>> present and swap bits by keeping the interface simple. The following
>> mask advice is nice. But if we add that kind of masking, it'll start to
>> look like a filter on top of pagemap. My intention is to not duplicate
>> the functionality already provided by the pagemap. One may ask, then why
>> am I adding "get the soft-dirty pages" functionality? I'm adding it to
>> complement the get and clear operation. The "get" and "get and clear"
>> operations with special flag (PAGEMAP_SD_NO_REUSED_REGIONS) can give
>> results quicker by not splitting the VMAs.
> 
> This simple interface is good only for a limited number of use-cases.
> The interface
> that I suggest doesn't duplicate more code than this one, but it is much more
> universal. It will be a big mess if you add a separate API for each
> specific use-case.
>
>
>>> I mean we should be able to specify for what pages we need to get info
>>> for. An ioctl argument can have these four fields:
>>> * required bits (rmask & mask == mask) - all bits from this mask have to be set.
>>> * any of these bits (amask & mask != 0) - any of these bits is set.
>>> * exclude masks (emask & mask == 0) = none of these bits are set.
>>> * return mask - bits that have to be reported to user.
The required mask (rmask) makes sense to me. At the moment, I only know
about the practical use case for the required mask. Can you share how
can any and exclude masks help for the CRIU?

>>>
>>>> - Clear the pages which are soft-dirty.
>>>> - The optional flag to ignore the VM_SOFTDIRTY and only track per page
>>>> soft-dirty PTE bit
>>>>
>>>> There are two decisions which have been taken about how to get the output
>>>> from the syscall.
>>>> - Return offsets of the pages from the start in the vec
>>>
>>> We can conside to return regions that contains pages with the same set
>>> of bits.
>>>
>>> struct page_region {
>>>       void *start;
>>>       long size;
>>>       u64 bitmap;
>>> }
>>>
>>> And ioctl returns arrays of page_region-s. I believe it will be more
>>> compact form for many cases.
>> Thank you for mentioning this. I'd considered this while development.
>> But I gave up and used the simple array to return the offsets of the
>> pages as in the problem I'm trying to solve, the dirty pages may be
>> present amid non-dirty pages. The range may not be useful in that case.
> 
> This is a good example. If we expect more than two consequent pages
> on average, the "region" interface looks more prefered. I don't know your
> use-case, but in the case of CRIU, this assumption looks reasonable.
> 
>> Also we want to return only a specific number of pages of interest. The
>> following paragraph explains it.
>>
>>>
>>>> - Stop execution when vec is filled with dirty pages
>>>> These two arguments doesn't follow the mincore() philosophy where the
>>>> output array corresponds to the address range in one to one fashion, hence
>>>> the output buffer length isn't passed and only a flag is set if the page
>>>> is present. This makes mincore() easy to use with less control. We are
>>>> passing the size of the output array and putting return data consecutively
>>>> which is offset of dirty pages from the start. The user can convert these
>>>> offsets back into the dirty page addresses easily. Suppose, the user want
>>>> to get first 10 dirty pages from a total memory of 100 pages. He'll
>>>> allocate output buffer of size 10 and the ioctl will abort after finding the
>>>> 10 pages. This behaviour is needed to support Windows' getWriteWatch(). The
>>>> behaviour like mincore() can be achieved by passing output buffer of 100
>>>> size. This interface can be used for any desired behaviour.
> 
> Now, it is more clear where this interface came from. It repeats the interface
> of Windows' getWriteWatch. I think we have to look wider. The
> interface that reports
> regions will be more efficient for many use-cases. As for
> getWriteWatch, it will require
> a bit more code in user-space, but this code is trivial.
> 
> Thanks,
> Andrei

-- 
Muhammad Usama Anjum
