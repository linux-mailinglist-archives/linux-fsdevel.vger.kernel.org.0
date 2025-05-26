Return-Path: <linux-fsdevel+bounces-49843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9FAAC4005
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 15:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408A71898257
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 13:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67CF202987;
	Mon, 26 May 2025 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2sNBUvzH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D93D994
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748264732; cv=none; b=ixEQlpcFQ0OJIxfO1mXc09pKkkEyj1k8MZ0iIoBRlPZEu/LObnxml3HZtiFh+H2Azo4MlA7t82xt8d6CcM0zoGlLo31spKRQSRbxwOUYYGZRUJeEOZa/nZgyKrjiIGWH7qkmdSAgvb+Zffki9FWaVuOnPOEBcNMMmFOpovW9SKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748264732; c=relaxed/simple;
	bh=WRLLyPG7MzldbSRPAUAN/GvuK1SYShz7eNNwcu/ZPS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYg4nlfUitpd+x7+mAEQxxY7mG1Yx6ZFKXXHDjJK0MPXv8iIDOudRshzVimxUGcSD3B8RrO/YrLo/88od52zH1QplraV0MQmA9hPiu/YzZc9VmBOTZX/mg7GuaOB4L+wDWiS1qPGCAPw/DK6Ok2EfKzuN7jTRMte6bGd1sz+Z3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2sNBUvzH; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3dd7a95d19eso5460795ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 06:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748264729; x=1748869529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PckAgJRqpIcIH4yJpxxrhEiCPsRLuROIFTuYYDqeZI=;
        b=2sNBUvzHzousFttUhrKTRdFtiPfd7MSQcaQ5abSGsSgDzHzxyHUlQdtth0bpMf+/Fu
         eUmcKSR9cw1Cg6KztxHzuEGRwwZZvHn0vfiMHCX7GFq1V+tftQNBd0/KwQ/W/cRZw42Y
         SeiG7IAJ9UuQDI3lCs4Tc+7iU30UOrynT1iDgsUHjArJmtS36QSUxYf9UznUqpvdoTRv
         OTsms5JF85B54p/zHiYsbq+dFiCiZL5RP9zdi7zjanKph8PZHnLKXK4m0EY2rBL9FArJ
         mkdEx9Z0UF21U/ewmbAUsvxsM4Cv2Tl7niS6EKtvy+99aSy0SfaRtnbA75wT9bQ5fd0J
         7Yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748264729; x=1748869529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PckAgJRqpIcIH4yJpxxrhEiCPsRLuROIFTuYYDqeZI=;
        b=rodoeK0EBMAXkgRz/pUU+8HqIdVOuwgiF/MB/d9PFIl7yNEv5r0jusU50jupmRAchK
         4+QMHymVWVBVszPZehoR2yiWutmfzaRiGdSX9P4N5bLSpzPeIlhhaVrR9PLM6/k18jDk
         03dU6hy6RsvW8H7LDyUQkLpPPHyBMiKAPcoo7mTH+eLtpTBhg7ogekAc1fnz4VbW14+k
         d4Jc00PRd2PPMzUzl0BY3VwphRBvPa2G+SrxOtX9kL6vCfaerGV55ivFLCvvoN/zV7x1
         hM3CEfIA1pnwjX2iLom9oI21KGOL82uOwuNN0k2PH9wRExDAAqxerqXbF9me4RS5U/mk
         Bqsg==
X-Forwarded-Encrypted: i=1; AJvYcCUEX3kBUi1DgoJuyZC8PMev9ML1dHpo20F2Qb8QG6wEtSqnjtObPGe2yCEIVNR3PU4EoN3F0R366NzdHWsy@vger.kernel.org
X-Gm-Message-State: AOJu0YxZwOt8ad26/J2ArWia1n/Vudi+inD3cCdUvHH+n02TV88lpVKU
	KWF1is8TrqTLbzxogSU0SJzdMbUV3NhV3KG32MBogT9LgMC6O9q49jLJ8qG/xZtJaApsIHIp9PW
	V8ymf
