Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979644A0391
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 23:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbiA1WXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 17:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350036AbiA1WXE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:23:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D41C06173B;
        Fri, 28 Jan 2022 14:23:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AF4CB80D50;
        Fri, 28 Jan 2022 22:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0194C340E7;
        Fri, 28 Jan 2022 22:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643408581;
        bh=Y8FxnAdX9n8TxRkQk5LvtXGKosxm4BS7eqBiMD65ByQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZTfM2zWOLRYFEH25Aw9j8R4WbZsZabZ5sjIueAaAyaJcKZPArpQPQxsnZcl8AeCgm
         HE/saeGpzbtoKawDale/41m9c4PaNrgZSXOn8VpkpGccgYkV3deFnbrJkaUKkVYCnL
         u3tDTUtNgkrWnifL/9+PMuBTGwP16kcDPRuis2e6A0nX7WtTBAraPBgdM9SrP8krgk
         +LvjFDZki1L7u0Ooy3hrykCIg/zzIXAm61cG6aNvJPxKgoP413OhLynWT7hE85Y2PJ
         Km97SuJkut8rSMQFLVOy7oDw3d9oovHeKTxjHudOqAECqziPmTtF/p08wlXZ3pQGXL
         8S2mnU+3NfMzw==
Date:   Fri, 28 Jan 2022 14:23:00 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Chandan Babu R <chandan.babu@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs: use vfs helper to update file attributes after
 fallocate
Message-ID: <20220128222300.GO13563@magnolia>
References: <164316352410.2600373.17669839881121774801.stgit@magnolia>
 <164316352961.2600373.9191916389107843284.stgit@magnolia>
 <87k0ekciiv.fsf@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0ekciiv.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 28, 2022 at 03:02:40PM +0530, Chandan Babu R wrote:
> On 26 Jan 2022 at 07:48, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > In XFS, we always update the inode change and modification time when any
> > preallocation operation succeeds.  Furthermore, as various fallocate
> > modes can change the file contents (extending EOF, punching holes,
> > zeroing things, shifting extents), we should drop file privileges like
> > suid just like we do for a regular write().  There's already a VFS
> > helper that figures all this out for us, so use that.
> >
> > The net effect of this is that we no longer drop suid/sgid if the caller
> > is root, but we also now drop file capabilities.
> >
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/xfs/xfs_file.c |   23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >
> >
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index 22ad207bedf4..eee5fb20cf8d 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -1057,13 +1057,28 @@ xfs_file_fallocate(
> >  		}
> >  	}
> >  
> > -	if (file->f_flags & O_DSYNC)
> > -		flags |= XFS_PREALLOC_SYNC;
> > -
> 
> Without the above change, if fallocate() is invoked with FALLOC_FL_PUNCH_HOLE,
> FALLOC_FL_COLLAPSE_RANGE or FALLOC_FL_INSERT_RANGE, we used to update inode's
> timestamp, remove setuid/setgid bits and then perform a synchronous
> transaction commit if O_DSYNC flag is set.
> 
> However, with this patch applied, the transaction (inside
> xfs_vn_update_time()) that updates file's inode contents (i.e. timestamps and
> setuid/setgid bits) is not synchronous and hence the O_DSYNC flag is not
> honored if the fallocate operation is one of FALLOC_FL_PUNCH_HOLE,
> FALLOC_FL_COLLAPSE_RANGE or FALLOC_FL_INSERT_RANGE.

Ah, right.  This bug is covered up by the changes in the last patch, but
it would break bisection, so I'll clean that up and resubmit.  Thanks
for the comments!

> > -	error = xfs_update_prealloc_flags(ip, flags);
> > +	/* Update [cm]time and drop file privileges like a regular write. */
> > +	error = file_modified(file);
> >  	if (error)
> >  		goto out_unlock;
> >  
> > +	/*
> > +	 * If we need to change the PREALLOC flag, do so.  We already updated
> > +	 * the timestamps and cleared the suid flags, so we don't need to do
> > +	 * that again.  This must be committed before the size change so that
> > +	 * we don't trim post-EOF preallocations.
> > +	 */

So the code ends up looking like:

	if (file->f_flags & O_DSYNC)
		flags |= XFS_PREALLOC_SYNC;
	if (flags) {
		flags |= XFS_PREALLOC_INVISIBLE;

		error = xfs_update_prealloc_flags(ip, flags);
		if (error)
			goto out_unlock;
	}

--D

> > +	if (flags) {
> > +		flags |= XFS_PREALLOC_INVISIBLE;
> > +
> > +		if (file->f_flags & O_DSYNC)
> > +			flags |= XFS_PREALLOC_SYNC;
> > +
> > +		error = xfs_update_prealloc_flags(ip, flags);
> > +		if (error)
> > +			goto out_unlock;
> > +	}
> > +
> >  	/* Change file size if needed */
> >  	if (new_size) {
> >  		struct iattr iattr;
> 
> -- 
> chandan
