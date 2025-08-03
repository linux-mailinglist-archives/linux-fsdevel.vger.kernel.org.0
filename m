Return-Path: <linux-fsdevel+bounces-56612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069BBB196D4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 01:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8CC67A2BDC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 23:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8D421421D;
	Sun,  3 Aug 2025 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dvmyy2WR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAD21FCF7C
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Aug 2025 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754262286; cv=none; b=gGfhOshJyfexdeGUS9SD255cB0a8qH7UY+4kgaB3Xw7HJGzAXvlfm+FqxRrBONcW/tMCSNfqNzH9sgnBtxBbSSNuYR5JDbpLKkE5HTobffEn6Wmk+vOyWI6Tgwy59qAOs5SBpq5ZPd+6KLRrxdY8QgtsFNYCTGUHlzJ4m7T/ECU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754262286; c=relaxed/simple;
	bh=Dv81L0UB61wQBOb0IupiOoJhq1u150tKJU35Qof1ZvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCZWcnpvROhEp7+86XJnlwvtGj90hfsAt3VcdNG2guBo196wygFLScKHm162kCybN3iZxc+JCIui77b6NPxzghm52amiia8sjEmXcJHwysk6loR+eQiKCU0LvqP/AJh0xkJJ2CxcobtpktMG4H5JhXOyK4Xd3+1yuq81BlWPpq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dvmyy2WR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA7FC4CEEB
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Aug 2025 23:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754262286;
	bh=Dv81L0UB61wQBOb0IupiOoJhq1u150tKJU35Qof1ZvI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Dvmyy2WRIVA2yPVZL2MvKZdibhREriJ4DfE2dM+0GFucRZFmjQY4/PKcdlMWjr/7x
	 0gN4EXc7YdiPM19hHUSsGS7Ton8GLki2EzPIiT/NEAJbPBNLWW6U7iU2f322B4gfm1
	 Ftn+Wh7JuNZxi4ADa/3HCTav7DU60PBH3NN7eq0aPuOe7yjcFOLPOZQKYSFGE0fFwF
	 PziVZ9iBrypWONw5g0kQwr6+nY+3lGsTEhCgKQ3O8HCCRPuHW2T2faRfo+7X4OMA+B
	 TA7xymUNVqP4xqiELmChJDUMzGfx6goq2JLHrWF67FZNwBt4vMU17NH13d4UCepuiW
	 NUhOUAgDa883A==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-615622ed70fso5709598a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Aug 2025 16:04:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBY6qU+Cob4N9HYMJDDoxMrKp9Pv69i6gp8tB9HYgtWDIqJZJ0pXYpvHV5qhliHA2mZ7dhq159LjHyv6Yc@vger.kernel.org
X-Gm-Message-State: AOJu0YxgpIS7oDwWhmHedxslYgledccp8w49cFCsQvK6/CzTRyquE/Qt
	3q3XEUl+dWwoK6sju20ikarctDTzXnO0kmh3enu1CTbd0zE92XgghXtZnAE1K+AEmk/EGoQtVH6
	9BImFqxvOlu/MCYjdmPvoprlsxrtwAe0=
X-Google-Smtp-Source: AGHT+IG389RxyrNgiDXJS0M3GuK8XvQHY/TIxlJvNvVeL1YQdD23Nh7MfNZ19+0iUKXCAdMCiXLGNmTSK7sgW/Kp8H4=
X-Received: by 2002:a17:906:aacd:b0:af9:5ca0:e4fe with SMTP id
 a640c23a62f3a-af95ca1914cmr327149166b.56.1754262284645; Sun, 03 Aug 2025
 16:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801001452.14105-1-linkinjeon@kernel.org> <PUZPR04MB631623977A900687BA21F92E8126A@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB631623977A900687BA21F92E8126A@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 4 Aug 2025 08:04:33 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9sFBN+7=8xO35dY4adNRsuvTMbRuyPkMF6=k40QJCRhQ@mail.gmail.com>
