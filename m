Return-Path: <linux-fsdevel+bounces-39936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD20A1A562
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 15:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366D11889C44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 14:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764CD20F96B;
	Thu, 23 Jan 2025 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz7D1ouF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BD3B66E
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737640886; cv=none; b=IABL17EuZ/yrvomW/GONfq7HRSOWwhv1ahkBxyEayE47P86ouveZJNr95Hmswwlc0lCO69hg+R5lSUdr8LPLQ7a2sYc+cuNSMsx1cPMhfGvbUtYoK2vkRpKNKg276JncYzToeY454ZI5g8bZ3JGswzkAcwGj7SybJtNoP+z/ijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737640886; c=relaxed/simple;
	bh=U0Zr4AhRK9h1oMVWz5C+snGhkZSaMpWMiEntZ+mKDIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8PrsYuriK2VThQlpphJiVh7UmupRhS5Zr3D8KP6WhHc8EVZE+h7Fsy2MtKt8JFGnRO4SncizHo4cvBMHwc8DCmBpgQBwqi3rMpq5youJis5KUKHB/xaXkU6SYqoZsN5mFZKFY3J2mwBC0GOlJAjX1s4XY/dyKfMaX82574hUkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lz7D1ouF; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab39f84cbf1so180474166b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 06:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737640883; x=1738245683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CD9kYrAVhKnQDBKLNNViBub6pGq4GHP7ASxkx74oLeg=;
        b=Lz7D1ouF/nqkBab7wrSHdTuPB9xT0PpkUSgFONiEplEssryC3oAd/8IRYgn9+cBboI
         sCrjgjPb7mZkIGyuIEENySh7YXM8Xn7U+E8LmDLV290vEdDNTpCyy+N0iDtjw/BeEN5u
         frzWaqLkNidp61zXMf2cJIXJTdNbGr4dNSyO+aCVwtJLI4qyU6xwFAMAhrtpRS04ners
         hGByDZu+yfcxZJhCl9G725iIvuPLqt+jxA4gjJKxuqjOycyIqDUwfEo40SWiEkG+da8f
         d+wZh6hQOFxLATswIeFR4cNb32v47g9bd1MkNciCdgV5sOGx4ycw8WLx2PCPuTJRsEJg
         YI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737640883; x=1738245683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CD9kYrAVhKnQDBKLNNViBub6pGq4GHP7ASxkx74oLeg=;
        b=BN2m+AmdPfnkwUhoPaBrLWUowUD4YItrEdJOHYTl2aQZhx8gHcJlOgXxfjd1QeZasz
         c72oLB1T00Nk+cJu+v4wVknBLybTC82Vpjy95JtwdOIhzhy0T+yn6IvhjuKY5h2LZG+F
         6yeo+tdC40jF4rX9ukSKlbY9s/C2ly3A1NBwTD3tlwynQ6hej8JKcPWQdb3f9x9dOygB
         QbkVFQKvCWEjNulliSTWAOad/BQNuQF1ZnkdAda25OGeZrC8CP/JU7mdN2fFq05hcTkP
         61txEVXXt8hZioDTYZwDBHMKIVr7Sbsf1AhWyKOfGrkSxSZvZXW0z7n8vJIzItsrzY9K
         v99w==
X-Gm-Message-State: AOJu0YyONIbZfic3tcrN7RjoQzxsPBRluQsOFkHBlRl558qn32lBChju
	udq+HoBE1h/Wr/vBMbkE6104f/RDjbftnM1Bn6RDfdlihOnykd6JI0hP1/x2fOOQoy8eO6I+Nff
	ETwkAIM3zxSTnhRrw4okryaK5NAM=
X-Gm-Gg: ASbGncuCjJsxdBGwTxE46uXrGW8j3fiprmR+5IUCEcDDhCa/vM3kmFdeAC6Npx2HBN7
	wXyW5ky5kH3OBPlYF6DNP8Px6eo2w22oDfGJCaueD7nMOUOXQmzqNFMMSxKHcugBsNOuu0rB+
X-Google-Smtp-Source: AGHT+IFCFJCKNN8EmF6TMcQ5DtMOu2MUMKp53MSXZj+rUyWclz+aJ8LEhTvhXFl5yWZ1mL3CPBlul15p5b2FHKLqiig=
X-Received: by 2002:a17:907:1c26:b0:aab:9361:f8f8 with SMTP id
 a640c23a62f3a-ab38b3cdfa1mr2327157766b.50.1737640882502; Thu, 23 Jan 2025
 06:01:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxj00D_fP3nRUBjAry6vwUCNjYuUpCZg2Uc8hwMk6n+2HA@mail.gmail.com>
 <Z41rfVwqp6mmgOt9@dread.disaster.area> <CAOQ4uxgYERCmPrTXjuM4Q3HdWK_HxuOkkpAEnesDHCAD=9fsOg@mail.gmail.com>
 <Z5GOlVQpN47LLmo1@dread.disaster.area>
