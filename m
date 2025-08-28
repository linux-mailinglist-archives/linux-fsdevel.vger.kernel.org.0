Return-Path: <linux-fsdevel+bounces-59453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C46B38F99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 02:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63AC1189EC09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 00:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37C112B73;
	Thu, 28 Aug 2025 00:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maXnkDOU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01012F32
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 00:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756339694; cv=none; b=b/TqhfKgnKVFYpOTeFMQPbdfOUW3A5WAynUb7SR3EbmvKusb/ZP72hFi8qTODG4VqljxloXaOn3JbEDDNZcM8owqGTYaJzQTeS7LEJBn8JcXtHjyXRDC7Ym5MGhunWI6+FZPMTZ3qbRoAkryIR+r33OWhMcC11P/m1ESoLG8plA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756339694; c=relaxed/simple;
	bh=PKkxxByaWX7ONyMiJDDL/r8G6ONhVWGRRaiH4Y8o61c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBxCiyoTm3q/089nEVeQinQe95IYOykCHMzTZkOCGr2AKStt3zTjYs6B0MWd0x7wF5b76/Z7n/rCGauM2Op7AHrTyeTtqrJ8Gcv/X/Y0Sgj9uxsThEHt1IHVdP1PObQXaB6FfxuXAgA/OVtnbYOTFozu0NMq0k1G3QCXWVLFmHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maXnkDOU; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b2979628f9so4164361cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 17:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756339691; x=1756944491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b36Nwls2M2gX56Ll9j62ZCf9y1Sd4pC4ay7N7C461Vo=;
        b=maXnkDOUY6OkXnIEaiVfda4ah201ofCI8/0hPFMkf7y+OnMIDhKClFgp9gO06UyNqV
         GKgAIzkerZ1D/iYobNnObemT2kWpw79XPl2B2jir5EpFVOEdjzVgkeb+PmY+vhzhix6S
         vVMN1BKXn7rXwH4GBPz87KTRG/FroaCVHhaeEOX7IDNcKfwvetvxXWpzqdSWZjPKdJR2
         ABIk15uVIfEFq0dQo+qhTcc6xHrPFNWhF0fFuyHp2K+m4XiKHxzEGZjmQtZtLl8CwjAp
         ol9TK1Hbkv2bN97M5emjiy4Sbdh90JmCJfem3LsMOyFdXojjwmFAADKYUB49V/KKo/mO
         Vznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756339691; x=1756944491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b36Nwls2M2gX56Ll9j62ZCf9y1Sd4pC4ay7N7C461Vo=;
        b=FC7WD0wDsUEgIjiY4vL98Ft+C4ufe1Q0noKnA1nFOc//GPT7sbo1wgtrbxHAw8Dsvd
         gprSdz269YEJSkCAvCfPgNq9mI4RWwUb/dxx2bs2dGSOO0NNBXYa1oGLkIr40X5lpD0J
         KAlEY3UU/5lS0Gq4WvKxv9YETGC/gGAwmWt02IYZiNlArGcspwiaeCdiWAOG1Lj4Tj0S
         t7rCiUW4fi+xIA3ryo4il3xqizrgImAKQXR4qTF/wFM+l3kpvqbW2C1iIH2+59sHWB4l
         zQu9MLpXqo1+GtozBMsNPkhPGpfZv8WnYaWfAG6Iwjs8dKTg2GNynDTQ5weU5ur+fEjF
         jzMg==
X-Forwarded-Encrypted: i=1; AJvYcCW9N5M7g72FhtUIBjXuJb9M9bYmekYyPvErsym9NlDLpq065noM7oK/XKpGQ+Yo88G7Kj+4l1WmGc12/UKu@vger.kernel.org
X-Gm-Message-State: AOJu0YxuOwVyxm5SO8LzCEwUcoiIskxcuvvDOFuBujpleDDzOHWyAsYj
	32uWEDxAVMPQiXBLx64GzYJkMUlQVApzMBZmk90UKYCwLeEAqDWiLeW/09JYqsq/4G98ghiZAI1
	FRffaGyKcqZuQcvNigC26aLYVf5TKKdo=
X-Gm-Gg: ASbGncuqwkIkV3m88U+kOdVLsSpeoJF1NLe+lIpgonr1JE/IW7YO4+s0N2z9Xap9vtD
	1fhRUgLKUXjtvGD0kLzWkwiZeTE566kNSnYKEhm81ivzgOB+ufwzgE35hqneUBzVicIGEp6exGt
	U/nrSx7k3397tXCoYFW/7gNleAYxsXGPCrePp1QK5bMUIgLX74CUVEkEQTBpepvG1n24j9Nvd7E
	i8hBNlGc76vbcQlz4blKWZYyQ7m2Q==
