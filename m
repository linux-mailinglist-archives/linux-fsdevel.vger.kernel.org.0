Return-Path: <linux-fsdevel+bounces-21640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 287A1906EE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 14:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F2BB26D32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 12:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EC4146A9A;
	Thu, 13 Jun 2024 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpLx5daL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9830E1459F1;
	Thu, 13 Jun 2024 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280656; cv=none; b=LGBfSI5mer9YQbhCE0Kgjcwixa+0MK67hV7XIeVJ88Me5h5N+UgK0jYHtHY+yMktJkQcst9JMEqQGKmcWoINCYN0yESjoQSNT40zwinIrvHiNDHj/t4d0XiyvSqAgOrSbW3LbfSxGm0RlbqyyxFkEru1dmEbIgu/DdpIk1JQI0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280656; c=relaxed/simple;
	bh=H9BiII9YUZgE5S9VCr50+FtSHFlNjcFnzHb9qUOtYcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u41sFb8t6abD48V3d2sEJ6w6HTWq//aiJarmr3Q6lLxIePbwSr5JyDFNFLN6mlAep8IxihH4Ye3OQ9XhxwEfNJB+vfQS9KQIrqU2/bs/GtVRdRx1rXITHEvHXPnfy4Chjbfah+tPtrnM0PZzGe+S/dAW0RIBchUDMj9XaPDWAW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpLx5daL; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-62f86abc8abso10153057b3.0;
        Thu, 13 Jun 2024 05:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718280653; x=1718885453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jilhcaruJb2IBiLjemWE46i5/PUFqJsWXVunml9StIM=;
        b=hpLx5daL6vNpOfWV4Fef5kfL4DjNXjb2vErXr7bBYlrXes1/hJcYP+dFNZ8YNqxyLx
         Z5zmHxG2DYAIo76SD7I6u8sJS8viNL/AAzQOh0L8WMXCy6cjZ2pzKlN8m/2zkq3rK9Ws
         AkEglgy49r/YFPWisRqg0H81QICipnuuoAj5sZg9aej7eA2yJW1m5wrqiCP+CLL9mVrF
         9/m2nbIvJ7MJsACfshNSjeUc1s4j3gYWP0uQa0Xc1AY9z5GbFvWTQBB2XvrSNfgyHtCW
         9qhmjc4Lf4iAwoXbn/pv1v8f7dQCjj3BLvHw9IrVNf42exHpl2N12AYm1Fcz9d50k1Ha
         hFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718280653; x=1718885453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jilhcaruJb2IBiLjemWE46i5/PUFqJsWXVunml9StIM=;
        b=bPbTB4/Js5dLXnArVEJsgM0U4yD5c3LDTny5dBCezxnQzdka5WPzW4R1thfDxePrST
         yjg/c6DaEVC+gOOnaNNZpRVTjK/KDBlNkNwuu5zY61vkHawc9497NWRIOyhA0PHYeEqr
         3D5EJywvvr3y3FJWTHR+ysvc6Tnr6KBqYnYX4RtR+MEVXWBLxBxHhDp4DxvtzHlck4K+
         BoXSjxrt6i/cQSe9gTbuNm75O+3ZrEwqe1X2oVhuBNVUViIYU8NZCzLjgqmwGwfzRbh7
         v1iFwOoDWrkElfzoLsIrxbWEKX3QT4NDkP4N1oscgYYiU2C+IwmM7mjyWvLR1NjKjyzQ
         kjtg==
X-Forwarded-Encrypted: i=1; AJvYcCWp3EZjm0QKRpYHJsylbAQ1PB93AG+mc5+cVx+IZB55Zq4CLV+d3LoJhymLHCo4Z3LnTrXKQmAZaO1bmF4leZJMWltxNvchAarAHzY1v/5D0iLpZkhzodOyEcE7hQul0kgWfGqmsnmjvr0ekrnGNH7puOlzggJbCTtq6XuH6KfiSvwUP3TU90+GTGKxPH1LL5Q0saQxYd+tvjwMDyHFTvO7yEKBjvce+d27EszhPX4x6gNDG3Tp/i6TejKOudk81VHKfF2vBiyQGDgAUWedrv+Htg3dHXtdN6DfX7OjWzDvvZ87rjhsH5CpY+bgZKcCMoLqTRU/hA==
X-Gm-Message-State: AOJu0YxKnSzMvK473IntlLzPBskKGebiieCaxXtMpat8SOswUYUhwtBE
	yGhFNFEiy3cSTLItuihb3PFwVlbVEYHxnAhO4ux8m0jfv06M/CR+j9wFIXLwlg8BnPhbHK9uSuo
	d8KwEZ/NmALKeYYfqHCrVSNGb9Aw=
X-Google-Smtp-Source: AGHT+IECeNpAbuMBJduU/4vfo0TDc0y586W3/bKZ6gp1RqZAixArBbb8xY+5b1a7GzKTFusgDcdldUI00nJxS7Gmy8k=
X-Received: by 2002:a05:690c:6683:b0:61a:c316:9953 with SMTP id
 00721157ae682-62fb857416emr57999367b3.11.1718280653503; Thu, 13 Jun 2024
 05:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023044.45873-1-laoar.shao@gmail.com> <20240613023044.45873-7-laoar.shao@gmail.com>
 <Zmqvu-1eUpdZ39PD@arm.com>
In-Reply-To: <Zmqvu-1eUpdZ39PD@arm.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 13 Jun 2024 20:10:17 +0800
Message-ID: <CALOAHbB3Uiwsp2ieiPZ-_CKyZPgW6_gF_y-HEGHN3KWhGh0LDg@mail.gmail.com>
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

On Thu, Jun 13, 2024 at 4:37=E2=80=AFPM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> On Thu, Jun 13, 2024 at 10:30:40AM +0800, Yafang Shao wrote:
> > Using __get_task_comm() to read the task comm ensures that the name is
> > always NUL-terminated, regardless of the source string. This approach a=
lso
> > facilitates future extensions to the task comm.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  mm/kmemleak.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> > index d5b6fba44fc9..ef29aaab88a0 100644
> > --- a/mm/kmemleak.c
> > +++ b/mm/kmemleak.c
> > @@ -663,13 +663,7 @@ static struct kmemleak_object *__alloc_object(gfp_=
t gfp)
> >               strncpy(object->comm, "softirq", sizeof(object->comm));
> >       } else {
> >               object->pid =3D current->pid;
> > -             /*
> > -              * There is a small chance of a race with set_task_comm()=
,
> > -              * however using get_task_comm() here may cause locking
> > -              * dependency issues with current->alloc_lock. In the wor=
st
> > -              * case, the command line is not correct.
> > -              */
> > -             strncpy(object->comm, current->comm, sizeof(object->comm)=
);
> > +             __get_task_comm(object->comm, sizeof(object->comm), curre=
nt);
> >       }
>
> You deleted the comment stating why it does not use get_task_comm()
> without explaining why it would be safe now. I don't recall the details
> but most likely lockdep warned of some potential deadlocks with this
> function being called with the task_lock held.
>
> So, you either show why this is safe or just use strscpy() directly here
> (not sure we'd need strscpy_pad(); I think strscpy() would do, we just
> need the NUL-termination).

The task_lock was dropped in patch #1 [0]. My apologies for not
including you in the CC for that change. After this modification, it
is now safe to use __get_task_comm().

[0] https://lore.kernel.org/all/20240613023044.45873-2-laoar.shao@gmail.com=
/

--=20
Regards
Yafang

