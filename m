Return-Path: <linux-fsdevel+bounces-60218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9D0B42CD3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 00:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1032F7C67D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 22:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE202ED177;
	Wed,  3 Sep 2025 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3aKW2WI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6B33E7;
	Wed,  3 Sep 2025 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756938775; cv=none; b=krqWpPui4c27rQThfkyX3PjadHZUqxhAMRS0byMozPwd/NE59YqME5nT++b81/XVH949uP8QcgvmoajGkZbyyFfNtdQMg85KK0VDVTqzT/q8NCEeCM97BBLcQMzVDH5VWIHfIxgW+RHP0TQ6dw7/tzz5sM5TF7nXXrZpGAo4pCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756938775; c=relaxed/simple;
	bh=tb39vFh99hbLWiyWX4mAWbJtuRFGUGs+sZjpBFSL32M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NT/58YT3+9KHtSjC5OXJl2hL9NYKGTFZsKb2OXH/bYi5b2KgJu62+i5W7WOEqQwGq/5ymvHnoZhE89VHrqsLRM7s9XsteVMDgr3dZDE/rAHEMBEMfbhDpNvByKtRirsOAO/CP9PCZUsNT+DqUW3DIEN8kupRddXWAoII0Xi/YLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3aKW2WI; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-80e33b9e2d3so33123185a.2;
        Wed, 03 Sep 2025 15:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756938772; x=1757543572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl5ppucTkHboJuFREXiK6JnC1CL91JJQ8RTQr395/34=;
        b=g3aKW2WIzhsFHUWgQ3/rdIGWlpXX03eQ7uivbhlFJC0pn371uf6xdMHRDUMJGDS/2M
         4/DMT3b1YC7lOnWsi16sAFSO/dhOOBD31lne+lpbbBu8SQyZYpEYGeQQ7UccvL+bC8AS
         o5gdRMHHDy0YLSd3rYvDcdix65GTib48ABzlDJOeHUL8OKiOswObaw11kRdE4zhP+W9O
         Ui79+Cpy5p5hMJXA7cvP1heq7CWpBwBS7V+24h1A1NbATVCzKypvBeCQbrmbUJA0Lrhp
         rjk79koleiTL0oXiXZY/LoGQO+nvMebin3jYU7N73ptEngz3fGxFLImMi8+E7wO7zilr
         530Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756938772; x=1757543572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rl5ppucTkHboJuFREXiK6JnC1CL91JJQ8RTQr395/34=;
        b=mJCVeoKgpJdDXxqfI/8a73ndjsrVt+3y/b62MbJSEZm7+8IEvgSup69kviD2C+nzKf
         v/JZz+/YUWpmuhtOTejS5pxyY5cUF5NySuZyIc9DPGtPkVkeeuVMKzd0MvlUPW0/x3zX
         GRhaC50/gaFEfM/9XywUAEUAzI4rb3npE0pKHJrcJ+zFvDfiRax6bFxlQj4SP78/oUsx
         qxlEBEuS1eSocu8A2AMx+WaXJ7KDiWIiF+yy2SjDFNNek3Bje6hnTxxVE8zuO56aCCyo
         /rYNxXpO2wdR3hX+BV8BPkFNYV+EtRhyq7CUrkM/rHvd9wB/l6ZKkUKI+5ghVjyrAJvS
         MheA==
X-Forwarded-Encrypted: i=1; AJvYcCV9ThS5wduYLht/tINVSGBlbOmMrGXJObejjWhnOuLHv+BRK4P6kUFset9vRfvgILMMJOkuUPZIawjVDhtE@vger.kernel.org, AJvYcCVXQ+MefDe8DvICogU1ULtBNEOwTWAuiziTcpCwEEj36UXqB7u+u+3oaJhexvpUC4W56ycwspf+FfiwsQv7@vger.kernel.org
X-Gm-Message-State: AOJu0YwMNkb35r3r5F8tFfOfLcFVoJPe0EIGGcUvF1I8KpTJGaA/qQ9m
	LtBshcpx8AYfSpgGFbxfEys0lyfmajkuNzdVgaP3yWNqxVJqGcqQBtRpIIYlgcNFBS6Q/ji9mgX
	XASkgNV5XwfDs3nk11wMnhDQaHNM2S9FCuT/T
