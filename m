Return-Path: <linux-fsdevel+bounces-21709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0382908B07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 13:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C21DB20C4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 11:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF4919645D;
	Fri, 14 Jun 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D20YfIx9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453CA190487;
	Fri, 14 Jun 2024 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718365579; cv=none; b=R7QHZt42nbzyS7YPzwZpVcqhvC87+cjy/18zAf9FEbV2lbFkyLuLo2UTtNKcqe5tIv9S8Ra8pMUUUAd5XmGR+jpHof8Agd0BoVcNFef3N9+xySmatqTtw/CZ3cYTZxBwGzJdDtNHnSjnxmPkiNvzpj566z1s3zh2mOxoqH5Qs4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718365579; c=relaxed/simple;
	bh=yKBS8YrQvYaJRUodD7XdGXa+UFaJJMkLRRHcLb+/TXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cm5/sKI5QQRJMXiBbt7JR0s3JUDBCTDKZALYJwlmanr2uBe5M58vP66yDJOfZ85LN4wn9RGm1aJTe8ABd7CIFPfQQDC2zCay4y91CFKBDoSLthU0BysLaeZf0F6DGmFRR9DyAOSd4t8NnjOzobCC7LVgceeowi9h/G56ESCFLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D20YfIx9; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b064841f81so16659026d6.1;
        Fri, 14 Jun 2024 04:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718365577; x=1718970377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhZTA0P9EB3vGdWtMZhD6+owrd3MXBYsoXYXThbWv8c=;
        b=D20YfIx9g37xfBpgnJeYuDSWVgN5mkg1Zs3BmfzVxx+bSIPa8Of2XPQQ23beYP7y83
         zIx2ygHm66/BPz9ERzLgIjBEW3d36mdlqidtAvyVfrDr6SYrRYCqTaIw4tSEhLxsyb4Z
         kC20WwlBBVwdhSjzo5yNyidReAfeOBO1vRoXkQxlDX7GlKYu9OQvxD8eIkfglt7tMAb8
         fYW2LyBL+uI+lokuKk5GuWq/mpWYQyQiN+l4ZAxTzCTCSQLdxO3xba2kAo/1IPr6xBd7
         LiX1gnJyJu7yIDKN3KobPfuIBdlpYrMvaAzsPJO2Pm3v+0ZwD2B8QhudjhnHa4anO5hx
         7+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718365577; x=1718970377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhZTA0P9EB3vGdWtMZhD6+owrd3MXBYsoXYXThbWv8c=;
        b=BxbA9U8DsUY8VGcwsITsT9ip8xmKyWEAOLCx9hhzITXQinPUXV475VGIvPS9YINCbk
         nmNsh44a8HsXalHQEXHw2Ijq/KHDeaCU2AzNhcorsSiUQTJK0Xfb53VhxtzcVkD1/M6R
         mXRL7o1S1Uy9gsAtJSXd6Q2ZBx/M4Fn7n8HsEgU+dw0xlxxQ92Kg0EsvHRugi8Dp7MFN
         fDcmeTUl5FXlr54FsoPcWn88czs5vVCHj4IEilI5rCNyVEis9WW26uwBDM9+uYWGZhUc
         TVXeUuQb1HgoZyf7yed7LjGnTbcpZD0cbnisDACbinPhSA8tmw3mWciTWI5zT1/it7+g
         BJqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4FNMVAdwC0RL8r6m3b+otYVAdq4LR7QA25OV/Zomr4MdGcUVM81Cy8yFz1I6wwClCjaxEOgJbpsz+VvSWvUK0EXlhZDc+Xd/ocOR78a+HtVM3CttJaeDTDP3AxJHAcws8b6inqvBz1ht5T43s50729E+GJEiOJxPuMKkp3+RbU8sbnOUj28ITgfutX38Wo31pQYa2svaYZ6fHsx/8OFa6hyHcjQL2VkRusuGGTCACwJSL1EI3f/SH/COTAVlgbsk0ygce2qVTMp4wO67ZckawCQ6C2skAWjCwavGjI4FOcJ6187wmXftqk19xRGpaxQCzZobxhA==
