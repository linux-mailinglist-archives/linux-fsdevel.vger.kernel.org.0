Return-Path: <linux-fsdevel+bounces-30311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53A19893C2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 10:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82201B2379B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 08:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C59513C9A3;
	Sun, 29 Sep 2024 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNgHeWOw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBF5F9CF;
	Sun, 29 Sep 2024 08:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727598627; cv=none; b=WvSUw+STaif+hxbo3yn3Qtya6bS+HC4HSGgyTHc3yT93JLjNLXkgaqgAN9bAF9NxaS9pS35LHaoGYj60o+7vVH8XZzA6a0e3N6nq2sLfgWG+U4Yeldj37edfE5Jq4ff9jEagyaNVpx9MqGYUOyS/hwJde4P9S6Dg9ECPsulqsJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727598627; c=relaxed/simple;
	bh=hmUs0GdfxyuCzAbqNxBCaF2AGSPRpqOhupSHuBWEgDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fY6PaRtpEmMgUZI3cOqZQ6xC34XUeAyyuy9vk0gdTR4q67a63A/KKrYA0ZvjAr4x3MIcJArJYSa2j4VPKm1jXHaWkNi98AbOoDH/V3U4G99Wx+alUxVdI+YT8R+VS7ElXwEgwgflKp+srwPBSW5pluz+JTYqWMubSFSY5cJDY5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNgHeWOw; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2facaa16826so1889791fa.0;
        Sun, 29 Sep 2024 01:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727598624; x=1728203424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtfQ8PjVBIqC5x6Ptii/ji6tl6SwiydJhKrTqRkluSY=;
        b=jNgHeWOwI62HIY6dXe6OFJGE6i9uFIK+MpIQrucGrMoYMu4Ov2c8aNizHe1Rnq770C
         ET9r5RuxikieGZvAsfNF9Q6pA9LjBGdOrkfFwmbDMG+ggp2izr1Z7MHwBKiIDaO6e4Uj
         4uUa6yPQeWlycMC+2M+8dCqnd6mSIkQA7/p7W+g4RDNnCPxFekRN5inTn5jP0HG18KLD
         I49dK2dIbpGRJas4+mjzZlAPg5Ii2ehylboGwuakSu2CCuttnllzPUGKby3M7RY644c0
         t9l8cng7UwHaKBA6ewYfgWXKxCjBk7hcdUt07iXAgkDVXLfuwlxPJ4BItGC+ehTxohG6
         AiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727598624; x=1728203424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtfQ8PjVBIqC5x6Ptii/ji6tl6SwiydJhKrTqRkluSY=;
        b=fMGYhgJ8qa/4DRrS2WI3A0R2nuVrsLMbdjPJ04ZtVkyn79vs8zNH16cD1iMwHMMzQu
         HFxnnjd0mZU4aXwROjGz9O28lf4KMvvki1v/V2YA+2OC29oggK6WLlPJekvx7K2ep+Bv
         nxVQ+RMQp7IK23ozfk9qJgSVVPTskkUVmbr+3IWtinIuNH1oeZRQbau2MhTE+uUx0ilo
         B0Gt3moVMyMLc28tB2gWehsgXUbsv+bEzbR0rBiiWE4u432d0rc1/dExw/dy6/aynGdg
         MsEiDGdRvhv58jTT/NAQmhXFeH/yrYw7lAPxJlYTx5bZxm9Y8LD4Bi/phJZxpQtHWWqV
         ss9A==
X-Forwarded-Encrypted: i=1; AJvYcCXWzhCuO52nonADX98SzyPaWZMvZVbLwMgR5qt0UpBhbw1SH4envTPYCkuVmfnnQUHuH5wE46/FK38=@vger.kernel.org
X-Gm-Message-State: AOJu0YylewPqS55INkx2MIVUu9l9IDP4uYx2Q6+jI4XVNAGzaaYy8scQ
	oD7Z88NDlv9zv4WL/N/jrF6tJKq9n2vPwHBH0BEqAcLG7+jLYW2/Cw1XX4y0kh+XIZ7VjqQwlKT
	JCzfD/F/QjEOA9yjMyMf3FqxXxwk=
X-Google-Smtp-Source: AGHT+IHD6DwTrsgbtaWY8g0IRkeuPLtO//m0DIce8g2mLe7kG+RSz0ObZMACtx390B1vwoLp0Nf42VG5qMRJZ3enjfs=
X-Received: by 2002:a05:6512:1113:b0:52f:d69e:bb38 with SMTP id
 2adb3069b0e04-5389fc3312fmr4933272e87.2.1727598623394; Sun, 29 Sep 2024
 01:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927065344.2628691-1-sunjunchao2870@gmail.com> <20240928044358.GV21877@frogsfrogsfrogs>