X-Gm-Features: Ac12FXxWH2mAbl8zWiQI7YOP9bEkeRDxtL4F0Qd78fyjB_1xh7LaDjp2Uq-lnPQ
Message-ID: <CAKYAXd9sFBN+7=8xO35dY4adNRsuvTMbRuyPkMF6=k40QJCRhQ@mail.gmail.com>
Subject: Re: [PATCH] exfat: optimize allocation bitmap loading time
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 5:03=E2=80=AFPM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> > Loading the allocation bitmap is very slow if user set the small cluste=
r
> > size on large partition.
> >
> > For optimizing it, This patch uses sb_breadahead() read the allocation
> > bitmap. It will improve the mount time.
> >
> > The following is the result of about 4TB partition(2KB cluster size)
> > on my target.
> >
> > without patch:
> > real 0m41.746s
> > user 0m0.011s
> > sys 0m0.000s
> >
> > with patch:
> > real 0m2.525s
> > user 0m0.008s
> > sys 0m0.008s
> >
> > Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> > Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> > ---
> >  fs/exfat/balloc.c   | 12 +++++++++++-
> >  fs/exfat/dir.c      |  1 -
> >  fs/exfat/exfat_fs.h |  1 +
> >  3 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
> > index cc01556c9d9b..c40b73701941 100644
> > --- a/fs/exfat/balloc.c
> > +++ b/fs/exfat/balloc.c
> > @@ -30,9 +30,11 @@ static int exfat_allocate_bitmap(struct super_block =
*sb,
> >                 struct exfat_dentry *ep)
> >  {
> >         struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> > +       struct blk_plug plug;
> >         long long map_size;
> > -       unsigned int i, need_map_size;
> > +       unsigned int i, j, need_map_size;
> >         sector_t sector;
> > +       unsigned int max_ra_count =3D EXFAT_MAX_RA_SIZE >> sb->s_blocks=
ize_bits;
> >
> >         sbi->map_clu =3D le32_to_cpu(ep->dentry.bitmap.start_clu);
> >         map_size =3D le64_to_cpu(ep->dentry.bitmap.size);
> > @@ -57,6 +59,14 @@ static int exfat_allocate_bitmap(struct super_block =
*sb,
> >
> >         sector =3D exfat_cluster_to_sector(sbi, sbi->map_clu);
> >         for (i =3D 0; i < sbi->map_sectors; i++) {
> > +               /* Trigger the next readahead in advance. */
> > +               if (0 =3D=3D (i % max_ra_count)) {
> > +                       blk_start_plug(&plug);
> > +                       for (j =3D i; j < min(max_ra_count, sbi->map_se=
ctors - i) + i; j++)
> > +                               sb_breadahead(sb, sector + j);
> > +                       blk_finish_plug(&plug);
> > +               }
> > +
> >                 sbi->vol_amap[i] =3D sb_bread(sb, sector + i);
> >                 if (!sbi->vol_amap[i]) {
> >                         /* release all buffers and free vol_amap */
> > diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> > index ee060e26f51d..e7a8550c0346 100644
> > --- a/fs/exfat/dir.c
> > +++ b/fs/exfat/dir.c
> > @@ -616,7 +616,6 @@ static int exfat_find_location(struct super_block *=
sb, struct exfat_chain *p_dir
> >         return 0;
> >  }
> >
> > -#define EXFAT_MAX_RA_SIZE     (128*1024)
> >  static int exfat_dir_readahead(struct super_block *sb, sector_t sec)
> >  {
> >         struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> > diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> > index f8ead4d47ef0..d1792d5c9eed 100644
> > --- a/fs/exfat/exfat_fs.h
> > +++ b/fs/exfat/exfat_fs.h
> > @@ -13,6 +13,7 @@
> >  #include <uapi/linux/exfat.h>
> >
> >  #define EXFAT_ROOT_INO         1
> > +#define EXFAT_MAX_RA_SIZE     (128*1024)
>
> Why is the max readahead size 128KiB?
> If the limit is changed to max_sectors_kb, so that a read request reads a=
s much
> data as possible, will the performance be better?
This sets an appropriate readahead size for exfat. It's already used
elsewhere in exfat.
Getting ->max_sectors_kb from the block layer will result in a layer violat=
ion.

Thanks.

