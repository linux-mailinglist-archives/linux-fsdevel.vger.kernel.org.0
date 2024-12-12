Return-Path: <linux-fsdevel+bounces-37214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA529EFA1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 18:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7E6189C6BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB8522370C;
	Thu, 12 Dec 2024 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtTyoHXH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87296223711
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 17:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025964; cv=none; b=mKhRdBAIdKcd+FbLc9PNY1CnOhn574O7p7NHEAFiZjXWCqZKH2I0+BJf+tE2ZL2JqqLoQvftBRptq6by8BJsAEvy9UsJN94vP5MG8W6JCBO49IV4VOyDtgvo+7dNa4DHItYxZjPgb0TVK8GOv1XJq2M5Sqmr+xLa+CA0x8HsFWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025964; c=relaxed/simple;
	bh=t5LJHpRHH84d90gMLgTTKnCKjHPRoxenrD3X6gOmXI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6OwQHB+WIrszWiUzezkBHCWvNnyZ1FoP3YOGeBhm6apmopF8ISmTHVnYVKB9MQ5qMY4CDHEr0gZNbMcDMJO1/9zVT9+G2qGZCOrmXwMqncZ86zTrEx3Ku5ckjblx2e3BDZGPuoTRxDxD+Dty3Xc5K8uJ9lXXybAZeqpYzkXYGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtTyoHXH; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46375ac25fbso9616061cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 09:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734025960; x=1734630760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjqAYqHkPAoYJFN099uHOWmg6hY23BZAD33mTlQbU3s=;
        b=GtTyoHXHMcEc299UZwNSqE9UmeEAj14wP2Wc8LYGw8L7uBBR1RplKWk7fCfHz4CpiH
         0qdN45yrt35PA6V6gbnn40kYf2TL6AZo95PfESFLw4d4CzkkbJMNVprfo8E3jev90vSY
         Ql8IoSXmxklsA6JxfexC03+6IGO06Q9ssfPzDKRiCRxmraeXbFxmYzY0Lm8wW56je+7D
         hZwOCQDV8TmM0BqQhEG4Tm6SuIytEbgCH7+EhsaeqSzIMoOKQqwmn9SiTY1XSYgSeygj
         HgGkUKYSBPJ6yvuW1KFJHpvHndwBgJOfzkopSz5waSAEmSElrwIkw5qDrg7NvWl74lzm
         4Sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734025960; x=1734630760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjqAYqHkPAoYJFN099uHOWmg6hY23BZAD33mTlQbU3s=;
        b=loTHjlziGias9LKe8O2QXSBMnBcrDiRzyz7yWZHBeZ8r/Fno/5ljV8Waj3E49iERC2
         lIVewQolgoOJqOL0lumXNrO3muxO98l/yrFpW1SE84i/2r3s2AqV3UpZV6lAZAq9rZuL
         yMChEft2IZQuE4+XTFkxSUrvfhYwgBD+BmzXdL32hGpge7LtlEy7CM+V6cNfBrujl0gQ
         t/TWdLGrfXHNkbsyr7As0ZXZ13QvHtpBOFFkACarEBSc+vs10du9zqPrgIUesaYJ7ll+
         zyJXjsgWGkP4ai43rI/l4VIwdViuiC499koX1oASzl4HASqu79scRJ7YFhZU8Ayf/V7S
         20Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXntLtDhbdsi9xsuYpcNO/aKdPAu7UrKlaBZLA3GeVlM6OCBWuiJ0LgljtE/E6hOLRMkWH7gXCLnLCYE/ue@vger.kernel.org
X-Gm-Message-State: AOJu0YzvhUW+wAKIrpwByaTQtH+iVHuVy6k7cumL9hMHDf89QVJzzV0l
	a7T/Fkx7G38OPbMKrnBURCTHbKSypEfBcrliRM9QuO1HLZl0ILnwbRmeG55yK49HFkDv188QhX6
	aXQgXwgyreKXQOVto0mz1vessVVQ=
X-Gm-Gg: ASbGnctKaWrTtzVQAa+7JJh85tU+s3v1yHnJoJrHGa8YUUhP/d8kYqbzOfZKlWXIU2P
	fNOwX0gMRGuT5UnNRGJG94G5QtQOXu8jqXOyFvuI=
