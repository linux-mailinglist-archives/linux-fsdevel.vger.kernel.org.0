Return-Path: <linux-fsdevel+bounces-13815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19C3873FA3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 19:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A091F20610
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 18:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74EE152E06;
	Wed,  6 Mar 2024 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="agjjUOQ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A980715278E
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749564; cv=none; b=HxvBGU0z84LE/9zVkmCA6F5bVBFBUKHHY+KngFJJf9ZDI5/lZP/j98fr+cbAGyABkWW7dCRitiTxxfnTDR2CKLYpkAdVD9Ox6/J2jc5YM79l08+yfn8z6u3lgLrI1vpTO33meHpxCDRHLwguAVCfVRWl0fb0q5s82xDgnotTJ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749564; c=relaxed/simple;
	bh=x2ZpLX5yONr7aQCOCLA0e041Rtm6gz/YdLIaAuCTmqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=roeaFqQ22gPdYfK6bM93X1wfiGyORiOYtHE0UfUW8mZrIz8q+OXgFjYvClanIu0NglMpOVVYW7aK936Y/PVSIGrAuTvB3C2QtsDxeItJvkl2ExqGzSEaju35epCs736QxM9FMf/SCokBYh5X0yEjhh5PVGQUFOlB1gHXbvYei9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=agjjUOQ9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607e56f7200so98597b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 10:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749562; x=1710354362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq5e0nRnwdhD4a9FMTFm9DydRhfgPVhlZe9ht+OK6P8=;
        b=agjjUOQ9/6hVGpnxq7KlKT26EnEzG1Nf1UxsGDjujH8HO2nWxmOBkH9GSUAjAL4r+h
         cloyo7v6u/pbh5DBZCu5ngQJUMJbAIUnSAw5kDn4zlFupTC93Y0xlheXiP7qvJx/zAc6
         UnjtDUKPbF/bXFtxCCffIDWfgKuLtr0rEB/OTeGm2hUECkALbquxVEZowXCTz88Fgl6v
         YSpdBG3HEpH7x2Kzv9hq71h0Wl5s3dGg0LrcyiHIuey+RPKz5BfXPyJzVaGjg+qXVc0N
         oNg58iIUQQ0tx5HZuJXXED/kdiQ5j95kH2tyPZsFKmLSb+uykMhPXCxwqdR87P/wGeGC
         fXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749562; x=1710354362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq5e0nRnwdhD4a9FMTFm9DydRhfgPVhlZe9ht+OK6P8=;
        b=FzV08yGBzKR0hp1cU2tbisGruP5RMcO61jIhxp8rLmduFqAPL9wh2PRt7PP+e2Wtca
         ybklKBwE6FcaN8mLiHYdTavZAFJrT0YI51/qfEOoriVEztEhTD35ItUM4U2rjKoVTRyG
         8ZZuuJ1eDjLWoVL6y3IpNKymVUi2/W4WugNEsNGy2VjM5T44M9Jxt9SlZE+yHjZmLZxY
         G5YRGZpArsvQyjbKZuUAOpGCWUrA3rH8iQD78O/FSZBlX5EWumL11oJG92dt3ceHNxQX
         M5SccMUd1yhs68BJfWkKKlhnIpZjWJbFlzy9b0WdxWVzscPmTcoSvLMkY+cR1JByViX5
         eTLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeLjwMnCRtHiKVohBVcwooCuYGWGG7fWa/+BIpjJj+Y6Pwa/V7m6UrbfPnjJyNmyPbk7aOU+RTtoCjBJwzEn7Y6MDLAxTWNrJH+jJOSw==
X-Gm-Message-State: AOJu0YwclDKlqnwEAPbolkUOyxdq9ikoRrQld2/Vp88NImrBFbDkdM+D
	cYI1WUHEePrHe6z8wmdpnT1OkASrBun5a18KdA7QbFPzsPIFQPZjypciE07uo3KWDQMA9JFiAt+
	Iog==
X-Google-Smtp-Source: AGHT+IHvZ8kVm6l/VDxZg87uGkFZ91C+i4oKHcDrWRMYqfh/2LVOqc/iUX+s1MQiLrOuG91osjkHSkoZjwg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:690c:fce:b0:609:e1f:5a42 with SMTP id
 dg14-20020a05690c0fce00b006090e1f5a42mr3594072ywb.2.1709749561828; Wed, 06
 Mar 2024 10:26:01 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:34 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-37-surenb@google.com>
Subject: [PATCH v5 36/37] MAINTAINERS: Add entries for code tagging and memory
 allocation profiling
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

The new code & libraries added are being maintained - mark them as such.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4ddbcdfb29a..03892d8032ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5210,6 +5210,13 @@ S:	Supported
 F:	Documentation/process/code-of-conduct-interpretation.rst
 F:	Documentation/process/code-of-conduct.rst
 
+CODE TAGGING
+M:	Suren Baghdasaryan <surenb@google.com>
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+S:	Maintained
+F:	include/linux/codetag.h
+F:	lib/codetag.c
+
 COMEDI DRIVERS
 M:	Ian Abbott <abbotti@mev.co.uk>
 M:	H Hartley Sweeten <hsweeten@visionengravers.com>
@@ -14062,6 +14069,16 @@ F:	mm/memblock.c
 F:	mm/mm_init.c
 F:	tools/testing/memblock/
 
+MEMORY ALLOCATION PROFILING
+M:	Suren Baghdasaryan <surenb@google.com>
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	include/linux/alloc_tag.h
+F:	include/linux/codetag_ctx.h
+F:	lib/alloc_tag.c
+F:	lib/pgalloc_tag.c
+
 MEMORY CONTROLLER DRIVERS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.44.0.278.ge034bb2e1d-goog


