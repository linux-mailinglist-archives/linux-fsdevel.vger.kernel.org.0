Return-Path: <linux-fsdevel+bounces-63020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06484BA8F02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 12:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A480189C935
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 10:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572632FDC2D;
	Mon, 29 Sep 2025 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4kdHIKB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22802FDC4C
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143468; cv=none; b=tU2OCWnqW+x4cHn8VLmz3umdvlzsKOuGb22hug06uxqliz0lDNy/RcgZiBWixCFa1U+ePEo4suYURhoUDJOiq9Sy9COrMqpwg6ZaKsjqwrI+KvO+9fZi+dA7a/+wQWE6xniJsMSP8opISsvZ5ho/bBVmLvLLLagh10epKJpMGZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143468; c=relaxed/simple;
	bh=JPxhgQ0ICAztTyZoMltYNVNwLafaaPDY0ijuOPDKEiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A98nZy/Ax8jYs1NLqnniBWwGAb0yIr0L/+dhfdoT2wxE0XPbrBl5azSWTITkA29w+ELNmbmpRUoObTpxB3Y6vrmCYUuPLhcneZFW3Ic85kg66bhLCfSwPwz1FHrq0wGuxT+7TY2aNK5rMzZMYCft5/wPmDOdHfdSnZBxU7QtZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4kdHIKB; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3682ac7f33fso55471001fa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 03:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759143464; x=1759748264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHXzobpLJ49nI/+XddZ1qpjJ3WtXnO55EUnggz8fl/g=;
        b=E4kdHIKBuIZR8GAyI669D/cFg/qDn1lLtyaqdaWn1YgexzgdHyF2oSbZFKYd9zeW70
         cFVm0KfJf0lrjng8tBJPukrIInCnzgO4L1No23FpSy0VGKHe/24W28mlhnnhYvdujUay
         gPO9j/QxvnBS//zuJNhfqAOoaO80tLf3+KfpcL8eLxGEoOdaImQDXtiYFkOPmmG63qkt
         WoSOsrlnN7tvwh7ucBGqZ2QBj5Mwfe1KNTZpO+QYw5hL9hTYp1td7Mxuov60gLK5wO7r
         hOkevZw0i7RnbSx4ERHwi1JsyDHg70SqB6z0mKiFk0WfWv+Wmi83tyWT+2s0UURVfclN
         W/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759143464; x=1759748264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHXzobpLJ49nI/+XddZ1qpjJ3WtXnO55EUnggz8fl/g=;
        b=h7Ay0kv0i7dIjzWhR3DSDWjCO1fFdH1DeVX8JitIEIC20zQ+vxRvaUcl4uvqn5Dara
         Q2xOvsDmezHY5IQvS4/kqT23+t6Vcp8bEBmxrltUkPIcD4ISPiY3sgNtNnpVUKeMBnfw
         1HP2WZzi204YwXk7Z5YOI8FmXAWBW0igG6dUiwFf2GzRm6XvENFUSHl81s5uUYwhdRpT
         UMJLMGMHAJQt34Pk9+xDxmZABFtghOnR6dWn99P1WYKFV++zawtW8nJS66D99vGaM/p/
         nF3OYQfgaSI4FDaHukDVHgYU6oK/UYkt4otCZpUF3QffB3XVGNwGlv32hTRI9WkuTxNC
         WX9w==
X-Forwarded-Encrypted: i=1; AJvYcCW/Ap6+Jh0JV17I7OX0+IzLaSrrFA0CVu4G86x+E+qSW5fTbD6k/f08JnKwRfn11UbeBNMIIZlKgtOq+9x5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/C0OLB1VGF4A91hEQribHAbqTLKNiqAJbopo7mT6JYtZodX3j
	5xIX6FjwVzKOVE1dNSM/0KuOTWn7Bc0hmdlUvl8+zDcs2h+idDkvIiP0fZzblZBT3ByYwOXoiiE
	/wV+xS8/f2b0p4l13rbiRHljJvnX0FhI=
