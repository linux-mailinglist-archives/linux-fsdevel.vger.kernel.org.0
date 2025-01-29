Return-Path: <linux-fsdevel+bounces-40303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722BBA22079
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 16:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7FE16486C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 15:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0551DE2B6;
	Wed, 29 Jan 2025 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="agsT9HAk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47421D90A5
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164817; cv=none; b=YX4ncgl3tXHKEHELGB0u/tXKO3p7m6skj3/ZwJNNIlO170eu5eDi6prHKDpv4KP8nXx3YCUE6DxnFrWkg8OaVJUwvA0vqi6YhWi2jNL0SVs1bmwlBjYKgisON76vKtJ3PfaMKa+R+3GhRfypm+AD5kRYGf6l18j2aynaIAS+cAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164817; c=relaxed/simple;
	bh=8BiKjvbno05SupIueqD9EmsRFfhnudabDEeI2RrgBGw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tmFrt5guWjyRSR9xTNhsK8H8gG04SzuoVV3GsywPPq8SD4F3eZiU8EJ6Aa6uA3IwXOfbQbGD4SUQFuA2MdqViDJV3zd9maxySVR4ZZrUAoAt5dsueRVmQ9Icc4j7wn0rPURvLmUDKk44ZH8JCumgHiTKAvUEmRfsST5ENxws2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=agsT9HAk; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4678afeb133so7385381cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 07:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1738164813; x=1738769613; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yIKG94g7FCq+SUOP4lYoS+T6cgI8wATeaYm8im0Vc8k=;
        b=agsT9HAkEOyIU0KWTO/FtC/UxTI690u4YspFKUb/p2zOCZPf6/3WXYqt++Qs+wAWxA
         2lVgiMFumHLwKEV+hRkJyVn1MG5C/AO6npBZgQSLISCf8tC7B1YJLJCcg7tjCkZ82jm4
         OTlFTGzJrSs1OTGmtuvqqQyhhCDDDFAB5ENtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738164813; x=1738769613;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yIKG94g7FCq+SUOP4lYoS+T6cgI8wATeaYm8im0Vc8k=;
        b=PCaVEyf/PAQlts4KYfuSJsndk8t0BnqnKgSAnyHE+c0PkCU7ygRVV0d/HDs+G9xZy3
         oCcS2vKSgkp8XikTwUf4aPL12Rjo1AjHmn4ti586UKSkwLiu5GsOTqy24UpesmQO5sdM
         Z+pwHpF2g+D7bpJ1b2TfMQrvK9G8IrbRdBx63fPD9vql1se2+WxheuaYbtrVuMHs1jUo
         y6A0P5OGjrQvKOdmlhQGsb/8b4TS1TGTsnM2mckl1x2gFdXHxdNKqgSwOcjl4gNrmoOH
         nWjrlpC/jcITWcy+D7pF55FG0Jou8eLKuwc9q/aOlbtNlzQrXqoJvuJQwAHglwCdqRlc
         rYRw==
X-Gm-Message-State: AOJu0YwP+6OF+0RqLedac+38Y0QW8Vr15Mtm5mSuds0uXk0+MPy+H4iD
	b2/x8lvoBX8pu4eTcN4EBVPgVWJBfx0fqQoxObYECfZMsU0M5kZJnO+WV1KEKfLbxPB3NsBgF+k
	1C2sxy/guFBh+bljPCuGBLIRXpDH/uE5YlUYJQQ==
X-Gm-Gg: ASbGncuV9iXcrcVNoDXkKhrw9gD7NWciFQiPZqHO6IEZj/H0mUWev2tCNg442BgdjG2
	HriYkbILndeL8OcHpWSTuk5rogjNZEMTzxbFkiYmIJEnUuWKSNd7aD3FoGRQjZa+Evi+vw3g=
X-Google-Smtp-Source: AGHT+IHB9G7DbwB9OrRuKm3hVYuw5Gvp7CHRScVBPRb7229T2Hy/vNcWr0ng7Z/5b4SzB8x0tuENvMPSAFYuKhjSWuk=
X-Received: by 2002:ac8:5fd1:0:b0:467:531f:10d6 with SMTP id
 d75a77b69052e-46fd07c81e5mr64927831cf.15.1738164813385; Wed, 29 Jan 2025
 07:33:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 29 Jan 2025 16:33:21 +0100
X-Gm-Features: AWEUYZn3FupY-UEwMXh2ZRqxPs_FAvESvFTzUlsOC8flQ3pzV3VmsGEhDvnQ22E
Message-ID: <CAJfpegvZoxFLWkFzHPw71FsVxoGMwg+P_iz9eeyU54+D4KG4ow@mail.gmail.com>
Subject: [GIT PULL] fuse update for 6.14
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-update-6.14

Add support for io-uring communication between kernel and userspace
using IORING_OP_URING_CMD (Bernd Schubert).  Following features enable
gains in performance compared to the regular interface:

- Allow processing multiple requests with less syscall overhead

- Combine commit of old and fetch of new fuse request

- CPU/NUMA affinity of queues

Patches were reviewed by several people, including Pavel Begunkov,
io-uring co-maintainer.

Thanks,
Miklos
---

Bernd Schubert (18):
      fuse: rename to fuse_dev_end_requests and make non-static
      fuse: Move fuse_get_dev to header file
      fuse: Move request bits
      fuse: Add fuse-io-uring design documentation
      fuse: make args->in_args[0] to be always the header
      fuse: {io-uring} Handle SQEs - register commands
      fuse: Make fuse_copy non static
      fuse: Add fuse-io-uring handling into fuse_copy
      fuse: {io-uring} Make hash-list req unique finding functions non-static
      fuse: Add io-uring sqe commit and fetch support
      fuse: {io-uring} Handle teardown of ring entries
      fuse: {io-uring} Make fuse_dev_queue_{interrupt,forget} non-static
      fuse: Allow to queue fg requests through io-uring
      fuse: Allow to queue bg requests through io-uring
      fuse: {io-uring} Prevent mount point hang on fuse-server termination
      fuse: block request allocation until io-uring init is complete
      fuse: enable fuse-over-io-uring
      fuse: prevent disabling io-uring on active connections

---
 Documentation/filesystems/fuse-io-uring.rst |   99 ++
 Documentation/filesystems/index.rst         |    1 +
 fs/fuse/Kconfig                             |   12 +
 fs/fuse/Makefile                            |    1 +
 fs/fuse/dax.c                               |   11 +-
 fs/fuse/dev.c                               |  127 +--
 fs/fuse/dev_uring.c                         | 1319 +++++++++++++++++++++++++++
 fs/fuse/dev_uring_i.h                       |  205 +++++
 fs/fuse/dir.c                               |   32 +-
 fs/fuse/fuse_dev_i.h                        |   66 ++
 fs/fuse/fuse_i.h                            |   32 +-
 fs/fuse/inode.c                             |   14 +-
 fs/fuse/xattr.c                             |    7 +-
 include/uapi/linux/fuse.h                   |   76 +-
 14 files changed, 1924 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/filesystems/fuse-io-uring.rst
 create mode 100644 fs/fuse/dev_uring.c
 create mode 100644 fs/fuse/dev_uring_i.h
 create mode 100644 fs/fuse/fuse_dev_i.h

