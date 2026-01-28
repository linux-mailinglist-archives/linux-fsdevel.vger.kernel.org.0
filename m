Return-Path: <linux-fsdevel+bounces-75678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGmtFLBZeWlnwgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 01:34:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DA79BAE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 01:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7CEC5300A5BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553B81F3BA2;
	Wed, 28 Jan 2026 00:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlcxSH0i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7C2745E;
	Wed, 28 Jan 2026 00:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769560472; cv=none; b=FtXRnMUsTolKInbITMkAG7XXtxKplERac2jffvY8U4tKpLWeLEfRSeENjYoGChyvWl0nUeE0L/fWWPAXgRV06ETTebpM68YPk8oPv1+xCuviGkWeXECwTHadW+Aym8fKFMFYoHcZjfIeS8C2P84k4/dxTyP5FfFo4Zpf3Uh3DKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769560472; c=relaxed/simple;
	bh=SsPTekksUpq7TEr4XTUb0fDNtPBNokKQnxykvA6ML+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpaM7HHgP4X2gHncS4OrOfdy8k3UYuYGP+m6uRFwnsvhPU1ZdBpJyg1xiRVGr3VvX+nnkVGziAS7mmVYGv9wvVbcfDTU38eT6J+GxnSP1nMqLBIqOZaiQiq5cERTBaEvBcYihmrmiFl49xAdZCoVQOscMA4m2H076uJt4YrcT1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlcxSH0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49572C2BC86;
	Wed, 28 Jan 2026 00:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769560472;
	bh=SsPTekksUpq7TEr4XTUb0fDNtPBNokKQnxykvA6ML+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rlcxSH0iKg1A3upDFu/j2Mr5b278KD6h17gLS7v+E4OSBcLKNxKRDKRaA8IR4lJo5
	 IQ4lXDk3Klkaro/KUNNKByVaAqstesRUmINMTFflCaxMPnF6p9WuYME54lbvo/7z0F
	 9a9jz2CgL9QjE5TJ7IDZPhocibMDKm2kr/p4MVzMdxe0hsZYBV6ohj0y+fQGTyY2Ty
	 bSOrBhYxsC56GR1ZoUI6DwOgae4zer0RPqaKivAnWTrcugRRLwxoGtTPUbGoc/MWFO
	 vMyxwUMrs2/ZU3nwj2FzwWIOQplwKj/FcpBfGaKZqDWfbbHvWtlPBEHaN6PPjZoYt2
	 /iH5SHqkS1lBQ==
Date: Tue, 27 Jan 2026 16:34:31 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHSET v6 4/8] fuse: allow servers to use iomap for better
 file IO performance
