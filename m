Return-Path: <linux-fsdevel+bounces-47134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424D4A99ACF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 23:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DE492241A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 21:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445631F1927;
	Wed, 23 Apr 2025 21:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jfn3r4vW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA1F4A07;
	Wed, 23 Apr 2025 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745444122; cv=none; b=WagLZxc3m/o9lKzMwOzKj+8SojJtqUWkj815YlHmdbUcdACT0313o4b6ySR38jvnZ0HwKLyeEteZBHiOlrXRzjDRrIMa2MP0q6lXThfCEbV6w9FaY0kn99oCOjKiMCGcHOprEtgOr9cEwWOCeMJTr95e5EJ/VOVaSecVKyqkdSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745444122; c=relaxed/simple;
	bh=ZOMahnqwK2czE5+AzFT6MW14Dv/ZxeTxkD1jEiJ1lNc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWEigMzK1MLqxzPxAPT2EFX9cbjNPDgIGYbgNUaWoyAYej7QSXUQp+0Od9e0QEr9Ia0qfB+HhbFqA5rGYPiewAtTTmEO11DhEI8x0DMBL5d8HAjfsCWycWZF2ZM31MV4sPBVWTeFFB18ww2q0/qsXE3ENGOdky40kkpPNiNU65o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jfn3r4vW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39c266c1389so203589f8f.1;
        Wed, 23 Apr 2025 14:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745444119; x=1746048919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=itX3NOYXWOyXJnbtbmqeBCVY1jsU6HXNt/e9Gv22P6g=;
        b=Jfn3r4vWM5vt5+VRvRjeu4eOyyg8XAosTk2sGUEHjWl6v0SjVVB8sYRTi/0GEsEOYp
         NJB4+MLMxwZK5+kfCW+lq8Fx/jp1Arvbpox1v9PV0tp3xAAO7yAsm+YOAp+LLg27cMnu
         vza8cditKZaYrZ40+gVp8ZVTSlSs1I4ToYeje4voPrJ6ugW4R7mvqs6HNGGYWlt5JaB6
         yxCVl70zwR8CrXN7+93uCLJzn1SbDFt0Kag1ngXcmTtOZkbBKty7yp7NHxY6R9CjG1P7
         X6O5BPr8mzOeFdzQRbP0dGL9Gq48ENZXgKu8QVKlIlZ+GPVbPRjG1FT0gcCswcV+/rHN
         D7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745444119; x=1746048919;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itX3NOYXWOyXJnbtbmqeBCVY1jsU6HXNt/e9Gv22P6g=;
        b=Q0pKNgZOuIiqPJhK02YFlKVy/fuF+mss3Uq8lGjEEkJok/X959bsf9AXgsyNobuPfv
         dvnxliVPDecdzZCGC1k32shS3whJqVhXzsWS/gOzII02IoNLqecH2ieDPBCVujNUOue0
         hipwboAtpjFnIzTTabZJsBCTFKxMOoeYGBXx716i1uB893+FUnWTHgxz1/hO0sPlClPE
         MOY350oOhp4sA7dVwOBMAAGjF+zaFCm9/lrO7z1fKS/nbv0QxbQzKah0K5xQYNTs2dzq
         f062RWOimyEceKHLgh2s3ueIe6+1q/aowBa1ES9JpnBsv4KFzJGa4HZgopwdkiYrec3e
         QJjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU08zAxH5NpCL1F6A2myjgUlG9sQJayZyhbByZdDZ+BCOCVIIeIh/q8vcovRuHJdu5ErIGAMRsWT2LTnlL9Qw==@vger.kernel.org, AJvYcCVQg30SjAtm6gIzOMNfP/MqJA+HD4ncanzZEO8pel+Lamv1hAv3uRvgYcAxuEcV3I3I1zk97rqKQ7kcyfjUpA==@vger.kernel.org, AJvYcCW7YIYJCmLsRGPoD4tC4rRgiBsosoC6aV9cnV0gIljfajsRypinPLfFwUqO/0Y2vttt9uaiI7Yc1QkF1kG8CFlo@vger.kernel.org, AJvYcCWKJeRUl6fXMiVWzDDlhFO+WtB8jloTvCt3du+tY5aT0XL6zPTnS/UQhT0swNbvxw/WxFW2Yxz2GChbEokV@vger.kernel.org
X-Gm-Message-State: AOJu0YxhxXdlcchvUvyQ2Oz98uPtik1tJ+LsbWd0vEkpo9mzURaAPcCX
	B4dhSWr8P8qS/DCc0evDxxUAsPewMYm37WvRfHk0WdXSCDAeDYkHu0xbiWvIjaSHzdjQ8/GWs2L
	0tcpYj7bnnjTFLNNvG3mO5g5eFag=
X-Gm-Gg: ASbGncsZsmfcHW2HPYuoefsxjFHjA8AupKowStZNAdCEeOP5/MIXRo7+SL1cS5kB/4P
	1HbWYGSd01e0ve4D7PWY8Wpgku6XUz9DhvZCKLTJA8Dtf7oEINoUE/I/WDWDXjjICsHclbqAMTj
	s+ZCy2yJ5eELqKTeVPS2fritc=
X-Google-Smtp-Source: AGHT+IEk58+6+Z8AY7dKKKI99YvdIThZGBgtaiZlaQ0+clqFup0opkmpEozBJaew3HhxREGTabJMb/2OD7j1BlA4mfY=
X-Received: by 2002:a05:6000:2486:b0:39e:cbca:7156 with SMTP id
 ffacd0b85a97d-3a06cf4f24amr55773f8f.1.1745444119284; Wed, 23 Apr 2025
 14:35:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 14:35:18 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 14:35:18 -0700
From: Kane York <kanepyork@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <202504202008.533326EF4@keescook>
References: <202504202008.533326EF4@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Apr 2025 14:35:18 -0700
X-Gm-Features: ATxdqUGGIPDI-VW9u9YHXcVHw682anBK-WlDW0KOLAEZB08mhUTLWij8yQDEYp0
Message-ID: <CABeNrKWW6P0STsmxyL7yOASn63fKyLrCqv=ksomqOJP+ry8PPw@mail.gmail.com>
Subject: Re: [PATCH 0/3] enumarated refcounts, for debugging refcount issues
To: kees@kernel.org
Cc: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 20 Apr 2025 20:09:50 -0700, Kees Cook wrote:
> On Sun, Apr 20, 2025 at 09:27:26PM -0400, Kent Overstreet wrote:
> > On Sun, Apr 20, 2025 at 06:08:41PM -0700, Kees Cook wrote:
> > > On Sun, Apr 20, 2025 at 11:59:13AM -0400, Kent Overstreet wrote:
> > > > Not sure we have a list for library code, but this might be of interest
> > > > to anyone who's had to debug refcount issues on refs with lots of users
> > > > (filesystem people), and I know the hardening folks deal with refcounts
> > > > a lot.
> > >
> > > Why not use refcount_t instead of atomic_t?
> > Out of curiousity, has overflow of an atomic_long_t refcount ever been
> > observed?
>
> Not to my knowledge. :)

Equivalent systems have observed it, but only in the presence of compiler
optimizations that deduce they could increment the refcount multiple times.

  NEVER_INLINE void naughty_ref_increment(ref* ref) {
    long i;
    for (i = 0; i < LONG_MAX/2; i++) {
      ref_get(ref);
    }
  }

Running the above code 3 times will saturate the refcount, if it ever
terminates in our lifetimes (due to being optimized into an
atomic_fetch_add(LONG_MAX/2)).

So: don't write the above code!

