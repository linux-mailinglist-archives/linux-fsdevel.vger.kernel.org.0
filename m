Return-Path: <linux-fsdevel+bounces-49854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E569AC4219
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 17:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDC23AE338
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 15:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6324245009;
	Mon, 26 May 2025 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cRj+M3dn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6072DCBE3
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748272018; cv=none; b=rMqTcrvZcXZw6OHtBaDMaUmccB+RxT/mYjsdjDUH4l9EFEA0qX09JTnrsLu39lXAVR20AqhyVHLloZNWLKWmnbz+zUBASJWVvOxTmL6f6WxFetgf6UM2zFozEYgIul2nRqwGeDrGWKTXRPXIMPWDFlSGl0g+DKUOOTcpXNoYqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748272018; c=relaxed/simple;
	bh=+RxDK02UJWXX3AFU2OTA/tQ9NDvNWzPkuUm/xO+7q0c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VcvNOlJ+0Pk94pHUeEa41R3/f3JshVV6tlDAmgCtk7j084RUUUCzxw2O64r0P7MHVR6pAmrlHK0CZCR4kWNcHQ3cDn7TIhbxFsYkMliU6F+Rcp4QWVvSI7ST889qmlPTVeA5XcDr5jR6DfFiIBC0bzKN9dtBmxe86ZgJZqJSEvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cRj+M3dn; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3dc7830a386so8893385ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 08:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748272015; x=1748876815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qGHOO9q/8/fyHzDnomJ4JDs+aV951/v+7a2GXwfIwX0=;
        b=cRj+M3dnqel1xbClX5UUH8hQucX+4r1+iyA2+MGpPcWi8Ilk876BMKr2NBBQ0bWcbB
         CR1PhLrLhcEeUZ6vOwB3Yqj1jpnjy89+uNvCZ2mOd4pS8fftPmX4kVsJb2kgAC2okgzT
         AfY3lsHdRHPKzB8687qo7NlQ8mNfMVaEx6q87Og4w4hYrAwIwiCKA0kgbmn2mOzLOsZG
         VIrrH07kiPqs5gby1bRc6u118NNOs0M77aEHtmumgdjxA+ZdxXAI2HVc86ywFi4LyO/9
         6DqraKS4a9ZUj5HLEClqQc12Gmnzf9Y+MmIzftuVDT6I/AIaflz901MuPLds/kn4IW8L
         bsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748272015; x=1748876815;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGHOO9q/8/fyHzDnomJ4JDs+aV951/v+7a2GXwfIwX0=;
        b=f5KM4BZDlv3hHhlluaERuqf/fQA5WL2hracFdL/O8wVhuoyXbJSsb99LeTWUXFKEwe
         nzXoyEyjGZLvZUUxhK7OracNTCps6MomZBk5XWt88m8dG1WIQU5KwC1JvtKSqfOMTl3e
         MHXCxdBCYpz95J/xJcD0rDLbymrvZTHMtGjxR0K6uonXo3HcTe9u+yhZaP8SfQnABcxC
         FRFWRwJ3VjyR6u9ngh1Sj0m1oIexsu8bIGy/Hje1oWB8yszN09impmwnhOn32Z3XEVWl
         LJ52jDLAng3PY3sBcgNIXq+AdFzbI6of3D0JU8P7+o4as+LWzsmRV5nDXUUah+MLe77F
         DKCA==
X-Forwarded-Encrypted: i=1; AJvYcCX8VqgxOq3H35TQhOwv6HtKU5gPKTHES33JC6zK+5U+bfcrHUCm9z0dwk6Y8M8uWh84qbKXbyr9Uj6PrKTV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw39HppGCUQ1btjTuSMtVIzoa5bqukGbISegeMr0qhwo5WzF8Ex
	49PwX1/QYg1l4IHnk62GAazFBp3QFgtyjVWVhl2Sd4J5FeR2ImYSWVyVbF9fPSJrayg=
