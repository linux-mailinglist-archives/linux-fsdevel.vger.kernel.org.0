Return-Path: <linux-fsdevel+bounces-75893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO/LCf68e2mnIAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 21:03:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B24B4225
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 21:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0F1D3026AAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 20:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABD531280F;
	Thu, 29 Jan 2026 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WypwZ7px"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7768921CA0D;
	Thu, 29 Jan 2026 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769716975; cv=none; b=RpNaeCgrG5Ta3EIQ6VCfTEAbwp4vJUeCRAVSSgaYQcaYhn3Ot/pvKywclX2x0V8YYsqMO1o5ulz+ibh7dfTYRqi0emcAvXlByW8AIK9fZmniR22YVRU1imfn5Ya3AVYVlL81UetyqMV1hzjsMmKfYuv1s/0x0RLWGWijylWxfnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769716975; c=relaxed/simple;
	bh=wyVn8K7NkWrDNEnfFHGiJ7dVBIk0W+Kcy54EZycLTX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iphm17IWTMnmkTaX2Q2+BNpFBBLhv8AgM3IFdEq+o+mbBTBNWeqPXMjz2mExrK+rKnZRlacc8PKJwasnnhD/OTsOLLzhfq7pvn5CZf2b0ARKgFa0y0kbP7m2MXXu9442eqvOmvJ8VPfa/WWhHHLzR994Lm78JMN1LOBtL/GvHmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WypwZ7px; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F193DC4CEF7;
	Thu, 29 Jan 2026 20:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769716975;
	bh=wyVn8K7NkWrDNEnfFHGiJ7dVBIk0W+Kcy54EZycLTX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WypwZ7pxLxEGiKJHLVD4XRd7jCYyJ+Uz1biS7q81uwoHZoEvOjO/C3VewRGrJrJCX
	 7X5NSitDh697GO3US05fPQ6kWEAD91dkyQWoWzSiWu77JO//IiZirsFYrgKQvoKHVm
	 ib9gZcWfC66TA8U5p6lwR+I5A00yw+OJ8uc69B4OYlPw3vYUwb9PO6EqGNmA5V6YUV
	 EUt5TvbHPh1AHKqhca7yQLHA3Dy6mXVdd6ZSP+sEqr8GFbWvN7jFSJf7ToJi6LIl92
	 gSMjz2TSOMDpNGBbzxrYD7qwluDODj3U5Q+tvRcAagai+RCZhPQyC89ORMQmhxNqWZ
	 cPbLfOUjBjXUA==
Date: Thu, 29 Jan 2026 12:02:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHSET v6 4/8] fuse: allow servers to use iomap for better
 file IO performance
Message-ID: <20260129200254.GA7686@frogsfrogsfrogs>
References: <20251029002755.GK6174@frogsfrogsfrogs>
 <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <CAJnrk1Z05QZmos90qmWtnWGF+Kb7rVziJ51UpuJ0O=A+6N1vrg@mail.gmail.com>
 <20260127022235.GG5900@frogsfrogsfrogs>
 <CAJnrk1bSVy4=c=N_FfOajs1FE4o8T=Br=jFm7gBDaCGvRpgGVA@mail.gmail.com>
 <20260127232125.GA5966@frogsfrogsfrogs>
 <CAJnrk1bxhw2u0qwjw0dJPGdmxEXbcEyKn-=iFrszqof2c8wGCA@mail.gmail.com>
 <20260128003431.GX5910@frogsfrogsfrogs>
 <CAJnrk1aBGx_FQ=_F-PaPshVKvyecdZZt4C0+z+XvNm6=tL0Y_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1aBGx_FQ=_F-PaPshVKvyecdZZt4C0+z+XvNm6=tL0Y_Q@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75893-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2B24B4225
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 05:12:54PM -0800, Joanne Koong wrote:

<snip>

> > > > > > Hrmm.  Now that /is/ an interesting proposal.  Does BPF have a data
> > > > > > structure that supports interval mappings?  I think the existing bpf map
> > > > >
> > > > > Not yet but I don't see why a b+ tree like data strucutre couldn't be added.
> > > > > Maybe one workaround in the meantime that could work is using a sorted
> > > > > array map and doing binary search on that, until interval mappings can
> > > > > be natively supported?
> > > >
> > > > I guess, though I already had a C structure to borrow from xfs ;)
> > > >
> > > > > > only does key -> value.  Also, is there an upper limit on the size of a
> > > > > > map?  You could have hundreds of millions of maps for a very fragmented
> > > > > > regular file.
> > > > >
> > > > > If I'm remembering correctly, there's an upper limit on the number of
> > > > > map entries, which is bounded by u32
> > > >
> > > > That's problematic, since files can have 64-bit logical block numbers.
> > >
> > > The key size supports 64-bits. The u32 bound would be the limit on the
> > > number of extents for the file.
> >
> > Oh, ok.  If one treats the incore map as a cache and evicts things when
> > they get too old, then that would be fine.  I misread that as an upper
> > limit on the *range* of the map entry keys. :/
> 
> I think for more complicated servers, the bpf prog handling for
> iomap_begin() would essentially just serve as a cache where if it's
> not found in the cache, then it sends off the FUSE_IOMAP_BEGIN request
> to the server. For servers that don't need as much complicated logic
> (eg famfs), the iomap_begin() logic would just be executed within the
> bpf prog itself.

