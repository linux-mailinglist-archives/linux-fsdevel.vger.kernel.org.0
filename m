Return-Path: <linux-fsdevel+bounces-63414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CB7BB8530
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 00:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F1E74EFB5B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 22:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA79928D84F;
	Fri,  3 Oct 2025 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmIy24l6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4A3289374
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 22:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759530492; cv=none; b=FDFnklzhrvK2MdQ+bTm8+1vOXcPzp2/CUVUGODV8hVYLSldwPnZhmO9a7uPTTBvWiqSKlVphWPFtlr/fHyJLjsXfcVvsG/2uy4V63IG5/l8sA5lZ+g/g5xziJztBVQ2oAXTABeofA11JzSRuB4FWcsUrZ8zA7RHqujytfHegqtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759530492; c=relaxed/simple;
	bh=7yNexokwfYgH5UzPI0yK7HWgKr/le2gf4eF7yR40vb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkkwkTqL/WrW8h7PnI5hr0bqpLovUeqjSHiBIeZ/PdwzJXM89iqjlzR6TokAaHpFVAHsPhDARYVlU1vjqEVVWQU1qBzsiuyLsNgdpMPrvzYccpYQSnXCT6S2NLddLacmK/IKwubDukgv+OlBlqN0o/srRnHlFR5J8SItjmaAhy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmIy24l6; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4de8bd25183so38721721cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 15:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759530488; x=1760135288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsrTjFioBDXPrtMuXAmVmhBbhuBxugl8WE75QZEEBM8=;
        b=AmIy24l6aVxfeQ+Bzf1oy0dCu1P+ioJDDXHFBoJ64IBTKvuJYRFJuZ/SPRoU9nsIz2
         yupEvKA9MvSH/1hG1sajcZNwrG+6dhPq0+s09aQXMOgwp8nrt5awwJm2SYKo4LrVYlma
         phhJGatZbc7R158TkWQ/n0qvBTYcY3PAjIztpDojLgeBEGwXPMdUN4+0zhv2SqEPJ0+e
         uDlTfz2qtILl/2l6wVvqLqb906vwXBSaST2Mv9EqDg/neeXPL1tH0ResYH2SJ/nmA80M
         xi3Td+rGUxImBdO/Kg9dqVZgQsrtQM4Hu+uCmkvxWHFPFuC8VHfTENov58zgOKLADBaC
         4mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759530488; x=1760135288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsrTjFioBDXPrtMuXAmVmhBbhuBxugl8WE75QZEEBM8=;
        b=syfEe9t876h67IFsmnsk19xQthl/a/l9IMEXAMqAeqiCGadUXL2xl+qgg51ohmYcQW
         OZc+XyLMdtf4ouMgJCSmKL3SJsq/o0JojFgDlCV8gPO7oqfGa75KlFbVAmWyHSDWrwHp
         OoIfJzxWZnGI268rWI/K/p+DbxiQhQmaOgCLE/WRqeCBe3GVxmszjn0oAE/aoMDtlLWJ
         Ve2WIPdisjz/t9F2cvFL27mV2gpXHuV1+fMvuDxW5SoM6jGk9n+PyS8rSClPc8RxzkCs
         riHe2x1Ic4fLDwtzCpx6zWZyKfNl/gTrS/JrYlB7lAXEXvTTbB9UCeGRcRg+LTwEzHFv
         vB2g==
X-Forwarded-Encrypted: i=1; AJvYcCWMbh62zIM+c9wn/kkgfGV01PXv0FUk1OCr+5ssVeOfjDog7dZbgm73VOwYDtePqdpPhGPm0Nc+Vp9uSMt4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk6Cl090QraczQTB7X92ioIEILU4RoPmy18zT8XYnLteM/O3nE
	6SGMQqMx4n+240hq2uN3gq0QiWU/t9ukrUqryw5AFt/VscSVZ1pmGAtSB7jTfABzE+RBKsR3I8r
	ydviBJPDLUoHFfYb3SivuCP5fKGnsK3w=