X-Gm-Gg: ASbGncv5I66N4OtijFx/5hZO5Y7PEatF1Zo4Darzp+Jk/+auw7+dASs0fWBNM6kfkjN
	dEdkfO9X5b+jWWRSXSs5X4/PfDj61DSum6iTstsNT7lLoyqelSQaWgpsExup7CPW5ASsDE56EeN
	Vo2o+6nA3NX+w8eFeYUq/kuqh35BadRvEyy3IrO9Og9NYY6yCD/vAQBv6nEae3z9B4xhABqKT9N
	eQ0DGMy
X-Google-Smtp-Source: AGHT+IEJGy+p5ZMDxjaeWyhsl7sPNb8pymVgA/7x5oMno/g1nPFtTRhWqFG/UZEFwOhI7o9ZuvfpgGghoOa7THLP2oI=
X-Received: by 2002:a05:620a:a10d:b0:806:cfb:843a with SMTP id
 af79cd13be357-8060cfb8488mr1229722085a.49.1756938772074; Wed, 03 Sep 2025
 15:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903083453.26618-1-luis@igalia.com> <CAJnrk1aWaZLcZkQ_OZhQd8ZfHC=ix6_TZ8ZW270PWu0418gOmA@mail.gmail.com>
 <87ikhze1ub.fsf@wotan.olymp> <20250903204847.GQ1587915@frogsfrogsfrogs>
