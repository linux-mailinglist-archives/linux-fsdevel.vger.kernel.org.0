Return-Path: <linux-fsdevel+bounces-60232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CF1B42E4B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 02:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42900563D80
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 00:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BFD18C332;
	Thu,  4 Sep 2025 00:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg+xq/FJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317F2502BE
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 00:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756946166; cv=none; b=L2KPTIDdCFfodqqF3H7NGnWObk2i3DLktJ6KYiDRMeaVxCSC49EFNL2O2szSHsMjPZ1qiJFNXmrQR7wamMtGTLnEMx9/4kewNhTP1c4ecCFJhKf5SemKeKUUaaXRMNriyuQ6KzK1TSArhIhQEbKfTGJMIKeDdvGizKTvW50I6uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756946166; c=relaxed/simple;
	bh=0LEugKspjlHqRkweNmjsbsqi4UnYn+9Ib+HIr4QsVqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ne7ILdSx436PPkDAX7zveJFPshjE0mACTYluQ52U9XQ1IwDFildRkz5ZpIMXyL9/6zIpXZjcd54UFeHHSEJVpj8iA3QoCFHhFgfPU5DtxaiDRls0TToli8ZsPFPBf1L4E3U4UTP943bR2v4bgDoi9+X3KG+71+yZ1yO1w3lYEN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yg+xq/FJ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-80597face96so52526685a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 17:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756946164; x=1757550964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxvKMDBteBaFSXXMAlTTXAOeze6jB8TNVMDDZC5HWuc=;
        b=Yg+xq/FJQ8AwDZz1NGoBPvU1a77/Ms9bSwbUtB3yoF3Uvjhh4dDKLJv1RTkdF0Z+P1
         liSMz6qarglpU/W1Bg7xkDLC2Q6tQ1b4t7XYrl+Swyv+Shw+pLxEo0TMyPVKC3gL9mYs
         l1emEGRvvgfJOv0kSsKmIhoytHwIi7nUYXRNrECxgj0TgTnErwlcwYeptxMXkMQByuRP
         ma0KuwZVRGAy9liZBk6xkd3QLcyARvC6zDyoEntp6rmco4Ohb2addNbH5009F2maHJ4M
         q/ukpzA+UyxQoUHJ72F1CgdwFYlDGK9/NoHixpXHdQ7CSRHTBFd/SClGTK9YxVUptYLc
         GC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756946164; x=1757550964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxvKMDBteBaFSXXMAlTTXAOeze6jB8TNVMDDZC5HWuc=;
        b=ZG6IdB47+W2Nki5aC0r3g27EqoGspGeJQoXTIMOkUiqInH92Slo3HoETrtzKahC3w7
         +ob2LSLDYzklurMohfnf/TIpFRo3NSjQhenLwz527E5yNeJ8W9P7FMvoPEvHe3siAy6s
         eZzsetCfWZBY4QFAwCVLWA5VRL9fMKQA7TdDTqb0QKn79o/n1oQe2+VyRCIDZo4UQVhf
         6qg0snH7ivUAde0VXpGemkjQrI7gF/5XvBYg1htCxTgnlLKh++OdrUjvrWA+ajRXtCuG
         jEGkTeY25B5gNrueSkKILbDcMaK7AX6DruEwrUygCN/y+h0pbrHLAyd7kd213uMXS+cF
         tzGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0v9GDOwDxNpVsdOqahOzV00AZu3XBOzsLHuTrLwdKk/YQXh1a6mhbWYnENXqrUsyL4eJPZKoKZXBgTdTe@vger.kernel.org
X-Gm-Message-State: AOJu0YyhGhqJ76PnhSV09jaU09hw2q7/UX2ecVVQS8r28yk2i/rfR0qf
	ZtpPzuf//7nSwhNvfKHCa32LyWU5tXbBkFgueUK72Y17GqVBELJGPFY5AMskDzkrIl5iefPfHKl
	j0vCwwcItG+SWeb6fwI7hUaSJpucQB40=
