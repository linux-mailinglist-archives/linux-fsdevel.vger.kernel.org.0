Return-Path: <linux-fsdevel+bounces-65226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F81BFE7EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 01:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CA33A80BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 23:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF7C3093A0;
	Wed, 22 Oct 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BZWmGKO9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f97.google.com (mail-lf1-f97.google.com [209.85.167.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEC330506D
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761174825; cv=none; b=LCMZY+UkSw7y/DRmbUAHaK6YFiFf3u3aRSw38L1L6YfXQCvCdQLxE0gDhSsMP27LtxWiV7egxIu7QuhQsMsfx+njQOoa1mDmndaEaqg/xYvIr48FHJp+Papez98q0lrKXDifA8MqROUZzHnARxAhw0C5s/B7rt1zLcyZlXFKcfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761174825; c=relaxed/simple;
	bh=+8TQGyg0ZV97+kPFYJBnRauC5Q+QxqG5BEUv/mu4y9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ebC7TohJQrU3OXGTjXqP8c5CvddaZgQ/QgPjor9JE8pPkdux0CfPhs2ZKIsHfWv9ei5Nw7ExBvzCak9+9eSqIQS8M7Z0V1SXOFBZuYIIIcXpWgxWzNyT0U16gTH79yPccYlIfHifNXtnQU5omKclqq7KjTRU9vfCaZzRCZa/03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BZWmGKO9; arc=none smtp.client-ip=209.85.167.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lf1-f97.google.com with SMTP id 2adb3069b0e04-592f1f75c46so18311e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 16:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761174821; x=1761779621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NEb7Tz++jPbBE/mHfoATYrwfDk87qKz0eD7ACfLRyGs=;
        b=BZWmGKO95mD2clfYM/PYqVpX7rGOPzXaBNdIxo6ldORmYIU9uBypqtCxh4clf8sg7p
         bbPfaMsN7iLQ3zmHfVqgp0KZOJTmocZJh605cfVR6RZ4eyuZEiryrUz3UjN6sJcbRuLw
         8B+Fd7EYoRGQnTx1q4yLgQoa/iMRapBsKvpc+cu8J5u96XjxcKdReTAR0i3usD+gUIre
         5xBkmT5LrdNzzrK7Ea0M1dpI+W25Hwuhn1oeXWrTL6cRWN18YvIfFRWWY2/QkX2n22G1
         iAWc4OQMve7TJLXWQbXzftDQIj1GtrxTS5Zw+8nVeEACw2dcTAO60Gd6UwnK9A8E7KtU
         3Kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761174821; x=1761779621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEb7Tz++jPbBE/mHfoATYrwfDk87qKz0eD7ACfLRyGs=;
        b=kTYXTXJMoauMobN583BnOnFibIwtSViCJ7vxy8noz5a1LQy5V3XB3WGSiyuPVEYUbe
         NmEwsPFM1xfY7IacmBPWmbINyyjtR84LzkbOoUwjo2X6+52R6dtMOF1OV/2/iJJ/RAG6
         Tj6lmpMGh0ISQ9UyZ6gNECkZcquXZXMPHNMIpc7Fu/ZcXXHi7HlPGCKlP+8NMCezdCUQ
         8kmG+c25f7reWAsZ04Jo1k6csFu/mQBkrIuk2oufz5YkUuMW0nwRubU8a59loQ8r9MSt
         7np6OgDnvGDnY2876ENqbtnesTf3iWKwf4jRqY1PlTFlPbQE+F2e57V+Cvx10+/ZS0U0
         MZeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgIAhRvIYJqtoDQYICep7yW6Vw8zSSdwh7+naEplPEYQIPjFYUFp8YTv8gACtaGPghGxk4z6yIYiU7FbAM@vger.kernel.org
X-Gm-Message-State: AOJu0YzlrcQ8lx5SokC5goJzWeCbInGKJB8RiuRGuh+vuLyej0sEivKi
	s8+uWmJixphdO71s0O5GCSYf22O1s8hU/gladR32ATX6s1O1sbqgK1lHe1HwuRlzzILqsjAPOC5
	25Qz4bc5rdG2dQfmR0E3B9Zg0ybU8C7LObnBrcFe32EGzCtSi/ag0
X-Gm-Gg: ASbGncttm30V3aKsYS39P47L7eUue44hHlmwg5SXE+y2LsKvpe6Kq4DiW3yPD55vEpB
	d0T+50JsVt8L9q4pKaVtWlTgYkX7eROEHPDnr9RC+LqmY8FZwe3GtiiLln6J+ox7DKwjhXebXVc
	1wRXYO0vFocjPnW+ZSq7d8F9Tj6cjCZTdGjTRCnY80Usf2yHjmfmfHe7waNfggF9wYTIzL0stTf
	K2bgWeyZAah3OD8WkUqhe9sNg9rfIxcTYC2B8tnFxDKV5Gn0zm9XeYmYZQPMnZRYXXVYB4cY0Kz
	iYZZ7XOj6Fu2s6pjke4QuH+RnPhaJ1QgcxRbWf8U9rSho3j0NCcBBJpYZX/zRw0EXmL1R0pKyIY
	9q/e/VXLabVB7O7pZ
X-Google-Smtp-Source: AGHT+IE8YXW1bqh82Pv83CqBL++4EorD9wKI8kSNSxyaHaZobY7QUQj2BR1bXjAEiGky/6dYa+2+odrIWp7W
X-Received: by 2002:a05:6512:131a:b0:57e:ed2d:190f with SMTP id 2adb3069b0e04-591d8598d06mr3612400e87.7.1761174820409;
        Wed, 22 Oct 2025 16:13:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-592f4aa2259sm40463e87.0.2025.10.22.16.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:13:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 86E1B340283;
	Wed, 22 Oct 2025 17:13:37 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7A5DAE4181C; Wed, 22 Oct 2025 17:13:37 -0600 (MDT)
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
Subject: [PATCH 0/3] io_uring/uring_cmd: avoid double indirect call in task work dispatch
Date: Wed, 22 Oct 2025 17:13:23 -0600
Message-ID: <20251022231326.2527838-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a io_req_tw_func_t wrapper function around each io_uring_cmd_tw_t
function to avoid the additional indirect call and save 8 bytes in
struct io_uring_cmd. Additionally avoid the io_should_terminate_tw()
computation in uring_cmd task work callbacks that don't need it.

Caleb Sander Mateos (3):
  io_uring: expose io_should_terminate_tw()
  io_uring/uring_cmd: call io_should_terminate_tw() when needed
  io_uring/uring_cmd: avoid double indirect call in task work dispatch

 block/ioctl.c                  |  1 +
 drivers/block/ublk_drv.c       |  3 +++
 drivers/nvme/host/ioctl.c      |  1 +
 fs/btrfs/ioctl.c               |  1 +
 fs/fuse/dev_uring.c            |  3 ++-
 include/linux/io_uring.h       | 14 +++++++++++
 include/linux/io_uring/cmd.h   | 46 ++++++++++++++++++++++------------
 include/linux/io_uring_types.h |  1 -
 io_uring/io_uring.h            | 13 ----------
 io_uring/uring_cmd.c           | 17 ++-----------
 10 files changed, 54 insertions(+), 46 deletions(-)

-- 
2.45.2


