Return-Path: <linux-fsdevel+bounces-58976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69476B339F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 10:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9171659FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 08:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59E22BF3C5;
	Mon, 25 Aug 2025 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PUCuuL25"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C62BEC2B
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111901; cv=none; b=AjBvQ1XnfGLel+T8B2xPiQs+ijjYjCmyKC2pfnj12f3E/iG/5J1OsybZ4zYCljqq2s1nqdHUtu3EcqIaiT8fPyP+kqdzsBJUdrzTapLRpIYKC0Ubn9EijOe6+pgOgZfw3yeTuZTbMVCMVYITE9dTW2tvgdQc+j3wWjgZnE8sdeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111901; c=relaxed/simple;
	bh=MuxvReaBtdtD8aqeVMKZdOXavAN9DWO2KW24+iyjXEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZLlNZMC8gGrJ4uOskqSuD4RiP/G2W6KJdr+7OtYAkxO+txc/339jyvMgNs78rm9zuD+NsWUAfa8gGdXl7l+GFXoIp3yt4TAFliQBCCSylwdTt2BBy7jrwf8lqtJMr0blaa7FqHBqWYe+2bCl4UkZ0JZwYVSRzAigMLXkyziIig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PUCuuL25; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-61bfa392bc1so2580450eaf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 01:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756111898; x=1756716698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yiKHfbMpQeBW7UMYX24IEkoqrFHE7sniOpBPzGsa+w=;
        b=PUCuuL25WCm4djpaTc3Cx/bM1r8JgD0PF3ENN5OS0nJmICviAkYlhfOd3hynxSkNCB
         9NGXmeCPeQx4H7nAN4gA105MscuRo+HvuXFPqCynW45kvpHapBRs+3pFl7DhHRXJLE84
         L/FSn5LtbJcoJZc1+obchraZMJNO0/dH4IatelUPqJos9gyDKHPEdWwZAVk3Q3y/Tr/T
         LcRszUgRzXH3oyi0JLT8Lj7gK/6G6U8eEh+2IO7PZroO6Zn5e4bU+UDCA9VAy+fz5d0O
         PPW+m3eYxoK7xrKllyCnPc1V7RppgskI0I4W6260jwrQgB6U8SSTscQvF/JjnjWeG0EC
         dxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756111898; x=1756716698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yiKHfbMpQeBW7UMYX24IEkoqrFHE7sniOpBPzGsa+w=;
        b=kyEhoPbwTZcHfD4fpt3yaQPPoE/j8SHe5nusYF7FlvnicALg0l/EawM4EUpOjoUxW1
         yWLHg7671uGhXj4GNRMTdoBUbo5kAWSn3aR9+TAi8goopRAJQrckBm9N4C8wHx5KC3mb
         CDt8TSS23/6a1Qf9anzp2QcGiqihCl+k/FO5ifCffTnjbrxt1QnKTVz0kh0kMjRKLTbX
         x0F4GAb8XUhjKQw9geMNv59qvYl8z6mG0++5JIGaMbxPqdcf6Lynoa5F9Kygs3aFQjUM
         Tro7RFAnSNr9oMtbGVI0+JtwruWGaWo1I5K7GZxkYpFZ9SVp9JlgJOXW6msvKyZw52Qu
         651Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFIiMEGFpj2cAbJBewH8Ktp/v62Jdzdbhv1GL/WEtPojeJmti+H54ilFfb3/X/iALAeBtbM1HSYIvEaqrj@vger.kernel.org
X-Gm-Message-State: AOJu0YwuUf5L/FfnXyx6W+Ch/kI1Gc1oDcI9keGn3AFRJQ7l6VlGHIPo
	/cYzm7GWX+xbglJ2WN9CfiXM6ek6Rrl32ktpOP71m2GjV6K9eRq9QRXjT2tf4CoW6SLym4mAjap
	bb8uKOLkKsovf2vG2cvzGM/yf1CC9hZ2kl+yCpExCOg==
X-Gm-Gg: ASbGncsGRUJVA4iNx2f+z2/6ExO7NbX4Z33eOCF6Ived48oe2quFA0R6SosS/0urgIK
	j5NvRebqHcN+mVcW2uCdUTh7n4eU8ErtauNevxqSgXcFOSeJg2uh4BsYA8uZ4vLj/EQxBFCNnT4
	0oIb0WWzCkUsBlWNVrigMAWmNUI48PHewHzBHBEa+6TDV8JJ4fcty6zLSQvFSd5t+z0S5v4HHpA
	5Cc/wIQT3Yj
