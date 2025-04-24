Return-Path: <linux-fsdevel+bounces-47205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4FAA9A550
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 10:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C559F3B7D74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3F720B811;
	Thu, 24 Apr 2025 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aR7isCav"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7747D205AB6
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482119; cv=none; b=od4wrDAG5DRFHekLfxD7Cq2pxwV/P7LKgG4lbn7TDUf5DoE+5fsGvrAVUQJm69KeEGXXpEKE7Ma57EAC6bz9Jbmj4wiS7wOEqmYGz6LBHDmE4JGucO7crJi3nv2m5OgR8UGuc4lS+BaprihnqvX2oEubBEsg42qUBM6OpNO0EEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482119; c=relaxed/simple;
	bh=7LSwA9/RC1GNwfG+lCcud3yw0cCVDeqP5nGelatoTRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXxMyM0bdCyitGd1Ljde4AyHXrofSCNZI+GNqstaeYPIl9IU25ZvYrnXz4ZWEVvXvU3mO9cqyEClRi3EK1++NlcSVNfYQzf8nkaPxqpiViky1Qd/jameb6O/IWig/3o4y01MYA3dv68Qvb0/IkbvzIQF1TKFcwYtQ2GHamsfAtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aR7isCav; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745482116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIBcAPIsvRbbtPBYFtUV3aaspfe/f5XOnaHKo0o0ZIA=;
	b=aR7isCavswchNYFgl2NYf2HbK3GmLFWGoaNh/3qFuZrqstuKz5prQXUP2Tk0oCjIEW3Nr8
	WjvenkO3CGq4p6RdToby9tKutSw367JYhbLtZxpDTpvlZptCeyku05kezmpWyjdIq2Mg/8
	kg8K2a1B8OV6AZVAgabjJ5WeYhHcBvg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-72CnI0KUONKDMgSkUso4mA-1; Thu, 24 Apr 2025 04:08:32 -0400
X-MC-Unique: 72CnI0KUONKDMgSkUso4mA-1
X-Mimecast-MFC-AGG-ID: 72CnI0KUONKDMgSkUso4mA_1745482112
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-225ab228a37so6629315ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 01:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745482112; x=1746086912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIBcAPIsvRbbtPBYFtUV3aaspfe/f5XOnaHKo0o0ZIA=;
        b=bp3f3GwJDxDhydVr5DE1Qq647v03tKnYsunxSYXXmyVtvrBMiXOEjobr8o/3IPH+Iu
         oO154TLuhagCNWtpO5U3kOVvLanEhGOrgUe3AJ1oYn40EGiwzw46alTzQ9crXboErpdv
         mmVyNMiWPRfcKdlVcmkwc5v+4e6RSyYZzKeJJ3638XzGQb8uPxI9T2em3epUVpZXayHT
         nzkCN43WZeaW6HU93pe3RPemVbEyd3MA1pWDhSoVNm7V/hiYNAV2Dwm0HRbP7pYre+5V
         2BBDpISTz6lM5bZWTb6NeBhJnCj08rz3C95YCd15kfKXg0pbzSLXjzHl3N5aHnXG+Thb
         dm4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiYNM7FfGqqaGN8uz6UFvu71lKB027Qn/qwBVXzpXEEY94vM1l1grrOpE9uHawO8lckn898QO3idTcD/xy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy06D5S6XXwTWGM8mX8keu6VdJT6gRnBydw76LG1xgIDsM+AxHC
	hVpE0kr8BtcmMZoCQ+0w3CIdcfcR5FcH+S7e0e+AOUkp6J89w5k0Ff73Js8dps1xPoeRUfut+Ci
	0JuZmpHMpHg0ufaoX7NDYHAWWWc3vfl9NBSGT+QYJTXYs5khKCKjuFj93as2Z83GVTJBZkhz0Iw
	y4eH5A3OdbT6oKF3/4VJwSeRuKKRFcjk5T0/G2BA==
X-Gm-Gg: ASbGncvY0pEV387aD2ebcZJOEmrxuIAKJFH9/UF5jG2+2VvWKgven5nkCtr1g6eQs+B
	/iA253NzWwxXijuNq12gOl8Taq922wV4FvOdiGcOnOKOlP9lcEexdwbN5STT0xRFeNIo=
