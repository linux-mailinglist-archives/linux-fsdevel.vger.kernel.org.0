Return-Path: <linux-fsdevel+bounces-14057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7580187722D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 17:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0384A1F2203B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 16:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E616745949;
	Sat,  9 Mar 2024 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhSnbF/p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E640245957;
	Sat,  9 Mar 2024 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710001145; cv=none; b=RiILHNLxlUNLWtU+jp8DrxVjZ9pla1p4FCtWyJ8u0cPf1exmv+qRgmMBlN9k0Le+ARBLpp8hedmWasA2nv1KHkU1XqrkfvJPWS2apRqHYTTQNbGaHWg5hnIOl2vxD/cNjUMunpmU+5kyxRDw1HuKUz6UAY9gJus/a48hXDYXlko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710001145; c=relaxed/simple;
	bh=A9czWoAPclIi3aNPvypvQTPoNROtlqDSEd4Q+nxmyos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXvrRt3YS0vdN1lISwt76IH6P1yp+87TNJr774zoV4hz7kvudz6YLLBgd/GrRzraqilae6vGoUBOeO2BJESIaxWT/cpVtN5U381fPFwfHzJNMLAVJf0FFwXKlFpk5xYnMPWBJsRUKJNbQRIr2vD/hjy9HgSoJOtTzycAR/v1q8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhSnbF/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BEFC433F1;
	Sat,  9 Mar 2024 16:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710001144;
	bh=A9czWoAPclIi3aNPvypvQTPoNROtlqDSEd4Q+nxmyos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VhSnbF/pHKAusicyM5vsnuzeSThwVva0SXXshUgbHtzIAQE0jjD7+A+KkVvJ8phZ5
	 1zSnjjw8Pya8dbGF0FgUOlpdQsdnI/liT2OGjxE4pycguf3FICqCsj7CnXJQfTW0Dh
	 H2vOpucKIfJZzIIdxBXIGj6CiwhxNF5ErwXA5z//YJPsQSSq71E+ij8yYXxjOrRP4E
	 r7kQ6a0mjUVz4IPeyBLzJcXBdt4sFTWquubn6lg8UhfynvWA5PNUbZVZ9SnvdRiWHU
	 q2rW9XfvwkYDoZFCw65hC/fzHsP5Pz9Zv5nXh2URRxvnzClF+8OkfwBT12/g4j3SMc
	 C6GK6Yc3Tls6Q==
Date: Sat, 9 Mar 2024 08:19:03 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com
Subject: Re: [PATCH v5 06/24] fsverity: pass tree_blocksize to
 end_enable_verity()
Message-ID: <20240309161903.GO1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-8-aalbersh@redhat.com>
 <20240305005242.GE17145@sol.localdomain>
 <20240306163000.GP1927156@frogsfrogsfrogs>
 <20240307220224.GA1799@sol.localdomain>
 <20240308034650.GK1927156@frogsfrogsfrogs>
 <ZeuEe7qpNYaIll7L@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeuEe7qpNYaIll7L@dread.disaster.area>

On Sat, Mar 09, 2024 at 08:34:51AM +1100, Dave Chinner wrote:
> On Thu, Mar 07, 2024 at 07:46:50PM -0800, Darrick J. Wong wrote:
> > On Thu, Mar 07, 2024 at 02:02:24PM -0800, Eric Biggers wrote:
> > > On Wed, Mar 06, 2024 at 08:30:00AM -0800, Darrick J. Wong wrote:
> > > > Or you could leave the unfinished tree as-is; that will waste space, but
> > > > if userspace tries again, the xattr code will replace the old merkle
> > > > tree block contents with the new ones.  This assumes that we're not
> > > > using XATTR_CREATE during FS_IOC_ENABLE_VERITY.
> > > 
> > > This should work, though if the file was shrunk between the FS_IOC_ENABLE_VERITY
> > > that was interrupted and the one that completed, there may be extra Merkle tree
> > > blocks left over.
> > 
> > What if ->enable_begin walked the xattrs and trimmed out any verity
> > xattrs that were already there?  Though I think ->enable_end actually
> > could do this since one of the args is the tree size, right?
> 
> If we are overwriting xattrs, it's effectively a remove then a new
> create operation, so we may as well just add a XFS_ATTR_VERITY
> namespace invalidation filter that removes any xattr in that
> namespace in ->enable_begin...

Yeah, that sounds like a good idea.  One nice aspect of the generic
listxattr code (aka not the simplified one that scrub uses) is that the
cursor tracking means that we could actually iterate-and-zap old merkle
tree blocks.

If we know the size of the merkle tree ahead of time (say it's N blocks)
then we just start zapping N, then N+1, etc. until we don't find any
more.  That wouldn't be exhaustive, but it's good enough to catch most
cases.

Online fsck should, however, have a way to call ensure_verity_info() so
that it can scan the xattrs looking for merkle tree blocks beyond
tree_size, missing merkle tree blocks within tree_size, missing
descriptors, etc.  It looks like the merkle tree block contents are
entirely hashes (no sibling/child/parent pointers, block headers, etc.)
so there's not a lot to check in the tree structure.  It looks pretty
similar to flattening a heap into a linear array.

> > > BTW, is xfs_repair planned to do anything about any such extra blocks?
> > 
> > Sorry to answer your question with a question, but how much checking is
> > $filesystem expected to do for merkle trees?
> > 
> > In theory xfs_repair could learn how to interpret the verity descriptor,
> > walk the merkle tree blocks, and even read the file data to confirm
> > intactness.  If the descriptor specifies the highest block address then
> > we could certainly trim off excess blocks.  But I don't know how much of
> > libfsverity actually lets you do that; I haven't looked into that
> > deeply. :/
> 
> Perhaps a generic fsverity userspace checking library we can link in
> to fs utilities like e2fsck and xfs_repair is the way to go here.
> That way any filesystem that supports fsverity can do offline
> validation of the merkle tree after checking the metadata is OK if
> desired.

That'd be nice.  Does the above checking sound reasonable? :)

> > For xfs_scrub I guess the job is theoretically simpler, since we only
> > need to stream reads of the verity files through the page cache and let
> > verity tell us if the file data are consistent.
> 
> *nod*

I had another thought overnight -- regular read()s incur the cost of
copying pagecache contents to userspace.  Do we really care about that,
though?  In theory we could mmap verity file contents and then use
MADV_POPULATE_READ to pull in the page cache and return error codes.  No
copying, and fewer syscalls.

> > For both tools, if something finds errors in the merkle tree structure
> > itself, do we turn off verity?  Or do we do something nasty like
> > truncate the file?
> 
> Mark it as "data corrupt" in terms of generic XFS health status, and
> leave it up to the user to repair the data and/or recalc the merkle
> tree, depending on what they find when they look at the corrupt file
> status.

Is there a way to forcibly read the file contents even if it fails
verity validation?  I was assuming the only recourse in that case is to
delete the file and restore from backup/package manager/etc.

> > Is there an ioctl or something that allows userspace to validate an
> > entire file's contents?  Sort of like what BLKVERIFY would have done for
> > block devices, except that we might believe its answers?
> > 
> > Also -- inconsistencies between the file data and the merkle tree aren't
> > something that xfs can self-heal, right?
> 
> Not that I know of - the file data has to be validated before we can
> tell if the error is in the data or the merkle tree, and only the
> user can validate the data is correct.

<nod>

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