X-Gm-Message-State: AOJu0YzmdK0TYu2Gx2m+pz93J6wxbaR3Jdkef8qaLPjyA7bR48txF/3E
	7ALlHErbhZJACtPn6ANMa8laTeO0EbuJdGvEL8+CzC/VsktoGpj9295EqjI1yiuuKj7ycpB4CI2
	Z4ACjVQYuObZLr3STqpXUUB12GvY=
X-Google-Smtp-Source: AGHT+IFaFnMNLjJYSYrMKDyE9tX4zgL8n/jhcGz01q5yiY/JXZZX7mC42E5kkQyr9LsVQPUZ9vqhx86BbZKpLx0rTA8=
X-Received: by 2002:a0c:c203:0:b0:6b0:77fb:8f19 with SMTP id
 6a1803df08f44-6b2afd6cb2cmr22836486d6.47.1718365577138; Fri, 14 Jun 2024
 04:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023044.45873-1-laoar.shao@gmail.com> <20240613023044.45873-7-laoar.shao@gmail.com>
 <Zmqvu-1eUpdZ39PD@arm.com> <CALOAHbB3Uiwsp2ieiPZ-_CKyZPgW6_gF_y-HEGHN3KWhGh0LDg@mail.gmail.com>
 <ZmwiEbCcovJ8fdr5@arm.com>
In-Reply-To: <ZmwiEbCcovJ8fdr5@arm.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 14 Jun 2024 19:45:40 +0800
Message-ID: <CALOAHbAvUPf5_ryDNm=Ujqmg_XycK0Sh23dr_62gFch9NhRGng@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] mm/kmemleak: Replace strncpy() with __get_task_comm()
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: torvalds@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 6:57=E2=80=AFPM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> On Thu, Jun 13, 2024 at 08:10:17PM +0800, Yafang Shao wrote:
> > On Thu, Jun 13, 2024 at 4:37=E2=80=AFPM Catalin Marinas <catalin.marina=
s@arm.com> wrote:
> > > On Thu, Jun 13, 2024 at 10:30:40AM +0800, Yafang Shao wrote:
> > > > Using __get_task_comm() to read the task comm ensures that the name=
 is
> > > > always NUL-terminated, regardless of the source string. This approa=
ch also
> > > > facilitates future extensions to the task comm.
> > > >
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > ---
> > > >  mm/kmemleak.c | 8 +-------
> > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > >
> > > > diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> > > > index d5b6fba44fc9..ef29aaab88a0 100644
> > > > --- a/mm/kmemleak.c
> > > > +++ b/mm/kmemleak.c
> > > > @@ -663,13 +663,7 @@ static struct kmemleak_object *__alloc_object(=
gfp_t gfp)
> > > >               strncpy(object->comm, "softirq", sizeof(object->comm)=
);
> > > >       } else {
> > > >               object->pid =3D current->pid;
> > > > -             /*
> > > > -              * There is a small chance of a race with set_task_co=
mm(),
> > > > -              * however using get_task_comm() here may cause locki=
ng
> > > > -              * dependency issues with current->alloc_lock. In the=
 worst
> > > > -              * case, the command line is not correct.
> > > > -              */
> > > > -             strncpy(object->comm, current->comm, sizeof(object->c=
omm));
> > > > +             __get_task_comm(object->comm, sizeof(object->comm), c=
urrent);
> > > >       }
> > >
> > > You deleted the comment stating why it does not use get_task_comm()
> > > without explaining why it would be safe now. I don't recall the detai=
ls
> > > but most likely lockdep warned of some potential deadlocks with this
> > > function being called with the task_lock held.
> > >
> > > So, you either show why this is safe or just use strscpy() directly h=
ere
> > > (not sure we'd need strscpy_pad(); I think strscpy() would do, we jus=
t
> > > need the NUL-termination).
> >
> > The task_lock was dropped in patch #1 [0]. My apologies for not
> > including you in the CC for that change. After this modification, it
> > is now safe to use __get_task_comm().
> >
> > [0] https://lore.kernel.org/all/20240613023044.45873-2-laoar.shao@gmail=
.com/
>
> Ah, great. For this patch:
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>
> You may want to add a comment in the commit log that since
> __get_task_comm() no longer takes a long, it's safe to call it from
> kmemleak.

I will add it. Thanks for your suggestion.

--=20
Regards
Yafang

