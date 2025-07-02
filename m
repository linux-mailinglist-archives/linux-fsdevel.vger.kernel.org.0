Return-Path: <linux-fsdevel+bounces-53736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60613AF6452
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 23:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5F61C23128
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 21:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B21023F412;
	Wed,  2 Jul 2025 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxO0d7i3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E828F4F1;
	Wed,  2 Jul 2025 21:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751492876; cv=none; b=Pk+ADmLF+OJM5glybXK6uHcz3AkhjOgix9JJ5LJCnfoYtRsMPa1kgK3Mq+LvDcYMItoqpAQrE6SSqXH6igLLTdXBwdzNvVBURgz4/5UGnTkaGW6052g/KJzv+QQ/tMR2lJ7tLnHSb3kXkLdBGeYxQzuTTEoH96t71gcyRzVBBlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751492876; c=relaxed/simple;
	bh=3F0e4ClGzJgX/J6AnoNUdr6gzOEpfijU8HaAHHh0I0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhLNx9ihIUJ2qNQ5tHzW3ADoOZmF3V7C3EExVaZE8Jfg5Q1ooGzFmwDVbywhKqjYRDuyc1raXaMmYUqwOMb5GpYwftI/G0dSCek9I3hIq3THgb5n2kiYVeDnKgcUOQ8I+aKZyYRbIzZ1D+Skd6ZAKX9YJ60vkiesZdhVC1AwKJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxO0d7i3; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a5840ec53dso89437381cf.0;
        Wed, 02 Jul 2025 14:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751492873; x=1752097673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzvjFSwko+dMrc+VXfpopyy6igCQQKgZWqJ5p1e5f6w=;
        b=CxO0d7i3Xl0pSF3OVyXsgDKVfUZGryL2NHMEuXGjAuZhRKvV3fI7eB/aIjN6EWzKaR
         vNtsbaFYZ6G8VF/XEGOGrOv97SE1bNGoDNBoWu89fpSQgEZCcOYfYg0+Ggs37ktzhvcS
         If64MhVaqsV9muDGq8NNBb7uUcDc1OdDC0I/foAtG4GV2rSWpf7vQq6AWsRQIzfDM+pU
         2LV0bG6CTJR5IQMrSHHoy9pELk5w4g9fbaM+ZtF5rnriVAdrvKdwTNhvsdggPyPjxdDW
         LLGLomxAPvGV8Wry63UmE/aOsru9+AMFCQQLmzp3aNfWm8aam6PIIcnvuPm3ryb3b4hP
         Vpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751492873; x=1752097673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzvjFSwko+dMrc+VXfpopyy6igCQQKgZWqJ5p1e5f6w=;
        b=pLVjgoiE7fmDMxHaVja5ioVQZf/oh5o4lI6jRgf/SkTowP87bG4wRH5T5P0ims45Jx
         Q6qAbk4QBsTCHg9XahkLfbBT1Mw6ITaZK1HsRePrh09/O78ez/SL9LcAHYI/M6ruC3Uh
         e29G3yCUPLOskldsB0dqWMqu/zSOdJK8Ngmu4hHEXo9YEBD5ymX7CyXdOHacBjTWd7Pp
         kzs91A+0NN4lft+fctPUAm90DMd5qPzsg34vee6I6ED7WMYcJ2Bi2w5InY6TqDhfRv+E
         eRYiRhBmdfzFOautDiExbHHzyIO8cF8j29xKQ7hZaX2jf+hWgomD9/5xhj3wInafAKEx
         y1EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDddxioRNAoJDJkXih9HSGNkfTLQcTR2RN7KCO3EL8mRpihWX20MRDixJk9EnglVboSI7k3ZjV0MpZsA==@vger.kernel.org, AJvYcCVRgFmoTuzhBryo3YbJEEVYaAKmfjzlnmJk9M7wBE0/1gOfh+UW9CAwMuiS6Kb57zMpEQeqU8pD9k2C@vger.kernel.org, AJvYcCWw+nDJXUYfVNGllRcZ2+vGikPhMOMgwVV90i5eJAHRK68POIre867cvMnw0WRkKGaymdSSijAALRey@vger.kernel.org, AJvYcCXObC2MnaN2/OtlGJy9ecYiHWWy5iXwHBAvXURjUQA4ijvHXEy0jeYeFRrXsxT3mmQ2ZlFXAho0ll4d0dqzhw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yze4GOGcxlaL2NEFG1CIFHMod+Lt66JYvfqhFOlACgms7eDZmnO
	ZxY90bz8rhJZJ2BzPF9oVWW+wtwmyCG8vRgwIx6A6aZf/gCl5uasHcca9+PD7m3kONX2BKKwpEU
	V+ndLAAz76FxJ+BgaRsucANFBcPDaDOU=
X-Gm-Gg: ASbGnct1DSVu5PLmrV7Lfy6LG6zTD30tQc9iqqfXM/WblrsFKJQPrdAmsRhcUn3ZtX4
	wVkaOUr9HB6XJJkbB+/eROUWLDscRDe0l/cb82TUT9/LWzP2xp/+TDVVA0fVhkcsOkYySFm2w/t
	ZjVOgbVmbi5Xho1RBYmzxVtUIo7FnCweG/wui4BQbnuAhx/XhMdtEADAoqcbkmHN0dQs/bbw==
