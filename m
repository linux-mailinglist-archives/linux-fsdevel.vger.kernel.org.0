Return-Path: <linux-fsdevel+bounces-9049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFA483D773
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 11:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB061C2D212
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 10:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DDF20332;
	Fri, 26 Jan 2024 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWFkG3ek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32A22031E;
	Fri, 26 Jan 2024 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261353; cv=none; b=Rs5+V07Rprg2W36TCbTSyfA0M5PDb6fA0AKXRZzVflnY9dCd2RfZpiweeR2rvGvOWvHb1ODawJEfYpd9SLaFMtgYglykep7krpsQKu7Ag8sOruKdfWs+Epvs1ZyilyTA8yTR2GKb0fwn9ty3tOJ9hp++hAOqxqwhNsI946QE3Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261353; c=relaxed/simple;
	bh=2GO7Kp3vfdLO1W9xw3SynsKsljBCFhfa3Vk61NJbQzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPdMSVqCNDnT0EN3QSh89ogivuPI+4YPIqtRZchNBVFiNCK35mjRPVmjdWsQiLhJ5wKFrNRlxy+CE/VuHiq4Jj4c6LMr51FrBnSkveV3x/cQM43MD6H3WMLyD3cze8E2iU9P8/i31jlTOUqiFBZPmfSdUp78CRelt9L2cBogIlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWFkG3ek; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51022133a84so190639e87.3;
        Fri, 26 Jan 2024 01:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706261350; x=1706866150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkuT80Nd2CrCGFE0QyltfIZ25KKAHv/Lip39TXBqmQk=;
        b=XWFkG3ekEDNRQ3kgf4dC49CVElIIKXplBwpWID4rklUU9Ry8ZR+YnRuo2Vbi0i6Obg
         APdHBI6fatoki1xRNPCjGbEb1Fdpxxx3I5/LivwJh4No3GMXN/FVS+THlj/Wt/G7d/bp
         VW3H+D5vTmNWRHX76xllKbU4zK55hAP2NMnfgeRgNS9bXn21lcCu/qsieLYwjuq/H5vc
         bA69ElcxLsBYrEjWKoL0e8ThYj8xLeJNuZbMrX1qwQpR2YSgQ7uv82Ad3CUSedzHdb0I
         mwyp/QblcNs67zJ/NCTj4ObsLzP3sqDFnzLgWG6exuxuSHxZ4Sxk5vCMu699rykSj8ex
         y+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706261350; x=1706866150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkuT80Nd2CrCGFE0QyltfIZ25KKAHv/Lip39TXBqmQk=;
        b=SUqz6JOnPHhohJMIe+RxmdQFi7N35cfyq7fmEO05C+19bhSH5gOHL8FioMHYtvcVID
         6MVSGDDEEVBYdlWcbgndCExOhO99iwysRiYcc9ybePhsUul3oZefb7/JrOMn2FPBJj7h
         5qdhztWeqwgTisxZYiNs23FAG6rqQ5JHkW0/5U8xsqJKsvZZjwF8ngndkpNWoOoNaoaQ
         oK333R3rE4X5xl1CJlhLzT0d6ISMfDh77ZvorJRSoXjNDb2gHujy1oQhxZbOeIebS+ew
         K8CJ1x502euu0LE7MF6hEtz0TuSwJ2o57eY6ibhTICtOHZLIakZ1uI+KtfoaeHcocYId
         Vzyw==
X-Gm-Message-State: AOJu0Yxx/JUvDXt9I5/eDwjR9UsYqERDlhGxFxFKwL2i7y0iHMoXVE8P
	yhM8lWWpsQKkZ8Xyw95WjKWpv6ynU2rsy7c/jFWsiOj1Q3NSu6Ygqlc5x2KRVlVMVpKDQj8Oyfz
	laxvAyhbPkoj7HRqy58o+C/BSHMQ=
