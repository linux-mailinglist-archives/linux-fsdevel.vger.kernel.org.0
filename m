Return-Path: <linux-fsdevel+bounces-28491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0840296B232
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 08:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4591C216DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 06:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4D214600D;
	Wed,  4 Sep 2024 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey6vWavd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC34C1EC01C;
	Wed,  4 Sep 2024 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433005; cv=none; b=GF+BuBfy2dPeWRPoxp8aDoSFe7e7QT5iaL9xothhJYWyYFHDPX/91giIEUgpv/BEgp8d4rzShGgtZUpD/pEEcsqPZ5y2gsn0S1bzyBi9yhgh05YxC4zawGiOk3f60gjQSNmnNq1BiMfJadgvBmPUfM4w9uTSmX1jPLbYF49ZtY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433005; c=relaxed/simple;
	bh=ogV5SjCtt4WnjGz6QcAOJo1r/S6T7vuPd0T1eJnPzZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kF1/L2M1y5SZslNTlf5VRaD4pqzpm9iqyzWoVdNC7GVpWLY/9abUC9WZwdKQnSJu+kuB1t+5LQed666l9IDztsSg0SnxnaBfKajc9JK/1fJt3wjIXde7cBgqUtbdCnGm1pL3NPrB99r7EieljdQRbzqqxMwVv+dbZF5zno/QDZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ey6vWavd; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f4f2f0956dso4721031fa.3;
        Tue, 03 Sep 2024 23:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725433002; x=1726037802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+teFZ/KlCRcIgvuSuDA3bFb/EjJQXPZVYOHq6qE5n9Q=;
        b=ey6vWavd3ASaou/4GvfYE6Cdhq0NGZTMshlE+m1F0bIGNrbUVAx2xNXRW/F37P6u9R
         aRfIUaj6f5fRF4JKlIqsTTBSqAR1zXYkuT8VGB3O9+LGKf/ky4IjRfZ4UnZj4TndZnmU
         Bb39QQM0iVTT0oXhe0iNXuqbM6eqGNl2QxRCZNXKOsYFShjKTTOHe+KcK4QdEHbe1h+T
         164Vhmj/OT8JqKnBF9FvNtHHsunuXka++feLGDIHRVck7JRTUPG6lzhU184xDhWdKdgb
         qPCGtuo1XOHvMWmK1PNHg1Pb/ajxyywkYQsiNh8k0WUt7AobpMGxuuwUw6bQY9MKOvGa
         bafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725433002; x=1726037802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+teFZ/KlCRcIgvuSuDA3bFb/EjJQXPZVYOHq6qE5n9Q=;
        b=Jw9DSFRfHPeCqQmZ3s8MsyTs/T2cfGI6b9x5Ien0BuD6sw0VQgQlBmecaJQ2e6VyTW
         RahrqSYj7pIl02+bcNHMjU7+v6ivd37/LYNQXkVAJTu7JCo1A0i+BGv6dCVwN0F8E5yR
         Nx180+a+vtbcHoCbOuWlf8RUcIVDgZOY4nnYs87QpzRdxVhJLPzWnLw4PBal1EmhHiJm
         by0tUQXD8H5lcgSy6vj5LXKA9zTFU3YmHdQAVYW45LNhCsSLbjmySkHqGjIFNUojbALk
         WWXHQtLrP65isU8QzEq/5ZQrFoFnvaUx11mCFNG2+OR33e2F1DcYbsdvYAyt178XFfXH
         zvXw==
X-Forwarded-Encrypted: i=1; AJvYcCWQDRDlzqeXT6cHtjWlvnh5/QymBfhTq3cWGh0cQcqcT1Owoh78WQkNHbA9NWcu8fWsk2p1UPTzq+Pj@vger.kernel.org, AJvYcCXm+nzQ4rEk22RevLj/OiZK5flAlNroYwmHEtYqwck85JOp7xYnFdevriVV9ZHnaDDkfHV8i0OCpwh66xVO2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIoSoK4RRvN0ZJiJ27BxuzTyTAUlB1kWuQdd6clZHUwToYwc/r
	mc2Jq0/gWtJDXPdSe1c4ZmGZ++v5KHBuxyi6ObSe744hUA3zjieAmZDNG2DkVjYznZ/dzp664F6
	AP00uI36r+apwAhvuknqx+GPQCF79qjks
X-Google-Smtp-Source: AGHT+IEHSPBDYriYS4IawxIvKiqHRSxTZIYcBLqQc6m2wNzdGwPHu+Vqr1UDK9a2qZpxhqc3lpPeSqKq4cvoCUUzJT0=
X-Received: by 2002:a2e:bc22:0:b0:2f0:29e7:4dc2 with SMTP id
 38308e7fff4ca-2f61e08bf9cmr61672801fa.5.1725433000919; Tue, 03 Sep 2024
 23:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823082237.713543-1-zhaoyang.huang@unisoc.com>
 <20240903022902.GP9627@mit.edu> <CAGWkznEv+F1A878Nw0=di02DHyKxWCvK0B=93o1xjXK6nUyQ3Q@mail.gmail.com>
 <20240903120840.GD424729@mit.edu> <CAGWkznFu1GTB41Vx1_Ews=rNw-Pm-=ACxg=GjVdw46nrpVdO3g@mail.gmail.com>
 <20240904024445.GR9627@mit.edu>
