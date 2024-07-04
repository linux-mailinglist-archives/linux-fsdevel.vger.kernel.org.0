Return-Path: <linux-fsdevel+bounces-23123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D222927638
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 14:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B955284C51
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 12:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC801B0107;
	Thu,  4 Jul 2024 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cpxxz5P2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41811AEFE5;
	Thu,  4 Jul 2024 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097069; cv=none; b=o6pX0N6bufak/UJWhuutbRnBIul1Na9pzlQV2AwMmSp+WJdqJsSWcwnLpvSv9JRk9XIXTy4Ovy4JolLEyWu/iDwVI55d2/HiYaW5zGZfK5Q+OEuzpPWPV21XtWYuMJy2zk2bfhMDX6PHFTqR2GEx/QN8cNO7+6gi8rtJpAjpItU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097069; c=relaxed/simple;
	bh=y/HsSvOsh+wSPPsva/vntMH7pEcZmfES+GyQgqd8Ntc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AF2RqZ92oQ18ElKAmGMG6MBTsVfzcuVwyKoG8MPpJs5ADSERDhtqVDfF4xyXT2eCVd78eTWWCDW8s/E+6iOWX0o+NJSxh/I/k+H5c8rtEqE+ol4v0RFRGiZ0+1bZegKysHxaEqcgfZZ2sdYVVHlYg+9yIzgpC26ZiS9D2vAvaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cpxxz5P2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77abe5c709so74183666b.2;
        Thu, 04 Jul 2024 05:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720097066; x=1720701866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkfUMcSsV+/cyyr0qSLUuAVHTphAAYzuKlDg7eow7nI=;
        b=Cpxxz5P24CVCXfR6QBFh/jy8/JIhBSsr4c0lv4W4tqtmd500XKUGt/zdM9iBSc5wcW
         GzFUQqkoiQdFBHJ6tvAnBW+KAA4A5jBzkwMjh6v3hhpf7WqyJojXHxNCU5zMDobAH6wY
         W8tdIDQFTbVQI4OB8rGaJZo8YmdGxqwIF+Pgc1/fwif4PslrYJUnL/pAOAlwgsoKC52b
         awkI/p9Q0ZuyDCXvgXdtaGf9kMPm2U5oSJp2Fij2NHz1U6rWH9hUhOxY8Dr/hgfElkpU
         6H0GIkwb1BLNirzBjbiSqadPRqc4chSonZe+mPnalfHPiuY4bH9v5+PGiJye5SOVQbkL
         DHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720097066; x=1720701866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkfUMcSsV+/cyyr0qSLUuAVHTphAAYzuKlDg7eow7nI=;
        b=INI4HrAhdHNK8HFNPy8CR8O42k/ctu7YNdpZxKsTbCgXXbTKOKOL7wXzkHoB3hjbkb
         BZpfhppRBgDknswKGimmilpUJts49yeLDW6jijK87wQ0qz10S1Q5otB2HjlK7mILXPEL
         gzGt8kMfffOcWm1fluul9FxHQUg8jWVQCv9yujLdeQkvMC1N7FxQ6QaBRIdr6CyJtr6X
         xwC10zvMyaabcyWIVQ6jKH6DeTqkyVnWd08vVRiqeFZypkZXueYy+4/yV4eSv0vV8hne
         99SAH7TPTT6RFjq4fg7REIkE7qqByRbQ9xo3AbpDK0HxA1+lcetCmBWwL5cf2Ds+Z4R7
         Rp/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEKDE2gSd240l/dcc3JuDIzknOtXaHysJahVCPXgGMmP/KDY6tslCzyJDUOVbat1MOYoDzpm2hv5R1hQU0DC+QwBGCFVJu7qJtSXFFUj9JgXQa6JnPVtlbgrvYigO2l5HHVEFUCeWyet1rtNRVrCuvFWuuV3w4gzSeJNvdXXhqQoKoOK9s
