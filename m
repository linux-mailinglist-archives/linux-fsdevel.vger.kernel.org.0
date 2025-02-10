Return-Path: <linux-fsdevel+bounces-41427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 700C1A2F571
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 18:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1111888F9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 17:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42DD255E3D;
	Mon, 10 Feb 2025 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MggNZwAf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820A92500DA
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209089; cv=none; b=kd9EHjWv96oFiYxTGNjNBkv0LHsrqk+EnGSfQbESF9jNU7VHzLvstsz8bGua1iNjSf9a4qzGMraYr7VNWOfmGJMd4Bft11mGQQMX4RjTk0rUZgzMwvdGYh31BNrWfGbd0V3hNoV66j6xKhfZV5beFC5C/hH0ekUj49SGB7PFLaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209089; c=relaxed/simple;
	bh=KveOwdYLnyMvdHPkIhUVg6hHWpjgSHD3jdqobeFCKGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpszghuVgpOjsYabblzUJtozblmkhNK3gRNoogJKrc+qJQ43DHnYzKdr5z5rsA3kXf+EZs3x+11I+mNyl1MVQF4spjIfOU+Y7q2XDD/jJzt3Kcx0MaiJs1HcPfwQJxLMd84SNTndFfifjAJ3Iu2nZuC3kclH4f2m6X59COO4z+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MggNZwAf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5de47cf93dfso4947717a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 09:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1739209086; x=1739813886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qVjjNIhYDEU4EznaGkWhHigqbNvzcXCKCHwh1pZR13Y=;
        b=MggNZwAfEofmTJ92obRF+CiS0oEKGjmbaB5ly5W8XVtlL5IVq/mC0NW4XQVJV8/zXO
         vq6MPlUj+g7vTCtw7AFq5bPaSRZeAgU56XoN0ZEAYXlFDl8iqBeDO/9iliNNauWcm/fx
         DPajmdOHY4VHxtWloK7miCFy+QqnajLJZPLe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209086; x=1739813886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qVjjNIhYDEU4EznaGkWhHigqbNvzcXCKCHwh1pZR13Y=;
        b=miF5mACgsLOn8zJwQq0TmvX0THNN/+/xhH4rdh3eOeMQVcimGD+atkIwe+9ykxWCxB
         leAIZekNbMOJGSXvcJ+Q9mQBQIUQbQ7oP9okcNescx6GehblGQEgLWiS9GZH+r8KMPFT
         GgvMbmSx9mxzv+ILnvpwVKzrjDWg0mJ+Cbr+7BtdF8tjNqYqv5Xow/1XjB1advUzB1WQ
         tGCqe8WH9Gp8oHyaAlZMEsP4Evlhu/+nfkZAoT/Vi3Enwfi4xM+9ATjicMIEtfpKuGy7
         y/+L+Vocx4LcmhYcQyVHQeLH1l3PPaeiyyYkkAmEJZDWnJ382LZppr7w3y9ByDr6iwSp
         +hLA==
X-Forwarded-Encrypted: i=1; AJvYcCVE6p/oazozSj3JbB1QhJNEr6gI1g5VysiXPgRl9xK1xj70Nar4UkkLvJV44RTuubC8MM3BeB+JIiuBOC+l@vger.kernel.org
X-Gm-Message-State: AOJu0YzPyBpwHuDW9mvBc0kFoE8Xx2PMUz1p+WWr6ocP8JYbnB8K6hQg
	kWY1BY2g1sRUAtJ8cAo+bHMBR32A87D0kYDxYIiFHwP+V/O+vR0ZJU9MJGbXEIy6fgCbs+JjkfA
	nwjY=
X-Gm-Gg: ASbGnctY6ZAr3eP4ihdvwMGMDsYvspVDV/Ex0aoDqoGVx/eRL1s6/iknD3Gk0zU7Huh
	DcmlqY7EPxSSYJ9ov+UY2ud8UXpYdYT8Y3x6AI+T9Lditl1NLdGiXkLX46hoZ3Fn+nfchv5TWo1
	iNlcUCD+1py1Xc8PLOybrb0NSX6cFZMafnwDXkG/eHI+3c/b6hCD48pvHHEiPYgyjaBsFpknsi/
	n2SeZQGqHox3TPex04kvETGolTt+yDL7pWb6QRhRx6rNi2sI/IzBLEKm8BFMWQWzRiFkmXWLhWy
	5P1VcWChdJlFwzz1cTldarM6I2cnbk3S+dN9WKqyunBvPXdckXJWdC0rwIQVrIxeXA==
