Return-Path: <linux-fsdevel+bounces-39989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C36A1A971
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 19:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71E63A39C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 18:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBC016F265;
	Thu, 23 Jan 2025 18:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrJjbEkV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4969C15A85A
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656054; cv=none; b=bohaBi8F0s8K4+i5W1b/dFCougTqrfDhl9EI7YIZrJ1FZ6rZTrEN1cy/Lu8Vy0S5OJtls5qg+hB/MAXuSin9elHVq0EZv2U11nB9xX6jExw3d9u/tz67/QXVEAAOPK3lWAk7irFLPYb/+/F3Z3cLweXvV1Os6QdTWWpvyAlzSDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656054; c=relaxed/simple;
	bh=YXYAHFBPXBJ6NaY5QbnjXFbbSEm3zqklp0fykUf3E6I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ueBl0Qp5mUg+a0NLJ4/5PBiA92WWD6HXZ8wHWEsKrjkxSrRzN6vk+lpbF95R3/SHhvQ0rykj9q1Gxcoin44aIuyzzTI7gdDYm3+THS9rn24MwoQeGtvzqVrDPo6FgBuyStyq/WqTyZGD0Mm6NHWxKf3OZDjYnIy+H5A1D/ZisXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrJjbEkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19020C4CED3;
	Thu, 23 Jan 2025 18:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737656053;
	bh=YXYAHFBPXBJ6NaY5QbnjXFbbSEm3zqklp0fykUf3E6I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VrJjbEkVqLIVGi1MVc78b4n7axHDPOupRBKLBCnie2zPx1FJbZyY0h/xoeExEdmOq
	 YSrLRydP5IKzBpERefhN/aGyZ4dWo8Imksqlc4NsbByUrYcl811EttTyk8jpzmhGXT
	 EQirhQfc+qjeQrYBQmnOEE8LfvCglUsJnxPUoUcdqprVOxEIhTVirSegK65wJq1xS8
	 Ce4RheqhKvUaMYkuLbusjwmd09R6xNs4GhryEpFl6XDgJ8CVj9G4jP+YQ7dULI1fCN
	 WFlfxvmv8YSB/SUp0kU0jfasideBhmB3cgdKoHxLb0ELapg87MiaYj1FQwOPBk/3Vk
	 /DxK0iP2KsN4Q==
Message-ID: <dc0649f70ca69741d351060c8c3816a347c00687.camel@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] vfs write barriers
From: Jeff Layton <jlayton@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, lsf-pc	
 <lsf-pc@lists.linux-foundation.org>, Jan Kara <jack@suse.cz>, Christian
 Brauner	 <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Date: Thu, 23 Jan 2025 13:14:11 -0500
In-Reply-To: <CAOQ4uxgYERCmPrTXjuM4Q3HdWK_HxuOkkpAEnesDHCAD=9fsOg@mail.gmail.com>
References: 
	<CAOQ4uxj00D_fP3nRUBjAry6vwUCNjYuUpCZg2Uc8hwMk6n+2HA@mail.gmail.com>
	 <Z41rfVwqp6mmgOt9@dread.disaster.area>
	 <CAOQ4uxgYERCmPrTXjuM4Q3HdWK_HxuOkkpAEnesDHCAD=9fsOg@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-20 at 12:41 +0100, Amir Goldstein wrote:
> On Sun, Jan 19, 2025 at 10:15=E2=80=AFPM Dave Chinner <david@fromorbit.co=
m> wrote:
> >=20
> > On Fri, Jan 17, 2025 at 07:01:50PM +0100, Amir Goldstein wrote:
> > > Hi all,
> > >=20
> > > I would like to present the idea of vfs write barriers that was propo=
sed by Jan
> > > and prototyped for the use of fanotify HSM change tracking events [1]=
.
> > >=20
> > > The historical records state that I had mentioned the idea briefly at=
 the end of
