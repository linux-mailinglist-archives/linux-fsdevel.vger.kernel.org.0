Return-Path: <linux-fsdevel+bounces-623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69BA7CDB07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 13:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89796B211FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 11:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0246335A5;
	Wed, 18 Oct 2023 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlWAylwo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF02E63E
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 11:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF67C433C7;
	Wed, 18 Oct 2023 11:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697630106;
	bh=kouUTomVRzr7+i4EflHX4+HRDMLMZ32DMLiuSrpZcr4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tlWAylwoWt9UwBsG6597itkE7ntW1+/H7s9JPrA3jTSumJNKZiz2ZrGbxjxRcUDoq
	 rLE85Z0hQNvClI0CTM/s/mQKQmRQR4aUxflm8V01W77qvbiT06Uaax8kRiot22Gsih
	 wVgE4Urw7D92iNwUUMzNvU2K58b1suqibPJ76hzYTnDoR0O3fXCk2FIcciFFw18ABK
	 VhkBJVfjHCEh2HV1KGzyS0k0cWLeHbxQnQmjCoG88xuZQjC+7Pi729swy5WEdKYFAA
	 xpkaQZGAfFscaRKbUds18xIiCroZcfr//M5wP/7msxi8ubKHEjl0Ekd6Fz0oqgNnsi
	 d/HSQJSVJbxsQ==
Message-ID: <d727d2c860f28c5c1206b4ec2be058b87d787e4f.camel@kernel.org>
Subject: Re: [PATCH] fat: fix mtime handing in __fat_write_inode
From: Jeff Layton <jlayton@kernel.org>
To: Klara Modin <klarasmodin@gmail.com>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Christian Brauner
	 <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date: Wed, 18 Oct 2023 07:55:04 -0400
In-Reply-To: <CABq1_vhoWrKuDkdogeHufnPn68k9RLsRiZM6H8fp-zoTwnvd_Q@mail.gmail.com>
References: <20231018-amtime-v1-1-e066bae97285@kernel.org>
	 <CABq1_vhoWrKuDkdogeHufnPn68k9RLsRiZM6H8fp-zoTwnvd_Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Many thanks for the bug report and testing! Do you mind if we add your
Tested-by: for this patch?

Thanks!
Jeff

On Wed, 2023-10-18 at 13:44 +0200, Klara Modin wrote:
> I can confirm that this patch fixes the issue, thanks!
>
> Den ons 18 okt. 2023 kl 13:15 skrev Jeff Layton <jlayton@kernel.org>:
> >=20
> > Klara reported seeing mangled mtimes when dealing with FAT. Fix the
> > braino in the FAT conversion to the new timestamp accessors.
> >=20
> > Fixes: e57260ae3226 (fat: convert to new timestamp accessors)
> > Reported-by: Klara Modin <klarasmodin@gmail.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > This patch fixes the bug that Klara reported late yesterday. The issue
> > is a bad by-hand conversion of __fat_write_inode to the new timestamp
> > accessor functions.
> >=20
> > Christian, this patch should probably be squashed into e57260ae3226.
> >=20
> > Thanks!
> > Jeff
> > ---
> >  fs/fat/inode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> > index aa87f323fd44..1fac3dabf130 100644
> > --- a/fs/fat/inode.c
> > +++ b/fs/fat/inode.c
> > @@ -888,9 +888,9 @@ static int __fat_write_inode(struct inode *inode, i=
nt wait)
> >                 raw_entry->size =3D cpu_to_le32(inode->i_size);
> >         raw_entry->attr =3D fat_make_attrs(inode);
> >         fat_set_start(raw_entry, MSDOS_I(inode)->i_logstart);
> > +       mtime =3D inode_get_mtime(inode);
> >         fat_time_unix2fat(sbi, &mtime, &raw_entry->time,
> >                           &raw_entry->date, NULL);
> > -       inode_set_mtime_to_ts(inode, mtime);
> >         if (sbi->options.isvfat) {
> >                 struct timespec64 ts =3D inode_get_atime(inode);
> >                 __le16 atime;
> >=20
> > ---
> > base-commit: fea0e8fc7829dc85f82c8a1a8249630f6fb85553
> > change-id: 20231018-amtime-24d2effcc9a9
> >=20
> > Best regards,
> > --
> > Jeff Layton <jlayton@kernel.org>
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

