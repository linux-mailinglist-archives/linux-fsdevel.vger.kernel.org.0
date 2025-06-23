Return-Path: <linux-fsdevel+bounces-52614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D97AE485B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 17:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF1E3A689A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F048528B41A;
	Mon, 23 Jun 2025 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li4aUdsp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CF8286D46
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691982; cv=none; b=HBv+zrkhWFWc0Thbxg5z5nyTALa69ptEhO2BaTmF4VOkyzRCU0GsILz9X1qWyKRQIlqaDtL3n9FgLfY+TOb5zGHGCCe38wfMSuCXjF4ca1mB4VTJ9d7zAkIgOaXk+gMfI/vU4Vmt/NB3d9+u9UOPssrQ01SYFQJZ9wY86SMrH9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691982; c=relaxed/simple;
	bh=lc100cMo9En40B0ztujnJRRO7hPXmlUrJUKsw1HShY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPg4BP0vRdE/ABEi2eZRwQN+djr3erT0uz48SRqB0i/IpypeSJBUJj/KgBgDgQwPYmzvYY7I3bFEq8hl1ZX8M9NlLYEVTmLY2jk0VuyfRk0YEdjAFheQae+GufJfOjbhdWKXjxFUtiqxlowUfTMROZ/0SeGKUEmdxJAA6t4HbeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Li4aUdsp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-adeaa4f3d07so875404566b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750691979; x=1751296779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCpZRaNYcrlJ7g7L1zxin2BdglQIDQ3Fa5bAy+E1/kg=;
        b=Li4aUdspklDyDQKJuRoCzOoqNmiYmlOWB2pUkzDwh4JuEVoC7iveooJQ8k2YiPgqbs
         /gcxGo/rVx3vh7SP+RSBtzPjMS1fr/hW1toACwBn+OJbPsni5AOb0vdtNrcS+Ym6GbpE
         HeBmhCBYfPqeS+tD3/iInP+b3TxP7vYM0wnzmb/WzHSuoICpincW/XPTIN8ZGNuMO33O
         FHuInZmVvPYBHtRARwrxqfpBTMxYM63nCI0Ttp8dOiEhWJQRgFaBNsLnLETQxWox63TA
         IuAC5f9EJM1iquB7tRzNp2J6RCcvFkiETKBKooCqAXZeRN811yteExfcZ39LTxwe+abu
         7Dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691979; x=1751296779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCpZRaNYcrlJ7g7L1zxin2BdglQIDQ3Fa5bAy+E1/kg=;
        b=vSo6rYEpUO1QYuFGznSZmKukuYoQYXFHbET5eIBfCgw2w/KfmypThy3P1iBw0CjlHs
         iTEKCnoXfncizWAhZQwos3h31MQpvI2wmLAJSxcmDTBR6drbaS+tgjxjxwjOkT8G5DiD
         P/PIhqUG6xQhNvBzROFpSz8UlUVFsVpZPXx9PGGo3qXIU26QECrdJfGsqbpFakc+l9Rc
         cvK/OpVFxlDNTDr4d4Cqrds6KYrfOBmaqeqGTM5BvuR9D0+Ad5ZKa420ijk30nVq6fMa
         nU69p4snecAd2CWc9KWFNwZFeO/qalRpYT8OvdjJqx8ZswqwYEkbVVavdq8BPYqI2sCG
         sxEA==
X-Forwarded-Encrypted: i=1; AJvYcCXRP/qdZXjLRHnYcNCYi+tNr671FxyWSkdMjHS1QiHw/H2L0qCYlDINxF+lbPF6l8bW7hzDB3hnjbWNXlYk@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyl7X5Ph4UafGLJCGw24mWH9av+IAd/dEaxZnoeOoygxCrwLBs
	O4GPL17XgavBDe/a4IEQCSu4AO2WJuC8xsb5sM/Yk3xVS4fa1cP+aHx15QvSMs8+HW/ZUlsmokZ
	GckDdmLSnodsUQ4Ld4tNC1SRkMRqJvms=