X-Google-Smtp-Source: AGHT+IEvEDydXznkcUnU+0JSU6x7dByI77Dd5uuLyP5MMNLK9cpd3c7pj4huvx9fk7DQobDzCWDAzLMQaz7dXW5dIfY=
X-Received: by 2002:a05:622a:1c15:b0:4b2:8ac5:259d with SMTP id
 d75a77b69052e-4b2aab57b30mr269660621cf.70.1756339691549; Wed, 27 Aug 2025
 17:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801002131.255068-1-joannelkoong@gmail.com>
 <20250801002131.255068-11-joannelkoong@gmail.com> <20250814163759.GN7942@frogsfrogsfrogs>
 <CAJnrk1a0vBqcbwDGnhr2A-H26Jr=0WauX7A2VLU9wvtV3UtpDQ@mail.gmail.com>
In-Reply-To: <CAJnrk1a0vBqcbwDGnhr2A-H26Jr=0WauX7A2VLU9wvtV3UtpDQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 27 Aug 2025 17:08:00 -0700
X-Gm-Features: Ac12FXwqLRXibxfrwhj_AuaJ3v6eBASHt1jSpfowrUPGFUx1R4A9sYyAIQxMccI
Message-ID: <CAJnrk1bqZzKvxxCrok2zqWoy8tXtY+hZF9kXa8PTWmZnihOMTw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 10/10] iomap: add granular dirty and writeback accounting
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-mm@kvack.org, brauner@kernel.org, willy@infradead.org, jack@suse.cz, 
	hch@infradead.org, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 11:38=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Thu, Aug 14, 2025 at 9:38=E2=80=AFAM Darrick J. Wong <djwong@kernel.or=
g> wrote:
> >
> > On Thu, Jul 31, 2025 at 05:21:31PM -0700, Joanne Koong wrote:
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
> > Apologies for my slow responses this month. :)
>
> No worries at all, thanks for looking at this.
> >
> > I wonder, does this cause an observable change in the writeback
> > accounting and throttling behavior for non-fuse filesystems like XFS
> > that use large folios?  I *think* this does actually reduce throttling
> > for XFS, but it might not be so noticeable because the limits are much
> > more generous outside of fuse?
>
> I haven't run any benchmarks on non-fuse filesystems yet but that's
> what I would expect too. Will run some benchmarks to see!

I ran some benchmarks on xfs for the contrived test case I used for
fuse (eg writing 2 GB in 128 MB chunks and then doing 50k 50-byte
random writes) and I don't see any noticeable performance difference.

I re-tested it on fuse but this time with strictlimiting disabled and
didn't notice any difference on that either, probably because with
strictlimiting off we don't run into the upper limit in that test so
there's no extra throttling that needs to be mitigated.

It's unclear to me how often (if at all?) real workloads run up
against their dirty/writeback limits.

>
> >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  fs/iomap/buffered-io.c | 136 ++++++++++++++++++++++++++++++++++++++-=
--
> > >  1 file changed, 128 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index bcc6e0e5334e..626c3c8399cc 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -20,6 +20,8 @@ struct iomap_folio_state {
> > >       spinlock_t              state_lock;
> > >       unsigned int            read_bytes_pending;
> > >       atomic_t                write_bytes_pending;
> > > +     /* number of pages being currently written back */
> > > +     unsigned                nr_pages_writeback;
> > >
> > >       /*
> > >        * Each block has two bits in this bitmap:
> > > @@ -81,6 +83,25 @@ static inline bool ifs_block_is_dirty(struct folio=
 *folio,
> > >       return test_bit(block + blks_per_folio, ifs->state);
> > >  }
> > >
> > > +static unsigned ifs_count_dirty_pages(struct folio *folio)
> > > +{
> > > +     struct iomap_folio_state *ifs =3D folio->private;
> > > +     struct inode *inode =3D folio->mapping->host;
> > > +     unsigned block_size =3D 1 << inode->i_blkbits;
> > > +     unsigned start_blk =3D 0;
> > > +     unsigned end_blk =3D min((unsigned)(i_size_read(inode) >> inode=
->i_blkbits),
> > > +                             i_blocks_per_folio(inode, folio));
> > > +     unsigned nblks =3D 0;
> > > +
> > > +     while (start_blk < end_blk) {
> > > +             if (ifs_block_is_dirty(folio, ifs, start_blk))
> > > +                     nblks++;
> > > +             start_blk++;
> > > +     }
> >
> > Hmm, isn't this bitmap_weight(ifs->state, blks_per_folio) ?
> >
> > Ohh wait no, the dirty bitmap doesn't start on a byte boundary because
> > the format of the bitmap is [uptodate bits][dirty bits].
> >
> > Maybe those two should be reversed, because I bet the dirty state gets
> > changed a lot more over the lifetime of a folio than the uptodate bits.
>
> I think there's the find_next_bit() helper (which Christoph also
> pointed out) that could probably be used here instead. Or at least
> that's how I see a lot of the driver code doing it for their bitmaps.

