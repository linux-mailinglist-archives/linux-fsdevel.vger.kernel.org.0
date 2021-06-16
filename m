Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF323AA114
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 18:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbhFPQTo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 12:19:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47670 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhFPQTn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:19:43 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 43F8621921;
        Wed, 16 Jun 2021 16:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623860256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=njQh0Wj8WGqpcEnSwnEIFqX3b+bD5hRU4nFDwvJD51Y=;
        b=x8GfO/lVcMvcF5Fj0qKyGb8+xN3ppnNPTSU0Yp+66OEEUn/nZ+1tdBP51ijek3bWbI32le
        wNVK6yBVUBU1tAA3klToZ4C2JOrYBsRSIH65SO7zzGIDn2pYzGBsHx7SEeCSlY6ZxrkIvW
        1ypApUaAaRIateixBhRf6p3m8OfhTVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623860256;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=njQh0Wj8WGqpcEnSwnEIFqX3b+bD5hRU4nFDwvJD51Y=;
        b=MNPRJqa5yVnzKY8PFe6WuLwgPRRX0REjJAA7HUqq9+5EffLPd4cksrHweNkxqwlw2/NN8T
        7JlPIsGzXczqtdDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 052A7118DD;
        Wed, 16 Jun 2021 16:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623860256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=njQh0Wj8WGqpcEnSwnEIFqX3b+bD5hRU4nFDwvJD51Y=;
        b=x8GfO/lVcMvcF5Fj0qKyGb8+xN3ppnNPTSU0Yp+66OEEUn/nZ+1tdBP51ijek3bWbI32le
        wNVK6yBVUBU1tAA3klToZ4C2JOrYBsRSIH65SO7zzGIDn2pYzGBsHx7SEeCSlY6ZxrkIvW
        1ypApUaAaRIateixBhRf6p3m8OfhTVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623860256;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=njQh0Wj8WGqpcEnSwnEIFqX3b+bD5hRU4nFDwvJD51Y=;
        b=MNPRJqa5yVnzKY8PFe6WuLwgPRRX0REjJAA7HUqq9+5EffLPd4cksrHweNkxqwlw2/NN8T
        7JlPIsGzXczqtdDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 8K+jACAkymBTGQAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 16 Jun 2021 16:17:36 +0000
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Qian Cai <quic_qiancai@quicinc.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, greg@kroah.com, glittao@gmail.com,
        andy.shevchenko@gmail.com
Cc:     vinmenon@codeaurora.org, Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux-FSDevel <linux-fsdevel@vger.kernel.org>
References: <1623438200-19361-1-git-send-email-faiyazm@codeaurora.org>
 <8c821abf-8fa6-b78b-cea4-b7d3b3b74a69@quicinc.com>
 <ce1b3c14-ec88-c957-0694-834051d4d39e@suse.cz>
 <25d59ad1-4d21-181c-afc2-8f396672bfd1@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v12] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
Message-ID: <21ccb5c6-2aee-f223-cd45-52b78e1f8640@suse.cz>
Date:   Wed, 16 Jun 2021 18:17:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <25d59ad1-4d21-181c-afc2-8f396672bfd1@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/16/21 5:50 PM, Faiyaz Mohammed wrote:
> 
> 
> On 6/16/2021 4:35 PM, Vlastimil Babka wrote:
>> On 6/15/21 5:58 PM, Qian Cai wrote:
>>>
>>>
>>> On 6/11/2021 3:03 PM, Faiyaz Mohammed wrote:
>>>> alloc_calls and free_calls implementation in sysfs have two issues,
>>>> one is PAGE_SIZE limitation of sysfs and other is it does not adhere
>>>> to "one value per file" rule.
>>>>
>>>> To overcome this issues, move the alloc_calls and free_calls
>>>> implementation to debugfs.
>>>>
>>>> Debugfs cache will be created if SLAB_STORE_USER flag is set.
>>>>
>>>> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
>>>> to be inline with what it does.
>>>>
>>>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>>>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
>>>
>>> Reverting this commit on today's linux-next fixed all leaks (hundreds) reported by kmemleak like below,
>>>
>>> unreferenced object 0xffff00091ae1b540 (size 64):
>>>   comm "lsbug", pid 1607, jiffies 4294958291 (age 1476.340s)
>>>   hex dump (first 32 bytes):
>>>     02 00 00 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kkkkkkkk
>>>     6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
>>>   backtrace:
>>>     [<ffff8000106b06b8>] slab_post_alloc_hook+0xa0/0x418
>>>     [<ffff8000106b5c7c>] kmem_cache_alloc_trace+0x1e4/0x378
>>>     [<ffff8000106b5e40>] slab_debugfs_start+0x30/0x50
>>>     slab_debugfs_start at /usr/src/linux-next/mm/slub.c:5831
>>>     [<ffff8000107b3dbc>] seq_read_iter+0x214/0xd50
>>>     [<ffff8000107b4b84>] seq_read+0x28c/0x418
>>>     [<ffff8000109560b4>] full_proxy_read+0xdc/0x148
>>>     [<ffff800010738f24>] vfs_read+0x104/0x340
>>>     [<ffff800010739ee0>] ksys_read+0xf8/0x1e0
>>>     [<ffff80001073a03c>] __arm64_sys_read+0x74/0xa8
>>>     [<ffff8000100358d4>] invoke_syscall.constprop.0+0xdc/0x1d8
>>>     [<ffff800010035ab4>] do_el0_svc+0xe4/0x298
>>>     [<ffff800011138528>] el0_svc+0x20/0x30
>>>     [<ffff800011138b08>] el0t_64_sync_handler+0xb0/0xb8
>>>     [<ffff80001001259c>] el0t_64_sync+0x178/0x17c
>>>
>> 
>> I think the problem is here:
>> 
>>>> +static void slab_debugfs_stop(struct seq_file *seq, void *v)
>>>> +{
>>>> +	kfree(v);
>>>> +}
>>>> +
>>>> +static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
>>>> +{
>>>> +	loff_t *spos = v;
>>>> +	struct loc_track *t = seq->private;
>>>> +
>>>> +	if (*ppos < t->count) {
>>>> +		*ppos = ++*spos;
>>>> +		return spos;
>>>> +	}
>>>> +	*ppos = ++*spos;
>>>> +	return NULL;
>>>> +}
>> 
>> If we return NULL, then NULL is passed to slab_debugfs_stop and thus we don't
>> kfree ppos. kfree(NULL) is silently ignored.
>> 
> I think yes, if NULL passed to kfree, it simply do return.
>> I think as we have private struct loc_track, we can add a pos field there and
>> avoid the kmaloc/kfree altogether.
>> 
> Hmm, yes we can add pos field "or" we can use argument "v" mean we can
> update v with pos in ->next() and use in ->show() to avoid the leak
> (kmalloc/kfree).

Can you explain the "or" part more. It's exactly what we already do, no? We use
"v" as you said. The problem is, if next(); returns NULL, then stop() gets the
NULL as "v". It's just what I see in the code of seq_read_iter() and traverse()
in fs/seq_file.c. I don't see another way to say there are no more records to
print - only to return NULL in next().
Ah, ok so we could maybe do the kfree() in next() then before returning NULL,
which is the last moment we have the pointer. But really, if we already have a
loc_track in private, why kmalloc an additional loff_t.

Anyway it seems to me also that
Documentation/filesystems/seq_file.rst should be updated, as the kfree() in
stop() is exactly what it suggests, and it doesn't show how next() indicates
that there are no more records by returning NULL, and what to do about kfree() then.
