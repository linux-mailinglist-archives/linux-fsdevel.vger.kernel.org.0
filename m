Return-Path: <linux-fsdevel+bounces-14419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB4887C7AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 03:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60962829E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 02:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23DA944F;
	Fri, 15 Mar 2024 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClHy/pvM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA9E6119;
	Fri, 15 Mar 2024 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710470907; cv=none; b=XXOa1HJXREDCX7dhInYc5N1j+6X3NfsDyGrNZetHv0pe6JPtJ4gu+stq/ekkM42ofs+8OA6HuI0eSAFe3RI9QSOxVQkDdlu5Yi0fwCzfAvNYGDTdp4ztiy9Z0zyDyX0MEOSzwRhAimeM4L2hPKMPxoEvz/tt+CvbPPD072czZH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710470907; c=relaxed/simple;
	bh=vLuEhKukV2AosJU47Ar2L7Vg5bijeRK06wIesJ6eiw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGtzEXydcccRkNYdty8yDqKvh/m17PqSwDEtbVA+b7E4TKEJ8IJeK6+ccTeT44B7aMnSuCAY+/jL1IikGa2c3pz4APArchmSt7Tnsk5xsjwHHuHGL1VYJ3L96hs8+F+y5aDQMInX/cHLRQFTClib6rRZZDPvUQDaGyw1j4KOzOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClHy/pvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1287DC433C7;
	Fri, 15 Mar 2024 02:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710470907;
	bh=vLuEhKukV2AosJU47Ar2L7Vg5bijeRK06wIesJ6eiw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ClHy/pvMYOMBCPGtPbBPhborfE4MX43kvfN7bZhi9dQ//MI2aXwUxPw9FJ+N/1hC+
	 88eQxFJCZ8dwn8G4fCtdyn31AyI2cPbYDjmjpUwXThZMhKKKZlwCmzqR5Snn4xSLqY
	 AAMBHjnm7SpgSDvP44N9xDSgsQ9MOzaI+JsEqNef4s+crdoAWBLVXzubBQEd4vUts3
	 iJXTwb3bBp9myH3mW15EUOPMTyhs3OG5HsOsxrTGqtSBgRS/mrHatH2FrgslesNi7D
	 H+aIays+2En/AZWPdAYqKEYuDcW+HQvcIFVmdIBxIHhDUjeIULxk2uGWkJsE/Ksyf2
	 bLuc5we5kLaNA==
Date: Thu, 14 Mar 2024 19:48:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: david@fromorbit.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, chandan.babu@oracle.com
Subject: Re: [PATCH v2] xfs: allow cross-linking special files without
 project quota
Message-ID: <20240315024826.GA1927156@frogsfrogsfrogs>
References: <20240314170700.352845-3-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314170700.352845-3-aalbersh@redhat.com>

On Thu, Mar 14, 2024 at 06:07:02PM +0100, Andrey Albershteyn wrote:
> There's an issue that if special files is created before quota
> project is enabled, then it's not possible to link this file. This
> works fine for normal files. This happens because xfs_quota skips
> special files (no ioctls to set necessary flags). The check for
> having the same project ID for source and destination then fails as
> source file doesn't have any ID.
> 
> mkfs.xfs -f /dev/sda
> mount -o prjquota /dev/sda /mnt/test
> 
> mkdir /mnt/test/foo
> mkfifo /mnt/test/foo/fifo1
> 
> xfs_quota -xc "project -sp /mnt/test/foo 9" /mnt/test
> > Setting up project 9 (path /mnt/test/foo)...
> > xfs_quota: skipping special file /mnt/test/foo/fifo1
> > Processed 1 (/etc/projects and cmdline) paths for project 9 with recursion depth infinite (-1).
> 
> ln /mnt/test/foo/fifo1 /mnt/test/foo/fifo1_link
> > ln: failed to create hard link '/mnt/test/testdir/fifo1_link' => '/mnt/test/testdir/fifo1': Invalid cross-device link

Aha.  So hardlinking special files within a directory subtree that all
have the same nonzero project quota ID fails if that special file
happened to have been created before the subtree was assigned that pqid.
And there's nothing we can do about that, because there's no way to call
XFS_IOC_SETFSXATTR on a special file because opening those gets you a
different inode from the special block/fifo/chardev filesystem...

> mkfifo /mnt/test/foo/fifo2
> ln /mnt/test/foo/fifo2 /mnt/test/foo/fifo2_link
> 
> Fix this by allowing linking of special files to the project quota
> if special files doesn't have any ID set (ID = 0).

...and that's the workaround for this situation.  The project quota
accounting here will be weird because there will be (more) files in a
directory subtree than is reported by xfs_quota, but the subtree was
already messed up in that manner.

Question: Should we have a XFS_IOC_SETFSXATTRAT where we can pass in
relative directory paths and actually query/update special files?

> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_inode.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 1fd94958aa97..b7be19be0132 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -1240,8 +1240,19 @@ xfs_link(
>  	 */
>  	if (unlikely((tdp->i_diflags & XFS_DIFLAG_PROJINHERIT) &&
>  		     tdp->i_projid != sip->i_projid)) {
> -		error = -EXDEV;
> -		goto error_return;
> +		/*
> +		 * Project quota setup skips special files which can
> +		 * leave inodes in a PROJINHERIT directory without a
> +		 * project ID set. We need to allow links to be made
> +		 * to these "project-less" inodes because userspace
> +		 * expects them to succeed after project ID setup,
> +		 * but everything else should be rejected.
> +		 */
> +		if (!special_file(VFS_I(sip)->i_mode) ||
> +		    sip->i_projid != 0) {
> +			error = -EXDEV;
> +			goto error_return;
> +		}
>  	}
>  
>  	if (!resblks) {
> -- 
> 2.42.0
> 
> 

