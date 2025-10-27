Return-Path: <linux-fsdevel+bounces-65809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C30BC11DF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 23:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F422D4F8258
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 22:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ABD32D0E0;
	Mon, 27 Oct 2025 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImTA2mCT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1943F32C951
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604746; cv=none; b=lVYyYyFW0Q4KIM7Imf8+J0viLIF9U4yDcnZep/yRBMPInepOOJ9V8phzgtsz3uKK6X8xLtKeJ05rr75gIlvEyQ4TZmOEtzVj3s9kab6xVcBSBZRvmR70Q6TnaoAWbcmx0mXdDo4JyYk3zjscQWEQhuwx5+Oks8Kwr9g2Wx+Oo8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604746; c=relaxed/simple;
	bh=yXdpRShVS1K32Aquc4tyYxMsBNzBUZ3kKDFt7c4YwWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQvJ/FU1MnvD0ZWSA+zOhZg/So82M28H2gBq6ENnTVV6G8b+RrK3Rq/XK7bkfxps74DiJFSU1TEQLxdQaJTafygLr5MW6B5KZiaaZSe1NSTAFUUaWTrd0SzV1NmNiIYpPJI0AzrHPFomo8yBEXkiVFh/zzA0oksewdmSgv4OmBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImTA2mCT; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ecf03363c9so16625671cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 15:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761604744; x=1762209544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwT/reRHz8WauSCoHeNwtCnsJgecgRuUxE4Adceiyqk=;
        b=ImTA2mCTrHTWOqrqMo6jQ9AggSPh4R1wWT4dmMS0KJW+K5rew+a8GCMkD5CcnEMI9m
         huTqGzgicHje4hm77CwZpMe1XpokWCnILPAZohDeCK0sYb0VSoLj/1Ip+vL+GQKFla9o
         uqPQMMXJnIjXPAMH1OOaArWuaASuGlLeHDpz1UguvlNjrzNBYKZsvxsVHsAoGc6hBaZ2
         pdo2n45vs55bKlcLEP0qEGFlrFiZXcY2DHW33b9M/kwg0Ors8tiMPYAeN6oF3iaRPtR2
         TGxsFv3KjoqGWzMeSTCzggAAE17IVRqAZpXBzxTAvS87S408Y2DTFBoknH7gRMIZ6jZF
         SyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761604744; x=1762209544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwT/reRHz8WauSCoHeNwtCnsJgecgRuUxE4Adceiyqk=;
        b=KJw8ZGMvbQAD2SW1EuReNsyzP6gNOexzavAY7Fsb01B78oXdJe5FJksE+obCvU6Ij5
         6MdL6mo6EXtk67uL+JoqtZEu+0A6zfRHd3wTLjF9FmXWLiUbeP3se6OGwVtpEyrprsVM
         8PezaHx3ELR3PkNpyf+Nyk+I1cp+uXqcdHFtwQNP2ZPUfh+wRJyEAjJtvMByaCQU4xMp
         p7eHidCacU7ouaYr+fX2D5blTQ0qN2fjq+MnNK5k2evdkaMxw26nK7s9ILmzkysNbyI8
         2GB8QZvB4GDUCE99MQEjGvEOkk/WsXovht+XKM8sRDKOKe4NAR1XWYX+FkEvYvhUcGbZ
         CaMg==
X-Gm-Message-State: AOJu0YxIqKN36Ynwvuu42NDKmL5RxFfVXgo7kOhuxdF/DalihG41l+XF
	KUhUCzUDuOBhTpXObQ+fUSxXNTyj0jF4VZBd9ExJ3XWKFXsmqv4yJYzxbXXctSbDd8mVFS3yikR
	5/+BdAVGXgJ+rvkHYP27zmd3YYRdF0+E=
