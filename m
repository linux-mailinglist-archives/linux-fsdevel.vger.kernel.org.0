Return-Path: <linux-fsdevel+bounces-9684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C448446CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4F61F2584B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F67133998;
	Wed, 31 Jan 2024 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="x89e3BAi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69412FF92
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724579; cv=none; b=K7V2whzovHL8S6GZeitdAPn6qjDvhddx0bF9H06p9RfN8ypBEJN95RtWsIiHUK9nbmGWG+Nug3SejtIlM1uFs+eCxstnI++L7pnUrLqWvLlyPxoeg1xM2i+SPjL/zFdNm7Ykhq8hWymNgGbAkunYTgwAjfFetxUe71oL/AnXW4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724579; c=relaxed/simple;
	bh=/v49PEtEzR6/xfD8kMB7+uineb0q9ZAngdSIP3MFDps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hWQw4hE0HDjE7HO/zHCe0dsllsnooZmbiNqXSeB+PNMzEepQnQZgo661sVMzmHpncZuPTP+ukNfrfEF01yPtr0oxYr2PHxzKiXi+nB85VsGpe9qSDYIptVyzDedO8+UEL/pSb2r60dtkEXtd1wYMKy1I+YqbR/4ZSB28wAZgt68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=x89e3BAi; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8df34835aso14270a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 10:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706724577; x=1707329377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QY7zEzwqmYwA2nFVbc/42RPkw9WThtWGivH+2h1lMKE=;
        b=x89e3BAikNx3y2elGjXn8fQFxz3RqVQdkizYSr4HbZBFCP1SdnYg4JvW0s02rcMor5
         69UDvlXk20g4QG2OVzDl/DWA6YQIB/m4/lstHaKbZsXKmBzGy9/Ur20J9wyj72tdD+JV
         Uxhlz3gsquw8i603rZMJdwBGMWUuy+vBY0BZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706724577; x=1707329377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QY7zEzwqmYwA2nFVbc/42RPkw9WThtWGivH+2h1lMKE=;
        b=vPEbm8Ij5Et2fJJPdV/bxO+KHeT/vuo4HJYcEmtXuIGnkEMbzkln2sF0wz4lrQgtLC
         mKVmPnbiu8e5yRssCFLX/mWpbr3zG1X9otaxL3Wgq1ywydl2q+3S8t6Tr2KjSm6vCSOn
         FWoGd04pN7MnTZ2266nwJVcb9AB6/iPHLFpWeSNfKA+NWTgjmbQ5HFe1aDEkDNHNndaL
         i505FYyXhjwpvq6XOVphWPX0VIg8pdPlLyP/3/ZoosAmo16yIRTPjVbOgB9lK07kRUP2
         43ytek+8hqw6aYP7gXowOCghVn226NWE1Iiy/lkHY1e7F5VWRUsqwb+pwf1Xs5hMlc89
         9Z0w==
X-Gm-Message-State: AOJu0Yy5nOmjvalH/oIlDFDtWaMXwtSvbusQke9j8xH3zLepXLDQJuly
	qOCREhiWO8hh44jAEqXG4cOHe2w9wdB6gSe3V4QSbVq9s0xDDM3204vkfLQT/Zs=
X-Google-Smtp-Source: AGHT+IGEBmFm6dZaS/pLbem/dLErXnfbvpgrBS2z8P1XW/DjP9SPVtbq9hvT5DKmTzUqWh6Apo8P7Q==
X-Received: by 2002:a05:6a21:9202:b0:19c:9f98:f514 with SMTP id tl2-20020a056a21920200b0019c9f98f514mr3150967pzb.10.1706724576603;
        Wed, 31 Jan 2024 10:09:36 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id v24-20020a634818000000b005cfbf96c733sm10876004pga.30.2024.01.31.10.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 10:09:36 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-api@vger.kernel.org,
	brauner@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	weiwan@google.com,
	David.Laight@ACULAB.COM,
	arnd@arndb.de,
	Joe Damato <jdamato@fastly.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kara <jack@suse.cz>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Julien Panis <jpanis@baylibre.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Steve French <stfrench@microsoft.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH net-next v5 0/3] Per epoll context busy poll support
Date: Wed, 31 Jan 2024 18:08:02 +0000
Message-Id: <20240131180811.23566-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v5.

