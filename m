Return-Path: <linux-fsdevel+bounces-46881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBBEA95CA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 05:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6AA189682E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 03:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866A919D093;
	Tue, 22 Apr 2025 03:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DqU+K7ny"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE41922C4
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 03:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745294316; cv=none; b=BWHhU79FDTpjnz6/LXIE7baTjOhjoV7Yoaz327A9spPNu+b+4AmQGn9PG7wO2jQ0WRJywl9pZ6ArYFIYss9udQ5ra4UdXOugB5Ht64/FftAz+KXdn9X0dOfikc9MouyldDqS7TJysx1UulSyw9ngZByDQuOsRwTef0cGSgLRbHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745294316; c=relaxed/simple;
	bh=yKRA8ZwqTzTG1B2kWoPv4xIY8kTNcN0dGqSKyOKdIvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rae9SuulPFf1HsM6fzWJHmC6k1O99tZnlxkAj3LsW3Fhc2GDouhkdWD3Q+sCQQg7yEKCpS85IuZ6fcO2e5jWipTyGGRXSDiUzkJZkbuLOVvYXPngUjvm17PHcjSRgkl/8jtcGMG6rwB6PM82ZYSW5riwtGmKnvY2wVQvU+9mtHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DqU+K7ny; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4769e30af66so59651cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 20:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745294313; x=1745899113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za4w8R1db1P50GHT4MAtmBfToY4zX6t9W05URRKIDM4=;
        b=DqU+K7nyhjRgWjOlMGd124Eo8QC9G0AdECUmRWJODHAYmiqvmuSxlDXAsjDES88eTR
         hLizXaYEgAzvUJ+zLI7XA5CNaSSz8CQB1yxmwnsn4jry+IBZswbES2s+Zb5cRkK+cy1b
         nIX7isyRgTLkkEAnK/f9DbkbAPJ05CKmaMa+e8kKvOnLVtCAkzKSFoG+PDf8CRaw6VJB
         3EHwewLmNwb2hipJ+INYPbg/VUtPPzlZoH/GGfCT4GdgQJ0U2l0BXPRr3DfWM1h7mLAM
         kO/k05gYzXW7tySkXCcnjLDQ+SIqJBkwDCgx1Cx2wxGbRdHe1dLDtsEQW7OhETHoQlo4
         xB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745294313; x=1745899113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=za4w8R1db1P50GHT4MAtmBfToY4zX6t9W05URRKIDM4=;
        b=vbjP2RkErHYyfnL34sOo3eDQxPNqbcRAJJC3TVXgi/lmqDYNkzQ2BwH+hG7SBVqNHj
         WHl2XzBAIblJ6/UW2yyLvCCHO/jAZZzQtrR+wCHZKnCFh9SF++Gpyi1YuK/yo/hTyYIf
         svJcFtffwOFlxZ3i74kcB9J6PbtpNzlDExJyoooFPz/IuV0hrIj4lgZfWvunXXpYIhVX
         O2HGs8EMaSglSbKAUi34gb1ko85gwRHkxsP30wy3LClTjKqXIKsS0UHvGsO6Chxkw3fw
         wNz0o2VInKepxO++Cd+ozkGJKq5/jU11M/zjqDsY3cCDijZD0HasXd/fgjYQt8DojY0n
         cjBg==
X-Forwarded-Encrypted: i=1; AJvYcCXmhkm2rsAleMgvsCvcm+ziehmeHx3c5RviFOUQbhfSF+Mzdw4GtXc2lCqQrlU2f9vAOHiH4D6s7lZF4hjo@vger.kernel.org
X-Gm-Message-State: AOJu0YxLkCOC8CBUxacDzScfR293uBNZC/LNw/Yo/9T8WgU8owCRq6fZ
	Wg7F6oJoEFDeFQb/5lkAC870XbhKMRlv3JY87DlvodnlWYT5yhg2zGHgaD2r8ZoMqK1cZtqgiLZ
	XNyD7h6ZpzaSRvzdAJA0XI/d7WKX9vkH3uM2H
X-Gm-Gg: ASbGncsZtAQvMvq3CssIOqgwriLwdnv2lx3bu9X3U3TDHEB++oU968nwlkftoF1QvGL
	1wqVW6ONLVBApzfGrNqA455DSbc44MuNceQFqzTutk6XDRVjCvH1HGxHObycC6XD9ZRrmaYVDIn
	3sVDwgEpAz9HgaxslsOx8bphb7QRQS/72FypmIJ/P8K2AGOcTeXMA=
