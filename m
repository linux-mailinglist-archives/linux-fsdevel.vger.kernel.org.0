Return-Path: <linux-fsdevel+bounces-12315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAA185E796
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 20:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1E01F21E8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA098126F37;
	Wed, 21 Feb 2024 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lsy4Y1o/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D531A8665F
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544465; cv=none; b=c8BeSgp2BTW14x0t2msZNcMKl1m4UzxhSlpktBLIDQ6KdK4kqQlhttEqscGywUOE/XECc062mDlstVB45cBqzux47BggeZ47JkmeHF1+PzR2duuqeDaOZuk6tbtj7tFMJYmHOnrji/NDwbHcjvniL38q0mfLkrZMIbOOhpoPkoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544465; c=relaxed/simple;
	bh=XvI76MSJf6n8ycfULIR+dpUzLDxxCd04CalcxvixqtQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XRYxmQ6QRxfSqE/wo7+C10zYyVaQRPlHzKNnpNFkbktWOrl2/Kf6xNdRhJOeIT6nQVPGZiuQGoay5NCyEElhwcy38IQkdKhAd+YtlR2BeIyzssr2/8wGgIOwnMs0yNvlX643FHoffxluHYR6OK4O3bpTCHjNyZN7bjuNCTzvGnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lsy4Y1o/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso10348723276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 11:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544461; x=1709149261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOix7cIZ9OpjtRmnOCb5oo8qhMGRBISTNpiHk2ice5Y=;
        b=Lsy4Y1o/cScEtlw+tphqx2teWGVdZTJvgOXQPbI1Y58lqPV7JelW3Z3i1qznu1dmJR
         CKcj0msql37fyX2oCVKqTQtBglvo+ePh761e2E5bkVDds+vWiyCiQ8nQKNx/0QkfpcfW
         bsO+pvW+RWBLd7z7TSagQKq+rkVY9GbiDqSXqtF1MAW9wlglo4hgc9fQ0MBdRoUDFQpC
         BgR18foC4w2y29Prp09CW6J612QcKNwE9rZDNDvsPvHgL+IQq4ktKrpW3Fv2I3ydiAHc
         kTjzs7kR1O63Ua7R5yUaJAy05OJdRDe0Fl2ylvvudFbfclVFq4fShUsZThe4OhzJvlf8
         YCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544461; x=1709149261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOix7cIZ9OpjtRmnOCb5oo8qhMGRBISTNpiHk2ice5Y=;
        b=PtQ1vexXT5O2tYw8dUk1btLe3NPkfrrwbY6B6+DCt09hH/iF3ZlJI55tIYXgLC0Tg+
         Y6LXQDZPyNMUTCmgHFnLiDoD1m5WPVSJKW7h0olhgXE2Gx+CP4645DvpQYibi0nwdeZ8
         7S88PDDXcFWRHcmU/TS6xPSIrNhB9N4xwnRSv4zvz5flGrHwUGE3LGj7Aojjuz3KrmWH
         eR2bwwbNhxaZIvmmOyBJRH0VOKydyfV3jdhcNdziM33vyxrJZRf10oRpMUumPOMzu8gh
         5eQr6oRs1FaR6Lolm3wLukENR5wN3lQ0VxV6IpKOlojJRLFhWq5J1oBNgsy3bpqOQJu4
         zfsA==
X-Forwarded-Encrypted: i=1; AJvYcCUWUWT5JUieN7VB8pe54TvuIpiGpP7DiaiQH7/FwowLaplyMk5S7z47w7cD4xt1OFGaU8LivI02wggat6ySqB1nNB+NkzGI8VMcycwUvQ==
X-Gm-Message-State: AOJu0Yw0+j4fZo/DAFlj84dncSgj027BTp/xcq9CSR4dgQ/SHnJ8F05H
	7LM9fhDIQfu9QAsPBMyxd7SUOLDkoDZ5VcBj8RVt/UsEPhSl/gKFLwSZoLwQu0LG2fd/aO7Dmv7
	Sfg==
X-Google-Smtp-Source: AGHT+IFQED8r11XAmHCvTPIM6osrIYpquXv216eXmkF7EFZy4gkeT8fImMy3GTq6A3JUXD3VP8Bk7+J6aLM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a05:6902:120b:b0:dbe:d0a9:2be8 with SMTP id
 s11-20020a056902120b00b00dbed0a92be8mr7992ybu.0.1708544460699; Wed, 21 Feb
 2024 11:41:00 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:15 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-3-surenb@google.com>
Subject: [PATCH v4 02/36] asm-generic/io.h: Kill vmalloc.h dependency
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

Needed to avoid a new circular dependency with the memory allocation
profiling series.

Naturally, a whole bunch of files needed to include vmalloc.h that were
previously getting it implicitly.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/asm-generic/io.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index bac63e874c7b..c27313414a82 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -991,7 +991,6 @@ static inline void iowrite64_rep(volatile void __iomem *addr,
 
 #ifdef __KERNEL__
 
-#include <linux/vmalloc.h>
 #define __io_virt(x) ((void __force *)(x))
 
 /*
-- 
2.44.0.rc0.258.g7320e95886-goog


