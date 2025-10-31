Return-Path: <linux-fsdevel+bounces-66627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA9AC26E87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 21:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7270C407C8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 20:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C232E329C63;
	Fri, 31 Oct 2025 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dvQYnWoz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com [209.85.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269313254B3
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761942882; cv=none; b=KAcJOcdJwjdWbqDSkYdLZmibbwKMaSE8u+WlIvMWgXJqdkwDVkqhHvqgh0WJaVC52X+Y3ubRspPz0ME9dq4Gj9gdyp2R8PwPLbwCXDSipo6gNGiCLHgYSw+Yb/fjde92bavo1Q3ZlAmWltYjIO4p12V7zwKg8fa2OHI8TlrEQbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761942882; c=relaxed/simple;
	bh=jvDE7lWJxH3JAXZ63PoEX/oK9PZRTBG5vt6245JF66Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b7smxhYdpPsTkdbH9KJFVhiXVFpUwpESbc/se2XzXpP9Mn23dMpC7w+0FMS1+FJlQVis3+c9KD/ZVigKlx6WWfhrOu3oPksA/aee6Him6b0oN+jLRtSRP4IQupO5BP57VMyYbURGLd6wk5iMH4+81ujg83tPPuK5PYVYre8SpXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dvQYnWoz; arc=none smtp.client-ip=209.85.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lf1-f99.google.com with SMTP id 2adb3069b0e04-592fac6c37fso325798e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 13:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761942877; x=1762547677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6JMKDvp/MIeXNCA/ceerlUqX0sUk5SPPyvwa4mIoYyc=;
        b=dvQYnWozKugEUNvqdhCr6mOWn03B72UNbtIqWXxtzXbQZh2FwocLAAA2fo4AQBP8nD
         gjuJ7hbba2arrHmEhlTtgj3pQKsPpu3BSnPyWnsK/iJ120VJETkxreb4co7cGyDFjZ1Q
         Romr/u0AGF19Syc7K43JIlSdWKtdIt1Ct4P5iyInbmy9uAp6cN0Z1/cei717ORVB3nVw
         DDaUMhf0SYo8HVPxmDmJPPtLOHXG4V63nGyRAWOsWj3w42NKDkkdBx63fvfLk7zXY9gU
         qtPQJcYjFgzu17DHVa4v45yxtBaGrPHVrXeKNpXiD88/aZ8e+7f8iLJHjYqmKVvQCbdk
         8keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761942877; x=1762547677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JMKDvp/MIeXNCA/ceerlUqX0sUk5SPPyvwa4mIoYyc=;
        b=dz3do7CdqFL6AcK/Hto3hZlXIeo0La59zqgBVDcUYZGSAYNArQHOwROgFUo4uh/onw
         g3ZsgWM0I9ZYrlrrB8L90TLKqa/wFxF27OrXMBUVrmmSopY1K2wc3XeIHWdE3JtaGjal
         G46lPsOr+NQM2ChJIF/3I8L/4CqAeo1ewWR0VITCuiLVBJchg2a4UrgojfAcePMQorjJ
         D6s/OvfW0tErBrJU18oyg9OPd/k18ArRUYdL0mqpY+tHcX/4v19QG46GK5HWB9nKxjKh
         5Wn6aGtBUATtkT8TZ599Osit31He9oPOHOBLiI6gc2iz8/I7DZQ76h9H3FZvJ4SaK98X
         uz+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6mJpVsJF7WcERe8YHyWRd0kBk141cZe08wK1Dk214+4KaW83ercyxGs6Jy0NXi+oOQzno6SEgvOqWUtYG@vger.kernel.org
X-Gm-Message-State: AOJu0YxpoGd1NzVBbLL3IbE52bnn/Uz702Nb5XMwtziklPTmqlJd1and
	rpLI5QQoynLzJKGrkbPE6dIW/P/lAeeetQWyNEHK6hwzy8ykHE9X1F5dHtAXFySWukMtavVIgy7
	4ksMZbLY+/iPmtMQWcd8/TW0s0DoPVuqc6byK
X-Gm-Gg: ASbGncsC4sdEzG1h4Is6l+gWaQqa6ulg+i2sw+gr3INcYSLV3DtiikgVoyyP3y9R7aC
	eS1ln1yLN4eL+Hwh4NQQWa1IucaSmV6Nl/vj/M47ucvtgerwEu/0hTBndFRFL/heR+6koPD+hRf
	j6+PrTquB08JSC018eT1oy9SrM0fvOyhGokm6jEWn5+7RJ/vL7KH5e6xJ9ZX+Mhgbm9JVilVuJS
	woCIom4x4uUTcSYUEx1p/mUBgugod1ChAXfYW49rl4UDq7O8JggOF4htqB00qyra5c++I1PtjyR
	cMN2ekxNjjPQ+hHTPPNBBFlK3m2rYa+2B5ds70OUKuLOvzN0v/MbdKxkFSPsQ2sYvXLxZxrT1pd
	PLyUNEuDaRQ+KvGsmd1BsyqZIUZa3DhU=
X-Google-Smtp-Source: AGHT+IHYGUnO7bV47O6a0JaarTqAfmI/2Y9l++bnlFY3ld+pOZSgy8vCnY+sYVKLt/9KYUiwgYpMC6aTC4ND
X-Received: by 2002:ac2:4c4f:0:b0:592:f7b4:e5fb with SMTP id 2adb3069b0e04-5941d4ff894mr969734e87.3.1761942876878;
        Fri, 31 Oct 2025 13:34:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-5941f3a30cbsm287556e87.27.2025.10.31.13.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 13:34:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4EBCF3400FE;
	Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 465FEE41255; Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 0/3] io_uring/uring_cmd: avoid double indirect call in task work dispatch
