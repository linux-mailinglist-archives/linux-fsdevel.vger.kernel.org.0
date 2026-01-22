Return-Path: <linux-fsdevel+bounces-74947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJchLIZwcWkPHAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:34:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1005FF69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3E963C1281
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9C42EB845;
	Thu, 22 Jan 2026 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOOhfIks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454392C15B0;
	Thu, 22 Jan 2026 00:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769042043; cv=none; b=texlLLMpYtnlZbfVBwTzPe/B44qOYTDyKGsowps6SnfFLSmzsP8wQyLsXYJka6oqEy6gSGVBXEANlDRQly1fpKs4QBH6k06/bbrghoLZjj4gqKWuIoHlCFZpDW/vAecKiBs3fNt8mGIi9xdj+uaxgoJVp3QfEzr7IUaAt05cVDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769042043; c=relaxed/simple;
	bh=AlLCBGz2KqUgBnl7BN91Zv6t3s74fGBh6hZLIjX85wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Anm4PZPKE/8rXDGxDQJCYWBcaKVQegf0q0ru1cLeDoAh3y9NSNbbrt1c9oL5sTFxanZOohG8E4u5lloffOSVFTkXarDleinF7oPpH0Wy3qdvvQhUNO3lV9GFS6cQWp6u3sOpshe61Lm+MZlnuZ9lWregPzb95N4JOPjliyByzUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOOhfIks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA0FC4CEF1;
	Thu, 22 Jan 2026 00:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769042041;
	bh=AlLCBGz2KqUgBnl7BN91Zv6t3s74fGBh6hZLIjX85wU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cOOhfIksvXcI1NL2PbQPDo0oKGzSoc7+WXXpXdyPvRUSY9X2/zS3nguSFuP8vfDLM
	 xkddeXzQjl0szF2WYuOS2u1QWEzqdTj2T7dOPYKXKoy13jQ0E+jl6GsI1MrdCbc/5h
	 nd9VlCgeiQ3Xmpds+sKZJxcv6amCZkH3FG7PEIyAebTBZuHi6kCvWkicO2eDbFcOL0
	 qbfox6z2gtDYzFBb+oBsp/MMZh/5Mb3EUX9bmmqVVdhAKIj8ekxnMwt2Bp1/bg2KqW
	 OgutgLTBhc3CN83szI2aoEXPIskgnAUP9PCL7Y7beFvJT0jmcosUt1TKUiL21uMPdZ
	 cWEcjZZudVoYA==
Date: Wed, 21 Jan 2026 16:34:01 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/31] fuse: implement the basic iomap mechanisms
Message-ID: <20260122003401.GL5966@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810371.1424854.3010195280915622081.stgit@frogsfrogsfrogs>
 <CAJnrk1ZOLNytBdVqvWiHbwA0rE0KCVt09SmHFZ3pp_tffg+iaQ@mail.gmail.com>
 <20260121224513.GJ5966@frogsfrogsfrogs>
 <CAJnrk1aa7eyFLm30wiR9fVuwW6RKKniuFmFUSHhs7NVXKJVKtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aa7eyFLm30wiR9fVuwW6RKKniuFmFUSHhs7NVXKJVKtQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74947-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 5E1005FF69
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 04:06:39PM -0800, Joanne Koong wrote:
> On Wed, Jan 21, 2026 at 2:45 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Jan 21, 2026 at 11:34:24AM -0800, Joanne Koong wrote:
> > > On Tue, Oct 28, 2025 at 5:45 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > >
> > > > Implement functions to enable upcalling of iomap_begin and iomap_end to
> > > > userspace fuse servers.
> > > >
> > > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > ---
> > > >  fs/fuse/fuse_i.h          |   22 ++
> > > >  fs/fuse/iomap_i.h         |   36 ++++
> > > >  include/uapi/linux/fuse.h |   90 +++++++++
> > > >  fs/fuse/Kconfig           |   32 +++
> > > >  fs/fuse/Makefile          |    1
> > > >  fs/fuse/file_iomap.c      |  434 +++++++++++++++++++++++++++++++++++++++++++++
> > > >  fs/fuse/inode.c           |    8 +
> > > >  7 files changed, 621 insertions(+), 2 deletions(-)
> > > >  create mode 100644 fs/fuse/iomap_i.h
> > > >  create mode 100644 fs/fuse/file_iomap.c
> > > >
> > > >
> > > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > > index 7c7d255d817f1e..45be59df7ae592 100644
> > > > --- a/fs/fuse/fuse_i.h
> > > > +++ b/fs/fuse/fuse_i.h
> > > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > > index 18713cfaf09171..7d709cf12b41a7 100644
> > > > --- a/include/uapi/linux/fuse.h
> > > > +++ b/include/uapi/linux/fuse.h
> > > > @@ -240,6 +240,9 @@
> > > >   *  - add FUSE_COPY_FILE_RANGE_64
> > > >   *  - add struct fuse_copy_file_range_out
> > > >   *  - add FUSE_NOTIFY_PRUNE
> > > > + *
> > > > + *  7.99
> > >
> > > Should this be changed to something like 7.46 now that this patch is
> > > submitted for merging into the tree?
> >
> > When review of this patchset nears completion I'll change the 99s to
> > 46 or whatever the fuse/libfuse minor version happens to be at that
> > point.
> 
> Sounds good.

