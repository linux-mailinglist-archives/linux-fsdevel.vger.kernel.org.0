Return-Path: <linux-fsdevel+bounces-35956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2AB9DA207
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 07:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41411284B2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 06:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAC61482F5;
	Wed, 27 Nov 2024 06:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPK7aqiI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BED6DF51;
	Wed, 27 Nov 2024 06:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732688051; cv=none; b=kHKET5TDLq0A87UIwcFIqjqyyELn1vRfASyoj4gzy+VjUR5Nhw3NF67Gh1Xk/3HNbv6REEePurxnmUBrIexZrCP9bXPWQg9tr91mcDi0APeR7brKZMsKN3nr+hH/bjrpq3rlwK37gDX5EcQZruBewJKW9GomSHZdNVSWxwysGgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732688051; c=relaxed/simple;
	bh=mIjObW/iBDG6II5VeKMX+1aOfpQnLoBEkcrTK3/L0dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1iLqsptCUywQTqDd9DxLLOOKYHgMat5cSICg/nMdRP3k04xcQPOOXSd7DFpADeZnOY4B+pKxPgReZfa5HfYVNUc7cNCzPQ9djcRGEDg+TZZNl6IpFyQSNXibHZJHrN2UNpivzGlckt1XJoJyjRVJpLx2oo5se/6srbPUdJOea8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPK7aqiI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cfddc94c83so7942712a12.3;
        Tue, 26 Nov 2024 22:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732688047; x=1733292847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDoZpetLkqMnLB7cRFHPmJPgDTTNJdqJP5Z9EqKdMUQ=;
        b=hPK7aqiIu5SmJlO3veQfgGIetHCY0ZE5klLCfjjEtwTvc6xmmheSO0KwNTg/1T9sJf
         JC601VlxE/dVCYYJOlUurYDIWC9ydfXAChmugsA+hAkaIpIYokYayoPvOMNNy67plaDQ
         mlechoqhogA8/MF1cmCoSBpKQdzMIoabT5Gr8nTy75tzgbz/z3A6X1482FR46WkNEbFD
         qVt+e6mQuTyZSh13GPrTl5R9anLcmsGlpaLJHMFLzZ8ikhVlFV3UIXsGf+jtQKvgQRoR
         3XvWm2DO54Uj7KYTQLjxQ72a8qQ/D09PD3WXcRPsQTW/nvJIElVjVou+tdYwX6ODcJLn
         iLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732688047; x=1733292847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDoZpetLkqMnLB7cRFHPmJPgDTTNJdqJP5Z9EqKdMUQ=;
        b=Bjq/9hogM6h587jweE/gTEDVPZUvocRmwiGGkEonRNO5wnsvPI/MkrK/CyokRMAuy3
         XbqtQqVgx3GqFt8dkzEFKPsj5e7px8PPFyX8Na1rCWxYHmrYiqKPbjmLV8O6+Quh1ILo
         LYqmj9rDDniR2L089lCZZjupTHh2NIajwdEI+7NMcA8g+7mWDG4AMIHyF/Ove3NlVky8
         oyLTSiA1mu9Zbd6ByYJqLObEIqc51tHrSbZMpVFEHrxr3xs9DHs0EymX0mElHRXTcKmO
         ETZGlDqf2YK1P1W2fYcT2byP1hUFlkbyQvfnR9f5T2NXK3Ujxsi2LAO/CXmCeF9eC7dj
         fwxg==
X-Forwarded-Encrypted: i=1; AJvYcCVi6A9Hy6t09cMVy6CENFPr1bzK8WcRK5AXBHzM4qUqpxP0y6W1guJw0kBFH1P8l3wLb7iqZ6+lf/tZsYzs@vger.kernel.org, AJvYcCWvtCs7EJ7kjsyr3eOvHfixovhYRr/RWYNy27jpEHQ8TGaXJU8ZUiF6FpJOJfT8Oxx6XvqbGAqujfQUYx0I@vger.kernel.org
X-Gm-Message-State: AOJu0YzTcAQxskwrAXXPCLHb+24qZNAoHIa/i/BSZ+/BkFgTSRHGHnwh
	0RHNr2qPqBySZtIF4nqH51j7EDhATvzt5kVL4R8PHSFzpglxcGAV1te/Dwy+0JbHhsMnXxCvXeY
	hZoA9PQJyqL7Axr5G9//TferYRTc=
