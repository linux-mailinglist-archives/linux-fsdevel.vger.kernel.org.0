Return-Path: <linux-fsdevel+bounces-52841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFEBAE7668
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 07:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 906CC7AF73E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 05:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F61C1E25EB;
	Wed, 25 Jun 2025 05:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6TgFnhs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871551CAA7B;
	Wed, 25 Jun 2025 05:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750829175; cv=none; b=htnc/CvHisM8WXoMGD//3zZ1zBGkghgOLE8kxUI7xVMX9sFwZHSBf64F64McSLD67qjGalk9mgJtsGS6lRKJigZ9SF0cR/rJt0UsURb92EeOabGB1EhrDqUSZPFfXCeqkQJkdN/yDYa6yk19XkYkH+asdQb5rS5b2hpy1PPHOJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750829175; c=relaxed/simple;
	bh=bPkwXdejXFyRLQk4Xfroh5E1UVmTSiHpEgQNBAEuAaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1HBStqaKSU+Tg4uxpQnLG332y5+7c5Zlony59D9zQCLaW+PoCXp5MxQjoZph0MAb629cRwst/FN57n+Xt07DTmQbdb2uu1aON629mNf6M48SDgokmfJh6twWouJ4yaIdAL32FRVn+oBzwDfvYwHYgGpdDQiCUE+LlQbCyyTi1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6TgFnhs; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a77ea7ed49so6483031cf.0;
        Tue, 24 Jun 2025 22:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750829172; x=1751433972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q19p5suBBHA0FjneVX/xMy9RvFn5wRCXcx5IQP+EzHg=;
        b=R6TgFnhs5PBWfqVLJY1roA4FYpF7GCfslf182oISKTeCb9poHJ6S5tVw2ggouKzn9M
         JbieFhToWmRkDRjQEkeSMU5dL9rCrFA/OTbX6Lq1bJD4hlMQtxqOFIesNp5Bck5zk+/r
         5DL15HNS5aasOfEK5CA+0eS4EIq/0Lz3BUwRuJFMkgod8/xM/UUMbaA61j390/ZIYOqj
         ni4rXuSIE3Wo/wtEs6rHm/TLxU7lstIpnaQZrKjJ289HZxF2uJ4ka1rtRmTcUE3vrear
         /yDnEWzPbrARFvXQQcwtFjdopPyM4dRzs403l/RMFPPm5pfVsSvkgjWDLqti5uAaB2uW
         rLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750829172; x=1751433972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q19p5suBBHA0FjneVX/xMy9RvFn5wRCXcx5IQP+EzHg=;
        b=c3buDkXN6MPPjx2BmMm29mnjKks31rhsEWbEj1LX0cQnUUabBs+0jDqBFsHbecXE5i
         Vu2h+nrB7EfTfbqmJ9Z9P2L84CrIzHjCGTn0Bw7Gh7Q+755FAI3h8v4KjkUCtfd9f4aI
         uXURJqdDEM5OsoCVAKvUflz5e106IQQfOtdoWuRjRwgpddsO/G2w7LzNdb4rVg+A6Rly
         Gf15z3ZB2N2KaA8VCazOwIDaOb7CRWxKL7mgVidUZY8UgWp4Pe4Om22wUfUr9x4BswIB
         yE8dXTN3kKpwH7PdGcWWfySfvo6sbyWi4mcSNIa31RN4afTmufz6F50Viih2MuCx80gg
         8r4w==
X-Forwarded-Encrypted: i=1; AJvYcCU2P0pR+XRgnAbtlQpY7oaV8wwNjXjk0Zyh/EovpbgMF1f2SRKWGtq/1Ou8iy4pn6g8/gfPIJE351XQD62U@vger.kernel.org, AJvYcCXqYQ42P4Vf8G2sZ3GNJe2c12s46ScH1JP9H6jbPetHaWY0xgJAc+XX0efO1lw9U10Zgcw4mvAMAhgt@vger.kernel.org, AJvYcCXzdJsNmLIxE6nW/uaxFDaO1PmT+BNTkNj3alQr0Crwx7BQWM8WPHQQJUj2U2vQ/u0ltLf5JGfyogWM@vger.kernel.org
X-Gm-Message-State: AOJu0YwUJG7g0ZR8gP/DVQU+r4n41q2yUAmAwMbunTEMPzXdKdqBfyBc
	0dDqcOEdNQBqNntWmkPW3TKW87Mu6OfkV++092r8QU8v+xUplLuX7S00ZQOgmbrL7uZCSrmdSd3
	MnF5zrs2fFkh00Mw6DIYhpAXasnnDG1qwGmRFx5c=
X-Gm-Gg: ASbGncsTjDa2sY9lRD2AvsLMptNsPJiQiemHLGz/vMr36oM1hvhVgLcdL2Ol18yzk5r
	9qR252C1n3aEUcSZsi2DtyHm0wQiGDGCtIF3DOrjUxXjODxGEZVixfHNg4x/23XysNVAc3ZzjBO
	jGvC7WSTu9ZbBgNdxhAtTnsiuEEHQDJY7Y5ABhWZdWNe+V0lLuj6X/yb+rZ+c=