X-Gm-Message-State: AOJu0Yz9H4+bnaoQYHdfUBnyftOusE2AiYuNj6BHlvWjDoTrt6FbQyWL
	hVwInCZsNi7peAc9HvR1v+2yjB8ttlmLpUc/o0CSqwm29dfqKF00GXXnbMY/V0eRqdmqyTmcEL5
	lX0RFObZcnb7P2kEiWWUlP4lAGqg=
X-Google-Smtp-Source: AGHT+IHFmYCKgNY1r2DGoJqg9mycJo12H8wKTENfBuwuWClUZZSD55krwAQWiym2HlVp5aZfkeM/sJwbR95fBp60Y6I=
X-Received: by 2002:a17:906:19c9:b0:a6f:b080:cf79 with SMTP id
 a640c23a62f3a-a77ba848085mr110339066b.67.1720097065822; Thu, 04 Jul 2024
 05:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606172813.2755930-1-isaacmanjarres@google.com>
 <4x5wsktkcwt7einzjowricl27pzusx6ggls43zionql7ixi5cz@icbegmuqqxcl> <ZoXEiCvdNRr_tj2N@google.com>
In-Reply-To: <ZoXEiCvdNRr_tj2N@google.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 4 Jul 2024 14:44:12 +0200
Message-ID: <CAGudoHFH+bCK6+tjgFRSfUvKhPwPTY6AGcD_S1pWy5ESYKUw2g@mail.gmail.com>
Subject: Re: [PATCH v5] fs: Improve eventpoll logging to stop indicting timerfd
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: tglx@linutronix.de, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	saravanak@google.com, Manish Varma <varmam@google.com>, 
	Kelly Rossmoyer <krossmo@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 11:37=E2=80=AFPM Isaac Manjarres
<isaacmanjarres@google.com> wrote:
>
> On Tue, Jun 25, 2024 at 07:58:43PM +0200, Mateusz Guzik wrote:
> > On Thu, Jun 06, 2024 at 10:28:11AM -0700, Isaac J. Manjarres wrote:
> > > +static atomic_t wakesource_create_id  =3D ATOMIC_INIT(0);
> > >  static const struct file_operations eventpoll_fops;
> > >
> > >  static inline int is_file_epoll(struct file *f)
> > > @@ -1545,15 +1546,21 @@ static int ep_create_wakeup_source(struct epi=
tem *epi)
> > >  {
> > >     struct name_snapshot n;
> > >     struct wakeup_source *ws;
> > > +   pid_t task_pid;
> > > +   int id;
> > > +
> > > +   task_pid =3D task_pid_nr(current);
> > >
> > >     if (!epi->ep->ws) {
> > > -           epi->ep->ws =3D wakeup_source_register(NULL, "eventpoll")=
;
> > > +           id =3D atomic_inc_return(&wakesource_create_id);
> > > +           epi->ep->ws =3D wakeup_source_register(NULL, "epoll:%d:%d=
", id, task_pid);
> >
> > How often does this execute? Is it at most once per task lifespan?
> Thank you for your feedback! This can execute multiple times throughout
> a task's lifespan. However, I haven't seen it execute that often.
>
> > The var probably wants to be annotated with ____cacheline_aligned_in_sm=
p
> > so that it does not accidentally mess with other stuff.
> >
> > I am assuming there is no constant traffic on it.
> Right, I don't see much traffic on it. Can you please elaborate a bit
> more on what interaction you're concerned with here? If it's a
> concern about false sharing, I'm worried that we may be prematurely
> optimizing this.
>

I am concerned with false sharing indeed, specifically with this
landing with something unrelated to epoll.

Preferably the linker would not merge cachelines across different .o
files and that would make the problem mostly sorted out.

In the meantime I would argue basic multicore hygiene dictates vars
like this one get moved out of the way if only to not accidentally
mess with other stuff.

But I am not going to pester you about it, It's not my call for this
code either.
--=20
Mateusz Guzik <mjguzik gmail.com>

