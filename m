Return-Path: <linux-fsdevel+bounces-56989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F755B1D8F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 15:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCA6726965
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 13:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F214D25B31B;
	Thu,  7 Aug 2025 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PWDJSY1x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500CC25A32E
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573140; cv=none; b=MZPJ27Fwduxpn6dZ4t7fFXj77WST+aAIwvWubwV/noVrsgXHK/ZXbBP9bg14CJmZiRzhEkO+jjGicmN6uFG3vjrbGrHb0dEkPIDoFTIBaJL6EMPghOLVFkykYUTPjCtgDFRZWVxDK91aMeO66ZTBv1/CwK0jF9u58WvsqdyhfDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573140; c=relaxed/simple;
	bh=BE5Henonj83S/x58TbOMswxN6uWYEKzKyZZTSsbruCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSsvlBpw3F10dKcESbckJ1FE2Wnqaw9nDZgTv1eL5BUUzMZ4be16bYITE1TxtIEbCt80by+u2jNyZ/p6ZsnhXhSaN8dCAubOZMisWIHaWOlOLdF/sUvKwm5RpGtjaiICcyYc+fP2nc7QSmBf09perZpl9UxnUkgbG+zGGp1QBFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PWDJSY1x; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b7910123a0so845796f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Aug 2025 06:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754573135; x=1755177935; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QkK/h5wyW78slTbM7rfscexueduuSs96e2Qc2RW5gY8=;
        b=PWDJSY1x3KjIoYMyRAV/nD8dicioBVARS+3hoJXNlET0sg58G2ZjUOEvn8PDbav+1j
         OsZpkEpx2lfO17rbC2SAEYeIL2Pa6ODOBw68VrpELrTa2if1E4a5AORzmAkdOb3ct/5A
         YacrUmrPsTOXLOjlnXu6RHXhjlur2LVQKFsU4r2PRHeYOFCJ/CgBaB9I4NJ8dXP2lRi+
         8DXiBG1mXTVv1azIpPECnV1jkVlPMKpOUx48kwq5YOkkKfwPyM5dhAZhPhJ1i6aJ8zVu
         q0zy01V3PqUJT3w9T1MS10KqnK3qpvRfgXvYmgAq81px+dwjqknCIAcQOePn34dX96EZ
         iH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754573135; x=1755177935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QkK/h5wyW78slTbM7rfscexueduuSs96e2Qc2RW5gY8=;
        b=DG19L/7sgEKK6QCblpxCxXGyENZ8nLp+dvRHquHTQ7OTa5sdO5EGLXTrWHGlFi6eQX
         a+iXWaRebBsYWkjtIPHycWbemxEOuGjn4fGwiDsWdVmh/KToc646NFah8XUkCaotUI9T
         cY/UNEnvoTnRv7VCztivEzpFlbLhjuL0h+zvEjGo92FpkCZwLl7gD/mAsuWnGjCWomg3
         telFizKv7CouofjA+6VIV8kYCmCL5TDy40QHZbRqwBXZGZXxZs6uIzb1MXd17ZSd9mg7
         O0KNsrSmfFymTeB+XDoqmq97Oz/XgByiMwImLSUK8D0Lf43Gf5j4i+BnjgzpKfVYYu+a
         tEGg==
X-Forwarded-Encrypted: i=1; AJvYcCWXDi6tVTgmm14IsSJ+U+SvBPnqaIYo4RUBwdxrtIzMg2xfossHXPx+wkIX184rZWnSPmiaDAy9j1EqMVAH@vger.kernel.org
X-Gm-Message-State: AOJu0YwDwQWpHvdC6Eo2HgBJR28wSMwyQyHMy4SHFdXx5N3kKbY0a1UB
	HNYt+/OVmW+7Qc2+99d5NtUaMxEfSc/+ljdZ3ONkHKszu6KZN6ZZC+BqjgbaNk79tmo=
X-Gm-Gg: ASbGncsaLeEFXT/yPRpiRsn4k6mgrXBfvCmXQFPE9m2ptVmBg8pT6z2MQsj3myB16k2
	5UmZEifSM4gCF0zMKHA6+9Zb9pdAlRV6JRNs5SQVMfBvqnco0mVuYIw32hgptCp60tw4FDgGCAE
	2HFWKU4mk2S4WW300hJWwUfwc9jWihb0DLkzRknHTrU9NnbS0H/RTwYqZtVrY5heJmgz2cSR684
	ON955RzeHvB98aKJwwVwb/fSufm5dIHNBWh4M3PmXBG22SHHWp1roAVpOPD0VVYE+f6NL+u0uKm
	ISGe7EwaEb9C/BWkU6unvUNB0UK6ZxWUvQ9bFCqWfTlZFKcVkB4eu2m4KNJsrvq3dXJmG81CXpO
	I6sKa/3oGc46p6/aF8urBvc9goYO41GNZKUjv+mqBJ1q6oA==
