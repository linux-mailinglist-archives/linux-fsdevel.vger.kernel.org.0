Return-Path: <linux-fsdevel+bounces-41024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FA2A2A102
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 07:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D3157A2CB0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58177224AF6;
	Thu,  6 Feb 2025 06:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ly0fkoxb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AB014A62A
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Feb 2025 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738823680; cv=none; b=RoxUt9/BFqTjdw2HVssegaqmgP91d0iO3Iuf51OD2jDOubfunFhP1rXV2fkQPZEtnowR2ITamaKLvuhZrtzHLOmWozp4EiOVoiRGMhQTwysxvyHoH5Tv6lWU11+8ZXfq54EPRmxToPTitYgqn9M+fELZPOEk0Hu/jHQRr7NV3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738823680; c=relaxed/simple;
	bh=OCk5YxFlV1COdwy5+E2NflqTAchjzitfvD2w9iIIKzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxYWNGc9Do1JuVHbvWV9uBYOqTTaWnKMZfvFK0W0WoPoKvD5TJ/66vazk7IbWDDvBSBaw295rPv+lkm5UWH3tSkLJIrnHpjdtJyCqsuq/3QJGxqwHUwnkOgMwiXXL0XbBUhJ6Y0bUof/MtMnCYPoUZg52a8ITaskJoSWQqWP2pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ly0fkoxb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f169e9595so8775205ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2025 22:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738823678; x=1739428478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7ECNJBXu40RP2Clx2OxfF2Lbt/uQreXDitoikmAYNM=;
        b=Ly0fkoxbRMnZQSmi9GHcbmk1ahu5wWB73WIRB7GV7bz4yfcSuqjIhATab69GW37s5f
         bvaKsnfE7qQmvOb0SQsLFqGDE0pXfRnt+4cD1zMgUdKbCM1p4Moa4uquGWnNUxvTZYTp
         dEQulAO2MYT8gVw3i0Oi3gz8aS9i4zS2v5qf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738823678; x=1739428478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7ECNJBXu40RP2Clx2OxfF2Lbt/uQreXDitoikmAYNM=;
        b=lWjproBifJ/lWikTyF25sL5fY4TJf5DkcMv9zsTpbQPPmlje8fTcBViP5ghGYHv4Fp
         fIivpj205opLsw+lqzFDvzuGH6ckupUVXg0ctzcTSJY3nrpkG5zgd9rVeEdetkdgPZ+r
         LqJPR6Ac0X7sOD+nWHMG11vNwHEIP2LFcralpc35UTzZ2kL6rljAogRbnXnfs+Od4rTX
         5ztzk+FE9znd1TkiRq+aX05/3Hrb+WWGhA9bxebLLsfXkNvXUI88zVWg53uBXMd13Uz/
         RYsg5pOYHQxP95VhMrvRhC7bNEWa25CvjiFkF2P/lQZ7AQHTyy7fTKyDoVKBK74fvX9Y
         4duA==
X-Forwarded-Encrypted: i=1; AJvYcCVTDYQuDp5WM0IWRbHKgYEnnF4SUrnvZwWN2Ss0YWFy9FGYD7rOxIarPf1tI+BmBrMMgZqWLDXRzP0yxrJC@vger.kernel.org
X-Gm-Message-State: AOJu0YwRmRCBcA46yJ3OEl+2Sn4WoqWCR5870cqAUo0tFKC5zC68Awu3
	sDJOiX7OkID9DmOLdaTcLZaMxHNCVptgQYcwSXaMcxdtS2RKm+1TBKM/bKvaVA==
X-Gm-Gg: ASbGncsvweXurPnq4yN9C3eP3OLnlZf3xvLUTmA6bb3wfKPwmhGYBetaeoZcy7FqVha
	Ng7y86y9Ie//XV4G2XruUmJxzXHPWlOlHTOOc7TBjExll86fhwKyBztysZStPboR9utzjKIvF4E
	z7Xq0tWHbLS89VeriK3I7MFOGZ2NEwhG4aSNcdGabAZIhbfQOPtcvBPc3t25lTzkvVbWV++LFcV
	alIXkHe8HfOOm2UCKr8zd6Q45IgDwgzlIibPz3IxvFiyI35XeFVYYeZs4tDRbTF6u3gNz2GGfXo
	oxxvEQ2Ey0YcyCVKc+c=