X-Google-Smtp-Source: AGHT+IHV6gJ2ig0SHMuOTHGQ+PLhYhpTaXEWeuYlswOgs1YTMiZiy85Ixu1kYbFdpgt0BVJ8+WbJ4vEwQODjQvUsc68=
X-Received: by 2002:a05:6512:31d1:b0:50e:aa04:b2eb with SMTP id
 j17-20020a05651231d100b0050eaa04b2ebmr1762991lfe.42.1706261349518; Fri, 26
 Jan 2024 01:29:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125071901.3223188-1-zhaoyang.huang@unisoc.com>
 <CAGWkznGpW=bUxET8yZGu4dNTBfsj7n79yXsTD23fE5-SWkdjfA@mail.gmail.com> <ZbNziLeet7TbDKEl@casper.infradead.org>
In-Reply-To: <ZbNziLeet7TbDKEl@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 26 Jan 2024 17:28:58 +0800
Message-ID: <CAGWkznGG1xLcPMsWbbXqO5iUWqC2UmyWwcJaFd4WBQ-aFE=-jA@mail.gmail.com>
Subject: Re: [PATCHv3 1/1] block: introduce content activity based ioprio
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Yu Zhao <yuzhao@google.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Hannes Reinecke <hare@suse.de>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 4:55=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Jan 26, 2024 at 03:59:48PM +0800, Zhaoyang Huang wrote:
> > loop more mm and fs guys for more comments
>
> I agree with everything Damien said.  But also ...
ok, I will find a way to solve this problem.
>
> > > +bool BIO_ADD_FOLIO(struct bio *bio, struct folio *folio, size_t len,
> > > +               size_t off)
>
> You don't add any users of these functions.  It's hard to assess whether
> this is the right API when there are no example users.
Actually, the code has been tested on ext4 and f2fs by patchv2 on a
v6.6 6GB android system where I get the test result posted on the
commit message. These APIs is to keep block layer clean and wrap
things up for fs.
>
> > > +       activity +=3D (bio->bi_vcnt + 1 <=3D IOPRIO_NR_ACTIVITY &&
> > > +                       PageWorkingset(&folio->page)) ? 1 : 0;
>
> folio_test_workingset().
>
> > > +       return bio_add_page(bio, &folio->page, len, off) > 0;
>
> bio_add_folio().
>
> > > +int BIO_ADD_PAGE(struct bio *bio, struct page *page,
> > > +               unsigned int len, unsigned int offset)
> > > +{
> > > +       int class, level, hint, activity;
> > > +
> > > +       if (bio_add_page(bio, page, len, offset) > 0) {
> > > +               class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> > > +               level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
> > > +               hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
> > > +               activity =3D IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
> > > +               activity +=3D (bio->bi_vcnt <=3D IOPRIO_NR_ACTIVITY &=
& PageWorkingset(page)) ? 1 : 0;
> > > +               bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_ACTIVITY(class, =
level, hint, activity);
> > > +       }
>
> why are BIO_ADD_PAGE and BIO_ADD_FOLIO so very different from each
> other?
These two API just repeat the same thing that bio_add_page and
bio_add_folio do.
>
> > >  static __always_inline __u16 ioprio_value(int prioclass, int priolev=
el,
> > > -                                         int priohint)
> > > +               int priohint)
>
> why did you change this whitespace?
>
> > >  {
> > >         if (IOPRIO_BAD_VALUE(prioclass, IOPRIO_NR_CLASSES) ||
> > > -           IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS) ||
> > > -           IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS))
> > > +                       IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS)=
 ||
> > > +                       IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS))
>
> ditto
These white spaces are trimmed by vim, I will change them back in next vers=
ion.
>
> > >                 return IOPRIO_CLASS_INVALID << IOPRIO_CLASS_SHIFT;
> > >
> > >         return (prioclass << IOPRIO_CLASS_SHIFT) |
> > >                 (priohint << IOPRIO_HINT_SHIFT) | priolevel;
> > >  }
> > > -
>
> more gratuitous whitespace change
>

