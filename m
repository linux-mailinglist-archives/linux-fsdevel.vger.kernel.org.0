Return-Path: <linux-fsdevel+bounces-8060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5956982EF31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 13:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5461D1C23390
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 12:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9C21BC36;
	Tue, 16 Jan 2024 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCpLe7Lv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5370E1BC23
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7836de7757dso18447185a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 04:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705409592; x=1706014392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0sIpHZGgWomYclPxXxDNF57Ztlaack1l2/nxGSU3U8=;
        b=BCpLe7LvShDV6UdLSPo53YOqF+XFjH8WM+l19hP3wM9CTQJ6dSWZF9ZuMHWRjuBz7A
         YFlM+UTPF4uzumotV7cua6CzvDIRJRJz+ksTZNpoQZjXghqnDCb8Wjo5cZ0SeSM5gWT7
         oym+3WlqUXSL4EYk4Yabik50JSDVN3A3T7iI0bQERSdvXmiZnSslIfMDv7qGwtSkyMuv
         XKJPRXSv9naR50xr7kMAJ8GlKbMJsaV/3yOom26J9B8K8QZyaPwSKt2Vwma4GxFePtEN
         8XO8dIHFBb/89PCC2sUtgyDow4s/ZDD/Za2WigqIptIrnu1dpg5vCR5bZEI81EGR0Lgb
         0byQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705409592; x=1706014392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0sIpHZGgWomYclPxXxDNF57Ztlaack1l2/nxGSU3U8=;
        b=rRUcJWiwuUjjEkC3QeIXNOx/0GzV7AXeZerGkwRVGFkRhKbZFEf4qqBFYT21TaWuZi
         yeBuWFbD5D4lsLcDgs/Zqo2PB8fz59TOLRPHQR6y1IuT4vAmKySBa6X0Gdioxa4Jy1CS
         M0KGTI/lyT3NApejtVbtbnMhlHePuV0d3dOdXJTeLMhiVQntxElETxXmB752B5Qis2gn
         bRLi7Szxv7R/1ajO7FueZkx+/Z2SBMOUGovYflALgPAIDmuc0DYhPb3QMe7tT8DqbZqy
         uMT5ullW9TDf4E3q4ehjhMPDYsgTlmQle8IYoLOp5fvbM4hrQNQIfZiDGhcAorceT5c2
         e8XA==
X-Gm-Message-State: AOJu0YxwQEJ4tjE9rSPc0OrJAp3tjAijm85vhpQlQFv68jtTlytAW4XU
	Yx8LJfRkLiseQ0LkY4mpPy/TI4hKqRl/mINbbrI=
X-Google-Smtp-Source: AGHT+IFqYN0i3ye0/ORKgkt4oEtn8wpPsjlSD+rZynM2rC3XN5vwM2rz2UeOGnCygq5liDb5nVYa/IljTL7YJdD76TM=
X-Received: by 2002:a05:6214:301e:b0:680:ff04:759e with SMTP id
 ke30-20020a056214301e00b00680ff04759emr7907684qvb.42.1705409592139; Tue, 16
 Jan 2024 04:53:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116113247.758848-1-amir73il@gmail.com> <20240116120434.gsdg7lhb4pkcppfk@quack3>
In-Reply-To: <20240116120434.gsdg7lhb4pkcppfk@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Jan 2024 14:53:00 +0200
Message-ID: <CAOQ4uxjioTjpxueE8OF_SjgqknDAsDVmCbG6BSmGLB_kqXRLmg@mail.gmail.com>
Subject: Re: [PATCH v3] fsnotify: optimize the case of no parent watcher
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 2:04=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 16-01-24 13:32:47, Amir Goldstein wrote:
> > If parent inode is not watching, check for the event in masks of
> > sb/mount/inode masks early to optimize out most of the code in
> > __fsnotify_parent() and avoid calling fsnotify().
> >
> > Jens has reported that this optimization improves BW and IOPS in an
> > io_uring benchmark by more than 10% and reduces perf reported CPU usage=
.
> >
> > before:
> >
> > +    4.51%  io_uring  [kernel.vmlinux]  [k] fsnotify
> > +    3.67%  io_uring  [kernel.vmlinux]  [k] __fsnotify_parent
> >
> > after:
> >
> > +    2.37%  io_uring  [kernel.vmlinux]  [k] __fsnotify_parent
> >
> > Reported-and-tested-by: Jens Axboe <axboe@kernel.dk>
> > Link: https://lore.kernel.org/linux-fsdevel/b45bd8ff-5654-4e67-90a6-aad=
5e6759e0b@kernel.dk/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Jan,
> >
> > Considering that this change looks like a clear win and it actually
> > the change that you suggested, I cleaned it up a bit and posting for
> > your consideration.
>
> Agreed, I like this. What did you generate this patch against? It does no=
t
> apply on top of current Linus' tree (maybe it needs the change sitting in
> VFS tree - which is fine I can wait until that gets merged)?
>

Yes, it is on top of Christian's vfs-fixes branch.

> > I've kept the wrappers fsnotify_path() and fsnotify_sb_has_watchers()
> > although they are not directly related to the optimization, because the=
y
> > makes the code a bit nicer IMO.
>
> Yeah, these cleanups are fine. I would have prefered them as a separate
> patch (some people might want the performance improvement to be backporte=
d
> and this makes it unnecessarily more complex) but don't resend just becau=
se
> of that.
>

Makes sense.

Thanks,
Amir.

