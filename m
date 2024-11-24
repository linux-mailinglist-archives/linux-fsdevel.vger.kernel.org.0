Return-Path: <linux-fsdevel+bounces-35713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC579D7709
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 19:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314622839FC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 18:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D77213D8A0;
	Sun, 24 Nov 2024 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fvBAQwaT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC9D6F2F3
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471246; cv=none; b=Vlz4i8M/MNe760ErFL64cKBzYQE1amLhQjxBuiMXpK6UdCF7wOb/AeCuF1mgwqp8ZFWl/dZMA8M/IZAMjvaOjmBagDKblcSAnh6NR1ha7kKOhMbY30nRZQktFY5hg5bz79IlNSEGPA7k5qncqK0yMH4qD+maF9pZv1hOFQ1KzW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471246; c=relaxed/simple;
	bh=MHRc+EZrsf2NABDvI/J/e1unkMv/9URuKXuZyw9v07o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdcNGIgk16EpNRj77ynv7jHyUhqxhJbS+G14Gb/3srNWVS73L3J36z/oqeH3/E2sjRXBJ1jW90QrKs+5cgC58yYXaBuCwRUP3r65jKnLLUHJzjReKCktIGWU/bEYGtGOug9MWqjET5EirtPQd/yZIbFUMklEAYW9HI3D2fJXJvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fvBAQwaT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cfddb70965so4777358a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 10:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732471243; x=1733076043; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eFtkAkE9w9ozdnjm+X092ocX1iqcO1qOEalWj4WqRqg=;
        b=fvBAQwaTB3Y5i3EuAng4142HiKE0L7NtWy9Jl13+QprMuoj07POmdz9C8T6u6g2i26
         q+YXDdKyH1lTMyznGBE0zvCPiUlK5l4tfjqM1zM5fmKPxF0Va636UQXlB1EN2prHqHZk
         k7nbDHM2kaXmdmhbkvrbf0g6sBIAzTgb203VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732471243; x=1733076043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFtkAkE9w9ozdnjm+X092ocX1iqcO1qOEalWj4WqRqg=;
        b=eBadzT0kgBLFWc+dYLEEc02bg2ibmLJXxcr9u9XOrLBNOZbWRi7k59uh7eUcxdKaFw
         S0zd06BYqvqIaZ2u5vP6Sy9pClScQMXOBpqZMmmOxee3F1LZIiPRJxi+x9dFVk1cVX1o
         7cY9JMLv2TDNieda4LGzpWRgC9dJBep33Ld7pS+QyfVfSmrQbwyakHGHvLf/JZYyd9h5
         qJgBXq2th8EJ0F3v/Bu4i17DG/vHYM1X8/c8TVabQtVbCensaKrk65wFMn2pzsJvrL9L
         qBGf9Nj9SOQzlgsSp/i3EpzCz+rX7HJ6XR6gYX1dxFJpBlUN7nw7VeiIrS/VTAFT4bs8
         18YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNQX3CkJxIB41pM0SFwJDYXb+M85U9gNHUgyVDLzRzUoxbzxXL7fBCg9Vd+S/VA8+mg2mmNxLeFJDZA0V1@vger.kernel.org
X-Gm-Message-State: AOJu0YxSnI4P3Le9FfBPfr1kdH8t+kaqWMY4CxOEyySmFV0FSvA0LZkt
	DcKQMVIzV5Azxk/05LB/KDU27ESUQtUPh1QkFj3MWsK1omqcUZSsP+7KOHAzbkcHmS7oeY1GUFs
	xCDI+GQ==
