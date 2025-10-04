Return-Path: <linux-fsdevel+bounces-63422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A481CBB87A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 03:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C12334887B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Oct 2025 01:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4741484A35;
	Sat,  4 Oct 2025 01:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0Xqa4t8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA278F36
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Oct 2025 01:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759540320; cv=none; b=tFZug4xHXoPSgATJgQ9PqCYqNsxeejfZnEE93Uxzlb9v9kMrO1yuqm+HAAAsEj2A63dVe9XfoV/FTCJzJkjz4Yvv9GV4KJymsKwwzVo09bgWjErjU1MvNScIlsHct3qXAef3sONVgeS83IQp9/QNM/eeAbnJXOnxOKA8gogsGUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759540320; c=relaxed/simple;
	bh=8Hg8vsRUU/rATEEsBzde7aNvQwbT5coAYTwEFk+UUW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBfByJyvcDieAhy3vH7H6LMVSh5czlQ6Q1l0cbxd7ZKtMrUIK77DHOw8FX7Gve8SuL7z/bGUwad8gLcqj6cLxSt9wT/l0VbSC6pSiTtUSNAAZtV8slwhy68/BFYslUOG/lj96ELQJObKAl7zvcgyDCnN5PWkTxcj8MMpc13vPsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0Xqa4t8; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-854585036e8so293409485a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 18:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759540318; x=1760145118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cg/o+1i1wgPcPhnANrnCwbeCVtTSpoAQZ0dnG9C/p9k=;
        b=H0Xqa4t8P7BWFcdtfGG7K6HfPcLvoHP7VzEBdqhxOYL8SrBJsqcCkDN7ojKEblmc3S
         +1+lrlY0+y0PKNZAG+wOBhGWlhBlWLaqfOX4dsTU3bu2kH684HRw65DsoLLrb0yiix3U
         902lxrGmMfJwdwWBXwGKYcdQqE7G+VnR1xc+M7hrycN1jbkenMMPpoSxWxpvTUBgyLLM
         D9xbLw7NqIQOjiX/FixSQmLwNNwSCO14Iyu9rAIAXOhNNnWEFluMbheqAPPMdNLjiecM
         RP1FVHVyvuqfY9FJAboJ/rvBp6PEIt7S2anZZLHD9NzyVOY6wM2aEDU55cIziuZY+R7o
         5Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759540318; x=1760145118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cg/o+1i1wgPcPhnANrnCwbeCVtTSpoAQZ0dnG9C/p9k=;
        b=T/J16cEL/m3X2pIJxqJoK+eJaazrSbyx1vhDz9A+nXsDLTWmdRm2lqgGJA3BXbyPwC
         nwRfCn5zCks6HPB3ddTVHpMZIrUzgVVkK3KUZE7QguXUUXQC0+4q5uC8fPqC/eZxVhAd
         6HEoiikgs2EzazmyZrdMP64Z3OtunSMmbYEvyGDTPNlaSbRNwpbEmjFwYmclpL3RXMvg
         Km5yec9btQFpJQt2CWxML361zjHRD+04i+Fv4SW9JJDoMvYWYp9rmUKIvBFSdByhL0SD
         jHpri4LPZMzJNpOK1vyEMMDDB0GBtlL/7DjBc9LPZjyOM6RMJgMJg0L8bJFhe1cOlvf5
         ZMqw==
X-Forwarded-Encrypted: i=1; AJvYcCU0J9s2JY+NpPxJK65aOd0ANCtiKKztzdigqq+tBPyQbUvDrUrhkaselOkc/TwmQ4TjM/hWM8tywBG+WKeZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzID/j28AUXaRgfgnBjsi6h3gwN+nEmHR5LM7wC1SMlamZdQ6P5
	L1hxIhe7zsMWuK7oBKHbH8qII0ppqdObnK9X/r+DAHDXdZB/qmp5Hwz29ejJjFcvP2tpwVL3EPV
	c8hZxE2Xn/tZx8HNWB7XwMr1Y2gFQKzk=
X-Gm-Gg: ASbGncuJD5hX77SeSkF45L7m7joSWpJ9tVDJcpWWO+9kEradF2MYeL57NJxJxYuguZA
	IRAY4rpXnwqNrdWkqfe1iPuZmGo+1REREbtARRj2aRQx6dUq5BibFT5JTIYmTMWp3GYE+L+D7mp
	NRIqjw9mdRWSDXFgTdl0/bnDmFWaQcOzsJVavxavvrd39pnLQf8fSVQ958wdTVTXE//JTbIKzh6
	PaSDJKhwWH/+tEVVlCttiZNMOFyK96I5zwXDmU0nZAGQ3df2m9PYES2BsqQ5bcJwItS4PlxCA==
