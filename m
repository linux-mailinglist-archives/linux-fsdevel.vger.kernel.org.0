Return-Path: <linux-fsdevel+bounces-16202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE05C89A0AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 17:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B251F22F7B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E9116F84B;
	Fri,  5 Apr 2024 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFFmoZoa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1015316EBF3;
	Fri,  5 Apr 2024 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329707; cv=none; b=RcxNkvjD2bX6U9mqRAiZg8TqpTRL9khWPga6Ip7KcibX97bGEUfenYKGZe21Bl0BccEjEwIb+OIrb6GS8gXxOSR5rnW0zIdaG45ETwNUsh7iCETzmilWZ8kbHSMRNxwRQBrTbFK6GUnoZ/c/Ga69jQHtWKG89uKTo6t42PgS32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329707; c=relaxed/simple;
	bh=8OTJYRkxJEPH+ieN+Wz+w9QPRHjkaVsc32knKowB3cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOkJ10xsY8bTODKtsWcZbH1mZhfVUXeDB7hS2N7BJjs3Yd/gJfXIZE7vWiftB9sTAXdUGBTUJQaTnLqMe1f0DqKOFbDs014N0va/OTVEiCp4Ft5StuLkRtdZKyd/5ZN2+BOZ9NvnCHg2gjs+p60gPAUeZbZuzsWVoIvQIDWzclo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFFmoZoa; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6993f39ac53so3839516d6.1;
        Fri, 05 Apr 2024 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712329705; x=1712934505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d56tBBvKhdU/LZ/YsQQXpTmVNEsS5p7VvT7fAO/irxw=;
        b=JFFmoZoa/Rptz37vqJ3VSqJU5RmAWxOJzIwnwNsGNLesESCpoucwCDPqHryReQklgf
         1cRZdoiBjv/ZkbR3lg/dUuBK1Qhm3RsfatEwYHyc+aX9LFZW7gqlJcNto5zk1Kfzxvo8
         uLQeMfe+Sgq+U4TCCglYRNQpx3Oti2/XoCMA2fmupPrQvAeGa5ezMcka1qqfY0dIo5fw
         7YM0dbQKGm6dx4Wx2UDlTiTxUDZEgaLbMLLOnU3+c7AMMCXXGPaIpGg+Pja/Umv7NmJe
         jP+uQDAzN0Of6ATgcOuI+vLRgMa5v2uxANdxvAA35Z7HXDQgFQqZJ1Y1NfkLhKxAZ5fK
         e/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712329705; x=1712934505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d56tBBvKhdU/LZ/YsQQXpTmVNEsS5p7VvT7fAO/irxw=;
        b=h3u+z8Zq2gQa58dJ0GVHu82wiFdwzeeh6ICDJdNYKiuVKZZwgiqXcxshd/5wUa2pEH
         x/GljFnlfkoCBg3v/VDWGL3QDk12ESEYwsu0t6PaMX1BGJz+Bn7GoR2yf2qsZdBsYEbG
         qts6UQbeilCTJE3+qq0Di1s4l+3crYWEHHOKVoHk23JagR38ekTgjF1KPQwd/TGHUK5b
         TYo6vD0bIgiH/vC8j+Udw7yNv31pwVhQl//XRaqicuDLdZLNr23Im6JMK68+HZDFykkY
         hc9/or64LHVJRW1wFEOIWtvUbx8ErUxKzxjv488PWcxKLEO5mM2ahtw36hM1SiJPNWwY
         SC5g==
X-Forwarded-Encrypted: i=1; AJvYcCXMmgpIqQ8IapK2xm9RpPH36YqWQOZkjW4GYg+huQt7WIxv/x3KP9PGbYKJdqTMaZ4y6uPRBDAtVn4GLqEtAPqHvZIBGkWdncoJCHpGKa0HTLo6GRw/CySvnYi1k1MSQ14lVDj2Bq50FU8Gkw==
X-Gm-Message-State: AOJu0YwCNbk57M+JLBbgB4R2r/NJOwMLsJ2u9ngndMzPSv1ojR0/g77N
	+zqQE20kZ6C+pGmnbezzXP4GAmMIHN/Q418NZ9Cfp7f5abE6Ol46K0YglyFo5e9/K+5JQ0fClKD
	C5MkS0znO8gwKXZx3j7lMybdKy0U=
X-Google-Smtp-Source: AGHT+IHsrzycOXlQkse5JPUfdRu4z8p9YwMV+DwDSeufk6DF3ue8UQQXBW6CwnVEK5l1XwTuje/F5xYnB/KwXUA3A5Y=
X-Received: by 2002:a05:6214:20aa:b0:696:4256:9fa6 with SMTP id
 10-20020a05621420aa00b0069642569fa6mr1916749qvd.26.1712329704925; Fri, 05 Apr
 2024 08:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000098f75506153551a1@google.com> <0000000000002f2066061539e54b@google.com>
 <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com>
In-Reply-To: <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Apr 2024 18:08:13 +0300
Message-ID: <CAOQ4uxhm5m9CvX0y2RcJGuP=vryZLp9M+tS6vH1o_9BGUqxrvg@mail.gmail.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
To: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	valesini@yandex-team.ru, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 9:54=E2=80=AFAM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Thu, Apr 4, 2024 at 2:51=E2=80=AFAM syzbot
> <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this issue to:
> >
> > commit 0fedefd4c4e33dd24f726b13b5d7c143e2b483be
> > Author: Valentine Sinitsyn <valesini@yandex-team.ru>
> > Date:   Mon Sep 25 08:40:12 2023 +0000
> >
> >     kernfs: sysfs: support custom llseek method for sysfs entries
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17cb5e03=
180000
> > start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.ker=
nel..
> > git tree:       upstream
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D142b5e03=
180000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D102b5e03180=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4d90a36f0ca=
b495a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D9a5b0ced8b1bf=
b238b56
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17f1d93d1=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15c38139180=
000
> >
> > Reported-by: syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com
> > Fixes: 0fedefd4c4e3 ("kernfs: sysfs: support custom llseek method for s=
ysfs entries")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
> >
>

Let's test Al's solution.

#syz test: https://github.com/amir73il/linux/ vfs-fixes

Thanks,
Amir.

