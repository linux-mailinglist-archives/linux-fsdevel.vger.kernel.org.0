Return-Path: <linux-fsdevel+bounces-65584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AC0C08363
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 23:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C23E4E9A55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 21:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA7C30C358;
	Fri, 24 Oct 2025 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo7Nvpt9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75174261B92
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761342650; cv=none; b=cwm75vrT9UH9OMhvrFJFgjb9nC0fuVxAtDSp99vsR1UkRW2+x6jfejkjMEasJT/XoU6sUd6V+CEiayNLJZfWXHtJGBYWmC6gSRxGePkDIQwmTLuCcjaZAsIrIf5AeKZrwE3x3JQbWQ/blecx1sBFsC8bQbxkjEUfjVIGMOrLYa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761342650; c=relaxed/simple;
	bh=C+YSt1Wm1zrFvoVsTMFoVkHzx43Z4BV55qjqWucFEuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V9X4JUm/ps3MP57uoRVSxJjxLqt0W4KJl7WfXZ5qfVnzAG3Zp1c2VN21CgVZ1ZNqa8MyRdBQ4SE10Oi8wRgcXywjQCpVm+NtixVdFzJHM4J6JsTwPfAN64KRNDUK0vsOaCQ920KqnccE7b/V74K0fq5/aYnxnHB0MACy4AU+ZIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jo7Nvpt9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so32263345ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 14:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761342649; x=1761947449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ly4o6Ahqb3aLTI1RBg8HXSEqCpXgPNSSyHu010tGA94=;
        b=jo7Nvpt9hgEfXGxIkHW0pCfFEa8daZrdRPU5wmwqNC3tIwVN2HWbTxsBklJjQjcQQw
         1ZsW4gguwOAYQ2/kTHa7gJ1+EcBCR2zHqu0fac85AwnVQ3alBE8FOBIR5sXhjWPdOSbM
         H1bvta+ahy9erCaEN3kjeuA0/4BCOsUo5QfT4yB9PGUcIo6LogfoSEptvzr/0uoQyyrn
         rgo1JA8OPU2y8HRZpFd36/dW75L4MAa/wtUZaywmOM1ay0jHIdmbDX9//K4n1o4+f9HH
         ktCnuszgGc5FFptQs8dQjJMHIn8IfCBdgQ6nwcXPY9b6NKHLZj4vXnitY2AFXuEXLT9l
         FNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761342649; x=1761947449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ly4o6Ahqb3aLTI1RBg8HXSEqCpXgPNSSyHu010tGA94=;
        b=d/zEvug8aw3hGNaPm8UGjMcxgAzWQWyv2X9kzCgjdLbTn5ImT7qBJmp6BP8GjvEDhI
         A7xq9ywDcdhE0ESDYHQZ8ZMNcLjn9hSCTqawN4u+JV3NNFh7JDgGJTNt9YxNeEl96lZD
         bo+b3SY2ER4zOidU1esHQEeG6tngPLSTPB/V6yCMPsMrynqa8osSizuVjNpPkZJLuOP9
         6SkhpIgBml0NaOsdLVfkG+ySY70kZNWCzMbGsd3CAL5CHRcbOEGo0l0uwxkjs4GQqWL6
         68CJJ6zY0NHEmSXHnCYikdYsqXPKjs/iWod8BGF8Yfgvzlv3q/G/J+OxZB7Y5/OTdyo4
         ZcHw==
X-Forwarded-Encrypted: i=1; AJvYcCV9IdtJMCGG3YycokTjxOGLjZj348RZAU9o7KcDD9l3exhaANBiqBEgqA0HMeNLoKusJZhsE+wU5BRc5rvh@vger.kernel.org
X-Gm-Message-State: AOJu0YwOs5FCMyVfAt9H1Avcgl5OnmMKo0gNfAioJEcZTCSMAizd+7VV
	jF0FE9FqjNJo5YR14Fj/Ffl7iob44j4gPG+3dDt+oMrn6vOEdFGs5q3H
