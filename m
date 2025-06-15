Return-Path: <linux-fsdevel+bounces-51688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E250ADA27B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 18:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B333116C410
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 16:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E8C27A90F;
	Sun, 15 Jun 2025 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV5oQPDG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E278726AA91
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Jun 2025 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750003199; cv=none; b=EgFS0XdV5gQ9sGxIWnNMbOmrVL00036mla4Uzqxd/cmBGLRFrni9v+ye6jrwdLXmWhaYP/PZeSzuXHPVdf+N8+M4Ag3/XG3wUS2C0CP2AnXgcV/JVDDWGvmjZwxKr6DxXkQHmsW99/SVlb3hOjYt/BjFTD27iNJUpVe5vIfxWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750003199; c=relaxed/simple;
	bh=Z0s3YRE2xg8BcZrBZmPHC0LvwRHEauBB6t+riIGqaU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZcJ65ul/5U9tGWFItBBM9bkzeMrU/4zWBJvTUBbTk2lzsfw6xu0KNcnZU8mgBn63ZtLxoggy9qKo2ZQQLx45CLN7OmBFCJrO7JjEWj72c3FRoHf06/pPVwuAv6PnDu1pN94aVX9bPMfbbkPazngJIaXEVRvCqCx+XzaCUsjtAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mV5oQPDG; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70e3980757bso29719597b3.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Jun 2025 08:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750003197; x=1750607997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaOT5MGQjJEl02xzG8igdVUaES5BazPL/8FjolKqAck=;
        b=mV5oQPDGNNLcSmnbWX+NH6SYm9dz6RGn9mflbdUyrQeG9M9TnFWwWCY/CJYppI7APK
         goGdbo3F5+zO0QRXk+AQsu6Z5a5hXxbYJWAqkU+dPXQVTs0msKPxTezBPlcC+oXPj9Od
         89isbfIWzflKbc9lFfaz3ZIRn6nfKyygO+MQwHSeNVLW0KtDrDQvKxqs77tIghsIv3/H
         OU03etpD1Tmwe2R91O8OflqXFDl4Uqedu+ZbDt7qwsVg5WObho8com3cpxw4ZqaP+qSU
         dEKpMNTyZWJLEzMBkSX6eA0W8imoDtbF8y0As0ZjBtCl9prlGzIClqqIOpuhX/ezlHOT
         WgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750003197; x=1750607997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaOT5MGQjJEl02xzG8igdVUaES5BazPL/8FjolKqAck=;
        b=Twl0oWprq97meap2rCfQei19KwFLpS2qYAw8X94tE75vTdAhnJIuXH8aZ6mjJ6Wj/0
         sWrBvTX6iYO6+Eh/G7Ts0TOsvBf3K7YYm45Qb7/wP7KTSooIir3J+VUecgq3p2sZ6OZk
         3mtTe/FLwd9iS9484J8h+upEIlkczYSrQVWLsEaZF47hb6DlB5+95N2p4e+ZM2CUZ6vW
         smp6x1CD5hBladO8PMKkP49g/Tdd8ke4GrN/V6ROS05NexFUym03GbDCdBaovnbHW+02
         KLZsUXFC3HgplW6N+a/0kuol7zNxt3nXGNPDj7b6d1t/sL8OWu0fv9iFWu7RmoJqbvTA
         exVg==
X-Gm-Message-State: AOJu0YxIf+flL41kuzz+JeGuH2PNPz7aNhx31RnSNj5SaoryTvoLebOa
	NW5ss/TMl3qXZYxsesPrGJh8NECg7VrErGCRHqzqVMFBWJJkZlJoVOtTFWHwpX7wJ0v5KqsnUUf
	4aSTkE6Nk7e08Nfcj33b0OKxFRBfYinI=
X-Gm-Gg: ASbGnctSQJZyNiyzmrJ1LVyU01DQ6ri5RSJEpWSEhZiZ2Aqaw0FurmfWmJRLm6QuPNn
	Ed/9NqQdeMH+6VPhePOTua2Z6PVVZV/F11DaoZSMlxtyQ0IU5LhPGo4TcAx7mdX5ngIGzdm11E0
	/zh53fqnmLDG54hctBsQhgd7v2w1+mUWe3V1OkqNU8a5A=
X-Google-Smtp-Source: AGHT+IHm5jGbLERFwiBEJR2VnDYMsKu/tlqap57QVVi4w4c5MG7uZq0vwWC5cGbblnDAkdB4wAzJLvKEzpefPil9N+I=
X-Received: by 2002:a05:690c:1a:b0:710:e5ae:a61 with SMTP id
 00721157ae682-7117493df8cmr93197067b3.14.1750003196706; Sun, 15 Jun 2025
 08:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <83907912-d8eb-462c-8851-2c6f44755d68@gmail.com> <b3ab81e1-760d-4e25-861d-a9ff243fe699@ddn.com>
In-Reply-To: <b3ab81e1-760d-4e25-861d-a9ff243fe699@ddn.com>
From: Feng Shuo <steve.shuo.feng@gmail.com>
Date: Sun, 15 Jun 2025 23:59:30 +0800
X-Gm-Features: AX0GCFudvw3M-4SeA6sKFvlaGrUxShkwavyMd0ZjYh1JiBCMc_JhvQBeHr_KFGs
Message-ID: <CALmpHyZO-kv+LPtZ3g_byHk_MdgbWiE=t_qPJFz32=PsY7C06A@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix the io_uring flag processing in init reply
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, mszeredi@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Bernd. I will send a new patch.

-- Feng Shuo

On Sun, Jun 15, 2025 at 5:45=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
>
>
> On 6/14/25 17:41, Feng Shuo wrote:
> > [You don't often get email from steve.shuo.feng@gmail.com. Learn why th=
is is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Fix the expression of the io_uring flag processing.
> >
> > Signed-off-by: Feng Shuo <steve.shuo.feng@gmail.com>
> > ---
> >  fs/fuse/inode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index bfe8d8af46f3..ef0ab9a6893c 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1434,7 +1434,7 @@ static void process_init_reply(struct fuse_mount =
*fm, struct fuse_args *args,
> >                                 else
> >                                         ok =3D false;
> >                         }
> > -                       if (flags & FUSE_OVER_IO_URING && fuse_uring_en=
abled())
> > +                       if ((flags & FUSE_OVER_IO_URING) && fuse_uring_=
enabled())
> >                                 fc->io_uring =3D 1;
> >
> >                         if (flags & FUSE_REQUEST_TIMEOUT)
> > --
> > 2.43.0
>
> Hi Shuo,
>
> I don't think it is a 'fix', because the '&' operatpr has higher
> precedence, for readability you are definitely right.
>
> Maybe something like
>
> fuse: Add parentheses around bitwise operation in conditional
>
> Add parentheses around the bitwise AND operation in the io_uring
> condition check for better readability.
>
>
> With an updated commit message/subject:
>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>
>
>
> Thanks,
> Bernd

