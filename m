Return-Path: <linux-fsdevel+bounces-30388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5C298A985
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 18:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E379286697
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CE5191F6B;
	Mon, 30 Sep 2024 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8HVMPDM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE07CA62
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727712888; cv=none; b=Xx2F1eWDKN3u72EGeJeeVsExe3y6SInb6esZeWdrs9XVxOs5GwH/KMSwOSbv4SmVq/Zgl+8CtgX6l+5Jz9pEHzO+8H1q7+foCUJ7n20WGA0l2La1PdcB0aoMW02NTtTldpLVf+l7fN0nIU5pga8OQMVn2qIq9GFefJKGykTjjTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727712888; c=relaxed/simple;
	bh=YYWzNWHh7Y28kr9y/6P1KH5SoQFjZVExRuN1eV9bW7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaiwTSjTCzEE38VDoK3+6anBJpolfw+wkcHb/kRmzhKeA5NAbASv8Pzhoq6rtUyJ8GZw67mI5rI6vKgnJK3OxkXLfG83QoxvFh/8NJZeOwE5IoLy3pVQEwU1HRhndwYWX2pt0kH46JgZnZKdAyuGZ1JcYsRhQbi6s6NHk5QYcHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8HVMPDM; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a9af813f6cso427991485a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 09:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727712886; x=1728317686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMG86LLn1OK1b+r6Rx7iOVcfIBULqhGjCr2m079yfBc=;
        b=k8HVMPDM3iGZqiUjtPQZzdsFwNZGv4UNKwNle+WtbkT9LOp8wLE4vwGu/Ux+Wk/Hbf
         0xz9k4M7pZzQB++0cCtlRWjQEyGbcP9Lvcr8NDXg4dPUVW4TLlvpA0+cdP8ckQiUT15E
         OW0X0qmbOJ6oXLLzBKtWntGQkl/4TTaXi0C0EbvXATtCLJ64aliJiD22EcZ0+NI0Azv1
         2gGnI2nXorUF+VEOwlfW9Q2uE6w2urNmlNgGzowUrDPJxxdfSucqssLsXWbI7ooH6egm
         gy4fkfUK2mYntdNW06DWE/LNiMiYAsLQOLW+QPFSsanJz76sLucdUkE0l6wec0aMY21J
         jDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727712886; x=1728317686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMG86LLn1OK1b+r6Rx7iOVcfIBULqhGjCr2m079yfBc=;
        b=G9fvFLcTeQ8P2ZvEps1a1eHWkfSzgJ99Du6HQkSm8GT8N+3SJgbqTqvnw5sGsa0PZh
         zgfZAzrOs+CKKp67nJ/JYUI3iGwhd3epXY/x/9NXVF760WilPKSOpI16XQSWAbL7CTLQ
         Lf29RhMVdvbvDU0FKgreHd/bJaGhzVifyTmLV9oDB7HLBMhM+PYsgIt/SWaaUvj5da/8
         uH9pmUTAXi6+2JQGytCjze5rbiCkPPvMUZJiDWjEt+AFT6DtL2MGZKcZUHI2EWhXEVng
         aGxNvG2Z4OunoLUkKTnXn2mkY8yu95M1wUv/voKaB/qBEjhMQtWBCUMD90djkFMCRLgq
         a53g==
X-Forwarded-Encrypted: i=1; AJvYcCWYspmqhiEdt1euqhzSBzuRZI60PlVOMcbg36GjSlGWS6WcTigLrs9HJnyAEGJvdpcvVyGIb9x2tKiXNs4h@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0DrlKTOb0AwpTL/A6bMNMKo9FBszitSijWruOxojiZZAPfVm7
	Z8Bqhulu1Mq+psiF8QomDf/JkfPk7PQz446LKYGGvVk5Xpc2a3kisq0t5cqq0IzQwxTS3rBcIo4
	emmtbsSIUeDaIcJdgS+732Sfv6Wg=
X-Google-Smtp-Source: AGHT+IGtQWDixW64KUdzss0cffgQRyCZULuu1qDWXVElA1RJAbSeoy82oEg+kkWyJfV4p7q62RvMma1WY8dLZH2Lf5k=
X-Received: by 2002:a05:6214:3207:b0:6c5:7446:4fdf with SMTP id
 6a1803df08f44-6cb3b5e283dmr211188786d6.24.1727712885411; Mon, 30 Sep 2024
 09:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927125624.2198202-1-amir73il@gmail.com> <20240930154249.4oqs5cg4n6wzftzs@quack3>
