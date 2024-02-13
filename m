Return-Path: <linux-fsdevel+bounces-11297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0DA8528B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 07:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057F328484D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 06:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335CF14A94;
	Tue, 13 Feb 2024 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DPttYn73"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FBF134AB
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805022; cv=none; b=KHRkh0EZCDb8Hd/iz16IP5jRQooYwwB1q5YJVYks7tTTrDRGULMbTQ61RXDTAYxzX+ca91GUyuZwJ2DLqo4kiunJ7w7QY1w8oRJFFm9d8FFkdto1PHbBNLA5MGrHHw/D64ctuLaCGzcFeLoYhKfZTtBgKzMd8L0DdXJZpUeTVqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805022; c=relaxed/simple;
	bh=XJ6w+axfSiOGyvsl0SsXjgtFDLRTmuTMOcV01RLfXZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OnE8ihlQU1dipVea41cCNl7UPHH0jqU/375airdXpfteQc4N4H81oO84OxcatuKmF88tbVPqddzaHuvcLonWlT/Itsdgtnkfyc4yRXUcFXzWkABxmRw2FzM3G0a/9Q7JEJ3ndSQaFxR9mgKi8LQPjG6euFSqdbt+Fd6D2ndpMhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DPttYn73; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bb9b28acb4so3151593b6e.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 22:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707805019; x=1708409819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oy4TBR/bVlwsRZ33zaaD5HQzvMGgX2/Drv+E9bU0wjo=;
        b=DPttYn7393elEgc2z0roy0Jc/+Nz0XTy7N/r7pPF+oqQGm6IQRXETxtUdsnD/8mW9w
         UnOkcAb5pfIp5rp0qRSZDT5NtUijE/31MvmW7q3FwsB1oJABv/+MKCfCsnlyhp8t4Ogn
         8YQrrwlUjXqPH2yNP4FDZbe2X2Bcmci0DBnZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805019; x=1708409819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oy4TBR/bVlwsRZ33zaaD5HQzvMGgX2/Drv+E9bU0wjo=;
        b=jCPoFnHJEVx6h4VBw5pmpdnZuKBcfn7EUS3pj6JZKvw7xbZHXtxxHiDqb/AL38FCXV
         TjvPknoDu53E2e8GE7St5+lTjmHW3MUHK7dZGZXHyiGjRGVMKq1Vr4X4gv0Ql13MOwC9
         BNvm+bWlYcbWMla5cXKGQ2ITIt0OktdufbJ0QWEpPMlTzojIOmZ4pc8k+KBqR0/jPNAM
         AJinWS24uEUAkWYzpvs96KsUhgE2qNFDs1XcbjgmzaLE1d1IV1KxPDkZMbLBbqJ+HtJ7
         g2+qzbJFADLN454znYCim84bNYxxUanX5cxzddueJfGCFD7eFriSWWdsCob2DTuJFOrJ
         OiAg==
X-Forwarded-Encrypted: i=1; AJvYcCXBgNkTYSLNedp0+2E/+7m/HV4p9CRPVMnPh6sUx2VCsmE8vJTaNLY1v4jPRKV7jNinqILEzVmuBYn1SK8RlVBPriwTGjd60qjWIeDaXg==
X-Gm-Message-State: AOJu0YyWKRXyHB6qH575Rm1TAfV+b6OMIhHsTZoulyO4DqSR4sm/BN8E
	gx8jmygffVPdYjTSD2rE1ueJZvKjsfEqa110Hqajkt52tPyAAx36/pvc2pGM16Q=