In-Reply-To: <20250903204847.GQ1587915@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 3 Sep 2025 15:32:40 -0700
X-Gm-Features: Ac12FXx3LnJrOWXaGia6xhx1r_WP72pOHDCUclKDn8t-zmc4NE9O4Dsxh-hxt58
Message-ID: <CAJnrk1aa97AwixCq9+eGQT52LAfqL-S1Ci5fSUygfFOo-6kMHA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: prevent possible NULL pointer dereference in fuse_iomap_writeback_{range,submit}()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 1:48=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Wed, Sep 03, 2025 at 09:08:12PM +0100, Luis Henriques wrote:
> > On Wed, Sep 03 2025, Joanne Koong wrote:
> >
> > > On Wed, Sep 3, 2025 at 1:35=E2=80=AFAM Luis Henriques <luis@igalia.co=
m> wrote:
> > >>
> > >> These two functions make use of the WARN_ON_ONCE() macro to help deb=
ugging
> > >> a NULL wpc->wb_ctx.  However, this doesn't prevent the possibility o=
f NULL
> > >> pointer dereferences in the code.  This patch adds some extra defens=
ive
> > >> checks to avoid these NULL pointer accesses.
> > >>
> > >> Fixes: ef7e7cbb323f ("fuse: use iomap for writeback")
> > >> Signed-off-by: Luis Henriques <luis@igalia.com>
> > >> ---
> > >> Hi!
> > >>
> > >> This v2 results from Joanne's inputs -- I now believe that it is bet=
ter to
> > >> keep the WARN_ON_ONCE() macros, but it's still good to try to minimi=
se
> > >> the undesirable effects of a NULL wpc->wb_ctx.
> > >>
> > >> I've also added the 'Fixes:' tag to the commit message.
> > >>
> > >>  fs/fuse/file.c | 13 +++++++++----
> > >>  1 file changed, 9 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > >> index 5525a4520b0f..990c287bc3e3 100644
> > >> --- a/fs/fuse/file.c
> > >> +++ b/fs/fuse/file.c
> > >> @@ -2135,14 +2135,18 @@ static ssize_t fuse_iomap_writeback_range(st=
ruct iomap_writepage_ctx *wpc,
> > >>                                           unsigned len, u64 end_pos)
> > >>  {
> > >>         struct fuse_fill_wb_data *data =3D wpc->wb_ctx;
> > >> -       struct fuse_writepage_args *wpa =3D data->wpa;
> > >> -       struct fuse_args_pages *ap =3D &wpa->ia.ap;
> > >> +       struct fuse_writepage_args *wpa;
> > >> +       struct fuse_args_pages *ap;
> > >>         struct inode *inode =3D wpc->inode;
> > >>         struct fuse_inode *fi =3D get_fuse_inode(inode);
> > >>         struct fuse_conn *fc =3D get_fuse_conn(inode);
> > >>         loff_t offset =3D offset_in_folio(folio, pos);
> > >>
> > >> -       WARN_ON_ONCE(!data);
> > >> +       if (WARN_ON_ONCE(!data))
> > >> +               return -EIO;
> > >
> > > imo this WARN_ON_ONCE (and the one below) should be left as is instea=
d
> > > of embedded in the "if" construct. The data pointer passed in is set
> > > by fuse and as such, we're able to reasonably guarantee that data is =
a
> > > valid pointer. Looking at other examples of WARN_ON in the fuse
> > > codebase, the places where an "if" construct is used are for cases
> > > where the assumptions that are made are more delicate (eg folio
> > > mapping state, in fuse_try_move_folio()) and less clearly obvious. I
> > > think this WARN_ON_ONCE here and below should be left as is.
> >
> > OK, thank you for your feedback, Joanne.  So, if Miklos agrees with tha=
t,
> > I guess we can drop this patch.

I think having the two lines "wpa =3D data->wpa;" and "ap =3D &wpa->ia.ap"
moved to below the "WARN_ON_ONCE(!data);" would still be useful

>
> AFAICT, this function can only be called by other iomap-using functions
> in file.c, and those other functions always set
> iomap_writepage_ctx::wb_ctx so I /think/ the assertions aren't necessary
> at all...
>
> > Cheers,
> > --
> > Lu=C3=ADs
> >
> > >
> > >
> > > Thanks,
> > > Joanne
> > >
> > >> +
> > >> +       wpa =3D data->wpa;
> > >> +       ap =3D &wpa->ia.ap;
> > >>
> > >>         if (!data->ff) {
>
> ...because if someone fails to set wpc->wb_ctx, this line will crash the
> kernel at least as much as the WARN_ON would.  IOWs, the WARN_ONs aren't
> necessary but I don't think they hurt much.
>

Oh, I see. Actually, this explanation makes a lot of sense. When I was
looking at the other WARN_ON usages in fuse, I noticed they were also
used even if it's logically proven that the code path can never be
triggered. But I guess what you're saying is that WARN_ONs in general
should be used if it's otherwise somehow undetectable / non-obvious
that the condition is violated? That makes sense to me, and checks out
with the other fuse WARN_ON uses.

I'm fine with just removing the WARN_ON(!data) here and below. I think
I added some more WARN_ONs in my other fuse iomap patchset, so I'll
remove those as well when I send out a new version.

> You could introduce a CONFIG_FUSE_DEBUG option and hide some assertions
> and whatnot behind it, ala CONFIG_FUSE_IOMAP_DEBUG*:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/tree=
/fs/fuse/iomap_priv.h?h=3Ddjwong-wtf&id=3D170269a48ae83ea7ce1e23ea5ff399956=
00efff0
>

In that case, personally I'd much prefer removing the WARN_ONs here
than having a new config for it.

Thanks,
Joanne

> --D
>
> > >>                 data->ff =3D fuse_write_file_get(fi);
> > >> @@ -2182,7 +2186,8 @@ static int fuse_iomap_writeback_submit(struct =
iomap_writepage_ctx *wpc,
> > >>  {
> > >>         struct fuse_fill_wb_data *data =3D wpc->wb_ctx;
> > >>
> > >> -       WARN_ON_ONCE(!data);
> > >> +       if (WARN_ON_ONCE(!data))
> > >> +               return error ? error : -EIO;
> > >>
> > >>         if (data->wpa) {
> > >>                 WARN_ON(!data->wpa->ia.ap.num_folios);
> >
> >

