Return-Path: <linux-fsdevel+bounces-71888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AA9CD77E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 01:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 171053001BFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CB71FDE31;
	Tue, 23 Dec 2025 00:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHtXhY/G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A341F4613
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 00:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766450187; cv=none; b=Fs2oCIiFWSCjFA7HV9QoCfzm+PhDXwRpT0cH/Qk2mX5ma45Jo5rYEeqUKHElME3FyrYOwp0AklqhSTtJS7eUzZ9WW5/8qwPp/oLcfPF4JlW5L2lvmFRM9DaIBxR4h6i6o284R8HbeiMTQ7YYvfjBKqY/9FoqfAlz0NYv7LL8ugk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766450187; c=relaxed/simple;
	bh=AqJnUW7ENCU9lhLx82NRORvUSa5ZTWncD0M24Q0Vayw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZKD9O06V0i44elU++ggVYfQBhEkuVVS8+0NJWoag73cP8iD9KDL8iARdrqoRvtmpbDRKzCsGUwx05CbpAHm0yIUbPSdsZ/5ncchS9JJUD4tJAbEM/lzOL2nsrg9Ev+nIuypi3zcam/VpLcYLTgq2Ri1/dbXejsXtwtBxW8MxKO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHtXhY/G; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so3527469b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 16:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766450185; x=1767054985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UNVVM3iNnsDDZ9LpCf1cMc9PuapDDbJq3uJy9qCzd9M=;
        b=ZHtXhY/GKpyOQjDAdquncmmKZkOFW1cTnYISdeer0mYyfonp5uWXq6d8pLkTJ+kA2F
         lpicKfiWycgl+bAKR6FfGMOdr8dsBas/fbbmFsgkHftGRH6tNpOqnTLITiBZYZ/8VUnE
         E4mOK9tVGIVRI6O46ytl/ZkjwAGtDBIELBpVD4ZSfgfO8pikkqB0pUhaMb+isx9YrYzY
         zoNZfa5XG2qIPPee8AIleh7pSd3Qn/eATdC+UGPUf9qFg5+gstj9wfzZ4LEzBtW7UrIR
         tvD7Jbpxsh9jnI3znHUyDDCPsj8uryg5BehE6YWo++8cdGxJSTOi2KnDkFV+Ra7ehvKx
         r3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766450185; x=1767054985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNVVM3iNnsDDZ9LpCf1cMc9PuapDDbJq3uJy9qCzd9M=;
        b=tsYUDJfnqGstSwtC+HUuKkRCwCJ958m7k71QjucN6EYr+RnYKTG1CaJiss4hTau90c
         gBHBZZe0DmDPnXKRiMSMP0AWDTYdiDVMhiilolT4ZQJBDHFmQiAT4Hmq7mlphfbqms1b
         7kE6rSDMMJF2J+DJ7nVF9zI8EOh+dXEAEG4gmbAD5DqgggoBcEaqFGEwuOdUS/LBegB4
         +qexYT+qyiSaoMtqXVIPgIOcyiZfx2ZiNXqV5MJ+7C+KFQxZnxzfVjlJQrjlun6n94Ey
         npMmuCPESXoCus8jnKLKSRxyXeTCC+Lv9uotkaYq2hvoHtS94VSq6MihaePAJaij2Y5X
         UAyg==
X-Forwarded-Encrypted: i=1; AJvYcCUtW38MREKCobGyfRX3eUdeRrsSSK3nTjeQFTFPBeJjiTbCWZGcIxcmS5AhebZYQaiaRHQEF+aseVBjoJI0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6hGHu1GnbJN9M+hCZ9a1SphdIQOXtwu6roJqy6kW8WR3z1bDo
	PMKSo0i3UsDXwyvAQYOEw9psOppp5DGojbA+UdzxqTkoeW6NMDl/+Vfi34iMgeZW
