Return-Path: <linux-fsdevel+bounces-28062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37788966565
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 17:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE02E1F251AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43B91B5EA2;
	Fri, 30 Aug 2024 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHadyWyn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242A3EACD;
	Fri, 30 Aug 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031609; cv=none; b=a36Ca15eBWfmfkPpYDBpmfIyKNHimkH0+kPXwEp0POTsqN54ouMc3x69jyB1GX5Ac5gkL8ow1Q2m5BDmZkkq6n81osEGnN6L88e0ac+Y3hPOxY640IHBqSIrG4QsHHBzB+IsVYMihsjf1EwCxhyotQrTAzcNb/nA0VbUu1UaIiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031609; c=relaxed/simple;
	bh=J0mPR+VW0Y6u0fxLb3eD+gu7vmEOkEYsR8GhSlx6/hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJE65WgulL3dhrp38M9z2ChBuZ8PaywJM5Mub728DSn8BHXN+ZYBlzFSZ6eeA2F3ttd8QbvOdaybfAWjg8XBb2hlQbli6Dl2R3bYsYHiUfZgYbRGEpVTMaAzZUgdFcQJWOMKI2um4pt53YCt5gq8ko2kaG9B591QsFiCHQQBB2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHadyWyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4B3C4CEC2;
	Fri, 30 Aug 2024 15:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725031608;
	bh=J0mPR+VW0Y6u0fxLb3eD+gu7vmEOkEYsR8GhSlx6/hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tHadyWynpBuA2wxOEKHJ/ao2N1vhVavyWR5bkd3PexLJ1n8+uv4/tJjfLo8uluHt6
	 YzFJpV+aWC0MXw/rL1isPdUYpOKJ+gi3/ugaZq3RBMwmqctgvMdx59LzByBnFnrq3L
	 y/rxnw7643ELQrv0agtAQCQaq6bO0BZufZKMpA3afh57E1fDUxZsblXkZUwf7WUDzZ
	 kpB9N5+meldL0EGc7y2xAza7plbnpdMt2YARsPumibxw6xXFfn5iKpn9cwsgRyHFl8
	 6DS4khO/YrRvnzDlGlKvWOmmpnJGzzPTZUldQzwBtoymELjY7Bn5SXa429ASO397JT
	 DosHSgrBbYNtA==
Date: Fri, 30 Aug 2024 08:26:48 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Haifeng Xu <haifeng.xu@shopee.com>, Jeff Layton <jlayton@kernel.org>,
	Theodore Tso <tytso@mit.edu>, miklos@szeredi.hu,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Ext4 <linux-ext4@vger.kernel.org>,
	fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH v2] ovl: don't set the superblock's errseq_t manually
Message-ID: <20240830152648.GE6216@frogsfrogsfrogs>
References: <CAOQ4uxi4B8JHYHF=yn6OrRZCdkoPUj3-+PuZTZy6iJR7RNWcbA@mail.gmail.com>
 <20240730042008.395716-1-haifeng.xu@shopee.com>
 <CAOQ4uxhs==_-EM+VyJRRCX_NPmYybPDBW2v7cXz33Qt2RMaPnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhs==_-EM+VyJRRCX_NPmYybPDBW2v7cXz33Qt2RMaPnQ@mail.gmail.com>

On Fri, Aug 30, 2024 at 03:27:35PM +0200, Amir Goldstein wrote:
> On Tue, Jul 30, 2024 at 6:20 AM Haifeng Xu <haifeng.xu@shopee.com> wrote:
> >
> > Since commit 5679897eb104 ("vfs: make sync_filesystem return errors from
> > ->sync_fs"), the return value from sync_fs callback can be seen in
> > sync_filesystem(). Thus the errseq_set opreation can be removed here.
> >
> > Depends-on: commit 5679897eb104 ("vfs: make sync_filesystem return errors from ->sync_fs")
> > Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> > Changes since v1:
> > - Add Depends-on and Reviewed-by tags.
> > ---
> >  fs/overlayfs/super.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index 06a231970cb5..fe511192f83c 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -202,15 +202,9 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
> >         int ret;
> >
> >         ret = ovl_sync_status(ofs);
> > -       /*
> > -        * We have to always set the err, because the return value isn't
> > -        * checked in syncfs, and instead indirectly return an error via
> > -        * the sb's writeback errseq, which VFS inspects after this call.
> > -        */
> > -       if (ret < 0) {
> > -               errseq_set(&sb->s_wb_err, -EIO);
> > +
> > +       if (ret < 0)
> >                 return -EIO;
> > -       }
> >
> >         if (!ret)
> >                 return ret;
> > --
> > 2.25.1
> >
> 
> FYI, this change is queued in overlayfs-next.
> 
> However, I went to see if overlayfs has test coverage for this and it does not.
> 
> The test coverage added by Darrick to the mentioned vfs commit is test xfs/546,
> so it does not run on other fs, although it is quite generic.
> 
> I fixed this test so it could run on overlayfs (like this):
> # This command is complicated a bit because in the case of overlayfs the
> # syncfs fd needs to be opened before shutdown and it is different from the
> # shutdown fd, so we cannot use the _scratch_shutdown() helper.
> # Filter out xfs_io output of active fds.
> $XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f
> ' -c close -c syncfs $SCRATCH_MNT | \
>         grep -vF '[00'
> 
> and it passes on both xfs and overlayfs (over xfs), but if I try to
> make it "generic"
> it fails on ext4, which explicitly allows syncfs after shutdown:
> 
>         if (unlikely(ext4_forced_shutdown(sb)))
>                 return 0;
> 
> Ted, Darrick,
> 
> Do you have any insight as to why this ext4 behavior differs from xfs
> or another idea how to exercise the syncfs error in a generic test?
> 
> I could fork an overlay/* test from the xfs/* test and require that
> underlying fs is xfs, but that would be ugly.
> 
> Any ideas?

That should be:

	if (unlikely(ext4_forced_shutdown(sb)))
		return -EIO;

no?  The fs is dead and cannot persist anything, so we should fling that
back to the calling program.

--D

> Thanks,
> Amir.
> 