Yes, I like the fuse_iomap_begin logic flow of:

1. Try to use a mapping in the iext tree
2. Call a BPF program to try to generate a mapping
3. Issue a fuse command to userspace

wherein #2 and #3 can signal that #1 should be retried.  (This is
already provided by FUSE_IOMAP_TYPE_RETRY_CACHE, FWIW)

That said, BPF doesn't expose an interval btree data structure.  I think
it would be better to add the iext mapping cache and make it so that bpf
programs could call fuse_iomap_cache_{upsert,remove,lookup}.  You could
use the interval tree too, but the iext tree has the advantage of higher
fanout factor.

> > As it stands, I need to figure out a way to trim the iomap btree when
> > memory gets tight.  Right now it'll drop the cache whenever someone
> > closes the file, but that won't help for long-life processes that open a
> > heavily fragmented file and never close it.
> >
> > A coding-intensive way to do that would be to register a shrinker and
> > deal with that, but ugh.  A really stupid way would be to drop the whole
> > cache once you get beyond (say) 64k of memory usage (~2000 mappings).
> 
> This kind of seems like another point in favor of giving userspace
> control of the caching layer. They could then implement whatever
> eviction policies they want.

Note that userspace already can control the cached iomappings --
FUSE_NOTIFY_IOMAP_UPSERT pushes a mapping into the iext tree, and
FUSE_NOTIFY_IOMAP_INVAL removes them.  The fuse server can decide to
evict whenever it pleases, though admittedly the iext tree doesn't track
usage information of any kind, so how would the fuse server know?

The static limit is merely the kernel's means to establish a hard limit
on the memory consumption of the iext tree, since it can't trust
userspace completely.

> It also allows them to prepopulate the cache upfront (eg when
> servicing a file open request, if the file is below a certain size or
> if the server knows what'll be hot, it could put those extents into
> the map from the get-go).

Hrm.  I haven't tried issuing FUSE_NOTIFY_IOMAP_UPSERT during an open
call, but I suppose it's possible.

> in my opinion, the fuse-iomap layer should try to be as simple/minimal
> and as generic as possible. I haven't read through iomap_cache.c yet
> but the header comment suggests it's adapted from the xfs extent tree

Rudely copied, not adapted ;)

I actually wonder if I should make a horrible macro to generate the
fuse_iext_* structures and functions, and then xfs_iext_tree.c and
fuse_iomap_cache.c can "share" that hairba^Wcode.

> cache. As I understand it, different filesystem implementations have
> different caching architectures that are better suited for their use
> cases

Err.  The way this evolved is ... way too long to go into in this email.
Here's a truncated version; I can tell you the full story next week.

Most filesystems store their file mapping data on disk in whatever
format the designers specified.  When the pagecache asks them to read
or write the cache, they attach buffer heads to the folio, fill out the
buffer heads with the minimum mapping information needed to map the
folios to disk addresses.  bios are constructed for each folio based on
what's in the bufferhead.

This was fine for filesystems that map each block individually, such as
FFS/ext2/ext3/fat...

> (I'm guessing that's the case, otherwise there would just be one
> general cache inside iomap all the filesystems would use?). It seems a

...but newer filesystems such as xfs/ext4/btrfs map a bunch of blocks at
a time.  Each of them invented their own private incore mapping
structures to mirror the ondisk structure.  xfs kept using the old
bufferheads into the early 2010s, ext4 is still using them, and btrfs
went its own way from the start.

Eventually XFS grew its own internal extent-to-bio mapping code that
flipped the model -- rather than get a pagecache folio, map the folio to
blocks, and issue IOs based on the blocks, it would get the file
mapping, grab folios for the whole mapping, and issue bios for the batch
of folios.  That's more efficient, but at this point we have a legacy
codebase problem for everything else in fs/.