I'll add another XXX comment here to increase the likelihood it doesn't
get missed.

> >
> > Nobody's touched this series since 29 October (during 6.19 development)
> > and I've been busy with xfs_healer so I'm not submitting this for 7.0
> > either.
> >
> > > > + *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
> > > >   */
> > > >
> > > > +/* fuse-specific mapping type indicating that writes use the read mapping */
> > > > +#define FUSE_IOMAP_TYPE_PURE_OVERWRITE (255)
> > > > +
> > > > +#define FUSE_IOMAP_DEV_NULL            (0U)    /* null device cookie */
> > > > +
> > > > +/* mapping flags passed back from iomap_begin; see corresponding IOMAP_F_ */
> > > > +#define FUSE_IOMAP_F_NEW               (1U << 0)
> > > > +#define FUSE_IOMAP_F_DIRTY             (1U << 1)
> > > > +#define FUSE_IOMAP_F_SHARED            (1U << 2)
> > > > +#define FUSE_IOMAP_F_MERGED            (1U << 3)
> > > > +#define FUSE_IOMAP_F_BOUNDARY          (1U << 4)
> > > > +#define FUSE_IOMAP_F_ANON_WRITE                (1U << 5)
> > > > +#define FUSE_IOMAP_F_ATOMIC_BIO                (1U << 6)
> > >
> > > Do you think it makes sense to have the fuse iomap constants mirror
> > > the in-kernel iomap ones? Maybe I'm mistaken but it seems like the
> > > fuse iomap capabilities won't diverge too much from fs/iomap ones? I
> > > like that if they're mirrored, then it makes it simpler instead of
> > > needing to convert back and forth.
> >
> > "Mirrored"?  As in, having the define use a symbol:
> >
> > #define FUSE_IOMAP_F_NEW                IOMAP_F_NEW
> >
> > instead of defining it to be a specific numerical constant like it is
> > here?
> 
> I was thinking keeping it like it is with defining it to a specific
> numerical constant, but having the number correspond to the number
> iomap.h uses and having static asserts to ensure they match, and then
> being able to just pass struct fuse_iomap_io's flags directly to
> iomap->flags and vice versa. But I guess the iomap constants could
> change at any time since it's not a uapi.

Yep.  iomap's api stability is only guaranteed until the mtime changes
on include/linux/iomap.h.

I actually /did/ do the static assert thing earlier in the lifetime of
this patchset, but then I godbolted what the conversion functions were
actually doing and observed that gcc and clang are smart enough to
collapse all the C code into the appropriate masking if you compile with
-O2.

<snip>

