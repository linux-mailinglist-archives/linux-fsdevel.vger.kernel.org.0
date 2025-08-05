Return-Path: <linux-fsdevel+bounces-56705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA6DB1ABE2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 03:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CBC18A1E42
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 01:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110B417C21C;
	Tue,  5 Aug 2025 01:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJmWMI7s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7023B149C7B
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 01:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754356002; cv=none; b=tbebVoEGczh2tBku4znZ84NqWh/cadCW5amQf51weqli7O2WVKvUgQYk92iBLKlRRwE2cqYoKBVuCXR09dq6ESOc0YDOnmvRXG7aFihfGQ1MXrjgF29tvXZ267V3YvUnKGcuPXxh8ARozak43h6Lvc2wxzDqPxnK2j7ic5f1qkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754356002; c=relaxed/simple;
	bh=IcXN/ilg1S2uPP6eSiRbp0iv7m0rBZXd4r+xJxdcXSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9zUnvOFTXKzZqmI2Nyg86i0a9IjOcmsXVhRl3pLmTDcrxtTRmXrZGxQcj+z1LX9o8HEqNH4SohclabdRZUJbdPxh+vINyDyzCt7IrQDsBAjeQEM8BB4guEvA3hGSYQE2eWhbZsbmP/IxZ3hPdfDUbRCPrfM0WyruUsSv96e4C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJmWMI7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6078C4CEF0
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 01:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754356001;
	bh=IcXN/ilg1S2uPP6eSiRbp0iv7m0rBZXd4r+xJxdcXSw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jJmWMI7sk2CV3fg/1yXbB9bUJ8AybViKi8Yd5cfLHWL7l0gZy412zNagO0UvdcxTx
	 +vdY3NCHsNMIgYm0FcqsB/3Uty0si8M8Vsn6VsNeNCRXinXo0QddSXCa+GNHYgQ1d6
	 sJ0t9b3CSYc0Lii0X/K9+ROgOIkAUcP2ezRo9uHL5oMO9ILILgHN20GFQ1nZm2XzfV
	 n2KxweRQOnCoVCMJNeenkjRCZyhlpLFKWOW5x5CjD+vg43BJTwILb9h0LHUJqmAnde
	 frLQssQVDgRphg2rxsQ43Fy9Actwg3kCfXxnGEsJGKOH54g8usbizWvi49C4KJLWBD
	 PW78Iy7fgAUXA==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6157b5d0cc2so5164174a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 18:06:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWoU8bUsrZjYPpoh29n9sb4pDukw9FfVqk78D/FldqIxGoJOkjXGdEueGzuPpCGCJnDCDWXogeG3hZ7sW5J@vger.kernel.org
X-Gm-Message-State: AOJu0YxeRPBaTl4TZT7tvsk8v5M+SyRJWexCNp7pFz0Frxo8qdSt93pQ
	0pIOYqkXtg/Wdo4FLu9OHUEuTu6vTNd8tWwxxqOXOrQrmZ774Ll2p65bt7Fu1n88mFWNmGB9yPL
	VCBRJhFecschml23YAz9YxNU8gwmhHdA=
X-Google-Smtp-Source: AGHT+IG6Qku6JaAcDjo9Qhu5rpyHMTbRwjN5uLUkw4LY9x9OCuxYQ7UX6LIo4GQpO9TJeL/vjAjbdXn4yxP747IECy4=
X-Received: by 2002:a17:907:94c9:b0:ae3:ed38:8f63 with SMTP id
 a640c23a62f3a-af94000c956mr1169597866b.14.1754356000469; Mon, 04 Aug 2025
 18:06:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801001452.14105-1-linkinjeon@kernel.org> <PUZPR04MB631623977A900687BA21F92E8126A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd9sFBN+7=8xO35dY4adNRsuvTMbRuyPkMF6=k40QJCRhQ@mail.gmail.com> <PUZPR04MB631671AF6B812D54A033C4598123A@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB631671AF6B812D54A033C4598123A@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 5 Aug 2025 10:06:28 +0900
