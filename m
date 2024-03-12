Return-Path: <linux-fsdevel+bounces-14223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4029487991E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 17:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710651C21D7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 16:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E717E117;
	Tue, 12 Mar 2024 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFXQ1qG+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707B615BF;
	Tue, 12 Mar 2024 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261490; cv=none; b=rklIFKuXjTIQQYnXfR38lxQBml7tTP17JYvbgPoySzMgb+JZegEoBNWA0uMGGkF/0cw4Gx0G5kUEv1gjkNL5dxriVT5faJprEAmxyOAHXC3Gymunte8LkIDdlqPJFRbjRVx6oh15zurOLZb5mE4yOTiW8IzjVwOUg9i/Cs42QYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261490; c=relaxed/simple;
	bh=B6ZUyeqO9XfV0ZY2luWJpItaxzGBN3tHZK5wVq+gwqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgJvnAJ1vMvXXup+PDSMmetig0mYdPX/mMnxGC173sP15DU0G/OVatlFUFhY4jnHX3kV7Sbmbkthd9RdiDzVmM86/58QM0eCLLEzTcJTdYv4HYPs/wh9aeeZd0LKTzF9A+ofUp3k30A3prFJzeAcTqTHCIgH0xd0geFRK06V9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFXQ1qG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98B7C433C7;
	Tue, 12 Mar 2024 16:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710261490;
	bh=B6ZUyeqO9XfV0ZY2luWJpItaxzGBN3tHZK5wVq+gwqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aFXQ1qG+TQ3XsNBbF/+UW1liLGn1Oz24Mq7QtQDKmTdcEvzV5RdSQPxaKp9wAZTAC
	 D/JHQ6CR7TtvaHhO65des0LXg7SNxAARNxgRAdBAc/aT+3tmNHxK455D4th8UuN2So
	 dsVFTV1p3bXezT2Vr4g1ZzeYDCtOAgqhxH82UcN2GQHDMARq236B7CSF77vo5EWT6y
	 boaeGgdRs/91G5kC6AS/IJLWp9sotjWBSZ2osEjt3XjMxYVoQcUhiAHdrXehmQUdaI
	 fTjhBcXaYoRwAGKiQlsdrfmZsWw/B2tzIyn8Pqf4QrhryIR5a8kt888E5ZcHj2w+Pa
	 WlTiRt9RUSG0g==
Date: Tue, 12 Mar 2024 09:38:09 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	ebiggers@kernel.org
Subject: Re: [PATCH v5 22/24] xfs: make scrub aware of verity dinode flag
Message-ID: <20240312163809.GF1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-24-aalbersh@redhat.com>
 <20240307221809.GA1927156@frogsfrogsfrogs>
 <iag66iabauxkow5z2cn275gjtbaycumf3u6lsyljzuascylbto@d23xbll7dx6n>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iag66iabauxkow5z2cn275gjtbaycumf3u6lsyljzuascylbto@d23xbll7dx6n>

On Tue, Mar 12, 2024 at 01:10:06PM +0100, Andrey Albershteyn wrote:
> On 2024-03-07 14:18:09, Darrick J. Wong wrote:
> > On Mon, Mar 04, 2024 at 08:10:45PM +0100, Andrey Albershteyn wrote:
> > > fs-verity adds new inode flag which causes scrub to fail as it is
> > > not yet known.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >  fs/xfs/scrub/attr.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
> > > index 9a1f59f7b5a4..ae4227cb55ec 100644
> > > --- a/fs/xfs/scrub/attr.c
> > > +++ b/fs/xfs/scrub/attr.c
> > > @@ -494,7 +494,7 @@ xchk_xattr_rec(
> > >  	/* Retrieve the entry and check it. */
> > >  	hash = be32_to_cpu(ent->hashval);
> > >  	badflags = ~(XFS_ATTR_LOCAL | XFS_ATTR_ROOT | XFS_ATTR_SECURE |
> > > -			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT);
> > > +			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT | XFS_ATTR_VERITY);
> > 
> > Now that online repair can modify/discard/salvage broken xattr trees and
> > is pretty close to merging, how can I make it invalidate all the incore
> > merkle tree data after a repair?
> > 
> > --D
> > 
> 
> I suppose dropping all the xattr XFS_ATTR_VERITY buffers associated
> with an inode should do the job.

Oh!  Yes, xfs_verity_cache_drop would handle that nicely.

--D

> -- 
> - Andrey
> 
> 

