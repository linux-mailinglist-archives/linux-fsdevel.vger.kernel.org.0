Return-Path: <linux-fsdevel+bounces-40088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F46A1BDBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 22:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8514168D6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 21:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10651DC9BC;
	Fri, 24 Jan 2025 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZDzD6Uj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBE61BFE10
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737752869; cv=none; b=crxyuOArTfc2IGtnFxaSliJAoWVfxeVnoGkJxeVqS8QKnfhqylt/oVhnCS3MEN70j/5EnFD6dZI+2AShSwWFz4kC5yZ+FrbCajnkgh3Gt6RcBtREQLkzE87bQ447MJT8S+xozs67KNhB+XtrV/MNsSL74PzF3FhskBWkEofViVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737752869; c=relaxed/simple;
	bh=Npo6d+/N2qTxReQUF52HOBoYT2XXtpG+2zK5eQFpUiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnXjXO8dikKZO0+Y5hVNRJQzoZZZ785AcoLkXKbC0mjj8ubfrQb3eM+d44OXeoPJm7lw/whggp50nDV7GFFeBfxEMBTsKpJ/I7xVY7KLbj5FpUyXKbaytJJYtEyG6kbkP+ANKPvEVwW6uw81fg+OJ/qjD8YX/1KCs3Y18t7QE0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZDzD6Uj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab651f1dd36so471533666b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 13:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737752865; x=1738357665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Npo6d+/N2qTxReQUF52HOBoYT2XXtpG+2zK5eQFpUiw=;
        b=dZDzD6Uj5CkUeYeIqYK71jpiqZakRJ7hJH8h1F0lPGVCq1U94q//nad/Y0skubVDl6
         mnGFcJtH0nTi8B+RKXx8SzwqhSpp6hA3I86qJNevfPmcQgC09CBAnH5Dxf/rcgIMJdg+
         jUOzz6JqF+2AvGJouwufU+1zWNI4R9PJK+x6Yv2vNrbO63wJpTEsOlxfMHxib3jlJ+fW
         LieS715BQkTT1+xwXU0mryclYjZqOyCEZUmRdzbRMgr3Kj/sIPYoFbr3u2GWfxbI4mrt
         cMZJRFdEJ3HhIGe7Ds7EPixR/hS91SI2wMPRXdjLCFgUV+TGNJ2bjqWFMVD6OLf7mKI3
         UACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737752865; x=1738357665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Npo6d+/N2qTxReQUF52HOBoYT2XXtpG+2zK5eQFpUiw=;
        b=tG5F05ru0tamoCTj+62pFENZXZ3BSHVvhVqY5W8HIMpcj5glwliGBe207B+SC1kKVA
         xcps0Hcms+KA/Ignzlaf9CofIqZHH5va75DZXWIw9zfsPnF4bpYNW1207KXsLoAYx8ZN
         H3pIlx8tvDg5JPcpYnEPL4UgBQ1HUTcRLVyBKUw569XVmuZ+LvCMQD6v+mwEA4BsaCm8
         +HVDDuFWi4VUOYrKLUdZHW5GCQd0pZxH7b7KfBMngXpTPGEM1/sMqHySV9ouVrbUmmhV
         FSf/4Cvw9I38DMvSMtpgNRxu5AWebT4zCz+uy2d0b9V44d0bRgeAJPhI8Iv0vB2yYSZZ
         eDKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQZwp9NlpmeJF9zV4lU8BtZo8hI4VX5eTcgo9K3/+rwfg5RPDlXO4mIKHChbZnuZ/nTen9ewvX4hDg6ygp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0sawaHMwuE/rS0WucC7iNbHcxeEz47J+DC/t/gsDFfgi0x6Q9
	yPuSxdJ1IRwlEyBxfqxDQCGMyfH1zwgF7D9aXWaQOyQa2gSHAEpEtG7jgFew+EctZDz//kBiC9d
	U+ffIqavNR93AKK3Dhei4hBXCyIOtpbCM
X-Gm-Gg: ASbGncvyyiAxZAvwvJKkN0YN/fV0V2twpYbb5yeg/stY+9laGVQ3+XX81KBoNv4JosZ
	zK9FXInc1uQYXQm05wE9In8JSZ1Xqf6ZhKqETb/tTUtzlXIOTncFf5lc3AMfIOw==
X-Google-Smtp-Source: AGHT+IFtBELgAPI2SHGAHGVYwAamcaKG9HyFwGx/GhkHgAu2XkCzQ/R2DIOFG0zBEWG0Z6jxDm02J4k68SMwLOwjFAQ=
X-Received: by 2002:a17:907:3f23:b0:ab3:f88:b54e with SMTP id
 a640c23a62f3a-ab38b2e71e0mr2879095066b.31.1737752865080; Fri, 24 Jan 2025
 13:07:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxj00D_fP3nRUBjAry6vwUCNjYuUpCZg2Uc8hwMk6n+2HA@mail.gmail.com>
 <Z41rfVwqp6mmgOt9@dread.disaster.area> <CAOQ4uxgYERCmPrTXjuM4Q3HdWK_HxuOkkpAEnesDHCAD=9fsOg@mail.gmail.com>
 <dc0649f70ca69741d351060c8c3816a347c00687.camel@kernel.org>
