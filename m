Return-Path: <linux-fsdevel+bounces-13214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4E386D40A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 21:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9581F24A8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 20:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A476CC09;
	Thu, 29 Feb 2024 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diU+V4Th"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9779A2E410;
	Thu, 29 Feb 2024 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237922; cv=none; b=DAoU9ax9G2dF6GZzGBfYTV5PlWdx4pXHbJ+Kd1VnA1WkGFRdySyEwRGJhyOfeqTR3oUWNCSuj3EjiHiD3YRIRMM8pGpaP0a1F6ytOnVz2yEMd/ndghBTFLaVReEW0Xwu0/8PqUlQ1Qe6cQry8dCbBpzTBG4oSKWyeTfaphUOR7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237922; c=relaxed/simple;
	bh=b/iUEhuGwZIlSsVnb6MBaptGvHOkdwDsH2T5H3Lxydo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTQN852vAl2UDdUPtJF8Clx1DcDi59Gc3k8wgUTKOcuvMUznWBjiDaMMSrlx70SctdfKTbaffV6/la/LJKit9fG/PSlIr4u6+t5t80YWzvZonMw6hVOzAgmB/JCc2ay6ffuLJPB8JcrBe3nyius9cpcWKtqQmAKh59j3E64Y5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diU+V4Th; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09ECC433C7;
	Thu, 29 Feb 2024 20:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709237920;
	bh=b/iUEhuGwZIlSsVnb6MBaptGvHOkdwDsH2T5H3Lxydo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=diU+V4ThMF7itixmLUEptHBFI1uoIo3WcV2nTfCJPxPa4ljT15j1vGeJT5aYsXZzE
	 MooXJ0drDuP7CuGfbvnSOZpDAwGIsu64BCoUP6Fw4FK/pkneQt+zsW1HIta5JcDVTp
	 lro9iC53vXetK721EtLXoOWC6CCcbo+5wjP2CVzjTZH8jj9vZGFJwLMW26AgfebDqn
	 Ny4/tgXDTNjQUNQrIC5nO30IpYcOKfO+7TQ9bY6/JZVWMz1Z0IIqFq3RFGAThQyiWD
	 CCIDGxzreeBedq6LFLi1fRUXnkw5SPU1OZfkFQEwnJzSpfI0f7qLwlzv1o+znL9CXA
	 F0IEAZz7f+lOQ==
Date: Thu, 29 Feb 2024 12:18:40 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Colin Walters <walters@verbum.org>
Cc: linux-fsdevel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHSET v29.4 03/13] xfs: atomic file content exchanges
Message-ID: <20240229201840.GC1927156@frogsfrogsfrogs>
References: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
 <87961163-a4b9-4032-aa06-f5126c9c8ca2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87961163-a4b9-4032-aa06-f5126c9c8ca2@app.fastmail.com>

On Tue, Feb 27, 2024 at 08:50:20PM -0500, Colin Walters wrote:
> 
> 
> On Mon, Feb 26, 2024, at 9:18 PM, Darrick J. Wong wrote:
> > Hi all,
> >
> > This series creates a new FIEXCHANGE_RANGE system call to exchange
> > ranges of bytes between two files atomically.  This new functionality
> > enables data storage programs to stage and commit file updates such that
> > reader programs will see either the old contents or the new contents in
> > their entirety, with no chance of torn writes.  A successful call
> > completion guarantees that the new contents will be seen even if the
> > system fails.
> >
> > The ability to exchange file fork mappings between files in this manner
> > is critical to supporting online filesystem repair, which is built upon
> > the strategy of constructing a clean copy of a damaged structure and
> > committing the new structure into the metadata file atomically.
> >
> > User programs will be able to update files atomically by opening an
> > O_TMPFILE, reflinking the source file to it, making whatever updates
> > they want to make, and exchange the relevant ranges of the temp file
> > with the original file. 
> 
> It's probably worth noting that the "reflinking the source file" here
> is optional, right?  IOW one can just:
> 
> - open(O_TMPFILE)
> - write()
> - ioctl(FIEXCHANGE_RANGE)

If the write() rewrites the entire file, then yes, that'll also work.

