Return-Path: <linux-fsdevel+bounces-52996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9087EAE9221
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4896A7B0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199702FE301;
	Wed, 25 Jun 2025 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMHywAqH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692FF2F3C0E;
	Wed, 25 Jun 2025 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893453; cv=none; b=InKhuXCWWQULK0qdC14rpby9iDjMbmdg+DGLvTVonQ0P7KRTN5leL1Z1SSs+IMGMLGJyEa7XSMYu7d3jbGFf9Gs4VYwmP9GeryiqF2s7cHJqaUU+j9/rYqqW0VOEU1ioLOrkLDU7HnRdL7jPbEeAXUbhyVH55uBzA+N1IBkZKKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893453; c=relaxed/simple;
	bh=d93OHtZpHqLPoIbKn84sAiKUZpSfPfqxrY/UyMGc52Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbKo52p6YqpCP65YmqpPEIEG9KoPO+LPdODqlyNuvYQKJMBpQxqgw24H54LGqr6LX2oNt52arfDKbXYT7/WV5nDmvFZLoQGkLmddXqKHkIDz5ciohyxkQowVk+eL/0CMqh9TlDtYK8YiN7pGlM2Jd5P7p4awO2i3tWXOn4v2Gvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMHywAqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022FAC4CEF1;
	Wed, 25 Jun 2025 23:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750893453;
	bh=d93OHtZpHqLPoIbKn84sAiKUZpSfPfqxrY/UyMGc52Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gMHywAqH8meta8A/WSGEK51VZYqQ8kjn7QsJ6qVHot3M3+OWo6U3SC2EFZyYznee4
	 pggYPNhlxhBO0cdFOu4FYzKhdHX5beyO4FwbP3utEpQOBUIXFr3LHpy6rHSc7eq496
	 Hd6+RpQnI6ucEx+8JTggHdP4Vzmlnyorrc2jVesD9C6uaiRgHVNm0+ExvVnsmvIQnx
	 HPsBUX2qXP3yjfZl/ryligK+Fa2A07VEpjRieDzwtyMM/yMFi9ESwadN7VL3ZM6odh
	 KNaMZJ8qrRaLn1WmAQtEgatdWrOPkttH9Lr5uy3x5h80oZj594emMO1+RS5+JDLX75
	 MmpxiMp8sifnQ==
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a585dc5f4aso5652301cf.2;
        Wed, 25 Jun 2025 16:17:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAL5OFZdtA/JnUqgcGCHNPYR+JS83Zooxp+HxfP8q0kDQY96fGkeuwzboCyrtch0KhI//y3MpLr+ZvRIcy@vger.kernel.org, AJvYcCUdDjCTZnvqeiUoClI3hAvkV5olLu/FlerNgVDhLOcD8SwExruDHRXSdhRAQfmQyRds5yZnd51tthGYD937bQ==@vger.kernel.org, AJvYcCWGd4rE9JYPsl9YA3uVVFBVVlUYGdTGMKr3avbXayJEoB1uv4LGi4clGSuH5m3KTSdIBGvqqnUTCRjoLoq20u7lmpSmnmkT@vger.kernel.org, AJvYcCWOY+5hs4XjxW+tXxYSNM0TgNIudpdH0DagScFjkyzUtciU8F1vicihCRqAKY1nBBJlF68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzubCcr4i3nJYU6t7Uklhj4k2tjoVPz2dQXtPdMeJzN8v+UxAdL
	j2H3OKED7WBAccUkNeQp9pYB8q+jRaHk/c1lZSrPrZrLB+1TU8sxigA2yHw9/JU+ocGd384g5dC
	Q+6tXK4ueq5aDWn6TzDznhI9+5N8otzE=
X-Google-Smtp-Source: AGHT+IGoh6S2nBdD+7L5IEbXsOa4fFgsvTiWA2MUQtgk66QvUy2ctdvR0Io57I8XDB1k/+xhQ0KaTf20soOaK2X8wDI=
X-Received: by 2002:a05:622a:2293:b0:4a6:f434:8cd with SMTP id
 d75a77b69052e-4a7c06ef9a4mr80144551cf.23.1750893452178; Wed, 25 Jun 2025
 16:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625.Ee2Ci6chae8h@digikod.net> <175089269668.2280845.5681675711269608822@noble.neil.brown.name>
