Return-Path: <linux-fsdevel+bounces-71652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C47BFCCAFC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 09:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A87AD3004CE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 08:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A4933556B;
	Thu, 18 Dec 2025 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cazEQAes"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA0B335553
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046917; cv=none; b=HcAtxn0WLRMH3g8gAtTMnjfH+kldHISTc/C+HThTbPmI+rlTLGCA3K/wp+RE0FoJitkhkncEAUwiCb5B3ukXHyhnI+m2rOxms3fm9RMdKwuxqFq8CwvIZYAImFlAlHTo06vjV9SIK6QtjRQZFQkLLhDo1WPBZA0FfF5I8mtNgas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046917; c=relaxed/simple;
	bh=INNkAtfdmZLhzOH8mhJ8Z0+QqXwu7xmZu04bxqhSxj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcwU007hAU8TxUG8U/xoCU+fXpK4qWzuNVN5FdjN5cjN+gu1hl4QwjluP0Se1hPI1IsMsoiuKxPjlhHgFkqXzgwOPGqETiVzFJlSQ77Ny9w/FSKXGM/mKQl70EVXsLsHnaiN1NCAl3GWBeK7tPIoIDAoI4LTKL+Qc/Hi8a2VvvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cazEQAes; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7bc0cd6a13aso245293b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 00:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766046915; x=1766651715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GH8NEID9VpaQqncoHSyH0Is0t17TVaTMSKnx7bo58E=;
        b=cazEQAesaafUcw9hF49+FF3cgeyFcyWKQIeMaUJS26/3KUrfaAekGVc6gIxo42Ycpu
         TPtp/mgwmzqC3QHHsyGaRiOCQ6J7zBsZO2idjyxh/+Mvx/rPbxD2NztpO8pmk6NJo90V
         qldCKx4qJ13swvN2x9qGikwvJH26KUQMJ+IC1Xj61BfNy45St/aP3HIT0nOueBtjnhVn
         Jyz9+IjU/uHJW/NcN9WgqthjYP+U9Kt1waiq/dVmi4wrGJn7MgzwgpbLKE86NvxzSAmp
         l+7VGCsMoRBDr8vavzo2xW9/iBD/qbsQlsiph1Q56HPi4I9SZgpLZlphBqKletsx+K0R
         OQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766046915; x=1766651715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7GH8NEID9VpaQqncoHSyH0Is0t17TVaTMSKnx7bo58E=;
        b=YkVXdBSXZwPUJuBV5JbDIyq/haD3lq3AzXv8hUqbZztXLz0K5SA9crQICJwbL8x6pd
         H5d2s/Xd6B4LkYExajdvDJU1xUYZQY49vZWd/CclVAZJmM04RjWWVoNdQg4NrZhaXOEh
         Vz0bRBCxV3qafWLcFFwr3Twp/1k4k9jtlkCQ1hkiWyn+g5X3q/7lBDk35gUqDcqB9Uey
         xOVM/b7amRcQXRZRLxp6mGvdcLyp6M/3T0dMuNI2QoQ6I6Kpyu/AIjWQRciDubmCOhcV
         GU54jLuNrJ4sm/pFZBHAkR/qDhTAGJ0501eE8x5J0b5iF0JnJchO4X09Plk6RxpkBUlz
         uCMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYIaEzLUp7VejTqbuurPCOk0cqwLb99pxYA3KOaxP1Pa+rDzknszTF+mGqnZYzKZ1yNxNQYr12KhSFIJSr@vger.kernel.org
X-Gm-Message-State: AOJu0YwNsMM8kTK4Ke6PtHK/z5cf6M/5lLxg7I2sTMMxcLGwZRNxUvjx
	CjKbPy2nqHFU6Xl3rA9alE9RQwAZI+FDBQcU7gXjNO4o46myyQhEax1Y
X-Gm-Gg: AY/fxX4CFoRnW7UwiaTm9zSYD6E5p+4E9hWJ75empOBKDVhltim6T3eKGfkTVlqZt+8
	iSwIpywAtFGr/njiV/cfLocaVRC+tuouxxHcTK1WDXD1Ch8o6FBdbSuOq/s70SyHfjOhE6oXB8m
	3tytfNgviWGs9BYxMuh0xRQLCqSQYQPJyzUlllXtXSWJcVPiwOh3ybSefSZLOedjVPPgp9ucCXu
	+i4bVCPn5rwRNxLg3RJGHWQRTEFvp32IKUrih9GYMvPMyHeLAmBoD2W2DRt+bG2nXQT4Iywq6T1
	Qq/1Vx8pGMC8SCm4+f5sTYF8kq/ItWK1d/zxge6bz6j34ycwKm4WO4nGJLrVBhvS5zl4QKmuax+
	C7f9hLb2uiZnpH6D07SHovQKUCCkWar68Q4imR+cwqxjfWFAVP2sC2EiL6WTv4Ywg4KVy7/ObKd
	8Rfz/edVYDedzLgKCi
