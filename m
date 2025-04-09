Return-Path: <linux-fsdevel+bounces-46084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66176A82669
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 15:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FAF178E3C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27E225F7B0;
	Wed,  9 Apr 2025 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zH6QNngT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF316EEC8
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206064; cv=none; b=NBHqASn/oZoJqxqV/5CQRqNiRttfW1WiXKytq5wflVHMshJMa23uhJr8StXtzWY4oLViY15yqwYFoQBP8WQKgfXNM1eQ3/g+0L7dbB67DWcaic42bj+w/g8hwnTkNB2UbFBIMx+1nNUsRrxcF5Fxn3BwFFJAG2MfW9B/wlHcy1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206064; c=relaxed/simple;
	bh=ToxSAHnav8JY+Fex5fVqXHAbu6f1gtbrYxB5uaOi1CE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eEUwntEKp+nwBtKVssQ3SRKox+fL0c908Avs1eW8xdrWv8IINR6TMm7aY5bBb626Q7E5fRLFHX70DBTWJ2wsopY8eCAuNw6iQcC0N+dP4wy9mUBwxD+1+RannfSN7aSOn2RC9/77vt9GS4+MMSz3azlZLgwpU42eDNkb9X9Q1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zH6QNngT; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d589ed2b47so22462985ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Apr 2025 06:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744206060; x=1744810860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LjRmHokXKtGq8jY3ta25MzQozdS/ikE4p/OHgY5w8d0=;
        b=zH6QNngTxEFXOL4tQ0KXaoSjS1PJh26TTyiDljtJ6hrivav3sazGBPAb/914gdPo9k
         QTeS5RVyMRWlW9yGR71l2XC2UvoFE/qCDhV/Df0F0K28VTcAC7LyFq6pnOjDO6v1HrJr
         BzdTyGX1J7TH3VQ+/wZ4ugEYsKlqS4d2b2mV3BpOxcFt0tCVBcglYjKzPxmqK+tHvB2c
         6DQ3Yso7ct4wWr83ClXScKJJi191tOKqdPxiGg0mvTzgQMa6uVKmc8Bhpd4kfE5+NVwL
         9d12X2Ga0iR1UnpQ7QUw3VnB5mLtCSweCpdz5pZIi6Lqxfp5Lh0xJHv3wb5temvtLxDi
         4Eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744206060; x=1744810860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LjRmHokXKtGq8jY3ta25MzQozdS/ikE4p/OHgY5w8d0=;
        b=oc44/rKi3iB/KB5YhJoVf+jrAq3AYleWPdPMqS+0jQBFz+0Q8/mWvNWImJKSBtc4lC
         24mn7bPEay3G8BuO+hU9ZpHOjfXb+G81oYM/7JIERKpEvmvI/Nu5aPd7zSVqnfrqAruh
         L80Zp2fKndEnfRRwfSshHdel37pBlppkEmtco2FEJglcUs4sgODr5gJuQx9Dxvq6s8is
         HnH0R3kqeSc1bf2EhMv5klaRyt5ThsHtKxmnVn2B0j022Vznqw2A4HAu72Pn6hklGTqG
         pLIGuAZRXwHwuSMtUCpO9TUzS6ORsZmME2NCPczMSIIbyLrbESyqHPqLiz0QOlr3RyJh
         Xd8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBoOk1QqMIxaR7qyH2OJcytv1twBvHopE2QsGR+5SHwMTb0ea7F3ZnOS0FlHIucKr72wGtJcVTlasiDXIR@vger.kernel.org
X-Gm-Message-State: AOJu0YxV7nu+UrG+KaxLiIVJnzg0YF655QD3kkixIIxURt4jnYjPhWGC
	Dv57ZzfxR3t84dJKxJjVunn83lX2N2dS5+892k40syqyd3hloyrzbuP8uipUdJg=
X-Gm-Gg: ASbGnct8bI+DW66rSrr13jYG5p3IWZfFJB5jWvBtD7/r7tiTi4kckmMtry7CWgvjOql
	XhJCGh8IxcsBbVnbwLt2yUWPcd5wCd8x5sovH09cYEd9062frAXWkgKWXiKFoY6tpOOedLubjTw
	/hgncZGuaJR3J+QeHnpJvEwI94CO/cfiR+zGPnwbcEhp7hldaQmK0Uf137L9/PgqZAUJjiH11Eq
	Z0C0Vf94jJPaGGliW4arPCVlffazEXTdpkS/gMXhzGzPrATAYno+xAzr++wJpzfbVLTEhiYEslF
	CV6OHgBNwkvhdgRRB/GgqvfbcXgrzPe8c9NQyypriju3
X-Google-Smtp-Source: AGHT+IFceys+pXrDkQAjVnC0xLIHJoCAESNX9VhaTheWSjgIQfBO8WOSoThMYZPhTIeixc70eRrFdA==
X-Received: by 2002:a05:6e02:1aab:b0:3ce:4b12:fa17 with SMTP id e9e14a558f8ab-3d77c2b6c0fmr28351475ab.19.1744206059756;
        Wed, 09 Apr 2025 06:40:59 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e2eaeesm242546173.126.2025.04.09.06.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 06:40:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCHSET v3 0/5] Cancel and wait for all requests on exit
Date: Wed,  9 Apr 2025 07:35:18 -0600
Message-ID: <20250409134057.198671-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Currently, when a ring is being shut down, some cancelations may happen
out-of-line. This means that an application cannot rely on the ring
exit meaning that any IO has fully completed, or someone else waiting
on an application (which has a ring with pending IO) being terminated
will mean that all requests are done. This has also manifested itself
as various testing sometimes finding a mount point busy after a test
has exited, because it may take a brief period of time for things to
quiesce and be fully done.

This patchset makes the task wait on the cancelations, if any, when
the io_uring file fd is being put. That has the effect of ensuring that
pending IO has fully completed, and files closed, before the ring exit
returns.

io_uring runs cancelations off kthread based fallback work, and patch 1
enables these to run task_work so we'll know that we can put files
inline and not need rely on deadlock prune flushing of the delayed fput
work item. The rest of the patches are all io_uring based and pretty
straight forward. This fundamentally doesn't change how cancelations
work, it just waits on the out-of-line cancelations and request
queiscing before exiting.

The switch away from percpu reference counts is done mostly because
exiting those references will cost us an RCU grace period. That will
noticeably slow down the ring tear down by anywhere from 10-100x.

The changes can also be found here:

https://git.kernel.dk/cgit/linux/log/?h=io_uring-exit-cancel.2

Since v2:
- Fix logic error io_queue_iowq()

 fs/file_table.c                |  2 +-
 include/linux/io_uring_types.h |  4 +-
 include/linux/sched.h          |  2 +-
 io_uring/io_uring.c            | 79 +++++++++++++++++++++++-----------
 io_uring/io_uring.h            |  3 +-
 io_uring/msg_ring.c            |  4 +-
 io_uring/refs.h                | 43 ++++++++++++++++++
 io_uring/register.c            |  2 +-
 io_uring/rw.c                  |  2 +-
 io_uring/sqpoll.c              |  2 +-
 io_uring/zcrx.c                |  4 +-
 kernel/fork.c                  |  2 +-
 12 files changed, 111 insertions(+), 38 deletions(-)

-- 
Jens Axboe



