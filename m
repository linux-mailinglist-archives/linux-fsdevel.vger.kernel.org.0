Return-Path: <linux-fsdevel+bounces-11214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E098F852072
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81AFDB242D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 21:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6421258AA6;
	Mon, 12 Feb 2024 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RjTPiwri"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E87758133
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 21:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774026; cv=none; b=Wb9H92J5rzfvIxsOZM6Arne2+uWGh91J5BiCnbQub2PXvU99EcdeIqUTLknEOUHXKeqnA2Ijnm7xo1dKhqTD6PJIkeCfQhxPm5MmWmmO2OpHqOI422j4Ply9Tyzo5q2FwgA791lY0xc5wUF6W+ln3Ggu80KOVuS6HOFLGacraXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774026; c=relaxed/simple;
	bh=mETHOHGta/ApXOLd4cZ9kSxCTLotDnWcLiMxmS8gzhM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JUGGg3oIfinxq+EwVIdYTHw8zSZ3/3x+gvx/SndbKcRv+HDM1sj/O6DtQoPEczxvG6ejznwdY2ufOf43MxifoJgtvhWXQ9A5qnInO9nBg0sgbtTbSipYwv53FgmroQhZ69fdoHR9uF6+TBgv9XW4KsH7IZ09mlZw/tY/E2huIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RjTPiwri; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ffee6fcdc1so59580687b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 13:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774023; x=1708378823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QVjGOqS2/C9DQQqaQQFc7iw3YwNnxSDsGz2z4KoUl2k=;
        b=RjTPiwriVDcuzwCfbRq9xz7eA2HwUPhlq7u9tBFItarGbooXsTHQrlQpNlJwmuRl+I
         AY+0rRZ7z9gxpONCWjOF9sIJw+wBlb6KwBkhfrw2WREPdVk36sYpA/6IRvxV29aphyMf
         zvX8ZyzRJ/sESFwB3DhyxyBZpiOro5RsFO6WghWMyIxZUzanm975zVvqx4BFStHGpXlQ
         Rq+rqSLyfcBNkfPlYT3L4aH/gGNoeC2s4VBGK63HGGzZJiF+SkHTIPHFhHzY83VhzS3Y
         YRGAEQMgXHRAnUPX7olhQlsnfjoLlYnyGISEgePfojGjl7aPnctGrv0jrL0ISua5jFcw
         7cZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774023; x=1708378823;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVjGOqS2/C9DQQqaQQFc7iw3YwNnxSDsGz2z4KoUl2k=;
        b=sFpnH4T5KVb4bjVRAYRfIUR0jVe06y4CISrKLq8fMg5SXgPeWWlmnvST7FW12XAoDr
         wiSAFlKH/wnU8ebPsEujBaMIdZDJ0H2LrU3w6IyofAGHOuHHaetas4Kc2cNvRjP7R3KO
         6fnfKCaNYUdyaq1EJQWkSOq+FClUvyafvRnSaQEl5PH+kOE365DgvzZQ1fbmo1lzVkTZ
         MJKNhLylDBO1B6Dhc98/KRbU/SCU2btwCF27B0M03JwgX4dxxHlwNspSISTPgzV4xdwT
         QMafuIXuul/ENND2VRQrsoK0tTH+sajUmHCFnO1VHoNsx2C4TIZTtxI1qk1ydNHGh7ve
         X4fA==
X-Forwarded-Encrypted: i=1; AJvYcCWcPGR+BgOlJ0y7NQRbGF4x5Jp+DBKTcdQbKfdBwZ+xE/WbRng8I/R5bXVG42eBYzWOUMIE9m81qWQBrSfSV+omgFd2qq/iBpNjOejlkQ==
X-Gm-Message-State: AOJu0YyDDQeQtn3X46A0I54qisvESLCEwvb+IwL/wHbHODJ0vDi8SNvo
	Mv7kVefSgERU8MgYWfg9y6EUISWDPN7OwUjNggJmbUs1kh1Qgctl8WKcfffLC3L0fsTQMjndD4U
	EMQ==
X-Google-Smtp-Source: AGHT+IHcBrIgMIQ03gLdwIObn4fTPAITy7Rn+dgjwGrjWr5hIgaJ7mUN+6YCHWnvHC5rR1WgctLJs84VL90=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a05:6902:709:b0:dbd:73bd:e55a with SMTP id
 k9-20020a056902070900b00dbd73bde55amr364194ybt.4.1707774022635; Mon, 12 Feb
 2024 13:40:22 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:09 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-24-surenb@google.com>
Subject: [PATCH v3 23/35] mm/slub: Mark slab_free_freelist_hook() __always_inline
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

It seems we need to be more forceful with the compiler on this one.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 9ea03d6e9c9d..4d480784942e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2124,7 +2124,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
 	return !kasan_slab_free(s, x, init);
 }
 
-static inline bool slab_free_freelist_hook(struct kmem_cache *s,
+static __always_inline bool slab_free_freelist_hook(struct kmem_cache *s,
 					   void **head, void **tail,
 					   int *cnt)
 {
-- 
2.43.0.687.g38aa6559b0-goog


