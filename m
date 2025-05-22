Return-Path: <linux-fsdevel+bounces-49655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6828DAC0470
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 08:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5345C1BC070D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 06:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61915221D87;
	Thu, 22 May 2025 06:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3WuAeqQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47788221728;
	Thu, 22 May 2025 06:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747894552; cv=none; b=Ss1kwyXw1K3cHMmRrOVhFQMOOpMNvq9z5Ot5fBVZwjAVwE9pUJg6ves2e1ekFbzs6Pw6F8Vsi6dWqia2MJRIz/eaLChzPMCKnqyNlgSyZFCBTOgpcJ6H6csDWmCP24YrQvtZO0z8slCEVo0lOB9lhso2aDx/nzd51R2NkrwZvc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747894552; c=relaxed/simple;
	bh=iqpb1rYrNkcWfeBryIxnBxG6EOtFDvLTGg/V1cSIVgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QP9iYMPEvvQ+ngOoHPhWZW90wFgA2lVcb3lxVxB2264U2FAx3oSCB/9nfGyAGLku+nFcxRUvYK1L0dxQB/f/0JFQhh+aMqXb+KD8Xkh721iRe/2i2J10p1PEbel1aYsLqMaEWrnk7g0vERHkMreH55U3TgsvLYhER6dhZ1NYVkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3WuAeqQ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f8b27c2d7bso79490536d6.1;
        Wed, 21 May 2025 23:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747894550; x=1748499350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXdrQudC82M+RXWv3KT75ifthrQS/0PqWGPX1TzmJn0=;
        b=G3WuAeqQZ90FGfft9iSpmrwzie6mT8mrU2ygiVXrXmld+nA1LK8B0tGz1rF5sv/oG8
         14hxrN/OGbUlMsNLMBoReTATFn/093/hunUT1CWpCOS9fPTCp2jcr32xUcI0SoC5gqWh
         effvsmpkfW+Eo+EVpMiiuNJVNnXfYnYrDYACQs3D6hUMkAJ+8t6dMhuqxe4MqPDsIC1Z
         aEXMrWrkf02ysfMwMJ+9T5uAJ7HzRa0rwzhnfejWfSZBrEzUIVu/n+rG8HyXyEe+ehav
         0LmlHu6bhm7XMlFqBEih1pprPmixIwXYxWkltDhrxB3JjLV7SUBUBeTLNW7ewzyNqoqA
         DjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747894550; x=1748499350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXdrQudC82M+RXWv3KT75ifthrQS/0PqWGPX1TzmJn0=;
        b=D/rHNAxO3iTFXzZG1LKFtCionYh6/kqbefSWdfE82CtPAFszs1rIV6rAXKquYNO5lb
         WWHjDlUwd3qasYBIbqlQk/7wjLXeA8hMX/vYd2oGg6he6MBZ+L0swWKKg+xl/KaauNOw
         dlncJ4bUuZ67ijnT+RO0AyzK3UhyZodc+KMitXFQ4by9AnLK5P0AH1YTk9jIy+T8ocJo
         lT7jL6Dj0CXUm5aR2W7+FijLtBU8f+jUgSZC+A7VKP8AeNIkjJJqqCYWDvwwCjX4/P4K
         jeEH5n/RxbgGabzwTZhBoc8JjBb7N7a0F+Rk3T7rvyOrZYRQK/4+9hVi+mqIQk2DwAEQ
         px8g==
X-Forwarded-Encrypted: i=1; AJvYcCUPL/wr5QJ7v4oF0S4LlKhZTxeXV9eeOyoWOG8sC5oYNJMRLGmRetAfxHoy9Y86fv1sjjhHiUS8op6Cx9uu78MK/96l@vger.kernel.org, AJvYcCUU8QqIVq78Aa2GFA57KgSOoEjLN9mLENRQjcwUycOuCareeLB6fK60rKo3FbUGgFSa+ALkjKDHMipjvnNYfxP5hA==@vger.kernel.org, AJvYcCXRcMozYEy4eOMs+MfAS+4jBAT3kXVgRDUOf1owkYOpAkshMDYjGbeKNiOJxWHn0CIC4B0=@vger.kernel.org, AJvYcCXY5Utz4t455yh3ZQz3oWmJUB6TUxCpF6yM50YNZ/DxfQ9ixz2KEC5zp8zHJvlX84wQxinO16g8WfO0qgOe@vger.kernel.org, AJvYcCXfyNGZpSMmx1ko7MS2QHtgYXy1X/21qq4o9bpjyzfPX1F3KydDfQETaL87cTm2x3zmb6VLF94IPy3otxIzsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZxhYQLbNO9kazkUPNCgJymDV5hJWxDN8CQsh8V8BgmmeoyVJd
	HuDIprf44bsPJqfnVvc+4W2Ta+edH4L7RINxby9vGzZLF+efoJAYR+AXsSNe/M0ZLogacszSfeE
	Wz2m2UX7i212MnKnJw8PV3w+zJkVbha4=
