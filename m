Return-Path: <linux-fsdevel+bounces-4861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229EC80506E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 11:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A1B1C20E21
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 10:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C9754BD0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="I43bvoYv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379E6AA;
	Tue,  5 Dec 2023 01:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701769821; x=1702374621; i=spasswolf@web.de;
	bh=PMUhOSPrIqO2nFBmzfdsWI9k8eQHrXY07i+nV1Od4lY=;
	h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:
	 References;
	b=I43bvoYvg0jQ2LjQbNPWfiBB/2lsdQYfrTAtuiIe4YWldsiRu1XtYQqAFVK1BSSH
	 ObzIy3uyegplEjem76S6OzWbho/tyMB2VlQKcRDCccM9yAGmFTEfaXOu0hWebJ83t
	 VUOiMeI6H5mvNpDf6ajGZCuRVMZvFeZ+WgM7cZa4zyASELdVtsPC5I3L2skJ64jPC
	 +IAooHVg+l3A78atP0KTL8GJoR1SG6LDs5vnfQLf0qclBJKXUMTvxS125oUrLnZYW
	 AScmQPLtwK4+koFZ4dKqtGzUQx3Th1GxrcEKyNA8cUbcRcC4MbSRsD2kH0xjuxvKF
	 RNclPacGRS3kcL/Wjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MA4fI-1qysI32fyE-00Bb8H; Tue, 05
 Dec 2023 10:50:21 +0100
Message-ID: <b0803db66dfd4816b21d78bcbccefdb75318444d.camel@web.de>
Subject: Re: [PATCH] fs: read_write: make default in vfs_copy_file_range()
 reachable
From: Bert Karwatzki <spasswolf@web.de>
To: Amir Goldstein <amir73il@gmail.com>, Christian Brauner
 <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, axboe@kernel.dk, dhowells@redhat.com,
 hch@lst.de,  jlayton@kernel.org, josef@toxicpanda.com,
 linux-fsdevel@vger.kernel.org,  miklos@szeredi.hu, viro@zeniv.linux.org.uk,
 linux-kernel@vger.kernel.org
Date: Tue, 05 Dec 2023 10:50:20 +0100
In-Reply-To: <CAOQ4uxg-4NSysxmviKxDhnrA5P455T074ku=F24Wa5KJnCgspQ@mail.gmail.com>
References: <20231130141624.3338942-4-amir73il@gmail.com>
	 <20231205001620.4566-1-spasswolf@web.de>
	 <CAOQ4uxiw8a+zh-x2a+A+EEZOFj1KYrBQucCvDv6s9w0XeDW-ZA@mail.gmail.com>
	 <CAOQ4uxg-4NSysxmviKxDhnrA5P455T074ku=F24Wa5KJnCgspQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zcmUqHktaTmrIK0UZTIsj1d2FWv0DtFAZvrawz/zY3G2GPfRlI/
 Ky8mjWLA39i07FmJTe7M9vRZKXM3Uj616p0UOYMtj0J3a2qtkeUZyM4Awq0s0JPkrR6I3kN
 rPihH0JJlIyBro3BZy4zdmIbUNHlNJn8T09UjtPDRZpd8KsRKRA0RoUVHkbqiioBpBT0r7m
 5f47GHuu+jqy1HuFFoUyw==
UI-OutboundReport: notjunk:1;M01:P0:RkCAm3fSDdY=;hYdum0k1djuM+QTsKNO7PfPrU/x
 vWLkAeuQoNxBbu4v4BVhh0TDJShHjmI03mjg6dSyJGs/EAlKkCNRS6nveSj7IsMXoRmhomGgb
 JZigMkqeIWTV9rApm7czJXE1Rg3CxFwI6gMr6ldAMTtlVWXzaAaPrs7JzHojqBsajpiz9G9NO
 oJhpHQLeYIX43Q2GF8PtKc30Q2UJnU20CTyqVgk0OXmOHLyhi99DLSJxgwLGghQNFqGjyKtJf
 zrFMGiyOyKD10GqiQN5Z2TfxtVbGR1mdbSItoDuGjBRbcBlfaG7v1BZN09wKwtrBbhgkNjch0
 x1lHNBef+EeUyt38l3ovd9uJR1ptOSM8srvw97/GYnMmJKhuxSiICBu35MCssGN4WIlfeOS/C
 LgEK+h1m1q43J2SpW/wuEZwWZoI2fy996B67FKTHE0iLfs3VmYaNS5OzTbDShdtbD2YezbG1k
 ekgEqGv8SodH017gvK0DJZxTTCVGOz+aWhG9NT6G344kYjH4SY2fVR5cfJFheKoQrIW+xOLpq
 XnSK2SiRuSredJ57T1fcJTVbAO+X8DQmK2odH23UfkyE2VFSquZ7iFmMZKWY80jSIkQOkD20h
 IOAmAyCj2BiFADnj4X8QlWAb6m93JVYTDgyVA+8iJKDPlqEvB0CtJSuFofR7l+xWnZH66j+cc
 xIabsReCyr+FRpnb8+zLhWj7TA9PbDsZ0uWOs/xVTx18ZRm9cMogCaN/hqbYE0t7X7b3TisYw
 C6+7WBKnEYqH2IM+Q50stN6Y89uJ4v9K1+d2YelxJpXoR1LObiO3DVQm2a41B45ExY1x1JkD/
 KQNMdkbTaHFlBv8PAqncI3ycJ+6SxPpMVuIb0kefi0uozjIZ5jPE3G9LQhQPa1z7fgnDs10jo
 90OMX6XaSg/gby1yrqxRNGRztvllmRZ3W0aOFWCrUugx5Y6LKWiYgMN5Bpq+IEWZXqZXavIzL
 t+iYuQ==

