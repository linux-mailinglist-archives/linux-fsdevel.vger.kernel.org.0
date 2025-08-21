Return-Path: <linux-fsdevel+bounces-58573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BBBB2EE2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 08:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3AC77232DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 06:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3A32E2DCA;
	Thu, 21 Aug 2025 06:25:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24779199FD0;
	Thu, 21 Aug 2025 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757553; cv=none; b=uqmPoFqBnPooohgXo4fjdZExJYfYIwtYtvwqmII52n6zjRMU2pYJg1Y+iTOpbj/1xq3LEZvHpx1RQvGQFJ/QH/jVuVWyOj/mTEtL9W+xriGo1c3k6nHegd1lFOFQX08eXa0qLRvQ63ovlDtvziHBDWDbYvzqjuCi32kn0bB6Hks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757553; c=relaxed/simple;
	bh=chnVPGe6NfLoxOOMWAgDsXpHzwTBGuMJYD8YzgM96x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbDKlLGJcGcXqx2LqPZc1qFfCx4e2tlTHB9AsZVXpbfkbjlZIWVhR4Wdxxa7rpEafLstIRoy+WRvlp+X7Tw6RStC9G67KERffRUOe1Jqbr7YM/JiGh3cXEkUWXi4WPAFcSJAhZMNxvoj5sOsp5a5PqGclneLI7TzrXqlW2RWK/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.22.11.164])
	by smtp.qiye.163.com (Hmail) with ESMTP id 201c913d4;
	Thu, 21 Aug 2025 14:25:36 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luochunsheng@ustc.edu,
	miklos@szeredi.hu
Subject: Re: [PATCH] fuse: clarify extending writes handling
Date: Thu, 21 Aug 2025 14:25:35 +0800
Message-ID: <20250821062535.1498-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820162724.GL7942@frogsfrogsfrogs>
References: <20250820162724.GL7942@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98cb4de42003a2kunm4fba01344ee982
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZS0gdVk4YQxpOSEMeHk5DS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VJSVVKSlVKTU9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0pVSktLVUtZBg
	++

On  Wed, 20 Aug 2025 09:27:24 Darrick J. Wong wrote:

> On Wed, Aug 20, 2025 at 08:52:35AM +0200, Miklos Szeredi wrote:
> > On Wed, 20 Aug 2025 at 07:20, Darrick J. Wong <djwong@kernel.org> wrote:
> > 
> > > I don't understand the current behavior at all -- why do the callers of
> > > fuse_writeback_range pass an @end parameter when it ignores @end in
> > > favor of LLONG_MAX?  And why is it necessary to flush to EOF at all?
> > > fallocate and copy_file_range both take i_rwsem, so what could they be
> > > racing with?  Or am I missing something here?
> > 
> > commit 59bda8ecee2f ("fuse: flush extending writes")
> > 
> > The issue AFAICS is that if writes beyond the range end are not
> > flushed, then EOF on backing file could be below range end (if pending
> > writes create a hole), hence copy_file_range() will stop copying at
> > the start of that hole.
> > 
> > So this patch is incorrect, since not flushing copy_file_range input
> > file could result in a short copy.
> 

Thanks to Miklos for the review and explanation.

> <nod> As far as Mr. Luo's patch is concerned, I agree that a strict "no
> behavior changes" patch should have changed the inode_in writeback_range
> call to:
> 
> 	err = fuse_writeback_range(inode_in, pos_in, LLONG_MAX);
> 
> Though if all callsites are going to pass LLONG_MAX in as @end, then
> why not eliminate the parameter entirely?
> 

Thanks for your reply.

Ok, understood. Before fully understanding why we need to flush up to the end,
let's first ensure the logic remains unchanged.
 
Rather than removing the end parameter from fuse_writeback_range and putting
LLONG_MAX inside the function, I suggest keeping the end parameter, modifying
the input argument to LLONG_MAX, and adding some comments. This way we can
more clearly see the range scope. Also, we cannot guarantee whether there
will be other scenarios that need the real_end in the future.

