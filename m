Return-Path: <linux-fsdevel+bounces-71913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C307CD7863
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 01:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4983C3074C31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDAA20DD75;
	Tue, 23 Dec 2025 00:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9Lrvj3V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBCB1F8AC5
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766450231; cv=none; b=OByEm+LXb+3nuvDf7qBWuy1/1t7vpXVGWAbYab7kfpiBPWiWHffXHM92o7ltnjNhVphbousYCFX8fXrRMR7PDrl4o9VkzeoIHQX+c52Aj54sQgJlIbHltASWjvla1at9wqTDxlaKb3//01iYsF78j/oZTah6VE/AKogVk2Ek10s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766450231; c=relaxed/simple;
	bh=V9juZQv6dZ0gT/KwWlkT+L4ounPrVhIWYnGjGMKnfLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkJNrO7U2L5xAwUS9+24rlnmScO9WkAdZX/Qw1GO1Htt9Pjdi3t0ijdpVHKWSXdgpTDYFvBdFRe1382XDA6nn0QZ5ETpgezis7W7dgJmxGP1sIYIE4Pdm5OFPPrEB8MnR/Xxw6ueJfwxWcKfsiMMLUbnAlQRwh95WYKk0L96BZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9Lrvj3V; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a0bb2f093aso46446945ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 16:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766450226; x=1767055026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCUvZ2hYYQ5gvK1i3te6jPtSCGz2KbW6xvKvu1HTms0=;
        b=f9Lrvj3VdwN8RvnOfS5XqQqwVMqzOGl/Mg580kcO+jR223sixOVqEFYsMJ4ShEkmZU
         CPs6zj2zgBT/4ZnUPR/fQDAbyc/JfQiUg8Lbag6+PPcsGbQ8DrcrsFp+GkZbSORBYOOx
         TTTJ6v0lchYXyQQsjPXlAZ9YuCbWInRQ+xZClYmobMGTtwNZiAayD5YkC1d3nkIgWgE+
         YFCnT479r1vF5TlreVClxUs74gfs/Pu03MnbjLBv7V/1czVt69vnXfgp8xoqSKnK+fxP
         BBxbaqVdtH0AdFTcEwOuI+oWgKRUCweQ3GNDD8skj0dOzpmkwXRKQUfR+FOgPylXmYIH
         xKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766450226; x=1767055026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rCUvZ2hYYQ5gvK1i3te6jPtSCGz2KbW6xvKvu1HTms0=;
        b=orUjuebG2JnwhDetljMgL0aWxEucQxDpV8XedERvymljlesRliScp/9Uais/ao1TuZ
         0Tzy90OY7LaPx7ciDlNKFgpI87ic0oCSq8CuLiqvsH2QM08k+CbFmG5LwKPG57RopAQ6
         XjoZ+HeqFRqTx+Ty2bsVijqjkcflcZiahOB9ReJ0pZYX+yY8dE5kC/179fZ6rlL7PsMT
         TamIBc1hi2pdfogOFiBNLQV0KE1LdLGptOtyxZe7oXzMtUWaPt3X3I/Bc3YGMDXkHhsk
         qpSE2FeESJ+oi58s2V7Js1FzxXk8LcKQfK6wPhSXhbWEqAvUvN4+003mlsxZQqa5ePFi
         tJuw==
X-Forwarded-Encrypted: i=1; AJvYcCV9V+g66BLYRQpnkIYwaGhmytfJOQLG7ZTLGE12bCWwJTNtDYdAjU5IZ2QRJBCV9EjUjSlPj3fbA7Z9yDj5@vger.kernel.org
X-Gm-Message-State: AOJu0YyA6e7iK0xKgPwXeRH2AQ/A7Yz0STd9jgvQt2LH8qYxLbEJQMZG
	S3Q30zWiwbHBR1dwTXqkE8I+acjjp22psToz5LyMuNmGhxIojrPxpCwn
X-Gm-Gg: AY/fxX6WCva5F3Ap195hXd3EgxFEn3O1k2HAmAKqY7yNnQEjvi+63B4Le6OcnE4jsTf
	W590jK+b483Yx5dYpK3mL27ncnjtkYvmnmcv43zlAYoko0/2m/fPr+nxzgaJ6xPzQdk5if3IHIb
	FkB+lxdLxvoRbkzmBpQwnFXsMHkvrY4517BOy3e5h3ZMFn2iy5sqNuame2DxU8j66GzMNc5Xn2Z
	7WoWTyZenlgd6ZT5+cW1WUSxxXZnLAWLItHOsV7ZQB6MIxvYAspMEWdqy7bXTKF1Q6yT4s/xnia
	oca083PwzzhIbu/xjmtBcMxUCyssrcZSRke74D9LtqgP8jfpO/nXXJjekqbNObo7UqBof/7m4+Y
	VzmuL5Xehuxlx9HBF+6PFuPVY6GXDxXnLtg8BXOTguFP6KpWLY10N+wxBfPK6ICBKX500+u/ZvC
	rl7DpGgy/tiPQxSalLJQ==
X-Google-Smtp-Source: AGHT+IFftGzbyJITZRwTiogWB1iGE2OWwoo0gCJmAcRStQQSlZUaefzcMueff6dDDiVY9mAkb+gFhQ==
X-Received: by 2002:a17:902:f60c:b0:2a0:8966:7c94 with SMTP id d9443c01a7336-2a2f22262e1mr121277385ad.20.1766450225693;
        Mon, 22 Dec 2025 16:37:05 -0800 (PST)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d3e1sm107001945ad.76.2025.12.22.16.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 16:37:05 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 25/25] docs: fuse: add io-uring bufring and zero-copy documentation
Date: Mon, 22 Dec 2025 16:35:22 -0800
Message-ID: <20251223003522.3055912-26-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251223003522.3055912-1-joannelkoong@gmail.com>
References: <20251223003522.3055912-1-joannelkoong@gmail.com>
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