In 2019, hch and I decided to export the extent-to-bio mapping code from
xfs so that new filesystems could start with something cleaner than
bufferheads.  In the past 7 years, nobody's added a new filesystem with
complex mapping requirements; they've only ported existing filesystems
to it, without further refactoring of their incore data structures.
That's why there's no generic iomap cache.

> lot better to me to just let the userspace server define that
> themselves. And selfishly from the fuse perspective, would be less

Well if I turned the iext code into a template then fuse would only need
enough glue code to declare a template class and use it.  The glue part
is only ... 230LOC.

> code we would have to maintain. And I guess too if some servers don't
> need caching (like famfs?), they could avoid that overhead.

Hrm.  Right now the struct fuse_iomap_cache is embedded in struct
fuse_inode, but that could be turned into a dynamic allocation.

> > > > > > At one point I suggested to the famfs maintainer that it might be
> > > > > > easier/better to implement the interleaved mapping lookups as bpf
> > > > > > programs instead of being stuck with a fixed format in the fuse
> > > > > > userspace abi, but I don't know if he ever implemented that.
> > > > >
> > > > > This seems like a good use case for it too
> > > > > >
> > > > > > > Is this your
> > > > > > > assessment of it as well or do you think the server-side logic for
> > > > > > > iomap_begin()/iomap_end() is too complicated to make this realistic?
> > > > > > > Asking because I'm curious whether this direction makes sense, not
> > > > > > > because I think it would be a blocker for your series.
> > > > > >
> > > > > > For disk-based filesystems I think it would be difficult to model a bpf
> > > > > > program to do mappings, since they can basically point anywhere and be
> > > > > > of any size.
> > > > >
> > > > > Hmm I'm not familiar enough with disk-based filesystems to know what
> > > > > the "point anywhere and be of any size" means. For the mapping stuff,
> > > > > doesn't it just point to a block number? Or are you saying the problem
> > > > > would be there's too many mappings since a mapping could be any size?
> > > >
> > > > The second -- mappings can be any size, and unprivileged userspace can
> > > > control the mappings.
> > >
> > > If I'm understanding what you're saying here, this is the same
> > > discussion as the one above about the u32 bound, correct?
> >
> > A different thing -- file data mappings are irregularly sized, can
> > contain sparse holes, etc.  Userspace controls the size and offset of
> > each mapping record (thanks to magic things like fallocate) so it'd be
> > very difficult to create a bpf program to generate mappings on the fly.
> 
> Would the bpf prog have to generate mappings on the fly though? If the
> userspace does things like fallocate, those operations would still go
> through to the server as a regular request (eg FUSE_FALLOCATE) and on
> the server side, it'd add that to the map dynamically from userspace.

That depends on the fuse server design.  For simple things like famfs
where the layout is bog simple and there's no fancy features like
delayed allocation or unwritten extents, then you could probably get
away a BPF program to generate the entire mapping set.  I suspect an
object-store type filesystem (aka write a file once, close it, snapshot
it, and never change it again) might be good at landing all the file
data in relatively few extent mappings, and it could actually compile a
custom bpf program for that file and push it to the kernel.

> > Also you could have 2^33 mappings records for a file, so I think you
> > can't even write a bpf program that large.
> 
> I think this depends on what map structure gets used. If there is
> native support added for b+ tree like data structures, I don't see why
> it wouldn't be able to.

<nod>

> > > > > I was thinking the issue would be more that there might be other logic
> > > > > inside ->iomap_begin()/->iomap_end() besides the mapping stuff that
> > > > > would need to be done that would be too out-of-scope for bpf. But I
> > > > > think I need to read through the fuse4fs stuff to understand more what
> > > > > it's doing in those functions.
> > >
> > > Looking at fuse4fs logic cursorily, it seems doable? What I like about
> > > offloading this to bpf too is it would also then allow John's famfs to
> > > just go through your iomap plumbing as a use case of it instead of
> > > being an entirely separate thing. Though maybe there's some other
> > > reason for that that you guys have discussed prior. In any case, I'll
> > > ask this on John's main famfs patchset. It kind of seems to me that
> > > you guys are pretty much doing the exact same thing conceptually.
> >
> > Yes, though John's famfs has the nice property that memory controller
> > interleaving is mathematically regular and likely makes for a compact
> > bpf program.
> 
> I tried out integrating the bpf hooks into fuse for iomap_begin() just
> to see if it was realistic and it seems relatively straightforward so
> far (though maybe the devil is in the details...). I used the

Ok, now *that's* interesting!  I guess I had better push the latest
fuse-iomap code ... but I cannot share a link, because I cannot get
through the @!#%%!!! kernel.org anubis bullcrap.

So I generated a pull request and I *think* this munged URL will work
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-service-container_2026-01-29

