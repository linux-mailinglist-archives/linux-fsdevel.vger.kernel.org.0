Return-Path: <linux-fsdevel+bounces-49857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D00AC42B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 17:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF84F3B26C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 15:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033452139CE;
	Mon, 26 May 2025 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="K7elq6un"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E82566
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748275089; cv=none; b=Eo/GcR4tScmJA2IraUzNgU/rPelEMCDjtvq3jNVy0P1QZL5xDFFf6eKL0QUteRCCZvMXUbhHzdUu1sheHtIMngohgpHhnKNR7Rarkw+yUTF/6ZppGoNMiLG1LulM1U1SB3U5PrF3zfZ5lmlSpbPXhFDQacEx8itZdCrj3EJygYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748275089; c=relaxed/simple;
	bh=JwoRkGOwOBjt4U22YRQH7wxZkmkUEKhs6C/eTV2xQmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqT0UMYRpM2mAm2bpHfrEwzpmOW69j/fz1P1erLYJ2NB+ayVEFzWSY4AEJWFBT3JALgrKQbOAvKTBWona2h/ZQLCQtsj7cYvtCflVlxWMwBtcb3EjTMfNfV10cljp67rx4tbXVfdg6j0lLRIWc70eV9JcejjnyWXeVop5x9C7ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=K7elq6un; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-861b1f04b99so66262739f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748275086; x=1748879886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y7CFfOdbeNiTdGmOpgebK5hzq1A+U47oLBFKifR2CHA=;
        b=K7elq6unwY+eCjstnVF1KgcRCfnc+51v4uNf8G2aq/h0KkccsNelGFFUbRPbgK956f
         MfdwzBLQ97FSMllAAvSxyR8iX7Quct4Vhm/x3u/u3i7xAxj5aD/UONnKTdyOX0QDtUDi
         M1wZqoh8iNJNhgWJqdakrK+2DIeWuTIbaYF+/q1NT6uT2i/Gzbr8jUe1K/6QNtJLQEc9
         iVpZUDzxciykGQgSkO4DuNVdsXvfkCp9Oq9S1uWDi6MlJDT/NLWxoC+n2N2EY9cuOYVd
         EnMTu7y9ZLpQec8EdvT7878zRNb4KCVIhbMUCRVH0+fzUHjk+FjvZQHfZ23AHWch1mri
         29Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748275086; x=1748879886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7CFfOdbeNiTdGmOpgebK5hzq1A+U47oLBFKifR2CHA=;
        b=aCqr+iKY2jqCH8EskrF/GuGPctgb+6nKv2htg0tcbR9z7VUDcxkhGO4Ua8rgYpebZy
         4BiuYJql04y/vRKQPMA/vN0wk4MZPzTCcteFsYZphes6ymtSiAb413j7KQ0EgRoR1du/
         spXurSfxdJBrwsudlLU9I5zVcSG7mrw2tzmgApSQ8Nko/6SlpQB3ClNQ9gDgYmqZQ6Tb
         xfrwogqvV9mCXtZr56NnKWH5U5GecgWM1Ij79t8hmVXdjNOAzAFcvT13ylOCuzg37Fbm
         4gYk4s/ZmS4xwcucz/CxE2goCEzGajXIb5jvkPbrZnh3R1NObdW0laVAThxqwoOHLwdJ
         RPyw==
X-Forwarded-Encrypted: i=1; AJvYcCXPwcKkJ2KTtZXjPX7KuKNeILDhX0rDZepLZroBEqHKqtv+YSul213dPBEXIrH733IVJu7wLAk7ouT4wl3S@vger.kernel.org
X-Gm-Message-State: AOJu0YzgIFT26r9wf8wIJ0/PF3WENRl/Rtw1/e6kRFy2e35O9bk0YFJj
	4Xua+Cd70h5JAnphsGE1lJ3VTXumBFRKcbZc+f+kMUx1yelqiAtGPNmggPLtSz27LW4=