Date: Fri, 31 Oct 2025 14:34:27 -0600
Message-ID: <20251031203430.3886957-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define uring_cmd implementation callback functions to have the
io_req_tw_func_t signature to avoid the additional indirect call and
save 8 bytes in struct io_uring_cmd.

v4:
- Rebase on "io_uring: unify task_work cancelation checks"
- Small cleanup in io_fallback_req_func()
- Avoid intermediate variables where IO_URING_CMD_TASK_WORK_ISSUE_FLAG
  is only used once (Christoph)

v3:
- Hide io_kiocb from uring_cmd implementations
- Label the 8 reserved bytes in struct io_uring_cmd (Ming)

v2:
- Define the uring_cmd callbacks with the io_req_tw_func_t signature
  to avoid the macro defining a hidden wrapper function (Christoph)

Caleb Sander Mateos (3):
  io_uring: only call io_should_terminate_tw() once for ctx
  io_uring: add wrapper type for io_req_tw_func_t arg
  io_uring/uring_cmd: avoid double indirect call in task work dispatch

 block/ioctl.c                  |  6 ++++--
 drivers/block/ublk_drv.c       | 18 ++++++++++--------
 drivers/nvme/host/ioctl.c      |  7 ++++---
 fs/btrfs/ioctl.c               |  5 +++--
 fs/fuse/dev_uring.c            |  7 ++++---
 include/linux/io_uring/cmd.h   | 22 +++++++++++++---------
 include/linux/io_uring_types.h |  7 +++++--
 io_uring/futex.c               | 16 +++++++++-------
 io_uring/io_uring.c            | 26 ++++++++++++++------------
 io_uring/io_uring.h            |  4 ++--
 io_uring/msg_ring.c            |  3 ++-
 io_uring/notif.c               |  5 +++--
 io_uring/poll.c                | 11 ++++++-----
 io_uring/poll.h                |  2 +-
 io_uring/rw.c                  |  5 +++--
 io_uring/rw.h                  |  2 +-
 io_uring/timeout.c             | 18 +++++++++++-------
 io_uring/uring_cmd.c           | 17 ++---------------
 io_uring/waitid.c              |  7 ++++---
 19 files changed, 101 insertions(+), 87 deletions(-)

-- 
2.45.2