X-Google-Smtp-Source: AGHT+IH2hs1CTPH8ai63DHl8Dw9B7d0EhYu7JD/3b18TSz8mXtvbx2qi1AzsEls4nrBxaiYiKzflpA==
X-Received: by 2002:a17:902:d583:b0:211:8404:a957 with SMTP id d9443c01a7336-21f17edda50mr105723575ad.41.1738823677923;
        Wed, 05 Feb 2025 22:34:37 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:28ab:cea4:aa8a:127a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c4c6sm4667755ad.176.2025.02.05.22.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 22:34:37 -0800 (PST)
Date: Thu, 6 Feb 2025 15:34:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Kairui Song <ryncsn@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Andi Shyti <andi.shyti@linux.intel.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Christian Brauner <brauner@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Dan Carpenter <dan.carpenter@linaro.org>, David Airlie <airlied@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Josef Bacik <josef@toxicpanda.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Rostedt <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 06/11] mm/vmscan: Use PG_dropbehind instead of
 PG_reclaim
Message-ID: <6vfuyhsy5mkyjscyffrjg3xbu3e5qx46ipqbwnrshnp3ernzw2@m2f3lycrg5z4>
References: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com>
 <20250130100050.1868208-7-kirill.shutemov@linux.intel.com>
 <CAMgjq7AWZg0Y7+v3_Z8-YVUXrANB29mCDSyzF39dtAM_TQ0aKw@mail.gmail.com>
 <42h65xowqe36eymr6pcomo7wzpe26kzwvyzg44hftqqczc5n6y@w2z5wvdrvktm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42h65xowqe36eymr6pcomo7wzpe26kzwvyzg44hftqqczc5n6y@w2z5wvdrvktm>