X-Received: by 2002:a17:903:238e:b0:224:1c1:4aba with SMTP id d9443c01a7336-22db3db0f63mr20382305ad.50.1745482111805;
        Thu, 24 Apr 2025 01:08:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9QCt1+uWV0hbcvfKshe4MEvAT+8cYmunuoojCcFbrOrf3foAV6szwZqkcwyD4r4JChprCKBZyHc1ES6rtmRM=
X-Received: by 2002:a17:903:238e:b0:224:1c1:4aba with SMTP id
 d9443c01a7336-22db3db0f63mr20382045ad.50.1745482111469; Thu, 24 Apr 2025
 01:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422142628.1553523-1-hch@lst.de> <20250422142628.1553523-16-hch@lst.de>
 <11b02dfa-9f71-48ac-9d20-ba5a6e44f289@kernel.org>
In-Reply-To: <11b02dfa-9f71-48ac-9d20-ba5a6e44f289@kernel.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 24 Apr 2025 10:08:19 +0200
X-Gm-Features: ATxdqUFTuhjv2n6cEKl2JrhrhPyh6bRjf4GKJQJ_KzadIMn25rxqpw5We26zq08
Message-ID: <CAHc6FU7Y5QKGB1pFL8A0-3VOX2i5LY92d9AYhWqgHMzxL30m4A@mail.gmail.com>
Subject: Re: [PATCH 15/17] gfs2: use bdev_rw_virt in gfs2_read_super
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, 
	Coly Li <colyli@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Carlos Maiolino <cem@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <jth@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 8:23=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
> On 4/22/25 23:26, Christoph Hellwig wrote:
> > Switch gfs2_read_super to allocate the superblock buffer using kmalloc
> > which falls back to the page allocator for PAGE_SIZE allocation but
> > gives us a kernel virtual address and then use bdev_rw_virt to perform
> > the synchronous read into it.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>
> One nit below.
>
> > ---
> >  fs/gfs2/ops_fstype.c | 24 +++++++++---------------
> >  1 file changed, 9 insertions(+), 15 deletions(-)
> >
> > diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> > index e83d293c3614..7c1014ba7ac7 100644
> > --- a/fs/gfs2/ops_fstype.c
> > +++ b/fs/gfs2/ops_fstype.c
> > @@ -226,28 +226,22 @@ static void gfs2_sb_in(struct gfs2_sbd *sdp, cons=
t struct gfs2_sb *str)
> >
> >  static int gfs2_read_super(struct gfs2_sbd *sdp, sector_t sector, int =
silent)
> >  {
> > -     struct super_block *sb =3D sdp->sd_vfs;
> > -     struct page *page;
> > -     struct bio_vec bvec;
> > -     struct bio bio;
> > +     struct gfs2_sb *sb;
> >       int err;
> >
> > -     page =3D alloc_page(GFP_KERNEL);
> > -     if (unlikely(!page))
> > +     sb =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> > +     if (unlikely(!sb))
> >               return -ENOMEM;
> > -
> > -     bio_init(&bio, sb->s_bdev, &bvec, 1, REQ_OP_READ | REQ_META);
> > -     bio.bi_iter.bi_sector =3D sector * (sb->s_blocksize >> 9);
> > -     __bio_add_page(&bio, page, PAGE_SIZE, 0);
> > -
> > -     err =3D submit_bio_wait(&bio);
> > +     err =3D bdev_rw_virt(sdp->sd_vfs->s_bdev,
> > +                     sector * (sdp->sd_vfs->s_blocksize >> 9), sb, PAG=
E_SIZE,
>
> While at it, use SECTOR_SHIFT here ?

This is hardcoded in several places; I can clean it up separately.

> > +                     REQ_OP_READ | REQ_META);
> >       if (err) {
> >               pr_warn("error %d reading superblock\n", err);
> > -             __free_page(page);
> > +             kfree(sb);
> >               return err;
> >       }
> > -     gfs2_sb_in(sdp, page_address(page));
> > -     __free_page(page);
> > +     gfs2_sb_in(sdp, sb);
> > +     kfree(sb);
> >       return gfs2_check_sb(sdp, silent);
> >  }
> >

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks,
Andreas


