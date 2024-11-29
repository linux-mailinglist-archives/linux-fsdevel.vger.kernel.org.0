Return-Path: <linux-fsdevel+bounces-36135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B62079DC26B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 11:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6958B21D6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 10:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEEB198E75;
	Fri, 29 Nov 2024 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqFA7iF/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2CA15AD9C
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732877838; cv=none; b=KmLu68H3613lH4I4JAYYe5Hf4UpvWcvDmQKn46X/pZzVUgmw/GAAkDP5s4iN7+KjjHHOxpfS4Kj9ElcLSrAwpDcqF56IU1aPyu/bhXXdILzLgilNjSVXooGGiDz5awJCfrRJOlO2fHravO0DKc+DqKtCFRdJKtYsjnbcMYx4ahI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732877838; c=relaxed/simple;
	bh=zdYDzuEtSnF/OazVqLPDlKkO8wqO9Oj4J7f4PhAoKHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2ktTtMy9qCCc0pyHrgaTtTtYVn1YR6OxhrksPN5ahzumZfeqeIS39aTDQgkkeN1R78DYGCgrTYvSinJXepVEBP1VDdV32AR7Bx3xe6tG8Mnct+VAzFmdQWh8STJ9Xu0pbImfo6Rqu1wNKm7orfPLc/abvlu+/sUdoCOvpsinlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqFA7iF/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa51bf95ce1so337290866b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 02:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732877835; x=1733482635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pFOh1YFOwer4oSt+DU/GMjI2dqWS3OicJtGWdV7xkI=;
        b=dqFA7iF/RX8Hq0u0RPsiT+ghHaW4tmbQZbQlKI+DRQT+AgoY4V0sHht+EgGbhDq/dC
         swmgCvooAJptbhmbZx7j1s6AYsi/0nr/9Gjs+oZVNCX2dUMNI26I2RxCV6ws9Dd1FUMr
         2orlh4gIyxmEIyUuax6ykfu+hkIEVZfuHWdDifft1A/QQGLWm9H9X64ETAWW5DCiU1Oc
         RARCV8PZRc180T/FFGHGvUjPgNfsVKs1deparNbqvdTMYrDk37yCTsndQNuB5nXi0nNi
         AaqA/chrXcVktnCTwa3SZ8XnnMRfg0gcAMo/I7UnfVVFxDWkqaqToQe7EdKEOQL9305F
         R+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732877835; x=1733482635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pFOh1YFOwer4oSt+DU/GMjI2dqWS3OicJtGWdV7xkI=;
        b=ptUE1zyCHOfnSEZStZfss+aphARs1G1X7Y1YOf70LPXJW0ULDczGQaoPaySP8eAgmV
         pQyFFP/Sdi0bs8pYnzlU/kkZEifOLXV50zFaQ09Byk4vayye8Cpm88whGBLUNsKeCvV3
         Xev4zmOO6xBQMjk5ZeWOladdtDSaynIUmE4Moh3N6Gxyksu1NCLJ7DheFDkIHIm9vk/G
         8Fy7j29hLPtrzeG7IsruCyq2Tr/J16ULmk7kRUWL7etnA2zokTDB107I0SXi34yfW25J
         Ly1mDk1LCEH2NMgODpzfwpQ7zvLkVxRWhdW5kmEgpyVyEzXiKVGWZL9eboNePfEseg4P
         T0gg==
X-Forwarded-Encrypted: i=1; AJvYcCWY1ai5Yp3y4JCFx5ALMFgb2rNCA7bpIO/TY/mfv2EJ2kgBd0porwg2d1DR8S4EoLGnzeCTkwk92Qj3iHEW@vger.kernel.org
X-Gm-Message-State: AOJu0YxGK6tEawHcsmOJmQwNSTjWrETP0pB+D8pQT8yQ3iwulMH/pyV+
	GMvzInAXpXmBCxH+qGCCYqI0LtomQJgHve1MKPcvNQ4Wr+reiyUyq37POUhyDmy4cr0u/2d1iLw
	6p8Whqd+D7E+oWgRlni6xF53qUo8=
X-Gm-Gg: ASbGncunEN4A3ZLkkSs/pX4q/kgnFSY1JUV055cw0tI82k2e9JFtJ2WfxTRXGMNqiqr
	y8hV1Gh9MR35hTYaBWbFZ724nrYQG+3w=
