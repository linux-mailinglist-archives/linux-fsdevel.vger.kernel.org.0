Return-Path: <linux-fsdevel+bounces-30233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918319880EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 10:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D134C1C22243
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 08:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33CF18A6CA;
	Fri, 27 Sep 2024 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqAazClv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19EC18C1F;
	Fri, 27 Sep 2024 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727427485; cv=none; b=RSaQfqPiL6gEx7MR+stae+M7VlfB1BaZaZnRHeGMAd20771EAkWBwyaJK0kCRZKswDKPPhhFLYN6G/Cv87DckLqkbHY6P2JKwtEpqnzcPQtxKNQYN0U56emsdwCC4kzKsb1Ud6TX5jD3zLHFTzlr3oQ2ODesnvlFTI0Xl+NWcUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727427485; c=relaxed/simple;
	bh=pEp5gXfIjEbg1ta4gdp8fy84aFsgcENp6aqfPlh6iqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJZWOmteWdSYbFZE6Uohme4xxBsSm/nNpu/lBbKBfNsdem1U4CeHDRWdQDqMAMd+I0Ea/HjOMtu5mtrI84atwtvSmJZq0qDz6/T++9q7RAm4n/mFpwRLK43TEYfFlOXh6gZLsWM6s9y/g09caFpc3VBIreyCFYurWfFQyLbNCXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqAazClv; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4a3075662b6so344760137.1;
        Fri, 27 Sep 2024 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727427483; x=1728032283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eg8VUnCWU6xpmCG+ce1Tu7r95og6PEk5nWNUF8PLnD0=;
        b=gqAazClv8s0ANTY895QSRiOBzehxWHAxTajzp8+L4oMVqITx1Rc1ZRR9N9zO3Vk1iS
         0E0oCx/nlNg97ah1qOH5riadZAAUmcSvNTYO5+8cO82PLUIPlS/cfntRZC9yPsZp5BNq
         HZigxvF8s1kAqeM4oah+T9Tu7K/saEbRk9nxIw4DIvRuG/wE2jmZ+lLUJ0nSO9Dx2xMF
         0I10U74DdkKzjVpgTDGlNKXooe+uatFavOqUsEAAcqBFLrRAjiPMFMCrJtoLD3RBJ5An
         kmon8czuYyTN9mFTIFXEn+V4NwEhigt5kZsoBpPbFRmrglYrNA4EqqQsJbKRRvYNpG4I
         noGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727427483; x=1728032283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eg8VUnCWU6xpmCG+ce1Tu7r95og6PEk5nWNUF8PLnD0=;
        b=gv9fLOBopnpIo0Vc3onAwq98+o1AmwfsGOzUyG8gbGravcS6kGattnVwcEWUJUJe40
         +0OOaYz2ANAIKW0RBypiVzAdT1I3PPoxhOlVSraoYfh2Bvxgo0knFVqOXuiZGWQJ/0uI
         wNEBBqoz2gsSku0wksBpFcUDb4BUZnjJQ5uzKu3fioSEbsV0pTWGrFkuQ01jqemwx+0B
         Lti5Sm19C0rU2s/Z1M0gTtzA1hyMkguLjTvVPMb3XU/fyRpveYS6rj1uJ0AiB2JqyjVk
         qom0D4uTvulcKDDjVr8ygshXwLmd/7QDhYBW9C/c/49306qMxXO6s7s0LoNKBHccM8yq
         ZzlA==