X-Gm-Gg: ASbGnctD30O4D6ZaQl0mUPN9dKneaPacOJnvGsaAAYF07mjzrVUcl27HEMWLD6YdqH5
	UD/XmVjBpZ6nd64B7cbfvB9C5GbOjo+9iM6M1vEBrdg0dJmkkHX3d7Z+z/CNPBW4Y8MzrXiyjtl
	IFg9g3/9Gup8ikkHfbumL/03OqA8MLgqy8x5aRdw+3i47rwm+YgYosy4aLRvWDum0IqSGzFkOpu
	MQ86vx0EWdELXMuztkmk9sGxtFGXYvOVEBL2OTGx/BvD4cDLBJaEtIosBkrJTwmJGC6FkFTng==
X-Google-Smtp-Source: AGHT+IEZXwB540cqRy8ufe9EvtDcaXb1ZxNBsYiEfhRvJvMgYSfsbmIjKWzMnu3HjZAnRxDOgf8vaW0o0avV6CEzCVs=
X-Received: by 2002:a05:622a:728d:b0:4dd:7572:216f with SMTP id
 d75a77b69052e-4e57e29e758mr27614521cf.32.1759530488122; Fri, 03 Oct 2025
 15:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
 <20250829233942.3607248-11-joannelkoong@gmail.com> <aLiOrcetNAvjvjtk@bfoster> <20250903195913.GI1587915@frogsfrogsfrogs>
In-Reply-To: <20250903195913.GI1587915@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 3 Oct 2025 15:27:57 -0700
X-Gm-Features: AS18NWDO6cSZMS7k5N8NjuFZJ24A4w4G8fBvn2duyG_c1N7JYvgnUloVpDvQoYo
Message-ID: <CAJnrk1ZT8w6p3Mnqx8R3dWUF1NFOYT95tkKFq5LGcS4=01fGsg@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] iomap: refactor dirty bitmap iteration
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, linux-mm@kvack.org, brauner@kernel.org, 
	willy@infradead.org, jack@suse.cz, hch@infradead.org, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 12:59=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Sep 03, 2025 at 02:53:33PM -0400, Brian Foster wrote:
> > On Fri, Aug 29, 2025 at 04:39:40PM -0700, Joanne Koong wrote:
> > > Use find_next_bit()/find_next_zero_bit() for iomap dirty bitmap
> > > iteration. This uses __ffs() internally and is more efficient for
> > > finding the next dirty or clean bit than manually iterating through t=
he
> > > bitmap range testing every bit.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > > ---
> > >  fs/iomap/buffered-io.c | 67 ++++++++++++++++++++++++++++++----------=
--
> > >  1 file changed, 48 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index fd827398afd2..dc1a1f371412 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c

Sorry for the late reply on this, I didn't realize you and Brian had
commented on this.

I'm going to pull this and the next patch (the uptodate bitmap
refactoring one) out of this series and put them instead on top of
this other patchset that does some other optimizations.