X-Gm-Gg: ASbGncsaDfUvq+4hQBMgCaIplvsJ8fn6URDg7lCnqb/1txik3/dqbYI1uqoV9dyUmXE
	AQOZGJyHeUAhZpLqA9oGb1KObpiQ6gU3AByw05ptpFPgeIe4JPz/41PlRMtKKKIbtpNweR8BNSd
	n6HH11v0JucIwnGl9nSgc1e0UBaNMOjxNZioFGbAi8LEse2PN42K49je2YgfygZwcuglhMBQeeH
	g7I8VUIMUy/vUGrP4E=
X-Google-Smtp-Source: AGHT+IFq/F2Sam+4NOp0z4+zy2UJzABdxTMpBfQMbHdmyiFJ7iPaAvDn2bswJosndms30eVWIDadlwUxUBeZy/kQMIU=
X-Received: by 2002:a05:620a:7101:b0:80a:72d7:f0da with SMTP id
 af79cd13be357-80a72d7f181mr680707085a.73.1756946163875; Wed, 03 Sep 2025
 17:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
 <20250829233942.3607248-13-joannelkoong@gmail.com> <20250902234604.GC1587915@frogsfrogsfrogs>
 <aLiNYdLaMIslxySo@bfoster>
In-Reply-To: <aLiNYdLaMIslxySo@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 3 Sep 2025 17:35:51 -0700
X-Gm-Features: Ac12FXwY3PDGqO3cWcWewqS3_uvz7ErKO_WyD1D_aUPlmd9OdplVHaXualv0wko
Message-ID: <CAJnrk1Z6qKqkOwHJwaBfE9FEGABGD4JKoEwNbRJTpOWL-VtPrg@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] iomap: add granular dirty and writeback accounting
To: Brian Foster <bfoster@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org, brauner@kernel.org, 
	willy@infradead.org, jack@suse.cz, hch@infradead.org, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:44=E2=80=AFAM Brian Foster <bfoster@redhat.com> w=
rote:
>
> On Tue, Sep 02, 2025 at 04:46:04PM -0700, Darrick J. Wong wrote:
> > On Fri, Aug 29, 2025 at 04:39:42PM -0700, Joanne Koong wrote:
> > > Add granular dirty and writeback accounting for large folios. These
> > > stats are used by the mm layer for dirty balancing and throttling.
> > > Having granular dirty and writeback accounting helps prevent
> > > over-aggressive balancing and throttling.
> > >
> > > There are 4 places in iomap this commit affects:
> > > a) filemap dirtying, which now calls filemap_dirty_folio_pages()
> > > b) writeback_iter with setting the wbc->no_stats_accounting bit and
> > > calling clear_dirty_for_io_stats()
> > > c) starting writeback, which now calls __folio_start_writeback()
> > > d) ending writeback, which now calls folio_end_writeback_pages()
> > >
> > > This relies on using the ifs->state dirty bitmap to track dirty pages=
 in
> > > the folio. As such, this can only be utilized on filesystems where th=
e
> > > block size >=3D PAGE_SIZE.
> >
> > Er... is this statement correct?  I thought that you wanted the granula=
r
> > dirty page accounting when it's possible that individual sub-pages of a
> > folio could be dirty.
> >
> > If i_blocksize >=3D PAGE_SIZE, then we'll have set the min folio order =
and
> > there will be exactly one (large) folio for a single fsblock.  Writebac=
k

Oh interesting, this is the part I'm confused about. With i_blocksize
>=3D PAGE_SIZE, isn't there still the situation where the folio itself
could be a lot larger, like 1MB? That's what I've been seeing on fuse
where "blocksize" =3D=3D PAGE_SIZE =3D=3D 4096. I see that xfs sets the min
folio order through mapping_set_folio_min_order() but I'm not seeing
how that ensures "there will be exactly one large folio for a single
fsblock"? My understanding is that that only ensures the folio is at
least the size of the fsblock but that the folio size can be larger
than that too. Am I understanding this incorrectly?

> > must happen in units of fsblocks, so there's no point in doing the extr=
a
> > accounting calculations if there's only one fsblock.
> >
> > Waitaminute, I think the logic to decide if you're going to use the
> > granular accounting is:
> >
> >       (folio_size > PAGE_SIZE && folio_size > i_blocksize)
> >