X-Gm-Gg: ASbGncsGmWfrq8bgueDDgXjrneJ2+hLx0TTUxr7IblorHDN7/9ESn1/v42WNDBIW7il
	F7c6uUcDz5RI/THgui4l2+TY9/yY56Xw=
X-Google-Smtp-Source: AGHT+IF3EiiHk+74MSMyYikO5IFU3xODqntnXb6lef7wQiVbmziPJGBKrD/7bI3gL4wu/NsH0boT3Moj1gayuKFeqTo=
X-Received: by 2002:a17:906:c3a3:b0:a9a:3e33:8d9e with SMTP id
 a640c23a62f3a-aa580f5620bmr109674566b.28.1732688047110; Tue, 26 Nov 2024
 22:14:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127054737.33351-1-bharata@amd.com>
In-Reply-To: <20241127054737.33351-1-bharata@amd.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 27 Nov 2024 07:13:54 +0100
Message-ID: <CAGudoHGup2iLPUONz=ScsK1nQsBUHf_TrTrUcoStjvn3VoOr7Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Large folios in block buffered IO path
To: Bharata B Rao <bharata@amd.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nikunj@amd.com, 
	willy@infradead.org, vbabka@suse.cz, david@redhat.com, 
	akpm@linux-foundation.org, yuzhao@google.com, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, joshdon@google.com, 
	clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 6:48=E2=80=AFAM Bharata B Rao <bharata@amd.com> wro=
te:
>
> Recently we discussed the scalability issues while running large
> instances of FIO with buffered IO option on NVME block devices here:
>
> https://lore.kernel.org/linux-mm/d2841226-e27b-4d3d-a578-63587a3aa4f3@amd=
.com/
>
> One of the suggestions Chris Mason gave (during private discussions) was
> to enable large folios in block buffered IO path as that could
> improve the scalability problems and improve the lock contention
> scenarios.
>

I have no basis to comment on the idea.

However, it is pretty apparent whatever the situation it is being
heavily disfigured by lock contention in blkdev_llseek:

> perf-lock contention output
> ---------------------------
> The lock contention data doesn't look all that conclusive but for 30% rwm=
ixwrite
> mix it looks like this:
>
> perf-lock contention default
>  contended   total wait     max wait     avg wait         type   caller
>
> 1337359017     64.69 h     769.04 us    174.14 us     spinlock   rwsem_wa=
ke.isra.0+0x42
>                         0xffffffff903f60a3  native_queued_spin_lock_slowp=
ath+0x1f3
>                         0xffffffff903f537c  _raw_spin_lock_irqsave+0x5c
>                         0xffffffff8f39e7d2  rwsem_wake.isra.0+0x42
>                         0xffffffff8f39e88f  up_write+0x4f
>                         0xffffffff8f9d598e  blkdev_llseek+0x4e
>                         0xffffffff8f703322  ksys_lseek+0x72
>                         0xffffffff8f7033a8  __x64_sys_lseek+0x18
>                         0xffffffff8f20b983  x64_sys_call+0x1fb3
>    2665573     64.38 h       1.98 s      86.95 ms      rwsem:W   blkdev_l=
lseek+0x31
>                         0xffffffff903f15bc  rwsem_down_write_slowpath+0x3=
6c
>                         0xffffffff903f18fb  down_write+0x5b
>                         0xffffffff8f9d5971  blkdev_llseek+0x31
>                         0xffffffff8f703322  ksys_lseek+0x72
>                         0xffffffff8f7033a8  __x64_sys_lseek+0x18
>                         0xffffffff8f20b983  x64_sys_call+0x1fb3
>                         0xffffffff903dce5e  do_syscall_64+0x7e
>                         0xffffffff9040012b  entry_SYSCALL_64_after_hwfram=
e+0x76

