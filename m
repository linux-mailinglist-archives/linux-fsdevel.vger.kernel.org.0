Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE04621B24
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 18:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbiKHRvR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Nov 2022 12:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbiKHRvQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:51:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70890C26;
        Tue,  8 Nov 2022 09:51:15 -0800 (PST)
Received: from [192.168.10.9] (unknown [39.45.244.84])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CBD496602040;
        Tue,  8 Nov 2022 17:51:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667929874;
        bh=NRAtcPw2wnMbEi41WFnnZ8Awkgbk4HFCvEFBYvlaf/4=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=FhaJOARjyis7Xbl1jdgCk+Obgpxov4IyFBEYPkzWBkU82YMHGk4/kXhJcEtw2DRyJ
         Yu6Ovbx888FeahhlQCbYTE5KscYnW4ibFwSjUx7HqOQZNXhyEymr97VTCLmZPOwtMP
         HMkfN9FC92BymBg7Jhxwupq2MmVFNVVk4aFS2/w38jkjJKkYKHQQqRLI0Azqu7f8i7
         baKNZlNjfZZQ1885uL+FThUD3LTmtuytVQJ5bdFT9qqkaAerAvfdOmKMGbKdf39spZ
         EygwwnPpIcLfTLHXTZplnDA8Bipf8ydKP3JY1l6nqSkEzT/myLYo8Y1RFV0QeTy7YP
         AXrbmTXyVqzqQ==
Message-ID: <a1155107-fc3a-8098-187d-c2981981ea2f@collabora.com>
Date:   Tue, 8 Nov 2022 22:51:04 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zach O'Keefe <zokeefe@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list : PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list : MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: Re: [PATCH v5 2/3] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20221103145353.3049303-1-usama.anjum@collabora.com>
 <20221103145353.3049303-3-usama.anjum@collabora.com>
 <CABb0KFFaYZG62TS+iM3Y92+hDyB35XR8dTX-5hDgWrXCcDQx7Q@mail.gmail.com>
 <f394de31-b9c1-5a6c-eab2-74b84f2b3ba3@collabora.com>
 <CABb0KFGbhM8V6qeDEzq7Lc_3cseScbK3zvfLndRdJfLstTO=2g@mail.gmail.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFGbhM8V6qeDEzq7Lc_3cseScbK3zvfLndRdJfLstTO=2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/8/22 9:00 PM, Michał Mirosław wrote:
>>>> + * @start:             Starting address of the region
>>>> + * @len:               Length of the region (All the pages in this length are included)
>>>> + * @vec:               Address of page_region struct array for output
>>>> + * @vec_len:           Length of the page_region struct array
>>>> + * @max_pages:         Optional max return pages (It must be less than vec_len if specified)
>>> I think we discussed that this is not counting the same things as
>>> vec_len, so there should not be a reference between the two. The limit
>>> is whatever fits under both conditions (IOW: n_vecs <= vec_len &&
>>> (!max_pages || n_pages <= max_pages).
>> In worse case when pages cannot be folded into the page_region, the one
>> page_region may have information of only one page. This is why I've
>> compared them. I want to communicate to the user that if max_pages is
>> used, the vec_len should be of equal or greater size (to cater worse
>> case which can happen at any time). Otherwise in worse case, the api can
>> return without finding the max_pages number of pages. I don't know how
>> should I put this in the comment.
> I'm not sure you need to, as this conclusion follows from the range vs
> page distinction.
> A user who wants to cater for the worst case will provide big-enough
> `vec` array, but another, who might be memory-constrained, could
> instead just retry the call with `start` updated to just after the
> last returned page until the ioctl() returns less ranges than
> `vec_len` allows.
Makes sense. I'll update and send next revision.

Thanks,
Usama
> 
> Best Regards
> Michał Mirosław
