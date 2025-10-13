Return-Path: <linux-fsdevel+bounces-63993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D120DBD5614
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 19:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1A05E0AF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 16:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B132D26F46F;
	Mon, 13 Oct 2025 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hcyeGPrr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CD526E6F6
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372409; cv=none; b=CvUz5K7YlL6/DaJGPwp5WETmLLaIQhxDLTRNFk599XXhZxBxevW3Ocfr2cOOpT0RfzYvNUpfuQdT55Telj+DVawpmDyNkbApnvaOQzALrCUYl/jZQVA8T8xBz6dJh+y929PXV6oIUTAM+8N1w9TRVvvqGlkpU+V7PG6QgTUBGwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372409; c=relaxed/simple;
	bh=SY0BghA+Ysl/prygsetImC/y3EbVm8BVAcQjJMwqtVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6clxQED0QjNHGSEpEkYTXtKjiRqumzmuDfTLZcFOXcgFCSSTbk7yf+DqKc1gY5a793hvZqEuEG8z0AR8g4DDl+S5clOhuaWWIj8H3zqaYQbvuBjdIpW6mr9RAIFHy6DqEybPgijGjN3OVNba3zUE4CmMhhdrENfbuwKoiWGY1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hcyeGPrr; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63a10267219so1613918a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760372405; x=1760977205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7sWgKFnXKgddcA8SesxIqcxmzVwUrjw9E9Rc16q4eHc=;
        b=hcyeGPrrYgYRSrbVIAKILKaRxI/WL+HxPsJ4ahISxySOYKE4N8rWjC/TpNUFzyd3QR
         aCx3JeyPb22dz21K8rGk5TYOFsDNKuNU/SG42by/U5NMx1txXh0dr57eXoPNwouoVESl
         qKM1FK118S7fND8IZwuhToMDSyIrvB/EHv/FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760372405; x=1760977205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sWgKFnXKgddcA8SesxIqcxmzVwUrjw9E9Rc16q4eHc=;
        b=dSx+LXEQlYzk/QX1TUCmSGCMfBaBLUZZyMG8rBCMWqRyYMOq5s7nbSqgHi8h++jU/c
         N8pmhPuC54gpFHWnWYqBbhVoNggTELw95tJhScJsQHhqTk4VaxE1PYLR7gGDHZspYlVw
         iCe9TO23iJ2CIE5Bf1dG5qLM9X7EGkFRzAccoYLPETFIbSaOlqDj8Bm/6C2CPDntWFbT
         0Cf9qKx0T5KeNAXuK74jADd334Q2EmrTHc2tU9hTCMWlleN+G4nNFKkm7Ni4Hn4E7FgN
         kHCw+ixCtfI1OKIPfIB61z/M/IcUYmWYfDzBZ91hvNmYlekM5XXsKRoni5Wd6UgxfffA
         CFoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFShJ+0KF4AhFiK7LF2RFousmgiLwCd37+0rF/ogJq7lQBim9xEXdtCK30YB2DGS6OvOIpwj2jD6lcGhAw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6SwiZROmVVVkaqZgQCeB4EkPV6aCrAkO4Ojs9XiG8xi2E+ENx
	mq2IzK9ZMyIJ7AllJm2VhtQDW/aTd7nr1EGMmvaMCy1DLGrxllinECk9bdJgO5jyrJWcIx/ni0c
	E30/E3ig=
X-Gm-Gg: ASbGncsKuWf2dxCs4MCL9dyKoUVecdbJdlLYkChnb1CBbYKwsLN7BPK2oeIQToHw8KC
	F3t985WKKS86RbZrWib0SeDvGLu/r5egK0TWYNe65LLXtAWm975hq0bWgqxfZryJygNG/RcPSev
	56DYxsFiRXKEZBtfdhSIY7pr4M8lRIJz+xrcmcXmSAl/MNwq7vtVi6z2INCTn0bX0ZKE0F125At
	1aY787aA1sSn79fGvl+UXZWiHa3Q0yZ/eO9tB6/yHl9OmjV2CnfhdrGsHy4xS/KzL1gTseegOgo
	IbYlry+Cx3Ova6wXgS04fyMJVNkCkkdnCBa8rTga2FgGf0diADK4rOJbWbdmIWL95FWsnEobnYn
	V4yZ+LhwtC8Pm5efw5ya/C117NEDFuq1sbGNCvUAP5kg9Yv9RhGvtvSTySJjEYJ9FbVpwEi4wsK
	lV7OxVNXsmyf90t3xlB8IGGNSOKA==
X-Google-Smtp-Source: AGHT+IG7AmK8VUpO1Ny3WQBA/gmYD4Lx4ER5J5VL17FsrpYLaJ3bxNzpIQmCUTd8uEF70RQWdzF95w==
X-Received: by 2002:a05:6402:5cb:b0:61a:7385:29e3 with SMTP id 4fb4d7f45d1cf-639d616f668mr21207487a12.18.1760372404595;
        Mon, 13 Oct 2025 09:20:04 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c321453sm9115311a12.39.2025.10.13.09.20.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 09:20:04 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63a10267219so1613865a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 09:20:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuonFyccthX5s0BaUDo01y98/CHuOAGXkG3KjCcvXhGXXNnK7Qch3Q2WkTiO8oOdBK+q8EVA9PB5VinGYM@vger.kernel.org