X-Google-Smtp-Source: AGHT+IG8NcRgD8HjsYiMmdTDaNKZPb9NcZq/V1BCtOww+6YZ0E97J6rokogv4y/jJOKonqENm32mK1l2oO6j6tLbRnY=
X-Received: by 2002:ac8:7f88:0:b0:4a7:8916:90a1 with SMTP id
 d75a77b69052e-4a97694b788mr64158191cf.22.1751492872931; Wed, 02 Jul 2025
 14:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-6-joannelkoong@gmail.com>
 <aEZoau3AuwoeqQgu@infradead.org> <20250609171444.GL6156@frogsfrogsfrogs>
 <aEetuahlyfHGTG7x@infradead.org> <aEkHarE9_LlxFTAi@casper.infradead.org>
 <ac1506958d4c260c8beb6b840809e1bc8167ba2a.camel@kernel.org>
 <aFWlW6SUI6t-i0dN@casper.infradead.org> <CAJnrk1b3HfGOAkxXrJuhm3sFfJDzzd=Z7vQbKk3HO_JkGAxVuQ@mail.gmail.com>
 <aFuWhnjsKqo6ftit@infradead.org> <CAJnrk1Zud2V5fn5SB6Wqbk8zyOFrD_wQp7B5jDBnUXiGyiJPvQ@mail.gmail.com>
 <20250701054101.GE10035@frogsfrogsfrogs> <CAJnrk1bRL47BawgTCjLdrsuK=hpd+zkRwA+ZgLDUN7GzzJzNxw@mail.gmail.com>
In-Reply-To: <CAJnrk1bRL47BawgTCjLdrsuK=hpd+zkRwA+ZgLDUN7GzzJzNxw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 2 Jul 2025 14:47:42 -0700
X-Gm-Features: Ac12FXym-R9az5mneQ_EpRVW06KPBGyYF3nzRvjGnvd59Swbs2wunS06cNQoyGo
Message-ID: <CAJnrk1bWe7MNQGrSDgRaX4L1fEcwqzz2tqOCKv8DfySnFS8GRQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] iomap: add iomap_writeback_dirty_folio()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 2:36=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> On Mon, Jun 30, 2025 at 10:41=E2=80=AFPM Darrick J. Wong <djwong@kernel.o=
rg> wrote:
> >
> > On Wed, Jun 25, 2025 at 09:44:31AM -0700, Joanne Koong wrote:
> > > On Tue, Jun 24, 2025 at 11:26=E2=80=AFPM Christoph Hellwig <hch@infra=
dead.org> wrote:
> > > >
> > > > On Tue, Jun 24, 2025 at 10:26:01PM -0700, Joanne Koong wrote:
> > > > > > The question is whether this is acceptable for all the filesyst=
em
> > > > > > which implement ->launder_folio today.  Because we could just m=
ove the
> > > > > > folio_test_dirty() to after the folio_lock() and remove all the=
 testing
> > > > > > of folio dirtiness from individual filesystems.
> > > > >
> > > > > Or could the filesystems that implement ->launder_folio (from wha=
t I
> > > > > see, there's only 4: fuse, nfs, btrfs, and orangefs) just move th=
at
> > > > > logic into their .release_folio implementation? I don't see why n=
ot.
> > > > > In folio_unmap_invalidate(), we call:
> > > >
> > > > Without even looking into the details from the iomap POV that basic=
ally
> > > > doesn't matter.  You'd still need the write back a single locked fo=
lio
> > > > interface, which adds API surface, and because it only writes a sin=
gle
> > > > folio at a time is rather inefficient.  Not a deal breaker because
> > > > the current version look ok, but it would still be preferable to no=
t
> > > > have an extra magic interface for it.
> > > >
> > >
> > > Yes but as I understand it, the focus right now is on getting rid of
> > > ->launder_folio as an API. The iomap pov imo is a separate issue with
> > > determining whether fuse in particular needs to write back the dirty
> > > page before releasing or should just fail.
> >
> > This might not help for Joanne's case, but so far the lack of a
> > launder_folio in my fuse+iomap prototype hasn't hindered it at all.
> > From what I can tell it's ok to bounce EBUSY back to dio callers...
> >
> > > btrfs uses ->launder_folio() to free some previously allocated
> > > reservation (added in commit 872617a "btrfs: implement launder_folio
> > > for clearing dirty page reserve") so at the very least, that logic
> > > would need to be moved to .release_folio() (if that suffices? Adding
> > > the btrfs group to cc). It's still vague to me whether
> > > fuse/nfs/orangefs need to write back the dirty page, but it seems fin=
e
> >
> > ...but only because a retry will initiate another writeback so
> > eventually we can make some forward progress.  But it helps a lot that
> > fuse+iomap is handing the entire IO stack over to iomap.
> >
> > > to me not to - as I understand it, the worst that can happen (and
> > > please correct me if I'm wrong here, Matthew) from just failing it
> > > with -EBUSY is that the folio lingers longer in the page cache until
> > > it eventually gets written back and cleared out, and that only happen=
s
> > > if the file is mapped and written to in that window between
> > > filemap_write_and_wait_range() and unmap_mapping_folio(). afaics, if
> > > fuse/nfs/orangefs do need to write back the dirty folio instead of
> > > failing w/ -EBUSY, they could just do that logic in .release_folio.
> >
> > What do you do in ->release_folio if writeback fails?  Redirty it and
> > return false?
>
> Yeah, I was thinking we just redirty it and return false. I don't
> think that leads to any deviation from existing behavior (eg in
> folio_unmap_invalidate(), a failed writeback will return -EBUSY
> regardless of whether the writeback attempt happens from
> ->launder_folio() or ->release_folio()).

Or actually I guess the one deviation is that with ->launder_folio()
it can return back a custom error code (eg -ENOMEM) to
folio_unmap_invalidate() whereas release_folio() errors will default
to -EBUSY, but the error code propagated to folio->mapping will be the
same.
> >
> > --D