X-Google-Smtp-Source: AGHT+IFcEjQTfRmUrRdhBgTOurxWjQuVGlUBvouMoAS8BiMsWER7QUSADnSG6T0JxoPlwzAT7BGfgQ==
X-Received: by 2002:a05:6808:178a:b0:3bf:f543:4073 with SMTP id bg10-20020a056808178a00b003bff5434073mr10407898oib.37.1707805018849;
        Mon, 12 Feb 2024 22:16:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQHNYwVMxGqxp4VH8pF8WsS2O6Sh/7PTPnuGXLsAssnCKzXSbI0UWbbMhEGlPnyUxWSo+yjmfgmoxcqdCR8vMHPFzv8RUWJ9b+Nex9HHm5bvn6f9wXA9LI/waiE+exWqw1aB6sl2gNZ5cY7fJKPNkBqapeGk314DJ3U0mOX6UISvbCKFPexnxbEZfYKSFo2fE/czZZkKsSs7FLwSNj2jDIgZizzgXl1EeT/b5nJubCOTGzQ4qONNQ1XKuKY/fCNbzHuSNuj5bm6amAgtnckg+SuXQK5St4Mii2ZSN8Cct0EwLAQWmvpBRXlwSrBpuAdt2db7lx3B+a1sjoNi/SGQLipWuES98AC/JKkjgJ3mOTCRyEpFIfdDTUWSQlNq3HnW2BGOyAGQ5du3460znErU5xsv5Hn9QeZchtw7RVAPUjHdTB6BnzsZBlfKCVwyq47qJbH8fPhbatn6DRqWCgrIsa+RoYv2hMMKDDIHR41dIMYXZwiE+zZDFyWzU07sLbNPexJAlcGhi/dcaioYI78obMRzc48h3EJpKxKoRmQGsDvdZfJ3Ni/KWPg6vbm1xuLu36j8iMnACzIcE1WkAlPgTyuVRHuXbekcaV8TMd4eXB/bwdiu8C8HylymV9j+YWWISwonWgjv12Y0dHgnlXJKa+9eHwzHOFSntym6+3Xt8sIHczRwWjGWm44IvJGoCFWG0MqZizaKN7n97Ob8b3uyhRHA6z1ejoMmUEXC1Nf3SaUIVFObIoNY9T2rCIsGh0O9osrpnsUr7gG5KKt5JMS7vh+80FwYNToEUrpGlrdQdzqKe91QnO7n1Vyuy8WTf5anrS5eOyUR7QT1F7pUn6hr+cSQ57PFtJgazfbKSRCqLzOMxpgO3MMjxfYv3YtsTw18IPW2p7u+UwV89xuakJ/0OGPx/N4YeLIkra7iMyHwAh0ZeRE2Ml1c8xaUhCgmN7y7yGQF
 YwEUpBoSFDyaw=
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id n19-20020a638f13000000b005dc87f5dfcfsm342936pgd.78.2024.02.12.22.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 22:16:58 -0800 (PST)
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
	sdf@google.com,
	amritha.nambiar@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>,
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
	Thomas Huth <thuth@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH net-next v8 0/4] Per epoll context busy poll support
Date: Tue, 13 Feb 2024 06:16:41 +0000
Message-Id: <20240213061652.6342-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v8.

TL;DR This builds on commit bf3b9f6372c4 ("epoll: Add busy poll support to
epoll with socket fds.") by allowing user applications to enable
epoll-based busy polling, set a busy poll packet budget, and enable or
disable prefer busy poll on a per epoll context basis.

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

v7 -> v8:
   - Reviewed-by tag from Eric Dumazet applied to commit message of patch
     1/4.

   - patch 4/4:
     - EPIOCSPARAMS and EPIOCGPARAMS updated to use WRITE_ONCE and
       READ_ONCE, as requested by Eric Dumazet
     - Wrapped a long line (via netdev/checkpatch)

v6 -> v7:
   - Acked-by tags from Stanislav Fomichev applied to commit messages of
     all patches.
   - Reviewed-by tags from Jakub Kicinski, Eric Dumazet applied to commit
     messages of patches 2 and 3. Jiri Slaby's Reviewed-by applied to patch
     4.

   - patch 1/4:
     - busy_poll_usecs reduced from u64 to u32.
     - Unnecessary parens removed (via netdev/checkpatch)
     - Wrapped long line (via netdev/checkpatch)
     - Remove inline from busy_loop_ep_timeout as objdump suggests the
       function is already inlined
     - Moved struct eventpoll assignment to declaration
     - busy_loop_ep_timeout is moved within CONFIG_NET_RX_BUSY_POLL and the
       ifdefs internally have been removed as per Eric Dumazet's review
     - Removed ep_busy_loop_on from the !defined CONFIG_NET_RX_BUSY_POLL
       section as it is only called when CONFIG_NET_RX_BUSY_POLL is
       defined

   - patch 3/4: 
     - Fix whitespace alignment issue (via netdev/checkpatch)

   - patch 4/4:
     - epoll_params.busy_poll_usecs has been reduced to u32
     - epoll_params.busy_poll_usecs is now checked to ensure it is <=
       S32_MAX
     - __pad has been reduced to a single u8
     - memchr_inv has been dropped and replaced with a simple check for the
       single __pad byte
     - Removed space after cast (via netdev/checkpatch)
     - Wrap long line (via netdev/checkpatch)
     - Move struct eventpoll *ep assignment to declaration as per Jiri
       Slaby's review
     - Remove unnecessary !! as per Jiri Slaby's review
     - Reorganized variables to be reverse christmas tree order

v5 -> v6:
  - patch 1/3 no functional change, but commit message corrected to explain
    that an or (||) is being used instead of xor.

  - patch 3/4 is a new patch which adds support for per epoll context
    prefer busy poll setting.

  - patch 4/4 updated to allow getting/setting per epoll context prefer
    busy poll setting; this setting is limited to either 0 or 1.

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

Joe Damato (4):
  eventpoll: support busy poll per epoll instance
  eventpoll: Add per-epoll busy poll packet budget
  eventpoll: Add per-epoll prefer busy poll option
  eventpoll: Add epoll ioctl for epoll_params

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 fs/eventpoll.c                                | 131 +++++++++++++++++-
 include/uapi/linux/eventpoll.h                |  13 ++
 3 files changed, 138 insertions(+), 7 deletions(-)

-- 
2.25.1


