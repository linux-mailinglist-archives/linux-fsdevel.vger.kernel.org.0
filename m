Return-Path: <linux-fsdevel+bounces-70524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71677C9D724
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 897A634B220
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044A6221265;
	Wed,  3 Dec 2025 00:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQ8GBVNR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D28212542
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722242; cv=none; b=n/wx6bXfBZtrgvqRfNTj3B5WriBxChUCZLI6Ob1n9Lo9AwG9FE35GNoZ68FET1o2ocSCw9AvPSIpaqihD1Fi1LncZPH91auYHu5o1SQ4CvgITyhSMxUX2UqkNkh2h76TQwhe/xkCLFi6B4/PY6U39jQRe/n1dewfCjs/zF4RKKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722242; c=relaxed/simple;
	bh=RRRVmnuSlO2yAUlxwC0oPD9059AuiV98qY7YvSV4HJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXBaNuo8t0YrWmky2nP1hidnd/jN3YyL/qRQ+Q8DoTsbNNpoRgnACbCIJb+ziLN5yICrCVb/nqqPELO9Ejc4jmClRrb9dXBkO1xVYHXmU+ab/1uFCZhGF9fHvi3ajmk3djS/IxxSN14zy5kBoZ6MRwxcMAXnJ8vxG5QU2Ts1ZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQ8GBVNR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so7352193b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722240; x=1765327040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EG2G6U8pfCC1wTS9qAldfTiYW8GZ41ecBEhlt3Vx2u4=;
        b=NQ8GBVNRrkrZLE6POSgF7hyGm6OnJMecmdjPZt7XwDaj4ZngBf9MDAlSZ+jPe87Wfr
         A5/CBIQ6Xm1Qe+QhnNd+zvgRqXrSQgAMlculonHMR0UsTpgIhMDXv+DifCrBJEYC3jHw
         gXTfP4bm/qOqAIzr3dW9EJ7Yf/3kKKyklkUlSxI/ubxzbChVyVULzfpzpZljlIdWkic0
         lwT0UuKSxJJfjvdGDygvVp07x+jtHSBR+jxMFCMUULW3ARMfOu+mrCYO048RvEL4KAGk
         DeLdFe8Y14VpNYWxj/zSAyqrojHZJgfZytzbyDceohQYWHr9F1J5C3q2k2FnW6Pvq9i1
         ok2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722240; x=1765327040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EG2G6U8pfCC1wTS9qAldfTiYW8GZ41ecBEhlt3Vx2u4=;
        b=xQ8JvPUYDSgOhhR80dPP63+Iap9Xhuos4a3xl8rnfG4h7cEwyX/6NLxaIMUB9JMRIh
         fprPwWABLw7dQohEpPI+rc01V63IcoH7D8x85pDCzzCvPKdGa13TVepdqL883srTeQdC
         HTQs+m5WT6Qn+ODr8ccNLFKSdng/VkmHK66Abk4LOamYrluZq9yxlMNT8DcSysVxULkR
         SMJSsDKHfH5OScjhELq+IrFwPDIqCdW5wARctMWWvSGa5PsAeRofOA2D7Xi8cL0fufUy
         wOyIGB6Yw+ezcxQr72eenrckPYhFyfgw9yX494UwmapzOL3K1pBXSd9QF5EOkTKjvWQT
         ImbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2Es3ATpcVNWIz81ptOR26qjknDY4WniAXoL/WNYAMpnf4EIojuVXJHtUmT3gLTpbL/vrmhiBWLX76qPIP@vger.kernel.org
X-Gm-Message-State: AOJu0YwklA8pKinWbrx9SvrTRu07jLFa2b5rhJhX3Tw5t83doFLyhfWE
	kNzFvHk8DH9ioWGdztBtb4NEmf7P5EBR6ZP+cg5uxycuQpGvlxV5iUEl
X-Gm-Gg: ASbGncun7IPwYlN6hyHS/NeRw+FkqcHrJ31nSft3u5fRxV5vlo9RHL2H4BVjPb3uu4s
	nOeSaHCxsaKbOZZ8pJgFHDyXemIymxpjgImgw8NLCPkT6AmaGajIMbaWawqFaSsjRUV4o+v7eJh
	puQsA/OmWwbAq7ZCYPl5SPSyHGeGW1lMdW1pluLHMRgb+oDg5KF2G6o55pcK/rM9lFExssBS4TQ
	lzpmGPSl0/685NDUy0bsScahpHL52U0o10sCv3pa96O1al1gC2MGASmKUbPNHt7ug8O7vJw9ZkR
	WrunC8OCu+xjv79qNGlnME7jc406DjC6ppgikecM70k5MiG/WTvdsS71MRcAj9gJNoZ1mzQ3i6d
	EkiQ0XywytadLdhKVgYFt8zsrq1h1nad625v7RC7CpLDbkFIlKdnReCq0OEHnmDgFfPWXneiDDz
	+UdepIR5+Z4niZ+JhVTO8iK0iZAZpA
X-Google-Smtp-Source: AGHT+IEflUnue+4P0QQ0xgarlCKeNigyt2dqEt8BoputBM87r7zg+mnVlp/6Yl4h+pAEW2HDBx11mA==
X-Received: by 2002:a05:6a00:3e04:b0:7aa:2d04:ccf6 with SMTP id d2e1a72fcca58-7e00453e088mr447884b3a.0.1764722240346;
        Tue, 02 Dec 2025 16:37:20 -0800 (PST)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f457c38sm18031924b3a.54.2025.12.02.16.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:37:20 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 30/30] docs: fuse: add io-uring bufring and zero-copy documentation
Date: Tue,  2 Dec 2025 16:35:25 -0800
Message-ID: <20251203003526.2889477-31-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203003526.2889477-1-joannelkoong@gmail.com>
References: <20251203003526.2889477-1-joannelkoong@gmail.com>
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
index d73dd0dbd238..9f98289b0734 100644
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
+  virtual addresses for evey server-kernel interaction
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


