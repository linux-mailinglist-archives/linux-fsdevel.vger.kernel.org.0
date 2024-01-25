Return-Path: <linux-fsdevel+bounces-9014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B7983CFCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 23:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567F8295491
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 22:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68C212B9A;
	Thu, 25 Jan 2024 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="B58/m/Id"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86412B8C
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223467; cv=none; b=c/y+mcM49nDKBdFIVcJZdY2npmIGM7CSiSwsZllsQY9/QeElNVksvzmh9pEdF8pj4U9FYDN6vqgUGISsLbZqnchPiaXEzBwZwCcmXGiU+ex16D/cOnZ1SznGeq8qQXdStwAe/M6RrtukpeH4384QaNooBTWBAdV+K99mVrmWD+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223467; c=relaxed/simple;
	bh=6odP9Zfv4jT1UPPhYzIXbp8Wkc0XoPa8xwrrf2TyNnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CLR1mIW6tWD/KfKG3QHMEzXrJT8Aw2EOoIlgYJWrdIJ/1H5ctFXLKpP5d+FarsumElobQcclGw4VECD5Z1rncCz0oosvQTJJcjBLRT0Ha+H61lB3Ug7L7MHfFBmiKJMQYDk9qGHKX+/Pk52e0oQkVYkEJ71w9i8Wh9dotyMbpDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=B58/m/Id; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bed9f5d35dso362296539f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 14:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706223464; x=1706828264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DmGx9+QDJXLKTo3H9MiyfX7TEgh1xSwvOnrY9VXnVdM=;
        b=B58/m/IdEYEIh4nIv0EmFBOm4KbcmU6fOaU+HuIHrhpFJpz/MM3n8bRPbuqAbecug3
         N6YzG3FjKiKEebsmKqjSkWs4Pg3AGfTud+81aSxHknxuks2j6eU4RO9yzC2qHQQ4ZlZY
         ayecjUqmgf8t81yW5/d2MHYjH7AhLyrCDFL90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706223464; x=1706828264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmGx9+QDJXLKTo3H9MiyfX7TEgh1xSwvOnrY9VXnVdM=;
        b=fIwqbuW9FMrLjZ3RghicExhaO9PVPDZBESBOoi6EyZ65olnZHV2p0dvByVY5hxueTC
         lnMKsjkDc+40nROtiSNcRG+drsLvyRuXctAs2wr9DlRpPFEbtxHaXkZbUcJ7gLk9h97E
         s4a0RtrA7SfbmKQIiPIQXETa2Xq56KXhyXZJX8wIPaouA1zzLMLF3BsAP/FUfY2tVw6K
         FwKxhkwffLLiKtf3AET2NsbBYuEgx5E7KC9hv6/o+Fz1p+aZ1ah0IKYzdi9NaI7PGURV
         iA23pDOXpXYTDD5kYNNx+DMUfUgeG/wiKbK5Pp0xoKfpmcncQN6u9ScwA9XTDPNJZ2D+
         tI7A==
X-Gm-Message-State: AOJu0YwHog7pA9nNUP3wr+cRqpnkQoOLkE9f9Ii76oVSEe5ezbXM/htK
	wDFHL4vUrfNktyRtu1sFtybWhiNo9+3slehjMLfubgCB9rfyPWoebggaK60aW8Y=
X-Google-Smtp-Source: AGHT+IGJOlk8p0p+eepUvrJIZ2A7VA58foiJl5D62a/cdKG2oMDEtZHgf75lD945pBIByTtOFe6B7w==
X-Received: by 2002:a92:290f:0:b0:35f:ced5:5555 with SMTP id l15-20020a92290f000000b0035fced55555mr437125ilg.25.1706223464499;
        Thu, 25 Jan 2024 14:57:44 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id z24-20020a631918000000b005d68962e1a7sm19948pgl.24.2024.01.25.14.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 14:57:43 -0800 (PST)
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
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Arnd Bergmann <arnd@arndb.de>,
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
	Thomas Huth <thuth@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH net-next v3 0/3] Per epoll context busy poll support
Date: Thu, 25 Jan 2024 22:56:56 +0000
Message-Id: <20240125225704.12781-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v3. Cover letter updated from v2 to explain why ioctl and
adjusted my cc_cmd to try to get the correct people in addition to folks
who were added in v1 & v2. Labeled as net-next because it seems networking
related to me even though it is fs code.

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

Note: patch 1/4 uses an xor so that busy poll is only enabled if the
per-context busy poll usecs is set or the system-wide sysctl. If both are
enabled, busy polling does not happen. Calling this out specifically incase
there are strong feelings about this one; I felt one xor the other made
sense, but I am open to changing it.

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
individual applications, making epoll-based busy poll more usable. Note
that this change includes an xor allowing only the per-context busy poll or
the system wide sysctl, not both. If both are enabled, busy polling does
not happen. Calling this out specifically incase there are strong feelings
about this one; I felt one xor the other made sense, but I am open to
changing it.

Thanks,
Joe

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
    independently to the list [5].

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
[5]: https://lore.kernel.org/lkml/CANn89i+uXsdSVFiQT9fDfGw+h_5QOcuHwPdWi9J=5U6oLXkQTA@mail.gmail.com/

Joe Damato (3):
  eventpoll: support busy poll per epoll instance
  eventpoll: Add per-epoll busy poll packet budget
  eventpoll: Add epoll ioctl for epoll_params

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 fs/eventpoll.c                                | 122 +++++++++++++++++-
 include/uapi/linux/eventpoll.h                |  12 ++
 3 files changed, 130 insertions(+), 5 deletions(-)

-- 
2.25.1


