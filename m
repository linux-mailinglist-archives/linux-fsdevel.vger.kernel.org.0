Return-Path: <linux-fsdevel+bounces-38156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A047A9FD09F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 07:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282553A0579
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 06:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA1513B592;
	Fri, 27 Dec 2024 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYBnJUhZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FD71876;
	Fri, 27 Dec 2024 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735281845; cv=none; b=DrQ0+Jo7qT8DK4udXQhHzzL3WfpmBEPahhQHfLIFzmo/YVVJJgzeMhB06vsfykC7TJ9K9IgSMGsxnhlH2Q5G+8E5Bntd1CWocLucSAOsQgABQkgcip0qiRDWJpeCwEM09jaJEJOcq0Hv2rh58kTDo8qDFK7/OMytRPU0AqYGk4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735281845; c=relaxed/simple;
	bh=mtEVHdjFrMeo0LcF+J7XobO9iNcWNDV9Gsnss4pHriM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=lOL99MqsCTWqWgfNKiAPFK/VMmL8FdtljFwyzlAuLkavfFw86ZN0X23c6pAoCCGOM2Lib8Jp0ygYBeg15ZRbIUFgwOtvUDCiMTCJ65VZ20uUNpmvS1TSSrLJrero+jYCoCVIVefO4+gM+C7U6h++YC1ZJ2Dmuwbp/tGVEjJHki4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYBnJUhZ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so9162202a12.1;
        Thu, 26 Dec 2024 22:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735281841; x=1735886641; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ekaj3T/I82JW+8FjErfQ0VZwUHj+ybs1lVyr97c52dQ=;
        b=QYBnJUhZzar8bzxpodnwq3rmDM6VJX7Do7ghqxuwA41D3wcPaoGu1mhL1nluuOgz6V
         ZdVvDOsJQDzjD6M25Da9HbqKbc44cfVjngxfW0D6L++uurF3ClZnK6bJVzeGlDaIjlqa
         izqbrfzslMd57PAAGKkd5Osb/Dfr6S/y8AolL3spwY8Vn2oVrZqSoUtHRNAoR4hVFWv+
         nQVVeZpIe/laWXgYLUR+0gQZl6SflzQMP0Ajwr7lkmDdE82Az2op+7yakWWkcjV5Oz4a
         ModT85hTz4ISU0IbLArdesBBNHWhaeETOx0K3LDJfYu6nGASOQWlO0KA1NKb0NTxuACq
         0JcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735281841; x=1735886641;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ekaj3T/I82JW+8FjErfQ0VZwUHj+ybs1lVyr97c52dQ=;
        b=INVtqf8cVKtuTGgfoRcP9wwf48XCDPqJhHBjQLfUCQeJXy0Cp0rrLSb1WlJPcsG6mi
         JFU6IPPznt3i95H67hxvyrpj72Dkd9473HBQBZyWgYpSIZQYUHljZlJZx6JTCpGN6by8
         ERuMbC6pQQj7wUcnctj/t91XaSeM6rBufvy+K2/VMljFWPMoQX4a22FYl9h/OLLUQzjT
         FfBGJfE+p2h0/wQ0lmnXyXYKvTTCy4CYL0H12uvD/JDVq5HpDDx4js4o/QKvFgEUqmyg
         at7gkjRF/wVukLuiO+cxoYQAMOg3A0AklD6dziugcwlGeoAiSQggNlmyDChHsGu8o2hd
         fJUw==
X-Forwarded-Encrypted: i=1; AJvYcCVIny0os/oq7fdW6sm4qF7vnV++9o0ch75l+PLLQ0xQ6rPMaswidsdpZB5L/87B1G4eYCBdcnJJ1+w9@vger.kernel.org, AJvYcCWaotskztFDOaq13b9uzu74hTygOqLlHqjklFkMPJdg7n4QJcx4cXdDn0S34DWc+EW6lz/3vlD27QCa7ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTT8ObGsYqdI5xRCjpNhqURF5950C7xXIjB0uIdz+SzF3Ls3lk
	GVrfqp7F0tDKLgaeQPDarh5kLVP+WrMOqrUQbH1QAGDD5tnIwvh6RLe9c6hVn2/XknsK//4qcmX
	w4cpmSToSpgIg6SkQiTlrukrD/R7SNQ==
X-Gm-Gg: ASbGncsO+BpDWTXqvZGJB1PWZFQ5qxfsNxmp1GsYLSkfYIvsgWzQ/N/rbgElAuEg/lo
	Icnky2UaiqX3oKdamADEo0yJLiJFqdIRfes3bkYQ=
X-Google-Smtp-Source: AGHT+IGLQPRro6p+IqEDYMslg8fSvVAn+4l/feE/ZC3pT4O7FHtn+vOWij1lWZ9vd56F7/do5oxfTBvhqGGjJ7N2HOI=
X-Received: by 2002:a05:6402:2344:b0:5d0:e410:468b with SMTP id
 4fb4d7f45d1cf-5d81dd64032mr20383623a12.2.1735281840726; Thu, 26 Dec 2024
 22:44:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
 <20240905-delstid-v4-1-d3e5fd34d107@kernel.org> <Zt3mK3fn0gWEsD9d@tissot.1015granger.net>
 <4eb752d9d8fabc0951df41762d92f751507292a3.camel@kernel.org>
In-Reply-To: <4eb752d9d8fabc0951df41762d92f751507292a3.camel@kernel.org>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Fri, 27 Dec 2024 07:42:00 +0100
Message-ID: <CALXu0UcORpnDCOz4Z-BQmXXvaNZ3cH4Og+E1L-CUwqzNGjh6oQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] nfsd: fix initial getattr on write delegation
To: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Sept 2024 at 22:40, Jeff Layton <jlayton@kernel.org> wrote:
>
> On Sun, 2024-09-08 at 14:00 -0400, Chuck Lever wrote:
> > On Thu, Sep 05, 2024 at 08:41:45AM -0400, Jeff Layton wrote:
> > > At this point in compound processing, currentfh refers to the parent of
> > > the file, not the file itself. Get the correct dentry from the delegation
> > > stateid instead.
> > >
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/nfs4state.c | 31 +++++++++++++++++++++++--------
> > >  1 file changed, 23 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index df69dc6af467..db90677fc016 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -5914,6 +5914,26 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4_open *open, int status)
> > >     }
> > >  }
> > >
> > > +static bool
> > > +nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
> > > +                struct kstat *stat)
> > > +{
> > > +   struct nfsd_file *nf = find_rw_file(dp->dl_stid.sc_file);
> >
> > The xfstests workflow on NFSv4.2 exhausts the capacity of both the
> > main and scratch devices (backed by xfs) about half-way through
> > each test run.
> >
> > Deleting all visible files on both devices frees only a little bit
> > of space. The test exports can be unshared but not unmounted
> > (EBUSY). Looks like unlinked but still open files, maybe.
> >
> > Bisected to this here patch.
> >
> > Should there be a matching nfsd_file_put() book-end for the new
> > find_rw_file() call site?
> >
>
> Yes. Braino on my end. I was thinking that find_rw_file didn't take a
> reference, but it does and we do need to put it. Would you like me to
> respin, or do you just want to add it in the appropriate spot?

Did the respin ever happen?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

