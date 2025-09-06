Return-Path: <linux-fsdevel+bounces-60448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D789AB46AEB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 13:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB6DA084EB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3164284B3C;
	Sat,  6 Sep 2025 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYbvkvGn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330EF27B32B;
	Sat,  6 Sep 2025 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757157253; cv=none; b=V+KmJ5exg2Tpm9lQ0ut4I0ovwXLEVr+HPYZFUDFrTcTeW7YMfAvuTkLlaYUulol2Wi5cAmsz5ZHanjd/Kw9NgabCQGDDi5WkXeigFm9XHIgnyd+Nhzlj/TOXid7rRgBinUU4RhSz4apcyUudZuyMVjl2poIeo1o6nt/3tdsooD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757157253; c=relaxed/simple;
	bh=79tZSDjissr69qWLTtGDszHMBwdmGZrw62SonGZBniU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEti/0Mnn034YwLslcXgxptf6lZeiA5fPMYixv/EoVHT0W04u8sc5ZvKOldh9dWzqJupm05PHuM2HRcDVnPzjd4rz8VucZfgnRJHLaC7Aqk88p+K0LYg76HXwl3Sf+qiUHtu2whypAY8ugGIcW8o33U60ticFX0i/OgTSXxYaW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYbvkvGn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45cb5e1adf7so23942925e9.0;
        Sat, 06 Sep 2025 04:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757157249; x=1757762049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WK+GAzkyID6tHGg5RxAC2Li9CcM3O7oCVmbbRYNKra8=;
        b=CYbvkvGninhN3Z6wZDkqj1ky315/omElwOsnJhbHb6iC9VwVpkmMYAAjrAjWjIvhTZ
         aRHYBMK50v+otki+AXE4aZa0zm53auBCH45ZIhHXh+JoBSF1PMnKCe9R+iQZ2L8gwgUg
         eYustfZ0nmh6TmVZl5ux2ulECwz3Uanm3Cm8Wv2Hn6BKtqUYU/ftnVEZp2ut61xOa0ER
         kmaLRdodfwcaNGdh/rMosPqH6F8ngIo/rzQVrWW/ecoJXCsUbVQh38eCxJlpCzvH3uIE
         YE9d4cS+yz7M471SqXjXC+qz0PA/Zzc6c+Qh6eiZYcQA+a2jwj0boGnkPJXAM5nMhese
         gEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757157249; x=1757762049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WK+GAzkyID6tHGg5RxAC2Li9CcM3O7oCVmbbRYNKra8=;
        b=B2Yh9tDz+2Wi5MZ/gZ1utsFGKfXnhmZFCPVg20iyLOv0JrRxvLxTwyecM72xU8zL93
         bPMCG0IUiTvYNMu63XdfDS7j7C2BxXq5yii+IbLUFOzn4XK25ouKLc0SvxaYypkZUn5T
         mKCI9o547JAeMNKtuy7jOgsuxsxcC2ydAgUMmM1PM0O0wdMmo69BzqJhYpB2ia2rxUyb
         w7oKaNJ3iapwIAIVOe2hrcb+9mV9Vt4awtQ1K4gRp4z/NAoLOJ2qGbAUgtrCt2JwNtgm
         Tz0ZIbM7UcmSVb0dgD21nEtTfAQBcojyd3L2DrzIxOoggaw29d0QIrL8hHQOA/8lwAxN
         Kslg==
X-Forwarded-Encrypted: i=1; AJvYcCUlVkvx5e5RYNKIFjUdywuFx0LlfqiNS5qafon1j5KFKn/80sXMcTsdy3YtuNjE2FCqWRE=@vger.kernel.org, AJvYcCWXFB6v0Z5svnbmn/2GbZAaC4xGP4vbN8Y4V7SBMsfq+MeQazIVT5U7JFEEVWLiEXcPUnrr0hx0bhSbpOPT2jfUzfyW@vger.kernel.org, AJvYcCWmIfRjO72M8PIGCPzCa+4BlY+/BTZYnVLWbsf0PoJvqvVKDg8PuLque4IMxjh0to4dRXx/2EigVInvt6L8mQ==@vger.kernel.org, AJvYcCWpruacRg6IZEmkWP3K+KGTHTrg+tg6RuEjEYiZaiR6RxRf4Qc+6W+UlM0I98RSq7e6XNiTSY2SkwEgs5NS@vger.kernel.org, AJvYcCX3qQg9FvRn/9yRYM6FtzpWydoqN42V5A/v1a5gYP2nBiz7zw48sgMzwSS61x+ixmkRzGE2znPW62St9fzzO6h3LQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIMSBWptRKUoIU0Nt0FUM+ucUvK6TB/0O629xdrxAwSuYfRDtD
	0s5nsCP7PY1EFDKJNv5fisHINAfVaOAmyfagv+QnCMNv4zZ9KHKrmAtm