Or I guess you could just git-pull this:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git tags/fuse-service-container_2026-01-29

> drivers/hid/bpf/hid_bpf_struct_ops.c program as a model for how to set
> up the fuse bpf struct ops on the kernel side. calling it from
> file_iomap.c looks something like
> 
> static int fuse_iomap_begin(...)
> {
>        ...
>        struct fuse_bpf_ops *bpf_ops = fuse_get_bpf_ops();
>        ...
>       err = -EOPNOTSUPP;
>       if (bpf_ops && bpf_ops->iomap_begin)
>                err = bpf_ops->iomap_begin(inode, pos, len, flags, &outarg);
>        if (err)
>                err = fuse_simple_request(fm, &args);
>       ...
> }

I'm curious what the rest of the bpf integration code looks like.

> and I was able to verify that iomap_begin() is able to return back
> populated outarg fields from the bpf prog. If we were to actually
> implement it i'm sure it'd be more complicated (eg we'd need to make
> the fuse_bpf_ops registered per-connection, etc) but on the whole it

What is a fuse_bpf_ops?  I'm assuming that's the attachment point for a
bpf program that the fuse server would compile?  In which case, yes, I
think that ought to be per-connection.

So the bpf program can examine the struct inode, and the pos/len/opflags
field; and from that information it has to write the appropriate fields
in &outarg?  That's new, I didn't think bpf was allowed to write to
kernel memory.  But it's been a few years since I last touched the bpf
internals.

Some bpf programs might just know how to fill out outarg on their own
(e.g. famfs memory interleaving) but other bpf programs might perform a
range query on some imaginary bpf-interval-tree wherein you can do a
fast lookup based on (inumber, pos, len)?

I guess that's an interesting question -- would each fuse connection
have one big bpf-interval-tree?  Or would you shard things by inode to
reduce contention?  And if you sharded like that, then would you need a
fuse_bpf_ops per inode?

(I'm imagining that the fuse_bpf_ops might be where you'd stash the root
of the bpf data structure, but I know nothing of bpf internals ;))

Rolling on: how easy is it for a userspace program to compile and upload
bpf programs into the kernel?  I've played around with bcc enough to
write some fairly stupid latency tracing tools for XFS, but at the end
of the day it still python scripts feeding a string full of maybe-C into
whatever the BPF does under the hood.

I /think/ it calls clang on the provided text, links that against the
current kernel's header files, and pushes the compiled bpf binary into
the kernel, right?  So fuse4fs would have to learn how to do that; and
now fuse4fs has a runtime dependency on libllvm.

And while I'm on the topic of fuse-bpf uapi: It's ok for us to expose
primitive-typed variables (pos/len/opflags) and existing fuse uapi
directly to a bpf program, but I don't think we should expose struct
inode/fuse_inode.  Maybe just fuse_inode::nodeid?  If we're careful not
to allow #include'ing structured types in the fuse bpf code, then
perhaps the bpf programs could be compiled at the same time as the fuse
server.

> seems doable. My worry is that if we land the iomap cache patchset now
> then we can't remove it in the future without breaking backwards
> compatibility for being a performance regression (though maybe we can
> since the fuse-iomap stuff is experimental?), so imo it'd be great if

I don't think it's a huge problem to remove functionality while the
EXPERIMENTAL warnings are in place.  We'd forever lose the command codes
for FUSE_NOTIFY_IOMAP_UPSERT and FUSE_NOTIFY_IOMAP_INVAL, but we've only
used 12 out of INT_MAX so that's not likely to be a concern.

> we figured out what direction we want to go before landing the cache
> stuff. And I think we need to have this conversation too on the main
> famfs patchset (eg whether it should go through your general iomap
> plumbing with bpf helpers vs. being a separate implementation) since
> once that lands, it'd be irrevocable.

I've of two minds on that -- John got here first, so I don't want to
delay his patchset whilst I slowly work on this thing.  OTOH from an
architecture standpoint we probably ought to push for three ways for a
fuse server to upload mappings:

1. Upserting mappings with arbitrary offset and size into a cache
2. Self contained bpf program that can generate any mapping
3. Sprawling bpf program that can read any other artifacts that another
   bpf program might have set up for it

But yeah, let's involve John.

--D