X-Google-Smtp-Source: AGHT+IFLvYyMiPRzs9rrQMqs2JnG0v1Bz/iHHaMqXs7Ifgi0InrWOPxE8NIVym22Jcei5iLGhrb8hDuNGJz6rr/Jh4M=
X-Received: by 2002:a05:620a:1729:b0:85e:24c3:a60f with SMTP id
 af79cd13be357-87a3adf2c75mr747203585a.65.1759540317558; Fri, 03 Oct 2025
 18:11:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
 <20250829233942.3607248-11-joannelkoong@gmail.com> <aLiOrcetNAvjvjtk@bfoster>
 <20250903195913.GI1587915@frogsfrogsfrogs> <CAJnrk1ZT8w6p3Mnqx8R3dWUF1NFOYT95tkKFq5LGcS4=01fGsg@mail.gmail.com>
In-Reply-To: <CAJnrk1ZT8w6p3Mnqx8R3dWUF1NFOYT95tkKFq5LGcS4=01fGsg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 3 Oct 2025 18:11:46 -0700
X-Gm-Features: AS18NWBK4HC9BGpRE6C1zBBeHEWzv0WiMOcZUgcfeGJPNXvBrfXXNYrG_x2NsQA
Message-ID: <CAJnrk1ayPGD5h+zHzHrdW5CvyJuhEZ38DD1+ZqAK3vo46wtd=A@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] iomap: refactor dirty bitmap iteration
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, linux-mm@kvack.org, brauner@kernel.org, 
	willy@infradead.org, jack@suse.cz, hch@infradead.org, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 3:27=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> On Wed, Sep 3, 2025 at 12:59=E2=80=AFPM Darrick J. Wong <djwong@kernel.or=
g> wrote:
> >
> > On Wed, Sep 03, 2025 at 02:53:33PM -0400, Brian Foster wrote:
> > > On Fri, Aug 29, 2025 at 04:39:40PM -0700, Joanne Koong wrote:
> > > > Use find_next_bit()/find_next_zero_bit() for iomap dirty bitmap
> > > > iteration. This uses __ffs() internally and is more efficient for
> > > > finding the next dirty or clean bit than manually iterating through=
 the