X-Gmail-Original-Message-ID: <CAKYAXd89-cCuHKzNqHzpHUB3owfvdQ3AOFwnLCP6nvONZsNZOA@mail.gmail.com>
X-Gm-Features: Ac12FXydym_jaesOfNhO4SpnHeuccHLyPs0qaDpIkFeGohLbQQLvBZFqAo9-LvA
Message-ID: <CAKYAXd89-cCuHKzNqHzpHUB3owfvdQ3AOFwnLCP6nvONZsNZOA@mail.gmail.com>
Subject: Re: [PATCH] exfat: optimize allocation bitmap loading time
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 5:57=E2=80=AFPM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> > On Fri, Aug 1, 2025 at 5:03=E2=80=AFPM Yuezhang.Mo@sony.com
> > <Yuezhang.Mo@sony.com> wrote:
> > >
> > > > Loading the allocation bitmap is very slow if user set the small cl=
uster
> > > > size on large partition.
> > > >
> > > > For optimizing it, This patch uses sb_breadahead() read the allocat=
ion
> > > > bitmap. It will improve the mount time.
> > > >
> > > > The following is the result of about 4TB partition(2KB cluster size=
)
> > > > on my target.
> > > >
> > > > without patch:
> > > > real 0m41.746s
> > > > user 0m0.011s
> > > > sys 0m0.000s
> > > >
> > > > with patch:
> > > > real 0m2.525s
> > > > user 0m0.008s
> > > > sys 0m0.008s
> > > >
> > > > Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> > > > Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> > > > ---
> > > >  fs/exfat/balloc.c   | 12 +++++++++++-
> > > >  fs/exfat/dir.c      |  1 -
> > > >  fs/exfat/exfat_fs.h |  1 +
> > > >  3 files changed, 12 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
> > > > index cc01556c9d9b..c40b73701941 100644
> > > > --- a/fs/exfat/balloc.c
> > > > +++ b/fs/exfat/balloc.c
> > > > @@ -30,9 +30,11 @@ static int exfat_allocate_bitmap(struct super_bl=
ock *sb,
> > > >                 struct exfat_dentry *ep)
> > > >  {
> > > >         struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> > > > +       struct blk_plug plug;
> > > >         long long map_size;
> > > > -       unsigned int i, need_map_size;
> > > > +       unsigned int i, j, need_map_size;
> > > >         sector_t sector;
> > > > +       unsigned int max_ra_count =3D EXFAT_MAX_RA_SIZE >> sb->s_bl=
ocksize_bits;
> > > >
> > > >         sbi->map_clu =3D le32_to_cpu(ep->dentry.bitmap.start_clu);
> > > >         map_size =3D le64_to_cpu(ep->dentry.bitmap.size);
> > > > @@ -57,6 +59,14 @@ static int exfat_allocate_bitmap(struct super_bl=
ock *sb,
> > > >
> > > >         sector =3D exfat_cluster_to_sector(sbi, sbi->map_clu);
> > > >         for (i =3D 0; i < sbi->map_sectors; i++) {
> > > > +               /* Trigger the next readahead in advance. */
> > > > +               if (0 =3D=3D (i % max_ra_count)) {
> > > > +                       blk_start_plug(&plug);
> > > > +                       for (j =3D i; j < min(max_ra_count, sbi->ma=
p_sectors - i) + i; j++)
> > > > +                               sb_breadahead(sb, sector + j);
> > > > +                       blk_finish_plug(&plug);
> > > > +               }
> > > > +
> > > >                 sbi->vol_amap[i] =3D sb_bread(sb, sector + i);
> > > >                 if (!sbi->vol_amap[i]) {
> > > >                         /* release all buffers and free vol_amap */
> > > > diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> > > > index ee060e26f51d..e7a8550c0346 100644
> > > > --- a/fs/exfat/dir.c
> > > > +++ b/fs/exfat/dir.c
> > > > @@ -616,7 +616,6 @@ static int exfat_find_location(struct super_blo=
ck *sb, struct exfat_chain *p_dir
> > > >         return 0;
> > > >  }
> > > >
> > > > -#define EXFAT_MAX_RA_SIZE     (128*1024)
> > > >  static int exfat_dir_readahead(struct super_block *sb, sector_t se=
c)
> > > >  {
> > > >         struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> > > > diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> > > > index f8ead4d47ef0..d1792d5c9eed 100644
> > > > --- a/fs/exfat/exfat_fs.h
> > > > +++ b/fs/exfat/exfat_fs.h
> > > > @@ -13,6 +13,7 @@
> > > >  #include <uapi/linux/exfat.h>
> > > >
> > > >  #define EXFAT_ROOT_INO         1
> > > > +#define EXFAT_MAX_RA_SIZE     (128*1024)
> > >
> > > Why is the max readahead size 128KiB?
> > > If the limit is changed to max_sectors_kb, so that a read request rea=
ds as much
> > > data as possible, will the performance be better?
> > This sets an appropriate readahead size for exfat. It's already used
> > elsewhere in exfat.
> > Getting ->max_sectors_kb from the block layer will result in a layer vi=
olation.
>
> I checked the code of read ahead, EXFAT_MAX_RA_SIZE is consistent with th=
e
> default value(VM_READAHEAD_PAGES) of sb->s_bdi->ra_pages.
>
> Is it better to use sb->s_bdi->ra_pages instead?
> If so, users can set different values via 'blockdev --setra'.
I will change max_ra_count as follows:
max_ra_count =3D min(sb->s_bdi->ra_pages, sb->s_bdi->io_pages)
                << (PAGE_SHIFT - sb->s_blocksize_bits);
Thanks.