> > >
> > >  static unsigned ifs_find_dirty_range(struct folio *folio,
> > > @@ -92,18 +121,15 @@ static unsigned ifs_find_dirty_range(struct foli=
o *folio,
> > >             offset_in_folio(folio, *range_start) >> inode->i_blkbits;
> > >     unsigned end_blk =3D min_not_zero(
> > >             offset_in_folio(folio, range_end) >> inode->i_blkbits,
> > > -           i_blocks_per_folio(inode, folio));
> > > -   unsigned nblks =3D 1;
> > > +           i_blocks_per_folio(inode, folio)) - 1;
> > > +   unsigned nblks;
> > >
> > > -   while (!ifs_block_is_dirty(folio, ifs, start_blk))
> > > -           if (++start_blk =3D=3D end_blk)
> > > -                   return 0;
> > > +   start_blk =3D ifs_next_dirty_block(folio, start_blk, end_blk);
> > > +   if (start_blk > end_blk)
> > > +           return 0;
> > >
> > > -   while (start_blk + nblks < end_blk) {
> > > -           if (!ifs_block_is_dirty(folio, ifs, start_blk + nblks))
> > > -                   break;
> > > -           nblks++;
> > > -   }
> > > +   nblks =3D ifs_next_clean_block(folio, start_blk + 1, end_blk)
> > > +           - start_blk;
> >
> > Not a critical problem since it looks like the helper bumps end_blk, bu=
t
> > something that stands out to me here as mildly annoying is that we chec=
k
> > for (start > end) just above, clearly implying that start =3D=3D end is
> > possible, then go and pass start + 1 and end to the next call. It's not
> > clear to me if that's worth changing to make end exclusive, but may be
> > worth thinking about if you haven't already..

My thinking with having 'end' be inclusive is that it imo makes the
interface a lot more intuitive.

For example, for
    next =3D ifs_next_clean_block(folio, start, end);

with end being inclusive, then nothing in that range is clean if next > end
Whereas with end being exclusive, that's only true if next >=3D end,
which imo is more confusing.

If you and Darrick still much prefer having end be exclusive though,
then I'm happy to make that change.

>
> <nod> I was also wondering if there were overflow possibilities here.

I'm not sure what you had in mind for what would overflow, the end_blk
being beyond the end of the bitmap? The
find_next_bit()/find_next_zero_bit() interfaces protect against that.
Or maybe you're referring to something else?

>
> > Brian
> >
> > >
> > >     *range_start =3D folio_pos(folio) + (start_blk << inode->i_blkbit=
s);
> > >     return nblks << inode->i_blkbits;
> > > @@ -1077,7 +1103,7 @@ static void iomap_write_delalloc_ifs_punch(stru=
ct inode *inode,
> > >             struct folio *folio, loff_t start_byte, loff_t end_byte,
> > >             struct iomap *iomap, iomap_punch_t punch)
> > >  {
> > > -   unsigned int first_blk, last_blk, i;
> > > +   unsigned int first_blk, last_blk;
> > >     loff_t last_byte;
> > >     u8 blkbits =3D inode->i_blkbits;
> > >     struct iomap_folio_state *ifs;
> > > @@ -1096,10 +1122,13 @@ static void iomap_write_delalloc_ifs_punch(st=
ruct inode *inode,
> > >                     folio_pos(folio) + folio_size(folio) - 1);
> > >     first_blk =3D offset_in_folio(folio, start_byte) >> blkbits;
> > >     last_blk =3D offset_in_folio(folio, last_byte) >> blkbits;
> > > -   for (i =3D first_blk; i <=3D last_blk; i++) {
> > > -           if (!ifs_block_is_dirty(folio, ifs, i))
> > > -                   punch(inode, folio_pos(folio) + (i << blkbits),
> > > -                               1 << blkbits, iomap);
> > > +   while (first_blk <=3D last_blk) {
> > > +           first_blk =3D ifs_next_clean_block(folio, first_blk, last=
_blk);
> > > +           if (first_blk > last_blk)
> > > +                   break;
>
> I was wondering if the loop control logic would be cleaner done as a for
> loop and came up with this monstrosity:
>
>         for (first_blk =3D ifs_next_clean_block(folio, first_blk, last_bl=
k);
>              first_blk <=3D last_blk;
>              first_blk =3D ifs_next_clean_block(folio, first_blk + 1, las=
t_blk)) {
>                 punch(inode, folio_pos(folio) + (first_blk << blkbits),
>                       1 << blkbits, iomap);
>         }
>
> Yeah.... better living through macros?
>
> #define for_each_clean_block(folio, blk, last_blk) \
>         for ((blk) =3D ifs_next_clean_block((folio), (blk), (last_blk));
>              (blk) <=3D (last_blk);
>              (blk) =3D ifs_next_clean_block((folio), (blk) + 1, (last_blk=
)))
>
> Somewhat cleaner:
>
>         for_each_clean_block(folio, first_blk, last_blk)
>                 punch(inode, folio_pos(folio) + (first_blk << blkbits),
>                       1 << blkbits, iomap);
>

Cool, this macro looks nice! I'll use this in the next version.

Thanks,
Joanne

> <shrug>
>
> --D
>