In-Reply-To: <20240904024445.GR9627@mit.edu>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 4 Sep 2024 14:56:29 +0800
Message-ID: <CAGWkznFGDJsyMUhn5Y8DPmhba9h4GNkX_CaqEMev4z23xa-s6g@mail.gmail.com>
Subject: Re: [RFC PATCHv2 1/1] fs: ext4: Don't use CMA for buffer_head
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:44=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Wed, Sep 04, 2024 at 08:49:10AM +0800, Zhaoyang Huang wrote:
> > >
> > > After all, using GFP_MOVEABLE memory seems to mean that the buffer
> > > cache might get thrashed a lot by having a lot of cached disk buffers
> > > getting ejected from memory to try to make room for some contiguous
> > > frame buffer memory, which means extra I/O overhead.  So what's the
> > > upside of using GFP_MOVEABLE for the buffer cache?
> >
> > To my understanding, NO. using GFP_MOVEABLE memory doesn't introduce
> > extra IO as they just be migrated to free pages instead of ejected
> > directly when they are the target memory area. In terms of reclaiming,
> > all migrate types of page blocks possess the same position.
>
> Where is that being done?  I don't see any evidence of this kind of
> migration in fs/buffer.c.
The journaled pages which carry jh->bh are treated as file pages
during isolation of a range of PFNs in the callstack below[1]. The bh
will be migrated via each aops's migrate_folio and performs what you
described below such as copy the content and reattach the bh to a new
page. In terms of the journal enabled ext4 partition, the inode is a
blockdev inode which applies buffer_migrate_folio_norefs as its
migrate_folio[2].

[1]
cma_alloc/alloc_contig_range
    __alloc_contig_migrate_range
        migrate_pages
            migrate_folio_move
                move_to_new_folio

mapping->aops->migrate_folio(buffer_migrate_folio_norefs->__buffer_migrate_=
folio)

[2]
static int __buffer_migrate_folio(struct address_space *mapping,
                struct folio *dst, struct folio *src, enum migrate_mode mod=
e,
                bool check_refs)
{
...
        if (check_refs) {
                bool busy;
                bool invalidated =3D false;

recheck_buffers:
                busy =3D false;
                spin_lock(&mapping->i_private_lock);
                bh =3D head;
                do {
                        if (atomic_read(&bh->b_count)) {
          //My case failed here as bh is referred by a journal head.
                                busy =3D true;
                                break;
                        }
                        bh =3D bh->b_this_page;
                } while (bh !=3D head);

>
> It's *possile* I suppose, but you'd have to remove the buffer_head so
> it can't be found by getblk(), and then wait for bh->b_count to go to
> zero, and then allocate a new page, and then copy buffer_head's page,
> update the buffer_head, and then rechain the bh into the buffer cache.
> And as I said, I can't see any kind of code like that.  It would be
> much simpler to just try to eject the bh from the buffer cache.  And
> that's consistent which what you've observed, which is that if the
> buffer_head is prevented from being ejected because it's held by the
> jbd2 layer until the buffer has been checkpointed.
All of above is right except the buffer_head is going to be reattached
to a new page instead of being ejected as it still point to checkpoint
data.
>
> > > Just curious, because in general I'm blessed by not having to use CMA
> > > in the first place (not having I/O devices too primitive so they can'=
t
> > > do scatter-gather :-).  So I don't tend to use CMA, and obviously I'm
> > > missing some of the design considerations behind CMA.  I thought in
> > > general CMA tends to used in early boot to allocate things like frame
> > > buffers, and after that CMA doesn't tend to get used at all?  That's
> > > clearly not the case for you, apparently?
> >
> > Yes. CMA is designed for contiguous physical memory and has been used
> > via cma_alloc during the whole lifetime especially on the system
> > without SMMU, such as DRM driver. In terms of MIGRATE_MOVABLE page
> > blocks, they also could have compaction path retry for many times
> > which is common during high-order alloc_pages.
>
> But then what's the point of using CMA-eligible memory for the buffer
> cache, as opposed to just always using !__GFP_MOVEABLE for all buffer
> cache allocations?  After all, that's what is being proposed for
> ext4's ext4_getblk().  What's the downside of avoiding the use of
> CMA-eligible memory for ext4's buffer cache?  Why not do this for
> *all* buffers in the buffer cache?
Since migration which arised from alloc_pages or cma_alloc always
happens, we need appropriate users over MOVABLE pages. AFAIU, buffer
cache pages under regular files are the best candidate for migration
as we just need to modify page cache and PTE. Actually, all FSs apply
GFP_MOVABLE on their regular files via the below functions.

new_inode
    alloc_inode
        inode_init_always(struct super_block *sb, struct inode *inode)
        {
         ...
            mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);

static int filemap_create_folio(struct file *file,
                struct address_space *mapping, pgoff_t index,
                struct folio_batch *fbatch)
{
        struct folio *folio;
        int error;

        folio =3D filemap_alloc_folio(mapping_gfp_mask(mapping), 0);

>
>                                         - Ted