X-Gm-Gg: AY/fxX5JCDkNMAEIVaO6eAOYCTLkGJJnzvBgEVCyB7Akh2iGco+EC+GLlW1yvATk1yE
	n0zULFDhLS0b63oSAMcAyGrR/JNzR+h9pNwLY5EsAgwqtmO8KuaNppasjJpdSe5I2NqSMFWCoaz
	Nvm2cp1COY3F34HGx01y+JcroQB9Wrtt5lHfDBHN1y/YzUaKi+bH2tEEA39dnviuzBt2qSCTUWl
	tu5KHfDo5hqtB/rL5VpEp5/G1zERl4lAipTYrdC5Dei6NLxWDBaMWJGgtZo0GivvrLBVOd926De
	L1m39RkQ14dajSCRr5AugpXSS0bjqCgekE4AulIYdvH6Y0mnONp8e8nInDYAypyfepRnF+pSwcE
	rcQ85GDQcvzIF5rjPvsIGnAhLXYQdVxZO7r0lCBCNyJp848K74h3gvVLYkzpd88nPZkOleE9hjk
	Cc0cZEEnmKFSh5eh5JK7IdIEw/QMDW
X-Google-Smtp-Source: AGHT+IHpU+aB1cZ30EAPCwz8qZ4Os4mu4doygI+PUlJ4FMxAwHGXcz7c7pV+/kAqQrzBvVTFwyZfbg==
X-Received: by 2002:a05:6a00:a90d:b0:7e8:43f5:bd52 with SMTP id d2e1a72fcca58-7ff67756c3amr12198184b3a.62.1766450185316;
        Mon, 22 Dec 2025 16:36:25 -0800 (PST)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e797787sm11558159b3a.60.2025.12.22.16.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 16:36:24 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 00/25] fuse/io-uring: add kernel-managed buffer rings and zero-copy
Date: Mon, 22 Dec 2025 16:34:57 -0800
Message-ID: <20251223003522.3055912-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds buffer ring and zero-copy capabilities to fuse over io-uring.
This requires adding a new kernel-managed buf (kmbuf) ring type to io-uring
where the buffers are provided and managed by the kernel instead of by
userspace.

On the io-uring side, the kmbuf interface is basically identical to pbufs.
They differ mostly in how the memory region is set up and whether it is
userspace or kernel that recycles back the buffer. Internally, the
IOBL_KERNEL_MANAGED flag is used to mark the buffer ring as kernel-managed. 

