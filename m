Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01B6782B35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 16:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbjHUOLh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 10:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjHUOLg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:11:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01888E2;
        Mon, 21 Aug 2023 07:11:34 -0700 (PDT)
Received: from [192.168.10.12] (unknown [39.45.215.81])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 244B266071F4;
        Mon, 21 Aug 2023 15:11:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692627093;
        bh=++dzZO1vqk0amfLf6lBtmxCFkhXXPRL6bxuD2YCYW40=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Oog9YJYJ++VUYv2n0jvqY38wWi2YqISb9GEbfNel7+kNepgWEDIsUZ6kLDt7eY6nv
         4aEOakZfimkGLJoQoI+0OjzHFDVF5cUIk1r6NZJXQxLwIm1QRYK86tq3uk2/S4XLWh
         0LnALV1ykXJTaoLi/lWAkuAESAZZOypoacXthCfuXo6+he9+Wq7gIYXHScKRXilckx
         qh4Xnnnb8nFg+3TNxslTTy3aA0MuaPgAs8f8TvXyFqBdbED3LwsTY2uAa0jq/8JD10
         z/7E7GylUAPnp1U7m8nHM3VqANIK5qPzADv558t+fTA3lm5jAn/piSMckB7WELFpL1
         Tc60J78Opv4qw==
Message-ID: <35fe8ddc-cbf3-403c-a40a-2e7b6842ec98@collabora.com>
Date:   Mon, 21 Aug 2023 19:11:15 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
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
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v32 2/6] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230816113049.1697849-1-usama.anjum@collabora.com>
 <20230816113049.1697849-3-usama.anjum@collabora.com>
 <ZOAVEFniF/dm+mre@qmqm.qmqm.pl>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZOAVEFniF/dm+mre@qmqm.qmqm.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/19/23 6:04 AM, Michał Mirosław wrote:
> On Wed, Aug 16, 2023 at 04:30:45PM +0500, Muhammad Usama Anjum wrote:
>> The PAGEMAP_SCAN IOCTL on the pagemap file can be used to get or optionally
>> clear the info about page table entries.
> [...]
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
> [...]
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +static unsigned long pagemap_thp_category(pmd_t pmd)
>> +{
>> +	unsigned long categories = PAGE_IS_HUGE;
>> +
>> +	/*
>> +	 * THPs don't support file-backed memory. So PAGE_IS_FILE
>> +	 * is not checked here.
>> +	 */
> 
> It seems that we can have THP for files: ref. recent LKML thread [1].
> 
> [1] https://lkml.org/lkml/2023/8/16/1212
I didn't know about this. It seems like khugepaged can create file THPs.
Not sure if there is direct way to create file backed THPs. Maybe they'll
add this support after adding writing support to these file backed THPs.
READ_ONLY_THP_FOR_FS mentions this.

I can add a few lines of code for this here.

> 
>> +	if (pmd_present(pmd)) {
>> +		categories |= PAGE_IS_PRESENT;
>> +		if (!pmd_uffd_wp(pmd))
>> +			categories |= PAGE_IS_WRITTEN;
>> +		if (is_zero_pfn(pmd_pfn(pmd)))
>> +			categories |= PAGE_IS_PFNZERO;
>> +	} else if (is_swap_pmd(pmd)) {
>> +		categories |= PAGE_IS_SWAPPED;
>> +		if (!pmd_swp_uffd_wp(pmd))
>> +			categories |= PAGE_IS_WRITTEN;
>> +	}
>> +
>> +	return categories;
>> +}
> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