X-Google-Smtp-Source: AGHT+IHQ9dMmpvwSG0LG+OsU60Voye7P7DJOnU5DCYn4cofMlrbc+GKVT9M1/0FDZpZM67dPsg7qAw==
X-Received: by 2002:a05:6000:1a85:b0:3b7:78c8:9392 with SMTP id ffacd0b85a97d-3b8f4166f4emr5537116f8f.19.1754573135392;
        Thu, 07 Aug 2025 06:25:35 -0700 (PDT)
Received: from localhost (109-81-80-221.rct.o2.cz. [109.81.80.221])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c453ab0sm27171452f8f.44.2025.08.07.06.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 06:25:35 -0700 (PDT)
Date: Thu, 7 Aug 2025 15:25:34 +0200
From: Michal Hocko <mhocko@suse.com>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	len brown <len.brown@intel.com>, pavel machek <pavel@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nico Pache <npache@redhat.com>, xu xin <xu.xin16@zte.com.cn>,
	wangfushuai <wangfushuai@baidu.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Adrian Ratiu <adrian.ratiu@collabora.com>, linux-pm@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/9] freezer: Introduce freeze priority model to
 address process dependency issues
Message-ID: <aJSpTpB9_jijiO6m@tiehlicka>
References: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250807121418.139765-1-zhangzihuan@kylinos.cn>

On Thu 07-08-25 20:14:09, Zihuan Zhang wrote:
> The Linux task freezer was designed in a much earlier era, when userspace was relatively simple and flat.
> Over the years, as modern desktop and mobile systems have become increasingly complex—with intricate IPC,
> asynchronous I/O, and deep event loops—the original freezer model has shown its age.

A modern userspace might be more complex or convoluted but I do not
think the above statement is accurate or even correct.

> ## Background
> 
> Currently, the freezer traverses the task list linearly and attempts to freeze all tasks equally.
> It sends a signal and waits for `freezing()` to become true. While this model works well in many cases, it has several inherent limitations:
> 
> - Signal-based logic cannot freeze uninterruptible (D-state) tasks
> - Dependencies between processes can cause freeze retries 
> - Retry-based recovery introduces unpredictable suspend latency
> 
> ## Real-world problem illustration
> 
> Consider the following scenario during suspend:
> 
> Freeze Window Begins
> 
>     [process A] - epoll_wait()
>         │
>         ▼
>     [process B] - event source (already frozen)
> 
> → A enters D-state because of waiting for B

I thought opoll_wait was waiting in interruptible sleep.

> → Cannot respond to freezing signal
> → Freezer retries in a loop
> → Suspend latency spikes
> 
> In such cases, we observed that a normal 1–2ms freezer cycle could balloon to **tens of milliseconds**. 
> Worse, the kernel has no insight into the root cause and simply retries blindly.
> 
> ## Proposed solution: Freeze priority model
> 
> To address this, we propose a **layered freeze model** based on per-task freeze priorities.
> 
> ### Design
> 
> We introduce 4 levels of freeze priority:
> 
> 
> | Priority | Level             | Description                       |
> |----------|-------------------|-----------------------------------|
> | 0        | HIGH              | D-state TASKs                     |
> | 1        | NORMAL            | regular  use space TASKS          |
> | 2        | LOW               | not yet used                      |
> | 4        | NEVER_FREEZE      | zombie TASKs , PF_SUSPNED_TASK    |
> 
> 
> The kernel will freeze processes **in priority order**, ensuring that higher-priority tasks are frozen first.
> This avoids dependency inversion scenarios and provides a deterministic path forward for tricky cases.
> By freezing control or event-source threads first, we prevent dependent tasks from entering D-state prematurely — effectively avoiding dependency inversion.

I really fail to see how that is supposed to work to be honest. If a
process is running in the userspace then the priority shouldn't really
matter much. Tasks will get a signal, freeze themselves and you are
done. If they are running in the userspace and e.g. sleeping while not
TASK_FREEZABLE then priority simply makes no difference. And if they are
TASK_FREEZABLE then the priority doens't matter either.

What am I missing?
-- 
Michal Hocko
SUSE Labs

