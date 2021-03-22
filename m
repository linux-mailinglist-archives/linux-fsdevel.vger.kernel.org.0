Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44CC3445A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 14:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhCVNZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 09:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbhCVNYt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:24:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF555C061762
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 06:24:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v11so16724637wro.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 06:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TMhYVugyzUF8SPxHtKMVFHW2d9U56xBeasWjyoJCSqQ=;
        b=GOqOWv3PWULYhWC+ww6Br08BQ3+hu5bgizm80HEdUmXKmH2mFt8bV1ZJy436PQ/9I5
         uqSoy/QiB+fCzh6uhZhycXJbCky+BIPod2AXCDdjWJJy5jkc3wIbsyv6atzkUVUK1b9V
         lp6MtiFkGpzvqILZvRtjTDwG3Us4UswvmqAjiXnZVMAmV00NvwQqvp4pHVypdvgVHpsj
         0Jk3NjrrSI+idQKE/wL2kN/JEJ21gNfeK8dvwbM/g7+Jp1FlMj9p3HUdpF3mn58JjWbS
         JMQpsSti1bw3o3xWPdyqz0C3D6iY3eJaQZm3NNBYTarCuRoKiTn+maEvlGeWtDXigD40
         BN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TMhYVugyzUF8SPxHtKMVFHW2d9U56xBeasWjyoJCSqQ=;
        b=lGFsSLF/AY4hJPlqFofjpEbmpeqjeLoZsUeTKb9qkLu7fk+hdHtZN76Um22Teo3IMS
         /uH59rgSOeyAwMDIgQYOM3T5JwgNT3SJpEyMj+r/uFrC4PHcS/ZU57fsknmHl09XeOwd
         xXR+BJwpWfPyj6RozyjZklMV2Q3QqgTQ9VI0sqTy//CYP2auxV8jFka+BKplQ/eZZbkZ
         t09i+WnjUOKzvPIBbeJqNVzf+GKlwPXPSvaOqRrbRk3lqNe+b4qN4RLdXcKJQo4+Vrfn
         TOV0jq8MdiLPtxN7f2bRAG+g9rKcpx5n+ppig1fVPmS6bq2h8/Eqiw6cMK8uCRDet06E
         J5Pw==
X-Gm-Message-State: AOAM530u7KLQJr2MUuONNh4SqOdWggMTOhhYLBuMH5TD87npSBQLbrT5
        32zuEsLh6O1eHnI7czmwu9I3nA==
X-Google-Smtp-Source: ABdhPJwC/rS7OkQu8efIWmWHkHtUUiOkhXCO7peTBGOEGaKEAdeI7EQBg4GOdpdUjIXkhjLjBvQVoQ==
X-Received: by 2002:a1c:2857:: with SMTP id o84mr16021674wmo.181.1616419487136;
        Mon, 22 Mar 2021 06:24:47 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:58e2:985b:a5ad:807c])
        by smtp.gmail.com with ESMTPSA id i8sm19692969wrx.43.2021.03.22.06.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 06:24:46 -0700 (PDT)
Date:   Mon, 22 Mar 2021 14:24:40 +0100
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org, alexander.shishkin@linux.intel.com,
        acme@kernel.org, mingo@redhat.com, jolsa@redhat.com,
        mark.rutland@arm.com, namhyung@kernel.org, tglx@linutronix.de
Cc:     glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        christian@brauner.io, dvyukov@google.com, jannh@google.com,
        axboe@kernel.dk, mascasa@google.com, pcc@google.com,
        irogers@google.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 8/8] selftests/perf: Add kselftest for
 remove_on_exec
Message-ID: <YFiamKX+xYH2HJ4E@elver.google.com>
References: <20210310104139.679618-1-elver@google.com>
 <20210310104139.679618-9-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310104139.679618-9-elver@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 11:41AM +0100, Marco Elver wrote:
> Add kselftest to test that remove_on_exec removes inherited events from
> child tasks.
> 
> Signed-off-by: Marco Elver <elver@google.com>

To make compatible with more recent libc, we'll need to fixup the tests
with the below.

Also, I've seen that tools/perf/tests exists, however it seems to be
primarily about perf-tool related tests. Is this correct?

I'd propose to keep these purely kernel ABI related tests separate, and
that way we can also make use of the kselftests framework which will
also integrate into various CI systems such as kernelci.org.

Thanks,
-- Marco

------ >8 ------

diff --git a/tools/testing/selftests/perf_events/remove_on_exec.c b/tools/testing/selftests/perf_events/remove_on_exec.c
index e176b3a74d55..f89d0cfdb81e 100644
--- a/tools/testing/selftests/perf_events/remove_on_exec.c
+++ b/tools/testing/selftests/perf_events/remove_on_exec.c
@@ -13,6 +13,11 @@
 #define __have_siginfo_t 1
 #define __have_sigval_t 1
 #define __have_sigevent_t 1
+#define __siginfo_t_defined
+#define __sigval_t_defined
+#define __sigevent_t_defined
+#define _BITS_SIGINFO_CONSTS_H 1
+#define _BITS_SIGEVENT_CONSTS_H 1
 
 #include <linux/perf_event.h>
 #include <pthread.h>
diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
index 7ebb9bb34c2e..b9a7d4b64b3c 100644
--- a/tools/testing/selftests/perf_events/sigtrap_threads.c
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -13,6 +13,11 @@
 #define __have_siginfo_t 1
 #define __have_sigval_t 1
 #define __have_sigevent_t 1
+#define __siginfo_t_defined
+#define __sigval_t_defined
+#define __sigevent_t_defined
+#define _BITS_SIGINFO_CONSTS_H 1
+#define _BITS_SIGEVENT_CONSTS_H 1
 
 #include <linux/hw_breakpoint.h>
 #include <linux/perf_event.h>
