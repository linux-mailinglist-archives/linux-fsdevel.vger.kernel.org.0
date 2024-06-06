Return-Path: <linux-fsdevel+bounces-21136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32508FF7DE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 00:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1791F2303A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 22:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211E313E041;
	Thu,  6 Jun 2024 22:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWzImHRb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D02B13DDAD;
	Thu,  6 Jun 2024 22:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717714497; cv=none; b=euTb2emacBrl355YMMZevQwQdAv6tEJtW5nsR/2nVNePGPg9VbWpbP3tDszzUBTdJXK+nCs0+r0DoL/3yUAuO2KBZVZn1mNS7EuszSGWFT7tLtJSGNQH0i99IrelobegUCKkbV8muzS7cw4kILfW3vg5pFTGDohStVYd60XGyo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717714497; c=relaxed/simple;
	bh=Bzghvltxq1MRcY+oGehXBRSsz9rM21ZFVK/y+dmeIEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfLApbDVlZpqNevo9x1AShmgg1qefoi3OG35eADg8Sb4W030FOvefEpPBIiVdsE07P3+yGEVtTsdF2kZ3t/ie360LTmM1B9KmjwIHYF+pCDoXCB9kqa2/IKqmVgEmPt9p9lO8kIJGAwDEi82cuEgAPQCaOMjmZTlPjJB+RljT9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWzImHRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303C7C4AF08;
	Thu,  6 Jun 2024 22:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717714497;
	bh=Bzghvltxq1MRcY+oGehXBRSsz9rM21ZFVK/y+dmeIEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWzImHRb5mezFeKRbhID2aHf5Wk6kSepJ+7wId+axGmCKG4lmhfCE1ce6Gl4vExE5
	 gFzZGd8MPmwMIxOk7NtjJvYGr7TW6iSGZLood2A74xAiuNC3DAKgMHjV5YCidZRF9L
	 2hbANF5evlj2nM3ven1nmpNi2CMCQCdQ6M3dA637Nwy6ky1zISEVx+YMn71tPXbJ6F
	 WZ95RrhTd7aTBO/IMyZQE9mkfDsD16Xh+zkyEVQtpn1lqT581kWg8ytUN2hCRqe//R
	 jxCsvucnXWpgRj24tZcXlhxeKYtx1Eb5SKAiQRDUCIzTW5PQnu7E74ghqbugVyBOCX
	 f2F+01yE4Uybw==
Date: Thu, 6 Jun 2024 15:54:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <20240606225456.GP52987@frogsfrogsfrogs>
References: <xne47dpalyqpstasgoepi4repm44b6g6rsntk2ln3aqhn4putw@4cen74g6453o>
 <20240524161101.yyqacjob42qjcbnb@quack3>
 <20240531145204.GJ52987@frogsfrogsfrogs>
 <20240603104259.gii7lfz2fg7lyrcw@quack3>
 <vbiskxttukwzhjoiic6toscqc6b2qekuwumfpzqp5vkxf6l6ia@pby5fjhlobrb>
 <20240603174259.GB52987@frogsfrogsfrogs>
 <20240604085843.q6qtmtitgefioj5m@quack3>
 <20240605003756.GH52987@frogsfrogsfrogs>
 <CAOQ4uxiVVL+9DEn9iJuWRixVNFKJchJHBB8otH8PjuC+j8ii4g@mail.gmail.com>
 <ZmEemh4++vMEwLNg@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmEemh4++vMEwLNg@dread.disaster.area>

On Thu, Jun 06, 2024 at 12:27:38PM +1000, Dave Chinner wrote:
> On Wed, Jun 05, 2024 at 08:13:15AM +0300, Amir Goldstein wrote:
> > On Wed, Jun 5, 2024 at 3:38 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > On Tue, Jun 04, 2024 at 10:58:43AM +0200, Jan Kara wrote:
> > > > On Mon 03-06-24 10:42:59, Darrick J. Wong wrote:
> > > > > I do -- allowing unpriviledged users to create symlinks that consume
> > > > > icount (and possibly bcount) in the root project breaks the entire
> > > > > enforcement mechanism.  That's not the way that project quota has worked
> > > > > on xfs and it would be quite rude to nullify the PROJINHERIT flag bit
> > > > > only for these special cases.
> > > >
> > > > OK, fair enough. I though someone will hate this. I'd just like to
> > > > understand one thing: Owner of the inode can change the project ID to 0
> > > > anyway so project quotas are more like a cooperative space tracking scheme
> > > > anyway. If you want to escape it, you can. So what are you exactly worried
> > > > about? Is it the container usecase where from within the user namespace you
> > > > cannot change project IDs?
> > >
> > > Yep.
> > >
> > > > Anyway I just wanted to have an explicit decision that the simple solution
> > > > is not good enough before we go the more complex route ;).
> > >
> > > Also, every now and then someone comes along and half-proposes making it
> > > so that non-root cannot change project ids anymore.  Maybe some day that
> > > will succeed.
> > >
> > 
> > I'd just like to point out that the purpose of the project quotas feature
> > as I understand it, is to apply quotas to subtrees, where container storage
> > is a very common private case of project subtree.
> 
> That is the most modern use case, yes.
> 
> [ And for a walk down history lane.... ]

