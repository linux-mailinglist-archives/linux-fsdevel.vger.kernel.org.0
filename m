Return-Path: <linux-fsdevel+bounces-44856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CCCA6D474
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 07:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959A416D96A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 06:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A008204F62;
	Mon, 24 Mar 2025 06:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LpvXYy0x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619A32054E8
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742799216; cv=none; b=K1hpDMIDQTiBGjI/G6F4jMKrYiDO5NDkD+TMjza27XN/69v6v+RNGchsU6gNfiQwvXPzalJdyx1MkgnzPbIRh4hsiLOYKXaG/pCe92zVQtvjKadDaaWklhV4IWhJfSfiuU0Xl1ybI9A2Jbwb3CM+Wmb08Diif9rTrZGuWe1qT08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742799216; c=relaxed/simple;
	bh=6Iry22bjOWQ1AjPaz9MRQqCkIqRJczbOa9UlGPD4ElM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jye1ioImaKpUtHlb05hzBbwenN7nH9HQc59tyWYlEyma5AinyLO9IbgAjObKvnV6x5VImKexVkY0oK5oOftlGJHYf8NAdKLJhVAwRCnXNIoOOQja9fXKl6+Miocz+ZFEZ/knuOYhB4vUO/XeOrfm1fjbKPNjjmi98uqzcHoWChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LpvXYy0x; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-3fab1478893so1052832b6e.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Mar 2025 23:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742799213; x=1743404013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mHKQPGagMOpPzVXkQrg+YdchEGJ0YJ8P2M6qhZ6IcLg=;
        b=LpvXYy0x1/rlGCWEvwQJRccgpccdpNxLYJJa0AaN/K5VWbmXhypizwu7ZTMHZJzIDn
         nG6NcLodvxmOlHTwSPQVkQm7/rVW4WbUobSjFghcd8HqpqO5ie5Lb9vgSrXjypHJraOT
         decivjcIWv8u1Vx1MI6S6v3kmQjJX1PljRuDOo/JHS09yCphHhc/p1QgMvdEqztIi1Hd
         4hO1fA5tr4HZZU7QzY4XwCxWraJWyjlva/VOLH68fllrXWWS7Wd9h1LV3KRl1AS5ZSNF
         uRWa8SPWW4IV1STsWfSp0KnNPFaDM+3IZiTlWYPBrMDqARTUaiSJG4LFUa5H6WdGPoWx
         0FZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742799213; x=1743404013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHKQPGagMOpPzVXkQrg+YdchEGJ0YJ8P2M6qhZ6IcLg=;
        b=uBKxSvRinmJ5uEnYFX6yF3Fmy0QMqwErP9wkJQRvrK/RsZ1irUadgtMiMfcCcoRfq5
         oYgM/590rM8luf+YxHX0StXM/M6M3MLDMPnBr39dyGeuk1fY/yHiK0C5+CkCsxnceNJL
         vI9p72OuGw3LlH7/zAwywHDVuBHyzEW1XTow++X8nyqPpvLGzcO4g+90iZArOYZyfsCS
         a27owcXrlcw5t3rO27qTK6WWOP6JyYkOUz9J5h1P3/mXTbO/Vv48i4TfAjNOyLCQCQTR
         QhXX04wtKzgrYWIDQD460MrPBGnvA65r0gVW0t4RujpOgwJ2Zs9gZT876LoPHg7Hc4mH
         gvNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhwIEJWcj48R5DGTeiZQ4Rx0ctPOk38SFJ8le/EtZEcPoUD+P7meceAG3EeVos4ZC8W0ikT24t+m6DmqNX@vger.kernel.org
X-Gm-Message-State: AOJu0YxowI2933DEg7oUcnbI5upsm1Sx3LCzXdWBsZxc3+7l2k2PtyX9
	orCXwyrWwxmz6riYFEVWx8rtEBRmVfP6Th8LfXkHtJ1P2i6CGwUKUwnUJKkWK46vL28c/mkpteR
	0wg==
X-Google-Smtp-Source: AGHT+IHdUZdDUihniNDxIj7Y5cXrzFf0YBkU/hlZx14R7lVEo/UwEmOdH9bM8gXluf4n8aUSHGMsn5H0BYM=
X-Received: from oabry11.prod.google.com ([2002:a05:6871:208b:b0:2ae:bdb:eb0])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:2813:b0:72b:919a:fa96
 with SMTP id 46e09a7af769-72c0ae465f1mr8859493a34.5.1742799213422; Sun, 23
 Mar 2025 23:53:33 -0700 (PDT)
Date: Mon, 24 Mar 2025 06:53:27 +0000
In-Reply-To: <20250324065328.107678-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324065328.107678-1-avagin@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324065328.107678-3-avagin@google.com>
Subject: [PATCH 2/3] tools headers UAPI: Sync linux/fs.h with the kernel sources
From: Andrei Vagin <avagin@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	criu@lists.linux.dev, Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Andrei Vagin <avagin@gmail.com>

Required for a new PAGEMAP_SCAN test to verify guard region reporting.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/include/uapi/linux/fs.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index 8a27bc5c7a7f..24ddf7bc4f25 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -40,6 +40,15 @@
 #define BLOCK_SIZE_BITS 10
 #define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)
 
+/* flags for integrity meta */
+#define IO_INTEGRITY_CHK_GUARD		(1U << 0) /* enforce guard check */
+#define IO_INTEGRITY_CHK_REFTAG		(1U << 1) /* enforce ref check */
+#define IO_INTEGRITY_CHK_APPTAG		(1U << 2) /* enforce app check */
+
+#define IO_INTEGRITY_VALID_FLAGS (IO_INTEGRITY_CHK_GUARD | \
+				  IO_INTEGRITY_CHK_REFTAG | \
+				  IO_INTEGRITY_CHK_APPTAG)
+
 #define SEEK_SET	0	/* seek relative to beginning of file */
 #define SEEK_CUR	1	/* seek relative to current file position */
 #define SEEK_END	2	/* seek relative to end of file */
@@ -329,9 +338,16 @@ typedef int __bitwise __kernel_rwf_t;
 /* per-IO negation of O_APPEND */
 #define RWF_NOAPPEND	((__force __kernel_rwf_t)0x00000020)
 
+/* Atomic Write */
+#define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000040)
+
+/* buffered IO that drops the cache after reading or writing data */
+#define RWF_DONTCACHE	((__force __kernel_rwf_t)0x00000080)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND | RWF_NOAPPEND)
+			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
+			 RWF_DONTCACHE)
 
 #define PROCFS_IOCTL_MAGIC 'f'
 
@@ -347,6 +363,7 @@ typedef int __bitwise __kernel_rwf_t;
 #define PAGE_IS_PFNZERO		(1 << 5)
 #define PAGE_IS_HUGE		(1 << 6)
 #define PAGE_IS_SOFT_DIRTY	(1 << 7)
+#define PAGE_IS_GUARD		(1 << 8)
 
 /*
  * struct page_region - Page region with flags
-- 
2.49.0.395.g12beb8f557-goog