X-Google-Smtp-Source: AGHT+IEw+Z2w5EjRy4XJU/e2knLhBGaGGn4kw9sOc6Bm+wqv+yTmKoUJlM400BpT7uHZlTjhixVGnQ==
X-Received: by 2002:a05:6a21:7189:b0:35e:8b46:c116 with SMTP id adf61e73a8af0-375516d4d39mr1802667637.4.1766046914957;
        Thu, 18 Dec 2025 00:35:14 -0800 (PST)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1d2dc9dec9sm1605853a12.10.2025.12.18.00.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 00:35:14 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 25/25] docs: fuse: add io-uring bufring and zero-copy documentation
Date: Thu, 18 Dec 2025 00:33:19 -0800
Message-ID: <20251218083319.3485503-26-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218083319.3485503-1-joannelkoong@gmail.com>
References: <20251218083319.3485503-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for fuse over io-uring usage of kernel-managed
bufrings and zero-copy.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 .../filesystems/fuse/fuse-io-uring.rst        | 55 ++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/fuse/fuse-io-uring.rst b/Documentation/filesystems/fuse/fuse-io-uring.rst
index d73dd0dbd238..4c17169069e9 100644
--- a/Documentation/filesystems/fuse/fuse-io-uring.rst
+++ b/Documentation/filesystems/fuse/fuse-io-uring.rst
@@ -95,5 +95,58 @@ Sending requests with CQEs
  |    <fuse_unlink()                         |
  |  <sys_unlink()                            |
 
+Kernel-managed buffer rings
+===========================
 
-
+Kernel-managed buffer rings have two main advantages:
+* eliminates the overhead of pinning/unpinning user pages and translating
+  virtual addresses for every server-kernel interaction
+* reduces buffer memory allocation requirements
+
+In order to use buffer rings, the server must preregister the following:
+* a fixed buffer at index 0. This is where the headers will reside
+* a kernel-managed buffer ring. This is where the payload will reside
+
+At a high-level, this is how fuse uses buffer rings:
+* The server registers a kernel-managed buffer ring. In the kernel this
+  allocates the pages needed for the buffers and vmaps them. The server
+  obtains the virtual address for the buffers through an mmap call on the ring
+  fd.
+* When there is a request from a client, fuse will select a buffer from the
+  ring if there is any payload that needs to be copied, copy over the payload
+  to the selected buffer, and copy over the headers to the fixed buffer at
+  index 0, at the buffer id that corresponds to the server (which the server
+  needs to specify through sqe->buf_index).
+* The server obtains a cqe representing the request. The cqe flag will have
+  IORING_CQE_F_BUFFER set if a selected buffer was used for the payload. The
+  buffer id is stashed in cqe->flags (through IORING_CQE_BUFFER_SHIFT). The
+  server can directly access the payload by using that buffer id to calculate
+  the offset into the virtual address obtained for the buffers.
+* The server processes the request and then sends a
+  FUSE_URING_CMD_COMMIT_AND_FETCH sqe with the reply.
+* When the kernel handles the sqe, it will process the reply and if there is a
+  next request, it will reuse the same selected buffer for the request. If
+  there is no next request, it will recycle the buffer back to the ring.
+
+Zero-copy
+=========
+
+Fuse io-uring zero-copy allows the server to directly read from / write to the
+client's pages and bypass any intermediary buffer copies. This is only allowed
+on privileged servers.
+
+In order to use zero-copy, the server must pregister the following:
+* a sparse buffer for every entry in the queue. This is where the client's
+  pages will reside
+* a fixed buffer at index queue_depth (tailing the sparse buffer).
+  This is where the headers will reside
+* a kernel-managed buffer ring. This is where any non-zero-copied payload (eg
+  out headers) will reside
+
+When the client issues a read/write, fuse stores the client's underlying pages
+in the sparse buffer entry corresponding to the ent in the queue. The server
+can then issue reads/writes on these pages through io_uring rw operations.
+Please note that the server is not able to directly access these pages, it
+must go through the io-uring interface to read/write to them. The pages are
+unregistered once the server replies to the request. Non-zero-copyable
+payload (if needed) is placed in a buffer from the kernel-managed buffer ring.
-- 
2.47.3


