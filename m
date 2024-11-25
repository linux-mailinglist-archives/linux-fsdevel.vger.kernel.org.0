Return-Path: <linux-fsdevel+bounces-35741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5309D7952
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 01:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4CA416250D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 00:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB30B64A;
	Mon, 25 Nov 2024 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eKswk0em"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529342119
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732494652; cv=none; b=sE+MzNgpzSfSX98Asa+BShpRKIw+PpOl36IJ3TPpDV9xtNehY+n9aaAY7cZ95pdWuoVVZZpvrKkYJwScvb1lVojZvyQwe0PuokZrzDYQWKXEytVLX53qyDGJhcETfjH7jBgMLRSb21f5LxJd7MzbTmlXRt2Ll0UE7Kw5RkuzZq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732494652; c=relaxed/simple;
	bh=cdCkIqj0b+E2omPf3ZS2ZtoTtg6+WHjpWfYiHVKfKDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQSfM2GDXlap7/OO5xUps0jG/3uf8xGxGb/zVoG7PVIxzmYHYJplfdYKHGjP90KOns30lmhpTLlOoSn6Q1+4BpKFkiBaex/7ac7isbfAMM5pwx3rJ1ynYD1YN3D2cB1EQUX6wTmOoyIsc9MdE/3Rp4We5JYDUVwac6hXaQmcbVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eKswk0em; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38231e9d518so2556835f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 16:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732494648; x=1733099448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=In4MV9J97AT0cT9b+Yku4Fnet8PUyuFSy1FKoa/EZ1Y=;
        b=eKswk0emjwUi7/FOIoH45WayC2hK4Ilpqq+/Q7/85phY/VPJfnGVBbJujTYXwFspAe
         SReW32Gx7MuJgyLnbFQTGCKVIG0E8DWYY+TUw/LEGUDjqz45c87a32yJyzifSknjbxmi
         8gGbndB9uhWbMaLfKU0BQEm2UM0pQgXwN5QVkPnvaMJoYxjRZBeOE9BR0CXu5OUTOj1B
         nSyg7LyTUjBJ88Nkl0LkBoOoSpXDITriKV0NF6s4LRoXsv8pCrGoeSLAYITTncY/ZV5J
         6Dc8AxfgOmbfxY9RxyeVTm/y2nXozYLNz5qYP00HLH7Yk4rUQrfm5fE92gIvqyaNMi1f
         yjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732494648; x=1733099448;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=In4MV9J97AT0cT9b+Yku4Fnet8PUyuFSy1FKoa/EZ1Y=;
        b=dJWmRa9EHf8repi/RF3n8MXjWqF3W+Q4+yleYvgvzoMqmmalV6wPbcEnYJkHwZKmZi
         QVFn12yRXX4vyAGx5L3dReCBqqYnnOipunDqd5lx/JOOhEgQe4c06tLsk9s3928YleVx
         2uSvA43fTx178ZZpLPK5KHMOZe5FkAuB5SHHvtSK81G+lKKACZSAclpcu7rOCTsn8dbN
         u095dHua9lx+cFeT4nwHs0oS9TfBGRykIgC45quVqUdKpa+bIpQW7esec0e5poZMV8Y3
         huMFAZwu5Vu2WqEow27zSKT5G0aayH3UDhME0NnMMVUNFu/C9jnideCsFlWgbrU8nK9S
         SOnA==
X-Forwarded-Encrypted: i=1; AJvYcCUuQBUwLblL477ulOnjKwI+RzuG/38liiBh7G3UuziBb3Bjo8EZVwMTDFIhkJ4CyZ63POXGNO8zfZT/CqHh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0d4OIMOhMhdotvsDu/toSJkNmRKxGxzOqzm8SuaUGEXo9vG0M
	UpefWUHSMVK3rauii0aO63SRfAU8wjcxBLyypuga9G6UAglXz1HhoNspaqe/9wI=
X-Gm-Gg: ASbGncsG3DGsy4fEBHUPfNgcwY/6jZLllrVMEPH/7juHktx0uvsMWgJRGOB3WLrc+2L
	espHvNyI4TrARfV18YEkLl77ScTX1kOBmd2l1F0h4FcR17AQ6rvjOtFcie3ioCJstO4kb2Oag1s
	q6Pg/KkBVRz0gfJNdh3vzpkzHL8wi2WwCI81Adfwg5HkhbMIDZl7PiuPVkpOTs2kZ2GHr5PRhwm
	QKyIbNHCy1FWqONBqnvAHtLdbQjKRhHSSiHKOcIq9azu/hLYV+I1HvA17kGSWpdviGxK99yMeS8
	UQ==
X-Google-Smtp-Source: AGHT+IGRZF+ElRynDvzCG5+WgNc1U48/xAfkxjpXHoROCBbo3clZ8AH2AsjNjPvm/2klj3XuvbspIg==
X-Received: by 2002:a05:6000:154c:b0:382:5010:c8e1 with SMTP id ffacd0b85a97d-38260bc861bmr8406253f8f.42.1732494648187;
        Sun, 24 Nov 2024 16:30:48 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8d478sm52248305ad.33.2024.11.24.16.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 16:30:47 -0800 (PST)