In-Reply-To: <20240928044358.GV21877@frogsfrogsfrogs>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Sun, 29 Sep 2024 16:30:12 +0800
Message-ID: <CAHB1NahOXEHrzkcNM4GFWoC_sH5Ru-wajDeciFKgaD=+7w=UVQ@mail.gmail.com>
Subject: Re: [PATCH v2] xfs: do not unshare any blocks beyond eof
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, hch@lst.de, 
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com, 
	Dave Chinner <david@fromorbit.com>, xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Darrick. Thanks for your review and comments.

Darrick J. Wong <djwong@kernel.org> =E4=BA=8E2024=E5=B9=B49=E6=9C=8828=E6=
=97=A5=E5=91=A8=E5=85=AD 12:44=E5=86=99=E9=81=93=EF=BC=9A
>
> [cc linux-xfs]

Sorry for missing the CC to the XFS mailing list...
>
> On Fri, Sep 27, 2024 at 02:53:44PM +0800, Julian Sun wrote:
> > Attempting to unshare extents beyond EOF will trigger
> > the need zeroing case, which in turn triggers a warning.
> > Therefore, let's skip the unshare process if blocks are
> > beyond EOF.
> >
> > This patch passed the xfstests using './check -g quick', without
> > causing any additional failure
> >
> > Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotma=
il.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D296b1c84b9cbf306e5a0
> > Fixes: 32a38a499104 ("iomap: use write_begin to read pages to unshare")
> > Inspired-by: Dave Chinner <david@fromorbit.com>
> > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > ---
> >  fs/xfs/xfs_iomap.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > index 72c981e3dc92..81a0514b8652 100644
> > --- a/fs/xfs/xfs_iomap.c
> > +++ b/fs/xfs/xfs_iomap.c
> > @@ -976,6 +976,7 @@ xfs_buffered_write_iomap_begin(
>
> I'm unsure about why this correction is in
> xfs_buffered_write_iomap_begin.  If extent size hints are enabled, this
> function delegates to xfs_direct_write_iomap_begin, which means that
> this isn't a complete fix.

My understanding is that xfs_get_extsz_hint() return a nonzero value
only involving realtime dev/inodes, right?
If that is true, and reflink is not supproted with realtime devices,
then fallocate unshare will directly return 0 within
xfs_reflink_unshare() for rt dev/inodes. Furthermore,
xfs_get_extsz_hint() will always return zero for non-rt dev/inodes,
which means that fallocate unshare will never enter
xfs_direct_write_iomap_begin().

I reviewed the code for xfs_direct_write_iomap_begin(), and there is
no handling of IOMAP_UNSHARE, just as xfs_buffered_write_iomap_begin()
has done. Perhaps this is the reason?
>
> Shouldn't it suffice to clamp offset/len in xfs_reflink_unshare?

Possible makes sense. However, as Christoph mentioned here[1] where I
did this in xfs_reflink_unshare(), we should consider the last block
if file size is not block aligned. IMO, it's more elegant to do it in
iomap_begin() callback...

If there's any misunderstanding or if I missed something, please let
me know, thanks!

[1]: https://lore.kernel.org/linux-xfs/Zu2FWuonuO97Q6V8@infradead.org/
>
> --D
>
> >       int                     error =3D 0;
> >       unsigned int            lockmode =3D XFS_ILOCK_EXCL;
> >       u64                     seq;
> > +     xfs_fileoff_t eof_fsb;
> >
> >       if (xfs_is_shutdown(mp))
> >               return -EIO;
> > @@ -1016,6 +1017,13 @@ xfs_buffered_write_iomap_begin(
> >       if (eof)
> >               imap.br_startoff =3D end_fsb; /* fake hole until the end =
*/
> >
> > +     /* Don't try to unshare any blocks beyond EOF. */
> > +     eof_fsb =3D XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
> > +     if (flags & IOMAP_UNSHARE && end_fsb > eof_fsb) {
> > +             xfs_trim_extent(&imap, offset_fsb, eof_fsb - offset_fsb);
> > +             end_fsb =3D eof_fsb;
> > +     }
> > +
> >       /* We never need to allocate blocks for zeroing or unsharing a ho=
le. */
> >       if ((flags & (IOMAP_UNSHARE | IOMAP_ZERO)) &&
> >           imap.br_startoff > offset_fsb) {
> > @@ -1030,7 +1038,6 @@ xfs_buffered_write_iomap_begin(
> >        */
> >       if ((flags & IOMAP_ZERO) && imap.br_startoff <=3D offset_fsb &&
> >           isnullstartblock(imap.br_startblock)) {
> > -             xfs_fileoff_t eof_fsb =3D XFS_B_TO_FSB(mp, XFS_ISIZE(ip))=
;
> >
> >               if (offset_fsb >=3D eof_fsb)
> >                       goto convert_delay;
> > --
> > 2.39.2
> >


Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