On (25/02/03 10:39), Kirill A. Shutemov wrote:
> > Hi, I'm seeing following panic with SWAP after this commit:
> >
> > [   29.672319] Oops: general protection fault, probably for
> > non-canonical address 0xffff88909a3be3: 0000 [#1] PREEMPT SMP NOPTI
> > [   29.675503] CPU: 82 UID: 0 PID: 5145 Comm: tar Kdump: loaded Not
> > tainted 6.13.0.ptch-g1fe9ea48ec98 #917
> > [   29.677508] Hardware name: Red Hat KVM/RHEL-AV, BIOS 0.0.0 02/06/2015
> > [   29.678886] RIP: 0010:__lock_acquire+0x20/0x15d0
>
> Ouch.
>
> I failed to trigger it my setup. Could you share your reproducer?

I'm seeing this as well (backtraces below).

My repro is:

- 4GB VM with 2 zram devices
  - one is setup as swap
  - the other one has ext4 fs on it
	- I dd large files to it


---

xa_lock_irq(&mapping->i_pages):

[   94.609589][  T157] Oops: general protection fault, probably for non-canonical address 0xe01ffbf11020301a: 0000 [#1] PREEMPT SMP KASAN PTI
[   94.611881][  T157] KASAN: maybe wild-memory-access in range [0x00ffff88810180d0-0x00ffff88810180d7]
[   94.613567][  T157] CPU: 1 UID: 0 PID: 157 Comm: kswapd0 Not tainted 6.13.0+ #927
[   94.614947][  T157] RIP: 0010:__lock_acquire+0x6a/0x1ef0
[   94.615942][  T157] Code: 08 84 d2 0f 85 ed 13 00 00 44 8b 05 24 30 d5 02 45 85 c0 0f 84 bc 07 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 eb 18 00 00 49 8b 04 24 48 3d a0 8b ac 84 0f 84
[   94.619668][  T157] RSP: 0018:ffff88810510eec0 EFLAGS: 00010002
[   94.620835][  T157] RAX: dffffc0000000000 RBX: 1ffff11020a21df5 RCX: 1ffffffff084c092
[   94.622329][  T157] RDX: 001ffff11020301a RSI: 0000000000000000 RDI: 00ffff88810180d1
[   94.623779][  T157] RBP: 00ffff88810180d1 R08: 0000000000000001 R09: 0000000000000000
[   94.625213][  T157] R10: ffffffff8425d0d7 R11: 0000000000000000 R12: 00ffff88810180d1
[   94.626656][  T157] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
[   94.628086][  T157] FS:  0000000000000000(0000) GS:ffff88815aa80000(0000) knlGS:0000000000000000
[   94.629700][  T157] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.630894][  T157] CR2: 00007f757719c2b0 CR3: 0000000003c82005 CR4: 0000000000770ef0
[   94.632333][  T157] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.633796][  T157] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.635265][  T157] PKRU: 55555554
[   94.635909][  T157] Call Trace:
[   94.636512][  T157]  <TASK>
[   94.637052][  T157]  ? show_trace_log_lvl+0x1a7/0x2e0
[   94.638005][  T157]  ? show_trace_log_lvl+0x1a7/0x2e0
[   94.638960][  T157]  ? lock_acquire.part.0+0xfa/0x310
[   94.639909][  T157]  ? __die_body.cold+0x8/0x12
[   94.640765][  T157]  ? die_addr+0x42/0x70
[   94.641530][  T157]  ? exc_general_protection+0x12e/0x210
[   94.642558][  T157]  ? asm_exc_general_protection+0x22/0x30
[   94.643610][  T157]  ? __lock_acquire+0x6a/0x1ef0
[   94.644506][  T157]  ? _raw_spin_unlock_irq+0x24/0x40
[   94.645468][  T157]  ? __wait_for_common+0x2f2/0x610
[   94.646412][  T157]  ? pci_mmcfg_reserved+0x120/0x120
[   94.647364][  T157]  ? submit_bio_noacct_nocheck+0x32e/0x3e0
[   94.648448][  T157]  ? lock_is_held_type+0x81/0xe0
[   94.649360][  T157]  lock_acquire.part.0+0xfa/0x310
[   94.650288][  T157]  ? folio_unmap_invalidate+0x286/0x550
[   94.651324][  T157]  ? __lock_acquire+0x1ef0/0x1ef0
[   94.652250][  T157]  ? submit_bio_wait+0x17c/0x200
[   94.653166][  T157]  ? submit_bio_wait_endio+0x40/0x40
[   94.654140][  T157]  ? lock_acquire+0x18a/0x1f0
[   94.655008][  T157]  _raw_spin_lock+0x2c/0x40
[   94.655853][  T157]  ? folio_unmap_invalidate+0x286/0x550
[   94.656879][  T157]  folio_unmap_invalidate+0x286/0x550
[   94.657866][  T157]  folio_end_writeback+0x146/0x190
[   94.658815][  T157]  swap_writepage_bdev_sync+0x312/0x410
[   94.659840][  T157]  ? swap_read_folio_bdev_sync+0x3c0/0x3c0
[   94.660917][  T157]  ? do_raw_spin_lock+0x12a/0x260
[   94.661845][  T157]  ? __rwlock_init+0x150/0x150
[   94.662726][  T157]  ? bio_kmalloc+0x20/0x20
[   94.663548][  T157]  ? swapcache_clear+0xd0/0xd0
[   94.664431][  T157]  swap_writepage+0x2a5/0x720
[   94.665298][  T157]  pageout+0x304/0x6a0
[   94.666052][  T157]  ? get_pte_pfn.isra.0+0x4d0/0x4d0
[   94.667025][  T157]  ? find_held_lock+0x2d/0x110
[   94.667912][  T157]  ? enable_swap_slots_cache+0x90/0x90
[   94.668925][  T157]  ? arch_tlbbatch_flush+0x1f6/0x370
[   94.669903][  T157]  shrink_folio_list+0x19b5/0x2600
[   94.670856][  T157]  ? pageout+0x6a0/0x6a0
[   94.671649][  T157]  ? isolate_folios+0x156/0x320
[   94.672544][  T157]  ? find_held_lock+0x2d/0x110
[   94.673428][  T157]  ? mark_lock+0xcc/0x12c0
[   94.674258][  T157]  ? mark_lock_irq+0x1cd0/0x1cd0
[   94.675174][  T157]  ? reacquire_held_locks+0x4d0/0x4d0
[   94.676166][  T157]  ? mark_held_locks+0x94/0xe0
[   94.677045][  T157]  evict_folios+0x4bb/0x1580
[   94.677890][  T157]  ? isolate_folios+0x320/0x320
[   94.678787][  T157]  ? __lock_acquire+0xc4c/0x1ef0
[   94.679695][  T157]  ? lock_is_held_type+0x81/0xe0
[   94.680607][  T157]  try_to_shrink_lruvec+0x41e/0x9e0
[   94.681564][  T157]  ? __lock_acquire+0xc4c/0x1ef0
[   94.682482][  T157]  ? evict_folios+0x1580/0x1580
[   94.683390][  T157]  ? lock_release+0x105/0x260
[   94.684255][  T157]  lru_gen_shrink_node+0x25d/0x660
[   94.685202][  T157]  ? balance_pgdat+0x5b5/0xf00
[   94.686083][  T157]  ? try_to_shrink_lruvec+0x9e0/0x9e0
[   94.687076][  T157]  ? pgdat_balanced+0xb8/0x110
[   94.687957][  T157]  balance_pgdat+0x532/0xf00
[   94.688803][  T157]  ? shrink_node.part.0+0xc30/0xc30
[   94.689758][  T157]  ? io_schedule_timeout+0x110/0x110
[   94.690741][  T157]  ? reacquire_held_locks+0x4d0/0x4d0
[   94.691723][  T157]  ? __lock_acquire+0x1ef0/0x1ef0
[   94.692643][  T157]  ? zone_watermark_ok_safe+0x32/0x290
[   94.693650][  T157]  ? inactive_is_low.isra.0+0xe0/0xe0
[   94.694639][  T157]  ? do_raw_spin_lock+0x12a/0x260
[   94.695567][  T157]  kswapd+0x2ef/0x4e0
[   94.696297][  T157]  ? balance_pgdat+0xf00/0xf00
[   94.697176][  T157]  ? __kthread_parkme+0xb1/0x1c0
[   94.698087][  T157]  ? balance_pgdat+0xf00/0xf00
[   94.698971][  T157]  kthread+0x38b/0x700
[   94.699721][  T157]  ? kthread_is_per_cpu+0xb0/0xb0
[   94.700648][  T157]  ? lock_acquire+0x18a/0x1f0
[   94.701516][  T157]  ? kthread_is_per_cpu+0xb0/0xb0
[   94.702438][  T157]  ret_from_fork+0x2d/0x70
[   94.703267][  T157]  ? kthread_is_per_cpu+0xb0/0xb0
[   94.704193][  T157]  ret_from_fork_asm+0x11/0x20
[   94.705074][  T157]  </TASK>