Could you take all your institutional knowledge and paste it into a
Documentation/ file that we can use as a starting point for what exactly
does the project quota design do, please?  I'm betting the other two
filesystems that implement it (ext4/f2fs) don't quite implement the same
behaviors.

--D

> > The purpose is NOT to create a "project" of random files in random
> > paths.
> 
> This is *exactly* the original use case that project quotas were
> designed for back on Irix in the early 1990s and is the original
> behaviour project quotas brought to Linux.
> 
> Project quota inheritance didn't come along until 2005:
> 
> commit 65f1866a3a8e512d43795c116bfef262e703b789
> Author: Nathan Scott <nathans@sgi.com>
> Date:   Fri Jun 3 06:04:22 2005 +0000
> 
>     Add support for project quota inheritance, a merge of Glens changes.
>     Merge of xfs-linux-melb:xfs-kern:22806a by kenmcd.
> 
> And full support for directory tree quotas using project IDs wasn't
> fully introduced until a year later in 2006:
> 
> commit 4aef4de4d04bcc36a1461c100eb940c162fd5ee6
> Author: Nathan Scott <nathans@sgi.com>
> Date:   Tue May 30 15:54:53 2006 +0000
> 
>     statvfs component of directory/project quota support, code originally by Glen.
>     Merge of xfs-linux-melb:xfs-kern:26105a by kenmcd.
> 
> These changes were largely done for an SGI NAS product that allowed
> us to create one great big XFS filesystem and then create
> arbitrarily sized, thin provisoned  "NFS volumes"  as directory
> quota controlled subdirs instantenously. The directory tree quota
> defined the size of the volume, and so we could also grow and shrink
> them instantenously, too. And we could remove them instantenously
> via background garbage collection after the export was removed and
> the user had been told it had been destroyed.
> 
> So that was the original use case for directory tree quotas on XFS -
> providing scalable, fast management of "thin" storage for a NAS
> product. Projects quotas had been used for accounting random
> colections of files for over a decade before this directory quota
> construct was created, and the "modern" container use cases for
> directory quotas didn't come along until almost a decade after this
> capability was added.
> 
> > My point is that changing the project id of a non-dir child to be different
> > from the project id of its parent is a pretty rare use case (I think?).
> 
> Not if you are using project quotas as they were originally intended
> to be used.
> 
> > If changing the projid of non-dir is needed for moving it to a
> > different subtree,
> > we could allow renameat2(2) of non-dir with no hardlinks to implicitly
> > change its
> > inherited project id or explicitly with a flag for a hardlink, e.g.:
> > renameat2(olddirfd, name, newdirfd, name, RENAME_NEW_PROJID).
> 
> Why?
> 
> The only reason XFS returns -EXDEV to rename across project IDs is
> because nobody wanted to spend the time to work out how to do the
> quota accounting of the metadata changed in the rename operation
> accurately. So for that rare case (not something that would happen
> on the NAS product) we returned -EXDEV to trigger the mv command to
> copy the file to the destination and then unlink the source instead,
> thereby handling all the quota accounting correctly.
> 
> IOWs, this whole "-EXDEV on rename across parent project quota
> boundaries" is an implementation detail and nothing more.
> Filesystems that implement project quotas and the directory tree
> sub-variant don't need to behave like this if they can accurately
> account for the quota ID changes during an atomic rename operation.
> If that's too hard, then the fallback is to return -EXDEV and let
> userspace do it the slow way which will always acocunt the resource
> usage correctly to the individual projects.
> 
> Hence I think we should just fix the XFS kernel behaviour to do the
> right thing in this special file case rather than return -EXDEV and
> then forget about the rest of it. Sure, update xfs_repair to fix the
> special file project id issue if it trips over it, but other than
> that I don't think we need anything more. If fixing it requires new
> syscalls and tools, then that's much harder to backport to old
> kernels and distros than just backporting a couple of small XFS
> kernel patches...
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