> > > > bitmap range testing every bit.
> > > >
> > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > > > ---
> > > >  fs/iomap/buffered-io.c | 67 ++++++++++++++++++++++++++++++--------=
----
> > > >  1 file changed, 48 insertions(+), 19 deletions(-)
> > > >
> > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > > index fd827398afd2..dc1a1f371412 100644
> > > > --- a/fs/iomap/buffered-io.c
> > > > +++ b/fs/iomap/buffered-io.c
>
> Sorry for the late reply on this, I didn't realize you and Brian had
> commented on this.
>
> I'm going to pull this and the next patch (the uptodate bitmap
> refactoring one) out of this series and put them instead on top of
> this other patchset that does some other optimizations.
>
> > > >
> > > >  static unsigned ifs_find_dirty_range(struct folio *folio,
> > > > @@ -92,18 +121,15 @@ static unsigned ifs_find_dirty_range(struct fo=
lio *folio,
> > > >             offset_in_folio(folio, *range_start) >> inode->i_blkbit=
s;
> > > >     unsigned end_blk =3D min_not_zero(
> > > >             offset_in_folio(folio, range_end) >> inode->i_blkbits,
> > > > -           i_blocks_per_folio(inode, folio));
> > > > -   unsigned nblks =3D 1;
> > > > +           i_blocks_per_folio(inode, folio)) - 1;
> > > > +   unsigned nblks;
> > > >
> > > > -   while (!ifs_block_is_dirty(folio, ifs, start_blk))
> > > > -           if (++start_blk =3D=3D end_blk)
> > > > -                   return 0;
> > > > +   start_blk =3D ifs_next_dirty_block(folio, start_blk, end_blk);
> > > > +   if (start_blk > end_blk)
> > > > +           return 0;
> > > >
> > > > -   while (start_blk + nblks < end_blk) {
> > > > -           if (!ifs_block_is_dirty(folio, ifs, start_blk + nblks))
> > > > -                   break;
> > > > -           nblks++;
> > > > -   }
> > > > +   nblks =3D ifs_next_clean_block(folio, start_blk + 1, end_blk)
> > > > +           - start_blk;
> > >
> > > Not a critical problem since it looks like the helper bumps end_blk, =
but
> > > something that stands out to me here as mildly annoying is that we ch=
eck
> > > for (start > end) just above, clearly implying that start =3D=3D end =
is
> > > possible, then go and pass start + 1 and end to the next call. It's n=
ot
> > > clear to me if that's worth changing to make end exclusive, but may b=
e
> > > worth thinking about if you haven't already..
>
> My thinking with having 'end' be inclusive is that it imo makes the
> interface a lot more intuitive.
>
> For example, for
>     next =3D ifs_next_clean_block(folio, start, end);
>
> with end being inclusive, then nothing in that range is clean if next > e=
nd
> Whereas with end being exclusive, that's only true if next >=3D end,
> which imo is more confusing.

Ah I guess for the exclusive case you could just write it as
     next =3D ifs_next_clean_block(folio, start, end + 1);
which would let you make the check "if (next > end)".

I'll play around with both versions and see which one looks better.
You and Darrick may be right that we should just make it exclusive.

Thanks,
Joanne

>
> If you and Darrick still much prefer having end be exclusive though,
> then I'm happy to make that change.
>
> >
> > <nod> I was also wondering if there were overflow possibilities here.
>
> I'm not sure what you had in mind for what would overflow, the end_blk
> being beyond the end of the bitmap? The
> find_next_bit()/find_next_zero_bit() interfaces protect against that.
> Or maybe you're referring to something else?
>
> >
> > > Brian
> > >
> > > >
> > > >     *range_start =3D folio_pos(folio) + (start_blk << inode->i_blkb=
its);
> > > >     return nblks << inode->i_blkbits;
> > > > @@ -1077,7 +1103,7 @@ static void iomap_write_delalloc_ifs_punch(st=
ruct inode *inode,
> > > >             struct folio *folio, loff_t start_byte, loff_t end_byte=
,
> > > >             struct iomap *iomap, iomap_punch_t punch)
> > > >  {
> > > > -   unsigned int first_blk, last_blk, i;
> > > > +   unsigned int first_blk, last_blk;
> > > >     loff_t last_byte;
> > > >     u8 blkbits =3D inode->i_blkbits;
> > > >     struct iomap_folio_state *ifs;
> > > > @@ -1096,10 +1122,13 @@ static void iomap_write_delalloc_ifs_punch(=
struct inode *inode,
> > > >                     folio_pos(folio) + folio_size(folio) - 1);
> > > >     first_blk =3D offset_in_folio(folio, start_byte) >> blkbits;
> > > >     last_blk =3D offset_in_folio(folio, last_byte) >> blkbits;
> > > > -   for (i =3D first_blk; i <=3D last_blk; i++) {
> > > > -           if (!ifs_block_is_dirty(folio, ifs, i))
> > > > -                   punch(inode, folio_pos(folio) + (i << blkbits),
> > > > -                               1 << blkbits, iomap);
> > > > +   while (first_blk <=3D last_blk) {
> > > > +           first_blk =3D ifs_next_clean_block(folio, first_blk, la=
st_blk);
> > > > +           if (first_blk > last_blk)
> > > > +                   break;
> >
> > I was wondering if the loop control logic would be cleaner done as a fo=
r
> > loop and came up with this monstrosity:
> >
> >         for (first_blk =3D ifs_next_clean_block(folio, first_blk, last_=
blk);
> >              first_blk <=3D last_blk;
> >              first_blk =3D ifs_next_clean_block(folio, first_blk + 1, l=
ast_blk)) {
> >                 punch(inode, folio_pos(folio) + (first_blk << blkbits),
> >                       1 << blkbits, iomap);
> >         }
> >
> > Yeah.... better living through macros?
> >
> > #define for_each_clean_block(folio, blk, last_blk) \
> >         for ((blk) =3D ifs_next_clean_block((folio), (blk), (last_blk))=
;
> >              (blk) <=3D (last_blk);
> >              (blk) =3D ifs_next_clean_block((folio), (blk) + 1, (last_b=
lk)))
> >
> > Somewhat cleaner:
> >
> >         for_each_clean_block(folio, first_blk, last_blk)
> >                 punch(inode, folio_pos(folio) + (first_blk << blkbits),
> >                       1 << blkbits, iomap);
> >
>
> Cool, this macro looks nice! I'll use this in the next version.
>
> Thanks,
> Joanne
>
> > <shrug>
> >
> > --D
> >