Also UAF in compactd

[   95.249096][  T146] ==================================================================
[   95.254091][  T146] BUG: KASAN: slab-use-after-free in kcompactd+0x9cd/0xa60
[   95.257959][  T146] Read of size 4 at addr ffff888105100018 by task kcompactd0/146
[   95.262100][  T146] 
[   95.263347][  T146] CPU: 11 UID: 0 PID: 146 Comm: kcompactd0 Tainted: G      D W          6.13.0+ #927
[   95.263363][  T146] Tainted: [D]=DIE, [W]=WARN
[   95.263367][  T146] Call Trace:
[   95.263379][  T146]  <TASK>
[   95.263386][  T146]  dump_stack_lvl+0x57/0x80
[   95.263403][  T146]  print_address_description.constprop.0+0x88/0x330
[   95.263416][  T146]  ? kcompactd+0x9cd/0xa60
[   95.263425][  T146]  print_report+0xe2/0x1cc
[   95.263433][  T146]  ? __virt_addr_valid+0x1d1/0x3b0
[   95.263442][  T146]  ? kcompactd+0x9cd/0xa60
[   95.263449][  T146]  ? kcompactd+0x9cd/0xa60
[   95.263456][  T146]  kasan_report+0xb9/0x180
[   95.263466][  T146]  ? kcompactd+0x9cd/0xa60
[   95.263476][  T146]  kcompactd+0x9cd/0xa60
[   95.263487][  T146]  ? kcompactd_do_work+0x710/0x710
[   95.263495][  T146]  ? prepare_to_swait_exclusive+0x260/0x260
[   95.263506][  T146]  ? __kthread_parkme+0xb1/0x1c0
[   95.263520][  T146]  ? kcompactd_do_work+0x710/0x710
[   95.263527][  T146]  kthread+0x38b/0x700
[   95.263535][  T146]  ? kthread_is_per_cpu+0xb0/0xb0
[   95.263542][  T146]  ? lock_acquire+0x18a/0x1f0
[   95.263552][  T146]  ? kthread_is_per_cpu+0xb0/0xb0
[   95.263559][  T146]  ret_from_fork+0x2d/0x70
[   95.263569][  T146]  ? kthread_is_per_cpu+0xb0/0xb0
[   95.263576][  T146]  ret_from_fork_asm+0x11/0x20
[   95.263589][  T146]  </TASK>
[   95.263592][  T146] 
[   95.293474][  T146] Allocated by task 2:
[   95.294209][  T146]  kasan_save_stack+0x1e/0x40
[   95.295111][  T146]  kasan_save_track+0x10/0x30
[   95.295978][  T146]  __kasan_slab_alloc+0x62/0x70
[   95.296860][  T146]  kmem_cache_alloc_node_noprof+0xdb/0x2a0
[   95.297915][  T146]  dup_task_struct+0x32/0x550
[   95.298797][  T146]  copy_process+0x309/0x45d0
[   95.299656][  T146]  kernel_clone+0xb7/0x600
[   95.300451][  T146]  kernel_thread+0xb0/0xe0
[   95.301253][  T146]  kthreadd+0x3b5/0x620
[   95.302019][  T146]  ret_from_fork+0x2d/0x70
[   95.302865][  T146]  ret_from_fork_asm+0x11/0x20
[   95.303724][  T146] 
[   95.304146][  T146] Freed by task 0:
[   95.304836][  T146]  kasan_save_stack+0x1e/0x40
[   95.305708][  T146]  kasan_save_track+0x10/0x30
[   95.306569][  T146]  kasan_save_free_info+0x37/0x50
[   95.307515][  T146]  __kasan_slab_free+0x33/0x40
[   95.308402][  T146]  kmem_cache_free+0xff/0x480
[   95.309256][  T146]  delayed_put_task_struct+0x15a/0x1d0
[   95.310258][  T146]  rcu_do_batch+0x2ee/0xb70
[   95.311113][  T146]  rcu_core+0x4a6/0xa10
[   95.311868][  T146]  handle_softirqs+0x191/0x650
[   95.312747][  T146]  __irq_exit_rcu+0xaf/0xe0
[   95.313643][  T146]  irq_exit_rcu+0xa/0x20
[   95.314536][  T146]  sysvec_apic_timer_interrupt+0x65/0x80
[   95.315616][  T146]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[   95.316702][  T146] 
[   95.317127][  T146] Last potentially related work creation:
[   95.318155][  T146]  kasan_save_stack+0x1e/0x40
[   95.319006][  T146]  kasan_record_aux_stack+0x97/0xa0
[   95.319947][  T146]  __call_rcu_common.constprop.0+0x70/0x7b0
[   95.321014][  T146]  __schedule+0x75d/0x1720
[   95.321817][  T146]  schedule_idle+0x55/0x80
[   95.322624][  T146]  cpu_startup_entry+0x50/0x60
[   95.323490][  T146]  start_secondary+0x1b6/0x210
[   95.324354][  T146]  common_startup_64+0x12c/0x138
[   95.325248][  T146] 
[   95.325669][  T146] The buggy address belongs to the object at ffff888105100000
[   95.325669][  T146]  which belongs to the cache task_struct of size 8200
[   95.328215][  T146] The buggy address is located 24 bytes inside of
[   95.328215][  T146]  freed 8200-byte region [ffff888105100000, ffff888105102008)
[   95.330692][  T146] 
[   95.331116][  T146] The buggy address belongs to the physical page:
[   95.332275][  T146] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x105100
[   95.333862][  T146] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   95.335399][  T146] flags: 0x8000000000000040(head|zone=2)
[   95.336425][  T146] page_type: f5(slab)
[   95.337155][  T146] raw: 8000000000000040 ffff888100a80c80 dead000000000122 0000000000000000
[   95.338716][  T146] raw: 0000000000000000 0000000000030003 00000000f5000000 0000000000000000
[   95.340273][  T146] head: 8000000000000040 ffff888100a80c80 dead000000000122 0000000000000000
[   95.341844][  T146] head: 0000000000000000 0000000000030003 00000000f5000000 0000000000000000
[   95.343418][  T146] head: 8000000000000003 ffffea0004144001 ffffffffffffffff 0000000000000000
[   95.344977][  T146] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
[   95.346540][  T146] page dumped because: kasan: bad access detected
[   95.347701][  T146] 
[   95.348123][  T146] Memory state around the buggy address:
[   95.349139][  T146]  ffff8881050fff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   95.350598][  T146]  ffff8881050fff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   95.352054][  T146] >ffff888105100000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   95.353510][  T146]                             ^
[   95.354389][  T146]  ffff888105100080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   95.355856][  T146]  ffff888105100100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   95.357315][  T146] ==================================================================