X-Gm-Gg: ASbGncszwNE4MB7Z/L+MuFZCzDPbpusRh54AXKM3qYeXOrNvR6ixeP51kChkJuhIW0V
	lGek8MK4fTFTdF5UlAoBKlygY522qS22tucp5M5wWNGQkXDiLHwkkSkJxPeQqsSlRCmALTcPuN/
	Elei0OYvNUi5hDYzUNkOl/f+R/1GDOSxeq/kj2R9xD65cLtqz7n74WDZCjNJolDjd630nls511K
	fYUIZ3/HbAqHo7QbxYWZX+F3TamdfYoGvuRzbQKLwcgay2e/5WYYYK9BWgYn1QEcgoMYCUVJQSj
	V6tJEuEAFVlsagpOHpEXVZCDQyXyMwd3FglQQuBGA0y3bdzP
X-Google-Smtp-Source: AGHT+IEQIyh0Kkl2s8g5qzs6pl0cfoxrmVXzZamKFvMFxMBljYowI0rvs8s0G5Id070csHA0F9c+LA==
X-Received: by 2002:a05:6e02:160c:b0:3d9:65b6:d4db with SMTP id e9e14a558f8ab-3dc9b696c46mr90048105ab.12.1748275085766;
        Mon, 26 May 2025 08:58:05 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dca0409ce3sm14416065ab.58.2025.05.26.08.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 08:58:05 -0700 (PDT)
Message-ID: <432302ad-aa95-44f4-8728-77e61cc1f20c@kernel.dk>
Date: Mon, 26 May 2025 09:58:04 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
To: Vlastimil Babka <vbabka@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20250525083209.GS2023217@ZenIV> <20250525180632.GU2023217@ZenIV>
 <40eeba97-a298-4ae1-9691-b5911ad00095@suse.cz>
 <431cb497-b1ad-40a0-86b1-228b0b7490b9@kernel.dk>
 <6741c978-98b1-4d6f-af14-017b66d32574@kernel.dk>
 <9f0786e3-f8df-4c62-b5c0-10db0acb2b02@suse.cz>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <9f0786e3-f8df-4c62-b5c0-10db0acb2b02@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/25 9:31 AM, Vlastimil Babka wrote:
> On 5/26/25 17:06, Jens Axboe wrote:
>> On 5/26/25 7:05 AM, Jens Axboe wrote:
>>> On 5/25/25 1:12 PM, Vlastimil Babka wrote:
>>>
>>> Thanks for taking a look at this! I tried to reproduce this this morning
>>> and failed miserably. I then injected a delay for the above case, and it
>>> does indeed then trigger for me. So far, so good.
>>>
>>> I agree with your analysis, we should only be doing the dropbehind for a
>>> non-zero return from __folio_end_writeback(), and that includes the
>>> test_and_clear to avoid dropping the drop-behind state. But we also need
>>> to check/clear this state pre __folio_end_writeback(), which then puts
>>> us in a spot where it needs to potentially be re-set. Which fails pretty
>>> racy...
>>>
>>> I'll ponder this a bit. Good thing fsx got RWF_DONTCACHE support, or I
>>> suspect this would've taken a while to run into.
>>
>> Took a closer look... I may be smoking something good here, but I don't
>> see what the __folio_end_writeback()() return value has to do with this
>> at all. Regardless of what it returns, it should've cleared
>> PG_writeback, and in fact the only thing it returns is whether or not we
>> had anyone waiting on it. Which should have _zero_ bearing on whether or
>> not we can clear/invalidate the range.
> 
> Yeah it's very much possible that I was wrong, folio_xor_flags_has_waiters()
> looked a bit impenetrable to me, and it seemed like an simple explanation to
> the splats. But as you had to add delays, this indeed smells as a race.

Here's my delay trace fwiw, which is a bit different:

BUG: Bad page state in process fsx  pfn:4866b
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x25 pfn:0x4866b
flags: 0x3ffe0000000000a(uptodate|writeback|node=0|zone=0|lastcpupid=0x1fff)
raw: 03ffe0000000000a dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000025 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
Modules linked in:
CPU: 6 UID: 0 PID: 1853 Comm: fsx Not tainted 6.15.0-rc7-00144-gb1427432d3b6-dirty #1053 NONE 
Hardware name: linux,dummy-virt (DT)
Call trace:
 show_stack+0x1c/0x30 (C)
 dump_stack_lvl+0x58/0x78
 dump_stack+0x18/0x20
 bad_page+0x1a4/0x228
 free_unref_folios+0xc2c/0x1920
 folios_put_refs+0x354/0x5f0
 __folio_batch_release+0x98/0xd0
 writeback_iter+0x8f8/0xd00
 iomap_writepages+0x16e4/0x2090
 xfs_vm_writepages+0x200/0x2c0
 do_writepages+0x148/0x7c0
 filemap_fdatawrite_wbc+0xe0/0x138
 __filemap_fdatawrite_range+0xb0/0x100
 filemap_write_and_wait_range+0x68/0x100
 __generic_remap_file_range_prep+0x418/0x1090
 generic_remap_file_range_prep+0x18/0x80
 xfs_reflink_remap_prep+0x160/0x7d8
 xfs_file_remap_range+0x164/0xa90
 vfs_dedupe_file_range_one+0x398/0x4a0
 vfs_dedupe_file_range+0x410/0x648
 do_vfs_ioctl+0x13c4/0x1fc0
 __arm64_sys_ioctl+0xd8/0x188
 invoke_syscall.constprop.0+0x60/0x2a0
 el0_svc_common.constprop.0+0x148/0x240
 do_el0_svc+0x40/0x60
 el0_svc+0x34/0x70
 el0t_64_sync_handler+0x104/0x138
 el0t_64_sync+0x170/0x178
Disabling lock debugging due to kernel taint
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x25 pfn:0x4866b
flags: 0x3ffe0000000000a(uptodate|writeback|node=0|zone=0|lastcpupid=0x1fff)
raw: 03ffe0000000000a dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000025 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: VM_BUG_ON_FOLIO(((unsigned int) folio_ref_count(folio) + 127u <= 127u))
------------[ cut here ]------------
kernel BUG at ./include/linux/mm.h:1543!
Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
Modules linked in:
CPU: 6 UID: 0 PID: 0 Comm: swapper/6 Tainted: G    B               6.15.0-rc7-00144-gb1427432d3b6-dirty #1053 NONE 
Tainted: [B]=BAD_PAGE
Hardware name: linux,dummy-virt (DT)
pstate: 614000c5 (nZCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : folio_end_writeback+0x470/0x560
lr : folio_end_writeback+0x470/0x560
sp : ffff8000859978f0
x29: ffff8000859978f0 x28: dfff800000000000 x27: fffffdffc0219ac0
x26: 0000000000000000 x25: ffff000005ed8138 x24: 0000000000000000
x23: 1fffffbff804335e x22: 0000000000000004 x21: 0000000000000001
x20: fffffdffc0219af4 x19: fffffdffc0219ac0 x18: 000000000000000f
x17: 635f6665725f6f69 x16: 6c6f662029746e69 x15: 0720072007200720
x14: 0720072007200720 x13: 0720072007200720 x12: ffff60001b67150b
x11: 1fffe0001b67150a x10: ffff60001b67150a x9 : dfff800000000000
x8 : 00009fffe498eaf6 x7 : ffff0000db38a853 x6 : 0000000000000001
x5 : 0000000000000001 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : ffff0000c1f98000 x0 : 000000000000005c
Call trace:
 folio_end_writeback+0x470/0x560 (P)
 iomap_finish_ioend_buffered+0x38c/0x9e0
 iomap_writepage_end_bio+0x80/0xc0
 bio_endio+0x4dc/0x678
 blk_mq_end_request_batch+0x2b4/0x10c0
 nvme_pci_complete_batch+0x338/0x518
 nvme_irq+0xd8/0xf0
 __handle_irq_event_percpu+0xdc/0x528
 handle_irq_event+0x174/0x3d8
 handle_fasteoi_irq+0x2cc/0xba0
 handle_irq_desc+0xb8/0x120
 generic_handle_domain_irq+0x20/0x30
 gic_handle_irq+0x50/0x140
 call_on_irq_stack+0x24/0x50
 do_interrupt_handler+0xe0/0x148
 el1_interrupt+0x30/0x50
 el1h_64_irq_handler+0x14/0x20
 el1h_64_irq+0x6c/0x70
 do_idle+0x244/0x4c8 (P)
 cpu_startup_entry+0x64/0x80
 secondary_start_kernel+0x1e4/0x240
 __secondary_switched+0x74/0x78
Code: 91190021 91218021 aa1303e0 94039279 (d4210000) 
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Oops - BUG: Fatal exception in interrupt
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x0000,000000e0,0109a650,834e7607
Memory Limit: none
---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception in interrupt ]---

-- 
Jens Axboe

