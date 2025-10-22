Return-Path: <linux-fsdevel+bounces-65209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B049BFE259
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 22:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80AC3A7D09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 20:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917B32FB0AE;
	Wed, 22 Oct 2025 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeeiKJZ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E59B33F3
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164592; cv=none; b=LrPJiciVxVf/8QxEtf2uS43teysHKZOTg97EF+3pjnUXtien6GkKbBjd3YijLctg5kGy/78IY89+kazqiwpNdNcNrnEz4UwyItGyrDVUryEzk0V6j20pxbJ9tdO+KNB+DmZeJOdAwKnUr/p15E3voDtksZISBvOC+p9Jc/WZv10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164592; c=relaxed/simple;
	bh=cp5ty5nbE5cmwdf7e+GOM7vNP/yCBdewq52VexwfjUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uLYq87hDXNiPebHtjXTwEtUpvRxW8U2oQPdTBJB1XvBNe7/XCyuTphEJBTw9IfDPlkLZ3IaXmjFtvUg/GFLyxj15nvNuWUZUjjnNYYT4o5mOSeBC8zlv8pFjwSBSafftgaNNcNBmr/hJfgT3k+ioFQ1xTmP41bc7VvqMrNbmMwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeeiKJZ7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a26dab3a97so42368b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 13:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761164588; x=1761769388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=owh6411Khvjod0u0PmuG4C6qfWHhdBSTnJs4puqC3Kg=;
        b=JeeiKJZ7KlHyBHQ9E0rl6br2ZF0p1Ii2ouAGhMjJm6NK+dNTZQsRt5UIfeosCbbxFa
         ZFJYNRjwlHbu0JrK1pN6Q51k2LTge0/rYJwku/s5Cf39QQEBAdnO0Q7Pian1YIDZwqUJ
         L/kcVPiymblXP4LithiKaE/RAFQ3qV8/4zE35vKIcH6uAWpfgyQcrYsLlxS2LhHR6468
         4fdeRmGvF91YmpKY3JLO+u+nXfsK8vUIg8Aifeqgn4PfPloTg3xJhDi/4pBVcPdUgSbP
         me49fg7GxaKmrG4vGXtLPfYUhSbYULnMEwWkRn1IUPUNqmKvmTWn2JFMpV5ZnsMPMaF5
         hdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761164588; x=1761769388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owh6411Khvjod0u0PmuG4C6qfWHhdBSTnJs4puqC3Kg=;
        b=shnZzLi+4tzKC0bi6UHG0J4paDR7QTX5lCQi28vjwB52kDcrZWfSNpINlfVMalZX4+
         s5q3kVTMeKsPnzTzeba+U3oeuY92fVSL9FqpxWCvciny/AP9O5AoGJM08C/0pPHnf1LR
         WMHuM4FWdh2oagqPADkv2bzPyCdOeedV8FL9lqEcNWLhUdfD6FrO0x6G7R3V6ACAOMjE
         VhKYv7hmbfsAJm1eRPmh2N60hRdZIKYyraAqoON8YMEtsQ3FQvWiD6iEBsNQ2fGKRYuR
         QRRJoq/5UZaXEVFjx0waz/cG7ZOT9JoAVqNaK1kY3qTY95KVRZgfhI+N//Jn4vKA1PZ9
         /IPg==
X-Gm-Message-State: AOJu0YwuS/MPq1N6PRP77JCTzSODKstbdx4hsW40tJhJWOXVGNz3yOeV
	hJ0OGqPseTQLxDZQRTQl2Mon0QdLiwbB+KRqkQ/SseRNkR3A7UlS94SKN5Xi8w==
X-Gm-Gg: ASbGncsMSBwUG8+LvmxYjYkbZYzQ6SIzwK8hh7wdQ2dPi+QSKMx/T/I1qKv9aaWcB1w
	NpbShYbkX2ravfi3dkZN+gWhM94xh62Z0lQHGQN6sqCRMtqLKcm1ZDZcpFTJRL2KVZwfXy8X8vo
	VmaTt/60vAEG73gj0MUk17X1ejxfMdeR/Cij/hhC/D23pqsOIt1/dt4Juit0ZPIbGJNPe9xDkjh
	ATNUbVdSDufrgEZjD8Q8WvH8umCup0yO78Xf8LxxYnt0BStKpBYsgZHF7bqI50z7tGGvgAMaRDh
	HByBcmk02VyOvdWYyeD5GymhA8P9plpACMnRvAAuxwJYVGugkwsU0gik04GHXNvh9VSzfcTTcQf
	LXAEQuiTIM8GXhbc3Zyr9v8u6FzeoWYzeKiIsir+FH54wo6R8riOeLgL01bGltgUOGaqkhTCtjX
	GqbIAf5khYJCcCBZZkPQUm+cOYEHq8CzEjpBUdUw==
X-Google-Smtp-Source: AGHT+IGuB/VB6sKdsdIJLryUCnbDbDEr5ucYqlOAO+Rxg4lhkaXlPLYt7lOInmpiv3ym/DzPYwaUVA==
X-Received: by 2002:a05:6a21:6d94:b0:249:3006:7567 with SMTP id adf61e73a8af0-334a8607433mr30211682637.35.1761164587609;
        Wed, 22 Oct 2025 13:23:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8b82dsm99075b3a.50.2025.10.22.13.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:23:07 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	xiaobing.li@samsung.com
Subject: [PATCH v1 0/2] fuse io_uring: support registered buffers
Date: Wed, 22 Oct 2025 13:20:19 -0700
Message-ID: <20251022202021.3649586-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for daemons who preregister buffers to minimize the overhead
of pinning/unpinning user pages and translating virtual addresses. Registered
buffers pay the cost once during registration then reuse the pre-pinned pages,
which helps reduce the per-op overhead.

This is on top of commit 211ddde0823f in the iouring tree.

Joanne Koong (2):
  io-uring: add io_uring_cmd_get_buffer_info()
  fuse: support io-uring registered buffers

 fs/fuse/dev_uring.c          | 216 ++++++++++++++++++++++++++++++++---
 fs/fuse/dev_uring_i.h        |  17 ++-
 include/linux/io_uring/cmd.h |   2 +
 io_uring/rsrc.c              |  21 ++++
 4 files changed, 236 insertions(+), 20 deletions(-)

-- 
2.47.3


