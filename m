Return-Path: <linux-fsdevel+bounces-13591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7B6871A34
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 11:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEDF1C20EC5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 10:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F046548F0;
	Tue,  5 Mar 2024 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSw+9Dxf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961475381E
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633243; cv=none; b=UFGp7OezAS+5uPK7anLnoXKR+iDtRpOcfNEym2J4U2ORqXqiI8NjpHBKVQV7tnZaoXrOKTgL2yGhPUF122DfhACpNAvfyd1lO0wT/3D610ycxJ6/DBrS+cxYkkKQCFze0WXoCV2AZAxJ7ML40JablLkOGya1eCOLuaW0cpYigwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633243; c=relaxed/simple;
	bh=tmWvhUXEZZ3pBn0rRhtM8Nj4vDkTWD01IJZIJla18XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7CBJPoQ86a6zQTo8YCnPmJn+hW7u037SxXhZZqJZIOdWNLAQ9+CLTqbWtZDVztvkzOhj78CmVG20wasH5oUKWpqUL6whBVbDOD5jaYWt57kBZ2wcs1kcKoJhPuAGN6CpKm8jzPuxD2y2tBxvTNx+XTe1O9ui6aPKdpzZ/OVxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSw+9Dxf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709633240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LvzkgpPOzZwlEgXOsRWtL0iyRGHSE/p12vv2dYEEWM=;
	b=bSw+9DxfIsOAJTcWCtJ/9MvkfrOHj80n2yg6eyqyAzsjFqk+uROj1GnM0FYGUNKOtwtgIN
	d/6N8UJ7k9LsRmGsfYoqOO1nQCyu4OsdMdPlKRqAu5wztVvSOdmEpcMDmlXvHClUAz8/lN
	wPa8WQ3BX0/ghpoMv/cAXPR0iOQcvAU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-tCGw7R8fNeW2zsbUghBNbw-1; Tue, 05 Mar 2024 05:07:19 -0500
X-MC-Unique: tCGw7R8fNeW2zsbUghBNbw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1dccac85165so56224705ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 02:07:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633237; x=1710238037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LvzkgpPOzZwlEgXOsRWtL0iyRGHSE/p12vv2dYEEWM=;
        b=RVTY2gAt9xqyuuG7S/pw/XPj6BkT+/SAfpRh8QvFCT6r5TDwIJDtZ/TNRDvjEOlpuv
         4K3YNRxRRKIb+WfjGJbj8xvW/lgRVnnnIXx929kFXRAIj4PsO5pA8PDPm0kFLKdVkJoz
         3LKgPRDYUzlp3X3A9La7TOektCD4vkFXnKPrgpLPI232vDTPQynDkDHObMiTm5LHrywZ
         gUApghv2kSpjvu+Peln/jFjTmBApvMkPmaqSlbLFdC0wgGN0ra4w0sOLCPcAGHNUBikZ
         GFNKqjfza1dJXhXnFkfh57Phvg5w7HZXDe5vsNyyTe47z8uj7lvwFt2phyuOxQywUz9i
         3adg==
X-Forwarded-Encrypted: i=1; AJvYcCVDkZa7oc3nOtVBdY9rUY8KIYJ1BoYuiuOZdv2bNFRWtZjccuSA5YmVvGMhSDod8rmz3l7UsdBQjVlODRrg4Fu8K+WUxtidJJitlHa+Ww==
X-Gm-Message-State: AOJu0Yxas3AvE3887K9P4WdWmRgrWo6x9wFAABYAFPvEHiLg3k17TFqI
	Wlab0ZDFBgSXyx4ySflnqtRZ2mhObci0DXXfm4+/vubgE7Oo0hiDVfsqrKVo3qS/T73PqIsYTE0
	R7JRvDNBsiewPXVInwNIf7Hys8lONM4T1jxqX7ZlEMRLxpYZYXS/KYAqrwXC1kSDuqS38xu68ML
	Z43XBbrLsuyzI+6Jr41zyHbADuPpoJNAcxt6GhrtoFdUAIwa1U
X-Received: by 2002:a17:902:ce8d:b0:1dc:b320:60d2 with SMTP id f13-20020a170902ce8d00b001dcb32060d2mr1446802plg.33.1709633236854;
        Tue, 05 Mar 2024 02:07:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMv6QAUQFA2PQMt09dU18T+73TTHk4Z3gqozQBVsQrgdPPOTCB2inQqNxcby7aXzwG2tWIwk4xFqDbjP3soXg=
X-Received: by 2002:a17:902:ce8d:b0:1dc:b320:60d2 with SMTP id
 f13-20020a170902ce8d00b001dcb32060d2mr1446786plg.33.1709633236559; Tue, 05
 Mar 2024 02:07:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000c925dc0604f9e2ef@google.com> <0000000000000c6e0a0612e6bd58@google.com>
In-Reply-To: <0000000000000c6e0a0612e6bd58@google.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 5 Mar 2024 11:07:05 +0100
Message-ID: <CAHc6FU5ynRASxSQDYPMZ7FHuOmjxPbqe0E+TTJEc19+ArJby0Q@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] BUG: sleeping function called from invalid
 context in gfs2_withdraw
To: syzbot <syzbot+577d06779fa95206ba66@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com, 
	yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 10:48=E2=80=AFAM syzbot
<syzbot+577d06779fa95206ba66@syzkaller.appspotmail.com> wrote:
> syzbot suspects this issue was fixed by commit:
>
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
>
>     fs: Block writes to mounted block devices
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D119f927a18=
0000
> start commit:   6465e260f487 Linux 6.6-rc3
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8d7d7928f7893=
6aa
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D577d06779fa9520=
6ba66
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10dbcdc1680=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17a367b668000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: fs: Block writes to mounted block devices

Sounds reasonable:

#syz fix: fs: Block writes to mounted block devices

Andreas