Message-ID: <20260128003431.GX5910@frogsfrogsfrogs>
References: <20251029002755.GK6174@frogsfrogsfrogs>
 <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <CAJnrk1Z05QZmos90qmWtnWGF+Kb7rVziJ51UpuJ0O=A+6N1vrg@mail.gmail.com>
 <20260127022235.GG5900@frogsfrogsfrogs>
 <CAJnrk1bSVy4=c=N_FfOajs1FE4o8T=Br=jFm7gBDaCGvRpgGVA@mail.gmail.com>
 <20260127232125.GA5966@frogsfrogsfrogs>
 <CAJnrk1bxhw2u0qwjw0dJPGdmxEXbcEyKn-=iFrszqof2c8wGCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bxhw2u0qwjw0dJPGdmxEXbcEyKn-=iFrszqof2c8wGCA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75678-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73DA79BAE9
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 04:10:43PM -0800, Joanne Koong wrote:
> On Tue, Jan 27, 2026 at 3:21 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Tue, Jan 27, 2026 at 11:47:31AM -0800, Joanne Koong wrote:
> > > On Mon, Jan 26, 2026 at 6:22 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > On Mon, Jan 26, 2026 at 04:59:16PM -0800, Joanne Koong wrote:
> > > > > On Tue, Oct 28, 2025 at 5:38 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > > >
> > > > > > Hi all,
> > > > > >
> > > > > > This series connects fuse (the userspace filesystem layer) to fs-iomap
> > > > > > to get fuse servers out of the business of handling file I/O themselves.
> > > > > > By keeping the IO path mostly within the kernel, we can dramatically
> > > > > > improve the speed of disk-based filesystems.  This enables us to move
> > > > > > all the filesystem metadata parsing code out of the kernel and into
> > > > > > userspace, which means that we can containerize them for security
> > > > > > without losing a lot of performance.
> > > > >
> > > > > I haven't looked through how the fuse2fs or fuse4fs servers are
> > > > > implemented yet (also, could you explain the difference between the
> > > > > two? Which one should we look at to see how it all ties together?),
> > > >
> > > > fuse4fs is a lowlevel fuse server; fuse2fs is a high(?) level fuse
> > > > server.  fuse4fs is the successor to fuse2fs, at least on Linux and BSD.
> > >
> > > Ah I see, thanks for the explanation. In that case, I'll just look at
> > > fuse4fs then.
> > >
> > > >
> > > > > but I wonder if having bpf infrastructure hooked up to fuse would be
> > > > > especially helpful for what you're doing here with fuse iomap. afaict,
> > > > > every read/write whether it's buffered or direct will incur at least 1
> > > > > call to ->iomap_begin() to get the mapping metadata, which will be 2
> > > > > context-switches (and if the server has ->iomap_end() implemented,
> > > > > then 2 more context-switches).
> > > >
> > > > Yes, I agree that's a lot of context switching for file IO...
> > > >
> > > > > But it seems like the logic for retrieving mapping
> > > > > offsets/lengths/metadata should be pretty straightforward?
> > > >
> > > > ...but it gets very cheap if the fuse server can cache mappings in the
> > > > kernel to avoid all that.  That is, incidentally, what patchset #7
> > > > implements.
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache_2026-01-22
> > > >
> > > > > If the extent lookups are table lookups or tree
> > > > > traversals without complex side effects, then having
> > > > > ->iomap_begin()/->iomap_end() be executed as a bpf program would avoid
> > > > > the context switches and allow all the caching logic to be moved from
> > > > > the kernel to the server-side (eg using bpf maps).
> > > >
> > > > Hrmm.  Now that /is/ an interesting proposal.  Does BPF have a data
> > > > structure that supports interval mappings?  I think the existing bpf map
> > >
> > > Not yet but I don't see why a b+ tree like data strucutre couldn't be added.
> > > Maybe one workaround in the meantime that could work is using a sorted
> > > array map and doing binary search on that, until interval mappings can
> > > be natively supported?
> >
> > I guess, though I already had a C structure to borrow from xfs ;)
> >
> > > > only does key -> value.  Also, is there an upper limit on the size of a
> > > > map?  You could have hundreds of millions of maps for a very fragmented
> > > > regular file.
> > >
> > > If I'm remembering correctly, there's an upper limit on the number of
> > > map entries, which is bounded by u32
> >
> > That's problematic, since files can have 64-bit logical block numbers.
> 
> The key size supports 64-bits. The u32 bound would be the limit on the
> number of extents for the file.

Oh, ok.  If one treats the incore map as a cache and evicts things when
they get too old, then that would be fine.  I misread that as an upper
limit on the *range* of the map entry keys. :/

As it stands, I need to figure out a way to trim the iomap btree when
memory gets tight.  Right now it'll drop the cache whenever someone
closes the file, but that won't help for long-life processes that open a
heavily fragmented file and never close it.

A coding-intensive way to do that would be to register a shrinker and
deal with that, but ugh.  A really stupid way would be to drop the whole
cache once you get beyond (say) 64k of memory usage (~2000 mappings).

> > > > At one point I suggested to the famfs maintainer that it might be
> > > > easier/better to implement the interleaved mapping lookups as bpf
> > > > programs instead of being stuck with a fixed format in the fuse
> > > > userspace abi, but I don't know if he ever implemented that.
> > >
> > > This seems like a good use case for it too
> > > >
> > > > > Is this your
> > > > > assessment of it as well or do you think the server-side logic for
> > > > > iomap_begin()/iomap_end() is too complicated to make this realistic?
> > > > > Asking because I'm curious whether this direction makes sense, not
> > > > > because I think it would be a blocker for your series.
> > > >
> > > > For disk-based filesystems I think it would be difficult to model a bpf
> > > > program to do mappings, since they can basically point anywhere and be
> > > > of any size.
> > >
> > > Hmm I'm not familiar enough with disk-based filesystems to know what
> > > the "point anywhere and be of any size" means. For the mapping stuff,
> > > doesn't it just point to a block number? Or are you saying the problem
> > > would be there's too many mappings since a mapping could be any size?
> >
> > The second -- mappings can be any size, and unprivileged userspace can
> > control the mappings.
> 
> If I'm understanding what you're saying here, this is the same
> discussion as the one above about the u32 bound, correct?

A different thing -- file data mappings are irregularly sized, can
contain sparse holes, etc.  Userspace controls the size and offset of
each mapping record (thanks to magic things like fallocate) so it'd be
very difficult to create a bpf program to generate mappings on the fly.

Also you could have 2^33 mappings records for a file, so I think you
can't even write a bpf program that large.

> > > I was thinking the issue would be more that there might be other logic
> > > inside ->iomap_begin()/->iomap_end() besides the mapping stuff that
> > > would need to be done that would be too out-of-scope for bpf. But I
> > > think I need to read through the fuse4fs stuff to understand more what
> > > it's doing in those functions.
> 
> Looking at fuse4fs logic cursorily, it seems doable? What I like about
> offloading this to bpf too is it would also then allow John's famfs to
> just go through your iomap plumbing as a use case of it instead of
> being an entirely separate thing. Though maybe there's some other
> reason for that that you guys have discussed prior. In any case, I'll
> ask this on John's main famfs patchset. It kind of seems to me that
> you guys are pretty much doing the exact same thing conceptually.

