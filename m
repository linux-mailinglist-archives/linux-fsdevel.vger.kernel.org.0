Return-Path: <linux-fsdevel+bounces-16259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5809289A92C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 07:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC83C1F2287A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 05:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91F920317;
	Sat,  6 Apr 2024 05:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctyhzgDt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F494A50;
	Sat,  6 Apr 2024 05:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712381656; cv=none; b=Fx7uH/ElgfHrEi2s13khT/SOuP7lFlrbkJX5egu6B2nO5RTwimJp8SFf9nzex2Hc7xL75+prYxwnRe1TPuLFFVM3+PDzDHJFkJD6TvYonZEGx880uO0hced5vrNBiG3JGh0g8kqP2mRm0tbcuN8GHVYQVGoqsOtBI8X5+7TawuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712381656; c=relaxed/simple;
	bh=sjIb0OmKeVi5cnv4+A4sEyUIYpuAgv5LPoDxz0p0v/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogM5jrtoBTx+ijyaOMiZBnLacX/oY8dk2z7C/AsxmgEk1QNTN9BjIhWCFSh5ydukCksmeog94KEOx8/cp5S5Z7e5kiCxnr2Rw3yuEBoiC2YoNOeeS2xnXKxbTDPHGXJ/i2Ix64bONLMoMaDSO1igouB/52v+SVTAT9y3SGtTQAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctyhzgDt; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4317aff5cfdso14744211cf.2;
        Fri, 05 Apr 2024 22:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712381653; x=1712986453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+J2wZBHLKqPS/mVbQJu/RljYJnB9FBy3Yw/ZVeK47A=;
        b=ctyhzgDts24n7+iNmKK/igh8ClzDTPxp6WuN7PoSANyqgMu3DgaXbcnZ2YF2RBVvWp
         KVOO0k/cndvbX5c3Q21GoXp3h8aKZ71qcxsXEgiqvsy6VG6b16svgcvN2GGhr054DgBd
         jyUOuRhP48AYAEu3GKopJjyjR8x0jeOwaUqP+yJcSG432Iir11ISlD+l+TUIIXkQc+aN
         4G4chYyGayzYz2CheqwLh0NnNmUsnd3Lpvqj5DcpDQ9yjSPFbeilDB+J4YJ84lqgv9/G
         GgYzwhZ9QK3tKjb734iN71risLald0g4u1rKrPcHyUFcD+2QVYj7ImM7yx8wDobbwu30
         Penw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712381653; x=1712986453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+J2wZBHLKqPS/mVbQJu/RljYJnB9FBy3Yw/ZVeK47A=;
        b=N8knhDhbNFvAZ4M4zoR8Y6Mo7/kEimlOumbCtw7CL9P08Ji8L2U2M82z9VIpLXMQle
         oNeGh63uYtmjFaaGKqmXRyXNfdleHkDFGjmJQm4wis+7M9Y/4t6Rie3PlSIioVmWU9P3
         KMDPzT3mXcyj+j7AOC3ck3kX4JNy7XbUXb4d8D4BYktd6Xap41MitAbzlaR1jE/QlE1v
         V6uw3sF0NfsDHJ+PB+VIasyKFWjgKkD54heBEzlmJpV8viqZjXZloOj9TkaQErm2N1SH
         5Vev53uaZ03Tud6Cd7klGIpEGukfBNo9HDeF4aKXTPJHzvTIiCboYJed2VEt9b6kOxOn
         VZGg==
X-Forwarded-Encrypted: i=1; AJvYcCWCdLZ7y4AGvNDplboD8wd3Ysxa7et8tuxs/QlFhy4fe2mvZZtrIrve3YqrVssNlMk2BvV6/H+RrOrQGMKIMkBusJRtgNvyKQh7OVO0x9PI98g9jdUGznGzKye0RVFBjI7JC26Vmi6oJxh4aA==
X-Gm-Message-State: AOJu0Yz4DrCX13+l0x4+4AhQTeVYgfGh0xI4cHIYX9Jn12fUauFPsScM
	5hk+CXY73AnV8HP2xBxL5bov5VfuFxg7fppex/8VXhpOc19jbRZthfXc6XjLjxIrG4xBCAwyYdK
	j5QpyBl8VGeQ9qg6iWMyA7ItOJSc=
X-Google-Smtp-Source: AGHT+IGdpi3X6hvAiJJU5vuC1goR2nuppjKEUonPfQf7cgrtAzkjKl+THURhFH/wwQbjGtQlDmzfAgaknHBUlVp9PZs=
X-Received: by 2002:ac8:7d05:0:b0:434:5897:c6f0 with SMTP id
 g5-20020ac87d05000000b004345897c6f0mr3018031qtb.28.1712381653464; Fri, 05 Apr
 2024 22:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxhm5m9CvX0y2RcJGuP=vryZLp9M+tS6vH1o_9BGUqxrvg@mail.gmail.com>
 <00000000000039026a06155b3a12@google.com> <20240405162333.GU538574@ZenIV>
In-Reply-To: <20240405162333.GU538574@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 6 Apr 2024 08:34:02 +0300
Message-ID: <CAOQ4uxgJ5URyDG26Ny5Cmg7DceOeG-exNt9N346pq9U0TmcYtg@mail.gmail.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>, 
	brauner@kernel.org, gregkh@linuxfoundation.org, hch@lst.de, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	valesini@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 7:23=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Fri, Apr 05, 2024 at 08:37:03AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot tried to test the proposed patch but the build/boot failed:
>
> WTF?  The patch is
>
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index e9df2f87072c6..8502ef68459b9 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -636,11 +636,18 @@ static int kernfs_fop_open(struct inode *inode, str=
uct file *file)
>          * each file a separate locking class.  Let's differentiate on
>          * whether the file has mmap or not for now.
>          *
> -        * Both paths of the branch look the same.  They're supposed to
> +        * For similar reasons, writable and readonly files are given dif=
ferent
> +        * lockdep key, because the writable file /sys/power/resume may c=
all vfs
> +        * lookup helpers for arbitrary paths and readonly files can be r=
ead by
> +        * overlayfs from vfs helpers when sysfs is a lower layer of over=
alyfs.
> +        *
> +        * All three cases look the same.  They're supposed to
>          * look that way and give @of->mutex different static lockdep key=
s.
>          */
>         if (has_mmap)
>                 mutex_init(&of->mutex);
> +       else if (file->f_mode & FMODE_WRITE)
> +               mutex_init(&of->mutex);
>         else
>                 mutex_init(&of->mutex);
>
> How could it possibly trigger boot failure?  Test the parent, perhaps?

Let's try again, rebased on current master:

#syz test: https://github.com/amir73il/linux/ vfs-fixes

Thanks,
Amir.