In-Reply-To: <20240930154249.4oqs5cg4n6wzftzs@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 30 Sep 2024 18:14:33 +0200
Message-ID: <CAOQ4uxg-peR_1iy8SL64LD919BGP3TK5nde_4ZiAjJg5F_qOjQ@mail.gmail.com>
Subject: Re: [PATCH] fanotify: allow reporting errors on failure to open fd
To: Jan Kara <jack@suse.cz>
Cc: Krishna Vivek Vitta <kvitta@microsoft.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 5:42=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 27-09-24 14:56:24, Amir Goldstein wrote:
> > When working in "fd mode", fanotify_read() needs to open an fd
> > from a dentry to report event->fd to userspace.
> >
> > Opening an fd from dentry can fail for several reasons.
> > For example, when tasks are gone and we try to open their
> > /proc files or we try to open a WRONLY file like in sysfs
> > or when trying to open a file that was deleted on the
> > remote network server.
> >
> > Add a new flag FAN_REPORT_FD_ERROR for fanotify_init().
> > For a group with FAN_REPORT_FD_ERROR, we will send the
> > event with the error instead of the open fd, otherwise
> > userspace may not get the error at all.
> >
> > In any case, userspace will not know which file failed to
> > open, so leave a warning in ksmg for further investigation.
> >
> > Reported-by: Krishna Vivek Vitta <kvitta@microsoft.com>
> > Closes: https://lore.kernel.org/linux-fsdevel/SI2P153MB07182F3424619EDD=
D1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Jan,
> >
> > This is my proposal for a slightly better UAPI for error reporting.
> > I have a vague memory that we discussed this before and that you prefer=
red
> > to report errno in an extra info field (?), but I have a strong repulsi=
on
> > from this altenative, which seems like way over design for the case.
>
> Hum, I don't remember a proposal for extra info field to hold errno. What=
 I
> rather think we talked about was that we would return only the successful=
ly
> formatted events, push back the problematic one and on next read from
> fanotify group the first event will be the one with error so that will ge=
t
> returned to userspace. Now this would work but I agree that from userspac=
e
> it is kind of difficult to know what went wrong when the read failed (wer=
e
> the arguments somehow wrong, is this temporary or permanent problem, is i=
t
> the fd or something else in the event, etc.) so reporting the error in
> place of fd looks like a more convenient option.
>
> But I wonder: Do we really need to report the error code? We already have
> FAN_NOFD with -1 value (which corresponds to EPERM), with pidfd we are
> reporting FAN_EPIDFD when its open fails so here we could have FAN_EFD =
=3D=3D
> -2 in case opening of fd fails for whatever reason?
>

Well it is hard as it is to understand that went wrong, so the error
codes provide some clues for the bug report.
ENOENT, ENXIO, EROFS kind of point to the likely reason of
failures, so it does not make sense for me to hide this information,
which is available.

> >       if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
> >           path && path->mnt && path->dentry) {
> >               fd =3D create_fd(group, path, &f);
> > -             if (fd < 0)
> > -                     return fd;
> > +             /*
> > +              * Opening an fd from dentry can fail for several reasons=
.
> > +              * For example, when tasks are gone and we try to open th=
eir
> > +              * /proc files or we try to open a WRONLY file like in sy=
sfs
> > +              * or when trying to open a file that was deleted on the
> > +              * remote network server.
> > +              *
> > +              * For a group with FAN_REPORT_FD_ERROR, we will send the
> > +              * event with the error instead of the open fd, otherwise
> > +              * Userspace may not get the error at all.
> > +              * In any case, userspace will not know which file failed=
 to
> > +              * open, so leave a warning in ksmg for further investiga=
tion.
> > +              */
> > +             if (fd < 0) {
> > +                     pr_warn_ratelimited("fanotify: create_fd(%pd2) fa=
iled err=3D%d\n",
> > +                                         path->dentry, fd);
>
> This is triggerable only by priviledged user so it is not a huge issue bu=
t
> it still seems wrong that we spam kernel logs with warnings on more or le=
ss
> normal operation. It is unrealistic that userspace would scrape the logs =
to
> extract these names and furthermove without full path they are not even
> telling much. If anything, I'd be willing to accept pr_debug() here which
> sysadmin can selectively enable to ease debugging.

Even without the full path I could easily understand which file was
failing the event in git clone, but sure, pr_debug is a decent compromise.

Thanks,
Amir.

