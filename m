Return-Path: <linux-fsdevel+bounces-25676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8641694ED72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 14:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93D51C21DCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A547217BB18;
	Mon, 12 Aug 2024 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ra3BGMiO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D50517B516
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467457; cv=none; b=GGR2xRxKuAtytNQuXKc5d9EfAqmh27pfHcT279CEuBnD1EonIC1+SnF6/EY5McPmUjMi9n856mNM3K7Flu0E347ELikJ3E9ri8rjdKVknFXcACpaXtI+nEzgQ0cXnCmJd9QKCcy2td6dAblhYNzj4H/Vr6GqNUEwEUUfs9k6qpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467457; c=relaxed/simple;
	bh=MDz9dC9gTYTAHSjLLL5G1NfvdG2IhmR0AoliL3khWdk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vApSb1HOGrc63DodoGACuSwyh2iqNk5yU5/uEQ7toEK9wba79BVvySbppWhspjdwyTmwwZ5sKSVqlg5g9pZtqJ9NK3AGFQY11UiRHdlIPj29V8DV3A8cG/PUBi7Yd+wbQIL3e4fc5J6RQL+Ru3dNzwJ8EBB4hxTozkI7/W7g+yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ra3BGMiO; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7a23fbb372dso2585453a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 05:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723467454; x=1724072254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=im8KpEyQEI7OiPKCxOhe/2kt2a2ybz6CAYmO/N9YxlY=;
        b=ra3BGMiOwemjKxq0pZbrGRV+gZfqKFNqWJLdH5X4M5VRPI+tfOUoTB9B/I/qX42J3a
         GwGo9pNVigPZ3n+8+PJhs10Pqjq32PHh2VyGUwXL1Zsq/XmMLzYo8nXssenwHNS67lG5
         tgyoe/mvDkbsOKgXJm5sOWlO5DmaGdAuBze0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723467454; x=1724072254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=im8KpEyQEI7OiPKCxOhe/2kt2a2ybz6CAYmO/N9YxlY=;
        b=fp4tNNSqz02MIaUKzhYT3NO7Bz64n1nTgfLUVeasyhxr+T6SpDrdFLpXI5bXxt/eoc
         vwIxwjX5uPAUvU75g2zjTJPnKB1TOK2XsE28rlTjYiErRvzJKrJBxUrwqi0Kufv0NcFb
         gr5cDUx8TDq52dnxpAplWYke4W1uMCICyRecPLJnu6wCfJYuFkITonnBCChJXnVI6G6l
         FwYIEXIvXdV1QWCeC7mKImuJZn+xFLQwuck5V7nIZ0oojwsOWG4JQATXztn2OG02Tkhw
         b/IsYNiYLZ+YPPFIpWlgoOehsA9i3Zo2Ht+ze14PWY2C/jynlSgybyxwbbt/biPNPVKf
         CdQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkuHGppwqn4jt8vxcbYXo9baeKkXSU0Pm4Us5hVlwCMbm48y8W1z/GNp2oKsNE/59bIbnHPX4IRtNisll+VtO1CNpsiXyhpjgp7D8r3Q==
X-Gm-Message-State: AOJu0Yz0WhCDSVt8rX9suuJXozQs8wdFWCRcVQSF/nCkBOxRsV/bsz1W
	sEl9wmCs5D3mC25MDOmCjf6Frts/Cxr6CRc2hyNQbcQMa/ohhMeTx5/l8Wje9+g=