X-Google-Smtp-Source: AGHT+IEiQ+a522oTrm3IuhY8zn1XjaYyirkPysZnwpniD0hAuVUhEKLWjlac8HKEKxMvq2cb3MQTvH7foHDEY6LGtng=
X-Received: by 2002:ac8:7d82:0:b0:4a3:4412:dfcd with SMTP id
 d75a77b69052e-4a7c12d4c65mr28227151cf.22.1750829172310; Tue, 24 Jun 2025
 22:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-6-joannelkoong@gmail.com> <aEZoau3AuwoeqQgu@infradead.org>
 <20250609171444.GL6156@frogsfrogsfrogs> <aEetuahlyfHGTG7x@infradead.org>
 <aEkHarE9_LlxFTAi@casper.infradead.org> <ac1506958d4c260c8beb6b840809e1bc8167ba2a.camel@kernel.org>
 <aFWlW6SUI6t-i0dN@casper.infradead.org>
In-Reply-To: <aFWlW6SUI6t-i0dN@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 24 Jun 2025 22:26:01 -0700
X-Gm-Features: AX0GCFu34MAEFWyIgKGdiwLU6rAivs8LUjM5RQDY_BGwbOBM6uVGfN-_Vs0Q5y0
Message-ID: <CAJnrk1b3HfGOAkxXrJuhm3sFfJDzzd=Z7vQbKk3HO_JkGAxVuQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] iomap: add iomap_writeback_dirty_folio()
To: Matthew Wilcox <willy@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, miklos@szeredi.hu, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 11:15=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Wed, Jun 18, 2025 at 08:17:03AM -0400, Jeff Layton wrote:
> > On Wed, 2025-06-11 at 05:34 +0100, Matthew Wilcox wrote:
> > > On Mon, Jun 09, 2025 at 08:59:53PM -0700, Christoph Hellwig wrote:
> > > > On Mon, Jun 09, 2025 at 10:14:44AM -0700, Darrick J. Wong wrote:
> > > > > > Where "folio laundering" means calling ->launder_folio, right?
> > > > >
> > > > > What does fuse use folio laundering for, anyway?  It looks to me =
like
> > > > > the primary users are invalidate_inode_pages*.  Either the caller=
 cares
> > > > > about flushing dirty data and has called filemap_write_and_wait_r=
ange;
> > > > > or it doesn't and wants to tear down the pagecache ahead of some =
other
> > > > > operation that's going to change the file contents and doesn't ca=
re.
> > > > >
> > > > > I suppose it could be useful as a last-chance operation on a dirt=
y folio
> > > > > that was dirtied after a filemap_write_and_wait_range but before
> > > > > invalidate_inode_pages*?  Though for xfs we just return EBUSY and=
 let
> > > > > the caller try again (or not).  Is there a subtlety to fuse here =
that I
> > > > > don't know about?
> > > >
> > > > My memory might be betraying me, but I think willy once launched an
> > > > attempt to see if we can kill launder_folio.  Adding him, and the
> > > > mm and nfs lists to check if I have a point :)
> > >
> > > I ... got distracted with everything else.
> > >
> > > Looking at the original addition of ->launder_page (e3db7691e9f3), I
> > > don't understand why we need it.  invalidate_inode_pages2() isn't
> > > supposed to invalidate dirty pages, so I don't understand why nfs
> > > found it necessary to do writeback from ->releasepage() instead
> > > of just returning false like iomap does.
> > >
> > > There's now a new question of what the hell btrfs is up to with
> > > ->launder_folio, which they just added recently.
> >
> > IIRC...
> >
> > The problem was a race where a task could could dirty a page in a
> > mmap'ed file after it had been written back but before it was unmapped
> > from the pagecache.
> >
> > Bear in mind that the NFS client may need write back and then
> > invalidate the pagecache for a file that is still in use if it
> > discovers that the inode's attributes have changed on the server.
> >
> > Trond's solution was to write the page out while holding the page lock
> > in this situation. I think we'd all welcome a way to avoid this race
> > that didn't require launder_folio().
>
> I think the problem is that we've left it up to the filesystem to handle
> "what do we do if we've dirtied a page^W folio between, say, calling
> filemap_write_and_wait_range() and calling filemap_release_folio()".
> Just to make sure we're all on the same page here, this is the sample
> path I'm looking at:
>
> __iomap_dio_rw
>   kiocb_invalidate_pages
>     filemap_invalidate_pages
>       filemap_write_and_wait_range
>       invalidate_inode_pages2_range
>         unmap_mapping_pages
>         folio_lock
>         folio_wait_writeback
>         folio_unmap_invalidate
>           unmap_mapping_folio
>         folio_launder
>         filemap_release_folio
>         if (folio_test_dirty(folio))
>           return -EBUSY;
>
> So some filesystems opt to write back the folio which has been dirtied
> (by implementing ->launder_folio) and others opt to fail (and fall back t=
o
> buffered I/O when the user has requested direct I/O).  iomap filesystems
> all just "return false" for dirty folios, so it's clearly an acceptable
> outcome as far as xfstests go.
>
> The question is whether this is acceptable for all the filesystem
> which implement ->launder_folio today.  Because we could just move the
> folio_test_dirty() to after the folio_lock() and remove all the testing
> of folio dirtiness from individual filesystems.

Or could the filesystems that implement ->launder_folio (from what I
see, there's only 4: fuse, nfs, btrfs, and orangefs) just move that
logic into their .release_folio implementation? I don't see why not.
In folio_unmap_invalidate(), we call:

        ret =3D folio_launder(mapping, folio);
        if (ret)
                return ret;
        if (folio->mapping !=3D mapping)
                return -EBUSY;
        if (!filemap_release_folio(folio, gfp))
                return -EBUSY;

If fuse, nfs, btrfs, and orangefs absolutely need to do whatever logic
they're doing in .launder_folio, could they not just move it into
.release_folio?

>
> Or have I missed something and picked the wrong sample path for
> analysing why we do/don't need to writeback folios in
> invalidate_inode_pages2_range()?

