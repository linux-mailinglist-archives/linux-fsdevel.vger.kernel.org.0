Return-Path: <linux-fsdevel+bounces-13783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33012873EB1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 19:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D3B1F22E18
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 18:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48DB140E55;
	Wed,  6 Mar 2024 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jLouP7rT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A831140E5B
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749497; cv=none; b=lM+cXP8to25vwF8slfeIUWW4lFOo8n+DY9YZNdbHcIwWS8GIIsVNaYMXHzH/QoGugqawueeHVPtCtbU5NEN1KKJssjaTkU7vNt0anurCOHwceMkWvQQH1h3u1VWZSGZyWucXlInL2TtayU+HLcAZ3s9GKC5S4xGnMuEkJiqQBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749497; c=relaxed/simple;
	bh=ZqsbHPLTqR5vr2hfJmCxnAF/y893b7KN4UH1mJR1TTs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UvmF5gwGz5/k9YFB/1TdUB0Zenx9zC49aSq8jSpmaljU2tv5hGoCvghOuRxU3DT7nYQN9995KQJhYqRXtivFr0bWyu/UsvjqYLrDlDDoBXWQyiUVyUBgy48JTsP9jdzn9S00NJxYbecPX1QAFOFysFBln4PM+23EgNWkGeDNi38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jLouP7rT; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so8285453276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 10:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749494; x=1710354294; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5nTBv3DNXNZIxIc1ZBoC1bDpLfB6IB4LOR7eT5PZErs=;
        b=jLouP7rTUREvN56iRZsR/StLrVicW2U29Jn2jyJh40ndaqldFFoP0MEYJLRk2j5+MP
         J89OfA588DB0e0vPuFuxPxBbBQFbdkG8ekDvjRrUCxV/+WKOOdt6AS5udiurxiJ1Y5Qe
         YXAcHkKWKseALXkXjMW60ZGiG0qC0Q62rD60v7kAPEyEUvYfySg4WqzHgWN2FwCr3NFY
         gMGb8SMWX0ZLoJGvG3pNTmVozTKBVTB+StepddRBqxKHNwQ0C3uQGfuHqG/49nHPKECf
         y6TMsvLIJexpDlkIT3yWoOOaV/Ip3mWAOwDvvnz+ROsUBjceVzwKI2uV/09CtoeBdMzm
         hlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749494; x=1710354294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5nTBv3DNXNZIxIc1ZBoC1bDpLfB6IB4LOR7eT5PZErs=;
        b=OXe7M64Tpr1eS0mC1bKlEMckjJjDDXp04TtjfnV2xHbfZq2lYsl5NGkWm4JlUW8Fkf
         S3G/+HIpUM2ENZ+/64cDFD/xCl0Ha1PpSgRyjEsJssAEJUVUlnE78TnZJa653XfG+Vqz
         z9f6Awxh8YMFSz2Tl/OyCIaYDoXxV6g8BZ9MUXahyDkE1UY0r21CRQ8oKo8tgPSIfSfS
         B2dC33xkxk5rllQJSb56cjdq6zFWI1ubDX+0rd6CXYDTsdpffenuOVLg4ccKadHPutGw
         bTQBkB7ztLrzIVszaY3I/z5eZo8gZzBwowF+ZMp0JAeHQifuOwkgSUGu8PBd6v/T25RZ
         BcvA==
X-Forwarded-Encrypted: i=1; AJvYcCVuGNM8u2mzmuoGs8KtSNjcWjYVKsdtaGeU0Rh2t/uUx55rWvGhjMVhkaXf15QkXiAi3rcDoiZgwH0VPRI+HtcfSE+CgGwnwOwjrDbblw==
X-Gm-Message-State: AOJu0YyUFmlh7bKeon9Nr89Xvhc/OKafaTgXDsDSr0k8TXQBSntUkvjJ
	/BCLoHhsGcFYKak4ywgGsQ/S4fZqDPUwFLpZW1ag2VqF9xRAuPoHrGyNVpP7hipx/pQhz5eCJna
	VGw==
X-Google-Smtp-Source: AGHT+IG5gxx5etlJS8XEklM9jb6RXbjr2MBzNYyK3K6zvzjzbtTe9XCBybhsxXG5rBRlQj+HJ+M1RmTOlz4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:1009:b0:dbe:387d:a8ef with SMTP id
 w9-20020a056902100900b00dbe387da8efmr534074ybt.1.1709749493516; Wed, 06 Mar
 2024 10:24:53 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:02 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-5-surenb@google.com>
Subject: [PATCH v5 04/37] scripts/kallysms: Always include __start and __stop symbols
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

These symbols are used to denote section boundaries: by always including
them we can unify loading sections from modules with loading built-in
sections, which leads to some significant cleanup.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
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
2.44.0.278.ge034bb2e1d-goog


