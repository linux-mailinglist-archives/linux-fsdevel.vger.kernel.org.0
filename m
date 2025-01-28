Return-Path: <linux-fsdevel+bounces-40191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E07A202F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 02:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C998165E32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 01:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A9F13C80E;
	Tue, 28 Jan 2025 01:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chawJ90G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13C42561D;
	Tue, 28 Jan 2025 01:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738027484; cv=none; b=OC5SrlA2nD2OIfLvObLjWv/h50ZMJVQf1ebIoCRMU6UFPMyQpqQLJxZf9sToyLZ9ETyfbs5O7I3vwjStdYJud7GJgU+sAZVdcjodFKYIzw7/SPkOmCMcS2W/vc552do4IRwD36dF9sxFcfG6r1DvyP0M8p/Ie92/UucWYbnvYc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738027484; c=relaxed/simple;
	bh=ZNOabaBUHCQqFjCjXCMWKlI0Rwj13ltQaBfx+WUZ8mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADtaIzJDfSBmIQfWr7Rb6Poh+iDtJw8V5Oan+HyXvEuBVQ6tW+RCkLCPRC7n7V/iR8p6GmsSGSVoseHmW/AHVVyQPoNUk75VzDVkmqe0LCCjS3X34pO3Tj1LX109jeDvhKUTcfxfdAaCFgraCUQ1A6I3uFJo4JbYuI9T4zZ/NbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chawJ90G; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso7015907a91.2;
        Mon, 27 Jan 2025 17:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738027482; x=1738632282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWL6C+kqpj+gBy0RfSYoYVLKnqSYvu312YXcNFBv0HU=;
        b=chawJ90GwrNmLt2XBnYzEYv0O6Gy+hSVYKAYSOKh7/gZpBLQovJ4TRu0k11eUzZWw2
         Qk7HRFUvLtFqKG/bIc0hzJIPIadvbHaWiRrJ7Th5hJR36/Xiq6YYAwF4YJSLHjY664Fq
         7ACXukrLnjRWCBgtoHq8UMWY4jKmuZIQKuIJ3tTW8HQHAm+r1xaxIAxAgO/HLPdT2dH5
         V4RDtnKttIYjZMqJxO4TAOzjNZc/hYG3PCuXTB2cyfSxZBKTIY68/UJY347lyvPkGHFu
         6eijoZnE8mH8X3eWrzuy8imzZWjxd8bwLR+Tdridt4WOBW/3hh4UZxlz4D4RMHTgPFUy
         6XAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738027482; x=1738632282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWL6C+kqpj+gBy0RfSYoYVLKnqSYvu312YXcNFBv0HU=;
        b=pfngPgtca3j9veALTvQXKcv8TXd8o5v+Q7VMFOAuWqxdY82V6oXrLPUs/lLC1fhbnt
         U83cBNw753DDd0e81rzbxcyf1O4vOzwMMVvINuf5LseRkbc4AkbC2CCtzpfVD6eXTWnJ
         538hSapnJBldnuPkQJ/XN6bJ4kihZBQEQE5llUrO82q6JEe8R0HWZOYSpVS8jwIooVuL
         vvylcomlnJdeE/JggeNqt+22rR+AQP6aVaxEEjLdouME5xHP9oq6teVSc4Su6Lww7CZ0
         pzaj2EQppE2OQRh8MxHcJl7hMPtbvDTUp1aZA9qEflha2q+jd3SGtx0Y2Hs/x7kXA2TF
         zctw==
X-Forwarded-Encrypted: i=1; AJvYcCUZugXEnBNa/wRI4lsSwkQCIAIFxW3DbOWuc9PuAvlbRKXWlHFGKyo2jsKLcaSKjxUL6th3+SVSlSVng+nLxd9Clf5y@vger.kernel.org, AJvYcCUhC2YLF7RHoVgmA6WLvBmBzcdMIQjMoNRkF3K7AyAuMlH56NEf3Pka73GQsq1FPowDuEHIjkNWA2Q7TC0w@vger.kernel.org, AJvYcCVIKacmH/Q9XmQH+yGl3Er7HWGnF3PONE5wgvqVHGbY/Eo8yZJBc644VJAz4CjvPqKu7ki+sDIzoiiXTq81mw==@vger.kernel.org, AJvYcCXWhjsgbTIILDJZFpCaqny+YmQNTi7EXiKX8FXbx7np366ogQ06BCiplnLSrXj0Fn7p7dw=@vger.kernel.org, AJvYcCXmGmRl9SCZX9DrTY+4TmyDHq46+Sw2udItLc2/TRlo+G8WQT/N4jzT8vp8Hkb8VEpmSm1sgPuKf+vZQkV9Q8LNxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjWWY8ZZ7Lb71rDp82iGjR6hyXZSzCHtB9Tkwt6PrnkE5FkoFz
	yRsvB0IafxWb8OAo5XJpXpFFRsh6hTMJSQ8Fr+uxcWg/SJV1HJMgWgjID518vktm3T7XBl8r5Br
	AKBqCiN6fhIFobj+HZ3DE+krXUKo=
