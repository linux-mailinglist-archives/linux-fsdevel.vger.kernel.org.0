Return-Path: <linux-fsdevel+bounces-50675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3E7ACE5D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 22:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB2D170D51
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 20:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E47420E6F3;
	Wed,  4 Jun 2025 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/LA0hwo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7208219ABC6;
	Wed,  4 Jun 2025 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749069484; cv=none; b=tO5BV+t5Vshi17aOmFh+Y/w7ygBFzPOtSgUL2Qn3ZYF/cvss9XY0+/S7uIa0AtNn7KhdS7G7OGQYaN++ov7JhW+OzsoE3EL7lzSwlvYxvZsVJlpVW4G4qH8JEsw/jbO/LUEK/5WrwA7UxExd+IlPK6BQbzxZCILOxcFaFAVCrvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749069484; c=relaxed/simple;
	bh=pgJKEv2jAnuX/L7yciDsQWLunIL8XZIPetYx1VK+E88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAfiKLSkLktL3EyUKjWnltMSF/wBxFnvUVzp561SkbnpTUNV9qY0UDG78+nwAm7bIanixKfC2BXLEdxRo1TFsAQVQ25yqVw9ftkUKq6m95NIg24TFbeduqM75bDURLTjVSVDuEDy0/oVqUutDVC9JP9GqE89pjDIpDy+MJY1FzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/LA0hwo; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313132d1f7aso228541a91.3;
        Wed, 04 Jun 2025 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749069483; x=1749674283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joBU8n6b8tl+3db8kE736wD5+CIbZIG5tMRWUz70vaU=;
        b=W/LA0hwo1RzsTsHrWu/A8K4NOk3fROA777SEBCnUYZv3DIB1LUOwRk2jf4Xlae7+dW
         1o1k+yWt4k0NdMEbHKy4OP4pNKmNDEv5KXbcRoTRTjA1jmFGUnxZNFGF3Sc8njxOI91W
         RzoxLU/Q7FIEpaBWNyuCUuAEi1GN0sPQmUI3RD+7J5A9Whx1vZOstICos+CDLfwavdR/
         OvSAAmcjs+lx1chjpx7czpiwyVxyTt6WAF72/iMI8vmPniaMtP3hjXOB0LdjlegNXlmn
         rSZ3FoC/jTzW1vOwSmiEvpnNFU9K0owRasfogULR1R0/Kva2xqvIBNug/UcwaGYgDkNK
         Us5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749069483; x=1749674283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joBU8n6b8tl+3db8kE736wD5+CIbZIG5tMRWUz70vaU=;
        b=VZtc9KpPMetS2PfKtRgYFKmRZRbV6LxKtx4nCjA4r15TBJMnE+N8PZUyJERkpupAyH
         3sM62VCvoYbjcTGDdHl0Mz5Bl1hE14QtF9lAY157sOP5HILFjFL280o2oBgQEW55m2/Z
         pykRTfRqq6uixzVsRbvaWDwG8+cF2ZP11Vi29zramnj4ogFvI4JlSD0q54BwMPCnuKeJ
         04vGaoZptUANs3V9JH8a/tUWPKU63RT9js0lR8VQwJhjuKOr/kNlzq8KVjm45zA2FkfH
         5TsmMlry6HFlpK71GP5dhBEln0giQPjRnvLDh7v5N6DZnnkGn6RHrnCOppblNPR3VJfY
         Snfw==
X-Forwarded-Encrypted: i=1; AJvYcCV7C2sNaB+ouuvegHHtjaxhQRgpa0juPn+WQgbNxDX0+knWR6KIcZ2lK1zRq7XZHjJQeCdMEb/EdTg3D6fE@vger.kernel.org, AJvYcCVxxk8QpVvEFtwH/crODHhFytsDMhMK3QPDAtvOpL1fpBeBCOSicJJiPCZCjTI++MQfV7IrvOYsyKmYwq/tEz7642VjagoO@vger.kernel.org, AJvYcCXE+tAHQS9V+enwoviLdLUcb86+ykNp/+cYBYnZT4rdSW4NNdJp8ZpuuVTQ0MlohKlcdJV96QFUNP1ymHYh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+vuuXtROBq72Gx293kGFg1DqCA1FC4Id+2bRMBOVCw5U/rLyk
	EMI28/C2kTJ5tN5eVjus7pPiri/wXWhprhmGkTDuYZoO6K7YRaYAGkj0NRTIiCG76jQqbBnOYfo
	NCQLjhztbwxkErSnrEZ3rXnix6vndp+s=
