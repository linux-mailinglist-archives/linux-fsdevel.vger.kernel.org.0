Return-Path: <linux-fsdevel+bounces-11226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6314A8520BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1895B289EAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 21:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5325F873;
	Mon, 12 Feb 2024 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vc5AxPqe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3315F86A
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774051; cv=none; b=QNWMD5RAQEHkEXem43a7FEpHxqlPniNXPSMDXltyp3uhQXKKVyCGpiqCQMnMEBGIbQwvZyIc8aV00tmt5SXJ04Hdtg7DXmc8EqB/k+vHeV3qLCpuIQVYFz+wePAcXFGS6Vjh8wcU5MvgQlGkh3bOcPyss/9xs2yrIpnX1m/hzEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774051; c=relaxed/simple;
	bh=vS3hFfqyUn7F6Wyl2Bup5pxO9jekfVbmKT9YXb3RIpI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WERePJLlvwha/6lbOg6IH3WjBsp3wndCLHb4eeDKZW7OVztXQLnsVz2FG33TraMrT5/WI1eQ6HCWm+J12Kmc1/n9XDYKzj3oc7MjEKpVCgDV6+djE7pPVWLfFLFuheXg0Yb3GXO4Lx9llv55ohdMhiY7/dbIcmPEwc6Nns9kCDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vc5AxPqe; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6049b563243so67273157b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 13:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774048; x=1708378848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SBX12uj3ZhdKUrlA/PpkAMdvyZt1FRyTju3ec31OSZc=;
        b=vc5AxPqeoJBaP6CJzYBZKxHiP/DQGt0I9S4yEzdaLl1mcsFSky0Wm82h7aTAHg4ui7
         3ii5QvvIcgBEmO/J8f09wf1MoxQ0GtxK/Zrv55HKo+WlvhUf/1+8txh8Lcyxa8/2Oys+
         OwFRw9nF+b4KA+G7NDrBGUww33SAdIKI7R315L+iqovLAs6p2HYL29aAyPhmx/jfJC43
         4TBsxNsgRGkRs53o85/X7MVx7BkY8BgugIEjzE5iE1jb4qk6ljVn/i74pTUp30TIPKBm
         iKRCN9q7PNmjA+s8cljPaF0ECouOdCaj0oQN7gmLiWBbRFBnhd2kguBJrnMcxWYJxT6C
         8BSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774048; x=1708378848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBX12uj3ZhdKUrlA/PpkAMdvyZt1FRyTju3ec31OSZc=;
        b=HHk9q5ghgpD/S5I9sifAm9PkCx/VFAN6KATEvgAWo9GXBXuZmwWTtJJ+16CYlO5bU7
         YqDHjGiNc7tUKXzSblb52dmdwjMjYoW3T9FW11gF69uqqGRURSxMZHDpc3OQojl9HnOy
         IhmTgh9Ny0QgPm34Nvn2fbS2uvbqpBnfszDHQN+83VGljwG688AOQo/1WxFkHTS5KL1Y
         /TKKVbIVkwiPFQWlU5wXR05J4CqIapqySMq7/O/Voa0qHZn+6/7CIjJRGzJLplVxbO2O
         4Iu+3cclQHFYBl3rPwusfJSgbur3+Rr8tG83kcaddoETsguocRS8hMu2NFB8g7rN2cj7
         5WFg==
X-Gm-Message-State: AOJu0YwKvAaUI9tiVeqRvRxaJEOxPPxd2r2ifIDKHEb59xbyxvawyQ7h
	vCW+pKuOdUCs47qJQfprhI0jQF4kgXBC3Nlrd3GG5BocX9Y9+d/gmp1haxeat39N+cBCQM5WIgO
	BpA==
X-Google-Smtp-Source: AGHT+IGnimMvKfHnjDqQ+fcufl2ID9NuWKv0TEQmpUKb7IHMbluonmQIQ8q+5RdznzBwDieXP2FUkEOc23U=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a05:690c:ec9:b0:604:648:6dc0 with SMTP id
 cs9-20020a05690c0ec900b0060406486dc0mr2354569ywb.10.1707774048308; Mon, 12
 Feb 2024 13:40:48 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:21 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-36-surenb@google.com>
Subject: [PATCH v3 35/35] MAINTAINERS: Add entries for code tagging and memory
 allocation profiling
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

The new code & libraries added are being maintained - mark them as such.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73d898383e51..6da139418775 100644
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
@@ -14056,6 +14063,15 @@ F:	mm/memblock.c
 F:	mm/mm_init.c
 F:	tools/testing/memblock/
 
+MEMORY ALLOCATION PROFILING
+M:	Suren Baghdasaryan <surenb@google.com>
+M:	Kent Overstreet <kent.overstreet@linux.dev>
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
2.43.0.687.g38aa6559b0-goog


