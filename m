Return-Path: <linux-fsdevel+bounces-16323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4DF89B087
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 13:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5761F21E70
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 11:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7407E208B4;
	Sun,  7 Apr 2024 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecy07tw7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B3F18C1F;
	Sun,  7 Apr 2024 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712487788; cv=none; b=RvOl84hVzFcZezNo/tvMVYoDG7fGezpHxBKchWu6BJzKUujOxkIRs8KEYR4Kk02FNfnA1Kke9TQs9M+hi212XyeQQnvS3ZUYPZJ+P0Q53BvDhI4zIggZ5oRZFdABCB81FcQh5in5rczM9ssT0yleCvpFLRwr3lqundfjgSYw+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712487788; c=relaxed/simple;
	bh=2bnSJcE/EunYmSFZYekZyYXjQHtFS370sqqCcC7vL6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKG/Mtz8+sH92OKzRM61zcokSfllgjWhm0rf3sO9UjoOkX9PgKbPXYKJYwWLkMn2acIrIQqlhqzh84D08u7Qrok1ysX6xjx2GRI+XYbSmvKZrw5L2ye0LZjdNaK8a4V4yfze/3M8xkjYCAiPF01i+mpOseIz4OXP66nArMZ+tVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecy07tw7; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78d515ae606so119548585a.0;
        Sun, 07 Apr 2024 04:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712487786; x=1713092586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nwRbexcYOPp30ekgwuJ6VgzDw5dRFusyO6fanHsflY=;
        b=ecy07tw7AVEF0mjmcrakqx7/p1J6Gsg/zt8FW/T6A2nYxMvqDzldZgF3eyQ089KZRr
         WDdHI+DZrtyUej6HX6bF2hykZ7/dPaokjx1Ilhj/cBJuAgP3ejPiqG/JOy4sh1YSspUw
         GvB8rlYF3CJQ+DpcNd0BCcLVzOqwuzeBfSfHmSLFqVckaSKQ5+9EbD3AzsvW532CHszV
         lvJP3AVqGXvbcstv3XAZDbnDkriPJRsi2ysmDBztAPHuMF4KI9efTaTG2ApDX05YXw0f
         wX3Xv1LCOtGe0IxjFbmxg6OTamQmmeUR9jo/PhdeMxlklL3ylv+zZF0YI3JNHgEhNcJY
         EkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712487786; x=1713092586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nwRbexcYOPp30ekgwuJ6VgzDw5dRFusyO6fanHsflY=;
        b=hwxRJ4K0LjBPzRqX+HhlJcUSjcGlSA/iRwIl4jcRh2+WyWQk+FehPRRVLSpXiHaQf7
         QwxOEpzLFOGgYDupEyQA17kfc9CedO9S3krNcA7S15W8LRlRatdrYdpVDPh16MJwrbww
         qC009b3MiU7RMpQ6433pizbfpSPKGCu4qicB5uAdfdBImRlJB1vc3GxL2MokhLW35MR0
         Oq4tvfYB3RkNSkrDAPcKCK1nL8AZGxMlKxlDKtlSuIigDto3Dy8Q4/nPK6uUUr74KCAq
         7fM2Wd4rkBZvwxQ42EvrcVMkfJi2CMOKKHb7eWCrQbvHPY6TEYv2C05+Y6QCMMXKc5/q
         ZGaA==
X-Forwarded-Encrypted: i=1; AJvYcCUhtZAonl1vbanfv12r4fLVtN4MGgPcDQaiysU9Eug8DMG6geaqUK+W4VBH6QdFABj6XHHOBU6euK4NE31JUzyU7ZtEj/Idql45OuYovRrDzFUCI0fcAYly+Im5qZjl7J89Qj1jetwGDMkR4A==
X-Gm-Message-State: AOJu0Yz578Arp00faq8znyd3yZtenocKTI6ZA7c7VwM+HZG3iWttMbFG
	rY4TLdun9b7h8Z9jEwzn6wpZlAR4kG37FaPtlOUSIh7hpSXVw587p1T09Nj2I1OhsQYR0MnGEZl
	E7p3ZWtPGQXdGsn/jfxWTtzuhIizcItIwFkc=
X-Google-Smtp-Source: AGHT+IGEl/fhvMWuigWpp5T/hRSMXCz9SaI1xF8O7il2iyC3X2Iozqdj/gTeeQyJyQRAJOtvG+/c6gyQT0Y9RCgag6I=
X-Received: by 2002:a05:6214:b13:b0:699:1b89:178c with SMTP id
 u19-20020a0562140b1300b006991b89178cmr12331825qvj.2.1712487786390; Sun, 07
 Apr 2024 04:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxgJ5URyDG26Ny5Cmg7DceOeG-exNt9N346pq9U0TmcYtg@mail.gmail.com>
 <000000000000107743061568319c@google.com> <20240406071130.GB538574@ZenIV>
 <CAOQ4uxhpXGuDy4VRE4Xj9iJpR0MUh9tKYF3TegT8NQJwanHQ8g@mail.gmail.com> <20240407005056.GF538574@ZenIV>
In-Reply-To: <20240407005056.GF538574@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 7 Apr 2024 14:02:54 +0300
Message-ID: <CAOQ4uxgkTRghep_-VFpHPWW1ua+NWZ2YuFZVJHCAa0euTHgkJg@mail.gmail.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>, 
	brauner@kernel.org, gregkh@linuxfoundation.org, hch@lst.de, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	valesini@yandex-team.ru, Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 3:51=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Sat, Apr 06, 2024 at 11:57:11AM +0300, Amir Goldstein wrote:
> > On Sat, Apr 6, 2024 at 10:11=E2=80=AFAM Al Viro <viro@zeniv.linux.org.u=
k> wrote:
> > >
> > > On Sat, Apr 06, 2024 at 12:05:04AM -0700, syzbot wrote:
> > >
> > > > commit:         3398bf34 kernfs: annotate different lockdep class f=
or ..
> > > > git tree:       https://github.com/amir73il/linux/ vfs-fixes
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc5cda11=
2a8438056
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D9a5b0ced8=
b1bfb238b56
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > >
> > > > Note: no patches were applied.
> > >
> >
> > Looks like it fixes the problem:
> > https://lore.kernel.org/lkml/000000000000a386f2061562ba6a@google.com/
> >
> > Al,
> >
> > Are you ok with going with your solution?
> > Do you want to pick it up through your tree?
> > Or shall I post it and ask Christian or Greg to pick it up?
>
> Umm...  I can grab it into #fixes.

Cool.

Also:

#syz dup: possible deadlock in seq_read_iter (3)

https://lore.kernel.org/linux-fsdevel/CAJfpegumD0gDXpZwy53pPu54ifOfW-tTBLni=
LHep3sW2Z96MjQ@mail.gmail.com/

Thanks,
Amir.