X-Gm-Gg: ASbGncvcSR9m6TyvO2yh/Xrc7cUlAfrQxuKsbd9dbro3tSfbAfxtD/NL5WJWRCdJGet
	zSo7mOOjyx1ARA69MWqnjX3/g/wVvusDk6oCWW2PLwoeTaF6KjAQvgQQRnpWvIqCiWI2Yz69Kcl
	tbVg==
X-Google-Smtp-Source: AGHT+IEnr9Q9tZOl7yts+9JQOMhGxLXwor7F1+tEO7eO4lojdnHymfL2CNPa8Qw5kBoY8swBcV5WfM44QXbraQ4a4HE=
X-Received: by 2002:a05:6a00:2917:b0:725:b201:2362 with SMTP id
 d2e1a72fcca58-72dafa409b5mr61620850b3a.11.1738027481968; Mon, 27 Jan 2025
 17:24:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127222114.1132392-1-andrii@kernel.org> <20250127164106.5f40b62e0f1cf353538c46fd@linux-foundation.org>
In-Reply-To: <20250127164106.5f40b62e0f1cf353538c46fd@linux-foundation.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jan 2025 17:24:30 -0800
X-Gm-Features: AWEUYZk09zQNKSjG3RxZBbWMKxSCzryFhpuTAs83Pv_RrQIyT0M8-_pPLCp7Qxc
Message-ID: <CAEf4BzZmO0sBGRDp3MhMTWEfm-UamnJcoaEKqJXb33v9eyYEKg@mail.gmail.com>
Subject: Re: [PATCH v2] mm,procfs: allow read-only remote mm access under CAP_PERFMON
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org, 
	peterz@infradead.org, mingo@kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, shakeel.butt@linux.dev, rppt@kernel.org, 
	liam.howlett@oracle.com, surenb@google.com, kees@kernel.org, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 4:41=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 27 Jan 2025 14:21:14 -0800 Andrii Nakryiko <andrii@kernel.org> wr=
ote:
>
> > It's very common for various tracing and profiling toolis to need to
> > access /proc/PID/maps contents for stack symbolization needs to learn
> > which shared libraries are mapped in memory, at which file offset, etc.
> > Currently, access to /proc/PID/maps requires CAP_SYS_PTRACE (unless we
> > are looking at data for our own process, which is a trivial case not to=
o
> > relevant for profilers use cases).
> >
> > Unfortunately, CAP_SYS_PTRACE implies way more than just ability to
> > discover memory layout of another process: it allows to fully control
> > arbitrary other processes. This is problematic from security POV for
> > applications that only need read-only /proc/PID/maps (and other similar
> > read-only data) access, and in large production settings CAP_SYS_PTRACE
> > is frowned upon even for the system-wide profilers.
> >
> > On the other hand, it's already possible to access similar kind of
> > information (and more) with just CAP_PERFMON capability. E.g., setting
> > up PERF_RECORD_MMAP collection through perf_event_open() would give one
> > similar information to what /proc/PID/maps provides.
> >
> > CAP_PERFMON, together with CAP_BPF, is already a very common combinatio=
n
> > for system-wide profiling and observability application. As such, it's
> > reasonable and convenient to be able to access /proc/PID/maps with
> > CAP_PERFMON capabilities instead of CAP_SYS_PTRACE.
> >
> > For procfs, these permissions are checked through common mm_access()
> > helper, and so we augment that with cap_perfmon() check *only* if
> > requested mode is PTRACE_MODE_READ. I.e., PTRACE_MODE_ATTACH wouldn't b=
e
> > permitted by CAP_PERFMON. So /proc/PID/mem, which uses
> > PTRACE_MODE_ATTACH, won't be permitted by CAP_PERFMON, but
> > /proc/PID/maps, /proc/PID/environ, and a bunch of other read-only
> > contents will be allowable under CAP_PERFMON.
> >
> > Besides procfs itself, mm_access() is used by process_madvise() and
> > process_vm_{readv,writev}() syscalls. The former one uses
> > PTRACE_MODE_READ to avoid leaking ASLR metadata, and as such CAP_PERFMO=
N
> > seems like a meaningful allowable capability as well.
> >
> > process_vm_{readv,writev} currently assume PTRACE_MODE_ATTACH level of
> > permissions (though for readv PTRACE_MODE_READ seems more reasonable,
> > but that's outside the scope of this change), and as such won't be
> > affected by this patch.
> >
>
> This should be documented somewhere, so we can tell our users what we
> did.  Documentation/filesystems/proc.rst seems to be the place.  .

Wow, that's a big file :) Funny enough, that file mentions ptrace only
in the context of /proc/<pid>/timerslack_ns, nothing else. Hm.. Should
I add a common section saying something about how either
CAP_SYS_PTRACE or CAP_PERFMON provides access to other process' user
space information?

If that's ok, I can send that as a follow up patch (as I bet there
will be a bunch of iteration on exact form, shape, wording,
placement).