X-Gm-Gg: ASbGncsPlMY9KHF/pB9zEjfMsqAn7Gbp3MMSvMoRFKGpgTeVfcU3d0W67qFLTtGRkVb
	66l3eGlXhRhPzEMy8rhoUxrRJblHKdi9S0JJjHyxMDP7vQDowCoHiWvhWokWGpUowiJwnEjAvOJ
	gYYI61UOXE7pqjXE0ZVrknMDREP6abOXwD5fLfCByu4AxTkIq3VHjwcgylu2xQKIyT3sKFABCZN
	g9Q+F2yuVVV/wViq2hp/dDPqjszeCi7eaSdxK5Atk92Ra5vKq+p0zm65L5Gh+u0kr1GOUZTXuCI
	UTGuQYd403EUtMz8QdvR08CEC7OIsNrpMcnA
X-Google-Smtp-Source: AGHT+IGz3fv6BxFkA5fCM1H9P6AEYihIvlTYFeuqTyPOyy9BUpbrjOlDstW4QMRCU+vbzKoFIOB1yeohnGpdLtWPYCg=
X-Received: by 2002:a05:622a:1892:b0:4e8:a7d6:bc07 with SMTP id
 d75a77b69052e-4ed075cdb23mr25594551cf.71.1761604743630; Mon, 27 Oct 2025
 15:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008204133.2781356-1-joannelkoong@gmail.com>
 <CAJfpegsyHmSAYP04ot8neu_QtsCkTA2-qc2vvvLrsNLQt1aJCg@mail.gmail.com> <CAJnrk1anOVeNyzEe37p5H-z5UoKeccVMGBCUL_4pqzc=e2J7Ug@mail.gmail.com>
In-Reply-To: <CAJnrk1anOVeNyzEe37p5H-z5UoKeccVMGBCUL_4pqzc=e2J7Ug@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 27 Oct 2025 15:38:52 -0700
X-Gm-Features: AWmQ_bko484e3pQgerqCGRXptAUyLzvA4LU7zsUPgJyJGGmg6VANzWHnZHObVz4
Message-ID: <CAJnrk1bx+32Tq5DOk6=C+_smV2HgP3+RT6gpYLSNMEirFs_EkQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 11:36=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Thu, Oct 9, 2025 at 7:17=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
> >
> > On Wed, 8 Oct 2025 at 22:42, Joanne Koong <joannelkoong@gmail.com> wrot=
e:
> >
> > > Since fuse now uses proper writeback accounting without temporary pag=
es,
> > > strictlimiting is no longer needed. Additionally, for fuse large foli=
o
> > > buffered writes, strictlimiting is overly conservative and causes
> > > suboptimal performance due to excessive IO throttling.
> >
> > I don't quite get this part.  Is this a fuse specific limitation of
> > stritlimit vs. large folios?
> >
> > Or is it the case that other filesystems are also affected, but
> > strictlimit is never used outside of fuse?
>
> It's the combination of fuse doing strictlimiting and setting the bdi
> max ratio to 1%.
>
> I don't think this is fuse-specific. I ran the same fio job [1]
> locally on xfs and with setting the bdi max ratio to 1%, saw
> performance drops between strictlimiting off vs. on
>
> [1] fio --name=3Dwrite --ioengine=3Dsync --rw=3Dwrite --bs=3D256K --size=
=3D1G
> --numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1
> >
> > > Administrators can still enable strictlimiting for specific fuse serv=
ers
> > > via /sys/class/bdi/*/strict_limit. If needed in the future,
> >
> > What's the issue with doing the opposite: leaving strictlimit the
> > default and disabling strictlimit for specific servers?
>
> If we do that, then we can't enable large folios for servers that use
> the writeback cache. I don't think we can just turn on large folios if
> an admin later on disables strictlimiting for the server, because I
> don't think mapping_set_folio_order_range() can be called after the
> inode has been initialized (not 100% sure about this), which means
> we'd also need to add some mount option for servers to disable
> strictlimiting.

Miklos, could you share your thoughts on this? Are you in favor of
disabling default strictlimiting? Or do you prefer to have it kept
enabled by default, with some mount option or sysctl added for
privileged servers to be able to disable strictlimiting + enable large
folios if they use the writeback cache?

Thanks,
Joanne

>
> Thanks,
> Joanne
> >
> > Thanks,
> > Miklos

