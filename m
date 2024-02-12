Return-Path: <linux-fsdevel+bounces-11210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C80185205A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E191C22EDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 21:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343E854FB8;
	Mon, 12 Feb 2024 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUhSPVJ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF5E55E70
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774017; cv=none; b=kolQIe9wzvDfYK6e22BlPu5gafKx79QpDWHsPRKHfXAWyvinSPOxqzLpngQxKZ+lYuViQP9BBd16fmyyJhbXlZ9LeFd+NFUbEMrNEo4kvt7n3QwoElBFXTavAbICLHniDPJKcMC5OF/QJmGPE19b3BRR2q/PjEZ8uLNQuHigP1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774017; c=relaxed/simple;
	bh=0VXvOfFGtVEGo1DudaY7A2/vICWwaW6LKiU6pA/68sI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MEeD93LnILuu1cPfEahqHHFn1ZkJ0Z3Ofq/5MMTO36tQaEyr/x5FjZLzHBKRQZh2vc6drppIb5AmdzMUpsUocG0g+ealpphwoKcixvzdn0H+8CWpHyy7TPTYuobFt+mARVhJS4Eeo+tQZjNA0GJu+jy5y7naAighOw+j+YZ+zBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sUhSPVJ7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc6c9b6014so111122276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 13:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774014; x=1708378814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q3nAahWS0BuDAP/EiPEY1h7hxq9o0SR1xq9twkhL8Tk=;
        b=sUhSPVJ7xhqNi0GLFCEB2XvyxGUrlOwz6elzivt0cCzVvmYJ2Ix2wbLMtDRAVbSAIC
         EnVMW07tJnXBcBuA08aNZ4eJHh6LqkH8e/hf37HBdruYO+46pYaZIzI7+zGbV8Z2U2N4
         gjjADvMYYYEiXp+IQ0Ibn6XJ3sHp+5+SJYDSUNRJ0tz5FTtLFMYhuyoFb8qLSU3LEhb+
         h9oAiYsu7PFwQaI6Fo9i9N0ynF1fj15KfHVHZAhiRjnrZOW8ncZTYKEg3u/H4A/MxYZR
         dv1+s++2OgwaEbe1MoFD4D6LSOf/Yqbqdc+mNvHDJs6o+/ILAImDPsEI7dzBqvX6j6JG
         zlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774014; x=1708378814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3nAahWS0BuDAP/EiPEY1h7hxq9o0SR1xq9twkhL8Tk=;
        b=kvHciAPG+0eIJHrTFMIofSWv34z0mpszM2/oJCyL0OIgib+3nydixOqVqtwk6Q1kAS
         XJxmtjahpaGbgut7Q9/BlfR2r1G8aw0JL9sV5AylMsCpFVMcPUQvhIbFxr077jsMG0I4
         0PmbMkj0z7UHYAnzf/Z+H2DPkfRO0E5mIuFJX15eIbkhL0wti4iuADm+P+jrN+xZhdmX
         Ju0K8czOPOTeea0qbGWZhdxk8Xbdog8s8vbyyo723Xgvjk0YtFw9CNPonZj+r/xjzFgj
         uOM8cyjZstAbU875lEf3W/NfoGv9SmcXSPxRJoz6sUGkVUZ52oWdpRPORdOWw1VsHW4W
         zq3A==
X-Forwarded-Encrypted: i=1; AJvYcCWmxOwnt5RtgZRAgKEGD2rzhHoM2N6X59bpxOXn7NV6QAxUFK3lWs82gZhLTuJMR40/9ml3HV8gbctvMG06ckgQ8KO2AoF5mInPJpLTMQ==
X-Gm-Message-State: AOJu0YxzTMkwNUoOuFFON0OX0TwFxw3X2qUx874N1oOrarBstXb+PWPq
	DQHhjIgB5kam4vsmyRReBzjksckbcGLuAqtC2ndsvVTOBE1j1TbtYKATVrotOPQcq6kGPRszZjZ
	/ow==
X-Google-Smtp-Source: AGHT+IFjfWZYV/B1TC2tamqn5wnV41GSoY2BgJr6sKI43uRZs97PbAp/sxw1wS58qt9V9k9WwRg1VI3jBIQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a05:6902:70c:b0:dc6:fec4:1c26 with SMTP id
 k12-20020a056902070c00b00dc6fec41c26mr2112341ybt.1.1707774014153; Mon, 12 Feb
 2024 13:40:14 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:05 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-20-surenb@google.com>
Subject: [PATCH v3 19/35] mm/page_ext: enable early_page_ext when CONFIG_MEM_ALLOC_PROFILING_DEBUG=y
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

For all page allocations to be tagged, page_ext has to be initialized
before the first page allocation. Early tasks allocate their stacks
using page allocator before alloc_node_page_ext() initializes page_ext
area, unless early_page_ext is enabled. Therefore these allocations will
generate a warning when CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled.
Enable early_page_ext whenever CONFIG_MEM_ALLOC_PROFILING_DEBUG=y to
ensure page_ext initialization prior to any page allocation. This will
have all the negative effects associated with early_page_ext, such as
possible longer boot time, therefore we enable it only when debugging
with CONFIG_MEM_ALLOC_PROFILING_DEBUG enabled and not universally for
CONFIG_MEM_ALLOC_PROFILING.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/page_ext.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/page_ext.c b/mm/page_ext.c
index 3c58fe8a24df..e7d8f1a5589e 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -95,7 +95,16 @@ unsigned long page_ext_size;
 
 static unsigned long total_usage;
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+/*
+ * To ensure correct allocation tagging for pages, page_ext should be available
+ * before the first page allocation. Otherwise early task stacks will be
+ * allocated before page_ext initialization and missing tags will be flagged.
+ */
+bool early_page_ext __meminitdata = true;
+#else
 bool early_page_ext __meminitdata;
+#endif
 static int __init setup_early_page_ext(char *str)
 {
 	early_page_ext = true;
-- 
2.43.0.687.g38aa6559b0-goog


