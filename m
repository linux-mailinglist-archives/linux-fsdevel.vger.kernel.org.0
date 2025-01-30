Return-Path: <linux-fsdevel+bounces-40459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 198C3A237AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 00:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D7C1886A44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 23:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10CF1F1906;
	Thu, 30 Jan 2025 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEc/vxPt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E61ADC6E;
	Thu, 30 Jan 2025 23:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738278668; cv=none; b=gqDmMpr4Z6X9+rJvcHH06P/pbXH/KdpDgDquSp/oej81hRF6nEORMINkCarcPB3w08UMYuNeg7lNNMlU3JlP7fSGUcymB8gyhVbOw/uF3963fA7b4Cz1JI/Rh9q39zZ4BK52DgpohnAEVHh3aZC0pRQeNyUr5SyRfhbfIHSMzb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738278668; c=relaxed/simple;
	bh=4oi7WkhOykWli13EBEjA9VAtEU7v5puC44lrglxVQGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHd53rxghLWjIxkmVB/g3Z4oa47mtvee5a/DcCUU1dzxKtS/tDU5Otex1F3/JL+//26PH7RFl+8Qv6x5DXvwdhovN7G17hV2Una16gSSTbjQt2ibS3ENWFK3tNM/ZFmrEn+u4zZWNDoI7xukGmyypCipnotDC+PmThpbkx169BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEc/vxPt; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4afeccfeda2so784103137.1;
        Thu, 30 Jan 2025 15:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738278665; x=1738883465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znFKl7btryDHSHgPOHjNvbE4o0Vi9WBPek7/nfXpsCI=;
        b=IEc/vxPttf2yotk4oDx8VKyVwRXBEgS+yuWG1Th5ZtTo3gQJMCs+Dg5hN6irhfUOvW
         a1F72G6prPe48LXRL5WzV+BB9qkz79fnshVMXad9sbqkRVrxbCJ5dr1o9+DbjERtFoUT
         RuMcGIegd2suGHA9FQU/DUwbFNyOOzF+fHQmaRbPT8aMJ58R6R+uCvb2tVDZO7XhEDN9
         KK6imtqAEtrEF7KmUff1EZt8i6PT28cRaWXxwRlyTtr1ac7piPJ8FFPN5EhZTAGC7oPy
         lX/1tvpEk197LTHwhPyhZubvkXUko+dsxjLk9CDFKkh1Nfpmji3K1nqSRGd/wdOzk3Kg
         BxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738278665; x=1738883465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znFKl7btryDHSHgPOHjNvbE4o0Vi9WBPek7/nfXpsCI=;
        b=WbhlvSlYJ4NdTMbkRpU/6KHhwoSkuWnIXOb+vtyvFymsHRvmdC/1WgyTeRgHdf4b7G
         LpQglsmVhoHGqCLVI79kDoRMNdYh2fPrJG0QaUqEPhnWWYGvDGTB6DYx6fNwWeXTG8Rg
         7/Pfp9hzS5KBEhJJFOi5GtziLoivSxVT24S+XyfWMTYs89HD9qZTlnMhRKMT7i7CMMHF
         2xWvU8XqAMNjxGrsfEDnmRe+nlKXw5mwUqyx9ZVYRAsfn0osuPm63OWKpxt2KLVQHz6b
         DvVi2/dkuFdI0bch9AnY4VgeCaW9vYRJvy04fVcWagmuyZameAqTffO2v+/2ov90oqJh
         KAdw==
X-Forwarded-Encrypted: i=1; AJvYcCU1rH8CpzLu1CSsdTJLsn7gqcfXzcN7DlOkUhfgzWpcfH+nGisE4GMcJcl5oLxSHgQNgOOmwVWhuxc=@vger.kernel.org, AJvYcCVLcYiICPolkNBw06Rtetu+YF7ZRE4/lGLzCvg4gp3rKXJgPa3fylTnrmpOdC+0t5abu9rgFQcb5t6CBk4h8A==@vger.kernel.org, AJvYcCWhmHyv1z/QWxFf9d8oRcr68metVWUtQk+vrCibdXYpGtNRNqNPdnmDKYtCylW4AIbmmLmo98/cz05udVKO@vger.kernel.org, AJvYcCXiKi8ExzIeDz/R4pw6RSgxvO+r5KPUh28TvvgUkAuwGJ2TU+fWDihfLfNBTEjpkJWptaOHSON81bM4qfzrRGUu@vger.kernel.org
X-Gm-Message-State: AOJu0YzrPXYvrdFfU8xrzYj7By20+ex817bCKNkFKI+rnLMF2C2CfFsI
	3nqcVVoe2oYC/a+T7ojm6hsZ/Q3crerPNwYVX2x1Z5Nw5xRmyaUijNuXVVcFx+gj34MzQsx2pJh
	F5wg3uZIF6Gi1VcXRQ6+5sF51gfE=
