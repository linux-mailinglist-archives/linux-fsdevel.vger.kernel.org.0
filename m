Return-Path: <linux-fsdevel+bounces-68536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5937C5EA9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 18:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1EB84E57F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 17:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C821633B973;
	Fri, 14 Nov 2025 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Lmsn/JP9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C02D5416
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763142134; cv=none; b=I3aDy2XrqkutGvDRgtoZGMFlzj+mXiIYPUPu96qzM5wbx1h/ZmKZIfs4quOyy6PPfyri8kRaHkofwFRe1E/C8YmwHiFDIA5j7Moq6zVdhtDj3a0RZySLD9GpkZw0Gpw76bGN5uUBJ8HeK6yZfq6K/PIUtJdY3uA2w4H6wiO1Vjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763142134; c=relaxed/simple;
	bh=Ck3PsG2YZBT3+DkuH0L2cNVUndhWauf+ZUbtOHHIsMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mceNwtoMl0ORi7iqXA5VQZoEh6OjDaiRUdXr8AAuanoA0RumSQH3wc3ZV+sj4EPrxY63WWjO22OfzhKTDMU7smc1JXR18h+2c1HPlqCqFrufmGcIraLyzQ+kydHjHz9ckQYpJVmLtRhNFp6r0ktBY5BMmcofZOr02OPzopQGh8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Lmsn/JP9; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4e4d9fc4316so18485811cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 09:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1763142130; x=1763746930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpAxRfX7+XU3sg7WElj4wsWAhBbaiRWwTC7gp0ZtA/k=;
        b=Lmsn/JP9Hn8sSuHtk7YBivjPsa+jAtCjCwNsVrhJtGeuX4e2iIrnVG6vcVIk3BwrUn
         JuGLWgaO4CH7RuxHOOa7DEIv2JyvnoU/HoQVg8Uyi1MfuglFbcRbwI1m/19nBrdUSNZf
         m3aMfYO5SOOEg2N//6uREMOjXfOExVzHEmNa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763142130; x=1763746930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FpAxRfX7+XU3sg7WElj4wsWAhBbaiRWwTC7gp0ZtA/k=;
        b=KwNt8/bNEV44SCYMtS4NsgRPmYIJB5W4z01wlL6Vn4ZpWNJSqmQ/6VSJr3G8QEsjXi
         PMbVESTtuf6hL5ved0E3TuMVLZJz3/jTHjcN55tu9naSeq1aLXywJY2PTLVVFh+i+wyG
         EJlfEoLwYm9zvQDazzdwnp8rcxvdW3+435cbStqycNogSWFnEwlHSNhfAHqS+sQLvXNz
         JUT5Sm+RrzhmC9/MZR/SVkk5tSirNpB4m9ezzqBEECkR4vqhiStSJxi5JQM66VCknqms
         C0Vg1NSfYX++X4U+qPNfuqv3jMondG5boQkUIVb2b0JTVzYsmUuecwl16/ZbBTLh34lO
         BeBg==
X-Forwarded-Encrypted: i=1; AJvYcCV7xX2wOqHX2NaladGglI9qtm2+hAHLr5Wf1NP83uDHU1RfEUBJZO3TObt/W9JHX34H4E+Wp0OGahGYmNKW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/L9UR8oAjL1eKGhB/M/gK7vBYy7PHIuq5DbhKn0kbkHwk6f6l
	8zoU5WRX+GHmCbKoBfHm5J7CHSAbRCdTJG6RYkRFH0ozQm37Rb/eIfvRHXsnNFOETJx/0KOlEjz
	7Xm1FtABn+xsNCeSQtQFHWc5h/hcE1tc6e1f0IM0EuA==
X-Gm-Gg: ASbGncsODgwNH4sdAzb2BQnwBAdlg56lchrg9nYarlHEuSRxOsqFne0TQBEg1fmjnJO
	ucRxw+l+E66pqT0AgY/Kgo5+pNkFuSEozKwq+qR4/6pZ9bW5j3tiD5V/aqe9+5ON22i6hKDxuaq
	Mv/NQdfK21zcnUJfGIysTajuE+6rkD3Jr82tgH2A6x56/GaakCA76JEFcWybrcfkQPmQiG4qRzS
	Jpfnw+31obvWFAEow63EZ2GzbdqtX89wiZ8cuMKKQT4xpRU04eUT0WBkhdj1BbDxaD4lcq6vHER
	a0HMZyzqf6+Vut1sI9IpIAUSiPGZ
X-Google-Smtp-Source: AGHT+IG8oRNEQTwOYfdLAuDndZk1qi6Lyv5tVmzFUUqZK8ufbDw/Uf511bZlhVgLaFRWtMGjOknMUzz+F6oiwCmXBO8=
X-Received: by 2002:a05:622a:1a1e:b0:4e8:aee7:c55a with SMTP id
 d75a77b69052e-4edf20a221bmr57184441cf.26.1763142130553; Fri, 14 Nov 2025
 09:42:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
 <20251114-work-ovl-cred-guard-prepare-v1-3-4fc1208afa3d@kernel.org>
 <CAOQ4uxhB2am_xAGugZvAiuEx7ud+8QGPJBwcA+M+LmRvWC-nsA@mail.gmail.com>
 <20251114-gasleitung-muffel-2a5478a34a6b@brauner> <CAOQ4uxie_CSG7kPBCZaKEfiQmLH7EAcMqrHXvy78ciLqX4QuKA@mail.gmail.com>
In-Reply-To: <CAOQ4uxie_CSG7kPBCZaKEfiQmLH7EAcMqrHXvy78ciLqX4QuKA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Nov 2025 18:41:59 +0100
X-Gm-Features: AWmQ_bkMQWRwIOVYfcltNX1QVP7XG0IYaUQqBxN3AT2GDcB7daO0WvsP5XHhKPw
Message-ID: <CAJfpegtZhfU7hmYcom9LgnkhXbZ8peLtRm1CDhVy2JXfqJUGkA@mail.gmail.com>
Subject: Re: [PATCH 3/6] ovl: reflow ovl_create_or_link()
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Nov 2025 at 13:07, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, Nov 14, 2025 at 1:00=E2=80=AFPM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > On Fri, Nov 14, 2025 at 12:52:58PM +0100, Amir Goldstein wrote:
> > > On Fri, Nov 14, 2025 at 11:15=E2=80=AFAM Christian Brauner <brauner@k=
ernel.org> wrote:

> > > > +
> > > > +               if (attr->hardlink)
> > > > +                       return do_ovl_create_or_link(dentry, inode,=
 attr);
> > > > +
> > >
> > > ^^^ This looks like an optimization (don't setup cred for hardlink).
> > > Is it really an important optimization that is worth complicating the=
 code flow?
> >
> > It elides a bunch of allocations and an rcu cycle from put_cred().
> > So yes, I think it's worth it.
>
> I have no doubt that ovl_setup_cred_for_create() has a price.
> The question is whether hardlinking over ovl is an interesting use case
> to optimize for.
>
> Miklos? WDYT?

Hard link is special cased in several places because it's only
creating the directory entry, but no the inode.  As I see it it's not
about optimization, more about hardlink simply being special.

Thanks,
Miklos

