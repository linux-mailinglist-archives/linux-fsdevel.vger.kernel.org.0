Return-Path: <linux-fsdevel+bounces-17088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E818A78A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 01:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4C7282E61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 23:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB97713A894;
	Tue, 16 Apr 2024 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9fOjStt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA54AEE9;
	Tue, 16 Apr 2024 23:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713310707; cv=none; b=NMg7AnGvgBXzrPO0HY8eorxRCKoCVUYFfihW714vx5Uu9bGavpWcSAz+AL5SJqx2fZn84RnCP4Xre9vsddaTwZf+BVuL4eDQEbWFNMHZkV/7yt1Y8j+HOdWpORZLtF9w04PImbs7SksNk3eG+eIW9ozMaQNcM03PkaPVp3H1ju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713310707; c=relaxed/simple;
	bh=X610+sNJI8FMaAeRTOdd7+DjjBHt0Eg6QzTcPtUj/yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qv+oufj9FFRPlRtUqml9emSMk6hGV2Xo0AGU3qM634RP5P9nnwKLa+jFnzIHKonOMhG+hCoGQ29bYxE/Qa7wY7WIX1WMS58NvjYgatZLIov45fqe4lgTDUc+Yx1d2/mwzLQvvqjpqs11pxoM4QTLI6qFAab+QA/koRqZczM+biI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9fOjStt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7CDC113CE;
	Tue, 16 Apr 2024 23:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713310706;
	bh=X610+sNJI8FMaAeRTOdd7+DjjBHt0Eg6QzTcPtUj/yM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z9fOjSttTz6t3HrcUirQXxY6ARYaZOuD+Duc/HAYF2cSpeVz2TiYu58MsGLp5Ha+L
	 jNVQK5RMw/yukLX9ZR6Df1QRq824G2D5gqaLq3KkhCr2gBc+xe7ywCZtz5SOX7plYQ
	 TCy1OOjkNiVb6qHAJzofkwNaExrxiEWUZkmLnExXP2c+CF7y/4IG8grbNTNxLDebHR
	 MP6Z+WN5THcfI9zsTwhHqX7/v5fii1NbBc/WzGGMx88VX7HHFol+SrqIkfnmIEZDu4
	 FBHBYgvum0DEEwAMJpVoO7oXN8T1W9A1sbgP5B1NKrUZ/uKM2nJXpFKMIppH1hfwSU
	 xFQsBJSGptACA==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bbd6ea06f5so185182b6e.1;
        Tue, 16 Apr 2024 16:38:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpo/XRgyIryt0RhbRe7/ufgnT+SRkfDZjNcx/bFzk0xJlVtmmj2WpVItwNrRL08EY1pHyxOMIc9/drfTpXJPZU1Z24RyMSnrCViA0zwGRNUtZX/L0LqkHX8NuaqkIy6IOnFNkI2UcWUv0oWA==
X-Gm-Message-State: AOJu0Yy7kaSKS69ltsDe26F0pi6kuJhOgH764U2dmKIGUNioWKfqp1ih
	2kBHN11sZcOSG+btJvags3mpFFTTRIelOJ1QHtEqzjrUSJiYsVs2OeNcUDiGnEFvcl/ijjc3kNK
	M/ToyVWsLH63y/7FOcKy1JfTPBJc=
X-Google-Smtp-Source: AGHT+IGLHw02QuJoUe1h4tht3h/r8lOSVIlHuWF8RGTAvSq3mUdvi6f1umYqSBOvTHJKucOim4NV1/qNf+6vS6/AepE=
X-Received: by 2002:a05:6808:2013:b0:3c7:2d71:6272 with SMTP id
 q19-20020a056808201300b003c72d716272mr272428oiw.29.1713310706173; Tue, 16 Apr
 2024 16:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000145ce00616368490@google.com> <Zh8DP48j0ECw5BeN@dread.disaster.area>
In-Reply-To: <Zh8DP48j0ECw5BeN@dread.disaster.area>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 17 Apr 2024 08:38:15 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_1v7sCwy0UYiixXOBA7xUkQK0EPtJcLOC0LYuJ9cHyfg@mail.gmail.com>
Message-ID: <CAKYAXd_1v7sCwy0UYiixXOBA7xUkQK0EPtJcLOC0LYuJ9cHyfg@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] possible deadlock in exfat_page_mkwrite
To: Dave Chinner <david@fromorbit.com>
Cc: syzbot <syzbot+d88216a7af9446d57d59@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 4=EC=9B=94 17=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 8:02, D=
ave Chinner <david@fromorbit.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Apr 16, 2024 at 06:14:20AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    66e4190e92ce Add linux-next specific files for 20240416
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15817767180=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc247afaa437=
e6409
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd88216a7af944=
6d57d59
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/86891dae5f9c/d=
isk-66e4190e.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/1ca383660bf2/vmli=
nux-66e4190e.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/bf6ff37d3fcc=
/bzImage-66e4190e.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+d88216a7af9446d57d59@syzkaller.appspotmail.com
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > WARNING: possible circular locking dependency detected
> > 6.9.0-rc4-next-20240416-syzkaller #0 Not tainted
> > ------------------------------------------------------
> > syz-executor.0/17125 is trying to acquire lock:
> > ffff88805e616b38 (&sb->s_type->i_mutex_key#24){++++}-{3:3}, at: inode_l=
ock include/linux/fs.h:791 [inline]
> > ffff88805e616b38 (&sb->s_type->i_mutex_key#24){++++}-{3:3}, at: exfat_p=
age_mkwrite+0x43a/0xea0 fs/exfat/file.c:629
>
> exfat_page_mkwrite() is taking the inode_lock() in the page fault
> handler:
>
>         folio_lock(folio);
>         .....
>         if (ei->valid_size < folio_pos(folio)) {
>                 inode_lock(inode);
>                 err =3D exfat_extend_valid_size(file, ei->valid_size, fol=
io_pos(folio));
>                 inode_unlock(inode);
>                 if (err < 0) {
>                         ret =3D vmf_fs_error(err);
>                         goto out;
>                 }
>         }
>
> This is can deadlock in a couple of ways:
>
> 1. page faults nest inside the inode lock (e.g. read/write IO path)
> 2. folio locks nest inside the inode lock (e.g. truncate)
> 3. IIUC, exfat_extend_valid_size() will allocate, lock and zero new
> folios and call balance_dirty_pages_ratelimited(). None of these
> things should be done with some other folio already held locked.
>
> As I've previously said: doing sparse file size extension in page
> fault context is complex and difficult to do correctly. It is far
> easier and safer to do it when the file is actually extended, and in
> that case the context doing the extension takes the perf penalty of
> allocaiton and zeroing, not the downstream application doing mmap()
> operations on the (extended) file....
Okay, Let me take a look.
Thanks for your comment.
>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com

