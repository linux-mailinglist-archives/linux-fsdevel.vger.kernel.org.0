Return-Path: <linux-fsdevel+bounces-39447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E37A1442C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 22:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347623A8327
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 21:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE023241685;
	Thu, 16 Jan 2025 21:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXGx0iKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1256198A0D;
	Thu, 16 Jan 2025 21:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737063833; cv=none; b=RW/3q+4jegxCjBynv7+4qwzHKnnZudJqIpvNYCoEkRzHmp+daZsVQSONORN5L/LXrhfrOSgYkg60hs6kDYNNGOZ1h2RiOeG5hXRZtasD2+9XNMRMbeNw/n4sNAP0OwxdcwmFmzA2Rm3dAwliAq2TKYMtnjXPv/NmgdOXLjY28so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737063833; c=relaxed/simple;
	bh=5XoSD9plel6+bX4wmbKVhcepR7Jv7EhvxrWMD3mEGf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYPqBSARnYhZE2E67/0Joo+F9CGlFOj4LzteZTpa5d4zqz+WeZSh8fMmjjqoWz3lMawQpxxiJFz3tt26fhyTl+pJGfLS1Nrwsy4rt6XcBvAOWN2vs1Kq/BrUu1ABDoyTyuj0fuMP5s6cBIU+jmdGUt0VP7Kt98sGZwy9GL2zNmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXGx0iKa; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216728b1836so24919385ad.0;
        Thu, 16 Jan 2025 13:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737063831; x=1737668631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxqWsllDy+gy+gAHeT6UbRVcmkocjbQQvQ+WdwmgTjI=;
        b=QXGx0iKaLX25eQc7w5xY7Cl+cAdgJujel73PzjMAA6zV0wI8ut4A3aLS3O2ab89Ns5
         9ZecSyjIsEIQAyHQKELPJ9qX2TnMtzcAwlFEDz31P5/E2/ivncZXCQDcw/iA2BOU6uzO
         w/WzeXOEwVqnFmI+kh5VhvCmx67gGQ3r/3yNEMoi7/SdMzq7uiSKmNxbDwulrEHCTK67
         1BeuNW4vzL8XqECJVErUJJ+6t1lAPy1r0Ig36mu3rh603CI1jDkzSXnzPROyEXX0OAXL
         mjqDwtW4yMAliI79ZVuiteOAznRK2a4xge7YZBvjMWVpGI0w6TYmqDNySvHlNzNSAwdP
         7iwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737063831; x=1737668631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxqWsllDy+gy+gAHeT6UbRVcmkocjbQQvQ+WdwmgTjI=;
        b=jzr4DvCQDJN1KshPpRzfnSl8UtRBfApcYmVi4Z9HoKa0RWtcu+J5QgLYx0kFtGCFMc
         k3CA2qIpzBorO+gr/DK7TzZtfyj9K/Nt/3No4e+2M/x/8mVr55u5HMlCktCpVi7Avk9h
         Pn3EYGUoixpFLizwQFfiifWaxFcU1/expF2YzcGOWGgMXnlt6sD81oe4Gube0dsBfZBQ
         HuupidTZxhSeaAp6FffFOzttLmPNBxyZKv7/z6rmjJ6M2/EEavfQ0P2ymKo+kMfLy7FG
         3ssuGNd4iuvJHntEnldjvjPEHdl8Xht3/3sW3VJeM1y5RGSKQLTVCZa6KLfzzH1BgTcC
         z7Gg==
X-Forwarded-Encrypted: i=1; AJvYcCU9wui3XlwqHsElZtpqphcrhWc43bvD1TDQN4YhS60dy0E8SiChzQJf6F61qnCaWJ3Q6nQuM70IVWvJUvCsUg==@vger.kernel.org, AJvYcCUvasf/r3Rlt4xCY5+7y92nBJLQqazwGzKd8s8mU8uLiHHtqjF9Tt4Y6DsCxP2WMFxNFP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGcwZEbmqjNFTCJfbon04SOZwIZGxyV3JKtg+fCCC05KxWkxMf
	S0Nxf+xh7Nov404cMTrjnjD5Xr9eHOIruCe5d39iqGkqXRW4nZCIupvrDUXu3P2dknM3xthcRLg
	Q0rraS75GTFGKpjE7+FNg8qGO9UGyjQ0K
X-Gm-Gg: ASbGncvHIpUI9fHP27+W6mK5Q4X5tzk16H6BF0o50xtor/ztF8tiSgeEARaToiEnNki
	vEifsHk8KE/YQzlFHDW4ExyDbwRAr2PDL+wX6
