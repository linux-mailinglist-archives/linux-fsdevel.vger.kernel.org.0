Return-Path: <linux-fsdevel+bounces-29272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FCB977677
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 03:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29245286164
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 01:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1416524C;
	Fri, 13 Sep 2024 01:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnur7UMb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3104A06;
	Fri, 13 Sep 2024 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726191614; cv=none; b=j2L1DAUrA9BzBQqMi7iJ9KbfynG33F195BfS870KdJ3tp6iQRBrmHD4HtjNGF4eeDoOvvEbPMZ6sVZMwkvoWiJ6mmoeQG7muV+juQbLOHt1iMCGnpIT4BVQsHKuyqc04WWLgOy3AIVWKLUW2vEe6a2XSHHIZQGrkSrkY7N168/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726191614; c=relaxed/simple;
	bh=G/XxhY/TCpiczKyWESI45YZIL71Lk4gvH65+2iIIhQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqw8bsuql+4IsWLm7cygSEm+JNrP4ZoQWY2F+UK0nn8Lb6hLFW5L6aQwVl0Yp3/DOBP116U7vMz42bRPBL8q6ZYCosC94Bn8hAvF1Aewo/9G7VHW3VZm/RJIgFevwMrejeUDUTA8J6UXVY8H+Ro+mMFljaut3uZ0M00kE8G9b9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnur7UMb; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53654d716d1so168192e87.2;
        Thu, 12 Sep 2024 18:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726191610; x=1726796410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6kTfQ0+XLkI7HmD31e28csWkZCT9p5mVYXpNSQOTvw=;
        b=fnur7UMbUQOajpOFnCrY3cwzUu8lAr26Yx8OLrOnMfVLAO6GBB1qetMvnOVJO2Dhdn
         abkXrNiDyv0vZfJot962IKVeY1HcDDHbWICXQ02uVoc5DPtVeV4/V1w3GG0/MxLoDKgI
         DsnpFUsXMP+PiGmReKmR+6K3pXlIpmqxvWqQZ8Y/r0CL3CK8SXQN63RlUc6CPkhmbZ9z
         UwKHWyK+twAkgmZ0RsAb6ietLzbOHZAsZ+jfg/nXTMnkSdKYdCznjXnGdVGaYGG7Tw+R
         b70AlTESCbmxLcTuAEUwHDisfp59nHAND4Qj8dWr55EdtYxpfYTj0JGCagxwzOs95zTp
         qyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726191610; x=1726796410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6kTfQ0+XLkI7HmD31e28csWkZCT9p5mVYXpNSQOTvw=;
        b=gUzkk1BH6u9lSdEOUg0qgPjDMDoP3yAmPo9q25bL+TGQRcymDEY/IL7uEXwKLKFLtT
         rIBvKRDvwDU9NVKuJ99wRSqYnLToKj8bgtq1ZNofcgF9CbzVC8tQm5jirxUBPsHj1zeN
         o4z2C8OF/anIsjzyglYLLet6Gkl/2kqPH0qGcgauzAbhNXjUNAg3JwjbMPHDoEunBSQI
         BRcucpYrdTQdR+7mtoMhbxtIRyn9xBBXmA8aAq77eKmFZgzCy5Z0PoMZMg1TIqaxMrV/
         27MRzzE4yY2Dy3txpnNT5pnSO1AOjLlJmyYmHaOeQd6LyjUzQwRyxwBIghGZWEVrXSXd
         jo6g==
X-Forwarded-Encrypted: i=1; AJvYcCW/pfhfcPvvP+MCo7S/q711cDBpoZQgZxmm2D0bCBujuPGeIBgSX0vKHv4v7gfYUTaVX/nsvb+dp83s@vger.kernel.org, AJvYcCXn/D417XdHuSNACXSh50KdAahAC+T6UdZh8VEDdM0jBjZ0qNYwubY5hzdJE895tlffE+jF8NISQPE/N3Jx6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy42U4KQUY5JFU4KkUXt0CsVpScBoxQncqlhdiI1BviVMfO4wGQ
	A904M+MOWqZk46wEogvfhPoD7xPBthA0gh1RaPCPPfPmn26FZRdT8VvYaZHgYRI8tfGqU0H1n8y
	QOxsahL/7Amxxmx+mHhkhRAIFpF4=
X-Google-Smtp-Source: AGHT+IGIPXeLZsPRegh15drXSIzAoa0A07+T0e/6TztFcQe32ePtb3CR8mcVBmyi4G5BgZCPD+wrV31PR0AtBMiGhZI=
X-Received: by 2002:a2e:bc15:0:b0:2f4:f3e7:2a36 with SMTP id
 38308e7fff4ca-2f787d9e80cmr7569011fa.3.1726191609329; Thu, 12 Sep 2024
 18:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823082237.713543-1-zhaoyang.huang@unisoc.com>
 <20240903022902.GP9627@mit.edu> <CAGWkznEv+F1A878Nw0=di02DHyKxWCvK0B=93o1xjXK6nUyQ3Q@mail.gmail.com>
 <20240903120840.GD424729@mit.edu> <CAGWkznFu1GTB41Vx1_Ews=rNw-Pm-=ACxg=GjVdw46nrpVdO3g@mail.gmail.com>
 <20240904024445.GR9627@mit.edu> <CAGWkznFGDJsyMUhn5Y8DPmhba9h4GNkX_CaqEMev4z23xa-s6g@mail.gmail.com>
 <20240912084119.j3oqfikuavymctlm@quack3> <CAGWkznG7_=zjKZBO-sj=79F3a3tgZuXqCXbvddDDG2Atv5043g@mail.gmail.com>
 <20240912101608.c6wfkvhbaatiokaw@quack3>