X-Google-Smtp-Source: AGHT+IFAQcMpksnOj6/LnVgDGD6JBzpXjxag/1e/85G4VIYTdvOtZFPDNyNK6UlAnIZAd4e91YTRU2x31r5jjnrdFuU=
X-Received: by 2002:a05:622a:198f:b0:476:f1a6:d8e8 with SMTP id
 d75a77b69052e-47aecc701e8mr15481851cf.11.1745294313032; Mon, 21 Apr 2025
 20:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206103702.3873743-1-surenb@google.com> <20231206103702.3873743-3-surenb@google.com>
 <8bcb7e5f-3c05-4d92-98f7-b62afa17e2fb@lucifer.local> <rns3bplwlxhdkueowpehtrej6avjbmh6mauwl33pfvr4qptmlg@swctg52xpyya>
 <CAJuCfpFjx2NB8X8zVSGyrcaOfwMApZRfGfuia3ERBKj0XaPgaw@mail.gmail.com>
In-Reply-To: <CAJuCfpFjx2NB8X8zVSGyrcaOfwMApZRfGfuia3ERBKj0XaPgaw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 21 Apr 2025 20:58:22 -0700
X-Gm-Features: ATxdqUGzQHMqMLsQ2-GAAF2yokj3Za5US38h-1Y3L1CGlUceuA7t_asl_5wY1T0
Message-ID: <CAJuCfpHpdAn6yNVq1HXqO0qspj6DLb4qa_QufT+Z9RLTTa-N9Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] userfaultfd: UFFDIO_MOVE uABI
To: Alejandro Colomar <alx@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, aarcange@redhat.com, 
	linux-man@vger.kernel.org, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, shuah@kernel.org, lokeshgidra@google.com, 
	peterx@redhat.com, david@redhat.com, ryan.roberts@arm.com, hughd@google.com, 
	mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org, 
	willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com, 
	zhangpeng362@huawei.com, bgeffon@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, jdduke@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 10:16=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Sat, Apr 19, 2025 at 12:26=E2=80=AFPM Alejandro Colomar <alx@kernel.or=
g> wrote:
> >
> > Hi Lorenzo, Suren, Andrea,
> >
> > On Sat, Apr 19, 2025 at 07:57:36PM +0100, Lorenzo Stoakes wrote:
> > > +cc Alejandro
> >
> > Thanks!
> >
> > > On Wed, Dec 06, 2023 at 02:36:56AM -0800, Suren Baghdasaryan wrote:
> > > > From: Andrea Arcangeli <aarcange@redhat.com>
> > > >
> > > > Implement the uABI of UFFDIO_MOVE ioctl.
> >
> > [...]
> >
> > > >
> > > > [1] https://lore.kernel.org/all/1425575884-2574-1-git-send-email-aa=
rcange@redhat.com/
> > > > [2] https://lore.kernel.org/linux-mm/CA+EESO4uO84SSnBhArH4HvLNhaUQ5=
nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com/
> > > >
> > > > Update for the ioctl_userfaultfd(2)  manpage:
> > >
> > > Sorry to resurrect an old thread but... I don't think this update was=
 ever
> > > propagated anywhere?
> > >
> > > If you did send separately to man-pages list or whatnot maybe worth n=
udging
> > > again?
> > >
> > > I don't see anything at [0].
>
> Thanks for bringing it up! This must have slipped from my attention.
>
> > >
> > > [0]: https://man7.org/linux/man-pages/man2/ioctl_userfaultfd.2.html
> > >
> > > Thanks!
> > >
> > > >
> > > >    UFFDIO_MOVE
> > > >        (Since Linux xxx)  Move a continuous memory chunk into the
> >
> > Nope, it seems this was never sent to linux-man@.
> > <https://lore.kernel.org/linux-man/?q=3DUFFDIO_MOVE>:
>
> Sorry for missing that part.
>
> >
> >         [No results found]
> >
> > Please re-send including linux-man@ in CC, as specified in
> > <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/CONTR=
IBUTING>
>
> Thanks for the reference. Will post the documentation update later today.

Was planning to post today but I'm a bit rusty with the syntax. Will
try to send it out tomorrow after verifying the results.

> Thanks,
> Suren.
>
> >
> >
> > Have a lovely night!
> > Alex
> >
> > --
> > <https://www.alejandro-colomar.es/>