X-Gm-Gg: ASbGncuCC8NbWuxj9tgeDrQ+tQ+olzHxNMX2iviDj/cOTMlJ3GHJe7lZDevmyq5C9uQ
	QaGtvGMMgA+2Ii9DRXxLLY7NoRr9UoghfmHf6glkc1pW1Je1X2xdlcfQfCRb+2RLwunylZ/KkV5
	OpiocC4M4ayYJUp2OwpOTdB8dxwNEX3jEvNwzAl8STF3PVX5Yt5fbtJAP68s7z7MBCGCfa4l779
	W4M9lMqzjBsBcUms/X1IwfF4tV2HZHvWUKDkfqGP0f4sKQsa/F8URQgmcY6efbk+HG1G2TMyhyA
	PAkIBpFWWnBTNWoIatrN1H0lTVXDcQAz6O9dj/A+dFz7gBDV
X-Google-Smtp-Source: AGHT+IHlp5bn+Rb+2jmjdSwIP0fZowm8iMHkGWxS+hWrFXEh/LUXkuzcec5mF3y9Q6VtfjljH2/lyQ==
X-Received: by 2002:a05:6602:4c8e:b0:867:667d:18dd with SMTP id ca18e2360f4ac-86cbb7befa4mr802736839f.1.1748264717888;
        Mon, 26 May 2025 06:05:17 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc4eaa3csm4654545173.143.2025.05.26.06.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 06:05:17 -0700 (PDT)
