Return-Path: <linux-fsdevel+bounces-39665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EB3A16BC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 12:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DADD71884EAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 11:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE621DF248;
	Mon, 20 Jan 2025 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk9Ddd5P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A345191F95
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737373308; cv=none; b=bfwz5QcgJaGCYBhBxslEvaAKSaS8EapBrowERAzRNLYylmXGJoCdasRQdWXNq4P1M53/Wj+NTaQ2+V/OMyb7cIQuExqelDSpd+lKOHnfCpYvw64Q2V8XMnEcKigdbw5IdS7tQp7sJ8IEWEKepwLAH7kW5QQAo5ZMTX9vuLR03vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737373308; c=relaxed/simple;
	bh=3wNiyZqY4d8N6/HLyr+A93+iM6EP9sugGebM7coSsGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsRolpiZsG5Orpe63cpjoznHWpNlPTyooYRD5VHHoKbohB0HRmdpWxeODawD3+V/Lv6QZUI+Aow61RdDtzMfyUFpSKXO0Ur/uotEdCVg6a9dbhPWAzxTuwFfjqK4sRq6sGWidB9lFxPAkiN0Y3nGzbgoiLI9OX15FLhKopG5lEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk9Ddd5P; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso783973566b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 03:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737373305; x=1737978105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0PGVVu+uM4YHhK6nf1XCqGEYoubaocg3wNswSqPtNg=;
        b=Gk9Ddd5PH9RtNdIjh77GhQndzoxT4qlmT0l7mTdWrXjA6He7Ti72fYv9UFbhbnuwDN
         YSc226qwYg+0LBUbxfMEibjXkgt8uPwwZ2QhJxWOA9GNxX0BtDnVAAVMwEsSroUwKzNa
         wtulB9MysfhW7WnAwsIFrVGJ7bSWXoq178hEtkjkchxsPIBJHZhnmZPvpnQhN0Jalb4Y
         JcLeSL6UxojngXzUFLtADxeHB1qOQnyzw/Em5FGr6IesQKU7iGb2bnXuuLWPp77lN/Yt
         3SgXLu7B3EHZ3JQH4WZLOLbxGSgZS3o5ZgXK7Voe4C9Lpg4nB8d/J6Cm6YA0eS0/cRIZ
         F9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737373305; x=1737978105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0PGVVu+uM4YHhK6nf1XCqGEYoubaocg3wNswSqPtNg=;
        b=AvGjYc+OTXyfXZNZ/JFkgNCrkIyz1AF4BPbth8d/M1W1ZJkGQK/XmkCTOFxnf0ksIw
         ZCIQ7avWpAHwUwMaO1e1zXEp7Af7lI0rtD9qGtb9xc3EtHjoc/IAfXgPexOysX+V73WZ
         5Ow5c9uXDFiPd3J9lybJiEQZayYqLlYdz6NzP20tCHiKykKujWxB1u1WWzBvlYoxpyNr
         F/9qKqNqDYNb13XlbAMfIAuiOQQsYF1Y7BPeyZJcHGquXeVK1ms6nVrlqRrozTswtAVs
         4vnFde4woH1DdTCf4BgNJjitv1HGE+9mh1eZt/o1ghHUlOu5Kj59ZHVm9Fk3fZbaFRCc
         8kow==
X-Gm-Message-State: AOJu0Yw4g1pW4WnDbGceaUB0/tua5WIsPa+/5vJyl1zxxfVb9q5OQk70
	5P7VdluGmJY89ggMKhb9yhO04EDOulcVGPSMudSC0xnZGWNFizyiwWEvUvzHKlegmzzOQ3Ql3Zp
	2wxzm+PTLQ8kklnMsxnrlTBgxV4F6T41Ia+c=
X-Gm-Gg: ASbGncuRQG1kDC9IPM3ktp8P5vVhGQu00/SZrr36AmzhYEzDdUIHTPhafN697ZV4m4J
	odVQz0oiVjCrYGg5XNAmEkIS9GOr31eIDUnQ7D242NdlRoth2CdY=
X-Google-Smtp-Source: AGHT+IE+FZK7NvZwl0/qc/LF1UgUFmZWeR5BKjcPvvQLrVfFpyP3CVC28xUlid9upSMddW5yqFfGYfdZ8yiBZiQR634=
X-Received: by 2002:a17:907:9408:b0:aab:daf9:972 with SMTP id
 a640c23a62f3a-ab38b29cf07mr1131154466b.28.1737373304175; Mon, 20 Jan 2025
 03:41:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxj00D_fP3nRUBjAry6vwUCNjYuUpCZg2Uc8hwMk6n+2HA@mail.gmail.com>
 <Z41rfVwqp6mmgOt9@dread.disaster.area>