X-Received: by 2002:a05:6402:35c1:b0:62f:1366:46e8 with SMTP id
 4fb4d7f45d1cf-639baf075f0mr25361887a12.7.1760372403624; Mon, 13 Oct 2025
 09:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgzXWxG=PCmi_NQ6Z50_EXAL9vGHQSGMNAVkK4ooqOLiA@mail.gmail.com>
 <CAHk-=wgbQ-aS3U7gCg=qc9mzoZXaS_o+pKVOLs75_aEn9H_scw@mail.gmail.com>
 <ik7rut5k6vqpaxatj5q2kowmwd6gchl3iik6xjdokkj5ppy2em@ymsji226hrwp>
 <CAHk-=wghPWAJkt+4ZfDzGB03hT1DNz5_oHnGL3K1D-KaAC3gpw@mail.gmail.com>
 <CAHk-=wi42ad9s1fUg7cC3XkVwjWFakPp53z9P0_xj87pr+AbqA@mail.gmail.com>
 <nhrb37zzltn5hi3h5phwprtmkj2z2wb4gchvp725bwcnsgvjyf@eohezc2gouwr>
 <CAHk-=wi1rrcijcD0i7V7JD6bLL-yKHUX-hcxtLx=BUd34phdug@mail.gmail.com>
 <qasdw5uxymstppbxvqrfs5nquf2rqczmzu5yhbvn6brqm5w6sw@ax6o4q2xkh3t>
 <CAHk-=wg0r_xsB0RQ+35WPHwPb9b9drJEfGL-hByBZRmPbSy0rQ@mail.gmail.com>
 <jzpbwmoygmjsltnqfdgnq4p75tg74bdamq3hne7t32mof4m5xo@lcw3afbr4daf> <dz7pcqi5ytmb35r6kojuetdipjp7xdjlnyzcu5qb6d4cdo6vq5@3b62gfzcxszo>
In-Reply-To: <dz7pcqi5ytmb35r6kojuetdipjp7xdjlnyzcu5qb6d4cdo6vq5@3b62gfzcxszo>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 Oct 2025 09:19:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgrZL7pLPW9GjUagoGOoOeDAVnyGJCn+6J5x-9+Dtbx-A@mail.gmail.com>
X-Gm-Features: AS18NWC_26IcmmEQwm0Kzayu0MFl0jqhPq6BKmyAI8MXuCaJVEX1viMlot--KWU
Message-ID: <CAHk-=wgrZL7pLPW9GjUagoGOoOeDAVnyGJCn+6J5x-9+Dtbx-A@mail.gmail.com>
Subject: Re: Optimizing small reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 08:39, Kiryl Shutsemau <kirill@shutemov.name> wrote:
>
> And, for archiving purposes, here is the last version of the patch that
> supports large blocks.
>
> Do you think it makes sense to submit unsafe_copy_to_user() optimization
> as a standalone thingy?

Without a user, I'm not convinced. I think right now there are zero
cases of unsafe_copy_to_user() that are large enough for this to
matter. It looks like we have exactly two cases; the readdir() case I
knew about (because I did that one), and one other user in put_cmsg(),
which was introduced to networking with the commit message being

 "Calling two copy_to_user() for very small regions has very high overhead"

so that one is very small too.

HOWEVER.

What I like in this patch is how you split up filemap_read() itself
further, and I think that part might be worth it, except I think you
did the "noinline" parts wrong:

> +static bool noinline filemap_read_fast(struct kiocb *iocb, struct iov_iter *iter,
...
> +static ssize_t filemap_read_slow(struct kiocb *iocb, struct iov_iter *iter,
...
> +ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
> +               ssize_t already_read)
> +{
> +       struct inode *inode = iocb->ki_filp->f_mapping->host;
> +       union {
> +               struct folio_batch fbatch;
> +               __DECLARE_FLEX_ARRAY(char, buffer);
> +               //char __buffer[4096];
> +       } area __uninitialized;
> +
> +       if (unlikely(iocb->ki_pos < 0))
> +               return -EINVAL;
> +       if (unlikely(iocb->ki_pos >= inode->i_sb->s_maxbytes))
> +               return 0;
> +       if (unlikely(!iov_iter_count(iter)))
> +               return 0;
> +
> +       iov_iter_truncate(iter, inode->i_sb->s_maxbytes - iocb->ki_pos);
> +
> +       if (filemap_read_fast(iocb, iter, area.buffer, sizeof(area), &already_read))
> +               return already_read;
> +
> +       return filemap_read_slow(iocb, iter, &area.fbatch, already_read);
> +}
>  EXPORT_SYMBOL_GPL(filemap_read);

Look, the reason you did this was presumably for stack usage when you
have a big 4k allocation, but the part you *really* needed to protect
was filemap_read_slow() that then has much deeper call chains.

So filemap_read_slow() should *not* ever see the big 4k stack slot
that it never needs or uses, and that eats into our fairly small
kernel stack.

BUT with this organization, what you could have done is:

 - don't share the buffers between filemap_read_slow/filemap_read_fast
at all, so the 'union' trick with a flex array etc would go away

 - both filemap_read_slow and filemap_read_fast would be 'noinline' so
that they don't share a stack frame

 - filemap_read_fast could have the on-stack byte buffer - I think 4k
is still excessive for on-stack, but it could certainly be larger than
256 bytes

 - filemap_read_slow would have just the 'struct folio_batch' thing.

Anyway, I think *that* part of this patch might actually be worth it
independently of anything else.

Of course, that re-organization does cause that extra level of
function calls in order to not have excessive stack usage, and the CPU
errata can make 'ret' instructions expensive, but whatever.

So I don't know. I like how it splits up those two cases more clearly
and makes the baseline 'filemap_read()' much simpler and very
straightforward, and I like how it also splits up the stack usage and
would make that union trick unnecessary.

But it's not a big deal either way.

                Linus