X-Gm-Gg: ASbGnctEF74zPs6RSl0OFENWFnsnOOJU7f6i4iXobE+2RPnJQIJshaYxuVUniYDqFds
	R0ECfFMxQBAYSPgYHrhM93kxQnfLYmb60xNyFaWCDBBS6yW/47mEDfWidN+8vhtYDpN9F5Ny0Qt
	z22OoyheKsKGx1vRGfaFoG7TVKZOs4yU2F9sk1VtKKr27UEgnvOwZvjg==
X-Google-Smtp-Source: AGHT+IG2nEpSKguYvq4MT0QxB0uZkhC0q9k5UaApzvYIBw2WImr6QSPQ8WHQwfIIGy4TVpQhO/XQ26yuezEx15TWaZU=
X-Received: by 2002:a17:907:2d86:b0:ad8:9257:5728 with SMTP id
 a640c23a62f3a-ae057d8cca2mr1299182366b.27.1750691978472; Mon, 23 Jun 2025
 08:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622215140.GX1880847@ZenIV> <CAOQ4uxioVpa3u3MKwFBibs2X0TWiqwY=uGTZnjDoPSB01kk=yQ@mail.gmail.com>
 <20250623144515.GB1880847@ZenIV>
In-Reply-To: <20250623144515.GB1880847@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Jun 2025 17:19:26 +0200
X-Gm-Features: Ac12FXyyihH5TYAhYyJoqyhCl2n3PwsvmkwMKcy2wI_t4F_ZZCDNn659Q0mwsUw
Message-ID: <CAOQ4uxhTXgTt62cX-F00e4vAyhDn=fCTxDqONcGT9+tBH-DkCQ@mail.gmail.com>
Subject: Re: interesting breakage in ltp fanotify10
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Eric Biggers <ebiggers@google.com>, linux-fsdevel@vger.kernel.org, 
	LTP List <ltp@lists.linux.it>, Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 4:45=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Mon, Jun 23, 2025 at 09:24:22AM +0200, Amir Goldstein wrote:
> > On Sun, Jun 22, 2025 at 11:51=E2=80=AFPM Al Viro <viro@zeniv.linux.org.=
uk> wrote:
> > >
> > >         LTP 6763a3650734 "syscalls/fanotify10: Add test cases for evi=
ctable
> > > ignore mark" has an interesting effect on boxen where FANOTIFY is not
> > > enabled.  The thing is, tst_brk() ends up calling ->cleanup().  See t=
he
> > > problem?
> > >         SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "%d", old_cache_pressur=
e);
> > > is executed, even though
> > >         SAFE_FILE_SCANF(CACHE_PRESSURE_FILE, "%d", &old_cache_pressur=
e);
> > >         /* Set high priority for evicting inodes */
> > >         SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "500");
> > > hadn't been.
> > >
> > >         Result: fanotify10 on such kernel configs ends up zeroing
> > > /proc/sys/vm/vfs_cache_pressure.
> >
> > oops.
> > strange enough, I cannot reproduce it as something is preventing
> > zeroing vfs_cache_pressure:
> >
> > fanotify23.c:232: TCONF: fanotify not configured in kernel
> > fanotify23.c:249: TWARN: Failed to close FILE
> > '/proc/sys/vm/vfs_cache_pressure': EINVAL (22)
>
> How old is your ltp tree?  Mine was from late May (81d460ba6737 "overcomm=
it_memory:
> Disable optimization for malloc to prevent false positives")

My LTP tree is from end of May tag 20250530

> and I'm definitely
> seeing that behaviour with fanotify23 as well.  No TWARN, though -

I have no idea where this strange TWARN is coming from
I did not investigate it, but the bug is there anyway, so I sent a fix.

Thanks,
Amir.