> > > my talk in LSFMM 2023 [2], but we did not really have a lot of time t=
o discuss
> > > its wider implications at the time.
> > >=20
> > > The vfs write barriers are implemented by taking a per-sb srcu read s=
ide
> > > lock for the scope of {mnt,file}_{want,drop}_write().
> > >=20
> > > This could be used by users - in the case of the prototype - an HSM s=
ervice -
> > > to wait for all in-flight write syscalls, without blocking new write =
syscalls
> > > as the stricter fsfreeze() does.
> > >=20
> > > This ability to wait for in-flight write syscalls is used by the prot=
otype to
> > > implement a crash consistent change tracking method [3] without the
> > > need to use the heavy fsfreeze() hammer.
> >=20
> > How does this provide anything guarantee at all? It doesn't order or
> > wait for physical IOs in any way, so writeback can be active on a
> > file and writing data from both sides of a syscall write "barrier".
> > i.e. there is no coherency between what is on disk, the cmtime of
> > the inode and the write barrier itself.
> >=20
> > Freeze is an actual physical write barrier. A very heavy handed
> > physical right barrier, yes, but it has very well defined and
> > bounded physical data persistence semantics.
>=20
> Yes. Freeze is a "write barrier to persistence storage".
> This is not what "vfs write barrier" is about.
> I will try to explain better.
>=20
> Some syscalls modify the data/metadata of filesystem objects in memory
> (a.k.a "in-core") and some syscalls query in-core data/metadata
> of filesystem objects.
>=20
> It is often the case that in-core data/metadata readers are not fully
> synchronized with in-core data/metadata writers and it is often that
> in-core data and metadata are not modified atomically w.r.t the
> in-core data/metadata readers.
> Even related metadata attributes are often not modified atomically
> w.r.t to their readers (e.g. statx()).
>=20
> When it comes to "observing changes" multigrain ctime/mtime has
> improved things a lot for observing a change in ctime/mtime since
> last sampled and for observing an order of ctime/mtime changes
> on different inodes, but it hasn't changed the fact that ctime/mtime
> changes can be observed *before* the respective metadata/data
> changes can be observed.
>=20
> An example problem is that a naive backup or indexing program can
> read old data/metadata with new timestamp T and wrongly conclude
> that it read all changes up to time T.
>=20
> It is true that "real" backup programs know that applications and
> filesystem needs to be quisences before backup, but actual
> day to day cloud storage sync programs and indexers cannot
> practically freeze the filesystem for their work.
>=20

Right. That is still a known problem. For directory operations, the
i_rwsem keeps things consistent, but for regular files, it's possible
to see new timestamps alongside with old file contents. That's a
problem since caching algorithms that watch for timestamp changes can
end up not seeing the new contents until the _next_ change occurs,
which might not ever happen.

It would be better to change the file write code to update the
timestamps after copying data to the pagecache. It would still be
possible in that case to see old attributes + new contents, but that's
preferable to the reverse for callers that are watching for changes to
attributes.

Would fixing that help your use-case at all?

> For the HSM prototype, we track changes to a filesystem during
> a given time period by handling pre-modify vfs events and recording
> the file handles of changed objects.
>=20
> sb_write_barrier(sb) provides an (internal so far) vfs API to wait
> for in-flight syscalls that can be still modifying user visible in-core
> data/metadata, without blocking new syscalls.
>=20
> The method described in the HSM prototype [3] uses this API
> to persist the state that all the changes until time T were "observed".
>=20
> > This proposed write barrier does not seem capable of providing any
> > sort of physical data or metadata/data write ordering guarantees, so
> > I'm a bit lost in how it can be used to provide reliable "crash
> > consistent change tracking" when there is no relationship between
> > the data/metadata in memory and data/metadata on disk...
>=20
> That's a good question. A bit hard to explain but I will try.
>=20
> The short answer is that the vfs write barrier does *not* by itself
> provide the guarantee for "crash consistent change tracking".
>=20
> In the prototype, the "crash consistent change tracking" guarantee
> is provided by the fact that the change records are recorded as
> as metadata in the same filesystem, prior to the modification and
> those metadata records are strictly ordered by the filesystem before
> the actual change.
>=20
> The vfs write barrier allows to partition the change tracking records
> into overlapping time periods in a way that allows the *consumer* of
> the changes to consume the changes in a "crash consistent manner",
> because:
>=20
> 1. All the in-core changes recorded before the barrier are fully
>     observable after the barrier
> 2. All the in-core changes that started after the barrier, will be record=
ed
>     for the future change query
>=20
> I would love to discuss the merits and pitfalls of this method, but the
> main thing I wanted to get feedback on is whether anyone finds the
> described vfs API useful for anything other that the change tracking
> system that I described.

--=20
Jeff Layton <jlayton@kernel.org>