X-Gm-Gg: ASbGncs50n/xT0SJkhc9QH2+hYF+wSb1qsmIvT0z/gSZQfV4sXZpL+ltkaUjojTmPAQ
	EqN2iZ83D54lQxtaE9st2yFFjtDSB584hXjwEbCj62CfSypamoXKjg+esCMav8C8uyB0+6sliPE
	VC1SXl4GJasySCofaCPmDBUgZ2LRuxqVU8y34e2ZsYFCu32YoTgyIjVO9MdrtnSklFQQDLdOkKQ
	m7ABfHYvx0tT229QjEXtqOeAFQa+9Q=
X-Google-Smtp-Source: AGHT+IGWuBxNGdwpR1qoBJpJgw+amjLbYU9hsRksLpCILSPVONQpvSdK96EgUU9ULAnuDqxgbW6BMzUzXAVtxbo57r8=
X-Received: by 2002:a05:651c:502:b0:372:89df:9673 with SMTP id
 38308e7fff4ca-372fa29f95fmr330321fa.13.1759143463517; Mon, 29 Sep 2025
 03:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929095544.308392-1-sunjunchao@bytedance.com> <f8cf2061-44f3-4775-b321-713dc90c3282@suse.com>
In-Reply-To: <f8cf2061-44f3-4775-b321-713dc90c3282@suse.com>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Mon, 29 Sep 2025 18:57:31 +0800
X-Gm-Features: AS18NWAAuvHx66ggA-u_WXc9TsJVtaQqxswdi4XTKTeAlkY1OmNtEzHnxjh03Xk
Message-ID: <CAHB1Naj44zBo1Fi_+SSpNx1PSXyAy3XnTMPDdU4yCPkr3oxcNw@mail.gmail.com>
Subject: Re: [PATCH] fs: Make wbc_to_tag() extern and use it in fs.
To: Qu Wenruo <wqu@suse.com>
Cc: Julian Sun <sunjunchao@bytedance.com>, linux-fsdevel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, clm@fb.com, 
	dsterba@suse.com, xiubli@redhat.com, idryomov@gmail.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org, 
	willy@infradead.org, jack@suse.cz, brauner@kernel.org, agruenba@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 6:16=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/9/29 19:25, Julian Sun =E5=86=99=E9=81=93:
