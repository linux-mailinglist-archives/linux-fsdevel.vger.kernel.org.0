Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B774164B597
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 14:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiLMNEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 08:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiLMNET (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:04:19 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319E11D333;
        Tue, 13 Dec 2022 05:04:18 -0800 (PST)
Received: from [192.168.10.9] (unknown [39.45.25.143])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9F4BD6602BE3;
        Tue, 13 Dec 2022 13:04:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670936655;
        bh=DS1yA+9XmvYzYNCforotpq+Ol0Tx/1wHHkNgJvMknJw=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=evzGVJCnpg4Ir/+WqpNCzOcMVx6xdKFUa4HxK6tKwytXZs8UBlg/7Wto83ls+GnYU
         zEdZHrxsd717cqCl5ylOk2uwbNbNQC/14rcXw86eVcjWPOlOPVSe44c7NdPhOOwX31
         tOzXdmwu0QGuOtaB/RoRJs2OzDyLo79VXLFMJcm4/SnCYcxVXeT3QSxKCsEE0RrbFO
         HSgsGh+cfdTAv5HiH5Lq1zF4m+//KmonD/cqBokq/5WhmPPv64yiCHriPk44pw9la9
         ukiD0t0DbNAOyFnmVan/cfDBl0ht7zKWOyqH0P6y3PVCmGqaFvfPIl5oyPevMlz3ou
         TbscPsB/9K+dg==
Message-ID: <d7185563-3a7a-d69e-d3d1-1a2b071aa85d@collabora.com>
Date:   Tue, 13 Dec 2022 18:04:04 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
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
        "open list : MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Paul Gofman <pgofman@codeweavers.com>
Subject: Re: [PATCH v6 2/3] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Content-Language: en-US
To:     Cyrill Gorcunov <gorcunov@gmail.com>
References: <20221109102303.851281-1-usama.anjum@collabora.com>
 <20221109102303.851281-3-usama.anjum@collabora.com> <Y5eSKBJ9hTtw9cbK@grain>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y5eSKBJ9hTtw9cbK@grain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/13/22 1:42 AM, Cyrill Gorcunov wrote:
> On Wed, Nov 09, 2022 at 03:23:02PM +0500, Muhammad Usama Anjum wrote:
> ...
>> +
>> +static long do_pagemap_sd_cmd(struct mm_struct *mm, struct pagemap_scan_arg *arg)
>> +{
>> +	struct mmu_notifier_range range;
>> +	unsigned long __user start, end;
>> +	struct pagemap_scan_private p;
>> +	int ret;
>> +
>> +	start = (unsigned long)untagged_addr(arg->start);
>> +	if ((!IS_ALIGNED(start, PAGE_SIZE)) || (!access_ok((void __user *)start, arg->len)))
>> +		return -EINVAL;
>> +
>> +	if (IS_GET_OP(arg) &&
>> +	    ((arg->vec_len == 0) || (!access_ok((struct page_region *)arg->vec, arg->vec_len))))
>> +		return -ENOMEM;
>> +
>> +	if (IS_SD_OP(arg) && ((arg->required_mask & PAGEMAP_NONSD_OP_MASK) ||
>> +	     (arg->anyof_mask & PAGEMAP_NONSD_OP_MASK)))
>> +		return -EINVAL;
>> +
>> +	end = start + arg->len;
>> +	p.max_pages = arg->max_pages;
>> +	p.found_pages = 0;
>> +	p.flags = arg->flags;
>> +	p.required_mask = arg->required_mask;
>> +	p.anyof_mask = arg->anyof_mask;
>> +	p.excluded_mask = arg->excluded_mask;
>> +	p.return_mask = arg->return_mask;
>> +	p.vec_index = 0;
>> +	p.vec_len = arg->vec_len;
>> +
>> +	if (IS_GET_OP(arg)) {
>> +		p.vec = vzalloc(arg->vec_len * sizeof(struct page_region));
>> +		if (!p.vec)
>> +			return -ENOMEM;
>> +	} else {
>> +		p.vec = NULL;
>> +	}
> 
> Hi Muhammad! I'm really sorry for diving in such late (unfortunatelly too busy to
> step in yet). Anyway, while in general such interface looks reasonable here are
> few moments which really bothers me: as far as I undertstand you don't need
> vzalloc here, plain vmalloc should works as well since you copy only filled
> results back to userspace. Thank you for reviewing. Correct, I'll update to use vmalloc.

> Next -- there is no restriction on vec_len parameter,
> is not here a door for DoS from userspace? Say I could start a number of ioctl
> on same pagemap and try to allocate very big amount of vec_len in summay causing
> big pressure on kernel's memory. Or I miss something obvious here?
Yes, there is a chance that a large chunk of kernel memory can get
allocated here as vec_len can be very large. We need to think of limiting
this buffer in the current implementation. Any reasonable limit should
work. I'm not sure what would be the reasonable limit. Maybe couple of
hundred MBs? I'll think about it. Or I should update the implementation
such that less amount of intermediate buffer can be used like mincore does.
But this can complicate the implementation further as we are already using
page ranges instead of keeping just the flags. I'll see what can be done.

-- 
BR,
Muhammad Usama Anjum
