Return-Path: <linux-fsdevel+bounces-33031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC7E9B2109
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 23:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DE22813F8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 22:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4608189F59;
	Sun, 27 Oct 2024 22:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pG1rNBNQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFAA14BF86
	for <linux-fsdevel@vger.kernel.org>; Sun, 27 Oct 2024 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730067823; cv=none; b=ADgaY2JBzjzqSVo+WGprP+KLZGn+XaWLK/byt3vh5w6YmgVGOv8sQ9Xb18b3Siq0XZdHN9azxxDeJBj6FbrXgu2D3NNM3gnTs0Tz19HqdrlWP4o3+diFtd+51GT2P/QmoNH7tGp1d2dOovPbG30NyzY+0SS6uzPVGTFixfSRRt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730067823; c=relaxed/simple;
	bh=Az/6E9Bz3pDkSLhUuGM6XS7I0+/lN+5RjptLOdn0Z9A=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=gqgoKbifdDGd94HEx9+HYdZlo9jalfIOI9yoBv6nlINGSeGQpODTlz8ec8pYv07+J7NXGUAk8HHv+9FiAa4v4GRc+Vjtj9fV8MmU4BZApB8gwHWhxT4NaT7svB7ceYvob27qnmbSu1GDpzuR+7bsWLeqcbDHvBTxUgKQ+Gq+m7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pG1rNBNQ; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-718065d6364so1816977a34.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Oct 2024 15:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730067819; x=1730672619; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+XkdkUsBCpwU48QmXXg+E+cbuL3jYIMICiO/oJZ7j9Y=;
        b=pG1rNBNQScLQ5yWDMpSwoafspz6IVOs7+0h5/bpxDrJmNu9fM5RsH0JgFnXfPU6PSH
         XiVQQGMXwrNUoeJmsAoLKyz049wW8EtXO8FxvUc/7kwyLg0wSdfRWuqnwAVQz0oouuDu
         wGfQtEt4S0qgp3vxtUpnKkuZDdL0UjAYbCXFKO1VB6J03NZVIxLPSg6tHTE7qExijqHO
         yTcyuuRBn+NOQzb6aBzO9iAgpvVSxF4i41U8A7qJE1N9yUWIuqCMVsrLLFpIqJAaAg09
         ygLmear3kRv6+BW6fAVLGS5MLqIUcDN2DOnCpgJanqxM6RVE0DPvNHcm/THaEru1mvoH
         Or6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730067819; x=1730672619;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XkdkUsBCpwU48QmXXg+E+cbuL3jYIMICiO/oJZ7j9Y=;
        b=h4g9BOKfSxTCUdPJhZ/8zmRlpwP/xXD8y0k9vXrH0/dFiIeT6+DUD1MoPar4Nw7CBp
         oTpx8s0U0xLIM4ymmB2gzTebiThOOmuIxJVIPCOkndgpwdsW3pSFQIGhIR3W7rHVkn1h
         Eb0THUJ/TMF9DbZtZ3CeJXIY/p6jBRUCabPNO79u1kVtZS0/gwsoMk3ncXTq5VdQXMRO
         rrdMgCAtYXwUQinRCK03YVIJHy952ASKmJTVjPq5um07t2MSZ3T56oSnWq0imCcGlV4Z
         KV63+2ywCJoldknyBQwaF3bxs0EuTSFmCWn8GUMnPi1ZzX+qRiyP9wFEInu+nyMWGhHR
         /yTg==
X-Forwarded-Encrypted: i=1; AJvYcCXT71Hw9Aul2/z1cDulJowBPTOOAhjLUzO/ZKtlyEU81OTDoGUnsaZ4Gvb+zotax1TduNsPyWRSyAomYUwx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Rn8tODCH/ezWu6mTrUU7IbzKbwiqDvlqvEoz48fxTpCoRPG8
	q3jbn/dVaky10uBKxxyVP2oHf9pGdgPh24+ANyTD0FzNF5sl588AxyijSKBcPA==
X-Google-Smtp-Source: AGHT+IHWRKvprk92gXrSyzyMGO8sYq9D2+dQAwzgUyL9Up++6xFGJPIJrFUiroBsPDyQ5b0RA039+w==
X-Received: by 2002:a05:6830:440f:b0:718:118d:2bf6 with SMTP id 46e09a7af769-718683256d2mr5142266a34.23.1730067818830;
        Sun, 27 Oct 2024 15:23:38 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec186fd35bsm1389857eaf.30.2024.10.27.15.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 15:23:37 -0700 (PDT)
Date: Sun, 27 Oct 2024 15:23:23 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Christian Brauner <brauner@kernel.org>, 
    Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>, 
    Kent Overstreet <kent.overstreet@linux.dev>, 
    "Darrick J. Wong" <djwong@kernel.org>, 
    Thomas Gleixner <tglx@linutronix.de>, 
    Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
    linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: [PATCH] iov_iter: fix copy_page_from_iter_atomic() if
 KMAP_LOCAL_FORCE_MAP
Message-ID: <dd5f0c89-186e-18e1-4f43-19a60f5a9774@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

generic/077 on x86_32 CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y with highmem,
on huge=always tmpfs, issues a warning and then hangs (interruptibly):

WARNING: CPU: 5 PID: 3517 at mm/highmem.c:622 kunmap_local_indexed+0x62/0xc9
CPU: 5 UID: 0 PID: 3517 Comm: cp Not tainted 6.12.0-rc4 #2
...
copy_page_from_iter_atomic+0xa6/0x5ec
generic_perform_write+0xf6/0x1b4
shmem_file_write_iter+0x54/0x67

Fix copy_page_from_iter_atomic() by limiting it in that case
(include/linux/skbuff.h skb_frag_must_loop() does similar).

But going forward, perhaps CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is too
surprising, has outlived its usefulness, and should just be removed?

Fixes: 908a1ad89466 ("iov_iter: Handle compound highmem pages in copy_page_from_iter_atomic()")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org
---
 lib/iov_iter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1abb32c0da50..94051b83fdd8 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -461,6 +461,8 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
 		size_t bytes, struct iov_iter *i)
 {
 	size_t n, copied = 0;
+	bool uses_kmap = IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) ||
+			 PageHighMem(page);
 
 	if (!page_copy_sane(page, offset, bytes))
 		return 0;
@@ -471,7 +473,7 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
 		char *p;
 
 		n = bytes - copied;
-		if (PageHighMem(page)) {
+		if (uses_kmap) {
 			page += offset / PAGE_SIZE;
 			offset %= PAGE_SIZE;
 			n = min_t(size_t, n, PAGE_SIZE - offset);
@@ -482,7 +484,7 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
 		kunmap_atomic(p);
 		copied += n;
 		offset += n;
-	} while (PageHighMem(page) && copied != bytes && n > 0);
+	} while (uses_kmap && copied != bytes && n > 0);
 
 	return copied;
 }
-- 
2.35.3