Yeah, you're right about this - I had used "ifs && i_blocksize >=3D
PAGE_SIZE" as the check, which translates to "i_blocks_per_folio > 1
&& i_block_size >=3D PAGE_SIZE", which in effect does the same thing as
what you wrote but has the additional (and now I'm realizing,
unnecessary) stipulation that block_size can't be less than PAGE_SIZE.

> > Hrm?
> >
>
> I'm also a little confused why this needs to be restricted to blocksize
> gte PAGE_SIZE. The lower level helpers all seem to be managing block
> ranges, and then apparently just want to be able to use that directly as
> a page count (for accounting purposes).
>
> Is there any reason the lower level functions couldn't return block
> units, then the higher level code can use a blocks_per_page or some such
> to translate that to a base page count..? As Darrick points out I assume
> you'd want to shortcut the folio_nr_pages() =3D=3D 1 case to use a min pa=
ge
> count of 1, but otherwise ISTM that would allow this to work with
> configs like 64k pagesize and 4k blocks as well. Am I missing something?
>

No, I don't think you're missing anything, it should have been done
like this in the first place.

> Brian
>
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  fs/iomap/buffered-io.c | 140 ++++++++++++++++++++++++++++++++++++++-=
--
> > >  1 file changed, 132 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index 4f021dcaaffe..bf33a5361a39 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -20,6 +20,8 @@ struct iomap_folio_state {
> > >     spinlock_t              state_lock;
> > >     unsigned int            read_bytes_pending;
> > >     atomic_t                write_bytes_pending;
> > > +   /* number of pages being currently written back */
> > > +   unsigned                nr_pages_writeback;
> > >
> > >     /*
> > >      * Each block has two bits in this bitmap:
> > > @@ -139,6 +141,29 @@ static unsigned ifs_next_clean_block(struct foli=
o *folio,
> > >             blks + start_blk) - blks;
> > >  }
> > >
> > > +static unsigned ifs_count_dirty_pages(struct folio *folio)
> > > +{
> > > +   struct inode *inode =3D folio->mapping->host;
> > > +   unsigned block_size =3D i_blocksize(inode);
> > > +   unsigned start_blk, end_blk;
> > > +   unsigned blks, nblks =3D 0;
> > > +
> > > +   start_blk =3D 0;
> > > +   blks =3D i_blocks_per_folio(inode, folio);
> > > +   end_blk =3D (i_size_read(inode) - 1) >> inode->i_blkbits;
> > > +   end_blk =3D min(end_blk, i_blocks_per_folio(inode, folio) - 1);
> > > +
> > > +   while (start_blk <=3D end_blk) {
> > > +           start_blk =3D ifs_next_dirty_block(folio, start_blk, end_=
blk);
> > > +           if (start_blk > end_blk)
> > > +                   break;
> >
> > Use your new helper?
> >
> >               nblks =3D ifs_next_clean_block(folio, start_blk + 1,
> >                               end_blk) - start_blk?
> > > +           nblks++;
> > > +           start_blk++;
> > > +   }
> > > +
> > > +   return nblks * (block_size >> PAGE_SHIFT);
> >
> > I think this returns the number of dirty basepages in a given large
> > folio?  If that's the case then shouldn't this return long, like
> > folio_nr_pages does?
> >
> > > +}
> > > +
> > >  static unsigned ifs_find_dirty_range(struct folio *folio,
> > >             struct iomap_folio_state *ifs, u64 *range_start, u64 rang=
e_end)
> > >  {
> > > @@ -220,6 +245,58 @@ static void iomap_set_range_dirty(struct folio *=
folio, size_t off, size_t len)
> > >             ifs_set_range_dirty(folio, ifs, off, len);
> > >  }
> > >
> > > +static long iomap_get_range_newly_dirtied(struct folio *folio, loff_=
t pos,
> > > +           unsigned len)
> >
> > iomap_count_clean_pages() ?

Nice, a much clearer name.

I'll make the suggestions you listed above too, thanks for the pointers.

Thanks for taking a look at this, Darrick and Brian!
> >
> > --D
> >

