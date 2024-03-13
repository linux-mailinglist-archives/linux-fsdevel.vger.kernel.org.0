Return-Path: <linux-fsdevel+bounces-14259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D090787A0DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 02:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9961B21284
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 01:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FD4BE5A;
	Wed, 13 Mar 2024 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXJiSAp0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA073BA27;
	Wed, 13 Mar 2024 01:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293718; cv=none; b=BZNl6sQ5BeT5cVrdHJGyrI0+8iT2OgUvLQlv/5g8idK8fqRfZnPGVnE+3rKlB7LJyOXqkDIb1HB2jEw3LGPkT4VME0gYbgJKNw5wBW0Cj4MShthy+RQlyYpOcerBVoV5OPcN3Ami1RjTaui7gwkbwyRd2lp72V23ZVsHFvdzLLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293718; c=relaxed/simple;
	bh=mozviQQ1a5r8AtM4acaROwzTWL20upkiONYs6QFn7g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jk3zXOiUDJNq++/N/lXH1HlNRAgWZtiTyaKTR966siBPWqfTNcE2MpgDlHV4mG+YwDNDOO885DTX0fV/PWj9DrKTEUNGd8p+hdbA8wppXY9u66IbsZilz7W02PrjHvYkUBJe5ZCqPRsx5GktwbzlqaFNt3uWlcuP8aGTtw7UxLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXJiSAp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994C0C433F1;
	Wed, 13 Mar 2024 01:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710293718;
	bh=mozviQQ1a5r8AtM4acaROwzTWL20upkiONYs6QFn7g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eXJiSAp0zfDotg1OyXu8TJTFOSnOuxRZd/qxvl9/OcgFBK0T1qKQ2BC8HN5hXqvk2
	 MhW8C7vPm88ydmjN2yYoSkN4zSuyaSvWH/fu/gzeaX8zSI+Ibax0car3kiuF4lwib9
	 Ei/X0XOomYh+HABNhPof0vGoxl1z0NitWzcHSLfIdmrUX5xKxrK317tMmNoEh4QICy
	 ZLwWlV+Q+82rbGgosaUMTSTutXKqVsYtSEtBcr7KhWyp2xTOmDtyurQj/gsg1Zgw/e
	 Gq5M0Bdw3yg8uazRQGzktKbqfQmOuhGyphGWs9V39uFgwPLalhwzOEOHAzfTAzao9e
	 Vqr8zw2MUq8uQ==
Date: Tue, 12 Mar 2024 18:35:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	ebiggers@kernel.org
Subject: Re: [PATCH v5 22/24] xfs: make scrub aware of verity dinode flag
Message-ID: <20240313013518.GI1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-24-aalbersh@redhat.com>
 <20240307221809.GA1927156@frogsfrogsfrogs>
 <iag66iabauxkow5z2cn275gjtbaycumf3u6lsyljzuascylbto@d23xbll7dx6n>
 <20240312163809.GF1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312163809.GF1927156@frogsfrogsfrogs>

On Tue, Mar 12, 2024 at 09:38:09AM -0700, Darrick J. Wong wrote:
> On Tue, Mar 12, 2024 at 01:10:06PM +0100, Andrey Albershteyn wrote:
> > On 2024-03-07 14:18:09, Darrick J. Wong wrote:
> > > On Mon, Mar 04, 2024 at 08:10:45PM +0100, Andrey Albershteyn wrote:
> > > > fs-verity adds new inode flag which causes scrub to fail as it is
> > > > not yet known.
> > > > 
> > > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > ---
> > > >  fs/xfs/scrub/attr.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
> > > > index 9a1f59f7b5a4..ae4227cb55ec 100644
> > > > --- a/fs/xfs/scrub/attr.c
> > > > +++ b/fs/xfs/scrub/attr.c
> > > > @@ -494,7 +494,7 @@ xchk_xattr_rec(
> > > >  	/* Retrieve the entry and check it. */
> > > >  	hash = be32_to_cpu(ent->hashval);
> > > >  	badflags = ~(XFS_ATTR_LOCAL | XFS_ATTR_ROOT | XFS_ATTR_SECURE |
> > > > -			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT);
> > > > +			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT | XFS_ATTR_VERITY);
> > > 
> > > Now that online repair can modify/discard/salvage broken xattr trees and
> > > is pretty close to merging, how can I make it invalidate all the incore
> > > merkle tree data after a repair?
> > > 
> > > --D
> > > 
> > 
> > I suppose dropping all the xattr XFS_ATTR_VERITY buffers associated
> > with an inode should do the job.
> 
> Oh!  Yes, xfs_verity_cache_drop would handle that nicely.

Here's today's branch, in which I implemented Eric's suggestions for the
"support block-based Merkle tree caching" patch, except for the ones
that conflict with the different direction I went in for
->read_merkle_tree_block; and implemented Dave's suggestions for
shrinker improvements:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity-cleanups-6.9_2024-03-12

--D

> --D
> 
> > -- 
> > - Andrey
> > 
> > 
> 

