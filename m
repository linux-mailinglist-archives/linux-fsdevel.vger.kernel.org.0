Return-Path: <linux-fsdevel+bounces-75919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP45K1/pe2mtJQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 00:12:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EE5B599E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 00:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE0F7301C175
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 23:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C9737419F;
	Thu, 29 Jan 2026 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyShugB1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198C374171;
	Thu, 29 Jan 2026 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728338; cv=none; b=nTJnnLpDOqI398Ci9+FU4CKaUpSoLFZkhQiHSF/8zwR7LDGKNMiHwkk/6y7853RLeipMfvWT/Z8q1p6Su5RcKU2vkvsJa1tCmMHdymOwYdhLqIPL02b7skrSOzSdTEtxgx3q2CcJZSenJGvKXh8nOEfAHPusYw9a0rruMnA2F8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728338; c=relaxed/simple;
	bh=Aq7sAxqifQQGtuqp8U7Oa3vpvJwch+zAlCw6lD6Ok7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9Aq9npe09BMxS7wMcEcaZNuF/UrSQcuj0P/gcl5efQFVTYcnCd9IM+OvqRykXHg+9d5ePwS22IZ80en9crHA53O5MqFg8qaEXJLAAlLE6e1CABfyDnQ022JDl4QIRY9+y50iK/RJLMwnI0TPLIYXytwnvucEXhNZzN1pOVn3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyShugB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2D6C4CEF7;
	Thu, 29 Jan 2026 23:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769728338;
	bh=Aq7sAxqifQQGtuqp8U7Oa3vpvJwch+zAlCw6lD6Ok7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oyShugB1PUyP1CZIv5ZwT/8pBVte0gj/bRo8fAPRjxVOdUWWzbs/JtMgAihs10OM3
	 N0nLpJe6NQKkUoSqPhbU5XbWfEFtrVWZv43byRSGyKEa2faWnyb8G34aM4JG0N9QYj
	 tNG0lpNipom1oLsVGfBUPQGwkvu8x5n65VIfaz3U020iHMVuVktLHh4mOxW0uB53WL
	 dziLPRRn4GymGDRjANFcp8nf9z/QEq6YgR24qTDx23r8jcHjKyAsv4tVTBMoISiX7N
	 I4nlUYmUp5CoP6/K38mDr+BbNW88YFS8OBhxqTd0U8CLcXvLgBm7NUTV9MFwYynpYD
	 s3P05GGKGuWCA==
Date: Thu, 29 Jan 2026 15:12:17 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHSET v6 4/8] fuse: allow servers to use iomap for better
 file IO performance