X-Google-Smtp-Source: AGHT+IFJ8nfvyxrTqg6VxOKD0CufFjU1A2OBqv/Q8IbOnctjE7U7MK2YC0UxDWKTh/Q0FC+Z0t5Zxuu/xq1hLlP3kJk=
X-Received: by 2002:a05:6a20:3951:b0:1e8:bd15:683e with SMTP id
 adf61e73a8af0-1eb21485986mr265362637.10.1737063830859; Thu, 16 Jan 2025
 13:43:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116124949.GA2446417@mit.edu> <Z4l3rb11fJqNravu@dread.disaster.area>
In-Reply-To: <Z4l3rb11fJqNravu@dread.disaster.area>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Jan 2025 13:43:39 -0800
X-Gm-Features: AbW1kvY6e2rA2HpeJQdPmEaWaAGzDu9n4853huC-0TDKG6x8zzSYBXV4e3IoCIM
Message-ID: <CAEf4Bzbe6vWS3wvmvTcCAQY6bZf2G-D6msgvwYHyWVg3HnMXSg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] time to reconsider tracepoints in the vfs?
To: Dave Chinner <david@fromorbit.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org, 
	Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 1:18=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Thu, Jan 16, 2025 at 07:49:49AM -0500, Theodore Ts'o wrote:
> > Historically, we have avoided adding tracepoints to the VFS because of
> > concerns that tracepoints would be considered a userspace-level
> > interface, and would therefore potentially constrain our ability to
> > improve an interface which has been extremely performance critical.
>
> Yes, the lack of tracepoints in the VFS is a fairly significant
> issue when it comes to runtime debugging of production systems...
>
> > I'd like to discuss whether in 2025, it's time to reconsider our
> > reticence in adding tracepoints in the VFS layer.  First, while there
> > has been a single incident of a tracepoint being used by programs that
> > were distributed far and wide (powertop) such that we had to revert a
> > change to a tracepoint that broke it --- that was ***14** years ago,
> > in 2011.
>
> Yes, that was a big mistake in multiple ways. Firstly, the app using
> a tracepoint in this way. The second mistake was the response that
> "tracepoints should be stable API" based on the abuse of a single
> tracepoint.
>
> We had extensive tracepoint coverage in subsystems *before* this
> happened. In XFS, we had already converted hundreds of existing
> debug-build-only tracing calls to use tracepoints based on the
> understanding that tracepoints were *not* considered stable user
> interfaces.
>
> The fact that existing subsystem tracepoints already exposed the
> internal implementation of objects like struct inode, struct file,
> superblocks, etc simply wasn't considered when tracepoints were
> declared "stable".
>
> The fact is that it is simply not possible to maintain any sort of
> useful introspection with the tracepoint infrastructure without
> exposing internal implementation details that can change from kernel
> to kernel.
>
> > Across multiple other subsystems, many of
> > which have added an extensive number of tracepoints, there has been
> > only a single problem in over a decade, so I'd like to suggest that
> > this concern may have not have been as serious as we had first
> > thought.
>
> Yes, these subsystems still operate under the "tracepoints are not
> stable" understanding.  The reality is that userspace has *never*
> been able to rely on tracepoints being stable across multiple kernel
> releases, regardless of what anyone else (including Linus) says is
> the policy.
>
> > I'd like to propose that we experiment with adding tracepoints in
> > early 2025, so that at the end of the year the year-end 2025 LTS
> > kernels will have tracepoints that we are confident will be fit for
> > purpose for BPF users.
>
> Why does BPF even need tracepoints? BPF code should be using kprobes
> to hook into the running kernel to monitor it, yes?

This is way more nuanced than that. There are at least a few
advantages that tracepoints have over kprobes, even if both are usable
(and useful) with BPF:

  - kprobes very often get inlined by the compiler (especially if they
are static functions), making them unusable (and kprobing inlined
functions comes with a huge set of additional hurdles and problems, we
don't have to go into details here). This is probably the biggest
issue in practice for which tracepoints are way-way better.

  - raw performance: tracepoints are *significantly* faster than
kprobes (like 2-3x less overhead, [0])

  - relative stability of tracepoints in terms of naming, semantics,
arguments. While not stable APIs, tracepoints are "more stable" in
practice due to more deliberate and strategic placement (usually), so
they tend to get renamed or changed much less frequently.

So, as far as BPF is concerned, tracepoints are still preferable to
kprobes for something like VFS, and just because BPF can be used with
kprobes easily doesn't mean BPF users don't need useful tracepoints.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240326162151.3=
981687-3-andrii@kernel.org/

>
> Regardless of BPF, why not just send patches to add the tracepoints
> you want?
>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com
>