The zero-copy work builds on top of the infrastructure added for
kernel-managed buffer rings (the bulk of which is in patch 19: "fuse: add
io-uring kernel-managed buffer ring") and that informs some of the design
choices for how fuse uses the kernel-managed buffer ring without zero-copy.

There was a previous submission for supporting registered buffers in fuse [1]
but that was abandoned in favor of using kernel-managed buffer rings, which,
once incremental buffer consumption is added in a later patchset, gives
significant memory usage advantages in allowing the full buffer capacity to be
utilized across multiple requests, as well as offers more flexibility for
future additions. As well, it also makes the userspace side setup simpler.
The relevant refactoring fuse patches from the previous submission are carried
over into this one.

Benchmarks for zero-copy (patch 24) show approximately the following
differences in throughput for bs=1M:

direct randreads: ~20% increase (~2100 MB/s -> ~2600 MB/s)
buffered randreads: ~25% increase (~1900 MB/s -> 2400 MB/s)
direct randwrites: no difference (~750 MB/s)
buffered randwrites: ~10% increase (950 MB/s -> 1050 MB/s)

The benchmark was run using fio on the passthrough_hp server:
fio --name=test_run --ioengine=sync --rw=rand{read,write} --bs=1M
--size=1G --numjobs=2 --ramp_time=30 --group_reporting=1

This series is on top of commit 40fbbd64bba6 in the io-uring tree.

The libfuse patch used for testing / verifying functionality is in [2]. This
has a dependency on the liburing changes in [3].

Thanks,
Joanne 

[1] https://lore.kernel.org/linux-fsdevel/20251027222808.2332692-1-joannelkoong@gmail.com/
[2] https://github.com/joannekoong/libfuse/commit/f15094b1881f9488b45026ae51f18d13ced4a554
[3] https://github.com/joannekoong/liburing/tree/kmbuf

v2: https://lore.kernel.org/linux-fsdevel/20251218083319.3485503-1-joannelkoong@gmail.com/
v2 -> v3:
* fix casting between void * and u64 for 32-bit architectures (kernel test robot)
* add newline for documentation bullet points (kernel test robot)
* fix unrecognized "boolean" (kernel test robot), switch it to a flag (me)

v1: https://lore.kernel.org/linux-fsdevel/20251203003526.2889477-1-joannelkoong@gmail.com/
v1 -> v2:
* drop fuse buffer cleanup on ring death, which makes things a lot simpler (Jens)
  - this drops a lot of things (eg needing ring_ctx tracking, needing callback
    for ring death, etc)
* drop fixed buffer pinning altogether and just do lookup every time (Jens)
  (didn't significantly affect the benchmark results seen)
* fix spelling mistake in docs (Askar)
* use -EALREADY for pinning already pinned bufring, return PTR_ERR for
   registration instead of err, move initializations to outside locks (Caleb)
* drop fuse patches for zero-ed out headers (me)

Joanne Koong (25):
  io_uring/kbuf: refactor io_buf_pbuf_register() logic into generic
    helpers
  io_uring/kbuf: rename io_unregister_pbuf_ring() to
    io_unregister_buf_ring()
  io_uring/kbuf: add support for kernel-managed buffer rings
  io_uring/kbuf: add mmap support for kernel-managed buffer rings
  io_uring/kbuf: support kernel-managed buffer rings in buffer selection
  io_uring/kbuf: add buffer ring pinning/unpinning
  io_uring/kbuf: add recycling for kernel managed buffer rings
  io_uring: add io_uring_cmd_fixed_index_get() and
    io_uring_cmd_fixed_index_put()
  io_uring/kbuf: add io_uring_cmd_is_kmbuf_ring()
  io_uring/kbuf: export io_ring_buffer_select()
  io_uring/kbuf: return buffer id in buffer selection
  io_uring/cmd: set selected buffer index in __io_uring_cmd_done()
  fuse: refactor io-uring logic for getting next fuse request
  fuse: refactor io-uring header copying to ring
  fuse: refactor io-uring header copying from ring
  fuse: use enum types for header copying
  fuse: refactor setting up copy state for payload copying
  fuse: support buffer copying for kernel addresses
  fuse: add io-uring kernel-managed buffer ring
  io_uring/rsrc: rename
    io_buffer_register_bvec()/io_buffer_unregister_bvec()
  io_uring/rsrc: split io_buffer_register_request() logic
  io_uring/rsrc: Allow buffer release callback to be optional
  io_uring/rsrc: add io_buffer_register_bvec()
  fuse: add zero-copy over io-uring
  docs: fuse: add io-uring bufring and zero-copy documentation

 Documentation/block/ublk.rst                  |  14 +-
 .../filesystems/fuse/fuse-io-uring.rst        |  59 +-
 drivers/block/ublk_drv.c                      |  18 +-
 fs/fuse/dev.c                                 |  30 +-
 fs/fuse/dev_uring.c                           | 711 ++++++++++++++----
 fs/fuse/dev_uring_i.h                         |  41 +-
 fs/fuse/fuse_dev_i.h                          |   8 +-
 include/linux/io_uring/buf.h                  |  25 +
 include/linux/io_uring/cmd.h                  |  99 ++-
 include/linux/io_uring_types.h                |  10 +-
 include/uapi/linux/fuse.h                     |  17 +-
 include/uapi/linux/io_uring.h                 |  17 +-
 io_uring/kbuf.c                               | 350 +++++++--
 io_uring/kbuf.h                               |  29 +-
 io_uring/memmap.c                             | 117 ++-
 io_uring/memmap.h                             |   4 +
 io_uring/register.c                           |   9 +-
 io_uring/rsrc.c                               | 190 ++++-
 io_uring/rsrc.h                               |   5 +
 io_uring/uring_cmd.c                          |  65 +-
 20 files changed, 1541 insertions(+), 277 deletions(-)
 create mode 100644 include/linux/io_uring/buf.h

-- 
2.47.3