Message-ID: <20260129231217.GA7693@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <CAJnrk1Z05QZmos90qmWtnWGF+Kb7rVziJ51UpuJ0O=A+6N1vrg@mail.gmail.com>
 <20260127022235.GG5900@frogsfrogsfrogs>
 <CAJnrk1bSVy4=c=N_FfOajs1FE4o8T=Br=jFm7gBDaCGvRpgGVA@mail.gmail.com>
 <20260127232125.GA5966@frogsfrogsfrogs>
 <CAJnrk1bxhw2u0qwjw0dJPGdmxEXbcEyKn-=iFrszqof2c8wGCA@mail.gmail.com>
 <20260128003431.GX5910@frogsfrogsfrogs>
 <CAJnrk1aBGx_FQ=_F-PaPshVKvyecdZZt4C0+z+XvNm6=tL0Y_Q@mail.gmail.com>
 <20260129200254.GA7686@frogsfrogsfrogs>
 <CAJnrk1ag3ffQC=U1ZXVLTipDyo1VBQBM3MYNB6=6d4ywLOEieA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ag3ffQC=U1ZXVLTipDyo1VBQBM3MYNB6=6d4ywLOEieA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-75919-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 53EE5B599E
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 02:50:23PM -0800, Joanne Koong wrote:
> On Thu, Jan 29, 2026 at 12:02 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Jan 28, 2026 at 05:12:54PM -0800, Joanne Koong wrote:
> >
> > <snip>
> >
> > > > > > > > Hrmm.  Now that /is/ an interesting proposal.  Does BPF have a data
> > > > > > > > structure that supports interval mappings?  I think the existing bpf map
> > > > > > >
> > > > > > > Not yet but I don't see why a b+ tree like data strucutre couldn't be added.
> > > > > > > Maybe one workaround in the meantime that could work is using a sorted
> > > > > > > array map and doing binary search on that, until interval mappings can
> > > > > > > be natively supported?
> > > > > >
> > > > > > I guess, though I already had a C structure to borrow from xfs ;)
> > > > > >
> > > > > > > > only does key -> value.  Also, is there an upper limit on the size of a
> > > > > > > > map?  You could have hundreds of millions of maps for a very fragmented
> > > > > > > > regular file.
> > > > > > >
> > > > > > > If I'm remembering correctly, there's an upper limit on the number of
> > > > > > > map entries, which is bounded by u32
> > > > > >
> > > > > > That's problematic, since files can have 64-bit logical block numbers.
> > > > >
> > > > > The key size supports 64-bits. The u32 bound would be the limit on the
> > > > > number of extents for the file.
> > > >
> > > > Oh, ok.  If one treats the incore map as a cache and evicts things when
> > > > they get too old, then that would be fine.  I misread that as an upper
> > > > limit on the *range* of the map entry keys. :/
> > >
> > > I think for more complicated servers, the bpf prog handling for
> > > iomap_begin() would essentially just serve as a cache where if it's
> > > not found in the cache, then it sends off the FUSE_IOMAP_BEGIN request
> > > to the server. For servers that don't need as much complicated logic
> > > (eg famfs), the iomap_begin() logic would just be executed within the
> > > bpf prog itself.
> >
> > Yes, I like the fuse_iomap_begin logic flow of:
> >
> > 1. Try to use a mapping in the iext tree
> > 2. Call a BPF program to try to generate a mapping
> > 3. Issue a fuse command to userspace
> >
> > wherein #2 and #3 can signal that #1 should be retried.  (This is
> > already provided by FUSE_IOMAP_TYPE_RETRY_CACHE, FWIW)
> >
> > That said, BPF doesn't expose an interval btree data structure.  I think
> > it would be better to add the iext mapping cache and make it so that bpf
> > programs could call fuse_iomap_cache_{upsert,remove,lookup}.  You could
> > use the interval tree too, but the iext tree has the advantage of higher
> > fanout factor.
> >
> > > > As it stands, I need to figure out a way to trim the iomap btree when
> > > > memory gets tight.  Right now it'll drop the cache whenever someone
> > > > closes the file, but that won't help for long-life processes that open a
> > > > heavily fragmented file and never close it.
> > > >
> > > > A coding-intensive way to do that would be to register a shrinker and
> > > > deal with that, but ugh.  A really stupid way would be to drop the whole
> > > > cache once you get beyond (say) 64k of memory usage (~2000 mappings).
> > >
> > > This kind of seems like another point in favor of giving userspace
> > > control of the caching layer. They could then implement whatever
> > > eviction policies they want.
> >
> > Note that userspace already can control the cached iomappings --
> > FUSE_NOTIFY_IOMAP_UPSERT pushes a mapping into the iext tree, and
> > FUSE_NOTIFY_IOMAP_INVAL removes them.  The fuse server can decide to
> 
> This incurs round-trip context-switch costs though, which the bpf prog
> approach doesn't incur.

I realize that, but I think we're simply headed towards a fast path
wherein you can upload a bpf program; and a slow path for big complex
filesystems like ext4.  ext4 always gonna be slow. :)

> > evict whenever it pleases, though admittedly the iext tree doesn't track
> > usage information of any kind, so how would the fuse server know?
> >
> > The static limit is merely the kernel's means to establish a hard limit
> > on the memory consumption of the iext tree, since it can't trust
> > userspace completely.
> >
> > > It also allows them to prepopulate the cache upfront (eg when
> > > servicing a file open request, if the file is below a certain size or
> > > if the server knows what'll be hot, it could put those extents into
> > > the map from the get-go).
> >
> > Hrm.  I haven't tried issuing FUSE_NOTIFY_IOMAP_UPSERT during an open
> > call, but I suppose it's possible.

(It's quite possible; running through QA now)

> > > in my opinion, the fuse-iomap layer should try to be as simple/minimal
> > > and as generic as possible. I haven't read through iomap_cache.c yet
> > > but the header comment suggests it's adapted from the xfs extent tree
> >
> > Rudely copied, not adapted ;)
> >
> > I actually wonder if I should make a horrible macro to generate the
> > fuse_iext_* structures and functions, and then xfs_iext_tree.c and
> > fuse_iomap_cache.c can "share" that hairba^Wcode.
> >
> > > cache. As I understand it, different filesystem implementations have
> > > different caching architectures that are better suited for their use
> > > cases
> >
> > Err.  The way this evolved is ... way too long to go into in this email.
> > Here's a truncated version; I can tell you the full story next week.
> >
> > Most filesystems store their file mapping data on disk in whatever
> > format the designers specified.  When the pagecache asks them to read
> > or write the cache, they attach buffer heads to the folio, fill out the
> > buffer heads with the minimum mapping information needed to map the
> > folios to disk addresses.  bios are constructed for each folio based on
> > what's in the bufferhead.
> >
> > This was fine for filesystems that map each block individually, such as
> > FFS/ext2/ext3/fat...
> >
> > > (I'm guessing that's the case, otherwise there would just be one
> > > general cache inside iomap all the filesystems would use?). It seems a
> >
> > ...but newer filesystems such as xfs/ext4/btrfs map a bunch of blocks at
> > a time.  Each of them invented their own private incore mapping
> > structures to mirror the ondisk structure.  xfs kept using the old
> > bufferheads into the early 2010s, ext4 is still using them, and btrfs
> > went its own way from the start.
> >
> > Eventually XFS grew its own internal extent-to-bio mapping code that
> > flipped the model -- rather than get a pagecache folio, map the folio to
> > blocks, and issue IOs based on the blocks, it would get the file
> > mapping, grab folios for the whole mapping, and issue bios for the batch
> > of folios.  That's more efficient, but at this point we have a legacy
> > codebase problem for everything else in fs/.
> >
> > In 2019, hch and I decided to export the extent-to-bio mapping code from
> > xfs so that new filesystems could start with something cleaner than
> > bufferheads.  In the past 7 years, nobody's added a new filesystem with
> > complex mapping requirements; they've only ported existing filesystems
> > to it, without further refactoring of their incore data structures.
> > That's why there's no generic iomap cache.
> 
> Oh I see, so it actually *is* a generic cache? Just that the other