TL;DR This builds on commit bf3b9f6372c4 ("epoll: Add busy poll support to
epoll with socket fds.") by allowing user applications to enable
epoll-based busy polling and set a busy poll packet budget on a per epoll
context basis.

This makes epoll-based busy polling much more usable for user
applications than the current system-wide sysctl and hardcoded budget.

To allow for this, two ioctls have been added for epoll contexts for
getting and setting a new struct, struct epoll_params.

ioctl was chosen vs a new syscall after reviewing a suggestion by Willem
de Bruijn [1]. I am open to using a new syscall instead of an ioctl, but it
seemed that: 
  - Busy poll affects all existing epoll_wait and epoll_pwait variants in
    the same way, so new verions of many syscalls might be needed. It
    seems much simpler for users to use the correct
    epoll_wait/epoll_pwait for their app and add a call to ioctl to enable
    or disable busy poll as needed. This also probably means less work to
    get an existing epoll app using busy poll.

  - previously added epoll_pwait2 helped to bring epoll closer to
    existing syscalls (like pselect and ppoll) and this busy poll change
    reflected as a new syscall would not have the same effect.

Note: patch 1/4 as of v4 uses an or (||) instead of an xor. I thought about
it some more and I realized that if the user enables both the per-epoll
context setting and the system wide sysctl, then busy poll should be
enabled and not disabled. Using xor doesn't seem to make much sense after
thinking through this a bit.

Longer explanation:

Presently epoll has support for a very useful form of busy poll based on
the incoming NAPI ID (see also: SO_INCOMING_NAPI_ID [2]).

This form of busy poll allows epoll_wait to drive NAPI packet processing
which allows for a few interesting user application designs which can
reduce latency and also potentially improve L2/L3 cache hit rates by
deferring NAPI until userland has finished its work.

The documentation available on this is, IMHO, a bit confusing so please
allow me to explain how one might use this:

1. Ensure each application thread has its own epoll instance mapping
1-to-1 with NIC RX queues. An n-tuple filter would likely be used to
direct connections with specific dest ports to these queues.

2. Optionally: Setup IRQ coalescing for the NIC RX queues where busy
polling will occur. This can help avoid the userland app from being
pre-empted by a hard IRQ while userland is running. Note this means that
userland must take care to call epoll_wait and not take too long in
userland since it now drives NAPI via epoll_wait.

3. Optionally: Consider using napi_defer_hard_irqs and gro_flush_timeout to
further restrict IRQ generation from the NIC. These settings are
system-wide so their impact must be carefully weighed against the running
applications.

4. Ensure that all incoming connections added to an epoll instance
have the same NAPI ID. This can be done with a BPF filter when
SO_REUSEPORT is used or getsockopt + SO_INCOMING_NAPI_ID when a single
accept thread is used which dispatches incoming connections to threads.

5. Lastly, busy poll must be enabled via a sysctl
(/proc/sys/net/core/busy_poll).

Please see Eric Dumazet's paper about busy polling [3] and a recent
academic paper about measured performance improvements of busy polling [4]
(albeit with a modification that is not currently present in the kernel)
for additional context.

The unfortunate part about step 5 above is that this enables busy poll
system-wide which affects all user applications on the system,
including epoll-based network applications which were not intended to
be used this way or applications where increased CPU usage for lower
latency network processing is unnecessary or not desirable.

If the user wants to run one low latency epoll-based server application
with epoll-based busy poll, but would like to run the rest of the
applications on the system (which may also use epoll) without busy poll,
this system-wide sysctl presents a significant problem.

This change preserves the system-wide sysctl, but adds a mechanism (via
ioctl) to enable or disable busy poll for epoll contexts as needed by
individual applications, making epoll-based busy poll more usable.

Note that this change includes an or (as of v4) instead of an xor. If the
user has enabled both the system-wide sysctl and also the per epoll-context
busy poll settings, then epoll should probably busy poll (vs being
disabled). 

Thanks,
Joe

v4 -> v5:
  - patch 3/3 updated to use memchr_inv to ensure that __pad is zero for
    the EPIOCSPARAMS ioctl. Recommended by Greg K-H [5], Dave Chinner [6],
    and Jiri Slaby [7].

v3 -> v4:
  - patch 1/3 was updated to include an important functional change:
    ep_busy_loop_on was updated to use or (||) instead of xor (^). After
    thinking about it a bit more, I thought xor didn't make much sense.
    Enabling both the per-epoll context and the system-wide sysctl should
    probably enable busy poll, not disable it. So, or (||) makes more
    sense, I think.

  - patch 3/3 was updated:
    - to change the epoll_params fields to be __u64, __u16, and __u8 and
      to pad the struct to a multiple of 64bits. Suggested by Greg K-H [8]
      and Arnd Bergmann [9].
    - remove an unused pr_fmt, left over from the previous revision.
    - ioctl now returns -EINVAL when epoll_params.busy_poll_usecs >
      U32_MAX.

v2 -> v3:
  - cover letter updated to mention why ioctl seems (to me) like a better
    choice vs a new syscall.

  - patch 3/4 was modified in 3 ways:
    - when an unknown ioctl is received, -ENOIOCTLCMD is returned instead
      of -EINVAL as the ioctl documentation requires.
    - epoll_params.busy_poll_budget can only be set to a value larger than
      NAPI_POLL_WEIGHT if code is run by privileged (CAP_NET_ADMIN) users.
      Otherwise, -EPERM is returned.
    - busy poll specific ioctl code moved out to its own function. On
      kernels without busy poll support, -EOPNOTSUPP is returned. This also
      makes the kernel build robot happier without littering the code with
      more #ifdefs.

  - dropped patch 4/4 after Eric Dumazet's review of it when it was sent
    independently to the list [10].

v1 -> v2:
  - cover letter updated to make a mention of napi_defer_hard_irqs and
    gro_flush_timeout as an added step 3 and to cite both Eric Dumazet's
    busy polling paper and a paper from University of Waterloo for
    additional context. Specifically calling out the xor in patch 1/4
    incase it is missed by reviewers.

  - Patch 2/4 has its commit message updated, but no functional changes.
    Commit message now describes that allowing for a settable budget helps
    to improve throughput and is more consistent with other busy poll
    mechanisms that allow a settable budget via SO_BUSY_POLL_BUDGET.

  - Patch 3/4 was modified to check if the epoll_params.busy_poll_budget
    exceeds NAPI_POLL_WEIGHT. The larger value is allowed, but an error is
    printed. This was done for consistency with netif_napi_add_weight,
    which does the same.

  - Patch 3/4 the struct epoll_params was updated to fix the type of the
    data field; it was uint8_t and was changed to u8.

  - Patch 4/4 added to check if SO_BUSY_POLL_BUDGET exceeds
    NAPI_POLL_WEIGHT. The larger value is allowed, but an error is
    printed. This was done for consistency with netif_napi_add_weight,
    which does the same.

[1]: https://lore.kernel.org/lkml/65b1cb7f73a6a_250560294bd@willemb.c.googlers.com.notmuch/
[2]: https://lore.kernel.org/lkml/20170324170836.15226.87178.stgit@localhost.localdomain/
[3]: https://netdevconf.info/2.1/papers/BusyPollingNextGen.pdf
[4]: https://dl.acm.org/doi/pdf/10.1145/3626780
[5]: https://lore.kernel.org/lkml/2024013001-prison-strum-899d@gregkh/
[6]: https://lore.kernel.org/lkml/Zbm3AXgcwL9D6TNM@dread.disaster.area/
[7]: https://lore.kernel.org/lkml/efee9789-4f05-4202-9a95-21d88f6307b0@kernel.org/
[8]: https://lore.kernel.org/lkml/2024012551-anyone-demeaning-867b@gregkh/
[9]: https://lore.kernel.org/lkml/57b62135-2159-493d-a6bb-47d5be55154a@app.fastmail.com/
[10]: https://lore.kernel.org/lkml/CANn89i+uXsdSVFiQT9fDfGw+h_5QOcuHwPdWi9J=5U6oLXkQTA@mail.gmail.com/

Joe Damato (3):
  eventpoll: support busy poll per epoll instance
  eventpoll: Add per-epoll busy poll packet budget
  eventpoll: Add epoll ioctl for epoll_params

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 fs/eventpoll.c                                | 126 +++++++++++++++++-
 include/uapi/linux/eventpoll.h                |  12 ++
 3 files changed, 134 insertions(+), 5 deletions(-)

-- 
2.25.1


