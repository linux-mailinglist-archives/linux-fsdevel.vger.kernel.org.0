Return-Path: <linux-fsdevel+bounces-31907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A93F499D4E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 18:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315971F23F10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4161B85E2;
	Mon, 14 Oct 2024 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n5v7vU2x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483071A76DE
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728924181; cv=none; b=FXMVyADBFvwlnOM83pGVTPZLSZ+HO8hLFuPNgE/HcwnhmY7gVT3TyJzTwIGGZ2kd44S9Dke/g8Pj4AukmhbqiSB+cOWdiOVPXeuraUomA4YseElsxUsV5rsQgCIdV8ZHw4oSA8lUqMG9SzQZ+EFh9JTVIkzsXry06rKgkQWG1+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728924181; c=relaxed/simple;
	bh=H2zhOSr7rTC8ZsWXwDwe+xuL80mIu1E4LgMqQFZ62p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rdzl/XfOohKcG6T7CJJovxTPs3DDaMYWrJNX1SCrMp2LN7zH8sowyeP1vxqMbnAux95FSJ22vtmhZI88qLozO9y15T58XEWxm92UCTM0vyjLPWOACnnuKkdaj/F47Bo+qfuscYyrAFZ/yvppPGn9IASfr+djRlL5Hw1Qp+mjORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n5v7vU2x; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so3375715a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 09:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728924179; x=1729528979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vRohclFyb1yVLVIIYVU3Grng2JMSExeWOOVlHqN8Zo=;
        b=n5v7vU2xDlWxecjFsm0O53UAcBS7iG4k617Cycdwdgu/Oa1uoroXA53n/4dP2j36Hk
         YIvAa8eNay/BSQStv+s/Q6v900fPa3ffnbGwT6O4HYhnZOymaxOa/4LumhnWyVsQlLgE
         BneSKH3NFd4i4Aqla6ljeQPrtnXHI9lTIPSoivqbVqK8YvS5N/PTIbiBw7FeI7iul76S
         Z4rTckyhFmnLpvKL8fZ5xzlbdO7dofPnFDQ/pNgy3DwPw8RhAphN7+kLB17fPn6v+Pxc
         rFMG6Ji6tfESQHgqSp1fO0n883B8aspa4Tn957zy2KKvJ0Pm2gB9uc7cXV9tUaru2F9H
         ZLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728924179; x=1729528979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vRohclFyb1yVLVIIYVU3Grng2JMSExeWOOVlHqN8Zo=;
        b=u/9NgamDwqWphw/Usd/CEyZ/V/VooS4OcKAqMGMe8uLn09EJgz18PXbJ2oMeXMjH60
         1CUJ3GIQJrZ078annjtgoW9Ts3zjg673Nivy7i7cpkMQRxSI8bbPol7Urv65spDIcReG
         yEfZBBSkEee0VKfsMM4PEWf4SNrP53K7pGSb8nu4uSa1X0aVAI5+jEiZfy63Gdpt8wTk
         rWd4h1aASaKZGNHgy6/txqGYQ359eMukB/Hhe2deteKZgVHfddlVJVNi5JElzslwyljk
         770BMPWoV1RIzDa4MrYcmmS0h5lM2Rpm3ubMrjCKmlFnb5ZDUz8YXmDomxay4E4CswDM
         fOqw==
X-Forwarded-Encrypted: i=1; AJvYcCVtCs6fMvInYwyHJKx8ShGKi2TxagOX/9fNYopGgspGkSkKVZBNlRGQsDqzBkRpLzcI/oVahseZyuu3+h9r@vger.kernel.org
X-Gm-Message-State: AOJu0YzgnNuL8k/fvBF1rSoM0ZTS3Mg0TsVHvYpJpNpomZ+un4T9WPao
	WiCpVvDrIQylG+m/+mxg8yYaKPUoA5nxbl9ejJdGmsx/uS9iPLqpZMoDw4mqJyIU3+/Lfxnzdc/
	GZSbXrRuqoWBiJLMgCd+gUMbfjOC/MSNVUw16