Yes, though John's famfs has the nice property that memory controller
interleaving is mathematically regular and likely makes for a compact
bpf program.

--D

> Thanks,
> Joanne
> 
> >
> > <nod>
> >
> > --D
> >
> > >
> > > Thanks,
> > > Joanne
> > >
> > > >
> > > > OTOH it would be enormously hilarious to me if one could load a file
> > > > mapping predictive model into the kernel as a bpf program and use that
> > > > as a first tier before checking the in-memory btree mapping cache from
> > > > patchset 7.  Quite a few years ago now there was a FAST paper
> > > > establishing that even a stupid linear regression model could in theory
> > > > beat a disk btree lookup.
> > > >
> > > > --D
> > > >
> > > > > Thanks,
> > > > > Joanne
> > > > >
> > > > > >
> > > > > > If you're going to start using this code, I strongly recommend pulling
> > > > > > from my git trees, which are linked below.
> > > > > >
> > > > > > This has been running on the djcloud for months with no problems.  Enjoy!
> > > > > > Comments and questions are, as always, welcome.
> > > > > >
> > > > > > --D
> > > > > >
> > > > > > kernel git tree:
> > > > > > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-fileio
> > > > > > ---
> > > > > > Commits in this patchset:
> > > > > >  * fuse: implement the basic iomap mechanisms
> > > > > >  * fuse_trace: implement the basic iomap mechanisms
> > > > > >  * fuse: make debugging configurable at runtime
> > > > > >  * fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap devices
> > > > > >  * fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap devices
> > > > > >  * fuse: flush events and send FUSE_SYNCFS and FUSE_DESTROY on unmount
> > > > > >  * fuse: create a per-inode flag for toggling iomap
> > > > > >  * fuse_trace: create a per-inode flag for toggling iomap
> > > > > >  * fuse: isolate the other regular file IO paths from iomap
> > > > > >  * fuse: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HOLE}
> > > > > >  * fuse_trace: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HOLE}
> > > > > >  * fuse: implement direct IO with iomap
> > > > > >  * fuse_trace: implement direct IO with iomap
> > > > > >  * fuse: implement buffered IO with iomap
> > > > > >  * fuse_trace: implement buffered IO with iomap
> > > > > >  * fuse: implement large folios for iomap pagecache files
> > > > > >  * fuse: use an unrestricted backing device with iomap pagecache io
> > > > > >  * fuse: advertise support for iomap
> > > > > >  * fuse: query filesystem geometry when using iomap
> > > > > >  * fuse_trace: query filesystem geometry when using iomap
> > > > > >  * fuse: implement fadvise for iomap files
> > > > > >  * fuse: invalidate ranges of block devices being used for iomap
> > > > > >  * fuse_trace: invalidate ranges of block devices being used for iomap
> > > > > >  * fuse: implement inline data file IO via iomap
> > > > > >  * fuse_trace: implement inline data file IO via iomap
> > > > > >  * fuse: allow more statx fields
> > > > > >  * fuse: support atomic writes with iomap
> > > > > >  * fuse_trace: support atomic writes with iomap
> > > > > >  * fuse: disable direct reclaim for any fuse server that uses iomap
> > > > > >  * fuse: enable swapfile activation on iomap
> > > > > >  * fuse: implement freeze and shutdowns for iomap filesystems
> > > > > > ---
> > > > > >  fs/fuse/fuse_i.h          |  161 +++
> > > > > >  fs/fuse/fuse_trace.h      |  939 +++++++++++++++++++
> > > > > >  fs/fuse/iomap_i.h         |   52 +
> > > > > >  include/uapi/linux/fuse.h |  219 ++++
> > > > > >  fs/fuse/Kconfig           |   48 +
> > > > > >  fs/fuse/Makefile          |    1
> > > > > >  fs/fuse/backing.c         |   12
> > > > > >  fs/fuse/dev.c             |   30 +
> > > > > >  fs/fuse/dir.c             |  120 ++
> > > > > >  fs/fuse/file.c            |  133 ++-
> > > > > >  fs/fuse/file_iomap.c      | 2230 +++++++++++++++++++++++++++++++++++++++++++++
> > > > > >  fs/fuse/inode.c           |  162 +++
> > > > > >  fs/fuse/iomode.c          |    2
> > > > > >  fs/fuse/trace.c           |    2
> > > > > >  14 files changed, 4056 insertions(+), 55 deletions(-)
> > > > > >  create mode 100644 fs/fuse/iomap_i.h
> > > > > >  create mode 100644 fs/fuse/file_iomap.c
> > > > > >
> > > > >
> 

