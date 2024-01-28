Return-Path: <linux-fsdevel+bounces-9237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BD083F4EE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 11:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A700A1F21ADF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 10:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14282171AB;
	Sun, 28 Jan 2024 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lqe0JbpY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1623C1DFEB;
	Sun, 28 Jan 2024 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706436732; cv=none; b=duwobisfg3Gs/jDecv4AC1o4x6jeo15JQjmf4Yqut7UYN5GSDSoVuM4e7xZ+qd9bfHxJtFy4mhd1rO+HTDk1r5wnT1lBxSrCf74wadxVssrwpcsxE3XgJsVgZlOJgTtZIXcVt+lksBs+FYoySLGtDzRS15QAB3AhpnFVZvj/Gq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706436732; c=relaxed/simple;
	bh=mCoAPlVmO/9vSpNsBEHIAWFIC2QNuikQwdXZmb3c91E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxT6ebxOTbJ2Hy3msMMfdlvZbbtJJfksVzt4upkG7JGUxgK6dz67sboKtv/mmFCmeFufSRB8aDQ6eS4j0kKTXCkxkSITSlfhH7Hpbke0aK/hDKcKTMQK34l9b0N0jNXUYONi/Ega+EvyDg3xAuKNQG+//27iSZJ/fNy6HaJl9bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lqe0JbpY; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42a8a3973c5so10846381cf.2;
        Sun, 28 Jan 2024 02:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706436730; x=1707041530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mO33kD1qCH+Xc/yFNRT1niS7MhTMqAIfmIanUTcJPKk=;
        b=Lqe0JbpYIlDxOE3l4FQHIh0JzPJXzT9VjicuSk+BmxT8jh9q3kLFZ6WQD9goC/uvpO
         uO4xxUKviL4Yj8VcsHleavDikUijzUm5+PfNEX3FpGxgovo6onUlWzRLrX+5DR0PR0jC
         p84c2+wU44wfs5eE4BIZwh0rczfl4V476K1er4oGK93Y4lrbv5WrL62JGPp4v8UW5h9C
         L8BV1uxpSD/uNik7+aQzG56afMnr9hLcBQnkPdAe5xL/908XyfQn8AIvowlR9ZlYYVMf
         urLgsG1kLA351gwY/tryBWudU14ac5+wVzTXwrfLXbJ+ckOQW1oKjZgqps0XulT/nn1p
         wzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706436730; x=1707041530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mO33kD1qCH+Xc/yFNRT1niS7MhTMqAIfmIanUTcJPKk=;
        b=u3jbAKn8iZ8qpcQI4j/Wgc0z8C5CWG4/UtFhKS1z+hXEMr+pBw2LGU/ZsXR8yGF42d
         6/HFVN4zBKmc3izSQDCmTfs5EGzWCQz9665cdFgWTRGCrTDkfV1Z6fhhZ1jLwjenMEP7
         ctfCE37Akp5KVJX8PC3I4vpPnJ77tNPlzvrdgfII317W17f1U9G74F+YNj3yJjpJbzzu
         52wIWIPNb4/1Kk8+YHdXLTb/IaP7AKAFtNYFIRKW1LMMoh9Vb1kGjo0dN/wIFrNFQRR3
         PfYGPP/aOCs2af1lwhpAuLvyTI2oJfl7j8hQ8M+mDVypt6oJS0dUgbbAYnMYVnRDndGj
         5xag==
X-Gm-Message-State: AOJu0YwHr6ilD45sTJoPNYiizuro7bQMlSUm+ZDJY3CrX0juyx1SurIU
	QCe31i6v56VsK/teR/x1Azxjcegd8BPuccFjRhGJIx5ve04ruoESiOQ6CHeOstkdJidlVU2/F4/
	r6OwROTA9dL40bduXgozGYnYv9q4=
X-Google-Smtp-Source: AGHT+IGEQyN89e2gKXZ2v54m8Uh1CP51MaZEK3vyrIpJ46WZV8MmymronXm9dKbYWX8CBxq0YBMAeTEl36GwPqh1qWc=
X-Received: by 2002:a05:6214:cc9:b0:686:955c:f70e with SMTP id
 9-20020a0562140cc900b00686955cf70emr3851961qvx.6.1706436729859; Sun, 28 Jan
 2024 02:12:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000e171200600d6d8bd@google.com> <000000000000910cf5060fe42991@google.com>
In-Reply-To: <000000000000910cf5060fe42991@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 28 Jan 2024 12:11:58 +0200
Message-ID: <CAOQ4uxg-nL69cbs8J4xmOd=EAQTiB-cfWgZR0TvY+hb144nZSA@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] possible deadlock in seq_read_iter (2)
To: syzbot <syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, dhowells@redhat.com, hch@lst.de, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 4:28=E2=80=AFAM syzbot
<syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit da40448ce4eb4de18eb7b0db61dddece32677939
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Thu Nov 30 14:16:23 2023 +0000
>
>     fs: move file_start_write() into direct_splice_actor()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D105aa1a018=
0000
> start commit:   2cf4f94d8e86 Merge tag 'scsi-fixes' of git://git.kernel.o=
r..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3De5751b3a22261=
35d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dda4f9f61f96525c=
62cc7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D176a4f49e80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D154aa8d6e8000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: fs: move file_start_write() into direct_splice_actor()

Yes. I already wrote that this work is going to fix this repro
as well as other potential deadlocks.

#syz fix: fs: move file_start_write() into direct_splice_actor()

Thanks,
Amir.

