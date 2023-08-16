Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207ED77DEA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 12:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243903AbjHPK24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 06:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243957AbjHPK2p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:28:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4AF1FE2;
        Wed, 16 Aug 2023 03:28:39 -0700 (PDT)
Received: from [192.168.100.7] (unknown [59.103.216.185])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9F9196601F5E;
        Wed, 16 Aug 2023 11:28:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692181716;
        bh=ftvs9GI0pTNN1Q/Ql07C6782DgKc5N83c95v6mS+/Vs=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=PpzIsZzgyGy2AshrVIdc0edRLPNHnuk21fD7lKYnpXHzB3doJSC+w046cwPHp/3hr
         aGPn8aQutuTcG4dJfCB0G+DhBK26/PIQiLCKqfEdv4XVOxnIs2Xw/5rd7gw3LysdUf
         G6d4DFOa5zJIzJGVq1WxwkqR53uGvGX9Ec7S1iR4WyZQfAMzWxhgPSee/WCpJUnSZP
         8QzQsj1RZ2d4z3hBSRUfN2O7gaN3i0UM1t/yduIBDcTVfRbwFvp126hmnNSFzCPqTB
         KvDfCe2qfyzx+UxAeRAVPZXYkHw5NR7FhImLJF9vXmy1H4wiAJ4gWXswlWiD/saGHX
         UK21CV+X0xKqA==
Message-ID: <4367a28b-97c8-a73a-f8a2-8706d8ecf285@collabora.com>
Date:   Wed, 16 Aug 2023 15:28:26 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v30 2/6] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20230816065925.850879-1-usama.anjum@collabora.com>
 <20230816065925.850879-3-usama.anjum@collabora.com>
 <ZNya0c7zRmQ/HPMl@qmqm.qmqm.pl>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZNya0c7zRmQ/HPMl@qmqm.qmqm.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/16/23 2:45 PM, Michał Mirosław wrote:
> On Wed, Aug 16, 2023 at 11:59:21AM +0500, Muhammad Usama Anjum wrote:
>> The PAGEMAP_SCAN IOCTL on the pagemap file can be used to get or optionally
>> clear the info about page table entries.
> [...]
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
> [...]
>> +static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
>> +{
> [...]
>> +	for (walk_start = p.arg.start; walk_start < p.arg.end;
>> +			walk_start = p.arg.walk_end) {
>> +		long n_out;
>> +
>> +		if (fatal_signal_pending(current)) {
>> +			ret = -EINTR;
>> +			break;
>> +		}
>> +
>> +		ret = mmap_read_lock_killable(mm);
>> +		if (ret)
>> +			break;
>> +		ret = walk_page_range(mm, walk_start, p.arg.end,
>> +				      &pagemap_scan_ops, &p);
>> +		mmap_read_unlock(mm);
>> +
>> +		n_out = pagemap_scan_flush_buffer(&p);
>> +		if (n_out < 0)
>> +			ret = n_out;
>> +		else
>> +			n_ranges_out += n_out;
>> +
>> +		p.arg.walk_end = p.walk_end_addr ? p.walk_end_addr : p.arg.end;
> 
> I think p.walk_end_addr can be removed and replaced by `p.arg.walk_end`
> directly in the walk functions. If we don't set walk_end_addr we'll also
> return 0 so the check below will match. Might be good to add this as
> a comment.
I'll remove it and add a short comment.

> 
>> +		if (ret != -ENOSPC)
>> +			break;
>> +
>> +		if (p.arg.vec_len == 0 || p.found_pages == p.arg.max_pages)
>> +			break;
>> +	}
>> +
>> +	/* ENOSPC signifies early stop (buffer full) from the walk. */
>> +	if (!ret || ret == -ENOSPC)
>> +		ret = n_ranges_out;
>> +
>> +	p.arg.walk_end = p.arg.walk_end ? p.arg.walk_end : walk_start;
> 
> When the walk is finished, with ret == 0, the walk_start will point to
> the beginning, not the end of the range. So:
> 
> if (!walk_end) walk_end = p.arg.end;
This condition is to cater for the case when for loop doesn't execute at
all because the address range was zero. In that case start == end. So
p.arg.start or p.arg.end both would work fine. I'll add p.arg.end in
accordance to above loop.

> 
> Other than that, the patch looks complete now. Thanks for all your work!
I'll send the next revision.

> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
