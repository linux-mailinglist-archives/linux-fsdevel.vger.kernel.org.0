Return-Path: <linux-fsdevel+bounces-38916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD7FA09CCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 22:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35E63A17B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 21:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B532080D9;
	Fri, 10 Jan 2025 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwnHkWnT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A541206F33
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736543257; cv=none; b=owjI0EOevDMUerMZc+wXKyhrOrqlggqf1TYaEA8AQtf6iiTpanqWBz/szyS4Pi1KX1+BxoAi9fSCRflz9wSekE2tpf+n/sfRmlo336/sQO0ekfVweHqM5BNQajoxCrqdaIZJOWsWzoBWI2GjJqTLa9llBRrEKhGxshQq9+0mbJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736543257; c=relaxed/simple;
	bh=XrSLw4Id8gxP5uMDo10eDL3ura5oGHRWdk7jTvreFAQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FqbYoEcyBnAWQrMvM1uIiZ6nP5JJRBfSfmbHyIn5eAJVhoala6r1TpxQfdo/Q66RYoEl1Xfq/KEIjteAOOH0DR6x1amPNxbpQ/2gTqalMhJ1MUetSn0y7fkyVvx2HCXbZcfbV2GOI1AazrPMMVf0hyIQ39mhXqrbxc8K7skw2JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwnHkWnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D1CC4CED6;
	Fri, 10 Jan 2025 21:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736543257;
	bh=XrSLw4Id8gxP5uMDo10eDL3ura5oGHRWdk7jTvreFAQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nwnHkWnTM42XEXpADxHI8iCQ7j74wPKkc+4w/JeDdL/uvcB7Ii7nEUL0h2XR1Py2y
	 AIZhYDAiQtWvzQ6D9WGWSY6MTNk3Y6mp0SnT0WZIKuoKdUHxF12UCnvjVzLOBdpAUn
	 /RnVU9kGLPHj4QfPZzD64RPCdfR17jtgy6KsxTMmcnbCrQLWeGBMTUh6XR961xSR6x
	 6RCWgNfGXlqZUdY1rJ4Q1V4evTKzwSq3Iu0PErLSbF257zviOOIF5TgTA/8XH7pXtn
	 wM7+eEiZJQQuVPto93dx1eidOZg8TsKfkjMu2+tocD32Z0PNx5AI1DTzah+ci4Pjke
	 T8gXw4NgBA97g==
Message-ID: <956ae3eba9ef549d4f1ab3dff9e0bb09a39101b2.camel@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under
 writeback with AS_WRITEBACK_INDETERMINATE mappings
From: Jeff Layton <jlayton@kernel.org>
To: David Hildenbrand <david@redhat.com>, Shakeel Butt
 <shakeel.butt@linux.dev>,  Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert	
 <bernd.schubert@fastmail.fm>, Zi Yan <ziy@nvidia.com>, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, 	linux-mm@kvack.org, kernel-team@meta.com, Matthew
 Wilcox <willy@infradead.org>,  Oscar Salvador <osalvador@suse.de>, Michal
 Hocko <mhocko@kernel.org>
Date: Fri, 10 Jan 2025 16:07:34 -0500
In-Reply-To: <c9e4017a-9883-4052-9ca0-774b3745f439@redhat.com>
References: 
	<kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
	 <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com>
	 <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
	 <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com>
	 <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
	 <446704ab-434e-45ac-a062-45fef78815e4@redhat.com>
	 <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
	 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
	 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com>
	 <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
	 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
	 <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com>
	 <153c5a4f08daf60e1bbbdde02975392dc608cfdf.camel@kernel.org>
	 <e4150b98-99ed-45fc-8485-5ad044f10d84@redhat.com>
	 <47fff939fc1fb3153af5b129be600a018c8485e9.camel@kernel.org>
	 <c9e4017a-9883-4052-9ca0-774b3745f439@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-10 at 22:00 +0100, David Hildenbrand wrote:
> On 10.01.25 21:43, Jeff Layton wrote:
> > On Fri, 2025-01-10 at 21:20 +0100, David Hildenbrand wrote:
> > > On 10.01.25 21:16, Jeff Layton wrote:
> > > > On Tue, 2025-01-07 at 09:34 +0100, David Hildenbrand wrote:
> > > > > On 06.01.25 19:17, Shakeel Butt wrote:
> > > > > > On Mon, Jan 06, 2025 at 11:19:42AM +0100, Miklos Szeredi wrote:
> > > > > > > On Fri, 3 Jan 2025 at 21:31, David Hildenbrand <david@redhat.=
com> wrote:
> > > > > > > > In any case, having movable pages be turned unmovable due t=
o persistent
> > > > > > > > writaback is something that must be fixed, not worked aroun=
d. Likely a
> > > > > > > > good topic for LSF/MM.
> > > > > > >=20
> > > > > > > Yes, this seems a good cross fs-mm topic.
> > > > > > >=20
> > > > > > > So the issue discussed here is that movable pages used for fu=
se
> > > > > > > page-cache cause a problems when memory needs to be compacted=
. The
> > > > > > > problem is either that
> > > > > > >=20
> > > > > > >     - the page is skipped, leaving the physical memory block =
unmovable
> > > > > > >=20
> > > > > > >     - the compaction is blocked for an unbounded time
> > > > > > >=20
> > > > > > > While the new AS_WRITEBACK_INDETERMINATE could potentially ma=
ke things
> > > > > > > worse, the same thing happens on readahead, since the new pag=
e can be
> > > > > > > locked for an indeterminate amount of time, which can also bl=
ock
> > > > > > > compaction, right?
> > > > >=20
> > > > > Yes, as memory hotplug + virtio-mem maintainer my bigger concern =
is
> > > > > these pages residing in ZONE_MOVABLE / MIGRATE_CMA areas where th=
ere
> > > > > *must not be unmovable pages ever*. Not triggered by an untrusted
> > > > > source, not triggered by an trusted source.
> > > > >=20
> > > > > It's a violation of core-mm principles.
> > > > >=20
> > > > > Even if we have a timeout of 60s, making things like alloc_contig=
_page()
> > > > > wait for that long on writeback is broken and needs to be fixed.
> > > > >=20
> > > > > And the fix is not to skip these pages, that's a workaround.
> > > > >=20
> > > > > I'm hoping I can find an easy way to trigger this also with NFS.
> > > > >=20
> > > >=20
> > > > I imagine that you can just open a file and start writing to it, pu=
ll
> > > > the plug on the NFS server, and then issue a fsync or something to
> > > > ensure some writeback occurs.
> > >=20
> > > Yes, that's the plan, thanks!
> > >=20
> > > >=20
> > > > Any dirty pagecache folios should be stuck in writeback at that poi=
nt.
> > > > The NFS client is also very patient about waiting for the server to
> > > > come back, so it should stay that way indefinitely.
> > >=20
> > > Yes, however the default timeout for UDP is fairly small (for TCP
> > > certainly much longer). So one thing I'd like to understand what that
> > > "cancel writeback -> redirty folio" on timeout does, and when it
> > > actually triggers with TCP vs UDP timeouts.
> > >=20
> >=20
> >=20
> > The lifetime of the pagecache pages is not at all related to the socket
> > lifetimes. IOW, the client can completely lose the connection to the
> > server and the page will just stay dirty until the connection can be
> > reestablished and the server responds.
>=20
> Right. It cannot get reclaimed while that is the case.
>=20
> >=20
> > The exception here is if you mount with "-o soft" in which case, an RPC
> > request will time out with an error after a major RPC timeout (usually
> > after a minute or so). See nfs(5) for the gory details of timeouts and
> > retransmission. The default is "-o hard" since that's necessary for
> > data-integrity in the face of spotty network connections.
> >=20
> > Once a soft mount has a writeback RPC time out, the folio is marked
> > clean and a writeback error is set on the mapping, so that fsync() will
> > return an error.
>=20
> I assume that's the code I stumbled over in nfs_page_async_flush(),=20
> where we end up calling folio_redirty_for_writepage() +=20
> nfs_redirty_request(), unless we run into a fatal error; in that case,=
=20
> we end up in nfs_write_error() where we set the mapping error and stop=
=20
> writeback using nfs_page_end_writeback().
>=20

Exactly.

The upshot is that you can dirty NFS pages that will sit in the
pagecache indefinitely, if you can disrupt the connection to the server
indefinitely. This is substantially the same in other netfs's too --
CIFS, Ceph, etc.

The big difference vs FUSE is that they don't allow unprivileged users
to mount arbitrary filesystems, so it's a harder for an attacker to do
this with only a local unprivileged account to work with.
--=20
Jeff Layton <jlayton@kernel.org>

