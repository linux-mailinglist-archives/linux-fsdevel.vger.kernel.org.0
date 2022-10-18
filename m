Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CB060296C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 12:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJRKgj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 06:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJRKgi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:36:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20F98E9AC;
        Tue, 18 Oct 2022 03:36:37 -0700 (PDT)
Received: from [192.168.10.9] (unknown [39.45.244.84])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D95546602362;
        Tue, 18 Oct 2022 11:36:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666089396;
        bh=6IXmqpcqcRFcfMJiig2n7Q1DNwmUnPwfuYR6Uqnx6Yc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D03y7t3QjoZFHOlkcoh8Upt8tFLOo1WMcBG3pRMvPqs8KSRbs/30kAv6zWdk6/Vet
         yippPqeMjF7picY35GU2KggxzY89zHYPmFTAqYQOzbhhX85wzpEBhXqzP1SVVNDkFL
         odcgunCsKvKq7zvsizOgNNEDDDrT14oXuW2m4DFtUBtk4r40pppLo6J9IICdvw+egA
         MPLWSElufJKkoaSv44NnTEa3VpeSJNuw0h5fEidG1XpWBlKsUT6m/sL0ChrH+fMlu9
         TMaNQweRWpJp1eIdqcpk18x1bGqZnqfaKL8leKd5csF9hIvavkqoFCwX94yB//YktH
         h4W10JmoUxXOQ==
Message-ID: <474513c0-4ff9-7978-9d77-839fe775d04c@collabora.com>
Date:   Tue, 18 Oct 2022 15:36:24 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 0/4] Implement IOCTL to get and clear soft dirty PTE
Content-Language: en-US
To:     Danylo Mocherniuk <mdanylo@google.com>, avagin@gmail.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org
Cc:     corbet@lwn.net, david@redhat.com, kernel@collabora.com,
        krisman@collabora.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, peter.enderborg@sony.com,
        shuah@kernel.org, viro@zeniv.linux.org.uk, willy@infradead.org,
        emmir@google.com, figiel@google.com, kyurtsever@google.com,
        Paul Gofman <pgofman@codeweavers.com>, surenb@google.com
References: <Y0T2l3HaH2MU8M9m@gmail.com>
 <20221014134802.1361436-1-mdanylo@google.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20221014134802.1361436-1-mdanylo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>>>>> I mean we should be able to specify for what pages we need to get info
>>>>>> for. An ioctl argument can have these four fields:
>>>>>> * required bits (rmask & mask == mask) - all bits from this mask have to be set.
>>>>>> * any of these bits (amask & mask != 0) - any of these bits is set.
>>>>>> * exclude masks (emask & mask == 0) = none of these bits are set.
>>>>>> * return mask - bits that have to be reported to user.
>>> The required mask (rmask) makes sense to me. At the moment, I only know
>>> about the practical use case for the required mask. Can you share how
>>> can any and exclude masks help for the CRIU?
>>>
>>
>> I looked at should_dump_page in the CRIU code:
>> https://github.com/checkpoint-restore/criu/blob/45641ab26d7bb78706a6215fdef8f9133abf8d10/criu/mem.c#L102
>>
>> When CRIU dumps file private mappings, it needs to get pages that have
>> PME_PRESENT or PME_SWAP but don't have PME_FILE.
> 
> I would really like to see the mask discussed will be adopted. With it CRIU will
> be able to migrate huge sparse VMAs assuming that a single hole is processed in
> O(1) time.
> 
> Use cases for migrating sparse VMAs are binaries sanitized with ASAN, MSAN or
> TSAN [1]. All of these sanitizers produce sparse mappings of shadow memory [2].
> Being able to migrate such binaries allows to highly reduce the amount of work
> needed to identify and fix post-migration crashes, which happen constantly.
> 

Hello all,

I've included the masks which the CRIU developers have specified. 
max_out_page is another new optional variable which is needed to 
terminate the operation without visiting all the pages after finding the 
max_out_page number of desired pages. There is no way to terminate the 
operation without this variable.

How does the interface looks now? Please comment.

/* PAGEMAP IOCTL */
#define PAGEMAP_GET		_IOWR('f', 16, struct pagemap_sd_args)
#define PAGEMAP_CLEAR		_IOWR('f', 17, struct pagemap_sd_args)
#define PAGEMAP_GET_AND_CLEAR	_IOWR('f', 18, struct pagemap_sd_args)

/* Bits are set in the bitmap of the page_region and masks in 
pagemap_sd_args */
#define PAGE_IS_SD	1 << 0
#define PAGE_IS_FILE	1 << 1
#define PAGE_IS_PRESENT	1 << 2
#define PAGE_IS_SWAPED	1 << 3

/**
  * struct page_region - Page region with bitmap flags
  * @start:	Start of the region
  * @len:	Length of the region
  * bitmap:	Bits sets for the region
  */
struct page_region {
	__u64 start;
	__u64 len;
	__u64 bitmap;
};

/**
  * struct pagemap_sd_args - Soft-dirty IOCTL argument
  * @start:		Starting address
  * @len:		Length of the region
  * @vec:		Output page_region struct array
  * @vec_len:		Length of the page_region struct array
  * @max_out_page:	Optional max output pages (It must be less than 
vec_len if specified)
  * @flags:		Special flags for the IOCTL
  * @rmask:		Special flags for the IOCTL
  * @amask:		Special flags for the IOCTL
  * @emask:		Special flags for the IOCTL
  * @__reserved:		Reserved member to preserve data alignment. Must be 0.
  */
struct pagemap_sd_args {
	__u64 __user start;
	__u64 len;
	__u64 __user vec; // page_region
	__u64 vec_len;    // sizeof(page_region)
	__u32 flags;      // special flags
	__u32 rmask;
	__u32 amask;
	__u32 emask;
	__u32 max_out_page;
	__u32 __reserved;
};

/* Special flags */
#define PAGEMAP_NO_REUSED_REGIONS	0x1


>>
>>>>>>> - Clear the pages which are soft-dirty.
>>>>>>> - The optional flag to ignore the VM_SOFTDIRTY and only track per page
>>>>>>> soft-dirty PTE bit
>>>>>>>
>>>>>>> There are two decisions which have been taken about how to get the output
>>>>>>> from the syscall.
>>>>>>> - Return offsets of the pages from the start in the vec
>>>>>>
>>>>>> We can conside to return regions that contains pages with the same set
>>>>>> of bits.
>>>>>>
>>>>>> struct page_region {
>>>>>>        void *start;
>>>>>>        long size;
>>>>>>        u64 bitmap;
>>>>>> }
>>>>>>
>>>>>> And ioctl returns arrays of page_region-s. I believe it will be more
>>>>>> compact form for many cases.
>>>>> Thank you for mentioning this. I'd considered this while development.
>>>>> But I gave up and used the simple array to return the offsets of the
>>>>> pages as in the problem I'm trying to solve, the dirty pages may be
>>>>> present amid non-dirty pages. The range may not be useful in that case.
>>>>
>>>> This is a good example. If we expect more than two consequent pages
>>>> on average, the "region" interface looks more prefered. I don't know your
>>>> use-case, but in the case of CRIU, this assumption looks reasonable.
> 
> Plus one for page_region data structure. It will make ASAN shadow memory
> representation much more compact as well as any other classical use-case.
> 
> [1] https://github.com/google/sanitizers	
> [2] https://github.com/google/sanitizers/wiki/AddressSanitizerAlgorithm#64-bit	
> 
> Best,
> Danylo
> 