> What I'm (still) wondering is why was it necessary to flush the source
> and destination ranges between (pos + len - 1) and LLONG_MAX?  But let's
> see, what did 59bda8ecee2f have to say?
> 
> | fuse: flush extending writes
> |
> | Callers of fuse_writeback_range() assume that the file is ready for
> | modification by the server in the supplied byte range after the call
> | returns.
> 
> Ok, so far so good.
> 
> | If there's a write that extends the file beyond the end of the supplied
> | range, then the file needs to be extended to at least the end of the range,
> | but currently that's not done.
> |
> | There are at least two cases where this can cause problems:
> |
> |  - copy_file_range() will return short count if the file is not extended
> |    up to end of the source range.
> 
> That suggests to me
> 
> filemap_write_and_wait_range(inode_in, pos_in, pos_in + pos_len - 1)
> 
> but I don't see why we need to flush more bytes than that?  The server's
> CFR implementation has all the bytes it needs to read the source data.
> 
> Hum.  But what if CFR is actually reflink?  I guess you'd want to
> buffer-copy the unaligned head and tail regions, and reflink the
> allocation units in the middle, but I still don't see why the fuse
> server needs more of the source file than (pos, pos + len - 1)?
> 
> |  - FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE will not extend the file,
> |    hence the region may not be fully allocated.
> 
> Hrm, ZERO | KEEP_SIZE is supposed to allow preallocation of blocks
> beyond EOF, or at least that's what XFS does:
> 
> $ truncate -s 10m /mnt/test
> $ xfs_io -c 'fzero -k 100m 64k' /mnt/test
> $ filefrag -v /mnt/test
> Filesystem type is: 58465342
> File size of /mnt/test is 10485760 (2560 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:    25600..   25615:         24..        39:     16:      25600: last,unwritten,eof
> /mnt/test: 1 extent found
> 
> as does ext4:
> 
> $ truncate -s 10m /mnt/test
> $ xfs_io -c 'fzero -k 100m 64k' /mnt/test
> $ filefrag -v /mnt/test
> Filesystem type is: ef53
> File size of /mnt/test is 10485760 (2560 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:    25600..   25615:      33808..     33823:     16:      25600: last,unwritten,eof
> /mnt/test: 1 extent found
> 
> (Notice that the 10M file has one extent starting at 100M)
> 
> I can see why you'd want to flush the target range in case the fuse
> server has a better trick up its sleeve to zero the already-written
> region that isn't the punch-and-realloc behavior that xfs and ext4 have.
> But here too I don't see why the fuse server would need more than the
> target region.
> 
> Though I think for both cases we end up flushing more than the target
> region, because the page cache rounds start down and end up to PAGE_SIZE
> boundaries.
> 
> | Fix by flushing writes from the start of the range up to the end of the
> | file.  This could be optimized if the writes are non-extending, etc, but
> | it's probably not worth the trouble.
> 
> <shrug> Was there a bug report associated with this commit?  I couldn't
> find the any hits on the subject line in lore.  Was this simply a big
> hammer that solved whatever corruption problems were occuring?  Or
> something found in code inspection?
> 
> <confused>
> 
> --D
> 
> > Thanks,
> > Miklos
> > 

Regarding "The issue AFAICS is that if writes beyond the range end are not flushed, 
then EOF on backing file could be below range end (if pending writes create a hole), 
hence copy_file_range() will stop copying at the start of that hole."

I looked up some information from man and code

1. The man copy_file_range description:

"If fd_in is a sparse file, then copy_file_range() may expand any holes existing 
in the requested range. Users may benefit from calling copy_file_range() in a loop, 
and using the lseek(2) SEEK_DATA and SEEK_HOLE operations to find the locations of
data segments."

The man page description of 'If fd_in is a sparse file' clearly refers to the source
file being a sparse file (i.e., containing holes). In this case, copy_file_range may
expand holes (logical zero-byte regions) in the source file into actual written zero
bytes in the destination file (physically occupying disk space), causing the destination
file to lose its sparseness. This should refer to the case where holes exist within the
copy_from range of fd_in.

2. Looking at the corresponding code:
copy_file_range() -> do_splice_direct -> splice_direct_to_actor -> do_splice_read

do_splice_read:
do {
    if (*ppos >= i_size_read(in->f_mapping->host))
        break;  // Hit end of file, exit
		
    // filemap_get_pages encountering file holes will fill with zeros
    // Or is there a case where the filesystem returns failure when it encounters a hole?
    error = filemap_get_pages(&iocb, len, &fbatch, true); 
    if (error < 0)
        break;
    
    // Process each page, copy to pipe
    for (i = 0; i < folio_batch_count(&fbatch); i++) {
        n = splice_folio_into_pipe(pipe, folio, *ppos, n);
        if (!n)
            goto out;
			...
    }
} while (len);

I can understand that the [pos, pos+len) range needs to be flushed to the backing file
to avoid the FUSE userspace program mistakenly thinking that there are holes in the
backing file (file_in) or that the size is insufficient, which would cause the FUSE
userspace program to execute copy_file_range(back_file_in, back_file_out) and return
short copy or overwrite holes with zeros.

But I'm also confused why we need to flush beyond the [pos, pos+len) range?

Yes, are there any testcases or problem email discussions that would make it easier
to understand the reason? 

I'll continue to look at the code in detail combined with testing later.

Thanks
Chunsheng Luo