X-Gm-Gg: ASbGncsDUxLtUzxjd4IiQy3XTofunTg0+YZP8T+z5WC96HKpToOKSu+Wgxccnog/LDi
	k9Za/viKeNBM3IwcwMDHXS+BJzUFJ64qX4ulmVEIVPPScR08KoWJRQwgD3K7jzL1sIaz3T+mYjb
	Rf5dALg1fBsL3EE20yjChN6yIDlXuzy0sqjmERjBImNwVxqAvAyR/qhCSYB9ozhATPdueX5CAFF
	IOE4KWxaujfUzkqqaB0ZBij7Fr/579BiUsPhfApxF8ij94gVeMim4AkgEprU0ZeEqf1efM5IIg6
	N2icj0Amk+ha8ahz9pS/dszIIq6pNlYYxC870S/kkaeuUiiF
X-Google-Smtp-Source: AGHT+IHdf9kuEp+Oeqyrx300bcffpFTtYE92ed4KIlKyxTAk7PDHpZYQ2ettzlpPMwc5ugAW+HUS/g==
X-Received: by 2002:a05:6e02:198c:b0:3dc:787f:2bb5 with SMTP id e9e14a558f8ab-3dc9b71c656mr69408595ab.19.1748272014845;
        Mon, 26 May 2025 08:06:54 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc88f188c9sm29528045ab.3.2025.05.26.08.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 08:06:54 -0700 (PDT)
Message-ID: <6741c978-98b1-4d6f-af14-017b66d32574@kernel.dk>
Date: Mon, 26 May 2025 09:06:53 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
From: Jens Axboe <axboe@kernel.dk>
To: Vlastimil Babka <vbabka@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20250525083209.GS2023217@ZenIV> <20250525180632.GU2023217@ZenIV>
 <40eeba97-a298-4ae1-9691-b5911ad00095@suse.cz>
 <431cb497-b1ad-40a0-86b1-228b0b7490b9@kernel.dk>
