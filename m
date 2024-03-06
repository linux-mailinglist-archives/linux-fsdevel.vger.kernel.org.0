Return-Path: <linux-fsdevel+bounces-13782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C9A873EA7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 19:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D521F220A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 18:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715FB1420C6;
	Wed,  6 Mar 2024 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tF6nRmKS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DAB13E7C6
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749494; cv=none; b=ZkxAre0lmiRfqwQyzRWDGLPbnXJwiwNBklbgCLINSXkhrI/+pxwU4UDaMll9HZyTmHwhBL+N7Qgn10pq7zdE7WUaCG63l8EkcDfa+1dfRdAcKGxn05gD5PakfpdAheKUMLjFqGHES8/+k0DfqH0F+5eWv//mpA3RufGQCrIOC2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749494; c=relaxed/simple;
	bh=mZlZ4aAM1x7pkztROKSVF7CfVo40AKOzii/60d0+0u4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cl2baneWIvxxfVbKAQpTTvUEfFhfIwPkUaV0IK3rFbEm53dW61ZL40Gl9/+wICUBQZwrC4dj6Pr2s1F+Ej7kH+UDRkmjhDbFZPeaQoTfSB7aL+IX3a2xOBLBXbXSYKCBi7wxQCkREJ/jH9vmranhDI1ptyIT0xMxkvur7/rjuoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tF6nRmKS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso12358153276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 10:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749491; x=1710354291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NeN+jv49ztz1DkBAYeWMzQyB4IxgpHbFtvet8rPjepw=;
        b=tF6nRmKSJDsFFgTo5SXTWXfc3qYmMUb3MQjMby48H7EZjcTNEKTMQ3HVZ6ArnIeY6G
         bnnv7FVZui1jL2zdJ2jRTMJbJWM3aj+i4j9c+4jMDbwWkqRwGKhwxH4nKfYtHIZurmCU
         70CNjR6bNSf5s7fZEIXOTuAnww95ElTkb4KhihBxLcurxyFAWNRvALJGRmS6F68NXakP
         kgPYIKYjH7w80CY+XM9KQXG5BEHjlEeu9GwKal/Xn41fdYdUY+YLdTXO/BhkTehJEksZ
         0lDQQIF5vlfRYSbdOkyp+2Us61Qp1z8mfBklaIDggsZsEptmbDOB7U/eQWTVf6EgMaOI
         ZM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749491; x=1710354291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NeN+jv49ztz1DkBAYeWMzQyB4IxgpHbFtvet8rPjepw=;
        b=TD38kpju4It9JnZauX/tCYOTflR8m3c5oPYNerH69VCvTZXb822XQfgPRi0jwNiOI3
         k6fYaYhvj96EGFacN+qj98j4bi/riYi3kf0guidamN+wh74RW2oSOvGRQIAOXTZSIOON
         mK7DgYXqK0eUW/F2vskdg1s4Kvhp64nfL3YNctJCEiqqmnbsWoPMHZ0ZyfY5MCc/+5dm
         GLpe1DErKKQmHFo1xkWPtp57TzjacVrtler6X7z5RAM8sOfKbEoQxBZYWGfJKmyEzZFC
         4/t9Elb/0z8Wi9Uxnq/8SRdCWsjr/xYUZeHarHQ9t+ZSD5YWdU3YC3HtqtE3ndqaUT+m
         iMgw==
X-Forwarded-Encrypted: i=1; AJvYcCXCkbVFU/sfhTxemZgJ5GYub61sqtFgSDlse1X87toTs24GmV6uSvtirGInrkNQd1gQXXnrXqOopENK4ny4aHCd6WEJixCOeJGSa3SAdA==
X-Gm-Message-State: AOJu0YwuF7JPr1E1wT0QlxWhRlY3jvf0VJcb6Gr/pFbi9S8nN/G95rER
	gclTBZzR9TCGc9V1ZOio2JS/m+jbRbncZ+xYesjmkTHJj9bYoYPNXbFdkdfiEd6R9WXG+KEfZK6
	rwA==
X-Google-Smtp-Source: AGHT+IEhO5aEi5nmrgTX3yTDU5CUyz1hSmpU3f2fCr4To3c82DT/ejxK9TArxLseWogn2XsiLsKy5eHr87g=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:f0d:b0:dcd:4286:4498 with SMTP id
 et13-20020a0569020f0d00b00dcd42864498mr559510ybb.6.1709749491385; Wed, 06 Mar
 2024 10:24:51 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:01 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-4-surenb@google.com>
Subject: [PATCH v5 03/37] mm/slub: Mark slab_free_freelist_hook() __always_inline
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

It seems we need to be more forceful with the compiler on this one.
This is done for performance reasons only.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/slub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..0f3369f6188b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2121,9 +2121,9 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
 	return !kasan_slab_free(s, x, init);
 }
 
-static inline bool slab_free_freelist_hook(struct kmem_cache *s,
-					   void **head, void **tail,
-					   int *cnt)
+static __fastpath_inline
+bool slab_free_freelist_hook(struct kmem_cache *s, void **head, void **tail,
+			     int *cnt)
 {
 
 	void *object;
-- 
2.44.0.278.ge034bb2e1d-goog