X-Google-Smtp-Source: AGHT+IGhCMVuXv7b3jtgQWohuzvyjeU1+dK699iyaslJbYEliI1CYWZm7WA9mHQ9TtfWtDKq2d7JC5PXHIh2+LvQftg=
X-Received: by 2002:a05:622a:c9:b0:467:6cd9:3093 with SMTP id
 d75a77b69052e-467a16e1b4fmr19140661cf.46.1734025960295; Thu, 12 Dec 2024
 09:52:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211194522.31977-1-etmartin4313@gmail.com>
 <20241211194522.31977-2-etmartin4313@gmail.com> <CAJnrk1bE5UxUC1R1+FpPBt_BTPcO_E9A6n6684rEpGOC4xBvNw@mail.gmail.com>
 <CAMHPp_SqSRRpZO8j6TTskrCCjoRNcco+3mceUHwUxQ0aG_0G-A@mail.gmail.com>
 <CAK1f24=SjvSg0EFjvB29zUySRN7BR4O45XkcsL5Ob8jLebYTaQ@mail.gmail.com>
 <CAMHPp_SFP9s0rjZRG_V6m8SF09Oi5Tb9tQaiP3p=UhbCKg_2+A@mail.gmail.com> <CAK1f24knsHBi4hShGPP4KrEv=Erk5XOQ5CQv_e7VrK0RfirGkg@mail.gmail.com>
In-Reply-To: <CAK1f24knsHBi4hShGPP4KrEv=Erk5XOQ5CQv_e7VrK0RfirGkg@mail.gmail.com>
From: Etienne Martineau <etmartin4313@gmail.com>
Date: Thu, 12 Dec 2024 12:52:29 -0500
Message-ID: <CAMHPp_SKkiB6b1SRsq=PmdgcaHhLSEcQKe1FkXv9oqacsGj9wg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Abort connection if FUSE server get stuck
To: Lance Yang <ioworker0@gmail.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	miklos@szeredi.hu, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, laoar.shao@gmail.com, senozhatsky@chromium.org, 
	etmartin@cisco.com, joel.granados@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Barry Song <21cnbao@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 10:09=E2=80=AFAM Lance Yang <ioworker0@gmail.com> w=
rote:
>
> CC+ Andrew
> CC+ David
> CC+ Matthew
> CC+ Barry
> CC+ Ryan
>

> > Regular file-system drivers handles everything internally but FUSE on
> > the other hands,
> > delegate the file system operation to a user process ( FUSE server )
> > If the FUSE server is turning bad, you don't want to reload right?
>
> To me, it makes sense to reload the system if HUNG_TASK_PANIC is
> enabled. Doing so allows me to notice the issue in time and resolve it
> through the kernel dump, IHMO.
>
Going thru the kdump and extract the gcore of the FUSE server is a bit
convoluted.
Maybe we should SIGABRT the server directly then?

> >
> > A non-privileged user can  potentially exploit this flaw and trigger a
> > reload. I'm
> > surprised that this didn't get flagged before ( maybe I'm missing somet=
hing ? )
> > IMO this is why I think something needs to be done for the stable
> > branch as well.
>
> AFAIK, besides this, a non-privileged user has other ways to cause some
> processes to stay in the D state for a long period of time.
>
On older releases it used to be possible to trip the timer by banging
on some USB devices
but I believe this is fixed. Do you have an example?

> >
> > >
> > > If HUNG_TASK_PANIC is set, we should do a reload when a hung task is =
detected;
> > > this is working as expected IHMO.
> > Say when your browser hangs on your system, do you reload? FUSE server
> > is just another
> > process.
>
> Hmm... the choice to enable HUNG_TASK_PANIC should be up to the user, whi=
le
> the decision to reload the system should be up to the hung task detector =
;)
>
> Thanks a lot for including me. It seems like we're not on the same page a=
nd I'm
> also not a FUSE expert. So, let's hear the views of others.
>
> Thanks,
> Lance
>
>
thanks,
Etienne