In-Reply-To: <dc0649f70ca69741d351060c8c3816a347c00687.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Jan 2025 22:07:32 +0100
X-Gm-Features: AWEUYZm12zB_5nr5IttE3aZ5siotYPgXbvFOx0zZiL2S97HinHDgu6T4fzRz-6c
Message-ID: <CAOQ4uxgFWrkE5P3oyRMs89Fd9obi3XvtR0B3BjKcJNWwXPL5Ww@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] vfs write barriers
To: Jeff Layton <jlayton@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 7:14=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Mon, 2025-01-20 at 12:41 +0100, Amir Goldstein wrote:
> > On Sun, Jan 19, 2025 at 10:15=E2=80=AFPM Dave Chinner <david@fromorbit.=
com> wrote:
> > >
> > > On Fri, Jan 17, 2025 at 07:01:50PM +0100, Amir Goldstein wrote:
> > > > Hi all,
> > > >
> > > > I would like to present the idea of vfs write barriers that was pro=
posed by Jan
> > > > and prototyped for the use of fanotify HSM change tracking events [=
1].
> > > >
> > > > The historical records state that I had mentioned the idea briefly =
at the end of
> > > > my talk in LSFMM 2023 [2], but we did not really have a lot of time=
 to discuss
> > > > its wider implications at the time.
> > > >
> > > > The vfs write barriers are implemented by taking a per-sb srcu read=
 side
> > > > lock for the scope of {mnt,file}_{want,drop}_write().
> > > >
> > > > This could be used by users - in the case of the prototype - an HSM=
 service -
> > > > to wait for all in-flight write syscalls, without blocking new writ=
e syscalls
> > > > as the stricter fsfreeze() does.
> > > >
> > > > This ability to wait for in-flight write syscalls is used by the pr=
ototype to
> > > > implement a crash consistent change tracking method [3] without the
> > > > need to use the heavy fsfreeze() hammer.
> > >
> > > How does this provide anything guarantee at all? It doesn't order or
> > > wait for physical IOs in any way, so writeback can be active on a
> > > file and writing data from both sides of a syscall write "barrier".
> > > i.e. there is no coherency between what is on disk, the cmtime of
> > > the inode and the write barrier itself.
> > >
> > > Freeze is an actual physical write barrier. A very heavy handed
> > > physical right barrier, yes, but it has very well defined and
> > > bounded physical data persistence semantics.
> >
> > Yes. Freeze is a "write barrier to persistence storage".
> > This is not what "vfs write barrier" is about.
> > I will try to explain better.
> >
> > Some syscalls modify the data/metadata of filesystem objects in memory
> > (a.k.a "in-core") and some syscalls query in-core data/metadata
> > of filesystem objects.
> >
> > It is often the case that in-core data/metadata readers are not fully
> > synchronized with in-core data/metadata writers and it is often that
> > in-core data and metadata are not modified atomically w.r.t the
> > in-core data/metadata readers.
> > Even related metadata attributes are often not modified atomically
> > w.r.t to their readers (e.g. statx()).
> >
> > When it comes to "observing changes" multigrain ctime/mtime has
> > improved things a lot for observing a change in ctime/mtime since
> > last sampled and for observing an order of ctime/mtime changes
> > on different inodes, but it hasn't changed the fact that ctime/mtime
> > changes can be observed *before* the respective metadata/data
> > changes can be observed.
> >
> > An example problem is that a naive backup or indexing program can
> > read old data/metadata with new timestamp T and wrongly conclude
> > that it read all changes up to time T.
> >
> > It is true that "real" backup programs know that applications and
> > filesystem needs to be quisences before backup, but actual
> > day to day cloud storage sync programs and indexers cannot
> > practically freeze the filesystem for their work.
> >
>
> Right. That is still a known problem. For directory operations, the
> i_rwsem keeps things consistent, but for regular files, it's possible
> to see new timestamps alongside with old file contents. That's a
> problem since caching algorithms that watch for timestamp changes can
> end up not seeing the new contents until the _next_ change occurs,
> which might not ever happen.
>
> It would be better to change the file write code to update the
> timestamps after copying data to the pagecache. It would still be
> possible in that case to see old attributes + new contents, but that's
> preferable to the reverse for callers that are watching for changes to
> attributes.
>

Yes, I remember this was discussed.
I think it may make sense to update before and after copying data to page c=
ache?

> Would fixing that help your use-case at all?
>

I don't think it would, because my use case is not about querying
the change status of a single inode. It post change timestamp update
helps I don't see how.

Thanks,
Amir.