Content-Language: en-US
In-Reply-To: <431cb497-b1ad-40a0-86b1-228b0b7490b9@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/25 7:05 AM, Jens Axboe wrote:
> On 5/25/25 1:12 PM, Vlastimil Babka wrote:
>> On 5/25/25 8:06 PM, Al Viro wrote:
>>> On Sun, May 25, 2025 at 09:32:09AM +0100, Al Viro wrote:
>>>
>>>> Breakage is still present in the current mainline ;-/
>>>
>>> With CONFIG_DEBUG_VM on top of pagealloc debugging:
>>>
>>> [ 1434.992817] run fstests generic/127 at 2025-05-25 11:46:11g
>>> [ 1448.956242] BUG: Bad page state in process kworker/2:1  pfn:112cb0g
>>> [ 1448.956846] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x3e pfn:0x112cb0g
>>> [ 1448.957453] flags: 0x800000000000000e(referenced|uptodate|writeback|zone=2)g
>>
>> It doesn't like the writeback flag.
>>
>>> [ 1448.957863] raw: 800000000000000e dead000000000100 dead000000000122 0000000000000000g
>>> [ 1448.958303] raw: 000000000000003e 0000000000000000 00000000ffffffff 0000000000000000g
>>> [ 1448.958833] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) setg
>>> [ 1448.959320] Modules linked in: xfs autofs4 fuse nfsd auth_rpcgss nfs_acl nfs lockd grace sunrpc loop ecryptfs 9pnet_virtio 9pnet netfs evdev pcspkr sg button ext4 jbd2 btrfs blake2b_generic xor zlib_deflate raid6_pq zstd_compress sr_mod cdrom ata_generic ata_piix psmouse serio_raw i2c_piix4 i2c_smbus libata e1000g
>>> [ 1448.960874] CPU: 2 UID: 0 PID: 2614 Comm: kworker/2:1 Not tainted 6.14.0-rc1+ #78g
>>> [ 1448.960878] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014g
>>> [ 1448.960879] Workqueue: xfs-conv/sdb1 xfs_end_io [xfs]g
>>> [ 1448.960938] Call Trace:g
>>> [ 1448.960939]  <TASK>g
>>> [ 1448.960940]  dump_stack_lvl+0x4f/0x60g
>>> [ 1448.960953]  bad_page+0x6f/0x100g
>>> [ 1448.960957]  free_frozen_pages+0x471/0x640g
>>> [ 1448.960958]  iomap_finish_ioend+0x196/0x3c0g
>>> [ 1448.960963]  iomap_finish_ioends+0x83/0xc0g
>>> [ 1448.960964]  xfs_end_ioend+0x64/0x140 [xfs]g
>>> [ 1448.961003]  xfs_end_io+0x93/0xc0 [xfs]g
>>> [ 1448.961036]  process_one_work+0x153/0x390g
>>> [ 1448.961044]  worker_thread+0x2ab/0x3b0g
>>> [ 1448.961045]  ? rescuer_thread+0x470/0x470g
>>> [ 1448.961047]  kthread+0xf7/0x200g
>>> [ 1448.961048]  ? kthread_use_mm+0xa0/0xa0g
>>> [ 1448.961049]  ret_from_fork+0x2d/0x50g
>>> [ 1448.961053]  ? kthread_use_mm+0xa0/0xa0g
>>> [ 1448.961054]  ret_from_fork_asm+0x11/0x20g
>>> [ 1448.961058]  </TASK>g
>>> [ 1448.961155] Disabling lock debugging due to kernel taintg
>>> [ 1448.969569] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x3e pfn:0x112cb0g
>>
>> same pfn, same struct page
>>
>>> [ 1448.970023] flags: 0x800000000000000e(referenced|uptodate|writeback|zone=2)g
>>> [ 1448.970651] raw: 800000000000000e dead000000000100 dead000000000122 0000000000000000g
>>> [ 1448.971222] raw: 000000000000003e 0000000000000000 00000000ffffffff 0000000000000000g
>>> [ 1448.971812] page dumped because: VM_BUG_ON_FOLIO(((unsigned int) folio_ref_count(folio) + 127u <= 127u))g
>>> [ 1448.972490] ------------[ cut here ]------------g
>>> [ 1448.972841] kernel BUG at ./include/linux/mm.h:1455!g
>>
>> this is folio_get() noticing refcount is 0, so a use-after free, because
>> we already tried to free the page above.
>>
>> I'm not familiar with this code too much, but I suspect problem was
>> introduced by commit fb7d3bc414939 ("mm/filemap: drop streaming/uncached
>> pages when writeback completes") and only (more) exposed here.
>>
>> so in folio_end_writeback() we have
>>         if (__folio_end_writeback(folio))
>>                 folio_wake_bit(folio, PG_writeback);
>>
>> but calling the folio_end_dropbehind_write() doesn't depend on the
>> result of __folio_end_writeback()
>> this seems rather suspicious
>>
>> I think if __folio_end_writeback() was true then PG_writeback would be
>> cleared and thus we'd not see the PAGE_FLAGS_CHECK_AT_FREE failure.
>> Instead we do a premature folio_end_dropbehind_write() dropping a page
>> ref and then the final folio_put() in folio_end_writeback() frees the
>> page and splats on the PG_writeback. Then the folio is processed again
>> in the following iteration of iomap_finish_ioend() and splats on the
>> refcount-already-zero.
>>
>> So I think folio_end_dropbehind_write() should only be done when
>> __folio_end_writeback() was true. Most likely even the
>> folio_test_clear_dropbehind() should be tied to that, or we clear it too
>> early and then never act upon it later?
> 
> Thanks for taking a look at this! I tried to reproduce this this morning
> and failed miserably. I then injected a delay for the above case, and it
> does indeed then trigger for me. So far, so good.
> 
> I agree with your analysis, we should only be doing the dropbehind for a
> non-zero return from __folio_end_writeback(), and that includes the
> test_and_clear to avoid dropping the drop-behind state. But we also need
> to check/clear this state pre __folio_end_writeback(), which then puts
> us in a spot where it needs to potentially be re-set. Which fails pretty
> racy...
> 
> I'll ponder this a bit. Good thing fsx got RWF_DONTCACHE support, or I
> suspect this would've taken a while to run into.

Took a closer look... I may be smoking something good here, but I don't
see what the __folio_end_writeback()() return value has to do with this
at all. Regardless of what it returns, it should've cleared
PG_writeback, and in fact the only thing it returns is whether or not we
had anyone waiting on it. Which should have _zero_ bearing on whether or
not we can clear/invalidate the range.

To me, this smells more like a race of some sort, between dirty and
invalidation. fsx does a lot of sub-page sized operations.

I'll poke a bit more...

-- 
Jens Axboe

