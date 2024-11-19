Return-Path: <linux-fsdevel+bounces-35224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF649D2A37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 16:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A2B282D9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B9E1D0159;
	Tue, 19 Nov 2024 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oeA1y6+1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1353C463
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2024 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031630; cv=none; b=Kisewyq+/nD/uNRoPu4lqKYCeWpdPb8aZIkE4HVorjoknLZPg7g0qSUQgOwIrxMlcn5UHPL+kkxNv7FwutwOCO7qeXH6+JJw+2SXMuYgwulU6QAzhzzTsfl6YDNtOCy1AUCqhpfs6Gtlgo/ZQBIuY2iBmtFtlgC+2fAvpglF0z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031630; c=relaxed/simple;
	bh=oZBz6My2fl2cEQ/H4m7spItLuifNL3YkZ0yddOy41YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INuzgWwdV6KYwcl7U+MMcZcwJs7mom4AbSV0/O2dFbnGtpfZR7i8Yw61cG4ETcjG1Conm03OnxZw3yvEVUo+iiw7qtM08zpBk7MDi5/miAv7Q+KRpQQgG0zh6m9+g7mU7qL9ZQWOGvkHfb7nAT38tgwjBedPuRUELwcbSHujrBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oeA1y6+1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cfc264b8b6so11890a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2024 07:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732031627; x=1732636427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZBz6My2fl2cEQ/H4m7spItLuifNL3YkZ0yddOy41YQ=;
        b=oeA1y6+1eIa+KuXOu9qX7nu6h0bMz7NENQrNnJI47zwqpW6+yDIEi9QRdmjSgnaIlF
         k/RYgwEKxtf6zHr6my7/5bGrZq3tgO7I+ucxLpTd8W5zSJn3Li/1SXONWmkZlkDCQ+kP
         u6S6gbOFJLE3Yh2GTLsTZl5A06hCVjr5W5QMbMd0aYChC3jhaZuyHjCvmsgyZUx9uyUX
         b3SE0BGt53TC5G9A2i25OLm5rBsDdSCt+5r7JV8s4+ApK57hz38jpa/6CBXvr1zyP4nS
         uXNeMGxAn5LjJ+oaoSJ02f9gnaKTPk0kkRfForcsHfNuf2h/4jX9e/H1czJNFFLxMzBt
         NrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732031627; x=1732636427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZBz6My2fl2cEQ/H4m7spItLuifNL3YkZ0yddOy41YQ=;
        b=bdHNmr/J7GB8TiWDVfm8t+gXLnzl+qvw3oMb4v0HN7cuEDUMflGAKF6Kz8rxF+tFP9
         6awSb+3zxX3rrDGjpGHXW1p21Lt4gL4VViG5qPFq5iFsoAcaIV8yh8eJZpaiUgAamKCZ
         ZWlXR15ej/5Wq1zThLTUcVbemt3Zrt6RL7zEkM8cEEVIAmAaoCvxFh/hX1dyevIgfeP4
         xeZ8yYy8YlmGVdVN7vRw7IywbAff5fOM3yZuepNPhNftuxhKPsUlq0wTG4W0RynAn1Z8
         EHtFkq0nvVHqlvxeUYj5+R//AoCZjmP7Ht2WnCIur8RUxXCyAXcddGb1T1Jwzq8wHqt7
         f50g==
X-Forwarded-Encrypted: i=1; AJvYcCX6yBfABf5fs62NSQowCkqBTJ7oHX/h0+Vh3LeAh5bnB7P9Sqqpacr9SwQv3ANv8jzEScSgVBsN4t8VEr9o@vger.kernel.org
X-Gm-Message-State: AOJu0YwIaurlt3syYmW30kOKa3WZL5UsFNTfK/OX79b1tAwODc56PgQs
	0U77TcvUiiF/aRtlhng36sJqhU5f8AyVvRetVf0SYRV9276Z7uB/YqV5gUR0Ci9+C6Q/LETotu1
	p4jKY+IfgmJLCo5GnFZOHUkL4WSFA79YTkQiU
X-Gm-Gg: ASbGncurb5Q3LLwABJvF+wxEz6CsEbuZXW6sjkAxuQHTkhwwle412Pqrdcw88zBurFz
	haHRO+VPNB0X1HyPpAPkqQQMUfgNXHf/cg216YoPxP4idcwYBJgg8XceeyS8=