Am Dienstag, dem 05.12.2023 um 07:01 +0200 schrieb Amir Goldstein:
> On Tue, Dec 5, 2023 at 5:45=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Tue, Dec 5, 2023 at 2:16=E2=80=AFAM Bert Karwatzki <spasswolf@web.d=
e> wrote:
> > >
> > > If vfs_copy_file_range() is called with (flags & COPY_FILE_SPLICE =
=3D=3D 0)
> > > and both file_out->f_op->copy_file_range and file_in->f_op-
> > > >remap_file_range
> > > are NULL, too, the default call to do_splice_direct() cannot be reac=
hed.
> > > This patch adds an else clause to make the default reachable in all
> > > cases.
> > >
> > > Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> >
> > Hi Bert,
> >
> > Thank you for testing and reporting this so early!!
> >
> > I would edit the commit message differently, but anyway, I think that
> > the fix should be folded into commit 05ee2d85cd4a ("fs: use
> > do_splice_direct() for nfsd/ksmbd server-side-copy").
> >
> > Since I end up making a mistake every time I touch this code,
> > I also added a small edit to your patch below, that should make the lo=
gic
> > more clear to readers. Hopefully, that will help me avoid making a mis=
take
> > the next time I touch this code...
> >
> > Would you mind testing my revised fix, so we can add:
> > =C2=A0 Tested-by: Bert Karwatzki <spasswolf@web.de>
> > when folding it into the original patch?
> >
>
> Attached an even cleaner version of the fix patch for you to test.
> I tested fstests check -g copy_range on ext4.
> My fault was that I had tested earlier only on xfs and overlayfs
> (the two other cases in the if/else if statement).
>
> Thanks,
> Amir.
>
> > > ---
> > > =C2=A0fs/read_write.c | 2 ++
> > > =C2=A01 file changed, 2 insertions(+)
> > >
> > > diff --git a/fs/read_write.c b/fs/read_write.c
> > > index e0c2c1b5962b..3599c54bd26d 100644
> > > --- a/fs/read_write.c
> > > +++ b/fs/read_write.c
> > > @@ -1554,6 +1554,8 @@ ssize_t vfs_copy_file_range(struct file *file_=
in,
> > > loff_t pos_in,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* fallback to splice */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (ret <=3D 0)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
plice =3D true;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> >
> > This is logically correct because of the earlier "same sb" check in
> > generic_copy_file_checks(), but we better spell out the logic here as =
well:
> >
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =
else if (file_inode(file_in)->i_sb =3D=3D
> > file_inode(file_out)->i_sb) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Fallback to splice for sa=
me sb copy for
> > backward compat */
> >
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 splice =3D true;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file_end_write(file_out);
> > > --
> > > 2.39.2
> > >
> > > Since linux-next-20231204 I noticed that it was impossible to start =
the
> > > game Path of Exile (using the steam client). I bisected the error to
> > > commit 05ee2d85cd4ace5cd37dc24132e3fd7f5142ebef. Reverting this comm=
it
> > > in linux-next-20231204 made the game start again and after inserting
> > > printks into vfs_copy_file_range() I found that steam (via python3)
> > > calls this function with (flags & COPY_FILE_SPLICE =3D=3D 0),
> > > file_out->f_op->copy_file_range =3D=3D NULL and
> > > file_in->f_op->remap_file_range =3D=3D NULL so the default is never =
reached.
> > > This patch adds a catch all else clause so the default is reached in
> > > all cases. This patch fixes the describe issue with steam and Path o=
f
> > > Exile.
> > >
> > > Bert Karwatzki

Your new patch works fine (I applied it to linux-next-20231204), again tes=
ted by
starting Path of Exile via steam from an ext4 filesystem.

Bert Karwatzki

