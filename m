Return-Path: <linux-fsdevel+bounces-75551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOveJNf8d2kvnAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 00:46:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 318758E4C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 00:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 380E6301C16E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 23:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D713101D8;
	Mon, 26 Jan 2026 23:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QA4+2TgH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABC9221DAE;
	Mon, 26 Jan 2026 23:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769471177; cv=none; b=Fuh9MjI7P3OmzHNpV7v8oWPRvWxm0EpxNTUHgEpc1KcIAjxnhlXpkebODdT5qkxxsLd0007vYd1FGDO4gBQGwm02It2B9nF6tjrV6PIjspHE/dk5e+4UHmkZg7zujBeekGWYQut6TV98gUELc8fk1DQgtt4KXkxhfKD8qhJ5h/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769471177; c=relaxed/simple;
	bh=GsXQnRcqXHrJNv5TewQnYQk4Uuqp4ZogAohjWMuooRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FweTOQTbRTl474lhhdzFk1xDhLrUkY/iHA0ZpTOFxXsEOIUHe54eMYMgBrZfO1BtzmVEbRtHuUeE9mbzXPrdwf6sOUFAODwrrtv6vZ7+5sNBwAk+WtctT8yjC81VOV15w1CbTqPMrYz0HIcWuJ3EXfu2w5uRagjr/iH/kNu5Vt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QA4+2TgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A04C116C6;
	Mon, 26 Jan 2026 23:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769471177;
	bh=GsXQnRcqXHrJNv5TewQnYQk4Uuqp4ZogAohjWMuooRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QA4+2TgH0hxz+ivo6zWCq27agjp6S7/p7gQ6Cp8ZKtHEV/av51sURKSop0tONnb+9
	 EVMVaS6QOyjYOpm0NwUsKWG4ioHVWoLOPIA25KYtNhBK9ghgrbpssxUWfAjLQ2tiHI
	 bmIV2/bYO4bhwNJRe3clP++ddZl/gA+yLcoESmq54wERwfLCBu443jzJQv8wT38e+n
	 q+u0a+dR08NPsKoS8If0w6ZWV3THKoXTkQ9K4Y8vZ6GAn+I36yGO5jVxED7y+NwLqZ
	 0O0DUjKDty8D6Nro4yMz84M5Ng9J6ywTCPS5sg7+w5zil6CfE30NER8G8wyHnkNR14
	 8Y2O0PljB3K1Q==
Date: Mon, 26 Jan 2026 15:46:16 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/31] fuse: implement direct IO with iomap
Message-ID: <20260126234616.GD5900@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810612.1424854.16053093294573829123.stgit@frogsfrogsfrogs>
 <CAJnrk1Yo82LgK2_NSswSiY+YxoxKh71GDTeQSVs1Tf5sgLHEMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Yo82LgK2_NSswSiY+YxoxKh71GDTeQSVs1Tf5sgLHEMA@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-75551-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 318758E4C6
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 10:56:14AM -0800, Joanne Koong wrote:
> On Tue, Oct 28, 2025 at 5:48 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Start implementing the fuse-iomap file I/O paths by adding direct I/O
> > support and all the signalling flags that come with it.  Buffered I/O
> > is much more complicated, so we leave that to a subsequent patch.
> 
> Overall, this makes sense to me. Left a few comments below.

<nod>

> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/fuse_i.h          |   30 +++++
> >  include/uapi/linux/fuse.h |   22 ++++
> >  fs/fuse/dir.c             |    7 +
> >  fs/fuse/file.c            |   16 +++
> >  fs/fuse/file_iomap.c      |  249 +++++++++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/trace.c           |    1
> >  6 files changed, 323 insertions(+), 2 deletions(-)
> >
> >
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index e949bfe022c3b0..be0e95924a24af 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -672,6 +672,7 @@ enum fuse_opcode {
> >         FUSE_STATX              = 52,
> >         FUSE_COPY_FILE_RANGE_64 = 53,
> >
> > +       FUSE_IOMAP_IOEND        = 4093,
> >         FUSE_IOMAP_BEGIN        = 4094,
> >         FUSE_IOMAP_END          = 4095,
> >
> > @@ -1406,4 +1407,25 @@ struct fuse_iomap_end_in {
> >         struct fuse_iomap_io    map;
> >  };
> >
> > +/* out of place write extent */
> > +#define FUSE_IOMAP_IOEND_SHARED                (1U << 0)
> > +/* unwritten extent */
> > +#define FUSE_IOMAP_IOEND_UNWRITTEN     (1U << 1)
> > +/* don't merge into previous ioend */
> > +#define FUSE_IOMAP_IOEND_BOUNDARY      (1U << 2)
> > +/* is direct I/O */
> > +#define FUSE_IOMAP_IOEND_DIRECT                (1U << 3)
> > +/* is append ioend */
> > +#define FUSE_IOMAP_IOEND_APPEND                (1U << 4)
> > +
> > +struct fuse_iomap_ioend_in {
> > +       uint32_t ioendflags;    /* FUSE_IOMAP_IOEND_* */
> 
> Hmm, maybe just "flags" is descriptive enough? Or if not, then "ioend_flags"?

flags is fine, will change.

> > +       int32_t error;          /* negative errno or 0 */
> > +       uint64_t attr_ino;      /* matches fuse_attr:ino */
> > +       uint64_t pos;           /* file position, in bytes */
> > +       uint64_t new_addr;      /* disk offset of new mapping, in bytes */
> > +       uint32_t written;       /* bytes processed */
> 
> Is uint32_t enough here or does it need to be bigger? Asking mostly
> because I see in fuse_iomap_ioend() that the written passed in is
> size_t.

Hrmm.  A directio write cannot exceed MAX_RW_COUNT, which is slightly
less than 2GB.  On the other hand, the iomap ioend allows us to chain
together up to (IOEND_BATCH_SIZE * folio_size) bytes of writeback
completions.  Even on x86 that could be 8GB, so you're right, this ought
to be a u64.

> > +       uint32_t reserved1;     /* zero */
> > +};
> > +
> >  #endif /* _LINUX_FUSE_H */
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index bafc386f2f4d3a..171f38ba734d16 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -712,6 +712,10 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
> >         if (err)
> >                 goto out_acl_release;
> >         fuse_dir_changed(dir);
> > +
> > +       if (fuse_inode_has_iomap(inode))
> > +               fuse_iomap_open(inode, file);
> > +
> >         err = generic_file_open(inode, file);
> >         if (!err) {
> >                 file->private_data = ff;
> > @@ -1743,6 +1747,9 @@ static int fuse_dir_open(struct inode *inode, struct file *file)
> >         if (fuse_is_bad(inode))
> >                 return -EIO;
> >
> > +       if (fuse_inode_has_iomap(inode))
> > +               fuse_iomap_open(inode, file);
> > +
> >         err = generic_file_open(inode, file);
> >         if (err)
> >                 return err;
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 8a981f41b1dbd0..43007cea550ae7 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -246,6 +246,9 @@ static int fuse_open(struct inode *inode, struct file *file)
> >         if (fuse_is_bad(inode))
> >                 return -EIO;
> >
> > +       if (is_iomap)
> > +               fuse_iomap_open(inode, file);
> > +
> 
> AFAICT, there aren't any calls to generic_file_open() where we don't
> also do this "if (is_iomap) ..." check, so maybe we should just put
> this logic inside generic_file_open()?

I'm confused by your question; there are many users of
generic_file_open...?

$ git grep generic_file_open
fs/9p/vfs_inode.c:800:  err = finish_open(file, dentry, generic_file_open);
fs/9p/vfs_inode_dotl.c:317:     err = finish_open(file, dentry, generic_file_open);
fs/btrfs/file.c:3821:   return generic_file_open(inode, filp);
fs/fuse/dir.c:916:      err = generic_file_open(inode, file);
fs/fuse/dir.c:2007:     err = generic_file_open(inode, file);
fs/fuse/file.c:270:     err = generic_file_open(inode, file);
fs/gfs2/file.c:632:             ret = generic_file_open(inode, file);
fs/jffs2/file.c:55:     .open =         generic_file_open,
fs/nilfs2/file.c:148:   .open           = generic_file_open,
fs/ntfs3/file.c:1364:   return generic_file_open(inode, file);
fs/open.c:1607:int generic_file_open(struct inode * inode, struct file * filp)
fs/open.c:1614:EXPORT_SYMBOL(generic_file_open);
fs/orangefs/file.c:580: .open           = generic_file_open,
fs/quota/dquot.c:2219:  error = generic_file_open(inode, file);
fs/smb/client/dir.c:532:        rc = finish_open(file, direntry, generic_file_open);
fs/udf/file.c:203:      .open                   = generic_file_open,
fs/ufs/file.c:42:       .open           = generic_file_open,
fs/vboxsf/dir.c:341:    err = finish_open(file, dentry, generic_file_open);
fs/xfs/xfs_file.c:1612: return generic_file_open(inode, file);
fs/xfs/xfs_file.c:1626: error = generic_file_open(inode, file);
...

> >         err = generic_file_open(inode, file);
> >         if (err)
> >                 return err;
> > @@ -1751,10 +1754,17 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >         struct file *file = iocb->ki_filp;
> >         struct fuse_file *ff = file->private_data;
> >         struct inode *inode = file_inode(file);
> > +       ssize_t ret;
> >
> >         if (fuse_is_bad(inode))
> >                 return -EIO;
> >
> > +       if (fuse_want_iomap_directio(iocb)) {
> 
> In fuse, directio is also done if the server sets FOPEN_DIRECT_IO as
> part of the struct fuse_open_out open_flags arg, even if
> iocb->ki_flags  doesn't have IOCB_DIRECT set.

Yikes.  Let me look at the other fuse FOPEN_ flags:

 * FOPEN_DIRECT_IO: bypass page cache for this open file

Hrm.  This wouldn't be hard to implement, but what happens if the read
or write range aren't aligned to the block size?  Is it ok to return
EINVAL here?

 * FOPEN_KEEP_CACHE: don't invalidate the data cache on open

fuse_open takes care of this too.  Evidently I need to fix fuse4fs to
set this flag.

 * FOPEN_NONSEEKABLE: the file is not seekable
 * FOPEN_STREAM: the file is stream-like (no file position at all)

Not sure why you'd have a non-seekable regular iomap file but I think
fuse_finish_open takes care of this.

 * FOPEN_CACHE_DIR: allow caching this directory

Oh wow building up a dirent cache when someone does a readdir.  fuse4fs
should set this too.

 * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)

Hrm.  In theory fuse4fs could set this one too, but I think given the
higher chance of failure (or the usb stick being yanked out) I might not
set this one.

 * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode

iomap supports this, but fuse-iomap does not.  Are we supposed to return
EOPNOTSUPP/EINVAL or can we quietly ignore this flag until we support
it?

 * FOPEN_PASSTHROUGH: passthrough read/write io for this open file

I need to screen this out too.

> > +               ret = fuse_iomap_direct_read(iocb, to);
> > +               if (ret != -ENOSYS)
> 
> Hmm, where does fuse_iomap_direct_read() return -ENOSYS? afaict,
> neither fuse_iomap_ilock_iocb() nor iomap_dio_rw() do?

I /think/ the fuse server can reply with ENOSYS to fuse_iomap_begin(),
in which case it'll percolate upwards to iomap_iter into dio->error
where it can then be returned through iomap_dio_complete into
iomap_dio_rw into fuse_iomap_direct_read.

That will demote a directio...

> > +                       return ret;
> > +       }
> 
> I see that later on, in the patch that adds the implementation for
> buffered IO with iomap, this logic later becomes something like
> 
>         if (fuse_want_iomap_directio(iocb)) {
>                 ...
>         }

>         if (fuse_want_iomap_buffered_io(iocb))
>                 return fuse_iomap_buffered_read(iocb, to);

...into a buffered io.  Maybe I should special-case ENOTBLK since that's
what the other iomap users do.

Originally directio on XFS would never fall back to buffered io.  Then
we introduced out of place writes for reflink, which forced us to
implement the fallback for sub-allocation-unit directio writes that were
aligned to LBA size (since XFS has always allowed that).

Later on ext4 (which always allowed fallbacks) entered the chat and now
we're stuck with it. :)

> imo (if -ENOSYS is indeed not possible) something like this is maybe cleaner:
> 
>         if (fuse_inode_has_iomap(inode))
>                  fuse_iomap_read_iter(iocb, to);
> 
> to move as much iomap-specific logic away from generic fuse files?

That would be cleaner.  It might even be cleaner to give iomap files
their own file_operations structure completely.

> fuse_want_iomap_directio()/fuse_want_iomap_buffered_io() helpers, eg:
> 
> ssize_t fuse_iomap_read_iter(struct kiocb *iocb, struct iov_iter *to) {
>          if (iocb->ki_flags & IOCB_DIRECT)
>                   return fuse_iomap_direct_read(iocb, to);
>          return fuse_iomap_buffered_read(iocb, to);
> }
> 
> > +
> >         if (FUSE_IS_DAX(inode))
> >                 return fuse_dax_read_iter(iocb, to);
> >
> > @@ -1776,6 +1786,12 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >         if (fuse_is_bad(inode))
> >                 return -EIO;
> >
> > +       if (fuse_want_iomap_directio(iocb)) {
> > +               ssize_t ret = fuse_iomap_direct_write(iocb, from);
> > +               if (ret != -ENOSYS)
> > +                       return ret;
> > +       }
> 
> Same questions as above about -ENOSYS

Same weird answer, too. :P

> > +
> >         if (FUSE_IS_DAX(inode))
> >                 return fuse_dax_write_iter(iocb, from);
> >
> > diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> > index c63527cec0448b..4db2acd8bc9925 100644
> > --- a/fs/fuse/file_iomap.c
> > +++ b/fs/fuse/file_iomap.c
> > @@ -495,10 +495,15 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
> >  }
> >
> >  /* Decide if we send FUSE_IOMAP_END to the fuse server */
> > -static bool fuse_should_send_iomap_end(const struct iomap *iomap,
> > +static bool fuse_should_send_iomap_end(const struct fuse_mount *fm,
> > +                                      const struct iomap *iomap,
> >                                        unsigned int opflags, loff_t count,
> >                                        ssize_t written)
> >  {
> > +       /* Not implemented on fuse server */
> > +       if (fm->fc->iomap_conn.no_end)
> > +               return false;
> > +
> >         /* fuse server demanded an iomap_end call. */
> >         if (iomap->flags & FUSE_IOMAP_F_WANT_IOMAP_END)
> >                 return true;
> > @@ -523,7 +528,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
> >         struct fuse_mount *fm = get_fuse_mount(inode);
> >         int err = 0;
> >
> > -       if (fuse_should_send_iomap_end(iomap, opflags, count, written)) {
> > +       if (fuse_should_send_iomap_end(fm, iomap, opflags, count, written)) {
> >                 struct fuse_iomap_end_in inarg = {
> >                         .opflags = fuse_iomap_op_to_server(opflags),
> >                         .attr_ino = fi->orig_ino,
> > @@ -549,6 +554,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
> >                          * libfuse returns ENOSYS for servers that don't
> >                          * implement iomap_end
> >                          */
> > +                       fm->fc->iomap_conn.no_end = 1;
> >                         err = 0;
> >                         break;
> >                 case 0:
> > @@ -567,6 +573,95 @@ static const struct iomap_ops fuse_iomap_ops = {
> >         .iomap_end              = fuse_iomap_end,
> >  };
> >
> > +static inline bool
> > +fuse_should_send_iomap_ioend(const struct fuse_mount *fm,
> > +                            const struct fuse_iomap_ioend_in *inarg)
> > +{
> > +       /* Not implemented on fuse server */
> > +       if (fm->fc->iomap_conn.no_ioend)
> > +               return false;
> > +
> > +       /* Always send an ioend for errors. */
> > +       if (inarg->error)
> > +               return true;
> > +
> > +       /* Send an ioend if we performed an IO involving metadata changes. */
> > +       return inarg->written > 0 &&
> > +              (inarg->ioendflags & (FUSE_IOMAP_IOEND_SHARED |
> > +                                    FUSE_IOMAP_IOEND_UNWRITTEN |
> > +                                    FUSE_IOMAP_IOEND_APPEND));
> > +}
> > +
> > +/*
> > + * Fast and loose check if this write could update the on-disk inode size.
> > + */
> > +static inline bool fuse_ioend_is_append(const struct fuse_inode *fi,
> > +                                       loff_t pos, size_t written)
> > +{
> > +       return pos + written > i_size_read(&fi->inode);
> > +}
> > +
> > +static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t written,
> > +                           int error, unsigned ioendflags, sector_t new_addr)
> > +{
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > +       struct fuse_mount *fm = get_fuse_mount(inode);
> > +       struct fuse_iomap_ioend_in inarg = {
> > +               .ioendflags = ioendflags,
> > +               .error = error,
> > +               .attr_ino = fi->orig_ino,
> > +               .pos = pos,
> > +               .written = written,
> > +               .new_addr = new_addr,
> > +       };
> > +
> > +       if (fuse_ioend_is_append(fi, pos, written))
> > +               inarg.ioendflags |= FUSE_IOMAP_IOEND_APPEND;
> > +
> > +       if (fuse_should_send_iomap_ioend(fm, &inarg)) {
> > +               FUSE_ARGS(args);
> > +               int err;
> > +
> > +               args.opcode = FUSE_IOMAP_IOEND;
> > +               args.nodeid = get_node_id(inode);
> > +               args.in_numargs = 1;
> > +               args.in_args[0].size = sizeof(inarg);
> > +               args.in_args[0].value = &inarg;
> > +               err = fuse_simple_request(fm, &args);
> > +               switch (err) {
> > +               case -ENOSYS:
> > +                       /*
> > +                        * fuse servers can return ENOSYS if ioend processing
> > +                        * is never needed for this filesystem.
> > +                        */
> > +                       fm->fc->iomap_conn.no_ioend = 1;
> > +                       err = 0;
> 
> It doesn't look like we need to set err here or maybe I'm missing something

Maybe we both are? :D

There shouldn't be variables named @error _and_ @err in the same
function; and the err assignment here is indeed pointless as you state.
But that's a very confusing thing fo rme to have done.

fuse_iomap_ioend should return the error passed into it; or if no error
was passed into it, then it can convey an error that occurred during
processing of the ioend itself (e.g. remapping after a write failed).

> > +                       break;
> > +               case 0:
> > +                       break;
> > +               default:
> > +                       /*
> > +                        * If the write IO failed, return the failure code to
> > +                        * the caller no matter what happens with the ioend.
> > +                        * If the write IO succeeded but the ioend did not,
> > +                        * pass the new error up to the caller.
> > +                        */
> > +                       if (!error)
> > +                               error = err;
> > +                       break;
> > +               }
> > +       }
> > +       if (error)
> > +               return error;
> > +
> > +       /*
> > +        * If there weren't any ioend errors, update the incore isize, which
> 
> Not sure if incore is a standard term, but it had me confused for a
> bit. I think incore just means kernel-internal?

Yes.  Later on in the pagecache path we'll introduce the notion of the
"ondisk" isize.  Both of these names are iomap/xfs anachronisms.

The incore isize is of course the same kernel-internal file size.
The "ondisk" isize is the file size according to the fuse server.

Because iomap supports things like delalloc, this means that the
in-memory file can become quite a bit larger than what the kernel has
pushed to disk (and the fuse server) via writeback.  If userspace asks
the kernel to do something that requires immediate metadata changes such
as fallocate, it's critical to preflush anything dirty between the
"ondisk" EOF and the affected range.

Example: Let's say you write a 100K file and do not fsync it.  The
incore isize is 100K, but nobody's told the fuse server anything so it
thinks the file size is still empty.  Next, you pwrite another 22K but
this time at offset 20,000K.  The incore isize is now 22,022K, but
pagecache writeback hasn't triggered yet, so the fuse server thinks the
file is still empty.

Now you ask to fallocate 4K at offset 10,000K.  This requires a trip to
the fuse server to fill that 4k hole, but before you can do that, you
have to flush any dirty data between the ondisk size (0) and the start
of the fallocate range (10000K) because the fuse command will change the
file size to 10,004K, and as the write came before the fallocate, the
effects of that write must be persisted before the effects of the
fallocate.

But at this point we're only doing direct writes so this is a confusing
long way to update isize on an extending write.

> > +        * confusingly takes the new i_size as "pos".
> > +        */
> > +       fuse_write_update_attr(inode, pos + written, written);
> > +       return 0;
> > +}
> > +
> >  static int fuse_iomap_may_admin(struct fuse_conn *fc, unsigned int flags)
> >  {
> >         if (!fc->iomap)
> > @@ -618,6 +713,8 @@ void fuse_iomap_mount(struct fuse_mount *fm)
> >          * freeze/thaw properly.
> >          */
> >         fc->sync_fs = true;
> > +       fc->iomap_conn.no_end = 0;
> > +       fc->iomap_conn.no_ioend = 0;
> 
> fc after it's first allocated has all its fields memset to 0

Ok, will fix.

> >  }
> >
> >  void fuse_iomap_unmount(struct fuse_mount *fm)
> > @@ -760,3 +857,151 @@ loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence)
> >                 return offset;
> >         return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
> >  }
> > +
> > +void fuse_iomap_open(struct inode *inode, struct file *file)
> > +{
> > +       ASSERT(fuse_inode_has_iomap(inode));
> > +
> > +       file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
> > +}
> > +
> > +enum fuse_ilock_type {
> > +       SHARED,
> > +       EXCL,
> > +};
> > +
> > +static int fuse_iomap_ilock_iocb(const struct kiocb *iocb,
> > +                                enum fuse_ilock_type type)
> > +{
> > +       struct inode *inode = file_inode(iocb->ki_filp);
> > +
> > +       if (iocb->ki_flags & IOCB_NOWAIT) {
> > +               switch (type) {
> > +               case SHARED:
> > +                       return inode_trylock_shared(inode) ? 0 : -EAGAIN;
> > +               case EXCL:
> > +                       return inode_trylock(inode) ? 0 : -EAGAIN;
> > +               default:
> > +                       ASSERT(0);
> > +                       return -EIO;
> > +               }
> > +       } else {
> 
> nit: the else {} scoping doesn't seem needed here

<nod>

> > +               switch (type) {
> > +               case SHARED:
> > +                       inode_lock_shared(inode);
> > +                       break;
> > +               case EXCL:
> > +                       inode_lock(inode);
> > +                       break;
> > +               default:
> > +                       ASSERT(0);
> > +                       return -EIO;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to)
> > +{
> > +       struct inode *inode = file_inode(iocb->ki_filp);
> > +       ssize_t ret;
> > +
> > +       ASSERT(fuse_inode_has_iomap(inode));
> > +
> > +       if (!iov_iter_count(to))
> > +               return 0; /* skip atime */
> > +
> > +       file_accessed(iocb->ki_filp);
> 
> Does it make sense for this to be moved below so it's called only if
> fuse_iomap_ilock_iocb() succeeded?

Ideally we'd do it on successful return from iomap_dio_read.

Curiously, XFS does it this way (bump atime, take i_rwsem, do read),
whereas ext4 relies on filemap_read, which does it at the end.

Weird.

> > +
> > +       ret = fuse_iomap_ilock_iocb(iocb, SHARED);
> > +       if (ret)
> > +               return ret;
> > +       ret = iomap_dio_rw(iocb, to, &fuse_iomap_ops, NULL, 0, NULL, 0);
> > +       inode_unlock_shared(inode);
> > +
> > +       return ret;
> > +}
> > +
> > +static int fuse_iomap_dio_write_end_io(struct kiocb *iocb, ssize_t written,
> > +                                      int error, unsigned dioflags)
> > +{
> > +       struct inode *inode = file_inode(iocb->ki_filp);
> > +       unsigned int nofs_flag;
> > +       unsigned int ioendflags = FUSE_IOMAP_IOEND_DIRECT;
> > +       int ret;
> > +
> > +       if (fuse_is_bad(inode))
> > +               return -EIO;
> > +
> > +       ASSERT(fuse_inode_has_iomap(inode));
> > +
> > +       if (dioflags & IOMAP_DIO_COW)
> > +               ioendflags |= FUSE_IOMAP_IOEND_SHARED;
> > +       if (dioflags & IOMAP_DIO_UNWRITTEN)
> > +               ioendflags |= FUSE_IOMAP_IOEND_UNWRITTEN;
> > +
> > +       /*
> > +        * We can allocate memory here while doing writeback on behalf of
> > +        * memory reclaim.  To avoid memory allocation deadlocks set the
> > +        * task-wide nofs context for the following operations.
> > +        */
> > +       nofs_flag = memalloc_nofs_save();
> 
> I'm a bit confused by this part. Could you explain how it's invoked
> while doing writeback for memory reclaim? As I understand it,
> writeback goes through buffered io and not direct io?

I think this is a throwback to earlier versions of the iomap patchset
where I tried using the actual directio write machinery to perform
writebacks.  They're separate now, so I think this can go away.

> > +       ret = fuse_iomap_ioend(inode, iocb->ki_pos, written, error, ioendflags,
> > +                              FUSE_IOMAP_NULL_ADDR);
> > +       memalloc_nofs_restore(nofs_flag);
> > +       return ret;
> > +}
> > +
> > +static const struct iomap_dio_ops fuse_iomap_dio_write_ops = {
> > +       .end_io         = fuse_iomap_dio_write_end_io,
> > +};
> > +
> > +ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
> > +{
> > +       struct inode *inode = file_inode(iocb->ki_filp);
> > +       loff_t blockmask = i_blocksize(inode) - 1;
> > +       size_t count = iov_iter_count(from);
> > +       unsigned int flags = 0;
> > +       ssize_t ret;
> > +
> > +       ASSERT(fuse_inode_has_iomap(inode));
> > +
> > +       if (!count)
> > +               return 0;
> > +
> > +       /*
> > +        * Unaligned direct writes require zeroing of unwritten head and tail
> > +        * blocks.  Extending writes require zeroing of post-EOF tail blocks.
> > +        * The zeroing writes must complete before we return the direct write
> > +        * to userspace.  Don't even bother trying the fast path.
> > +        */
> > +       if ((iocb->ki_pos | count) & blockmask)
> > +               flags = IOMAP_DIO_FORCE_WAIT;
> > +
> > +       ret = fuse_iomap_ilock_iocb(iocb, EXCL);
> > +       if (ret)
> > +               goto out_dsync;
> 
> I wonder if we need the out_dsync goto at all. Maybe just return ret
> here directly?

Ok.

> > +       ret = generic_write_checks(iocb, from);
> > +       if (ret <= 0)
> > +               goto out_unlock;
> > +
> > +       /*
> > +        * If we are doing exclusive unaligned I/O, this must be the only I/O
> > +        * in-flight.  Otherwise we risk data corruption due to unwritten
> > +        * extent conversions from the AIO end_io handler.  Wait for all other
> > +        * I/O to drain first.
> > +        */
> > +       if (flags & IOMAP_DIO_FORCE_WAIT)
> > +               inode_dio_wait(inode);
> > +
> 
> Should we add a file_modified() call here?

Urk.  That will get fixed when I implement fuse_iomap_write_checks in
the next patch that does buffered IO, but yes, it's needed here too.

> 
> > +       ret = iomap_dio_rw(iocb, from, &fuse_iomap_ops,
> > +                          &fuse_iomap_dio_write_ops, flags, NULL, 0);
> > +       if (ret)
> > +               goto out_unlock;
> 
> I think we could get rid of this if (ret) check

Will do.

> > +
> > +out_unlock:
> > +       inode_unlock(inode);
> > +out_dsync:
> > +       return ret;
> > +}
> > diff --git a/fs/fuse/trace.c b/fs/fuse/trace.c
> > index 68d2eecb8559a5..300985d62a2f9b 100644
> > --- a/fs/fuse/trace.c
> > +++ b/fs/fuse/trace.c
> > @@ -9,6 +9,7 @@
> >  #include "iomap_i.h"
> >
> >  #include <linux/pagemap.h>
> > +#include <linux/iomap.h>
> 
> Was this meant to be part of the subsequent trace.h patch? I haven't
> tried compiling this though so maybe I' mmissing something but I'm not
> seeing which part of the logic above needs this.

Yes.  Originally the tracepoints were not broken out, but Miklos
asked for things to be this way.

--D

> Thanks,
> Joanne
> >
> >  #define CREATE_TRACE_POINTS
> >  #include "fuse_trace.h"
> >
> 

