Return-Path: <linux-fsdevel+bounces-26455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1BF959656
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 10:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81682824B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787F11A7AEC;
	Wed, 21 Aug 2024 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkYzijg5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EA115749E;
	Wed, 21 Aug 2024 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226450; cv=none; b=GAeLULDjEJvlSvY1Id2velqEytwN4MYUG7EVBTNrY6Csy2eA/YMbEIqHcq7ELRbDUTabhDPcC3+pK1DsaZJyPMTL292mPDNQbBea4gl4tU/XWXMe5yK5o5U4SSDAjCE8w9H9L5xo6VZq9/3zmYO72ti/bIZYzi92Fz3Mb3WLh9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226450; c=relaxed/simple;
	bh=KEiqrTa7V5LQvAxCRMo6VPBvHQqLLD9fgKPrlSjBAaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApNSKkiTWyLezCf4k/lkAfo6saiGuV8PKZkD2KRXn2W0ytPXDCB7O0bnaw1o+Dpru9nTH9aKKKnXhAs0hX7YJcRHHgH7Hh58RFl2zly2nejcX0BWqg8zBenovrCCNspA/NnjAeD/aLvW7pb1Lfzh7hvOeiS3h7wkAgLCoHnwgaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkYzijg5; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7093472356dso3387924a34.0;
        Wed, 21 Aug 2024 00:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724226448; x=1724831248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DNTFuMLfoiAK/QybcwS+hE3dNAux564SKlwhapf4UlE=;
        b=EkYzijg5CS5dKKzYB57m4zTA3kU+ykjNcXY7tp+3gAqFDJxxI82mVaSdka3aKIE+2Q
         wE2nzRaxBt2KGy4GBfOscu3bFHPOb03xCnYAR+sTBLAxzG/RJS7Y1/yuZLytt466Me8+
         TNaMpl3ktPw7VN/IMn7akGQRFKTasAZ/N8lNlcjr2aIkXYuKbFx8geTSD1qY5/xBr55/
         Dpp3eD91JmlJ4QVe9ZqfP90RWiIxqpyNIDKamLma2A1PclhrQgRLiCPebm2PTYJOqnJh
         kPk04+4kjbF7TarAnFxIWgQGHv/qZnNjwslOXLzFDDeD9SGlnEZRJZaNs7JChQ/mRRYA
         +BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724226448; x=1724831248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNTFuMLfoiAK/QybcwS+hE3dNAux564SKlwhapf4UlE=;
        b=usUdoLhR68BTgRSiVzyLYUyBzRLmS99Ctlax/KQ0ULyxw8pWxjhoB9vC76xB7H5Rkz
         vLYNA/Zf7CHAKbUjvwM0zbBCeTh1KZq9398H7CNAnpMoP6HDrsMCRHRuEDWvaC0PjNEj
         J+Am5269IkAzzFI31W2a1yse+RmzRVFqepYNPOu4I9OHnsSEfUxiEbuxPiWCJZDFse60
         snStr+UkXKXKZ4bup1M9D9teNcmghF94H5vE1rK4n9X+FKdGSp6G2L1bzLvIdY81k5+g
         GIIRkErS8eijIgY1QJ5xYhkH45P7mLgFbdOAP/OUJjpxusAbLbT+7ZbTI0jRRHEYy0lc
         CEVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkcEuTx/xU1nJuYUcol96FmZ8+BMYKIlbX/KRQY8rhgsfwewAtRW7w8Nwsoxd/7wSZdfzcsHYw@vger.kernel.org, AJvYcCVTDrYea6xk+G103bMzNlpzha5FsK25bTgQug58z04He09/OTt6QZEeSt74ZY7Lk5EeEFDfJ+QyAMSSHBQO@vger.kernel.org, AJvYcCVz7Xfrqk/AZrrfDdSwJGIM0RDjpBm/fL7/SJ9uab2gL86K44aiyodPfvKmxU2K4otQW8JHzmIumagVsZAw@vger.kernel.org
X-Gm-Message-State: AOJu0YyVi6W2rg8l2QO5KDs/E0h3zaOmpyqwTJqwxcFTbk6C5jdOUU81
	BJTR0c8l80JHMRJ+y+F+7TYHN0Od7XFECtIqlAjPCUJqH2hAPd2mSdM19Zy5UybdP0ylfZJYouj
	sXp1a1ZljCOFWvmX6Q28bKwMHX0Y=