> I suspect the "simpler" non-database cases (think e.g. editors
> operating on plain text files) are going to be operating on an
> in-memory copy; in theory of course we could identify common ranges
> and reflink, but it's not clear to me it's really worth it at the
> tiny scale most source files are.

Correct, there's no built-in dedupe.  For small files you'll probably
end up with a single allocation anyway, which is ideal in terms of
ondisk metadata overhead.

One advantage that EXCHANGE_RANGE has over the rename dance is that the
calling application doesn't have to copy all the file attributes and
xattrs to the temporary file before the switch.

> > The intent behind this new userspace functionality is to enable atomic
> > rewrites of arbitrary parts of individual files.  For years, application
> > programmers wanting to ensure the atomicity of a file update had to
> > write the changes to a new file in the same directory
> 
> More sophisticated tools already are using O_TMPFILE I would say,
> just with a final last step of materializing it with a name,
> and then rename() into place.  So if this also
> obviates the need for
> https://lore.kernel.org/linux-fsdevel/364531.1579265357@warthog.procyon.org.uk/
> that seems good.

It would, though I would bet that extending linkat (or rename, or
whatever) is going to be the only workable solution for old / simple
filesystems (e.g. fat32).

> >        Exchanges  are  atomic  with  regards to concurrent file opera‐
> >        tions, so no userspace-level locks need to be taken  to  obtain
> >        consistent  results.  Implementations must guarantee that read‐
> >        ers see either the old contents or the new  contents  in  their
> >        entirety, even if the system fails.
> 
> But given that we're reusing the same inode, I don't think that can
> *really* be true...at least, not without higher level serialization.

Higher level coordination is required, yes.  It doesn't have to be
serialization, though.  The committing thread could signal all the other
readers that they should invalidate and restart whatever they're working
on if that work depends on the file that was COMMIT_RANGE'd.  The
readers could detect unexpected data and resample mtime of the files
they've read and restart if it's changed.

> A classic case today is dconf in GNOME is a basic memory-mapped
> database file that is atomically replaced by the "create new file,
> rename into place" model.  Clients with mmap() view just see the old
> data until they reload explicitly.  But with this, clients with mmap'd
> view *will* immediately see the new contents (because it's the same
> inode, right?)

Correct, they'll start seeing the new contents as soon as they access
the affected pages.

How /does/ dconf handle those changes?  Does it rename the file and
signal all the other dconf threads to reopen the file?  And then those
threads get the new file contents?

>                and that's just going to lead to possibly split reads
> and undefined behavior - without extra userspace serialization or
> locking (that more proper databases) are going to be doing.

Huurrrh hurrrh.  That's right, I don't see how exchange can mesh well
with mmap without actual flock()ing. :(

fsnotify will send a message out to userspace after the exchange
finishes, which means that userspace could watch for the notifications
via fanotify.  However, that's still a bit racy... :/

> Arguably of course, dconf is too simple and more sophisticated tools
> like sqlite or LMDB could make use of this.  (There's some special
> atomic write that got added to f2fs for sqlite last I saw...I'm
> curious if this could replace it)

I think so:

F2FS_IOC_START_ATOMIC_WRITE -> XFS_IOC_START_COMMIT,
F2FS_IOC_COMMIT_ATOMIC_WRITE -> XFS_IOC_COMMIT_RANGE, and
F2FS_IOC_ABORT_VOLATILE_WRITE merely turns into close(temp_fd);

> But still...it seems to me like there's going to be quite a lot of the
> "potentially concurrent reader, atomic replace desired" pattern and
> since this can't replace that, we should call that out explicitly in
> the man page.  And also if so, then there's still a need for the
> linkat(AT_REPLACE) etc.

Hmm, I think I'll shrink that paragraph of the manpage:

"Exchanges are atomic with regards to concurrent file operations.
Implementations must guarantee that readers see either the old contents
or the new contents in their entirety, even if the system fails."

> 
> >            XFS_EXCHRANGE_TO_EOF
> 
> I kept reading this as some sort of typo...would it really be too
> onerous to spell it out as XFS_EXCHANGE_RANGE_TO_EOF e.g.?  Echoes of
> unix "creat" here =)

Yeah, I've expanded that to XFS_EXCHANGE_RANGE_TO_EOF for v29.5.

--D