In-Reply-To: <Z41rfVwqp6mmgOt9@dread.disaster.area>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 Jan 2025 12:41:33 +0100
X-Gm-Features: AbW1kvbohzSi5NP0qtoVZ9QXO5iVoPHIGtLwipZF7iE8RM7SRWHgwhclNcvndUQ
Message-ID: <CAOQ4uxgYERCmPrTXjuM4Q3HdWK_HxuOkkpAEnesDHCAD=9fsOg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] vfs write barriers
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 19, 2025 at 10:15=E2=80=AFPM Dave Chinner <david@fromorbit.com>=
 wrote:
>
> On Fri, Jan 17, 2025 at 07:01:50PM +0100, Amir Goldstein wrote:
> > Hi all,
> >
> > I would like to present the idea of vfs write barriers that was propose=
d by Jan
> > and prototyped for the use of fanotify HSM change tracking events [1].
> >
> > The historical records state that I had mentioned the idea briefly at t=
he end of
> > my talk in LSFMM 2023 [2], but we did not really have a lot of time to =
discuss
> > its wider implications at the time.
> >
> > The vfs write barriers are implemented by taking a per-sb srcu read sid=
e
> > lock for the scope of {mnt,file}_{want,drop}_write().
> >
> > This could be used by users - in the case of the prototype - an HSM ser=
vice -
> > to wait for all in-flight write syscalls, without blocking new write sy=
scalls
> > as the stricter fsfreeze() does.
> >
> > This ability to wait for in-flight write syscalls is used by the protot=
ype to
> > implement a crash consistent change tracking method [3] without the
> > need to use the heavy fsfreeze() hammer.
>
> How does this provide anything guarantee at all? It doesn't order or
> wait for physical IOs in any way, so writeback can be active on a
> file and writing data from both sides of a syscall write "barrier".
> i.e. there is no coherency between what is on disk, the cmtime of
> the inode and the write barrier itself.
>
> Freeze is an actual physical write barrier. A very heavy handed
> physical right barrier, yes, but it has very well defined and
> bounded physical data persistence semantics.

Yes. Freeze is a "write barrier to persistence storage".
This is not what "vfs write barrier" is about.
I will try to explain better.

Some syscalls modify the data/metadata of filesystem objects in memory
(a.k.a "in-core") and some syscalls query in-core data/metadata
of filesystem objects.

It is often the case that in-core data/metadata readers are not fully
synchronized with in-core data/metadata writers and it is often that
in-core data and metadata are not modified atomically w.r.t the
in-core data/metadata readers.
Even related metadata attributes are often not modified atomically
w.r.t to their readers (e.g. statx()).

When it comes to "observing changes" multigrain ctime/mtime has
improved things a lot for observing a change in ctime/mtime since
last sampled and for observing an order of ctime/mtime changes
on different inodes, but it hasn't changed the fact that ctime/mtime
changes can be observed *before* the respective metadata/data
changes can be observed.

An example problem is that a naive backup or indexing program can
read old data/metadata with new timestamp T and wrongly conclude
that it read all changes up to time T.

It is true that "real" backup programs know that applications and
filesystem needs to be quisences before backup, but actual
day to day cloud storage sync programs and indexers cannot
practically freeze the filesystem for their work.

For the HSM prototype, we track changes to a filesystem during
a given time period by handling pre-modify vfs events and recording
the file handles of changed objects.

sb_write_barrier(sb) provides an (internal so far) vfs API to wait
for in-flight syscalls that can be still modifying user visible in-core
data/metadata, without blocking new syscalls.

The method described in the HSM prototype [3] uses this API
to persist the state that all the changes until time T were "observed".

> This proposed write barrier does not seem capable of providing any
> sort of physical data or metadata/data write ordering guarantees, so
> I'm a bit lost in how it can be used to provide reliable "crash
> consistent change tracking" when there is no relationship between
> the data/metadata in memory and data/metadata on disk...

That's a good question. A bit hard to explain but I will try.

The short answer is that the vfs write barrier does *not* by itself
provide the guarantee for "crash consistent change tracking".

In the prototype, the "crash consistent change tracking" guarantee
is provided by the fact that the change records are recorded as
as metadata in the same filesystem, prior to the modification and
those metadata records are strictly ordered by the filesystem before
the actual change.

The vfs write barrier allows to partition the change tracking records
into overlapping time periods in a way that allows the *consumer* of
the changes to consume the changes in a "crash consistent manner",
because:

1. All the in-core changes recorded before the barrier are fully
    observable after the barrier
2. All the in-core changes that started after the barrier, will be recorded
    for the future change query

I would love to discuss the merits and pitfalls of this method, but the
main thing I wanted to get feedback on is whether anyone finds the
described vfs API useful for anything other that the change tracking
system that I described.

Thanks,
Amir.