X-Gm-Gg: ASbGncvuXlpomYSjclIG1pwbLoGuhMZmy2vbT92ptLY6JFwcVnnc7DxCq2niBz0x5Cq
	/OsMbWOsmAwrFOyIxVuq95U/TMgQ9b7i44S/V6RyfN6pQZVcc6gAdgXa7NAx4vk18aZ10OLt5u1
	ghkeEF5xj3d0CDgKhxr/V898GquisNLBSDFA9Y31SySpdyTyiSWhlgxNp94R+jjQ1x7Q7XcKEQ8
	b90JHuEgZx+zkBpHW/Q3xedopHmjlPIyOdA3I4N1zNrfG3/yM3eXKrccJkd/bY4KlEGJxJ+VXdo
	uTAQRmZkJ4NnTAUyOWJC3y8R6oU5Ip7bqxbQjnh869ZXGw8LgVXjRVBgOIURxhSQjJOJ5TcsPn/
	90O2LC2wGpeMB8tlJb6VMqkyAFIdOClXPjM9AHDvEo4YBjNwJKEHqT7KE0/HJfOkw
X-Google-Smtp-Source: AGHT+IFW/5FOxyFqj1+gS4iZbWkrMnNm7SEPeZdXIRSlHu3qHTX/3ekqpxHZW/pRpI0qkbfG1hNoJg==
X-Received: by 2002:a05:600c:4fc9:b0:45b:7aae:7a92 with SMTP id 5b1f17b1804b1-45ddded75e1mr12963215e9.21.1757157249223;
        Sat, 06 Sep 2025 04:14:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e898b99sm361608935e9.19.2025.09.06.04.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 04:14:08 -0700 (PDT)
Date: Sat, 6 Sep 2025 12:13:46 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Bhupesh Sharma <bhsharma@igalia.com>
Cc: Kees Cook <kees@kernel.org>, Bhupesh <bhupesh@igalia.com>,
 akpm@linux-foundation.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
 alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
 mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
 david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
 brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 linux-trace-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH v8 4/5] treewide: Switch memcpy() users of 'task->comm'
 to a more safer implementation
Message-ID: <20250906121346.3fa6ea16@pumpkin>
In-Reply-To: <d48f66cf-9843-1575-bcf0-5117a5527004@igalia.com>
References: <20250821102152.323367-1-bhupesh@igalia.com>
	<20250821102152.323367-5-bhupesh@igalia.com>
	<202508250656.9D56526@keescook>
	<d48f66cf-9843-1575-bcf0-5117a5527004@igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Sep 2025 10:58:17 +0530
Bhupesh Sharma <bhsharma@igalia.com> wrote:

> Hi Kees,
> 
> On 8/25/25 7:31 PM, Kees Cook wrote:
> > On Thu, Aug 21, 2025 at 03:51:51PM +0530, Bhupesh wrote:  
> >> As Linus mentioned in [1], currently we have several memcpy() use-cases
> >> which use 'current->comm' to copy the task name over to local copies.
> >> For an example:
> >>
> >>   ...
> >>   char comm[TASK_COMM_LEN];
> >>   memcpy(comm, current->comm, TASK_COMM_LEN);
> >>   ...
> >>
> >> These should be rather calling a wrappper like "get_task_array()",
> >> which is implemented as:
> >>
> >>     static __always_inline void
> >>         __cstr_array_copy(char *dst,
> >>              const char *src, __kernel_size_t size)
> >>     {
> >>          memcpy(dst, src, size);
> >>          dst[size] = 0;
> >>     }
> >>
> >>     #define get_task_array(dst,src) \
> >>        __cstr_array_copy(dst, src, __must_be_array(dst))
> >>
> >> The relevant 'memcpy()' users were identified using the following search
> >> pattern:
> >>   $ git grep 'memcpy.*->comm\>'
> >>
> >> Link:https://lore.kernel.org/all/CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com/  #1
> >>
> >> Signed-off-by: Bhupesh<bhupesh@igalia.com>
> >> ---
> >>   include/linux/coredump.h                      |  2 +-
> >>   include/linux/sched.h                         | 32 +++++++++++++++++++
> >>   include/linux/tracepoint.h                    |  4 +--
> >>   include/trace/events/block.h                  | 10 +++---
> >>   include/trace/events/oom.h                    |  2 +-
> >>   include/trace/events/osnoise.h                |  2 +-
> >>   include/trace/events/sched.h                  | 13 ++++----
> >>   include/trace/events/signal.h                 |  2 +-
> >>   include/trace/events/task.h                   |  4 +--
> >>   tools/bpf/bpftool/pids.c                      |  6 ++--
> >>   .../bpf/test_kmods/bpf_testmod-events.h       |  2 +-
> >>   11 files changed, 54 insertions(+), 25 deletions(-)
> >>
> >> diff --git a/include/linux/coredump.h b/include/linux/coredump.h
> >> index 68861da4cf7c..bcee0afc5eaf 100644
> >> --- a/include/linux/coredump.h
> >> +++ b/include/linux/coredump.h
> >> @@ -54,7 +54,7 @@ extern void vfs_coredump(const kernel_siginfo_t *siginfo);
> >>   	do {	\
> >>   		char comm[TASK_COMM_LEN];	\
> >>   		/* This will always be NUL terminated. */ \
> >> -		memcpy(comm, current->comm, sizeof(comm)); \
> >> +		get_task_array(comm, current->comm); \
> >>   		printk_ratelimited(Level "coredump: %d(%*pE): " Format "\n",	\
> >>   			task_tgid_vnr(current), (int)strlen(comm), comm, ##__VA_ARGS__);	\
> >>   	} while (0)	\
> >> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >> index 5a58c1270474..d26d1dfb9904 100644
> >> --- a/include/linux/sched.h
> >> +++ b/include/linux/sched.h
> >> @@ -1960,12 +1960,44 @@ extern void wake_up_new_task(struct task_struct *tsk);
> >>   
> >>   extern void kick_process(struct task_struct *tsk);
> >>   
> >> +/*
> >> + * - Why not use task_lock()?
> >> + *   User space can randomly change their names anyway, so locking for readers
> >> + *   doesn't make sense. For writers, locking is probably necessary, as a race
> >> + *   condition could lead to long-term mixed results.
> >> + *   The logic inside __set_task_comm() should ensure that the task comm is
> >> + *   always NUL-terminated and zero-padded. Therefore the race condition between
> >> + *   reader and writer is not an issue.
> >> + */
> >> +
> >>   extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec);
> >>   #define set_task_comm(tsk, from) ({			\
> >>   	BUILD_BUG_ON(sizeof(from) < TASK_COMM_LEN);	\
> >>   	__set_task_comm(tsk, from, false);		\
> >>   })
> >>   
> >> +/*
> >> + * 'get_task_array' can be 'data-racy' in the destination and
> >> + * should not be used for cases where a 'stable NUL at the end'
> >> + * is needed. Its better to use strscpy and friends for such
> >> + * use-cases.
> >> + *
> >> + * It is suited mainly for a 'just copy comm to a constant-sized
> >> + * array' case - especially in performance sensitive use-cases,
> >> + * like tracing.
> >> + */
> >> +
> >> +static __always_inline void
> >> +	__cstr_array_copy(char *dst, const char *src,
> >> +			  __kernel_size_t size)
> >> +{
> >> +	memcpy(dst, src, size);
> >> +	dst[size] = 0;
> >> +}  
> > Please don't reinvent the wheel. :) We already have memtostr, please use
> > that (or memtostr_pad).  
> 
> Sure, but wouldn't we get a static assertion failure: "must be array" 
> for memtostr() usage, because of the following:
> 
> #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + 
> __must_be_array(arr))
> 
> I think it would be easier just to set:
> 
>    memcpy(dst, src, size);
>    dst[size -1] = 0;
> 
> instead as Linus and Steven suggested.

The compiler is still likely to make a mess of it.
You really want:
	*(u64 *)dst = *(u64 *)src;
	*(u64 *)(dst + 8) = *(u64 *)(src + 8) & ~htobe64(0xff);
That may need something to force 8 byte alignment.
Or force 4 byte alignment and use a u64 type with 4 byte alignment.

	David

> 
> Thanks,
> Bhupesh
> 
> >> +
> >> +#define get_task_array(dst, src) \
> >> +	__cstr_array_copy(dst, src, __must_be_array(dst))  
> > Uh, __must_be_array(dst) returns 0 on success. :P Are you sure you
> > tested this?
> >  
> 
> 


