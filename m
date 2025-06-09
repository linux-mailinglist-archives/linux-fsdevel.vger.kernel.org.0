Return-Path: <linux-fsdevel+bounces-50978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D37CAD1860
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 07:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFE7188B8EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 05:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6479F28030C;
	Mon,  9 Jun 2025 05:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvyqXMbJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4233C38DEC;
	Mon,  9 Jun 2025 05:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749447323; cv=none; b=WHS0f+m9WwlGhpMreC/ZRomHo6X2rSMs5+dLZR1xlGOm0PnkaoODR28uSwJGCvUM1Be02pYsnZpuX39olyCf+XXrVPwiXU16KDpOcxmdm0NHd8NWKXjGZ73vjS7OvCUXY2SV5e1/8XWl3X7vzeCPX2ol5wRy3hWiweX8AI+yWxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749447323; c=relaxed/simple;
	bh=uMAALVz42MSAbN8QVIhZtacVHnYUUP3+rMUoCdj3S2g=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ltv7zHIMi8BrxmM/SI/hU7G3GaDzAGsNsYhFIUtB4hiGBxUxJiQnBVQSEx9ola/UXTv2BRbmeR0SNn2HyEcP1ikpU7KLzdpUiVVS71jI4ugKGSUyFb5x+x7k9JYbrPwLUkLsqp/ViuhQUpHL1tOFNYokq6RFdadA8b8Scs/m3Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvyqXMbJ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so3505608a91.0;
        Sun, 08 Jun 2025 22:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749447320; x=1750052120; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tkg9IMCTu6TKB1rVl4zEog0FDDNMrzDftkEt+V/q1Ho=;
        b=bvyqXMbJiU/u9Ueg3VLGql6x3CjZGkjFTSQT5+X9yzvwMM//z2otmk25ZLrwy3mX3d
         8lvAaQhWVI8ljrrT/j5rJqTeUPT09Qk2zDzK3KTdQXx99MtbpCkyT2HU00Gx5s6lLMkn
         902I8llGkCnKD5y2C9V/U3OZTUVwwNdyewLyCQEOYAygVkXajMFQY3fXYCs5vfwphrY6
         lGUJoP/2mWy0wFtzkaHdoFpH0TQf1PmosfcGTQCZmoCBuYJlESTzn6WLSXTAOPrEyiSQ
         RxnJXPf1h9UKyWig+MJ2TqBKwbGMqyvXCHl37sPwQp5yjKmhlUsU7aS4cjYVbFDOmSxP
         ID4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749447320; x=1750052120;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkg9IMCTu6TKB1rVl4zEog0FDDNMrzDftkEt+V/q1Ho=;
        b=QuYZSRzttF7cgQwWphQYriaKcyDkWO0oIKngUzV2GIilMKlXp9lnNv94w/6LO3cjDD
         lbzDInH7Z4L7q4FuDcHRIG/XRawLMib9TAfLIjKZXL/d58PM/ChdXGSj8Wj8UYxx6FoM
         fRm5riDsoxva+DCA1yLVhvsmXToQRRZvAQ2qE6cv01ROdMSgHCi/y8eVdYGERWPY6fZo
         aqvrgl3pACQkrZApFFx/+PwONuYsli4MzpvQ2kUMTYd+oxktDfBdy3TUU4P+6hy92PdJ
         GQ2fbJZBIScJBvD7dHckIgRSM7z3VWCAYNDgc/yRplHhfbcStZ4KSjcez2jgib9WNt8D
         gzsw==
X-Forwarded-Encrypted: i=1; AJvYcCU4+nlcTIA+IGyC4i09+BdSa/TIci5ai/3bXEkpAsJtCGsNqVMaS0xuNuoCTYffo4nH7f/HYNpwvMr0h2L3@vger.kernel.org, AJvYcCUZkdqm+C6J8uPbxxa5yfSwH9PWsU6dz20Z80TWL1eASdc1PZMvKAMckbCZCWY6hDGXXipxRB5pmJOIvSmb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8hH1MIvs+BOAYZ4rGiQ5QXruxMwscCcUqGyq06dmlFDNnot9G
	L0GJj3CY4mZtkAqRu8yWK+lM0ZKVlEjzM6q3nZQ7mQZ2EXwTgzsZa/xyafmvew==
X-Gm-Gg: ASbGncvqAe21pSJnWfD4qj0JJagRuIsxF+kfG1okyOlUiCRjfCz0XsT4xoJAu9dGETF
	aIcd4pjB5WhnnAXSrm0Uk432crIP09HTwwe6rNi+CRe4Ga9Ytwc1chVWdy6ygaJroEmL1Bu558P
	OC7OcNUG/ukswiRnhkmfsv2kmwlV3Dr9g8vaMHV32H9kkJKxQDpHc60Y1t8D/fWkYtNWAIOyj2i
	eYFogv46kHQHzYQ0Qywq30qUnVuli8hnbIKPqTa/g1B51oe3tHWpK0uWsmMKIK188r71RvHWO1o
	R0NkKrYkmme4Vcwbhnw6fI9g9jN33uIfLDLUm00AylAjLg1siyzm4g==