> > > > +struct fuse_iomap_io {
> > > > +       uint64_t offset;        /* file offset of mapping, bytes */
> > > > +       uint64_t length;        /* length of mapping, bytes */
> > > > +       uint64_t addr;          /* disk offset of mapping, bytes */
> > > > +       uint16_t type;          /* FUSE_IOMAP_TYPE_* */
> > > > +       uint16_t flags;         /* FUSE_IOMAP_F_* */
> > > > +       uint32_t dev;           /* device cookie */
> > >
> > > Do you think it's a good idea to add a reserved field here in case we
> > > end up needing it in the future?
> >
> > I'm open to the idea of pre-padding the structs, though that's extra
> > copy overhead until they get used for something.
> 
> Bernd would know better than me on this, but iirc, fuse generally
> tries to prepad structs to avoid having to deal with backwards
> compatibility issues if future fields get added.

<nod> for xfs I've generally added one u64 unless two would round us up
to a cacheline... or just defined the struct size to be something insane
like 512 bytes.

> >
> > Does that fuse-iouring-zerocopy patchset that you're working on enable
> > the kernel to avoid copying fuse command data around?  I haven't read it
> > in sufficient (or any) detail to know the answer to that question.
> 
> No, only the payload bypasses the copy. All the header stuff would
> have to get copied out to the ring.

D'oh! :/

> >
> > Second: how easy is it to send a variable sized fuse command to
> > userspace?  It looks like some commands like FUSE_WRITE do things like:
> >
> >         if (ff->fm->fc->minor < 9)
> >                 args->in_args[0].size = FUSE_COMPAT_WRITE_IN_SIZE;
> >         else
> >                 args->in_args[0].size = sizeof(ia->write.in);
> >         args->in_args[0].value = &ia->write.in;
> >         args->in_args[1].size = count;
> >
> > Which means that future expansion can (in theory) bump the minor version
> > and send larer commands.
> >
> > It also looks like the kernel can support receiving variable-sized
> > responses, like FUSE_READ does:
> >
> >         args->out_argvar = true;
> >         args->out_numargs = 1;
> >         args->out_args[0].size = count;
> >
> > I think this means that if we ever needed to expand the _out struct to
> > allow the fuse server to send back a more lengthy response, we could
> > potentially do that without needing a minor protocol version bump.
> 
> I'm not sure, Bernd or Miklos would know more, but my general
> impression has been that we try to avoid doing the FUSE_COMPAT_ stuff
> if we can.

<nod> revving the minor protocol version will take time to propagate.

<snip>

> > > > +};
> > > > +
> > > > +struct fuse_iomap_end_in {
> > > > +       uint32_t opflags;       /* FUSE_IOMAP_OP_* */
> > > > +       uint32_t reserved;      /* zero */
> > > > +       uint64_t attr_ino;      /* matches fuse_attr:ino */
> > > > +       uint64_t pos;           /* file position, in bytes */
> > > > +       uint64_t count;         /* operation length, in bytes */
> > > > +       int64_t written;        /* bytes processed */
> > >
> > > On the fs/iomap side, I see that written is passed through by
> > > iomap_iter() to ->iomap_end through 'ssize_t advanced' but it's not
> > > clear to me why advanced needs to be signed. I think it used to also
> > > represent the error status, but it looks like now that's represented
> > > through iter->status and 'advanced' strictly reflects the number of
> > > bytes written. As such, do you think it makes sense to change
> > > 'advanced' to loff_t and have written be uint64_t instead?
> >
> > Not quite -- back in the bad old days, iomap_iter::processed was a s64
> > value that the iteration loop had to set to one of:
> >
> >  * a positive number for positive progress
> >  * zero to stop the iteration
> >  * a negative errno to fail out
> >
> > Nowadays we just move iomap_iter::pos forward via iomap_iter_advance or
> > set status to a negative number to end the iteration.

Slight inaccuracy: one sets iter->status to a negative number to fail
out of the iteration.  To end early, they should call iomap_iter without
calling iomap_iter_advance.

> > So yes, I think @advanced should be widened to 64-bits since iomap
> > operations can jump more than 2GB per iter step.  Practically speaking I
> > think this hasn't yet been a problem because the only operations that
> > can do that (fiemap, seek, swap) also don't have any client filesystems
> > that implement iomap_end; or they do but never send mappings large
> > enough to cause problems.
> >
> > iomap iters can't go backwards so @advanced could be u64 as well.
> >
> > Also the name of the ->iomap_end parameter could be changed to
> > "advanced" because iomap_end could in theory be called for any
> > operation, not just writes.  That's a throwback to the days when the
> > iomap code was just part of xfs.  It also is an unsigned quantity.
> 
> That makes sense, thanks for the context.

<nod>

<snip>

> > > > +/* Convert a mapping from the server into something the kernel can use */
> > > > +static inline void fuse_iomap_from_server(struct inode *inode,
> > >
> > > Maybe worth adding a const in front of struct inode?
> >
> > It can go away in a patch or two when we wire up bdev support.
> >
> > Though considering that fuse_iomap_enabled returns false all the way to
> > the end of the patchset I guess I could just set bdev to null and skip
> > passing in the inode at all.

Done.

> > > > +                                         struct iomap *iomap,
> > > > +                                         const struct fuse_iomap_io *fmap)
> > > > +{
> > > > +       iomap->addr = fmap->addr;
> > > > +       iomap->offset = fmap->offset;
> > > > +       iomap->length = fmap->length;
> > > > +       iomap->type = fuse_iomap_type_from_server(fmap->type);
> > > > +       iomap->flags = fuse_iomap_flags_from_server(fmap->flags);
> > > > +       iomap->bdev = inode->i_sb->s_bdev; /* XXX */
> > > > +}
> > > > +
> > > > +/* Convert a mapping from the kernel into something the server can use */
> > > > +static inline void fuse_iomap_to_server(struct fuse_iomap_io *fmap,
> > > > +                                       const struct iomap *iomap)
> > > > +{
> > > > +       fmap->addr = FUSE_IOMAP_NULL_ADDR; /* XXX */
> > > > +       fmap->offset = iomap->offset;
> > > > +       fmap->length = iomap->length;
> > > > +       fmap->type = fuse_iomap_type_to_server(iomap->type);
> > > > +       fmap->flags = fuse_iomap_flags_to_server(iomap->flags);
> > > > +       fmap->dev = FUSE_IOMAP_DEV_NULL; /* XXX */
> > >
> > > AFAICT, this only gets used for sending the FUSE_IOMAP_END request. Is
> > > passing the iomap->addr to fmap->addr and inode->i_sb->s_bdev to
> > > fmap->dev not useful to the server here?
> >
> > So far the only fields I've needed in fuse4fs are the
> > offset/count/written fields as provided by iomap_iter, and the flags
> > field from the mapping.  The addr field isn't necessary for fuse4fs
> > because the fuse server would know if the mapping had changed.  OTOH
> > it's probably harmless to send it along.
> >
> > Hrm.  I probably need a way to look up the backing_id from the iomap
> > bdev.
> >
> > Looking further ahead at the ioend patch, I just realized that iomap
> > ioends can tell you the new address of a write-append operation but they
> > don't tell you which device.  I guess you can read that from the
> > ioend->io_bio.bi_bdev.
> >
> > > Also, did you mean to leave in the /* XXX */ comments?
> >
> > Yes, because they're a reminder to come back and check if I /ever/
> > needed them.
> 
> Makes sense, seems like you're planning to remove them when the patch
> is ready to merge, if I understand correctly.

Yeah.  I also fixed this fuse_iomap_to_server to set fmap->dev.

<snip>

> > > > +static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
> > > > +                         ssize_t written, unsigned opflags,
> > > > +                         struct iomap *iomap)
> > > > +{
> > > > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > > > +       struct fuse_mount *fm = get_fuse_mount(inode);
> > > > +       int err = 0;
> > > > +
> > > > +       if (fuse_should_send_iomap_end(iomap, opflags, count, written)) {
> > > > +               struct fuse_iomap_end_in inarg = {
> > > > +                       .opflags = fuse_iomap_op_to_server(opflags),
> > > > +                       .attr_ino = fi->orig_ino,
> > > > +                       .pos = pos,
> > > > +                       .count = count,
> > > > +                       .written = written,
> > > > +               };
> > > > +               FUSE_ARGS(args);
> > > > +
> > > > +               fuse_iomap_to_server(&inarg.map, iomap);
> > > > +
> > > > +               args.opcode = FUSE_IOMAP_END;
> > > > +               args.nodeid = get_node_id(inode);
> > >
> > > Just curious about this - does it make sense to set args.force here
> > > for this opcode? It seems like it serves the same sort of purpose a
> > > flush request (which sets args.force) does?
> >
> > What does args.force do?  There's no documentation of what behaviors
> > these fields are supposed to trigger.
> 
> The args.force forces the request to be sent even if it gets
> interrupted by a signal. It'll also bypass the fuse_block_alloc()
> check when sending the request, but I don't think that's too relevant
> to this case.

Hrm.  For iomap_begin I think it's ok if a signal kills the IO
operation.  For iomap_end ... I guess we really should force the command
out to the server in case it needs to clean up, even if the user is
hammering on kill -9.

For iomap_ioend the same probably applies, but it's called from
workqueue context so there's not going to be a fatal signal.  But maybe
we should do that, just in case someone develops motivation to make
directio completions run in the caller's context or something.

--D

