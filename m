Return-Path: <linux-fsdevel+bounces-74274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06528D38A43
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E82B30C2049
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B72A322C7F;
	Fri, 16 Jan 2026 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4kpSA3o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9DE320CAC
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606311; cv=none; b=fkE3q3WJDvhhpqOj6UMwr6ve6smr9q3sRyyfv3eCmgU9ctePl/rugn192+qZyL+NGu8WGFxEkzkzU1lH79Ki2Ty+OHjLa+lrsbrhqGhc14zhOkTFeUQ7exMSJHgWuuhS9Z3zxh03t1pl9lCigr9yMyC4t+nLOVSpSIxOkwDQQ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606311; c=relaxed/simple;
	bh=V9juZQv6dZ0gT/KwWlkT+L4ounPrVhIWYnGjGMKnfLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CztzAvNeTQhJ83Vy92a604EG/6azYFDg+jiiv48+Gn/HAekPwc/IZsxUWv78VLdU+jKfzU2lqw8H1baSj5fIxRqdPIFPm9uNrfipwQMsJ9UGlOvbTWvbnNGViDVHA4t2T26/9IpJ5b6u+MyO/iBXgHotH815iJ43feW+rkj5hUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4kpSA3o; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c56188aef06so1089658a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768606309; x=1769211109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCUvZ2hYYQ5gvK1i3te6jPtSCGz2KbW6xvKvu1HTms0=;
        b=d4kpSA3o9Yrdo4ohji9aCTvxuT7CnPC95GctmXCAWUwdBbb43Bz74AIOkmG+fywXfj
         FjnVKUm26tCfWvVZc9VOcJKHOuN9GcT3dKUiAxpnXnFb00EyHyGy52ucHYM1ru2c4tiE
         80DOymDKATv1uSkZwQmjsPRETmGMx/ZQHdl9Y9K1M37Zf/X4mE8vLbthZGgvo1HzW/9d
         B9TT4+oWeZpMa2DuA2Gb9LpbYlgIfSfUXGMPm/+NdszNplKVzzA6r2+4TeHH2sS3B/Jj
         h2Ko3wefVREnPcM6slj/CX6TDf5ev6Z6YokkXYgObHmohFPFmG+kHzxRtVTHa0TQ8eoN
         Ilyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606309; x=1769211109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rCUvZ2hYYQ5gvK1i3te6jPtSCGz2KbW6xvKvu1HTms0=;
        b=Ky1g1Lk0+z9lx6KUDimo2L6LIsifCt7Bi7h97+NN3Wx3QEycBMJ6ghqHdgzY1Gt+NI
         zQWO/sc2/BW4CjdKmhVoNFbm6SCunqD0WNwArtkRrrbsNRhfNSWRDsEVQQm/wZnvKFD/
         JAoNMjklgDnv5D/MmqJJo5rUB4SjmhcDODNjjRHMr/fYxRLFONuiGaqS5hrfHlCvMiPz
         vt6AWNjSi/GKtD8X3ivnv1RLgQtMZr8uUYgdP8KjLgL75Jcg4QZURTzB97na3SdXkj6B
         yz4hbegPz4JR+B62XzsmrhwxSHZfVCPIVpJDgPzFBoHSLGeChpR3VkyZiq204DI18tAc
         vhsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFwg+NmPWOzVePWOkK+nMs14wJZ5Pj7N3Ihjp+ulLeETQ3dV7X5TTffzIW17wy+4mvB4uYG7vHvyWlW0ow@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQKegZ5zg8tmmCWJsKTCvpAJPa/KK9e5lbN9YS06Ziqofj1Wo
	ZrPi1BPoeJWoET9XiJN62MMqrTBtabQcem98GKEceV2GAzZOZrDyvb+d
X-Gm-Gg: AY/fxX7VbSpFyuXOSBuKcSpPcFtpNrFx0xS2YhsRzkVj9QyUZiMpIHbLjvVSFogutrK
	7ZWXVDeIoKTGxs25a8HEn0WUOflTNuLpBIzAGwYlSkgXEl2T+WTsgtMCGusLwFiRjGGGtvAIe7X
	Kvgm5c28g0hlT8ZANJk3+KR3uRFLAdVVJMG7GiL+03mFO/f3xrB8WZh8vdPHPMa3z17+hbo3X4r
	aNzHvCUcoxuFoF/bmKpOeWdzRxARH9+r/iEdFCOKUMcIX1m4tykgb7oG0f2xQFZLwl3TBgTzHSL
	EDzQ164ZwBLK6HU8iynNLW+qTDGSGFIJs6hiU4FNmmHYVZ8w2J5PQmVCOrp1Zx/p4iyRiDe7yEc
	r7eKv1Q24wfKib4rM2PYBQ85O946fGhMDtbjA2qmzGtMHbUPWeBesGQENenAsE4QzfqKxvvfryv
	Bx5Vn5eT/lL3D7DwcA
X-Received: by 2002:a17:90b:5603:b0:340:2a16:94be with SMTP id 98e67ed59e1d1-35272ef6716mr3512884a91.4.1768606309107;
        Fri, 16 Jan 2026 15:31:49 -0800 (PST)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35272f4a9a1sm2947963a91.0.2026.01.16.15.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:31:48 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk,
	miklos@szeredi.hu
Cc: bschubert@ddn.com,
	csander@purestorage.com,
	krisman@suse.de,
	io-uring@vger.kernel.org,
	asml.silence@gmail.com,
	xiaobing.li@samsung.com,
	safinaskar@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 25/25] docs: fuse: add io-uring bufring and zero-copy documentation
Date: Fri, 16 Jan 2026 15:30:44 -0800
Message-ID: <20260116233044.1532965-26-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116233044.1532965-1-joannelkoong@gmail.com>
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
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
 .../filesystems/fuse/fuse-io-uring.rst        | 59 ++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/fuse/fuse-io-uring.rst b/Documentation/filesystems/fuse/fuse-io-uring.rst
index d73dd0dbd238..11c244b63d25 100644
--- a/Documentation/filesystems/fuse/fuse-io-uring.rst
+++ b/Documentation/filesystems/fuse/fuse-io-uring.rst
@@ -95,5 +95,62 @@ Sending requests with CQEs
  |    <fuse_unlink()                         |
  |  <sys_unlink()                            |
 
+Kernel-managed buffer rings
+===========================
 
-
+Kernel-managed buffer rings have two main advantages:
+
+* eliminates the overhead of pinning/unpinning user pages and translating
+  virtual addresses for every server-kernel interaction
+* reduces buffer memory allocation requirements
+
+In order to use buffer rings, the server must preregister the following:
+
+* a fixed buffer at index 0. This is where the headers will reside
+* a kernel-managed buffer ring. This is where the payload will reside
+
+At a high-level, this is how fuse uses buffer rings:
+
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
+
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


