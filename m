Return-Path: <linux-fsdevel+bounces-11023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E3D84FE99
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 22:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B40D1C24380
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 21:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3062D39AC9;
	Fri,  9 Feb 2024 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vn5cGjET"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E3124214
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 21:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513347; cv=none; b=YOh/wGjTCZotARN09pMPoZ99PsLsqcnB1sHYMnuyh13rgyhRxDvJzRGTCgwFo23pT+um9rZehuUGoyGvbnpIjcjnJtxRiCOdW3kpQbbt28hEuzqO5n9OkaF3xgG0cAcVmisnuKhkVcW9p3TY45GzzoPUXdQWhr/iHUxqhyNCFZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513347; c=relaxed/simple;
	bh=BptRnluT67ciQ8DWYhQvTIkSDEbsug1Ak3UtlQFX8y0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QPdn0qjOu4NZc+yRPcK9ZSVO5YB6T0SnYH7acUpZmcBBGFZtxdOarFbbk4JD+R0P48MW3yOxM/DBkp8smcqUCUXUQlhUAkyC1EMZ/CmKIwsMtB47NO1+d7/xyIFwocUa9ztb8vYUMcAloaemio/ImAMwLMuPt8abm2OdHWlX2x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vn5cGjET; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e06bc288d2so1000655b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 13:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707513343; x=1708118143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D2/+3vYZtbSbyQ5e2W9c0pD7gI0eBd/PvDW5PTU7kMg=;
        b=vn5cGjET2y5j4BOX7elUUHf0SI0EsLwN5ORi0/c4nO0984OlT/KFXsUWg96/MQT2fS
         SpB/OHEy7HTtEhv8Hd2+7vcFi7zcxApbiveS5WHiTWV/Lc6ezUqq2riediTbiQE/e/lB
         Cx8+2qsgu2TpzWnjz+dDgPSVg7k0ocOAb4xCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513343; x=1708118143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2/+3vYZtbSbyQ5e2W9c0pD7gI0eBd/PvDW5PTU7kMg=;
        b=i9RUUkgVjitWguBknijnhcWzefWna2j/MPSSrDO+8UFL9MAU0XNggpw55m8FUhzca7
         NvMAf1aC1CIRuasKPcBvnLP2vDmTUy2+gxDjg14J50dVVXX9bMZ5ncTgeDaXdgr0iwIL
         pnN6tnL/RCPD5MueyEXx/+lxc80S3+EPfC/kGtpmDeHM5YKHtmHHjyks13PtOReE+tB5
         Wo4ZWM73em0f6kfwCID9E71kP+h0NprqrlRN4cieA9hM2EkiaXv9W3R1R/xUVcKFqi8Q
         8wjYGHaNKbQOOZ1/1CT4d46EzV/o2L2AVeuEmIAtrRKOq6O7dniqYWvTMdRr2JMaVygu
         sKoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6vOgynFOKB53WSIdvjRtQ1JLNucttneIPBfrBeyNNCvjghUYGMPaGGTYK6fJVGgFkKIiHSGIGy+n7LYgVKg8BUAEPv2YsDRw5A8KNkA==
X-Gm-Message-State: AOJu0YxYu+XJHJ4LkkvwpMGDJ+H5lViIo8yok3E4/7iO770x3HVo4MSY
	fo30MS/1xaxik7uoy6Y0Kj6JXnQbnsBUZHTdVmq1XeOIbAFkb4o7La0XU2nJRe8=
X-Google-Smtp-Source: AGHT+IGRP21snVtoXmtHShQmOca/chEsTDn4V0cJCAy9E+uKPapg2/rVB54xC+c9EmMEE/L+5fmzsg==
X-Received: by 2002:a05:6a20:3a82:b0:19e:a36c:36ef with SMTP id d2-20020a056a203a8200b0019ea36c36efmr262408pzh.48.1707513343476;
        Fri, 09 Feb 2024 13:15:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVX7pIzrHeFHIfwvhVjO0EBysDPtzzfm03AT3WWQrPPgBCChi3ibn1HbKwtqK7QoDflkL5uo8KQBDJM0OhNUMisTzUAzXKzRGmh5A0++rgUtL41c8bMhrLmtbxHXY23XI+FpmYoPgtemV5FgUP2RvDauk2TSzdFO/odhX1gkyq4oRPJCgoT+YhOCj7NwOmYbRnbDY133EK1l1kKoZvqcURf2nCTuVB9X/F/EzeaKajF4sa5w2ekjFXhuafgsp7fVWkq+QsLjmBVHbSBl7biYhI8ngBw4uZrfLZXKe/14TfPQcw6J0Hm3wyAI/g7sqGXtTy/L0hP6T/F5/0Cs4JazENrsN0BrkaqiTiqQ6j0x68uIW+Il2YtR69NDSXA5bOHGUrZUZDIWFVPAtL0CTHy69jQsLSHCLyD3ebkqUHmC63DhChS71JXJ8lL5w91OXWlRFywHjhMl6UY8sMfr/5AD466OjYeH+/ttb2Znio7pU+3SXAuqtUsu73sg0R4Rsh0kYBg3N+AxEj/DTYA33GbBLnUEwoX+/0/hFVBB7nzVivbSqd25EltDuPtra7Zh3BQDAl6ELfBOyz2dvjjoLwAs1s95clOKntpy1ZYJxx/Ckftyd2M8EYcD0HrGFicwcNdzEyKbPDBigiYunx7yZiHxngBS4nNqELltdghSBL5j9GFpy7Di3Bz3S+ZEyjRjgMUKa8w8NJOy5O6ZufMWOfBWR0IcSK3db9Y7vHM+j8HaBuJA3AqisWzja0vTTUoIQkqj21bm1LsNqmzkHnMyBTOBwp7CVE9q/90hwA5WTJlpJX5f7ZdYwV6TUyX5oZaik0rH9Gxg0oHBxdWMuCzzaTCgr3N09+GtNk3rd/vKyxKJkhyE6BV44vjY9m1g2oJTVyspfHziCuceqG7JGUNZULRBkn7sHw4oDSauzkb+UZ+3d0Xfbd89nSVpPZiNN40fH0jjTyZb4
 ouMMKbQs4fK9CLJ6zMc5t2fPcmqLr7wSlkYwWoT+xXUX11oou4vS7rqJMrHKa+4iTLtpz4ECBuTtv5jVI=
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id x23-20020aa79197000000b006e05c801748sm969629pfa.199.2024.02.09.13.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:15:42 -0800 (PST)
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
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
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
Subject: [PATCH net-next v7 0/4] Per epoll context busy poll support
Date: Fri,  9 Feb 2024 21:15:20 +0000
Message-Id: <20240209211528.51234-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v7. See changelog below for minor functional change and cosmetic
cleanup details.

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


Subject: [PATCH net-next v7 0/4] *** SUBJECT HERE ***

*** BLURB HERE ***

Joe Damato (4):
  eventpoll: support busy poll per epoll instance
  eventpoll: Add per-epoll busy poll packet budget
  eventpoll: Add per-epoll prefer busy poll option
  eventpoll: Add epoll ioctl for epoll_params

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 fs/eventpoll.c                                | 130 +++++++++++++++++-
 include/uapi/linux/eventpoll.h                |  13 ++
 3 files changed, 137 insertions(+), 7 deletions(-)

-- 
2.25.1


