Return-Path: <linux-fsdevel+bounces-22795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FB991C3EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 18:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0940280D67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 16:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E451CB30C;
	Fri, 28 Jun 2024 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON9YAsO3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA441C9ED6;
	Fri, 28 Jun 2024 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592954; cv=none; b=s0FoK9KS6PeZSPHtDNEIYujYgkk1R1n6a6INM0Djz2Vdr4uMR3Zh/06zMkUr9tLqlu4n6nIvlGp0h7T0ub8SxCiPqhKT4oUuYa+cUkiME0ns3w28LGKZAVLlTkvllnxg+HxmG33RgGeNgS36pCYB5SLEWRXq2xnJEjQU9/BMCAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592954; c=relaxed/simple;
	bh=QP4OiqH6TSOfB/OMtnCgEh33cuRXNjGDaRkWgjeDo7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7aCgPsDWIUiiVuJllOy23Jf72rN9qmUqs69XtV+C1nTgx63CC8Wl8iels9+bwIIA6zQ4DGjl0SL6rSCRQPHdUJ19lAdjCjjArqxNaB+P5r9PCWluywH87Y9cZUQuqJ3QxwrzNaE2t2QeOdQRU6S2+JR3qZrr8WinNs6Z0FDiQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ON9YAsO3; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d55c0fadd2so527919b6e.3;
        Fri, 28 Jun 2024 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719592952; x=1720197752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l55GCdsGHigfQt9Zl2j26S+vi2KN1icw1YAJXC/GF+E=;
        b=ON9YAsO3C7d9fxB9qgQtULFFOMn6vTqIrYUBTW2DCog8QhlmCcHKFhfOBTmICNISKK
         dtUaXn/5YLISfS2qWZu/dEwvW1zmZQr8ZZWjgmdvnWb3yplkhUN66fHE5iNBSnmyfJ5z
         QcsnwXz8sjwXaHR2NxWuVY3+zXvbIt/U9A9egPws252jjOiA24ArvamrCjYSvcwXO+sG
         /8O+LKmaX+m9oju518IkXyUqQU/lBTWWCmKKsGoy8pT1MoMZu7G4gziTN0CSIlQTSeTO
         0oJ9y7NgoeCQ/sJ64q7dqj79QqEfPnW0hotbHEpkQJwVeQdAsc4knQYF3Q77FLqvmF0d
         fmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719592952; x=1720197752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l55GCdsGHigfQt9Zl2j26S+vi2KN1icw1YAJXC/GF+E=;
        b=xEdxQp7vntyjTk5YqZMzkWwVG6AqHPB27sibh9JEtRjYBPRDm7klbDQa9JiIDni1fx
         YWI+WzY8X3dD4ir3tAuIOadmyVIk+K1KCgtE5Wb5/TG2473SGxNv5MKV2ujBNo/QVczK
         Ng0xIZuwaS0Vy2Tq26ZBD8/GjkucfEHqNb7JUwHHV5e09JiwgEnnTcmuII+cNVoeXZBT
         xz3H3iv/uJpNq4V9aV9HJaafJjhlqSay49c/6VxZkQk1a+bP42Dpj24mQGRkUgmGce5t
         G+z9acg6V9A6XtOOr4JbRgIrm7OSS7L0OXyzaoWV7JZJiOBqo9gYebTxlkEK0y5T6iAH
         IlMw==
X-Forwarded-Encrypted: i=1; AJvYcCXtx+rATFerkOE0W/7e3ABFhMj6nyuju/I7lJRK9vhe2znWFJcDDTWNH1mPEc5ic5Ijfu0VnAOSmZuIKvZbxpryh5Iu6SLFBF+QVLPUCl0nmPi8FxFMQEqOBFhxlUD3lbhZ3s2xgB1Kl0oILNN6f26ukhVr4IObKFnTHQkvSqS4+g==
X-Gm-Message-State: AOJu0YztdEokd/mEENQg12XunkMSpYwZG9eLkTlRSyt7kZjMXVKwIH8C
	+ulpvJ26wQ9dVesmtfSgs676tfcz1odFfYKguBYRLuIxF4z6CX7N4pyMZgfYWAowaqWAouPaal+
	1tQw8+rA3NePVciicW/WKmvPIjzY=
X-Google-Smtp-Source: AGHT+IFFYy1A3RqdZ6XL4FzBiAcL85PGmQ+hHNlwWS1uWXR26y82VIzYROzLkKq18dxpwInUHrMk3RTnju/jtSmahRM=
X-Received: by 2002:a05:6808:10cf:b0:3d6:362b:5ea3 with SMTP id
 5614622812f47-3d6362b6505mr181081b6e.14.1719592951763; Fri, 28 Jun 2024
 09:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627170900.1672542-1-andrii@kernel.org> <20240627125938.da3541c6babfe046f955df7a@linux-foundation.org>
 <CAEf4BzaNOrMWB=nimR-UD8-MrC37kHQi6fh1hBv+aPWvoiSm5A@mail.gmail.com> <20240627141126.2ce3b4981e4f580713e31be0@linux-foundation.org>
In-Reply-To: <20240627141126.2ce3b4981e4f580713e31be0@linux-foundation.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Jun 2024 09:42:19 -0700
Message-ID: <CAEf4BzbMhR9X9nNawSgSehsewpSPHRdGMfjst7AGv9mvpeDWzg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] ioctl()-based API to query VMAs from /proc/<pid>/maps
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org, liam.howlett@oracle.com, 
	surenb@google.com, rppt@kernel.org, adobriyan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 2:11=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 27 Jun 2024 13:50:22 -0700 Andrii Nakryiko <andrii.nakryiko@gmail=
.com> wrote:
>
> > On Thu, Jun 27, 2024 at 12:59=E2=80=AFPM Andrew Morton
> > > Is it possible/sensible to make this feature Kconfigurable so that pe=
ople who
> > > don't need it can omit it?
> >
> > It's just a matter of #ifdef/#endif, so not hard, technically
> > speaking. But I'm wondering what's the concern? This is mostly newly
> > added code (except factoring out get_vma_name logic, which won't be
> > #ifdef'ed anyways), so if no one is using this new API, then it should
> > cause no issue.
> >
> > Generally speaking, I'd say if we don't *have to* add the Kconfig
> > option, I'd prefer that. But if you feel strongly, it's not hard for
> > me to do, of course.
> >
> > Or are you concerned with the vmlinux code size increase? It doesn't
> > seem to be large enough to warrant a Kconfig, IMO (from
> > bloat-o-meter):
> >
> > do_procmap_query                               -    1308   +1308
> > get_vma_name                                   -     283    +283
> > procfs_procmap_ioctl                           -      47     +47
> > show_map_vma                                 444     274    -170
> >
> > But again, do let me know if you insist.
>
> Yes, I'm thinking about being nice to small systems ("make
> tinyconfig"!).  The kernel just gets bigger and bigger over time,
> little bit by little bit.
>
> It's a judgment call - if making it configurable is ugly and/or adds
> maintenance overhead then no.
>

I see, thanks for clarifying. I'd vote to not add extra Kconfig to
keep things simple and less surprising. All this code is conditional
on CONFIG_PROC_FS=3Dy anyways, and there is plenty of code for procfs
already. I think this do_procmap_query is just a small addition here
that doesn't fundamentally regress anything.