Message-ID: <431cb497-b1ad-40a0-86b1-228b0b7490b9@kernel.dk>
Date: Mon, 26 May 2025 07:05:16 -0600
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
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <40eeba97-a298-4ae1-9691-b5911ad00095@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/25/25 1:12 PM, Vlastimil Babka wrote:
> On 5/25/25 8:06 PM, Al Viro wrote:
>> On Sun, May 25, 2025 at 09:32:09AM +0100, Al Viro wrote:
>>
>>> Breakage is still present in the current mainline ;-/
>>
>> With CONFIG_DEBUG_VM on top of pagealloc debugging:
>>
>> [ 1434.992817] run fstests generic/127 at 2025-05-25 11:46:11g
>> [ 1448.956242] BUG: Bad page state in process kworker/2:1  pfn:112cb0g
>> [ 1448.956846] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x3e pfn:0x112cb0g
>> [ 1448.957453] flags: 0x800000000000000e(referenced|uptodate|writeback|zone=2)g
> 
> It doesn't like the writeback flag.
> 
>> [ 1448.957863] raw: 800000000000000e dead000000000100 dead000000000122 0000000000000000g
>> [ 1448.958303] raw: 000000000000003e 0000000000000000 00000000ffffffff 0000000000000000g
>> [ 1448.958833] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) setg
>> [ 1448.959320] Modules linked in: xfs autofs4 fuse nfsd auth_rpcgss nfs_acl nfs lockd grace sunrpc loop ecryptfs 9pnet_virtio 9pnet netfs evdev pcspkr sg button ext4 jbd2 btrfs blake2b_generic xor zlib_deflate raid6_pq zstd_compress sr_mod cdrom ata_generic ata_piix psmouse serio_raw i2c_piix4 i2c_smbus libata e1000g
>> [ 1448.960874] CPU: 2 UID: 0 PID: 2614 Comm: kworker/2:1 Not tainted 6.14.0-rc1+ #78g
>> [ 1448.960878] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014g
>> [ 1448.960879] Workqueue: xfs-conv/sdb1 xfs_end_io [xfs]g
>> [ 1448.960938] Call Trace:g
>> [ 1448.960939]  <TASK>g
>> [ 1448.960940]  dump_stack_lvl+0x4f/0x60g
>> [ 1448.960953]  bad_page+0x6f/0x100g
>> [ 1448.960957]  free_frozen_pages+0x471/0x640g
>> [ 1448.960958]  iomap_finish_ioend+0x196/0x3c0g
>> [ 1448.960963]  iomap_finish_ioends+0x83/0xc0g
>> [ 1448.960964]  xfs_end_ioend+0x64/0x140 [xfs]g
>> [ 1448.961003]  xfs_end_io+0x93/0xc0 [xfs]g
>> [ 1448.961036]  process_one_work+0x153/0x390g
>> [ 1448.961044]  worker_thread+0x2ab/0x3b0g
>> [ 1448.961045]  ? rescuer_thread+0x470/0x470g
>> [ 1448.961047]  kthread+0xf7/0x200g
>> [ 1448.961048]  ? kthread_use_mm+0xa0/0xa0g
>> [ 1448.961049]  ret_from_fork+0x2d/0x50g
>> [ 1448.961053]  ? kthread_use_mm+0xa0/0xa0g
>> [ 1448.961054]  ret_from_fork_asm+0x11/0x20g
>> [ 1448.961058]  </TASK>g
>> [ 1448.961155] Disabling lock debugging due to kernel taintg
>> [ 1448.969569] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x3e pfn:0x112cb0g
> 
> same pfn, same struct page
> 
>> [ 1448.970023] flags: 0x800000000000000e(referenced|uptodate|writeback|zone=2)g
>> [ 1448.970651] raw: 800000000000000e dead000000000100 dead000000000122 0000000000000000g
>> [ 1448.971222] raw: 000000000000003e 0000000000000000 00000000ffffffff 0000000000000000g
>> [ 1448.971812] page dumped because: VM_BUG_ON_FOLIO(((unsigned int) folio_ref_count(folio) + 127u <= 127u))g
>> [ 1448.972490] ------------[ cut here ]------------g
>> [ 1448.972841] kernel BUG at ./include/linux/mm.h:1455!g
> 
> this is folio_get() noticing refcount is 0, so a use-after free, because
> we already tried to free the page above.
> 
> I'm not familiar with this code too much, but I suspect problem was
> introduced by commit fb7d3bc414939 ("mm/filemap: drop streaming/uncached
> pages when writeback completes") and only (more) exposed here.
> 
> so in folio_end_writeback() we have
>         if (__folio_end_writeback(folio))
>                 folio_wake_bit(folio, PG_writeback);
> 
> but calling the folio_end_dropbehind_write() doesn't depend on the
> result of __folio_end_writeback()
> this seems rather suspicious
> 
> I think if __folio_end_writeback() was true then PG_writeback would be
> cleared and thus we'd not see the PAGE_FLAGS_CHECK_AT_FREE failure.
> Instead we do a premature folio_end_dropbehind_write() dropping a page
> ref and then the final folio_put() in folio_end_writeback() frees the
> page and splats on the PG_writeback. Then the folio is processed again
> in the following iteration of iomap_finish_ioend() and splats on the
> refcount-already-zero.
> 
> So I think folio_end_dropbehind_write() should only be done when
> __folio_end_writeback() was true. Most likely even the
> folio_test_clear_dropbehind() should be tied to that, or we clear it too
> early and then never act upon it later?

Thanks for taking a look at this! I tried to reproduce this this morning
and failed miserably. I then injected a delay for the above case, and it
does indeed then trigger for me. So far, so good.

I agree with your analysis, we should only be doing the dropbehind for a
non-zero return from __folio_end_writeback(), and that includes the
test_and_clear to avoid dropping the drop-behind state. But we also need
to check/clear this state pre __folio_end_writeback(), which then puts
us in a spot where it needs to potentially be re-set. Which fails pretty
racy...

I'll ponder this a bit. Good thing fsx got RWF_DONTCACHE support, or I
suspect this would've taken a while to run into.

-- 
Jens Axboe