X-Google-Smtp-Source: AGHT+IHsLpuCXJ1jCSuWEW0H+vkh9llz5u72lwXovrOcRZXYfJP1AxG0z+APbf2W5DKdvEY48yOqAg==
X-Received: by 2002:a05:6402:360d:b0:5de:5865:69ae with SMTP id 4fb4d7f45d1cf-5de58656b68mr29437942a12.29.1739209084708;
        Mon, 10 Feb 2025 09:38:04 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de6e1bd66dsm3551638a12.0.2025.02.10.09.38.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 09:38:03 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab78e6edb48so468543566b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 09:38:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVuewMB+MO6UhFUJCYdWSvFcPW7Z5YllWn0UZhgUXZPfQGmzMMw4UDRK8awRveXAsTKlRXdyTgMgFo0HUnv@vger.kernel.org
X-Received: by 2002:a05:6402:5386:b0:5dc:74fd:abf1 with SMTP id
 4fb4d7f45d1cf-5de45017b76mr38928096a12.15.1739209083436; Mon, 10 Feb 2025
 09:38:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209150718.GA17013@redhat.com> <20250209150749.GA16999@redhat.com>
 <CAHk-=wgYC-iAp4dw_wN3DBWUB=NzkjT42Dpr46efpKBuF4Nxkg@mail.gmail.com>
 <20250209180214.GA23386@redhat.com> <CAHk-=whirZek1fZQ_gYGHZU71+UKDMa_MYWB5RzhP_owcjAopw@mail.gmail.com>
 <20250209184427.GA27435@redhat.com> <CAHk-=wihBAcJLiC9dxj1M8AKHpdvrRneNk3=s-Rt-Hv5ikqo4g@mail.gmail.com>
 <20250209191510.GB27435@redhat.com> <b050f92e-4117-4e93-8ec6-ec595fd8570a@amd.com>
 <20250210172200.GA16955@redhat.com>
In-Reply-To: <20250210172200.GA16955@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Feb 2025 09:37:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj8V1v6QmJ_8X6zznautRq29tXMYzxorOniFx4NtxRE1A@mail.gmail.com>
X-Gm-Features: AWEUYZmJaL8TbJ7lk4Lr0c0O26PwdykcaxCrEyPDuubQIkvHJrL2OOK5W6KVmlM
Message-ID: <CAHk-=wj8V1v6QmJ_8X6zznautRq29tXMYzxorOniFx4NtxRE1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] pipe: change pipe_write() to never add a zero-sized buffer
To: Oleg Nesterov <oleg@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, David Howells <dhowells@redhat.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, Oliver Sang <oliver.sang@intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Feb 2025 at 09:22, Oleg Nesterov <oleg@redhat.com> wrote:
>
> +               int avail = PAGE_SIZE - offset;
>
> -               if ((buf->flags & PIPE_BUF_FLAG_CAN_MERGE) &&
> -                   offset + chars <= PAGE_SIZE) {
> +               if (avail && (buf->flags & PIPE_BUF_FLAG_CAN_MERGE)) {
>                         ret = pipe_buf_confirm(pipe, buf);
>                         if (ret)
>                                 goto out;
>
> +                       chars = min_t(ssize_t, chars, avail);

If I read this correctly, this patch is horribly broken.

You can't do partial writes. Pipes have one very core atomicity
guarantee: from the man-pages:

   PIPE_BUF
       POSIX.1 says that writes of less than PIPE_BUF bytes must be
       atomic: the output data is written to the pipe as a contiguous
       sequence.  Writes of more than PIPE_BUF bytes may be nonatomic:
       the kernel may interleave the data with data written by other
       processes.  POSIX.1 requires PIPE_BUF to be at least 512 bytes.
       (On Linux, PIPE_BUF is 4096 bytes.)

IOW, that whole "try to write as many chars as there is room" is very
very broken. You have to write all or nothing.

So you can't (say) first write just 50 bytes of a 100-byte pipe write
because it fits in the last buffer, and then wait for another buffer
to become free to write the rest. Not just because another writer
might come in and start mixing in data, but because *readers* may well
expect to get 100 bytes or nothing.

And to make matters worse, you'll never notice the bug until something
breaks very subtly (unless we happen to have a good test-case for this
somewhere - there might be a test for this in LTP).

And yes, this is actually something I know for a fact that people
depend on. Lots of traditional UNIX "send packet commands over pipes"
programs around, which expect the packets to be atomic.

So things *will* break, but it might take a while before you hit just
the right race condition for things to go south, and the errors migth
end up being very non-obvious indeed.

Note that the initial

        chars = total_len & (PAGE_SIZE-1);

before the whole test for "can we merge" is fine, because if total_len
is larger than a page, it's no longer a write we need to worry about
atomicity with.

Maybe we should add a comment somewhere about this.

          Linus