X-Google-Smtp-Source: AGHT+IH67alDFmJ/3mgVr0phBe4Mq+rDYKUsxqPlH5AQRzh2Ya8BiMlkayp1gQGGBvsJx97f0ymlI6jwkyJc9vHRnQ8=
X-Received: by 2002:a17:907:77cd:b0:aa4:ce42:fa7f with SMTP id
 a640c23a62f3a-aa580edfbf1mr1140318266b.7.1732877834504; Fri, 29 Nov 2024
 02:57:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128142532.465176-1-amir73il@gmail.com> <wqjr5f4oic4cljs2j53vogzwgz2myk456xynocvnkcpvrlpzaq@clrc4e6qg3ad>
 <CAOQ4uxiqbSFGBoCzg44t4DM=uvJ3zbev_wbSot4i5C8jQW_t7Q@mail.gmail.com> <CAGudoHEgjTq6RTmcenUcZUaRuzkAm8WiCCbakqbUMa5AeT84fg@mail.gmail.com>
In-Reply-To: <CAGudoHEgjTq6RTmcenUcZUaRuzkAm8WiCCbakqbUMa5AeT84fg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 29 Nov 2024 11:57:03 +0100
Message-ID: <CAOQ4uxg6yZxTVMvkbvk5UW627dy2jOzX0+ssjzv6pHXLBKShPQ@mail.gmail.com>
Subject: Re: [PATCH] fs: don't block write during exec on pre-content watched files
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 6:00=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Thu, Nov 28, 2024 at 5:57=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Thu, Nov 28, 2024 at 3:34=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.co=
m> wrote:
> > >
> > > On Thu, Nov 28, 2024 at 03:25:32PM +0100, Amir Goldstein wrote:
> > > > Commit 2a010c412853 ("fs: don't block i_writecount during exec") re=
moved
> > > > the legacy behavior of getting ETXTBSY on attempt to open and execu=
table
> > > > file for write while it is being executed.
> > > >
> > > > This commit was reverted because an application that depends on thi=
s
> > > > legacy behavior was broken by the change.
> > > >
> > > > We need to allow HSM writing into executable files while executed t=
o
> > > > fill their content on-the-fly.
> > > >
> > > > To that end, disable the ETXTBSY legacy behavior for files that are
> > > > watched by pre-content events.
> > > >
> > > > This change is not expected to cause regressions with existing syst=
ems
> > > > which do not have any pre-content event listeners.
> > > >
> > > > +
> > > > +/*
> > > > + * Do not prevent write to executable file when watched by pre-con=
tent events.
> > > > + */
> > > > +static inline int exe_file_deny_write_access(struct file *exe_file=
)
> > > > +{
> > > > +     if (unlikely(FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
> > > > +             return 0;
> > > > +     return deny_write_access(exe_file);
> > > > +}
> > > > +static inline void exe_file_allow_write_access(struct file *exe_fi=
le)
> > > > +{
> > > > +     if (unlikely(FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
> > > > +             return;
> > > > +     allow_write_access(exe_file);
> > > > +}
> > > > +
> > >
> > > so this depends on FMODE_FSNOTIFY_HSM showing up on the file before a=
ny
> > > of the above calls and staying there for its lifetime -- does that ho=
ld?
> >
> > Yes!
> >
>
> ok
>
> In this case the new routines should come with a comment denoting it,
> otherwise the code looks incredibly suspicious.

How's this:

/*
 * Do not prevent write to executable file when watched by pre-content even=
ts.
 *
 * (*) FMODE_FSNOTIFY_HSM mode is set depending on pre-content watches at t=
he
 *     time of file open and remains for entire lifetime of the file, so if
 *     pre-content watches are added post execution or removed before the e=
nd
 *     of the execution, it will not cause i_writecount reference leak.
 */

Jan, can you add this on commit?

>
> > >
> > > I think it would be less error prone down the road to maintain the
> > > counters, except not return the error if HSM is on.
> >
> > Cannot.
> > The "deny write counter" and "writers counter" are implemented on the
> > same counter, so open cannot get_write_access() if we maintain the
> > negative deny counters from exec.
> >
>
> I'm aware, in the above suggestion they would have to be split. Not
> great by any means but would beat the counter suddenly getting
> modified if the above did not hold.

Well, Christian did propose to add a counter in the i_pipe/i_cdev
union, but this all seems too much.

We are forced to carry the legacy behavior to avoid ABI breakage,
but maintaining a more complex code because of that is not a good
idea IMO.

Hopefully, the suggested solution is a fair compromise.

Thanks,
Amir.