X-Gm-Gg: ASbGncts5gbETusCcCLwkeW80Ff6ZVJGU4T9xNrCRn+tC3BDpEOSI89XQUudOG046tx
	ft2UzwOYVtzNWwo9Lz2WhKBvKvOsEwqIbO5uq6sMt0IP8HRNUzcraDHGLxnXKAB4r+AJiKJBT2r
	2n3HzeAq/IkifmS2n3aQNIWwZqGgZ+nGv4Z6PO8flp37Z3oVXy
X-Google-Smtp-Source: AGHT+IECfyYi0yVRcK3x9dFDCPgy4jR7OngRwkOnLgyo6IvNQ91klesbnTdovQlIv7SDSNTL4qcVhbVXW3tZuQKdg7I=
X-Received: by 2002:a17:90b:5588:b0:311:fde5:c4be with SMTP id
 98e67ed59e1d1-3130cd7e428mr6357096a91.35.1749069482560; Wed, 04 Jun 2025
 13:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603065920.3404510-1-song@kernel.org> <20250603065920.3404510-4-song@kernel.org>
 <CAEf4BzasOmqHDnuKd7LCT_FEBVMuJxmVNgvs52y5=qLd1bB=rg@mail.gmail.com>
 <CAPhsuW7mwut7SYubAUa5Ji7meDP1Bn8ZD9s+4sqjBDim7jGrWA@mail.gmail.com>
 <CAEf4Bzbm=mnRM=PYBLDTogrb+bNk2TnTj-kGr3=oFNEyQm8hKw@mail.gmail.com> <CAPhsuW6rdJpP4pqtgU2WC8-KOkNObeY5ELMy_ga_0YjJJj0NaA@mail.gmail.com>
In-Reply-To: <CAPhsuW6rdJpP4pqtgU2WC8-KOkNObeY5ELMy_ga_0YjJJj0NaA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Jun 2025 13:37:50 -0700
X-Gm-Features: AX0GCFsvLc9sN7lYehGRiq33H23gnkjaUpl0qWQVrE8H5jwC0y-8E4yobGq-z3g
Message-ID: <CAEf4BzZpG05EHK20RDKJq2BXHKtZ4Z7CLvhQNJN5AUpTDYcMOw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/4] bpf: Introduce path iterator
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, gnoack@google.com, 
	m@maowtm.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 4:20=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Tue, Jun 3, 2025 at 2:45=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Jun 3, 2025 at 2:09=E2=80=AFPM Song Liu <song@kernel.org> wrote=
:
> > >
> > > On Tue, Jun 3, 2025 at 11:40=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > [...]
> > > > > +__bpf_kfunc struct path *bpf_iter_path_next(struct bpf_iter_path=
 *it)
> > > > > +{
> > > > > +       struct bpf_iter_path_kern *kit =3D (void *)it;
> > > > > +       struct path root =3D {};
> > > > > +
> > > > > +       if (!path_walk_parent(&kit->path, &root))
> > > > > +               return NULL;
> > > > > +       return &kit->path;
> > > > > +}
> > > > > +
> > > > > +__bpf_kfunc void bpf_iter_path_destroy(struct bpf_iter_path *it)
> > > > > +{
> > > > > +       struct bpf_iter_path_kern *kit =3D (void *)it;
> > > > > +
> > > > > +       path_put(&kit->path);
> > > >
> > > > note, destroy() will be called even if construction of iterator fai=
ls
> > > > or we exhausted iterator. So you need to make sure that you have
> > > > bpf_iter_path state where you can detect that there is no path pres=
ent
> > > > and skip path_put().
> > >
> > > In bpf_iter_path_next(), when path_walk_parent() returns false, we
> > > still hold reference to kit->path, then _destroy() will release it. S=
o we
> > > should be fine, no?
> >
> > you still need to handle iterators that failed to be initialized,
> > though? And one can argue that if path_walk_parent() returns false, we
> > need to put that last path before returning NULL, no?
>
> kit->path is zero'ed on initialization failures, so we can path_put() it
> safely. For _next() returns NULL case, we can either put kit->path
> in _destroy(), which is the logic now, or put kit->path in the last
> _next() call and make _destroy() a no-op in that case. I don't have
> a strong preference either way.

I didn't realize path_put() is a no-op for zeroed-out struct path. I'd
probably leave a comment for future selves, I don't have strong
preference otherwise.

>
> Thanks,
> Song