Admittedly I'm not familiar with this code, but at a quick glance the
lock can be just straight up removed here?

  534 static loff_t blkdev_llseek(struct file *file, loff_t offset, int whe=
nce)
  535 {
  536 =E2=94=82       struct inode *bd_inode =3D bdev_file_inode(file);
  537 =E2=94=82       loff_t retval;
  538 =E2=94=82
  539 =E2=94=82       inode_lock(bd_inode);
  540 =E2=94=82       retval =3D fixed_size_llseek(file, offset, whence,
i_size_read(bd_inode));
  541 =E2=94=82       inode_unlock(bd_inode);
  542 =E2=94=82       return retval;
  543 }

At best it stabilizes the size for the duration of the call. Sounds
like it helps nothing since if the size can change, the file offset
will still be altered as if there was no locking?

Suppose this cannot be avoided to grab the size for whatever reason.

While the above fio invocation did not work for me, I ran some crapper
which I had in my shell history and according to strace:
[pid 271829] lseek(7, 0, SEEK_SET)      =3D 0
[pid 271829] lseek(7, 0, SEEK_SET)      =3D 0
[pid 271830] lseek(7, 0, SEEK_SET)      =3D 0

... the lseeks just rewind to the beginning, *definitely* not needing
to know the size. One would have to check but this is most likely the
case in your test as well.

And for that there is 0 need to grab the size, and consequently the inode l=
ock.