X-Google-Smtp-Source: AGHT+IHbXNWjLe2scKNmHHh2XXD2X5FEQWghFG6+O13KNwkyiPgSiq0hAShH7180cL2YHTstjE9a3w==
X-Received: by 2002:a17:90b:5291:b0:2ff:556f:bf9 with SMTP id 98e67ed59e1d1-31349f2eacfmr15726530a91.4.1749447320031;
        Sun, 08 Jun 2025 22:35:20 -0700 (PDT)
Received: from dw-tp ([171.76.83.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349ffc151sm4843135a91.48.2025.06.08.22.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 22:35:18 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, david@redhat.com, shakeel.butt@linux.dev
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, donettom@linux.ibm.com, aboorvad@linux.ibm.com, sj@kernel.org, baolin.wang@linux.alibaba.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fix the inaccurate memory statistics issue for users
In-Reply-To: <f4586b17f66f97c174f7fd1f8647374fdb53de1c.1749119050.git.baolin.wang@linux.alibaba.com>
Date: Mon, 09 Jun 2025 10:57:41 +0530
Message-ID: <87bjqx4h82.fsf@gmail.com>
References: <f4586b17f66f97c174f7fd1f8647374fdb53de1c.1749119050.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On some large machines with a high number of CPUs running a 64K pagesize
> kernel, we found that the 'RES' field is always 0 displayed by the top
> command for some processes, which will cause a lot of confusion for users.
>
>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>  875525 root      20   0   12480      0      0 R   0.3   0.0   0:00.08 top
>       1 root      20   0  172800      0      0 S   0.0   0.0   0:04.52 systemd
>
> The main reason is that the batch size of the percpu counter is quite large
> on these machines, caching a significant percpu value, since converting mm's
> rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert mm's rss
> stats into percpu_counter"). Intuitively, the batch number should be optimized,
> but on some paths, performance may take precedence over statistical accuracy.
> Therefore, introducing a new interface to add the percpu statistical count
> and display it to users, which can remove the confusion. In addition, this
> change is not expected to be on a performance-critical path, so the modification
> should be acceptable.
>
> In addition, the 'mm->rss_stat' is updated by using add_mm_counter() and
> dec/inc_mm_counter(), which are all wrappers around percpu_counter_add_batch().
> In percpu_counter_add_batch(), there is percpu batch caching to avoid 'fbc->lock'
> contention. This patch changes task_mem() and task_statm() to get the accurate
> mm counters under the 'fbc->lock', but this should not exacerbate kernel
> 'mm->rss_stat' lock contention due to the percpu batch caching of the mm
> counters. The following test also confirm the theoretical analysis.
>
> I run the stress-ng that stresses anon page faults in 32 threads on my 32 cores
> machine, while simultaneously running a script that starts 32 threads to
> busy-loop pread each stress-ng thread's /proc/pid/status interface. From the
> following data, I did not observe any obvious impact of this patch on the
> stress-ng tests.
>
> w/o patch:
> stress-ng: info:  [6848]          4,399,219,085,152 CPU Cycles          67.327 B/sec
> stress-ng: info:  [6848]          1,616,524,844,832 Instructions          24.740 B/sec (0.367 instr. per cycle)
> stress-ng: info:  [6848]          39,529,792 Page Faults Total           0.605 M/sec
> stress-ng: info:  [6848]          39,529,792 Page Faults Minor           0.605 M/sec
>
> w/patch:
> stress-ng: info:  [2485]          4,462,440,381,856 CPU Cycles          68.382 B/sec
> stress-ng: info:  [2485]          1,615,101,503,296 Instructions          24.750 B/sec (0.362 instr. per cycle)
> stress-ng: info:  [2485]          39,439,232 Page Faults Total           0.604 M/sec
> stress-ng: info:  [2485]          39,439,232 Page Faults Minor           0.604 M/sec
>
> Tested-by Donet Tom <donettom@linux.ibm.com>
> Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: SeongJae Park <sj@kernel.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> Changes from v1:
>  - Update the commit message to add some measurements.
>  - Add acked tag from Michal. Thanks.
>  - Drop the Fixes tag.

Any reason why we dropped the Fixes tag? I see there were a series of
discussion on v1 and it got concluded that the fix was correct, then why
drop the fixes tag? 

Background: Recently few folks internally reported this issue on Power
too. e.g. 

$ ps -o rss $$
  RSS
    0

So it would be nice if we had fixes tag so that it gets backported
to all stable release. Does anybody sees any concern with that?

-ritesh

