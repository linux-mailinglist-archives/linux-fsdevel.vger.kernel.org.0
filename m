Return-Path: <linux-fsdevel+bounces-9710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8DA8447FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 20:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC67B28F131
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA0F3E479;
	Wed, 31 Jan 2024 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItolqjVg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C93A3AC16;
	Wed, 31 Jan 2024 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706729419; cv=none; b=gcBe2qP6Is42LMuNOBdfxUCXWRPu6zE9XTup4F1X1fLCSc2PcAcHxvdEFodgb1YPocU2X3oBK8yYWPozbuBLAoB8ciqOzP27BAY153vWJFDWgaNujaEHcxXLVEo7V35S9lroovEJEpx/dc1mOFtKWNDFISz98NzBkJpVglILh8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706729419; c=relaxed/simple;
	bh=px1JHDxvYgaqdqX1O1QaMV2nEJp1uUOqTXYJiymsmaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTb4/S2EINAKzWwtTk3zaDLDhu1217eiB+nnfn/2ns+0rwk8SY66h8o8gzDR4q6slut4LD4czGDXhpnTJdSxB6NxQfQXbYmabCbebF3L5EEDWdyUeTqzlZehEynxZDALdm5cyxdKkLW4vXZbLAKw2xZnicXEc4Lf9OpYItQ3qUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItolqjVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D13C433F1;
	Wed, 31 Jan 2024 19:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706729419;
	bh=px1JHDxvYgaqdqX1O1QaMV2nEJp1uUOqTXYJiymsmaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ItolqjVgwglYj31Ca6mDM6p2ozImVC+LtWcPDDkyVKBDKwzFt5gLCmruFrZ1vUJXG
	 2Bbps40yxME37saBhyVegbVNCv9VpEK6nqQgx4z0lsgxwizD1K1ehibL2DU+CwD7/2
	 HEiYW0Ktag6e49GhStNIDb8EAsfVeW72we3GdOXZQpXBhEY1G6tAJuPiKDlB2x0t8r
	 V5JAjbxNKPWEJs5cHwBLgIehZDunnSzeFYht8lUFgNW3lPLrSoCDadiyS6w64Rl7ff
	 54GMvaSQ3yBwvR53Kgbwg6I9/1uj51zpq1rgw/6ACA37Wz9N0KslGCymjzrflLiXVs
	 t7vrK38JxFiog==
Date: Wed, 31 Jan 2024 11:30:18 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: david@fromorbit.com, bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, raven@themaw.net, rcu@vger.kernel.org
Subject: Re: About the conflict between XFS inode recycle and VFS rcu-walk
Message-ID: <20240131193018.GN1371843@frogsfrogsfrogs>
References: <ZXJf6C0V1znU+ngP@dread.disaster.area>
 <20240131063517.1812354-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131063517.1812354-1-alexjlzheng@tencent.com>

On Wed, Jan 31, 2024 at 02:35:17PM +0800, Jinliang Zheng wrote:
> On Fri, 8 Dec 2023 11:14:32 +1100, david@fromorbit.com wrote:
> > On Tue, Dec 05, 2023 at 07:38:33PM +0800, alexjlzheng@gmail.com wrote:
> > > Hi, all
> > > 
> > > I would like to ask if the conflict between xfs inode recycle and vfs rcu-walk
> > > which can lead to null pointer references has been resolved?
> > > 
> > > I browsed through emails about the following patches and their discussions:
> > > - https://lore.kernel.org/linux-xfs/20220217172518.3842951-2-bfoster@redhat.com/
> > > - https://lore.kernel.org/linux-xfs/20220121142454.1994916-1-bfoster@redhat.com/
> > > - https://lore.kernel.org/linux-xfs/164180589176.86426.501271559065590169.stgit@mickey.themaw.net/
> > > 
> > > And then came to the conclusion that this problem has not been solved, am I
> > > right? Did I miss some patch that could solve this problem?
> > 
> > We fixed the known problems this caused by turning off the VFS
> > functionality that the rcu pathwalks kept tripping over. See commit
> > 7b7820b83f23 ("xfs: don't expose internal symlink metadata buffers to
> > the vfs").
> 
> Sorry for the delay.
> 
> The problem I encountered in the production environment was that during the
> rcu walk process the ->get_link() pointer was NULL, which caused a crash.
> 
> As far as I know, commit 7b7820b83f23 ("xfs: don't expose internal symlink
> metadata buffers to the vfs") first appeared in:
> - https://lore.kernel.org/linux-fsdevel/YZvvP9RFXi3%2FjX0q@bfoster/
> 
> Does this commit solve the problem of NULL ->get_link()? And how?

I suggest reading the call stack from wherever the VFS enters the XFS
readlink code.  If you have a reliable reproducer, then apply this patch
to your kernel (you haven't mentioned which one it is) and see if the
bad dereference goes away.

--D

> > 
> > Apart from that issue, I'm not aware of any other issues that the
> > XFS inode recycling directly exposes.
> > 
> > > According to my understanding, the essence of this problem is that XFS reuses
> > > the inode evicted by VFS, but VFS rcu-walk assumes that this will not happen.
> > 
> > It assumes that the inode will not change identity during the RCU
> > grace period after the inode has been evicted from cache. We can
> > safely reinstantiate an evicted inode without waiting for an RCU
> > grace period as long as it is the same inode with the same content
> > and same state.
> > 
> > Problems *may* arise when we unlink the inode, then evict it, then a
> > new file is created and the old slab cache memory address is used
> > for the new inode. I describe the issue here:
> > 
> > https://lore.kernel.org/linux-xfs/20220118232547.GD59729@dread.disaster.area/
> 
> And judging from the relevant emails, the main reason why ->get_link() is set
> to NULL should be the lack of synchronize_rcu() before xfs_reinit_inode() when
> the inode is chosen to be reused.
> 
> However, perhaps due to performance reasons, this solution has not been merged
> for a long time. How is it now? 
> 
> Maybe I am missing something in the threads of mail?
> 
> Thank you very much. :)
> Jinliang Zheng
> 
> > 
> > That said, we have exactly zero evidence that this is actually a
> > problem in production systems. We did get systems tripping over the
> > symlink issue, but there's no evidence that the
> > unlink->close->open(O_CREAT) issues are manifesting in the wild and
> > hence there hasn't been any particular urgency to address it.
> > 
> > > Are there any recommended workarounds until an elegant and efficient solution
> > > can be proposed? After all, causing a crash is extremely unacceptable in a
> > > production environment.
> > 
> > What crashes are you seeing in your production environment?
> > 
> > -Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
> 