X-Gm-Gg: ASbGncvBm7mLGSNpRMciAo6vXSpcRWCazTxFRgBumBpGGpFi4YENW/pQMpR03/AXYJU
	Oz7WeIO18PXZrSW/c7zSC1Or1kXgx+eoyMb7o6m2TFHlOPJwwmtobqHtOBsi6RceFL6ZU8VZkK2
	VZTqM2RaDpfIygbjWw2cGC940xzd+LMj2sJ2kklHhQIZ2ZkaFqiTJSGNTqQM+ibYNqDsYEgGh02
	W2dtj1p4iI9PlJewmJvw9L3+/n2R/pXKIeQiWuyBcSyI90K0LZ0n1OxvyjQaQob67wJwxRkmjFf
	fH32D/MiDNiOlLXK5R1xmqNREKqO5A9Nw41wecMcJQvWNXRgn/Va+FDRXP51ostHu8HwXR76bfP
	UHAVeKPYOQ9rZK4QSqFvW6CBNCKqClwvxIKeYnUA+BFPDC+h4icmC5B27m/RqlVCMwD2yvRYTUj
	zXlV81k2YHpZkrdm4zG5TOXE4JyBaJbQmbi6qm
X-Google-Smtp-Source: AGHT+IHymsU8k4kZTIIAaBNNdfaDtw3rP2Av/p2q3vsXR6oogEyT4KuJTVk/Es/LwtFefepJIbonWQ==
X-Received: by 2002:a17:902:e54e:b0:269:4741:6d33 with SMTP id d9443c01a7336-2948b9ab1a3mr38481035ad.23.1761342648593;
        Fri, 24 Oct 2025 14:50:48 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0abf1sm2378475ad.41.2025.10.24.14.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 14:50:48 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: bfoster@redhat.com,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] iomap: fix race when reading in all bytes of a folio
Date: Fri, 24 Oct 2025 14:50:08 -0700
Message-ID: <20251024215008.3844068-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a race where if all bytes in a folio need to get read in and
the filesystem finishes reading the bytes in before the call to
iomap_read_end(), then bytes_accounted in iomap_read_end() will be 0 and
the following "ifs->read_bytes_pending -= bytes_accounting" will also be
0 which will trigger an extra folio_end_read() call. This extra
folio_end_read() unlocks the folio for the 2nd time, which sets the lock
bit on the folio, resulting in a permanent lockup.

Fix this by returning from iomap_read_end() early if all bytes are read
in by the filesystem.

Additionally, add some comments to clarify how this accounting logic works.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: 51311f045375 ("iomap: track pending read bytes more optimally")
Reported-by: Brian Foster <bfoster@redhat.com>
--
This is a fix for commit 51311f045375 in the 'vfs-6.19.iomap' branch. It
would be great if this could get folded up into that original commit, if it's
not too logistically messy to do so.

Thanks,
Joanne
---
 fs/iomap/buffered-io.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 72196e5021b1..c31d30643e2d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -358,6 +358,25 @@ static void iomap_read_init(struct folio *folio)
 	if (ifs) {
 		size_t len = folio_size(folio);
 
+		/*
+		 * ifs->read_bytes_pending is used to track how many bytes are
+		 * read in asynchronously by the filesystem. We need to track
+		 * this so that we can know when the filesystem has finished
+		 * reading in the folio whereupon folio_end_read() should be
+		 * called.
+		 *
+		 * We first set ifs->read_bytes_pending to the entire folio
+		 * size. Then we track how many bytes are read in by the
+		 * filesystem. At the end, in iomap_read_end(), we subtract
+		 * ifs->read_bytes_pending by the number of bytes NOT read in so
+		 * that ifs->read_bytes_pending will be 0 when the filesystem
+		 * has finished reading in all pending bytes.
+		 *
+		 * ifs->read_bytes_pending is initialized to the folio size
+		 * because we do not easily know in the beginning how many
+		 * bytes need to get read in by the filesystem (eg some ranges
+		 * may already be uptodate).
+		 */
 		spin_lock_irq(&ifs->state_lock);
 		ifs->read_bytes_pending += len;
 		spin_unlock_irq(&ifs->state_lock);
@@ -383,6 +402,9 @@ static void iomap_read_end(struct folio *folio, size_t bytes_pending)
 		bool end_read, uptodate;
 		size_t bytes_accounted = folio_size(folio) - bytes_pending;
 
+		if (!bytes_accounted)
+			return;
+
 		spin_lock_irq(&ifs->state_lock);
 		ifs->read_bytes_pending -= bytes_accounted;
 		/*
-- 
2.47.3