No, quite the opposite.  fs/iomap/ handles individual mapping records,
but does not itself implement a cache.  A filesystem /could/ decide that
it wants to translate its ondisk mappings directly into a struct iomap
and then push that struct iomap object into a cache, but it would have
to implement the incore cache itself.

"struct iomap" is merely a generic interface; prior to the hoist, the IO
mapping code in xfs directly handled struct xfs_bmbt_irec objects.  Now
xfs translates xfs_bmbt_irec objects from its own cache into a struct
iomap and returns that from ->iomap_begin.

That said it wouldn't be terrible to provide a generic cache
implementation.  But the hard part is that caching struct iomap objects
would result in more memory use for XFS because xfs_bmbt_irec is
bitpacked.

> filesystems haven't ported over to it yet? That changes my opinion a
> lot on this then. If it's a generic cache that pretty much any modern
> filesystem should use, then it seems reasonable to me to have it on
> the fuse iomap kernel side. Though in that case, it seems a lot
> cleaner imo if the cache could be ported to the iomap layer as a
> generic cache (which seems like it'd be useful anyways for other
> filesystems to use if/when they port over to it, if I'm understanding
> what you're saying correctly), and then fuse just call into that api.

<nod> That sounds like a good long term goal.  For now let's get it
working inside fuse and then we can see if any other filesystems are
interested.

Also unclear: do filesystems want to hang more data off the incore
mapping data than the dataset that iomap itself needs?  That would
hamper attempts to make a generic iomap cache.

> >
> > > lot better to me to just let the userspace server define that
> > > themselves. And selfishly from the fuse perspective, would be less
> >
> > Well if I turned the iext code into a template then fuse would only need
> > enough glue code to declare a template class and use it.  The glue part
> > is only ... 230LOC.
> 
> Nice, I think this would be a lot nicer / less of a headache in the
> future for fuse to maintain.
> 
> >
> > > code we would have to maintain. And I guess too if some servers don't
> > > need caching (like famfs?), they could avoid that overhead.
> >
> > Hrm.  Right now the struct fuse_iomap_cache is embedded in struct
> > fuse_inode, but that could be turned into a dynamic allocation.
> >
> > > > > > > > At one point I suggested to the famfs maintainer that it might be
> > > > > > > > easier/better to implement the interleaved mapping lookups as bpf
> > > > > > > > programs instead of being stuck with a fixed format in the fuse
> > > > > > > > userspace abi, but I don't know if he ever implemented that.
> > > > > > >
> > > > > > > This seems like a good use case for it too
> > > > > > > >
> > > > > > > > > Is this your
> > > > > > > > > assessment of it as well or do you think the server-side logic for
> > > > > > > > > iomap_begin()/iomap_end() is too complicated to make this realistic?
> > > > > > > > > Asking because I'm curious whether this direction makes sense, not
> > > > > > > > > because I think it would be a blocker for your series.
> > > > > > > >
> > > > > > > > For disk-based filesystems I think it would be difficult to model a bpf
> > > > > > > > program to do mappings, since they can basically point anywhere and be
> > > > > > > > of any size.
> > > > > > >
> > > > > > > Hmm I'm not familiar enough with disk-based filesystems to know what
> > > > > > > the "point anywhere and be of any size" means. For the mapping stuff,
> > > > > > > doesn't it just point to a block number? Or are you saying the problem
> > > > > > > would be there's too many mappings since a mapping could be any size?
> > > > > >
> > > > > > The second -- mappings can be any size, and unprivileged userspace can
> > > > > > control the mappings.
> > > > >
> > > > > If I'm understanding what you're saying here, this is the same
> > > > > discussion as the one above about the u32 bound, correct?
> > > >
> > > > A different thing -- file data mappings are irregularly sized, can
> > > > contain sparse holes, etc.  Userspace controls the size and offset of
> > > > each mapping record (thanks to magic things like fallocate) so it'd be
> > > > very difficult to create a bpf program to generate mappings on the fly.
> > >
> > > Would the bpf prog have to generate mappings on the fly though? If the
> > > userspace does things like fallocate, those operations would still go
> > > through to the server as a regular request (eg FUSE_FALLOCATE) and on
> > > the server side, it'd add that to the map dynamically from userspace.
> >
> > That depends on the fuse server design.  For simple things like famfs
> > where the layout is bog simple and there's no fancy features like
> > delayed allocation or unwritten extents, then you could probably get
> > away a BPF program to generate the entire mapping set.  I suspect an
> > object-store type filesystem (aka write a file once, close it, snapshot
> > it, and never change it again) might be good at landing all the file
> > data in relatively few extent mappings, and it could actually compile a
> > custom bpf program for that file and push it to the kernel.
> >
> > > > Also you could have 2^33 mappings records for a file, so I think you
> > > > can't even write a bpf program that large.
> > >
> > > I think this depends on what map structure gets used. If there is
> > > native support added for b+ tree like data structures, I don't see why
> > > it wouldn't be able to.
> >
> > <nod>
> >
> > > > > > > I was thinking the issue would be more that there might be other logic
> > > > > > > inside ->iomap_begin()/->iomap_end() besides the mapping stuff that
> > > > > > > would need to be done that would be too out-of-scope for bpf. But I
> > > > > > > think I need to read through the fuse4fs stuff to understand more what
> > > > > > > it's doing in those functions.
> > > > >
> > > > > Looking at fuse4fs logic cursorily, it seems doable? What I like about
> > > > > offloading this to bpf too is it would also then allow John's famfs to
> > > > > just go through your iomap plumbing as a use case of it instead of
> > > > > being an entirely separate thing. Though maybe there's some other
> > > > > reason for that that you guys have discussed prior. In any case, I'll
> > > > > ask this on John's main famfs patchset. It kind of seems to me that
> > > > > you guys are pretty much doing the exact same thing conceptually.
> > > >
> > > > Yes, though John's famfs has the nice property that memory controller
> > > > interleaving is mathematically regular and likely makes for a compact
> > > > bpf program.
> > >
> > > I tried out integrating the bpf hooks into fuse for iomap_begin() just
> > > to see if it was realistic and it seems relatively straightforward so
> > > far (though maybe the devil is in the details...). I used the
> >
> > Ok, now *that's* interesting!  I guess I had better push the latest
> > fuse-iomap code ... but I cannot share a link, because I cannot get
> > through the @!#%%!!! kernel.org anubis bullcrap.
> >
> > So I generated a pull request and I *think* this munged URL will work
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-service-container_2026-01-29
> >
> > Or I guess you could just git-pull this:
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git tags/fuse-service-container_2026-01-29
> >
> > > drivers/hid/bpf/hid_bpf_struct_ops.c program as a model for how to set
> > > up the fuse bpf struct ops on the kernel side. calling it from
> > > file_iomap.c looks something like
> > >
> > > static int fuse_iomap_begin(...)
> > > {
> > >        ...
> > >        struct fuse_bpf_ops *bpf_ops = fuse_get_bpf_ops();
> > >        ...
> > >       err = -EOPNOTSUPP;
> > >       if (bpf_ops && bpf_ops->iomap_begin)
> > >                err = bpf_ops->iomap_begin(inode, pos, len, flags, &outarg);
> > >        if (err)
> > >                err = fuse_simple_request(fm, &args);
> > >       ...
> > > }
> >
> > I'm curious what the rest of the bpf integration code looks like.
> 
> This is the code I had yesterday (I didn't know how to run the fuse4fs
> stuff, so I used passthrough_hp as the server and had the trigger go
> through statfs):

Yeah, it's nasty ... you have to go build a patched libfuse3, then
grab the modified e2fsprogs, modify your ./configure commandline to
point itself at the built libfuse3, and then it'll build fuse4fs.

> 
> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> index 22ad9538dfc4..10c3939f4cf3 100644
> --- a/fs/fuse/Makefile
> +++ b/fs/fuse/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
>  fuse-y := trace.o      # put trace.o first so we see ftrace errors sooner
>  fuse-y += dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
>  fuse-y += iomode.o
> +fuse-y += fuse_bpf.o
>  fuse-$(CONFIG_FUSE_DAX) += dax.o
>  fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o backing.o
>  fuse-$(CONFIG_SYSCTL) += sysctl.o
> diff --git a/fs/fuse/fuse_bpf.c b/fs/fuse/fuse_bpf.c
> new file mode 100644
> index 000000000000..637cf152e997
> --- /dev/null
> +++ b/fs/fuse/fuse_bpf.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +
> +#include "fuse_i.h"
> +#include "fuse_dev_i.h"
> +#include "fuse_bpf.h"
> +
> +static struct btf *fuse_bpf_ops_btf;
> +static struct fuse_bpf_ops *active_bpf_ops;
> +
> +static int fuse_bpf_ops_init(struct btf *btf)
> +{
> +       fuse_bpf_ops_btf = btf;
> +       return 0;
> +}
> +
> +static bool fuse_bpf_ops_is_valid_access(int off, int size,
> +                                         enum bpf_access_type type,
> +                                         const struct bpf_prog *prog,
> +                                         struct bpf_insn_access_aux *info)
> +{
> +       return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> +}
> +
> +static int fuse_bpf_ops_check_member(const struct btf_type *t,
> +                                     const struct btf_member *member,
> +                                     const struct bpf_prog *prog)
> +{
> +       return 0;
> +}
> +
> +static int fuse_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
> +                                          const struct bpf_reg_state *reg,
> +                                          int off, int size)
> +{
> +       return 0;
> +}
> +
> +static const struct bpf_verifier_ops fuse_bpf_verifier_ops = {
> +       .get_func_proto = bpf_base_func_proto,
> +       .is_valid_access = fuse_bpf_ops_is_valid_access,
> +       .btf_struct_access = fuse_bpf_ops_btf_struct_access,
> +};
> +
> +static int fuse_bpf_ops_init_member(const struct btf_type *t,
> +                                   const struct btf_member *member,
> +                                   void *kdata, const void *udata)
> +{
> +    const struct fuse_bpf_ops *u_ops = udata;
> +    struct fuse_bpf_ops *ops = kdata;
> +    u32 moff;
> +
> +    moff = __btf_member_bit_offset(t, member) / 8;
> +    switch (moff) {
> +    case offsetof(struct fuse_bpf_ops, name):
> +        if (bpf_obj_name_cpy(ops->name, u_ops->name,
> +                             sizeof(ops->name)) <= 0)
> +            return -EINVAL;
> +        return 1;  /* Handled */
> +    }
> +
> +    /* Not handled, use default */
> +    return 0;
> +}
> +
> +static int fuse_bpf_reg(void *kdata, struct bpf_link *link)
> +{
> +       struct fuse_bpf_ops *ops = kdata;
> +
> +       active_bpf_ops = ops;
> +
> +       printk("fuse_bpf: registered ops '%s'\n", ops->name);
> +
> +       return 0;
> +}
> +
> +static void fuse_bpf_unreg(void *kdata, struct bpf_link *link)
> +{
> +       struct fuse_bpf_ops *ops = kdata;
> +
> +       if (active_bpf_ops == ops)
> +               active_bpf_ops = NULL;
> +
> +       printk("fuse_bpf: unregistered ops '%s'\n", ops->name);
> +}
> +
> +static int __iomap_begin(struct inode *inode, loff_t pos,
> +                        loff_t length, unsigned int flags,
> +                        struct fuse_iomap_io *out_io)
> +{
> +       printk("stub __iomap_begin(). should never get called\n");
> +       return 0;
> +}
> +
> +static struct fuse_bpf_ops __fuse_bpf_ops = {
> +       .iomap_begin = __iomap_begin,
> +};
> +
> +static struct bpf_struct_ops fuse_bpf_struct_ops = {
> +       .verifier_ops = &fuse_bpf_verifier_ops,
> +       .init = fuse_bpf_ops_init,
> +       .check_member = fuse_bpf_ops_check_member,
> +       .init_member = fuse_bpf_ops_init_member,
> +       .reg = fuse_bpf_reg,
> +       .unreg = fuse_bpf_unreg,
> +       .name = "fuse_bpf_ops",
> +       .cfi_stubs = &__fuse_bpf_ops,
> +       .owner = THIS_MODULE,
> +};
> +
> +struct fuse_bpf_ops *fuse_get_bpf_ops(void)
> +{
> +       return active_bpf_ops;
> +}
> +
> +int fuse_bpf_init(void)
> +{
> +       return register_bpf_struct_ops(&fuse_bpf_struct_ops, fuse_bpf_ops);
> +}
> +
> +BTF_ID_LIST_GLOBAL_SINGLE(btf_fuse_bpf_ops_id, struct, fuse_bpf_ops)
> +BTF_ID_LIST_GLOBAL_SINGLE(btf_fuse_iomap_io_id, struct, fuse_iomap_io)
> diff --git a/fs/fuse/fuse_bpf.h b/fs/fuse/fuse_bpf.h
> new file mode 100644
> index 000000000000..d9482b64642b
> --- /dev/null
> +++ b/fs/fuse/fuse_bpf.h
> @@ -0,0 +1,29 @@
> +#ifndef _FS_FUSE_BPF_H
> +#define _FS_FUSE_BPF_H
> +
> +#include "fuse_i.h"
> +#include <linux/iomap.h>
> +
> +/* copied from darrick's iomap patchset */
> +struct fuse_iomap_io {
> +        uint64_t offset;        /* file offset of mapping, bytes */
> +        uint64_t length;        /* length of mapping, bytes */
> +        uint64_t addr;          /* disk offset of mapping, bytes */
> +        uint16_t type;          /* FUSE_IOMAP_TYPE_* */
> +        uint16_t flags;         /* FUSE_IOMAP_F_* */
> +        uint32_t dev;           /* device cookie */
> +};
> +
> +struct fuse_bpf_ops {
> +    int (*iomap_begin)(struct inode *inode, loff_t pos,
> +                      loff_t length, unsigned int flags,
> +                      struct fuse_iomap_io *out_io__nullable);
> +
> +    /* Required for bpf struct_ops */
> +    char name[16];
> +};
> +
> +struct fuse_bpf_ops *fuse_get_bpf_ops(void);
> +int fuse_bpf_init(void);
> +
> +#endif /* _FS_FUSE_BPF_H */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 819e50d66622..78ae4425e863 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -7,6 +7,7 @@
>  */
> 
>  #include "fuse_i.h"
> +#include "fuse_bpf.h"
>  #include "fuse_dev_i.h"
>  #include "dev_uring_i.h"
> 
> @@ -662,6 +663,21 @@ static int fuse_statfs(struct dentry *dentry,
> struct kstatfs *buf)
>         struct fuse_statfs_out outarg;
>         int err;
> 
> +       printk("fuse_statfs() called!\n");
> +
> +       struct fuse_bpf_ops *bpf_ops = fuse_get_bpf_ops();
> +       struct fuse_iomap_io out_io = {};
> +
> +       /* call BPF prog if attached */
> +       if (bpf_ops && bpf_ops->iomap_begin) {
> +               err = bpf_ops->iomap_begin(d_inode(dentry), 111, 222,
> +                                          333, &out_io);
> +               printk("bpf prog returned: err=%d, out_io->offset=%llu\n",
> +                      err, out_io.offset);
> +       } else {
> +               printk("did not find a bpf prog\n");
> +       }
> +
>         if (!fuse_allow_current_process(fm->fc)) {
>                 buf->f_type = FUSE_SUPER_MAGIC;
>                 return 0;
> @@ -2194,6 +2210,12 @@ static int __init fuse_fs_init(void)
>         if (!fuse_inode_cachep)
>                 goto out;
> 
> +       err = fuse_bpf_init();
> +       if (err) {
> +               printk("fuse_bpf_init() failed %d\n", err);
> +               goto out2;
> +       }
> +
>         err = register_fuseblk();
>         if (err)
>                 goto out2;
> 
> 
> These are the changes for the libfuse side:
> https://github.com/joannekoong/libfuse/commit/1a6198f17dd215c93fd82ec020641c079aae1241

/me sees "SEC("struct_ops/iomap_begin")"

ohhhh my.

Well at least now I know that C programs can do bpf stuff via libfuse.

> To run it, run "make clean; make" from libfuse/example, and then sudo
> ninja from libfuse/build, and then
>  sudo ~/libfuse/build/example/passthrough_hp ~/liburing ~/mounts/tmp2
> --nopassthrough --foreground
> 
> Then from ~/mounts/tmp2, run "stat -f filename" and that will show a few things:
> on the kernel side it'll print a statement like "bpf prog returned:
> err=0, out_io->offset=999" which shows that the prog can return back a
> "struct fuse_iomap_io" with all the requisite metadata filled out
> on the server-side, if you run " sudo cat
> /sys/kernel/debug/tracing/trace_pipe", that should print out "
> bpf_trace_printk: fuse iomap_begin: inode=ffff8a75cbe63800 pos=111
> len=222 flags=333" which shows the prog can take in whatever
> pos/len/flags values you pass it from the fuse kernel

Hehhehe.  Will give that a shot.

--D

> 
> >
> > > and I was able to verify that iomap_begin() is able to return back
> > > populated outarg fields from the bpf prog. If we were to actually
> > > implement it i'm sure it'd be more complicated (eg we'd need to make
> > > the fuse_bpf_ops registered per-connection, etc) but on the whole it
> >
> > What is a fuse_bpf_ops?  I'm assuming that's the attachment point for a
> > bpf program that the fuse server would compile?  In which case, yes, I
> > think that ought to be per-connection.
> >
> > So the bpf program can examine the struct inode, and the pos/len/opflags
> > field; and from that information it has to write the appropriate fields
> > in &outarg?  That's new, I didn't think bpf was allowed to write to
> > kernel memory.  But it's been a few years since I last touched the bpf
> > internals.
> 
> It's been a few years since I looked at bpf as well but yes
> fuse_bpf_ops is basically the kernel-side struct_ops interface for
> getting fuse to trigger the attached bpf program's callback
> implementations. When the bpf program is loaded in, its callback
> functions get swapped in and fuse_bpf_ops's function pointers now
> point to the bpf's callback functions, so when you invoke
> fuse_bpf_ops's callbacks, it calls into the bpf prog's callback.
> 
> >
> > Some bpf programs might just know how to fill out outarg on their own
> > (e.g. famfs memory interleaving) but other bpf programs might perform a
> > range query on some imaginary bpf-interval-tree wherein you can do a
> > fast lookup based on (inumber, pos, len)?
> >
> > I guess that's an interesting question -- would each fuse connection
> > have one big bpf-interval-tree?  Or would you shard things by inode to
> > reduce contention?  And if you sharded like that, then would you need a
> > fuse_bpf_ops per inode?
> 
> Hmm the cache's tree is per-inode as I understand it, so probably each
> inode would have its own tree / map?
> 
> >
> > (I'm imagining that the fuse_bpf_ops might be where you'd stash the root
> > of the bpf data structure, but I know nothing of bpf internals ;))
> >
> > Rolling on: how easy is it for a userspace program to compile and upload
> > bpf programs into the kernel?  I've played around with bcc enough to
> > write some fairly stupid latency tracing tools for XFS, but at the end
> > of the day it still python scripts feeding a string full of maybe-C into
> > whatever the BPF does under the hood.
> 
> I found it pretty easy with the libbpf library which will generate the
> skeletons and provide the api helpers to load it in and other stuff
> (the libfuse link I pasted above for the userspace side has the code
> for compiling it and loading it).
> 
> >
> > I /think/ it calls clang on the provided text, links that against the
> > current kernel's header files, and pushes the compiled bpf binary into
> > the kernel, right?  So fuse4fs would have to learn how to do that; and
> > now fuse4fs has a runtime dependency on libllvm.
> 
> I think the libbpf library takes care of a lot of that for you. I
> think fuse4fs would just need to do the same thing as in that libfuse
> link above
> 
> >
> > And while I'm on the topic of fuse-bpf uapi: It's ok for us to expose
> > primitive-typed variables (pos/len/opflags) and existing fuse uapi
> > directly to a bpf program, but I don't think we should expose struct
> > inode/fuse_inode.  Maybe just fuse_inode::nodeid?  If we're careful not
> > to allow #include'ing structured types in the fuse bpf code, then
> > perhaps the bpf programs could be compiled at the same time as the fuse
> > server.
> 
> I agree, I think if we do decide to go further with this approach,
> we'll need to define exactly what the interfaces should be that would
> be safe to expose.
> 
> >
> > > seems doable. My worry is that if we land the iomap cache patchset now
> > > then we can't remove it in the future without breaking backwards
> > > compatibility for being a performance regression (though maybe we can
> > > since the fuse-iomap stuff is experimental?), so imo it'd be great if
> >
> > I don't think it's a huge problem to remove functionality while the
> > EXPERIMENTAL warnings are in place.  We'd forever lose the command codes
> > for FUSE_NOTIFY_IOMAP_UPSERT and FUSE_NOTIFY_IOMAP_INVAL, but we've only
> > used 12 out of INT_MAX so that's not likely to be a concern.
> >
> > > we figured out what direction we want to go before landing the cache
> > > stuff. And I think we need to have this conversation too on the main
> > > famfs patchset (eg whether it should go through your general iomap
> > > plumbing with bpf helpers vs. being a separate implementation) since
> > > once that lands, it'd be irrevocable.
> >
> > I've of two minds on that -- John got here first, so I don't want to
> > delay his patchset whilst I slowly work on this thing.  OTOH from an
> > architecture standpoint we probably ought to push for three ways for a
> > fuse server to upload mappings:
> 
> I think if John/Miklos wanted to go in this direction, all that would
> be needed from your series is the first one or two patches that define
> the basic fuse_iomap_io / fuse_iomap_begin / fuse_iomap_end structs
> and init config plumbing.
> 
> Thanks,
> Joanne
> 
> >
> > 1. Upserting mappings with arbitrary offset and size into a cache
> > 2. Self contained bpf program that can generate any mapping
> > 3. Sprawling bpf program that can read any other artifacts that another
> >    bpf program might have set up for it
> >
> > But yeah, let's involve John.
> >
> > --D
> >
> > >
> > > Thanks,
> > > Joanne
> > > >
> > > > --D
> > > >
> > > > > Thanks,
> > > > > Joanne
> > > > >
> > > > > >
> > > > > > <nod>
> > > > > >
> > > > > > --D
> > > > > >
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Joanne
> > > > > > >
> > > > > > > >
> > > > > > > > OTOH it would be enormously hilarious to me if one could load a file
> > > > > > > > mapping predictive model into the kernel as a bpf program and use that
> > > > > > > > as a first tier before checking the in-memory btree mapping cache from
> > > > > > > > patchset 7.  Quite a few years ago now there was a FAST paper
> > > > > > > > establishing that even a stupid linear regression model could in theory
> > > > > > > > beat a disk btree lookup.
> > > > > > > >
> > > > > > > > --D
> > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Joanne
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > If you're going to start using this code, I strongly recommend pulling
> > > > > > > > > > from my git trees, which are linked below.
> > > > > > > > > >
> > > > > > > > > > This has been running on the djcloud for months with no problems.  Enjoy!
> > > > > > > > > > Comments and questions are, as always, welcome.
> > > > > > > > > >
> > > > > > > > > > --D
> > > > > > > > > >
> > > > > > > > > > kernel git tree:
> > > > > > > > > > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-fileio
> > > > > > > > > > ---
> > > > > > > > > > Commits in this patchset:
> > > > > > > > > >  * fuse: implement the basic iomap mechanisms
> > > > > > > > > >  * fuse_trace: implement the basic iomap mechanisms
> > > > > > > > > >  * fuse: make debugging configurable at runtime
> > > > > > > > > >  * fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap devices
> > > > > > > > > >  * fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap devices
> > > > > > > > > >  * fuse: flush events and send FUSE_SYNCFS and FUSE_DESTROY on unmount
> > > > > > > > > >  * fuse: create a per-inode flag for toggling iomap
> > > > > > > > > >  * fuse_trace: create a per-inode flag for toggling iomap
> > > > > > > > > >  * fuse: isolate the other regular file IO paths from iomap
> > > > > > > > > >  * fuse: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HOLE}
> > > > > > > > > >  * fuse_trace: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HOLE}
> > > > > > > > > >  * fuse: implement direct IO with iomap
> > > > > > > > > >  * fuse_trace: implement direct IO with iomap
> > > > > > > > > >  * fuse: implement buffered IO with iomap
> > > > > > > > > >  * fuse_trace: implement buffered IO with iomap
> > > > > > > > > >  * fuse: implement large folios for iomap pagecache files
> > > > > > > > > >  * fuse: use an unrestricted backing device with iomap pagecache io
> > > > > > > > > >  * fuse: advertise support for iomap
> > > > > > > > > >  * fuse: query filesystem geometry when using iomap
> > > > > > > > > >  * fuse_trace: query filesystem geometry when using iomap
> > > > > > > > > >  * fuse: implement fadvise for iomap files
> > > > > > > > > >  * fuse: invalidate ranges of block devices being used for iomap
> > > > > > > > > >  * fuse_trace: invalidate ranges of block devices being used for iomap
> > > > > > > > > >  * fuse: implement inline data file IO via iomap
> > > > > > > > > >  * fuse_trace: implement inline data file IO via iomap
> > > > > > > > > >  * fuse: allow more statx fields
> > > > > > > > > >  * fuse: support atomic writes with iomap
> > > > > > > > > >  * fuse_trace: support atomic writes with iomap
> > > > > > > > > >  * fuse: disable direct reclaim for any fuse server that uses iomap
> > > > > > > > > >  * fuse: enable swapfile activation on iomap
> > > > > > > > > >  * fuse: implement freeze and shutdowns for iomap filesystems
> > > > > > > > > > ---
> > > > > > > > > >  fs/fuse/fuse_i.h          |  161 +++
> > > > > > > > > >  fs/fuse/fuse_trace.h      |  939 +++++++++++++++++++
> > > > > > > > > >  fs/fuse/iomap_i.h         |   52 +
> > > > > > > > > >  include/uapi/linux/fuse.h |  219 ++++
> > > > > > > > > >  fs/fuse/Kconfig           |   48 +
> > > > > > > > > >  fs/fuse/Makefile          |    1
> > > > > > > > > >  fs/fuse/backing.c         |   12
> > > > > > > > > >  fs/fuse/dev.c             |   30 +
> > > > > > > > > >  fs/fuse/dir.c             |  120 ++
> > > > > > > > > >  fs/fuse/file.c            |  133 ++-
> > > > > > > > > >  fs/fuse/file_iomap.c      | 2230 +++++++++++++++++++++++++++++++++++++++++++++
> > > > > > > > > >  fs/fuse/inode.c           |  162 +++
> > > > > > > > > >  fs/fuse/iomode.c          |    2
> > > > > > > > > >  fs/fuse/trace.c           |    2
> > > > > > > > > >  14 files changed, 4056 insertions(+), 55 deletions(-)
> > > > > > > > > >  create mode 100644 fs/fuse/iomap_i.h
> > > > > > > > > >  create mode 100644 fs/fuse/file_iomap.c
> > > > > > > > > >
> > > > > > > > >
> > > > >
> > >
> 

