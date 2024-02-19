Return-Path: <linux-fsdevel+bounces-12002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C39CF85A2EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 13:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793561F23834
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 12:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1962D608;
	Mon, 19 Feb 2024 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ls/NcvS1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1552E414;
	Mon, 19 Feb 2024 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344809; cv=none; b=G8h+E+Wf5d0EGQLLHobZ3qeQlhHNZ0pxMt1zvXtT6AMqkhESWvwUvZBHQx6ARZgPLuiBQogi+pmc14nCVEh2aWjU2X/Aha2WINQk2h1D+zcPKzeG4mvEVxHJJ43xS5ceSRUvBdK3YRqmZf/+hOFcr8vwOo/mUh5lAypczOWS0Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344809; c=relaxed/simple;
	bh=bnASyrErN7NwoKLXpETV8dN0Vg1HwaszPZGiWxExf5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7hNHa7+zzS9cGkwVKOrZrEf7+caPYNrB/CPQmdh23vH3oJ41bUk15XnXCN+iTrAYVQMmMJQnesgjHIHupne5task2e/8d3qbk977mtj6vWi8fGCv4eCTd55mki43zNIG6clFirs5vdklOvAQv6MJ1dnCA2MHBo4xI2MWthndzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ls/NcvS1; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d220e39907so36722541fa.1;
        Mon, 19 Feb 2024 04:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708344806; x=1708949606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9YkRy22tf63V8KfPxVfu3+EmjSbv9ECcTZiKgs/XWc=;
        b=Ls/NcvS1+5dkYZaFDBMreD+zm1r3u8qF87nr/C2raRNBleC5P6DV5AOFcwv/HnqDGm
         L+R/4YwiS0gupliDqleUzYpU1vZzCaDFuaKxcBnahJvlZ7bOOrSK44KSCbtgqusz4h1A
         C0h4rej2WWOxilhyEYh0DI679X2TMJ403vkyk7YZAXRswM4FzUXVAxpFFxkEAswWx9bs
         gg5GZ4SdZFr2myWSyjrphbsFuH4B/bktqsCErKkcdUd4YPF1cI9lkLwDSk2iQ9BHgTy3
         k0Lc37hFrB9uZJwYp9F+Y03faPRe2M7C/0RokeUlRBaQ/CSMbsPGRh/iJIsic8UuY3v6
         LBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708344806; x=1708949606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9YkRy22tf63V8KfPxVfu3+EmjSbv9ECcTZiKgs/XWc=;
        b=Zwm3iYtkVyV9/tfFF1kOtK7HDDwKtmVOEYHWHQK4EIph1Svi1Yzwi3OCBqT+yqutQZ
         0eHlZHy4jjgqnYUd6q9MJs0PKeTrobYeeBsSGRoZexW4BAwU9iMMYbhfNldpfBCtEcb4
         KOZJ/s13A5ZSWBjnfisvygY7Sa7GpP6J+9TdHrbIrlACM5RzxGTN7yJBFVVj/iue0L/s
         G+w3nqlfVZftZ1L9TUWUmdJ4Olo3PD9YujB1WaOQsKlObMuhOg58PEiQ9RBU5n4JSAIR
         M3ZuyvrL9dRAPDJk7WBiQ7f+QPjpmnDIYnSh+cDJT/jnE/BG2zpDeisbVOl9DRi6zkH6
         sDSw==
X-Forwarded-Encrypted: i=1; AJvYcCVCRo/rc2yChM+4Cqn7HFZfhBiGpqU0EPngcBwpGekYvV+Y2oR7BOh8/WgFM7+Lh4GAYHYGgAktmUKPaGg5CyPCsVCxqAyucXqPEFaL2d3DJRnUP4XNvS0UXtGtr4aZ0VFslVn1Iq+AZtPCpPkoJVHDjpHtyup0Henf3P6sRgzHmLyCOb2AtRRH
X-Gm-Message-State: AOJu0YzgjRKEASYM8g86eZbzKveLcFcIon1oZyYjHMU1sw440f94jphn
	pPOBtUTSKgxS5sGmhp4K8NDlGiHbDeh6UAHP6N3zDgEukQpaQMWLgomDOSaojO5QcaUohdzzb5l
	WGcZ7JOm8R7AE8pqS03JuOXgO10M=
X-Google-Smtp-Source: AGHT+IHJf9ouFCulxGArETEyR+TjVm6n/md5N0nnKK+E3PZ+xbDGd9Cnr4Fh7RRgxfzqZLVzQ3k5/YwaGeJ06v+9HkY=
X-Received: by 2002:a2e:b0c8:0:b0:2d2:25b3:f039 with SMTP id
 g8-20020a2eb0c8000000b002d225b3f039mr5644571ljl.50.1708344805799; Mon, 19 Feb
 2024 04:13:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000375f00060eb11585@google.com> <00000000000029d2820611a09994@google.com>
 <20240219114719.pyntouzverbsk4da@quack3>
In-Reply-To: <20240219114719.pyntouzverbsk4da@quack3>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Mon, 19 Feb 2024 21:13:09 +0900
Message-ID: <CAKFNMonaAqehuHVW1beMNfgYm1Y8_hcjAZGAC1F5zs-3zcPQjQ@mail.gmail.com>
Subject: Re: [syzbot] [nilfs?] KASAN: use-after-free Read in nilfs_set_link
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+4936b06b07f365af31cc@syzkaller.appspotmail.com>, axboe@kernel.dk, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 8:47=E2=80=AFPM Jan Kara wrote:
>
> On Sat 17-02-24 20:42:02, syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> >
> > commit 6f861765464f43a71462d52026fbddfc858239a5
> > Author: Jan Kara <jack@suse.cz>
> > Date:   Wed Nov 1 17:43:10 2023 +0000
> >
> >     fs: Block writes to mounted block devices
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D10639b34=
180000
> > start commit:   52b1853b080a Merge tag 'i2c-for-6.7-final' of git://git=
.ke..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D655f8abe9fe=
69b3b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D4936b06b07f36=
5af31cc
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11d62025e=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13c38055e80=
000
> >
> > If the result looks correct, please mark the issue as fixed by replying=
 with:
> >
> > #syz fix: fs: Block writes to mounted block devices
>
> The reproducers don't seem to be doing anything suspicious so I'm not sur=
e
> why the commit makes them not work anymore. There are no working
> reproducers for this bug though so I'll leave it upto the nilfs maintaine=
r
> to decide what to do.
>
>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

Thank you for your comment.

This is one of the issues that I could not reproduce and could not
proceed with the analysis, but since it may be caused by an abnormal
state of the directory file (even if it was overwritten), I would like
to leave it as a subject of investigation.

Thanks,
Ryusuke Konishi