In-Reply-To: <Z5GOlVQpN47LLmo1@dread.disaster.area>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 23 Jan 2025 15:01:11 +0100
X-Gm-Features: AWEUYZkAd2JsrQQB7axpxkTFV8sOTk_0R_8gYRr-nioXiq80f1hhW60VU1oOdTs
Message-ID: <CAOQ4uxiSfutiOvTDtrzFsbMzacnNLP5PE47edNeUZjDH8qXfuw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] vfs write barriers
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 1:34=E2=80=AFAM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Mon, Jan 20, 2025 at 12:41:33PM +0100, Amir Goldstein wrote:
> > For the HSM prototype, we track changes to a filesystem during
> > a given time period by handling pre-modify vfs events and recording
> > the file handles of changed objects.
> >
> > sb_write_barrier(sb) provides an (internal so far) vfs API to wait
> > for in-flight syscalls that can be still modifying user visible in-core
> > data/metadata, without blocking new syscalls.
>
> Yes, I get this part. What I don't understand is how it is in any
> way useful....
>
> > The method described in the HSM prototype [3] uses this API
> > to persist the state that all the changes until time T were "observed".
> >
> > > This proposed write barrier does not seem capable of providing any
> > > sort of physical data or metadata/data write ordering guarantees, so
> > > I'm a bit lost in how it can be used to provide reliable "crash
> > > consistent change tracking" when there is no relationship between
> > > the data/metadata in memory and data/metadata on disk...
> >
> > That's a good question. A bit hard to explain but I will try.
> >
> > The short answer is that the vfs write barrier does *not* by itself
> > provide the guarantee for "crash consistent change tracking".
> >
> > In the prototype, the "crash consistent change tracking" guarantee
> > is provided by the fact that the change records are recorded as
> > as metadata in the same filesystem, prior to the modification and
> > those metadata records are strictly ordered by the filesystem before
> > the actual change.
>
> This doesn't make any sense to me - you seem to be making
> assumptions that I know an awful lot about how your HSM prototype
> works.
>
> What's in a change record

The prototype creates a directory entry of this name:

changed_dirs/$T/<directory file handle hex>

which gets created if it does not exist before a change in a directory
or before a change to a file's data/metadata [*].

[*] For non-dir, the change record is for ANY parent of the file
if the file is unlinked, we have no need to track changes
if the file is disconnected it's up to the HSM to decide if to block the ch=
ange
or not record it

> when does it get written,

from handling of fanotify pre-modify events (not upstream yet)
*before* the change to in-core data/metadata
which are hooked inside {file,mnt}_want_write() wrappers
*before* {file,sb}_start_write()

> what is it's persistence semantics

The consumer (HSM service) is responsible for persisting
change records (e.g. by fsync of changed_dirs/$T/)

The only guarantee is expects from the filesystem is the
the change records (directory entries) are strictly ordered
to storage before data/metadata changes that are executed
after writing the change record.

> what filesystem metadata is it being written to?

For the prototype it is a directory index,
but that is an implementation detail of this prototype.

> how does this relate to the actual dirty data that is
> resident in the page cache that hasn't been written to stable
> storage yet?

The relation is as follows:
- HSM starts recording change records under both
  changed_dirs/$T/ and changed_dirs/$((T+1))/
- HSM calls sb_write_barrier() and syncfs()
- Then HSM stops recording changes in changed_dirs/$T/

So by the time changed_dirs/$T/ is "sealed", all the dirty data
will be either persistent in stable storage
OR also recorded in changed_dirs/$((T+1))/

> Is there a another change record to say the data the
> first change record tracks has been written to persistent storage?
>

Yes, I use a symlink to denote the "current" live change tracking session,
something like:

$ ln -sf $((T)) changed_dirs/current
...
$ ln -sf $((T+1)) changed_dirs/next
... (write barrier etc)
$ sync -f changed_dirs # seal current
$ mv changed_dirs/next changed_dirs/current

As you can see, I was trying to avoid tying the persistence semantics
to the kernel implementation of HSM.

As far as I can tell, the only thing I am missing from the kernel is
the vfs write barrier in order to take care of the rest in userspace.

Yes, there is this baby elephant in the room that "strictly ordered metadat=
a"
is not in any contract, but I am willing to live with that for now, for the
benefits of filesystem agnostic HSM implementation.

> > The vfs write barrier allows to partition the change tracking records
> > into overlapping time periods in a way that allows the *consumer* of
> > the changes to consume the changes in a "crash consistent manner",
> > because:
>
> > 1. All the in-core changes recorded before the barrier are fully
> >     observable after the barrier
> > 2. All the in-core changes that started after the barrier, will be reco=
rded
> >     for the future change query
> >
> > I would love to discuss the merits and pitfalls of this method, but the
> > main thing I wanted to get feedback on is whether anyone finds the
> > described vfs API useful for anything other that the change tracking
> > system that I described.
>
> This seems like a very specialised niche use case right now, but I
> still have no clear idea how the application using this proposed
> write barrier actually works to acheive the stated functionality
> this feature provides it with...
>

The problem that vfs write barrier is trying to solve is the problem
of order between changing and observing in-core data/metadata.
It seems like a problem that is more generic than my specialized
niche, but maybe it isn't.

The consumer of change tracking will start observing (reading)
the data/metadata only after sealing the period $T records,
so it avoids the risk of observing old data/metadata in a directory
recorded in period $T, without having another record in period $T+1.

The point in all this story is that the vfs write barrier is needed even if
there is no syncfs() at all and if the application does not care about
persistence at all.

For example, for an application that syncs files to a replica storage,
without the write barrier, the change query T can result in reading non-upd=
ate
data/metadata and reach the incorrect conclusion that *everything is in syn=
c*.

Thanks,
Amir.