> 
> Thanks,
> Joanne
> >
> > --D
> >
> > > Thanks,
> > > Joanne
> > >
> > > >
> > > > <nod>
> > > >
> > > > --D
> > > >
> > > > >
> > > > > Thanks,
> > > > > Joanne
> > > > >
> > > > > >
> > > > > > OTOH it would be enormously hilarious to me if one could load a file
> > > > > > mapping predictive model into the kernel as a bpf program and use that
> > > > > > as a first tier before checking the in-memory btree mapping cache from
> > > > > > patchset 7.  Quite a few years ago now there was a FAST paper
> > > > > > establishing that even a stupid linear regression model could in theory
> > > > > > beat a disk btree lookup.
> > > > > >
> > > > > > --D
> > > > > >
> > > > > > > Thanks,
> > > > > > > Joanne
> > > > > > >
> > > > > > > >
> > > > > > > > If you're going to start using this code, I strongly recommend pulling
> > > > > > > > from my git trees, which are linked below.
> > > > > > > >
> > > > > > > > This has been running on the djcloud for months with no problems.  Enjoy!
> > > > > > > > Comments and questions are, as always, welcome.
> > > > > > > >
> > > > > > > > --D
> > > > > > > >
> > > > > > > > kernel git tree:
> > > > > > > > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-fileio
> > > > > > > > ---
> > > > > > > > Commits in this patchset:
> > > > > > > >  * fuse: implement the basic iomap mechanisms
> > > > > > > >  * fuse_trace: implement the basic iomap mechanisms
> > > > > > > >  * fuse: make debugging configurable at runtime
> > > > > > > >  * fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap devices
> > > > > > > >  * fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap devices
> > > > > > > >  * fuse: flush events and send FUSE_SYNCFS and FUSE_DESTROY on unmount
> > > > > > > >  * fuse: create a per-inode flag for toggling iomap
> > > > > > > >  * fuse_trace: create a per-inode flag for toggling iomap
> > > > > > > >  * fuse: isolate the other regular file IO paths from iomap
> > > > > > > >  * fuse: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HOLE}
> > > > > > > >  * fuse_trace: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HOLE}
> > > > > > > >  * fuse: implement direct IO with iomap
> > > > > > > >  * fuse_trace: implement direct IO with iomap
> > > > > > > >  * fuse: implement buffered IO with iomap
> > > > > > > >  * fuse_trace: implement buffered IO with iomap
> > > > > > > >  * fuse: implement large folios for iomap pagecache files
> > > > > > > >  * fuse: use an unrestricted backing device with iomap pagecache io
> > > > > > > >  * fuse: advertise support for iomap
> > > > > > > >  * fuse: query filesystem geometry when using iomap
> > > > > > > >  * fuse_trace: query filesystem geometry when using iomap
> > > > > > > >  * fuse: implement fadvise for iomap files
> > > > > > > >  * fuse: invalidate ranges of block devices being used for iomap
> > > > > > > >  * fuse_trace: invalidate ranges of block devices being used for iomap
> > > > > > > >  * fuse: implement inline data file IO via iomap
> > > > > > > >  * fuse_trace: implement inline data file IO via iomap
> > > > > > > >  * fuse: allow more statx fields
> > > > > > > >  * fuse: support atomic writes with iomap
> > > > > > > >  * fuse_trace: support atomic writes with iomap
> > > > > > > >  * fuse: disable direct reclaim for any fuse server that uses iomap
> > > > > > > >  * fuse: enable swapfile activation on iomap
> > > > > > > >  * fuse: implement freeze and shutdowns for iomap filesystems
> > > > > > > > ---
> > > > > > > >  fs/fuse/fuse_i.h          |  161 +++
> > > > > > > >  fs/fuse/fuse_trace.h      |  939 +++++++++++++++++++
> > > > > > > >  fs/fuse/iomap_i.h         |   52 +
> > > > > > > >  include/uapi/linux/fuse.h |  219 ++++
> > > > > > > >  fs/fuse/Kconfig           |   48 +
> > > > > > > >  fs/fuse/Makefile          |    1
> > > > > > > >  fs/fuse/backing.c         |   12
> > > > > > > >  fs/fuse/dev.c             |   30 +
> > > > > > > >  fs/fuse/dir.c             |  120 ++
> > > > > > > >  fs/fuse/file.c            |  133 ++-
> > > > > > > >  fs/fuse/file_iomap.c      | 2230 +++++++++++++++++++++++++++++++++++++++++++++
> > > > > > > >  fs/fuse/inode.c           |  162 +++
> > > > > > > >  fs/fuse/iomode.c          |    2
> > > > > > > >  fs/fuse/trace.c           |    2
> > > > > > > >  14 files changed, 4056 insertions(+), 55 deletions(-)
> > > > > > > >  create mode 100644 fs/fuse/iomap_i.h
> > > > > > > >  create mode 100644 fs/fuse/file_iomap.c
> > > > > > > >
> > > > > > >
> > >
> 