X-Google-Smtp-Source: AGHT+IGJkNRWMDslGX8VGikfj4k8pSIFytg6HHn9/fNdMR27Jwroi6cqOy37+6ofhUlQm0wK3V9/RkK3duFuBFV560c=
X-Received: by 2002:a05:6808:5186:b0:435:f91e:6523 with SMTP id
 5614622812f47-43785c0e7b0mr5799495b6e.1.1756111898255; Mon, 25 Aug 2025
 01:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822082606.66375-1-changfengnan@bytedance.com>
 <20250822150550.GP7942@frogsfrogsfrogs> <aKiP966iRv5gEBwm@casper.infradead.org>
 <877byv9w6z.fsf@gmail.com> <aKif_644529sRXhN@casper.infradead.org> <874ityad1d.fsf@gmail.com>
In-Reply-To: <874ityad1d.fsf@gmail.com>
From: Fengnan Chang <changfengnan@bytedance.com>
Date: Mon, 25 Aug 2025 16:51:27 +0800
X-Gm-Features: Ac12FXyP3v__L8ofnuLQWnsBxvn3hkODtD2ZWzLQGxmgE7vI0Y2H8y3-Jmdu8tI
Message-ID: <CAPFOzZufTPCT_56-7LCc6oGHYiaPixix30yFNEsiFfN1s9ySMQ@mail.gmail.com>
Subject: Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the late reply.

Ritesh Harjani <ritesh.list@gmail.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=8823=
=E6=97=A5=E5=91=A8=E5=85=AD 12:35=E5=86=99=E9=81=93=EF=BC=9A
>
> Matthew Wilcox <willy@infradead.org> writes:
>
> > On Fri, Aug 22, 2025 at 09:37:32PM +0530, Ritesh Harjani wrote:
> >> Matthew Wilcox <willy@infradead.org> writes:
> >> > On Fri, Aug 22, 2025 at 08:05:50AM -0700, Darrick J. Wong wrote:
> >> >> Is there a reason /not/ to use the per-cpu bio cache unconditionall=
y?
> >> >
> >> > AIUI it's not safe because completions might happen on a different C=
PU
> >> > from the submission.
> >>
> >> At max the bio de-queued from cpu X can be returned to cpu Y cache, th=
is
> >> shouldn't be unsafe right? e.g. bio_put_percpu_cache().
> >> Not optimal for performance though.
> >>
> >> Also even for io-uring the IRQ completions (non-polling requests) can
> >> get routed to a different cpu then the submitting cpu, correct?
> >> Then the completions (bio completion processing) are handled via IPIs =
on
> >> the submtting cpu or based on the cache topology, right?
> >>
> >> > At least, there's nowhere that sets REQ_ALLOC_CACHE unconditionally.
> >> >
> >> > This could do with some better documentation ..
> >>
> >> Agreed. Looking at the history this got added for polling mode first b=
ut
> >> later got enabled for even irq driven io-uring rw requests [1]. So it
> >> make sense to understand if this can be added unconditionally for DIO
> >> requests or not.
> >
> > So why does the flag now exist at all?  Why not use the cache
> > unconditionally?

I think it's a history problem. When REQ_ALLOC_CACHE flag first add in
https://lore.kernel.org/all/20220324203526.62306-2-snitzer@kernel.org/,
it's rename from BIOSET_PERCPU_CACHE, only work for iopoll,
"If REQ_ALLOC_CACHE is set, the final put of the bio MUST be done from
process context, not hard/soft IRQ." and from
https://lore.kernel.org/all/cover.1667384020.git.asml.silence@gmail.com/,
remove this limit, percpu bio caching can used for IRQ I/O.
"Currently, it's only enabled for previous REQ_ALLOC_CACHE users but will
be turned on system-wide later."

>
> I am hoping the author of this patch or folks with io-uring expertise
> (which added the per-cpu bio cache in the first place) could answer
> this better. i.e.
>
> Now that per-cpu bio cache is being used by io-uring rw requests for
> both polled and non-polled I/O. Does that mean, we can kill
> IOCB_ALLOC_CACHE check from iomap dio path completely and use per-cpu
> bio cache unconditionally by passing REQ_ALLOC_CACHE flag?  That means
> all DIO requests via iomap can now use this per-cpu bio cache and not
> just the one initiated via io-uring path.
>
> Or are there still restrictions in using this per-cpu bio cache, which
> limits it to be only used via io-uring path? If yes, what are they? And
> can this be documented somewhere?

No restrictions for now, I think we can enable this by default.
Maybe better solution is modify in bio.c?  Let me do some test first.

>
> -ritesh
>