X-Forwarded-Encrypted: i=1; AJvYcCU2kNwiVal/pbxQT4WCA9SZmuyu4dEISqslPuFr2sq3fPC9fh4lTuNtOeMwBn7eFImzsyFFI6xRhuhFf81Yz1wZL1wQ@vger.kernel.org, AJvYcCV2d0D0BsiKzXbQwL2TqwG+DY84lebb4Cux4G3ododFoAY6h2IDdKJbj2Rirj5VI/GV5D4wQlxe+CgYaZXOIQ==@vger.kernel.org, AJvYcCVBl/qvinXfWiUkGDVSQEEFr34DlHiFhgvil23df4xrDTJaQwe8+RbTWWC7NSxrKM2HLeN0@vger.kernel.org, AJvYcCWv54scAvVjhxJ7pezM8EjvxB7WchzIL10MLmaFUD5N0HnHJDuhrh3OttX2qEFrQFjslKvAbekh@vger.kernel.org, AJvYcCX9euyxmhyykrVUsgOdHzuNKV/u6O+k37wODRkiEsSzy6g1Zc4McDVPNUsKwU5fVqUshNJjLg==@vger.kernel.org, AJvYcCXd2/Cf5XF8BV7pfNUiXvazo1DtVaAEBfxUYPzvDHrcZrXX9wPyDY7dwNKWJ6jM7wdBSmSTZMDWtvu24YZf0jTXd+AvdPDG@vger.kernel.org, AJvYcCXuBnXWcCYL00ekJ2MlOU2kOwc6+ENoSoMdNGRjknOmTeVb81bBrChPPP9VJ0o7LFuwo9fkrerckw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlZYuYIBAqeuADDiwDH4QGdEkax+KYdlNITZDIn6qmDW0w1eWE
	ziTAFLcqCrTmyw7kYJrLRlLAjg2pJLbz0YY1FjnOza6HmFweOxsxMhgfO6ZnU2yzL/YdMhgEvO0
	CMEi91DmBjgQJjf1VLr4BwrAZDmk=
X-Google-Smtp-Source: AGHT+IHlhccJP6o8YVDcpGsoOKh73nleQWjN6gMlntdM8azrnOLgCbN569DWouWNGBJF/Vf+8gknJS6h6du5PlKNbYc=
X-Received: by 2002:a05:6102:2ac4:b0:49b:e9fc:14d2 with SMTP id
 ada2fe7eead31-4a2d7ff9815mr2856108137.23.1727427482685; Fri, 27 Sep 2024
 01:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817025624.13157-1-laoar.shao@gmail.com> <20240817025624.13157-6-laoar.shao@gmail.com>
 <CAHp75VdpG=yQVaJLR3J5puwj4FYWtXzaHkC1TdmiqfJu1s9PpA@mail.gmail.com>
In-Reply-To: <CAHp75VdpG=yQVaJLR3J5puwj4FYWtXzaHkC1TdmiqfJu1s9PpA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 27 Sep 2024 16:57:26 +0800
Message-ID: <CALOAHbBHV_xB88AD8azVXZQzdowLtU6EHewFGUtPHQE9K6GQ_Q@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] mm/util: Fix possible race condition in kstrdup()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, alx@kernel.org, 
	justinstitt@google.com, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:35=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Sep 26, 2024 at 7:44=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > In kstrdup(), it is critical to ensure that the dest string is always
> > NUL-terminated. However, potential race condidtion can occur between a
>
> condition
>
> > writer and a reader.
> >
> > Consider the following scenario involving task->comm:
> >
> >     reader                    writer
> >
> >   len =3D strlen(s) + 1;
> >                              strlcpy(tsk->comm, buf, sizeof(tsk->comm))=
;
> >   memcpy(buf, s, len);
> >
> > In this case, there is a race condition between the reader and the
> > writer. The reader calculate the length of the string `s` based on the
>
> calculates
>
> > old value of task->comm. However, during the memcpy(), the string `s`
> > might be updated by the writer to a new value of task->comm.
> >
> > If the new task->comm is larger than the old one, the `buf` might not b=
e
> > NUL-terminated. This can lead to undefined behavior and potential
> > security vulnerabilities.
> >
> > Let's fix it by explicitly adding a NUL-terminator.
>
> memcpy() is not atomic AFAIK, meaning that the new string can be also
> shorter and when memcpy() already copied past the new NUL. I would
> amend the explanation to include this as well.
>
> ...
>
> > +               /* During memcpy(), the string might be updated to a ne=
w value,
> > +                * which could be longer than the string when strlen() =
is
> > +                * called. Therefore, we need to add a null termimator.
>
> /*
>  * The wrong comment style. Besides that a typo
>  * in the word 'terminator'. Please, run codespell on your changes.
>  * Also use the same form: NUL-terminator when you are talking
>  * about '\0' and not NULL.
>  */

Thank you for pointing out these errors and for recommending the use
of codespell.
Will fix them in the next version.

--=20
Regards
Yafang