X-Google-Smtp-Source: AGHT+IGNsuMEPDGgLQcJBGgUTcQNAXs25llr0/NFfx7zpUAdIJ2qG87STQ6ogH4Jn3C0zEhl2cmBRbcH53+WD7m9EI4=
X-Received: by 2002:aa7:c251:0:b0:5cf:f20c:bdf0 with SMTP id
 4fb4d7f45d1cf-5cff20cbec4mr2276a12.4.1732031626961; Tue, 19 Nov 2024 07:53:46
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <a0372f7f-9a85-4d3e-ba20-b5911a8189e3@lucifer.local> <CAG48ez2vG0tr=H8csGes7HN_5HPQAh4WZU8U1G945K1GKfABPg@mail.gmail.com>
 <CA+CK2bB0w=i1z78AJbr2gZE9ybYki4Vz_s53=8URrxwyPvvB+A@mail.gmail.com>
 <CAG48ez1KFFXzy5qcYVZLnUEztaZxDGY2+4GvwYq7Hb=Y=3FBxQ@mail.gmail.com>
 <CA+CK2bCBwZFomepG-Pp6oiAwHQiKdsTLe3rYtE3hFSQ5spEDww@mail.gmail.com>
 <CAG48ez0NzMbwnbvMO7KbUROZq5ne7fhiau49v7oyxwPrYL=P6Q@mail.gmail.com> <CA+CK2bByXtm8sLyFzDDzm5xC6xb=DEutaRUeujGJdwf-kmK1gA@mail.gmail.com>
In-Reply-To: <CA+CK2bByXtm8sLyFzDDzm5xC6xb=DEutaRUeujGJdwf-kmK1gA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 19 Nov 2024 16:53:10 +0100
Message-ID: <CAG48ez3zNWJY=3EcuS1n1cFyujUO7CXAYe7=H48Ja_WmdL_PYw@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com, 
	linux-hardening@vger.kernel.org, 
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 4:14=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
> On Tue, Nov 19, 2024 at 7:52=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> > On Tue, Nov 19, 2024 at 2:30=E2=80=AFAM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> > > > Can you point me to where a refcounted reference to the page comes
> > > > from when page_detective_metadata() calls dump_page_lvl()?
> > >
> > > I am sorry, I remembered incorrectly, we are getting reference right
> > > after dump_page_lvl() in page_detective_memcg() -> folio_try_get(); I
> > > will move the folio_try_get() to before dump_page_lvl().
> > >
> > > > > > So I think dump_page() in its current form is not something we =
should
> > > > > > expose to a userspace-reachable API.
> > > > >
> > > > > We use dump_page() all over WARN_ONs in MM code where pages might=
 not
> > > > > be locked, but this is a good point, that while even the existing
> > > > > usage might be racy, providing a user-reachable API potentially m=
akes
> > > > > it worse. I will see if I could add some locking before dump_page=
(),
> > > > > or make a dump_page variant that does not do dump_mapping().
> > > >
> > > > To be clear, I am not that strongly opposed to racily reading data
> > > > such that the data may not be internally consistent or such; but th=
is
> > > > is a case of racy use-after-free reads that might end up dumping
> > > > entirely unrelated memory contents into dmesg. I think we should
> > > > properly protect against that in an API that userspace can invoke.
> > > > Otherwise, if we race, we might end up writing random memory conten=
ts
> > > > into dmesg; and if we are particularly unlucky, those random memory
> > > > contents could be PII or authentication tokens or such.
> > > >
> > > > I'm not entirely sure what the right approach is here; I guess it
> > > > makes sense that when the kernel internally detects corruption,
> > > > dump_page doesn't take references on pages it accesses to avoid
> > > > corrupting things further. If you are looking at a page based on a
> > > > userspace request, I guess you could access the page with the
> > > > necessary locking to access its properties under the normal locking
> > > > rules?
> > >
> > > I will take reference, as we already do that for memcg purpose, but
> > > have not included dump_page().
> >
> > Note that taking a reference on the page does not make all of
> > dump_page() fine; in particular, my understanding is that
> > folio_mapping() requires that the page is locked in order to return a
> > stable pointer, and some of the code in dump_mapping() would probably
> > also require some other locks - probably at least on the inode and
> > maybe also on the dentry, I think? Otherwise the inode's dentry list
> > can probably change concurrently, and the dentry's name pointer can
> > change too.
>
> Agreed, once reference is taken, the page identity cannot change (i.e.
> if it is a named page it will stay a named page), but dentry can be
> renamed. I will look into what can be done to guarantee consistency in
> the next version. There is also a fallback if locking cannot be
> reliably resolved (i.e. for performance reasons) where we can make
> dump_mapping() optionally disabled from dump_page_lvl() with a new
> argument flag.

Yeah, I think if you don't need the details that dump_mapping() shows,
skipping that for user-requested dumps might be a reasonable option.