X-Google-Smtp-Source: AGHT+IEDVP2DotlNS2VvFJeOmAwWOSyXXgTf9UNwef/K0IjxmgAvZwtAL/FzLEwdlqdRyFWgivR/JbF5bg2V10bn2e4=
X-Received: by 2002:a05:6a21:393:b0:1d2:f00e:47bb with SMTP id
 adf61e73a8af0-1d8bcf3e69fmr17588474637.21.1728924179200; Mon, 14 Oct 2024
 09:42:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <670cb562.050a0220.4cbc0.0042.GAE@google.com> <CACzwLxgJb=xUCO+TFN_Y6SZ6YxoRn=pg0yfif3+GuHK8kL3x0Q@mail.gmail.com>
In-Reply-To: <CACzwLxgJb=xUCO+TFN_Y6SZ6YxoRn=pg0yfif3+GuHK8kL3x0Q@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Mon, 14 Oct 2024 18:42:21 +0200
Message-ID: <CANpmjNM3DVrO0vT2x3OiqQKLKf8kQ0qK3EdM+Wqi6ru66ZNBaQ@mail.gmail.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in xas_create / xas_find (8)
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: syzbot <syzbot+b79be83906cd9bab16ff@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Oct 2024 at 08:40, Sabyrzhan Tasbolatov <snovitoll@gmail.com> wr=
ote:
>
> On Mon, Oct 14, 2024 at 11:08=E2=80=AFAM syzbot
> <syzbot+b79be83906cd9bab16ff@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    2f91ff27b0ee Merge tag 'sound-6.12-rc2' of git://git.ke=
rne..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D155c879f980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D95098faba89=
c70c9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db79be83906cd9=
bab16ff
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/14933c4ac457/d=
isk-2f91ff27.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/6725831fc1a1/vmli=
nux-2f91ff27.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/98d64e038e72=
/bzImage-2f91ff27.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+b79be83906cd9bab16ff@syzkaller.appspotmail.com
> >
> > loop4: detected capacity change from 0 to 4096
> > EXT4-fs: Ignoring removed nobh option
> > EXT4-fs: Ignoring removed i_version option
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KCSAN: data-race in xas_create / xas_find
> >
> > write to 0xffff888106819919 of 1 bytes by task 3435 on cpu 0:
> >  xas_expand lib/xarray.c:613 [inline]
> >  xas_create+0x666/0xbd0 lib/xarray.c:654
> >  xas_store+0x6f/0xc90 lib/xarray.c:788
>
> AFAIU, xas_store() itself, doesn't have a locking mechanism,
> but is locked in xa_* functions. Example:
>
> void *xa_store_range(...)
> {
>    XA_STATE(xas, xa, 0);
>    ...
>    do {
>       xas_lock(&xas);
>       if (entry) {
>       ...
>          xas_create(&xas, true);
>    }
> ...
> unlock:
>    xas_unlock(&xas);
> }
>
> Same thing is for the another racing xas_find() function:
>
> void *xa_find(...)
> {
>    XA_STATE(xas, xa, *indexp);
>    void *entry;
>    rcu_read_lock();
>    do {
>       if (...)
>          entry =3D xas_find_marked(&xas, max, filter);
>       else
>          entry =3D xas_find(&xas, max);
>       ...
>    rcu_read_unlock();
> }
>
> In this KCSAN report, xas_create() and xas_find() are racing for `offset`=
 field.

If you search the mailing list archives, there are several such
reports: https://lore.kernel.org/all/20230914080811.465zw662sus4uznq@quack3=
/
And have all been deemed benign.

The code might benefit from markings, per:
https://github.com/torvalds/linux/blob/master/tools/memory-model/Documentat=
ion/access-marking.txt

But that's entirely up to the maintainer's preference:
https://lwn.net/Articles/816854/