X-Google-Smtp-Source: AGHT+IF0kxiN5PeGME/C0f5sNNmx2Q8USPOcg8M/l/rSyBKK3TPLmG1/uQER1xA1vSgsz9scqRXt0UnPF/x1wDhaJTc=
X-Received: by 2002:a05:6870:7024:b0:270:138a:5e57 with SMTP id
 586e51a60fabf-2738be81733mr1319401fac.44.1724226448173; Wed, 21 Aug 2024
 00:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731-gleis-mehreinnahmen-6bbadd128383@brauner>
 <20240818035818.GA1929@sol.localdomain> <20240819-staudamm-rederei-cb7092f54e76@brauner>
 <20240820193414.GA1178@sol.localdomain> <20240821-weitverbreitet-ambulant-46d7bfbc111e@brauner>
In-Reply-To: <20240821-weitverbreitet-ambulant-46d7bfbc111e@brauner>
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Wed, 21 Aug 2024 09:47:17 +0200
Message-ID: <CAO8sHcmLS5F6CocZPgThF8_KEk_dP113sWQL5a1XcXkeRTv6Qw@mail.gmail.com>
Subject: Re: [PATCH] pidfd: prevent creation of pidfds for kthreads
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Tycho Andersen <tandersen@netflix.com>, Tejun Heo <tj@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I just prepped https://github.com/systemd/systemd/pull/34058 which
will apply the same fix from ead48ec35c86 ("cgroup-util: Don't try to
open pidfd for kernel threads") for pids read from /proc as well.

Cheers,

Daan

On Wed, 21 Aug 2024 at 09:41, Christian Brauner <brauner@kernel.org> wrote:
>
> On Tue, Aug 20, 2024 at 12:34:14PM GMT, Eric Biggers wrote:
> > On Mon, Aug 19, 2024 at 10:41:15AM +0200, Christian Brauner wrote:
> > > On Sat, Aug 17, 2024 at 08:58:18PM GMT, Eric Biggers wrote:
> > > > Hi Christian,
> > > >
> > > > On Wed, Jul 31, 2024 at 12:01:12PM +0200, Christian Brauner wrote:
> > > > > It's currently possible to create pidfds for kthreads but it is unclear
> > > > > what that is supposed to mean. Until we have use-cases for it and we
> > > > > figured out what behavior we want block the creation of pidfds for
> > > > > kthreads.
> > > > >
> > > > > Fixes: 32fcb426ec00 ("pid: add pidfd_open()")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > ---
> > > > >  kernel/fork.c | 25 ++++++++++++++++++++++---
> > > > >  1 file changed, 22 insertions(+), 3 deletions(-)
> > > >
> > > > Unfortunately this commit broke systemd-shutdown's ability to kill processes,
> > > > which makes some filesystems no longer get unmounted at shutdown.
> > > >
> > > > It looks like systemd-shutdown relies on being able to create a pidfd for any
> > > > process listed in /proc (even a kthread), and if it gets EINVAL it treats it a
> > > > fatal error and stops looking for more processes...
> > >
> > > Thanks for the report!
> > > I talked to Daan De Meyer who made that change and he said that this
> > > must a systemd version that hasn't gotten his fixes yet. In any case, if
> > > this causes regression then I'll revert it right now. See the appended
> > > revert.
> >
> > Thanks for queueing up a revert.
> >
> > This was on systemd 256.4 which was released less than a month ago.
> >
> > I'm not sure what systemd fix you are talking about.  Looking at killall() in
> > src/shared/killall.c on the latest "main" branch of systemd, it calls
> > proc_dir_read_pidref() => pidref_set_pid() => pidfd_open(), and EINVAL gets
> > passed back up to killall() and treated as a fatal error.  ignore_proc() skips
> > kernel threads but is executed too late.  I didn't test it, so I could be wrong,
> > but based on the code it does not appear to be fixed.
>
> Yeah, I think you're right. What they fixed is
> ead48ec35c86 ("cgroup-util: Don't try to open pidfd for kernel threads")
> when reading pids from cgroup.procs. Daan is currently prepping a fix
> for reading pids from /proc as well.