In-Reply-To: <20240912101608.c6wfkvhbaatiokaw@quack3>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 13 Sep 2024 09:39:57 +0800
Message-ID: <CAGWkznGQkoJbUW7hkUK1+i4ww9ihtY2cUTZbC_jqwFq3HDqE4g@mail.gmail.com>
Subject: Re: [RFC PATCHv2 1/1] fs: ext4: Don't use CMA for buffer_head
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 6:16=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 12-09-24 17:10:44, Zhaoyang Huang wrote:
> > On Thu, Sep 12, 2024 at 4:41=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 04-09-24 14:56:29, Zhaoyang Huang wrote:
> > > > On Wed, Sep 4, 2024 at 10:44=E2=80=AFAM Theodore Ts'o <tytso@mit.ed=
u> wrote:
> > > > > On Wed, Sep 04, 2024 at 08:49:10AM +0800, Zhaoyang Huang wrote:
> > > > > > >
> > > > > > > After all, using GFP_MOVEABLE memory seems to mean that the b=
uffer
> > > > > > > cache might get thrashed a lot by having a lot of cached disk=
 buffers
> > > > > > > getting ejected from memory to try to make room for some cont=
iguous
> > > > > > > frame buffer memory, which means extra I/O overhead.  So what=
's the
> > > > > > > upside of using GFP_MOVEABLE for the buffer cache?
> > > > > >
> > > > > > To my understanding, NO. using GFP_MOVEABLE memory doesn't intr=
oduce
> > > > > > extra IO as they just be migrated to free pages instead of ejec=
ted
> > > > > > directly when they are the target memory area. In terms of recl=
aiming,
> > > > > > all migrate types of page blocks possess the same position.
> > > > >
> > > > > Where is that being done?  I don't see any evidence of this kind =
of
> > > > > migration in fs/buffer.c.
> > > > The journaled pages which carry jh->bh are treated as file pages
> > > > during isolation of a range of PFNs in the callstack below[1]. The =
bh
> > > > will be migrated via each aops's migrate_folio and performs what yo=
u
> > > > described below such as copy the content and reattach the bh to a n=
ew
> > > > page. In terms of the journal enabled ext4 partition, the inode is =
a
> > > > blockdev inode which applies buffer_migrate_folio_norefs as its
> > > > migrate_folio[2].
> > > >
> > > > [1]
> > > > cma_alloc/alloc_contig_range
> > > >     __alloc_contig_migrate_range
> > > >         migrate_pages
> > > >             migrate_folio_move
> > > >                 move_to_new_folio
> > > >
> > > > mapping->aops->migrate_folio(buffer_migrate_folio_norefs->__buffer_=
migrate_folio)
> > > >
> > > > [2]
> > > > static int __buffer_migrate_folio(struct address_space *mapping,
> > > >                 struct folio *dst, struct folio *src, enum migrate_=
mode mode,
> > > >                 bool check_refs)
> > > > {
> > > > ...
> > > >         if (check_refs) {
> > > >                 bool busy;
> > > >                 bool invalidated =3D false;
> > > >
> > > > recheck_buffers:
> > > >                 busy =3D false;
> > > >                 spin_lock(&mapping->i_private_lock);
> > > >                 bh =3D head;
> > > >                 do {
> > > >                         if (atomic_read(&bh->b_count)) {
> > > >           //My case failed here as bh is referred by a journal head=
.
> > > >                                 busy =3D true;
> > > >                                 break;
> > > >                         }
> > > >                         bh =3D bh->b_this_page;
> > > >                 } while (bh !=3D head);
> > >
> > > Correct. Currently pages with journal heads attached cannot be migrat=
ed
> > > mostly out of pure caution that the generic code isn't sure what's
> > > happening with them. As I wrote in [1] we could make pages with jhs o=
n
> > > checkpoint list only migratable as for them the buffer lock is enough=
 to
> > > stop anybody from touching the bh data. Bhs which are part of a runni=
ng /
> > > committing transaction are not realistically migratable but then thes=
e
> > > states are more shortlived so it shouldn't be a big problem.
> > By observing from our test case, the jh remains there for a long time
> > when journal->j_free is bigger than j_max_transaction_buffers which
> > failed cma_alloc. So you think this is rare or abnormal?
> >
> > [6] j_free & j_max_transaction_buffers
> > crash_arm64_v8.0.4++> struct
> > journal_t.j_free,j_max_transaction_buffers 0xffffff80e70f3000 -x
> >   j_free =3D 0x3f1,
> >   j_max_transaction_buffers =3D 0x100,
>
> So jh can stay attached to the bh for a very long time (basically only
> memory pressure will evict it) and this is what blocks migration. But wha=
t
> I meant is that in fact, most of the time we can migrate bh with jh
> attached just fine. There are only relatively short moments (max 5s) wher=
e
> a buffer (jh) is part of a running or committing transaction and then we
> cannot really migrate.
Please correct me if I am wrong. According to __buffer_migrate_folio,
the bh can not be migrated as long as it has jh attached which could
remain until the next cp transaction is launched. In my case, the
jbd2' log space is big enough( j_free =3D 0x3f1 >
j_max_transaction_buffers =3D 0x100) to escape the launch.

static int __buffer_migrate_folio(struct address_space *mapping,
                struct folio *dst, struct folio *src, enum migrate_mode mod=
e,
                bool check_refs)
{
 ...
recheck_buffers:
                busy =3D false;
                spin_lock(&mapping->i_private_lock);
                bh =3D head;
                do {
                        if (atomic_read(&bh->b_count)) {
//migrate will fail here as bh->jh attached
                                busy =3D true;
                                break;
                        }
                        bh =3D bh->b_this_page;
                } while (bh !=3D head);

>
> > > > > > > Just curious, because in general I'm blessed by not having to=
 use CMA
> > > > > > > in the first place (not having I/O devices too primitive so t=
hey can't
> > > > > > > do scatter-gather :-).  So I don't tend to use CMA, and obvio=
usly I'm
> > > > > > > missing some of the design considerations behind CMA.  I thou=
ght in
> > > > > > > general CMA tends to used in early boot to allocate things li=
ke frame
> > > > > > > buffers, and after that CMA doesn't tend to get used at all? =
 That's
> > > > > > > clearly not the case for you, apparently?
> > > > > >
> > > > > > Yes. CMA is designed for contiguous physical memory and has bee=
n used
> > > > > > via cma_alloc during the whole lifetime especially on the syste=
m
> > > > > > without SMMU, such as DRM driver. In terms of MIGRATE_MOVABLE p=
age
> > > > > > blocks, they also could have compaction path retry for many tim=
es
> > > > > > which is common during high-order alloc_pages.
> > > > >
> > > > > But then what's the point of using CMA-eligible memory for the bu=
ffer
> > > > > cache, as opposed to just always using !__GFP_MOVEABLE for all bu=
ffer
> > > > > cache allocations?  After all, that's what is being proposed for
> > > > > ext4's ext4_getblk().  What's the downside of avoiding the use of
> > > > > CMA-eligible memory for ext4's buffer cache?  Why not do this for
> > > > > *all* buffers in the buffer cache?
> > > > Since migration which arised from alloc_pages or cma_alloc always
> > > > happens, we need appropriate users over MOVABLE pages. AFAIU, buffe=
r
> > > > cache pages under regular files are the best candidate for migratio=
n
> > > > as we just need to modify page cache and PTE. Actually, all FSs app=
ly
> > > > GFP_MOVABLE on their regular files via the below functions.
> > > >
> > > > new_inode
> > > >     alloc_inode
> > > >         inode_init_always(struct super_block *sb, struct inode *ino=
de)
> > > >         {
> > > >          ...
> > > >             mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
> > >
> > > Here you speak about data page cache pages. Indeed they can be alloca=
ted
> > > from CMA area. But when Ted speaks about "buffer cache" he specifical=
ly
> > > means page cache of the block device inode and there I can see:
> > >
> > > struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
> > > {
> > > ...
> > >         mapping_set_gfp_mask(&inode->i_data, GFP_USER);
> > > ...
> > > }
> > >
> > > so at this point I'm confused how come you can see block device pages=
 in
> > > CMA area. Are you using data=3Djournal mode of ext4 in your setup by =
any
> > > chance? That would explain it but then that is a horrible idea as wel=
l...
> > The page of 'fffffffe01a51c00'[1] which has bh attached comes from
> > creating bitmap_blk by ext4_getblk->sb_getblk within process[2] where
> > the gfpmask has GFP_MOVABLE. IMO, GFP_USER is used for regular file
> > pages under the super_block but not available for metadata, right?
>
> Ah, right, __getblk() overrides the GFP mode set in bdev's mapping_gfp_ma=
sk
> and sets __GFP_MOVABLE there. This behavior goes way back to 2007
> (769848c03895b ("Add __GFP_MOVABLE for callers to flag allocations from
> high memory that may be migrated")). So another clean and simple way to f=
ix
> this (as Ted suggests) would be to stop setting __GFP_MOVABLE in
> __getblk(). For ext4 there would be no practical difference to current
> situation where metadata pages are practically unmovable due to attached
> jhs, other filesystems can set __GFP_MOVABLE in bdev's mapping_gfp_mask i=
f
> they care (but I don't think there are other big buffer cache users on
> systems which need CMA).
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