X-Gm-Gg: ASbGncvMpNWM3yCfBYRMPlBjuAi1YNwqumZ7IiCmIWsCjdnF1mBJBYlFSayIK486H+r
	KcPxmOIcZa0uPS9EBFy6zrgY7NCah1+wnf837D67XZFlRxSokjdLqQtBtpggVGanb+dvBPfS7ka
	48Uac0XvHRnqO/8AqJsIj+aQvd2b8SoUFF7Lx05XMY6oH/wchPii7wBcXWeN+QASlHP1ufIb7W0
	jfOLMPO/1tcHfK2/hOg9H8FLis0l4LIxjhXX/ob0tgDPncQ4cE0Jluwchdtzqcwrlz3OeTLer8B
	Gjm5C453oPOBCV6zo0OREdYX
X-Google-Smtp-Source: AGHT+IHyta8fsZL6mYRZ0s8rWmrEKVfwyFx2LAFW5x7bhH+QNF/brDMJ6OUX23auiXQuB+jDeLoSHA==
X-Received: by 2002:a17:907:781a:b0:aa5:39a6:2b48 with SMTP id a640c23a62f3a-aa539a62cc1mr467603966b.47.1732471242574;
        Sun, 24 Nov 2024 10:00:42 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa55567771esm6658066b.79.2024.11.24.10.00.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 10:00:41 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cfddb70965so4777336a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 10:00:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXlr4qS1GTrj2dGeGeUmW6IHdyxSiWjMV0ZU0pWUkAHXD1cV8EDAuw0+RYPdeMGJf+5qw96dvM4GJ77Zi+@vger.kernel.org
X-Received: by 2002:a17:906:23ea:b0:aa5:4731:1eaa with SMTP id
 a640c23a62f3a-aa547311fb0mr240536466b.50.1732471241090; Sun, 24 Nov 2024
 10:00:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whoEWma-c-ZTj=fpXtD+1EyYimW4TwqDV9FeUVVfzwang@mail.gmail.com>
 <20241124-work-cred-v1-0-f352241c3970@kernel.org>
In-Reply-To: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 10:00:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi5ZxjGBKsseL2eNHpDVDF=W_EDZcXVfmJ2Dk2Vh7o+nQ@mail.gmail.com>
Message-ID: <CAHk-=wi5ZxjGBKsseL2eNHpDVDF=W_EDZcXVfmJ2Dk2Vh7o+nQ@mail.gmail.com>
Subject: Re: [PATCH 00/26] cred: rework {override,revert}_creds()
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 05:44, Christian Brauner <brauner@kernel.org> wrote:
>
> This series does all that. Afaict, most callers can be directly
> converted over and can avoid the extra reference count completely.
>
> Lightly tested.

Thanks, this looks good to me. I only had two reactions:

 (a) I was surprised that using get_new_cred() apparently "just worked".

I was expecting us to have cases where the cred was marked 'const',
because I had this memory of us actively marking things const to make
sure people didn't play games with modifying the creds in-place (and
then casting away the const just for ref updates).

But apparently that's never the case for override_creds() users, so
your patch actually ended up even simpler than I expected in that you
didn't end up needing any new helper for just incrementing the
refcount on a const cred.

 (b) a (slight) reaction was to wish for a short "why" on the
pointless reference bumps

partly to show that it was thought about, but also partly to
discourage people from doing it entirely mindlessly in other cases.

I mean, sometimes the reference bumps were just obviously pointless
because they ended up being right next to each other after being
exposed, like the get/put pattern in access_override_creds().

But in some other cases, like the aio_write case, I think it would
have been good to just say

 "The refcount is held by iocb->fsync.creds that cannot change over
the operation"

or similar. Or - very similarly - the binfmt_misc uses "file->f_cred",
and again, file->f_cred is set at open time and never changed, so we
can rely on it staying around for the file lifetime.

I actually don't know if there were any exceptions to this (ie cases
where the source of the override cred could actually go away from
under us during the operation) where you didn't end up removing the
refcount games as a result. You did have a couple of cases where you
actually explained why the bump wasn't necessary, but there were a
couple where I would have wished for that "the reference count is held
by X, which is stable over the whole sequence" kind of notes.

But not a big deal. Even in this form, I think this is a clear and
good improvement.

Thanks,
                    Linus