> > The logic in wbc_to_tag() is widely used in file systems, so modify thi=
s
> > function to be extern and use it in file systems.
> >
> > This patch has only passed compilation tests, but it should be fine.
> >
> > Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> > ---
> >   fs/btrfs/extent_io.c      | 5 +----
> >   fs/ceph/addr.c            | 6 +-----
> >   fs/ext4/inode.c           | 5 +----
> >   fs/f2fs/data.c            | 5 +----
> >   fs/gfs2/aops.c            | 5 +----
> >   include/linux/writeback.h | 1 +
> >   mm/page-writeback.c       | 2 +-
> >   7 files changed, 7 insertions(+), 22 deletions(-)
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index b21cb72835cc..0fea58287175 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -2390,10 +2390,7 @@ static int extent_write_cache_pages(struct addre=
ss_space *mapping,
> >                              &BTRFS_I(inode)->runtime_flags))
> >               wbc->tagged_writepages =3D 1;
> >
> > -     if (wbc->sync_mode =3D=3D WB_SYNC_ALL || wbc->tagged_writepages)
> > -             tag =3D PAGECACHE_TAG_TOWRITE;
> > -     else
> > -             tag =3D PAGECACHE_TAG_DIRTY;
> > +     tag =3D wbc_to_tag(wbc);
> >   retry:
> >       if (wbc->sync_mode =3D=3D WB_SYNC_ALL || wbc->tagged_writepages)
> >               tag_pages_for_writeback(mapping, index, end);
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 322ed268f14a..63b75d214210 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -1045,11 +1045,7 @@ void ceph_init_writeback_ctl(struct address_spac=
e *mapping,
> >       ceph_wbc->index =3D ceph_wbc->start_index;
> >       ceph_wbc->end =3D -1;
> >
> > -     if (wbc->sync_mode =3D=3D WB_SYNC_ALL || wbc->tagged_writepages) =
{
> > -             ceph_wbc->tag =3D PAGECACHE_TAG_TOWRITE;
> > -     } else {
> > -             ceph_wbc->tag =3D PAGECACHE_TAG_DIRTY;
> > -     }
> > +     ceph_wbc->tag =3D wbc_to_tag(wbc);
> >
> >       ceph_wbc->op_idx =3D -1;
> >       ceph_wbc->num_ops =3D 0;
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 5b7a15db4953..196eba7fa39c 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -2619,10 +2619,7 @@ static int mpage_prepare_extent_to_map(struct mp=
age_da_data *mpd)
> >       handle_t *handle =3D NULL;
> >       int bpp =3D ext4_journal_blocks_per_folio(mpd->inode);
> >
> > -     if (mpd->wbc->sync_mode =3D=3D WB_SYNC_ALL || mpd->wbc->tagged_wr=
itepages)
> > -             tag =3D PAGECACHE_TAG_TOWRITE;
> > -     else
> > -             tag =3D PAGECACHE_TAG_DIRTY;
> > +     tag =3D wbc_to_tag(mpd->wbc);
> >
> >       mpd->map.m_len =3D 0;
> >       mpd->next_pos =3D mpd->start_pos;
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 7961e0ddfca3..101e962845db 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -3003,10 +3003,7 @@ static int f2fs_write_cache_pages(struct address=
_space *mapping,
> >               if (wbc->range_start =3D=3D 0 && wbc->range_end =3D=3D LL=
ONG_MAX)
> >                       range_whole =3D 1;
> >       }
> > -     if (wbc->sync_mode =3D=3D WB_SYNC_ALL || wbc->tagged_writepages)
> > -             tag =3D PAGECACHE_TAG_TOWRITE;
> > -     else
> > -             tag =3D PAGECACHE_TAG_DIRTY;
> > +     tag =3D wbc_to_tag(wbc);
> >   retry:
> >       retry =3D 0;
> >       if (wbc->sync_mode =3D=3D WB_SYNC_ALL || wbc->tagged_writepages)
> > diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> > index 47d74afd63ac..12394fc5dd29 100644
> > --- a/fs/gfs2/aops.c
> > +++ b/fs/gfs2/aops.c
> > @@ -311,10 +311,7 @@ static int gfs2_write_cache_jdata(struct address_s=
pace *mapping,
> >                       range_whole =3D 1;
> >               cycled =3D 1; /* ignore range_cyclic tests */
> >       }
> > -     if (wbc->sync_mode =3D=3D WB_SYNC_ALL || wbc->tagged_writepages)
> > -             tag =3D PAGECACHE_TAG_TOWRITE;
> > -     else
> > -             tag =3D PAGECACHE_TAG_DIRTY;
> > +     tag =3D wbc_to_tag(wbc);
> >
> >   retry:
> >       if (wbc->sync_mode =3D=3D WB_SYNC_ALL || wbc->tagged_writepages)
> > diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> > index a2848d731a46..884811596e10 100644
> > --- a/include/linux/writeback.h
> > +++ b/include/linux/writeback.h
> > @@ -370,6 +370,7 @@ int do_writepages(struct address_space *mapping, st=
ruct writeback_control *wbc);
> >   void writeback_set_ratelimit(void);
> >   void tag_pages_for_writeback(struct address_space *mapping,
> >                            pgoff_t start, pgoff_t end);
> > +xa_mark_t wbc_to_tag(struct writeback_control *wbc);
> >
> >   bool filemap_dirty_folio(struct address_space *mapping, struct folio =
*folio);
> >   bool folio_redirty_for_writepage(struct writeback_control *, struct f=
olio *);
> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index 3e248d1c3969..243808e19445 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -2434,7 +2434,7 @@ static bool folio_prepare_writeback(struct addres=
s_space *mapping,
> >       return true;
> >   }
> >
> > -static xa_mark_t wbc_to_tag(struct writeback_control *wbc)
> > +xa_mark_t wbc_to_tag(struct writeback_control *wbc)
>
> The function is small enough, why not export it as an inline function?
>

Good idea, will fix it in patch v2.
> The current version also lacks EXPORT_SYMBOL(), it may cause problems
> for fses built as a module.
>
> Thanks,
> Qu
>
> >   {
> >       if (wbc->sync_mode =3D=3D WB_SYNC_ALL || wbc->tagged_writepages)
> >               return PAGECACHE_TAG_TOWRITE;
>
>

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

