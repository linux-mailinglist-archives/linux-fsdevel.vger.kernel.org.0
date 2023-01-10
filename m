Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE8E6638CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 06:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjAJFuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 00:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjAJFtc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 00:49:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300A038B2;
        Mon,  9 Jan 2023 21:49:30 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.186.163])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 225DA660230B;
        Tue, 10 Jan 2023 05:49:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673329768;
        bh=IzktKiuA2C+7fFsNxOT5xp2wBaUGwyAnVvBi3Idir3E=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=JpkC/d8FVY+F4TtOcy4rj+hatadaGiVeh4gQRDbUXVPWKmVHn22jbsIquJ8kYQEUn
         bNWgZ0EijaKY2vMy4dcQdMQB/VzUd7do14SXu2oV3RTEnePYwt0wwePoOeZC1233C4
         duOmeLsaMUo56TjPeTNtsY3VvxR7e0o3uAuEF57c4VmAx321s0x6AjPBJHx1w0z9+V
         62gvy1zeYf3zE/XxpUheETJ/lCM4VUlP2rckcJ603iC6c3j6AvbLuaVnGjXtN6RCKe
         xHctrMfsbXkg6rHmj9a9lg83R8iwhfpYUJBwMT0EYsvOQZvc9SIu3NO7SvK19p6DBS
         n98N+vk+ecZkQ==
Message-ID: <8a0ebe48-c9fd-b030-71bd-4a806c6d5f29@collabora.com>
Date:   Tue, 10 Jan 2023 10:49:20 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, kernel@collabora.com,
        peterx@redhat.com, david@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] mm: implement granular soft-dirty vma support
To:     Cyrill Gorcunov <gorcunov@gmail.com>
References: <20221220162606.1595355-1-usama.anjum@collabora.com>
 <Y7ySt0XGnbzTyY6T@grain>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y7ySt0XGnbzTyY6T@grain>
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

On 1/10/23 3:18 AM, Cyrill Gorcunov wrote:
> On Tue, Dec 20, 2022 at 09:26:05PM +0500, Muhammad Usama Anjum wrote:
> ...
>>
>> +static inline int nsdr_adjust_new_first(struct vm_area_struct *new, struct vm_area_struct *vma)
>> +{
>> +	struct non_sd_reg *r, *r_tmp, *reg;
>> +	unsigned long mid = vma->vm_start;
>> +
>> +	list_for_each_entry_safe(r, r_tmp, &vma->non_sd_reg, nsdr_head) {
>> +		if (r->start < mid && r->end > mid) {
>> +			reg = kmalloc(sizeof(struct non_sd_reg), GFP_KERNEL);
>> +			if (!reg)
>> +				return -ENOMEM;
>> +			reg->start = r->start;
>> +			reg->end = mid;
>> +			list_add_tail(&reg->nsdr_head, &new->non_sd_reg);
>> +
>> +			r->start = mid;
>> +		} else if (r->end <= mid) {
>> +			list_move_tail(&r->nsdr_head, &new->non_sd_reg);
>> +		}
>> +	}
>> +	return 0;
>> +}
> 
> Hi Muhhamad, really sorry for delay. Please enlighten me here if I get your
No problem.
> idea right -- every new VMA merge might create a new non_sd_seg entry, right?
Every new VMA only has the non_sd_reg list initialized with no entries as
the whole VMA is soft-dirty at creation time. We add entries in this list
when the soft-dirty is cleared over the entire or the part of the VMA.
Once soft_dirty has been cleared, there might be entries in the non_sd_reg
lists of both VMAs which will be maintained properly if VMAs are
split/merged or freed if removed. At this time, the soft-dirty can only be
cleared over the entire process and hence over entire VMAs. So this list
will have only one entry even if VMAs are merged until VMAs are split.

> And this operation will be applied again and again until vma get freed. IOW
> we gonna have a chain of non_sd_reg which will be hanging around until VMA
> get freed, right?
Correct.

I've posted the next version of PAGEMAP_SCAN ioctl [1] where soft-dirty
support has been replaced with UFFD WP async. If that goes in, soft-dirty
support can be left alone as people don't seem receptive of the idea that
the soft-dirty support should be corrected.  UFFD WP async is better as it
is PTE based. Please review it.

[1]
https://lore.kernel.org/all/20230109064519.3555250-1-usama.anjum@collabora.com

-- 
BR,
Muhammad Usama Anjum