X-Gm-Gg: ASbGncs1gb4wm1gLCpoSYLLRxa/pyHSoBBXxFSbWt96+NdrSYdWGz1TqTnIGTr1XZJT
	UENHH1s4t5uGjdJa9MDvf7CpoJJWQEeLm3Yorf8jbMYWJfxAAK6l9C5WfTIpUsffWx7ZoNR8MCa
	j7DxQJIHt0RKzMWZVCOy+bYcnMKiSmqQNT8g==
X-Google-Smtp-Source: AGHT+IFKOC9mEYSOYCwZB+hNIAN37e7Pn0LuF6NZH6cBUxj4agI/PryyRfq8gu07V1D2LotWOWiLP5xa0GVKeJ6VviA=
X-Received: by 2002:ad4:5ec8:0:b0:6f5:4f18:81d9 with SMTP id
 6a1803df08f44-6f8b2d41e47mr406849736d6.23.1747894550006; Wed, 21 May 2025
 23:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521062337.53262-1-bhupesh@igalia.com> <20250521062337.53262-3-bhupesh@igalia.com>
In-Reply-To: <20250521062337.53262-3-bhupesh@igalia.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 22 May 2025 14:15:13 +0800
X-Gm-Features: AX0GCFvAMu94jah4jA_vOqZJoCDzlxV3FYoqVXzO2soNYAKD2LF9n-3UXNqK9FI
Message-ID: <CALOAHbCm_ggnxAtHMx07MUgnW01RiymD6MpR7coJOiokR4v52A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] treewide: Switch memcpy() users of 'task->comm' to
 a more safer implementation
To: Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, pmladek@suse.com, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com, 
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com, 
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org, 
	david@redhat.com, viro@zeniv.linux.org.uk, keescook@chromium.org, 
	ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz, mingo@redhat.com, 
	juri.lelli@redhat.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 2:24=E2=80=AFPM Bhupesh <bhupesh@igalia.com> wrote:
>
> As Linus mentioned in [1], currently we have several memcpy() use-cases
> which use 'current->comm' to copy the task name over to local copies.
> For an example:
>
>  ...
>  char comm[TASK_COMM_LEN];
>  memcpy(comm, current->comm, TASK_COMM_LEN);
>  ...
>
> These should be modified so that we can later implement approaches
> to handle the task->comm's 16-byte length limitation (TASK_COMM_LEN)
> is a more modular way (follow-up patches do the same):
>
>  ...
>  char comm[TASK_COMM_LEN];
>  memcpy(comm, current->comm, TASK_COMM_LEN);
>  comm[TASK_COMM_LEN - 1] =3D '\0';
>  ...
>
> The relevant 'memcpy()' users were identified using the following search
> pattern:
>  $ git grep 'memcpy.*->comm\>'

Hello Bhupesh,

Several BPF programs currently read task->comm directly, as seen in:

// tools/testing/selftests/bpf/progs/test_skb_helpers.c [0]
bpf_probe_read_kernel_str(&comm, sizeof(comm), &task->comm);

This approach may cause issues after the follow-up patch.
I believe we should replace it with the safer bpf_get_current_comm()
or explicitly null-terminate it with "comm[sizeof(comm) - 1] =3D '\0'".
Out-of-tree BPF programs like BCC[1] or bpftrace[2] relying on direct
task->comm access may also break and require updates.

[0]. https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/=
tools/testing/selftests/bpf/progs/test_skb_helpers.c#n26
[1]. https://github.com/iovisor/bcc
[2]. https://github.com/bpftrace/bpftrace

--=20
Regards
Yafang