>  134057198     14.27 h      35.93 ms    383.14 us     spinlock   clear_sh=
adow_entries+0x57
>                         0xffffffff903f60a3  native_queued_spin_lock_slowp=
ath+0x1f3
>                         0xffffffff903f5c7f  _raw_spin_lock+0x3f
>                         0xffffffff8f5e7967  clear_shadow_entries+0x57
>                         0xffffffff8f5e90e3  mapping_try_invalidate+0x163
>                         0xffffffff8f5e9160  invalidate_mapping_pages+0x10
>                         0xffffffff8f9d3872  invalidate_bdev+0x42
>                         0xffffffff8f9fac3e  blkdev_common_ioctl+0x9ae
>                         0xffffffff8f9faea1  blkdev_ioctl+0xc1
>   33351524      1.76 h      35.86 ms    190.43 us     spinlock   __remove=
_mapping+0x5d
>                         0xffffffff903f60a3  native_queued_spin_lock_slowp=
ath+0x1f3
>                         0xffffffff903f5c7f  _raw_spin_lock+0x3f
>                         0xffffffff8f5ec71d  __remove_mapping+0x5d
>                         0xffffffff8f5f9be6  remove_mapping+0x16
>                         0xffffffff8f5e8f5b  mapping_evict_folio+0x7b
>                         0xffffffff8f5e9068  mapping_try_invalidate+0xe8
>                         0xffffffff8f5e9160  invalidate_mapping_pages+0x10
>                         0xffffffff8f9d3872  invalidate_bdev+0x42
>    9448820     14.96 m       1.54 ms     95.01 us     spinlock   folio_lr=
uvec_lock_irqsave+0x64
>                         0xffffffff903f60a3  native_queued_spin_lock_slowp=
ath+0x1f3
>                         0xffffffff903f537c  _raw_spin_lock_irqsave+0x5c
>                         0xffffffff8f6e3ed4  folio_lruvec_lock_irqsave+0x6=
4
>                         0xffffffff8f5e587c  folio_batch_move_lru+0x5c
>                         0xffffffff8f5e5a41  __folio_batch_add_and_move+0x=
d1
>                         0xffffffff8f5e7593  deactivate_file_folio+0x43
>                         0xffffffff8f5e90b7  mapping_try_invalidate+0x137
>                         0xffffffff8f5e9160  invalidate_mapping_pages+0x10
>    1488531     11.07 m       1.07 ms    446.39 us     spinlock   try_to_f=
ree_buffers+0x56
>                         0xffffffff903f60a3  native_queued_spin_lock_slowp=
ath+0x1f3
>                         0xffffffff903f5c7f  _raw_spin_lock+0x3f
>                         0xffffffff8f768c76  try_to_free_buffers+0x56
>                         0xffffffff8f5cf647  filemap_release_folio+0x87
>                         0xffffffff8f5e8f4c  mapping_evict_folio+0x6c
>                         0xffffffff8f5e9068  mapping_try_invalidate+0xe8
>                         0xffffffff8f5e9160  invalidate_mapping_pages+0x10
>                         0xffffffff8f9d3872  invalidate_bdev+0x42
>    2556868      6.78 m     474.72 us    159.07 us     spinlock   blkdev_l=
lseek+0x31
>                         0xffffffff903f60a3  native_queued_spin_lock_slowp=
ath+0x1f3
>                         0xffffffff903f5d01  _raw_spin_lock_irq+0x51
>                         0xffffffff903f14c4  rwsem_down_write_slowpath+0x2=
74
>                         0xffffffff903f18fb  down_write+0x5b
>                         0xffffffff8f9d5971  blkdev_llseek+0x31
>                         0xffffffff8f703322  ksys_lseek+0x72
>                         0xffffffff8f7033a8  __x64_sys_lseek+0x18
>                         0xffffffff8f20b983  x64_sys_call+0x1fb3
>    2512627      3.75 m     450.96 us     89.55 us     spinlock   blkdev_l=
lseek+0x31
>                         0xffffffff903f60a3  native_queued_spin_lock_slowp=
ath+0x1f3
>                         0xffffffff903f5d01  _raw_spin_lock_irq+0x51
>                         0xffffffff903f12f0  rwsem_down_write_slowpath+0xa=
0
>                         0xffffffff903f18fb  down_write+0x5b
>                         0xffffffff8f9d5971  blkdev_llseek+0x31
>                         0xffffffff8f703322  ksys_lseek+0x72
>                         0xffffffff8f7033a8  __x64_sys_lseek+0x18
>                         0xffffffff8f20b983  x64_sys_call+0x1fb3
>     908184      1.52 m     439.58 us    100.58 us     spinlock   blkdev_l=
lseek+0x31
>                         0xffffffff903f60a3  native_queued_spin_lock_slowp=
ath+0x1f3
>                         0xffffffff903f5d01  _raw_spin_lock_irq+0x51
>                         0xffffffff903f1367  rwsem_down_write_slowpath+0x1=
17
>                         0xffffffff903f18fb  down_write+0x5b
>                         0xffffffff8f9d5971  blkdev_llseek+0x31
>                         0xffffffff8f703322  ksys_lseek+0x72
>                         0xffffffff8f7033a8  __x64_sys_lseek+0x18
>                         0xffffffff8f20b983  x64_sys_call+0x1fb3
>        134      1.48 m       1.22 s     663.88 ms        mutex   bdev_rel=
ease+0x69
>                         0xffffffff903ef1de  __mutex_lock.constprop.0+0x17=
e
>                         0xffffffff903ef863  __mutex_lock_slowpath+0x13
>                         0xffffffff903ef8bb  mutex_lock+0x3b
>                         0xffffffff8f9d5249  bdev_release+0x69
>                         0xffffffff8f9d5921  blkdev_release+0x11
>                         0xffffffff8f7089f3  __fput+0xe3
>                         0xffffffff8f708c9b  __fput_sync+0x1b
>                         0xffffffff8f6fe8ed  __x64_sys_close+0x3d
>
>
> perf-lock contention patched
>  contended   total wait     max wait     avg wait         type   caller
>
>    1153627     40.15 h      48.67 s     125.30 ms      rwsem:W   blkdev_l=
lseek+0x31
>                         0xffffffff903f15bc  rwsem_down_write_slowpath+0x3=
6c
>                         0xffffffff903f18fb  down_write+0x5b
>                         0xffffffff8f9d5971  blkdev_llseek+0x31
>                         0xffffffff8f703322  ksys_lseek+0x72
>                         0xffffffff8f7033a8  __x64_sys_lseek+0x18
>                         0xffffffff8f20b983  x64_sys_call+0x1fb3
>                         0xffffffff903dce5e  do_syscall_64+0x7e
>                         0xffffffff9040012b  entry_SYSCALL_64_after_hwfram=
e+0x76
>  276512439     39.19 h      46.90 ms    510.22 us     spinlock   clear_sh=
adow_entries+0x57
>                         0xffffffff903f60a3  native_queued_spin_lock_slowp=
ath+0x1f3
>                         0xffffffff903f5c7f  _raw_spin_lock+0x3f
>                         0xffffffff8f5e7967  clear_shadow_entries+0x57
>                         0xffffffff8f5e90e3  mapping_try_invalidate+0x163
>                         0xffffffff8f5e9160  invalidate_mapping_pages+0x10
>                         0xffffffff8f9d3872  invalidate_bdev+0x42
>                         0xffffffff8f9fac3e  blkdev_common_ioctl+0x9ae
>                         0xffffffff8f9faea1  blkdev_ioctl+0xc1
>  763119320     26.37 h     887.44 us    124.38 us     spinlock   rwsem_wa=
ke.isra.0+0x42
>                         0xffffffff903f60a3  native_queued_spin_lock_slowp=
ath+0x1f3
>                         0xffffffff903f537c  _raw_spin_lock_irqsave+0x5c
>                         0xffffffff8f39e7d2  rwsem_wake.isra.0+0x42
>                         0xffffffff8f39e88f  up_write+0x4f
>                         0xffffffff8f9d598e  blkdev_llseek+0x4e
>                         0xffffffff8f703322  ksys_lseek+0x72
>                         0xffffffff8f7033a8  __x64_sys_lseek+0x18
>                         0xffffffff8f20b983  x64_sys_call+0x1fb3
>   33263910      2.87 h      29.43 ms    310.56 us     spinlock   __remove=
_mapping+0x5d
>                         0xffffffff903f60a3  native_queued_spin_lock_slowp=
ath+0x1f3
>                         0xffffffff903f5c7f  _raw_spin_lock+0x3f
>                         0xffffffff8f5ec71d  __remove_mapping+0x5d
>                         0xffffffff8f5f9be6  remove_mapping+0x16
>                         0xffffffff8f5e8f5b  mapping_evict_folio+0x7b
>                         0xffffffff8f5e9068  mapping_try_invalidate+0xe8
>                         0xffffffff8f5e9160  invalidate_mapping_pages+0x10
>                         0xffffffff8f9d3872  invalidate_bdev+0x42
>   58671816      2.50 h     519.68 us    153.45 us     spinlock   folio_lr=
uvec_lock_irqsave+0x64
>                         0xffffffff903f60a3  native_queued_spin_lock_slowp=
ath+0x1f3
>                         0xffffffff903f537c  _raw_spin_lock_irqsave+0x5c
>                         0xffffffff8f6e3ed4  folio_lruvec_lock_irqsave+0x6=
4
>                         0xffffffff8f5e587c  folio_batch_move_lru+0x5c
>                         0xffffffff8f5e5a41  __folio_batch_add_and_move+0x=
d1
>                         0xffffffff8f5e7593  deactivate_file_folio+0x43
>                         0xffffffff8f5e90b7  mapping_try_invalidate+0x137
>                         0xffffffff8f5e9160  invalidate_mapping_pages+0x10
>        284     22.33 m       5.35 s       4.72 s         mutex   bdev_rel=
ease+0x69
>                         0xffffffff903ef1de  __mutex_lock.constprop.0+0x17=
e
>                         0xffffffff903ef863  __mutex_lock_slowpath+0x13
>                         0xffffffff903ef8bb  mutex_lock+0x3b
>                         0xffffffff8f9d5249  bdev_release+0x69
>                         0xffffffff8f9d5921  blkdev_release+0x11
>                         0xffffffff8f7089f3  __fput+0xe3
>                         0xffffffff8f708c9b  __fput_sync+0x1b
>                         0xffffffff8f6fe8ed  __x64_sys_close+0x3d
>    2181469     21.38 m       1.15 ms    587.98 us     spinlock   try_to_f=
ree_buffers+0x56
>                         0xffffffff903f60a3  native_queued_spin_lock_slowp=
ath+0x1f3
>                         0xffffffff903f5c7f  _raw_spin_lock+0x3f
>                         0xffffffff8f768c76  try_to_free_buffers+0x56
>                         0xffffffff8f5cf647  filemap_release_folio+0x87
>                         0xffffffff8f5e8f4c  mapping_evict_folio+0x6c
>                         0xffffffff8f5e9068  mapping_try_invalidate+0xe8
>                         0xffffffff8f5e9160  invalidate_mapping_pages+0x10
>                         0xffffffff8f9d3872  invalidate_bdev+0x42
>     454398      4.22 m      37.54 ms    557.13 us     spinlock   __remove=
_mapping+0x5d
>                         0xffffffff903f60a3  native_queued_spin_lock_slowp=
ath+0x1f3
>                         0xffffffff903f5c7f  _raw_spin_lock+0x3f
>                         0xffffffff8f5ec71d  __remove_mapping+0x5d
>                         0xffffffff8f5f4f04  shrink_folio_list+0xbc4
>                         0xffffffff8f5f5a6b  evict_folios+0x34b
>                         0xffffffff8f5f772f  try_to_shrink_lruvec+0x20f
>                         0xffffffff8f5f79ef  shrink_one+0x10f
>                         0xffffffff8f5fb975  shrink_node+0xb45
>        773      3.53 m       2.60 s     273.76 ms        mutex   __lru_ad=
d_drain_all+0x3a
>                         0xffffffff903ef1de  __mutex_lock.constprop.0+0x17=
e
>                         0xffffffff903ef863  __mutex_lock_slowpath+0x13
>                         0xffffffff903ef8bb  mutex_lock+0x3b
>                         0xffffffff8f5e3d7a  __lru_add_drain_all+0x3a
>                         0xffffffff8f5e77a0  lru_add_drain_all+0x10
>                         0xffffffff8f9d3861  invalidate_bdev+0x31
>                         0xffffffff8f9fac3e  blkdev_common_ioctl+0x9ae
>                         0xffffffff8f9faea1  blkdev_ioctl+0xc1
>    1997851      3.09 m     651.65 us     92.83 us     spinlock   folio_lr=
uvec_lock_irqsave+0x64
>                         0xffffffff903f60a3  native_queued_spin_lock_slowp=
ath+0x1f3
>                         0xffffffff903f537c  _raw_spin_lock_irqsave+0x5c
>                         0xffffffff8f6e3ed4  folio_lruvec_lock_irqsave+0x6=
4
>                         0xffffffff8f5e587c  folio_batch_move_lru+0x5c
>                         0xffffffff8f5e5a41  __folio_batch_add_and_move+0x=
d1
>                         0xffffffff8f5e5ae4  folio_add_lru+0x54
>                         0xffffffff8f5d075d  filemap_add_folio+0xcd
>                         0xffffffff8f5e30c0  page_cache_ra_order+0x220
>
> Observations from perf-lock contention
> --------------------------------------
> - Significant reduction of contention for inode_lock (inode->i_rwsem)
>   from blkdev_llseek() path.
> - Significant increase in contention for inode->i_lock from invalidate
>   and remove_mapping paths.
> - Significant increase in contention for lruvec spinlock from
>   deactive_file_folio path.
>
> Request comments on the above and I am specifically looking for inputs
> on these:
>
> - Lock contention results and usefulness of large folios in bringing
>   down the contention in this specific case.
> - If enabling large folios in block buffered IO path is a feasible
>   approach, inputs on doing this cleanly and correclty.
>
> Bharata B Rao (1):
>   block/ioctl: Add an ioctl to enable large folios for block buffered IO
>     path
>
>  block/ioctl.c           | 8 ++++++++
>  include/uapi/linux/fs.h | 2 ++
>  2 files changed, 10 insertions(+)
>
> --
> 2.34.1
>


--=20
Mateusz Guzik <mjguzik gmail.com>

