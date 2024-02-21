Return-Path: <linux-fsdevel+bounces-12317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7BF85E7A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 20:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C251F2158D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE071272D7;
	Wed, 21 Feb 2024 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H37z25x5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4338B1272C6
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544468; cv=none; b=UHBQkSicwn09RIWGS6y8AnXUstdzrPs+J/A0DzJcX3EHsv1qqBLG1J4yIkYnr2jQnVyL8R6WfXrhPmn3gW46yT2Q7tD46HNjqquGYp7jjOKC0AVFmZTUDDDMNwPIcMxAc6nMvZ93yw0PRvhsFgQh3Ui7KLcWBcm0ixHx9sWADqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544468; c=relaxed/simple;
	bh=HEHmOJCie8+J7RJiRgymV6TXHRXRZD3Kg9mNxHhJkjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iCnW5+4w3+4hMzyKX2cPezCJceucMbYNiibAJQThRj+k0R7AP7phGaLKNCmkpBzF0M1SWiliosnfuTPBcXjnINhvwTP2okuW9oQt5sMpNXg4Lt5JPjNMZUeTC/AU7AQ+yMFfmPWA2Se1vogIOYnZpd6OUoR0iCQHFzQCm69mqMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H37z25x5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6089253372cso9640017b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 11:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544465; x=1709149265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nNOJH11gO16gI1CGV9wD1JhhI3G0pl89I4/43bWDXAE=;
        b=H37z25x5wvEqUwzd/42xA/Op9Kb8Fd0bYv549DTrI2TY1FrCrkQmoYqACVMpDfqD4y
         OspB1oI6aB9HGWr2ol/P7wMiZw9MX2tFLcqPdJGAzby6B3v0elGYlsRr4FshFxpVDOBZ
         AJ1VLsD2PiTfLGyj9LG7ysU5bHCjMwgDXL+25UFC1aurZBEQpx3AB67ny16u57cPH2yX
         U/lQgoA+pKGM4aoHvqMFfedUkwH2/NcRsRLY+mgM4itaBDL1aKqg4idbJYagOSPcLGtq
         buHUA1yS57dInoD8oYhGZjYyo0cXPDzWMUwuEJ900z20bs+j9uzayLp55OTSZz1uViN6
         wZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544465; x=1709149265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNOJH11gO16gI1CGV9wD1JhhI3G0pl89I4/43bWDXAE=;
        b=DheuRn/1sfEOFwMdjrDbBaQmmp2ss5a4JtVUPRjB6uO356cn4V1unY1xHjZsdR7O0G
         tgvOSvbdMLi0v5liBUbN+5n99x3zOS93CFojEQHe6lexoMcH44/yVSjS4dEMVlKMX6mH
         b+9rAHDP9Nuva6O3dJhUcXf+8xnd9/cHIw/Dv/hRofX2C5lTaoP4LoAiisbjC2h6LaWc
         dxBcZqGD8RIj2NVxMo3nzE/3dEL6obr0DnoQSbb/RxnoMmEYpGROToNQeTLmJfizdKdI
         6Uq4r0xodon8P4FKwcr+boYj69m3hWz/vU6ec59cfEwAflZCPcxjtf54FgLNXud0HdHL
         PC3g==
X-Forwarded-Encrypted: i=1; AJvYcCVFk0n0ANAsJ6iriIUqTy0JulP1S4+yTvNs2b2x8TYgUA7EAWAUsfRJG36+q8NKn+OMrVdDwOQB9y6NDfQrtc80S/tFtiDFlUqib8vvwA==
X-Gm-Message-State: AOJu0YzWufbfBcV2n+PtGUPk1n+LyCjgEmTaP+431EBnW/utOmg5w1mT
	GRaun2bq19wJBakEL/uG2bwsy/T4ZfZ+gALuYFlk4Md9nonpEtG3V+tjPF5doJ4mYhZE3dQqwst
	M3Q==
X-Google-Smtp-Source: AGHT+IFw1HW6rh2zXq6oVisO+flBpM8PZrPAxomjgm47RtsfgtCbzompT9Q8/PbN9Jjx8wnIh7u82HkUv1c=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a81:528e:0:b0:608:94cb:6f6 with SMTP id
 g136-20020a81528e000000b0060894cb06f6mr174090ywb.7.1708544465320; Wed, 21 Feb
 2024 11:41:05 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:17 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-5-surenb@google.com>
Subject: [PATCH v4 04/36] scripts/kallysms: Always include __start and __stop symbols
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

These symbols are used to denote section boundaries: by always including
them we can unify loading sections from modules with loading built-in
sections, which leads to some significant cleanup.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/kallsyms.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 653b92f6d4c8..47978efe4797 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -204,6 +204,11 @@ static int symbol_in_range(const struct sym_entry *s,
 	return 0;
 }
 
+static bool string_starts_with(const char *s, const char *prefix)
+{
+	return strncmp(s, prefix, strlen(prefix)) == 0;
+}
+
 static int symbol_valid(const struct sym_entry *s)
 {
 	const char *name = sym_name(s);
@@ -211,6 +216,14 @@ static int symbol_valid(const struct sym_entry *s)
 	/* if --all-symbols is not specified, then symbols outside the text
 	 * and inittext sections are discarded */
 	if (!all_symbols) {
+		/*
+		 * Symbols starting with __start and __stop are used to denote
+		 * section boundaries, and should always be included:
+		 */
+		if (string_starts_with(name, "__start_") ||
+		    string_starts_with(name, "__stop_"))
+			return 1;
+
 		if (symbol_in_range(s, text_ranges,
 				    ARRAY_SIZE(text_ranges)) == 0)
 			return 0;
-- 
2.44.0.rc0.258.g7320e95886-goog