Message-ID: <b57b3d18-7a70-4efa-a356-809c6ab29c02@suse.com>
Date: Mon, 25 Nov 2024 11:00:40 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] kernel BUG in __folio_start_writeback
To: Matthew Wilcox <willy@infradead.org>,
 syzbot <syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
 josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
References: <67432dee.050a0220.1cc393.0041.GAE@google.com>
 <Z0OaHcMWcRtohZfz@casper.infradead.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <Z0OaHcMWcRtohZfz@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/25 07:56, Matthew Wilcox 写道:
> On Sun, Nov 24, 2024 at 05:45:18AM -0800, syzbot wrote:
>>
>>   __fput+0x5ba/0xa50 fs/file_table.c:458
>>   task_work_run+0x24f/0x310 kernel/task_work.c:239
>>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>>   exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>>   exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>>   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>>   syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
>>   do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> This is:
> 
>          VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
> 
> ie we've called __folio_start_writeback() on a folio which is already
> under writeback.
> 
> Higher up in the trace, we have the useful information:
> 
>   page: refcount:6 mapcount:0 mapping:ffff888077139710 index:0x3 pfn:0x72ae5
>   memcg:ffff888140adc000
>   aops:btrfs_aops ino:105 dentry name(?):"file2"
>   flags: 0xfff000000040ab(locked|waiters|uptodate|lru|private|writeback|node=0|zone=1|lastcpupid=0x7ff)
>   raw: 00fff000000040ab ffffea0001c8f408 ffffea0000939708 ffff888077139710
>   raw: 0000000000000003 0000000000000001 00000006ffffffff ffff888140adc000
>   page dumped because: VM_BUG_ON_FOLIO(folio_test_writeback(folio))
>   page_owner tracks the page as allocated
> 
> The interesting part of the page_owner stacktrace is:
> 
>    filemap_alloc_folio_noprof+0xdf/0x500
>    __filemap_get_folio+0x446/0xbd0
>    prepare_one_folio+0xb6/0xa20
>    btrfs_buffered_write+0x6bd/0x1150
>    btrfs_direct_write+0x52d/0xa30
>    btrfs_do_write_iter+0x2a0/0x760
>    do_iter_readv_writev+0x600/0x880
>    vfs_writev+0x376/0xba0
> 
> (ie not very interesting)
> 
>> Workqueue: btrfs-delalloc btrfs_work_helper
>> RIP: 0010:__folio_start_writeback+0xc06/0x1050 mm/page-writeback.c:3119
>> Call Trace:
>>   <TASK>
>>   process_one_folio fs/btrfs/extent_io.c:187 [inline]
>>   __process_folios_contig+0x31c/0x540 fs/btrfs/extent_io.c:216
>>   submit_one_async_extent fs/btrfs/inode.c:1229 [inline]
>>   submit_compressed_extents+0xdb3/0x16e0 fs/btrfs/inode.c:1632
>>   run_ordered_work fs/btrfs/async-thread.c:245 [inline]
>>   btrfs_work_helper+0x56b/0xc50 fs/btrfs/async-thread.c:324
>>   process_one_work kernel/workqueue.c:3229 [inline]
> 
> This looks like a race?
> 
> process_one_folio() calls
> btrfs_folio_clamp_set_writeback calls
> btrfs_subpage_set_writeback:
> 
>          spin_lock_irqsave(&subpage->lock, flags);
>          bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits)
> ;
>          if (!folio_test_writeback(folio))
>                  folio_start_writeback(folio);
>          spin_unlock_irqrestore(&subpage->lock, flags);
> 
> so somebody else set writeback after we tested for writeback here.

The test VM is using X86_64, thus we won't go into the subpage routine, 
but directly call folio_start_writeback().

> 
> One thing that comes to mind is that _usually_ we take folio_lock()
> first, then start writeback, then call folio_unlock() and btrfs isn't
> doing that here (afaict).  Maybe that's not the source of the bug?

We still hold the folio locked, do submission then unlock.

You can check extent_writepage(), where at the entrance we check if the 
folio is still locked.
Then inside extent_writepage_io() we do the submission, setting the 
folio writeback inside submit_one_sector().
Eventually unlock the folio at the end of extent_writepage(), that's for 
the uncompressed writes.

There are a lot of special handling for async submission (compression), 
but it  still holds the folio locked, do compression and submission, and 
unlock, just all in another thread (this case).

So it looks like something is wrong when transferring the ownership of 
the page cache folios to the compression path, or some not properly 
handled error path.

Unfortunately I'm not really able to reproduce the case using the 
reproducer...

Thanks,
Qu



> 
> If it is, should we have a VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio)
> in __folio_start_writeback()?  Or is there somewhere that can't lock the
> folio before starting writeback?
> 