X-Gm-Gg: ASbGnct4luJv6hVKKukDxLgzpxJVI8tlj8/X++0gvK2d/q9M8xc/AWaShI60JoV8AW8
	Pw45cBEsX19EjA9Q8NCmnjAQ06+jl2GZIzJDM67+m1sho46XHkePgkhLa5TpRwyws0sBZ7J68Hu
	H+UBswPAA+0MwUafBkY/sxIWDEW4AN
X-Google-Smtp-Source: AGHT+IH321PwJ0JRe/TSN6Zq0CSS5XUFlEth0ZB5Qv/4uCWWpKVwiJAOQGxksILWCWGFRbYS1xxOd6AMeabTzOckwZI=
X-Received: by 2002:a05:6102:800e:b0:4b2:5d10:58f2 with SMTP id
 ada2fe7eead31-4b9a4fc15bdmr8330026137.14.1738278665572; Thu, 30 Jan 2025
 15:11:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
 <20250130143754.1b8bb87bfb15175dd434529b@linux-foundation.org> <b396487f-b906-410d-9ff4-6956d99e2771@lucifer.local>
In-Reply-To: <b396487f-b906-410d-9ff4-6956d99e2771@lucifer.local>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Thu, 30 Jan 2025 23:10:53 +0000
X-Gm-Features: AWEUYZnZZOqxt2g398Nfl9bIz1LO0I91OZyVTPzRfWiKq3aimpDNM3XoQZ6Iau4
Message-ID: <CAKbZUD3w4_4MjrME-0mgRL01eFggb7et2BLa6012tzQX78KK9w@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] introduce PIDFD_SELF* sentinels
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 10:53=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Jan 30, 2025 at 02:37:54PM -0800, Andrew Morton wrote:
> > On Thu, 30 Jan 2025 20:40:25 +0000 Lorenzo Stoakes <lorenzo.stoakes@ora=
cle.com> wrote:
> >
> > > If you wish to utilise a pidfd interface to refer to the current proc=
ess or
> > > thread it is rather cumbersome, requiring something like:
> > >
> > >     int pidfd =3D pidfd_open(getpid(), 0 or PIDFD_THREAD);
> > >
> > >     ...
> > >
> > >     close(pidfd);
> > >
> > > Or the equivalent call opening /proc/self. It is more convenient to u=
se a
> > > sentinel value to indicate to an interface that accepts a pidfd that =
we
> > > simply wish to refer to the current process thread.
> > >
> >
> > The above code sequence doesn't seem at all onerous.  I'm not
> > understanding why it's worth altering the kernel to permit this little
> > shortcut?
>
> In practice it adds quite a bit of overhead for something that whatever
> mechanism is using the pidfd can avoid.
>
> It was specifically intended for a real case of utilising
> process_madvise(), using the newly extended ability to batch _any_
> madvise() operations for the current process, like:
>
>         if (process_madvise(PIDFD_SELF, iovec, 10, MADV_GUARD_INSTALL, 0)=
) {
>             ... error handling ...
>         }
>
> vs.
>
>         pid_t pid =3D getpid();
>         int pidfd =3D pidfd_open(pid, PIDFD_THREAD);
>
>         if (pidfd < 0) {
>            ... error handling ...
>         }
>
>         if (process_madvise(PIDFD_SELF, iovec, 10, MADV_GUARD_INSTALL, 0)=
) {
>            ... cleanup pidfd ...
>            ... error handling ...
>         }
>
>         ...
>
>         ... cleanup pidfd ...
>
> So in practice, it's actually a lot more ceremony and noise. Suren has be=
en
> working with this code in practice and found this to be useful.

It's also nice to add that people on the libc/allocator side should
also appreciate skipping pidfd_open's reliability concerns (mostly,
that RLIMIT_NOFILE Should Not(tm) ever affect thread spawning or a
malloc[1]). Besides the big syscall reduction and nice speedup, that
is.

[1] whether this is the already case is an exercise left to the
reader, but at the very least we should not add onto existing problems

--=20
Pedro