In-Reply-To: <175089269668.2280845.5681675711269608822@noble.neil.brown.name>
From: Song Liu <song@kernel.org>
Date: Wed, 25 Jun 2025 16:17:20 -0700
X-Gmail-Original-Message-ID: <CAPhsuW53QiS8Aa5c4VLFjojShmgibftVe=py-RuL+ZyHBY5Pbg@mail.gmail.com>
X-Gm-Features: Ac12FXziaRaFqMxVW6VcmQD_8qDZwMUUshKYzHkXEjuqAFIdtIHjuJL3ctPGHIo
Message-ID: <CAPhsuW53QiS8Aa5c4VLFjojShmgibftVe=py-RuL+ZyHBY5Pbg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
To: NeilBrown <neil@brown.name>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	brauner@kernel.org, kernel-team@meta.com, andrii@kernel.org, 
	eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	viro@zeniv.linux.org.uk, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, Tingmao Wang <m@maowtm.org>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 4:05=E2=80=AFPM NeilBrown <neil@brown.name> wrote:
>
> On Wed, 25 Jun 2025, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Wed, Jun 25, 2025 at 07:38:53AM +1000, NeilBrown wrote:
> > >
> > > Can you spell out the minimum that you need?
> >
> > Sure.  We'd like to call this new helper in a RCU
> > read-side critical section and leverage this capability to speed up pat=
h
> > walk when there is no concurrent hierarchy modification.  This use case
> > is similar to handle_dots() with LOOKUP_RCU calling follow_dotdot_rcu()=
.
> >
> > The main issue with this approach is to keep some state of the path wal=
k
> > to know if the next call to "path_walk_parent_rcu()" would be valid
> > (i.e. something like a very light version of nameidata, mainly sequence
> > integers), and to get back to the non-RCU version otherwise.
> >
> > >
> > > My vague impression is that you want to search up from a given strut =
path,
> > > no further then some other given path, looking for a dentry that matc=
hes
> > > some rule.  Is that correct?
> >
> > Yes
> >
> > >
> > > In general, the original dentry could be moved away from under the
> > > dentry you find moments after the match is reported.  What mechanisms=
 do
> > > you have in place to ensure this doesn't happen, or that it doesn't
> > > matter?
> >
> > In the case of Landlock, by default, a set of access rights are denied
> > and can only be allowed by an element in the file hierarchy.  The goal
> > is to only allow access to files under a specific directory (or directl=
y
> > a specific file).  That's why we only care of the file hierarchy at the
> > time of access check.  It's not an issue if the file/directory was
> > moved or is being moved as long as we can walk its "current" hierarchy.
> > Furthermore, a sandboxed process is restricted from doing arbitrary
> > mounts (and renames/links are controlled with the
> > LANDLOCK_ACCESS_FS_REFER right).
> >
> > However, we need to get a valid "snapshot" of the set of dentries that
> > (could) lead to the evaluated file/directory.
>
> A "snapshot" is an interesting idea - though looking at the landlock
> code you one need inodes, not dentries.
> I imagine an interface where you give it a starting path, a root, and
> and array of inode pointers, and it fills in the pointers with the path
> - all under rcu so no references are needed.
> But you would need some fallback if the array isn't big enough, so maybe
> that isn't a good idea.
>
> Based on the comments by Al and Christian, I think the only viable
> approach is to pass a callback to some vfs function that does the
> walking.
>
>    vfs_walk_ancestors(struct path *path, struct path *root,
>                       int (*walk_cb)(struct path *ancestor, void *data),
>                       void *data)

I like this idea.

Maybe we want "struct path *ancestor" of walk_cb to be const.
walk_cb should only change "data", so that we can undo all the
changes when the rcu walk fails.

Thanks,
Song