X-Google-Smtp-Source: AGHT+IGyKNoPKnsUeLXXVDODRMpADXy/RxJU7/g4zFWJav9Nc3d0UvLs50qUxM4lU6dtVDXTJ6HJ7g==
X-Received: by 2002:a17:90a:6b44:b0:2cb:5112:740 with SMTP id 98e67ed59e1d1-2d39262351cmr101548a91.26.1723467454465;
        Mon, 12 Aug 2024 05:57:34 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9ca6fafsm8183368a91.34.2024.08.12.05.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 05:57:33 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list),
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
Date: Mon, 12 Aug 2024 12:57:03 +0000
Message-Id: <20240812125717.413108-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Martin Karsten (CC'd) and I have been collaborating on some ideas about
ways of reducing tail latency when using epoll-based busy poll and we'd
love to get feedback from the list on the code in this series. This is
the idea I mentioned at netdev conf, for those who were there. Barring
any major issues, we hope to submit this officially shortly after RFC.

The basic idea for suspending IRQs in this manner was described in an
earlier paper presented at Sigmetrics 2024 [1].

Previously, commit 18e2bf0edf4d ("eventpoll: Add epoll ioctl for
epoll_params") introduced the ability to enable or disable preferred
busy poll mode on a specific epoll context using an ioctl
(EPIOCSPARAMS).

This series extends preferred busy poll mode by adding a sysfs parameter,
irq_suspend_timeout, which when used in combination with preferred busy
poll suspends device IRQs up to irq_suspend_timeout nanoseconds.

Important call outs:
  - Enabling per epoll-context preferred busy poll will now effectively
    lead to a nonblocking iteration through napi_busy_loop, even when
    busy_poll_usecs is 0. See patch 4.

  - Patches apply cleanly on net-next commit c4e82c025b3f ("net: dsa:
    microchip: ksz9477: split half-duplex monitoring function"),  but
    may need to be respun if/when commit b4988e3bd1f0 ("eventpoll: Annotate
    data-race of busy_poll_usecs") picked up by the vfs folks makes its way
    into net-next.

  - In the future, time permitting, I hope to enable support for
    napi_defer_hard_irqs, gro_flush_timeout (introduced in commit
    6f8b12d661d0 ("net: napi: add hard irqs deferral feature")), and
    irq_suspend_timeout (introduced in this series) on a per-NAPI basis
    (presumably via netdev-genl).

~ Description of the changes

The overall idea is that IRQ suspension is introduced via a sysfs
parameter which controls the maximum time that IRQs can be suspended.

Here's how it is intended to work:
  - An administrator sets the existing sysfs parameters for
    defer_hard_irqs and gro_flush_timeout to enable IRQ deferral.

  - An administrator sets the new sysfs parameter irq_suspend_timeout
    to a larger value than gro-timeout to enable IRQ suspension.

  - The user application issues the existing epoll ioctl to set the
    prefer_busy_poll flag on the epoll context.

  - The user application then calls epoll_wait to busy poll for network
    events, as it normally would.

  - If epoll_wait returns events to userland, IRQ are suspended for the
    duration of irq_suspend_timeout.

  - If epoll_wait finds no events and the thread is about to go to
    sleep, IRQ handling using gro_flush_timeout and defer_hard_irqs is
    resumed.

As long as epoll_wait is retrieving events, IRQs (and softirq
processing) for the NAPI being polled remain disabled. Unless IRQ
suspension is continued by subsequent calls to epoll_wait, it
automatically times out after the irq_suspend_timeout timer expires.

When network traffic reduces, eventually a busy poll loop in the kernel
will retrieve no data. When this occurs, regular deferral using
gro_flush_timeout for the polled NAPI is immediately re-enabled. Regular
deferral is also immediately re-enabled when the epoll context is
destroyed.

~ Benchmark configs & descriptions

These changes were benchmarked with memcached [2] using the
benchmarking tool mutilate [3].

To facilitate benchmarking, a small patch [4] was applied to
memcached 1.6.29 (the latest memcached release as of this RFC) to allow
setting per-epoll context preferred busy poll and other settings
via environment variables.

Multiple scenarios were benchmarked as described below
and the scripts used for producing these results can be found on
github [5].

(note: all scenarios use NAPI-based traffic splitting via SO_INCOMING_ID
by passing -N to memcached):

  - base: Other than NAPI-based traffic splitting, no other options are
    enabled.
  - busy:
    - set defer_hard_irqs to 100
    - set gro_flush_timeout to 200,000
    - enable busy poll via the existing ioctl (busy_poll_usecs = 64,
      busy_poll_budget = 64, prefer_busy_poll = true)
  - deferX:
    - set defer_hard_irqs to 100
    - set gro_flush_timeout to X,000
  - suspendX:
    - set defer_hard_irqs to 100
    - set gro_flush_timeout to X,000
    - set irq_suspend_timeout to 20,000,000
    - enable busy poll via the existing ioctl (busy_poll_usecs = 0,
      busy_poll_budget = 64, prefer_busy_poll = true)

~ Benchmark results

Tested on:

Single socket AMD EPYC 7662 64-Core Processor
Hyperthreading disabled
4 NUMA Zones (NPS=4)
16 CPUs per NUMA zone (64 cores total)
2 x Dual port 100gbps Mellanox Technologies ConnectX-5 Ex EN NIC

The test machine is configured such that a single interface has 8 RX
queues. The queues' IRQs and memcached are pinned to CPUs that are
NUMA-local to the interface which is under test. memcached binds to the
ipv4 address on the configured interface.

The NIC's interrupts coalescing configuration are left at boot-time
defaults.

The overall takeaway from the results below is that the new mechanism
(suspend20, see below) results in reduced 99th percentile latency and
increased QPS in the MAX QPS case (compared to the other cases), and
reduced latency in the lower QPS cases for comparable CPU usage to the
base case (and less CPU than the busy case).

base
  load     qps  avglat  95%lat  99%lat     cpu
  200K  199982     109     225     385      30
  400K  400054     138     262     676      44
  600K  599968     165     396     737      64
  800K  800002     353    1136    2098      83
 1000K  964960    3202    5556    7003      98
   MAX  957274    4255    5526    6843     100

busy
  load     qps  avglat  95%lat  99%lat     cpu
  200K  199936     101     239     287      57
  400K  399795      81     230     302      83
  600K  599797      65     169     264      95
  800K  799789      67     145     221      99
 1000K 1000135      97     186     287     100
   MAX 1079228    3752    7481   12634      98

defer20
  load     qps  avglat  95%lat  99%lat     cpu
  200K  200052      60     130     156      28
  400K  399797      67     140     176      49
  600K  600049      94     189     483      68
  800K  800106     246     959    2201      88
 1000K  857377    4377    5674    5830     100
   MAX  974672    4162    5454    5815     100

defer200
  load     qps  avglat  95%lat  99%lat     cpu
  200K  200029     165     258     316      18
  400K  399978     183     280     340      32
  600K  599818     205     310     367      46
  800K  799869     265     439     829      73
 1000K  995961    2307    5163    7027      98
   MAX 1050680    3837    5020    5596     100

suspend20
  load     qps  avglat  95%lat  99%lat     cpu
  200K  199968      58     128     161      31
  400K  400191      61     135     175      51
  600K  599872      67     142     196      66
  800K  800050      78     153     220      82
 1000K  999638     101     194     292      91
   MAX 1144308    3596    3961    4155     100

suspend200
  load     qps  avglat  95%lat  99%lat     cpu
  200K  199973     149     251     313      20
  400K  399957     154     270     331      35
  600K  599878     157     284     351      51
  800K  800091     158     293     359      65
 1000K 1000399     173     311     393      85
   MAX 1128033    3636    4210    4381     100

Thanks,
Martin and Joe

[1]: https://doi.org/10.1145/3626780
[2]: https://github.com/memcached/memcached/blob/master/doc/napi_ids.txt
[3]: https://github.com/leverich/mutilate
[4]: https://raw.githubusercontent.com/martinkarsten/irqsuspend/main/patches/memcached.patch
[5]: https://github.com/martinkarsten/irqsuspend

Thanks,
Martin and Joe

Martin Karsten (5):
  net: Add sysfs parameter irq_suspend_timeout
  net: Suspend softirq when prefer_busy_poll is set
  net: Add control functions for irq suspension
  eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
  eventpoll: Control irq suspension for prefer_busy_poll

 Documentation/networking/napi.rst |  3 ++
 fs/eventpoll.c                    | 26 +++++++++++++--
 include/linux/netdevice.h         |  2 ++
 include/net/busy_poll.h           |  3 ++
 net/core/dev.c                    | 55 +++++++++++++++++++++++++++----
 net/core/net-sysfs.c              | 18 ++++++++++
 6 files changed, 98 insertions(+), 9 deletions(-)

--
2.25.1

