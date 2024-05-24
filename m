Return-Path: <linux-fsdevel+bounces-20132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC2A8CEA4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 21:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC651F21B08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 19:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FFF5F47D;
	Fri, 24 May 2024 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ulzdx/3z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CEE5CDE9;
	Fri, 24 May 2024 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716579033; cv=none; b=HBJOpjZQkMdylN7GT4CYxrdU7z+OgnAgsLD4QIuh7kV7lA5ADmjKlTSuTdrZWnVdZwaHUM8zSzIiMMDi/AbtOnVtgchopkMyygaJCqD7Oft22pEuC7R7v09u8DHHo8qtPuRbZqcPwPhCGks9b47XMtjDAueMC4gpzip4xfTEPn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716579033; c=relaxed/simple;
	bh=dzHU3P7qRxjg2ho0r9MNensCeoxNpPcQCmFpOL/oYJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnqtJfzBRM5QCN/b9OWVfYHSKuZ8rQwZ+ynWgzbPISlelMN/uW2gg60rwlxwYmMkYunzlXaBhpsIH3wVBB+g8CPtrM2do/IzwXbCGCd12ShpA5fpMqpl5iDvoGGah/7uO5lhYI9jjCiCknLmW9KElgIQ38UFlO5kRDD3cGM+0z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ulzdx/3z; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f32b1b5429so21791305ad.2;
        Fri, 24 May 2024 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716579031; x=1717183831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzHU3P7qRxjg2ho0r9MNensCeoxNpPcQCmFpOL/oYJM=;
        b=Ulzdx/3zkLYBhCIXLDCB3IAMbe0FHGpUsNyY/BosEydFd5j+G8yMgXmY17JwvNBYGt
         7m3v+dBkQDUOQSxRP+KbfKg2NazeMeFPNFKJp9icZKsVuqSt4mNdp8wZsiCOyTU1XLjf
         pTx6hE77O7JG51cvDVf1WITsVYvWZunVDRpifVhHobzwyo4y2zl8ETcPkc6dtN+UHJPh
         Ih3sdiO3ddxJclK9+KU1f/yjpT3dZSEucBd2luExtUNtIxMh1hXNH6ix7SJj/YnzOwcV
         e4ZkjDPw4ZYIATY4/6TkkQw8sOs8iVlvjZuAuMWtMdAtodh4/35oM28oaAoEc62VCMy4
         y1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716579031; x=1717183831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzHU3P7qRxjg2ho0r9MNensCeoxNpPcQCmFpOL/oYJM=;
        b=PV6zHif/uRqu2XwnoBMWQmff7A1Ilf+b3l0deaCpXQ4Pm+ZL1+vAFb7ilmJ37n+IL7
         8UJuI+kEJE7YvKDET15e2Yy0jzY+Sy6mM7tQe3ShU1H89T7ESpO8lDFy/hKINjdxAE4J
         HNE5YQd8yXzydm8qh0eFfv7li7IupViKV9Oo4jOHjaXCtFm5e+Fig6U6nQp3Ov5ypoZH
         hNQrsui0qPy5pCIRl91ZHKDIYwGsW8fdtmD2+dh0l+0SQ7jW9vBqWIuJXxkgNiVLgk00
         5BDKw/5D/wf4ZXY5xUJj/aa14FrGpkBBSqCbEASd7XLofyXpWECFkM4JVXuo4e+LQP44
         4oaw==
X-Forwarded-Encrypted: i=1; AJvYcCWp11Cw/58Rz5v8bmNjrD2S9apEhtC74GTxEacIOzfY3WbdHvfb/MDnuY98P+jbnLVzJ1YMTLKH6tVZ5ZEcIOgQ9lBZhD2UESvTtCGgx+LF9mhuSUIMf9IOOe7miITJpPVGx4HXjKj7bxFvWmeN/d27Oiivy2CuWL8Ew3g6uSYJSQ==
X-Gm-Message-State: AOJu0Yx/yxdvV0WCDwhPeDBJc1wAO646U5woOsg+7hnVi/TkM5NuBpBD
	7K3l6Z0+eF7oWYro01m6zbzUXaRxof45ExxzitfJ6wprkbvXIQG0E8nnjRvV6D9UjIVqapVAPdf
	nM6ug/k5L2jTbvQen3sz09UNdJ2Q=
X-Google-Smtp-Source: AGHT+IErPGmKm79ivkmkKeo0JgNi86h6exL4rS7HdkRJQeYCQL17fT0j3PSVuuXjGNENXBV8IjvDmTQR0TXeOsBeJjw=
X-Received: by 2002:a17:902:ecc6:b0:1f3:4348:15ca with SMTP id
 d9443c01a7336-1f4486f294bmr43420585ad.25.1716579031155; Fri, 24 May 2024
 12:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524041032.1048094-1-andrii@kernel.org> <20240524103212.382d10aed85f2e843e86febb@linux-foundation.org>
In-Reply-To: <20240524103212.382d10aed85f2e843e86febb@linux-foundation.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 24 May 2024 12:30:18 -0700
Message-ID: <CAEf4BzaT0yVenLQWc7Be+Y+yYhrfUR=gi-PyzVarQam9WqzESw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] ioctl()-based API to query VMAs from /proc/<pid>/maps
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org, liam.howlett@oracle.com, 
	surenb@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 10:32=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Thu, 23 May 2024 21:10:22 -0700 Andrii Nakryiko <andrii@kernel.org> wr=
ote:
>
> > Implement binary ioctl()-based interface to /proc/<pid>/maps file
>
> Why an ioctl rather than a read() of (say) a sysfs file?

This is effectively a request/response kind of API. User provides at
least address and a set of flags (that determine what subset of VMAs
are of interest), and optionally could provide buffer pointers for
extra variable-length data (e.g., VMA name). I'm not sure how to
achieve this with read() syscall.

Kernel has already established an approach to support these
input/output binary-based protocols and how to handle extensibility
and backwards/forward compatibility. And so we are using that here as
well. ioctl() is just an existing mechanism for passing a pointer to
such binary request/response structure in the context of some process
(also note that normally it will be a different process from the
actual user process that is using this API, that's always the case for
profiling, for example).

As for the sysfs as a location for this file. It doesn't matter much
to me where to open some file, but it has to be a per-PID file,
because each process has its own set of VMAs. Applications often will
be querying VMAs across many processes, depending on incoming data (in
our cases, profiling stack trace address data). So this eliminates
something like prctl().

Does sysfs have an existing per-process hierarchy of files or
directories that would be a natural match here? As I mentioned,
/proc/PID/maps does seem like a natural fit in this case, because it
represents the set of VMAs of a specified process. And this new API is
just an alternative (to text-based read() protocol) way of querying
this set of VMAs.

