Return-Path: <linux-fsdevel+bounces-30042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ADD98555F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 10:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3FC282375
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 08:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A05715921D;
	Wed, 25 Sep 2024 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAs/myGn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90D0157472;
	Wed, 25 Sep 2024 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727252467; cv=none; b=TE43pXMsgl3SXzftcj/RENyy/8aclwK4C0cLgHdmH6jCGwxwKXjEeH0oiW2f5y23U8ogNj77xQSvlGBEkmqv9b+5m2obXmZYgvxS04ddU3ndsNhAShDPJgKuGg7aM3iGT4h7oYki7+rHh8/YAOxop/PqNUQDTUUhz+uytULDfLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727252467; c=relaxed/simple;
	bh=QmYF9mAYJQbgVS85AxdTvM5CXVsN5gmmSJw9tjqbUUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ud6QSTbjPF1/6ML4FNIC0qghHeSEkCHD0bYWg/0xAbkKmRhh5kqHgp1MCwjqH0rWz11aI5K+ej6yN3OBBx8QN2MhTRplyAX8S7eIvonatr7Id8f94/cmT5gsnSuscTQhpVszdAYuusEyVWwg0LqNs0aWTJCkdb6lCf/piIcdX58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAs/myGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E56CC4CEC3;
	Wed, 25 Sep 2024 08:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727252467;
	bh=QmYF9mAYJQbgVS85AxdTvM5CXVsN5gmmSJw9tjqbUUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAs/myGnly3ulviILdxBQVG/60wM9VhcYM9KSZEuS1TIRL6Af1SE+SLwblC6kzUHE
	 fF2I9G7uVY54lJhg9IfNbKtrD1tJ6qwVFVtZl0NNeC63EimzlCoe4W5FUUlC5dPLU9
	 /GW2jKJKMfjsST6lF/fuDWnzNuou1aNh+tiJe4VgIhCqgSxIw46+iw2zv94sRgAiZY
	 lcaMsTZEH+Xr/8QWcZOEIcWeEkHkoTZWzXOWK3tQhMGu03YSLl8qSHznOS79J2bM1V
	 a3JoRl+sShxzrGyxs7r88cE7bsIn8dxBxYDS4D+Ki8RjqNAUrcEBk/zLsZhekvfB9K
	 IogryK75bdPdw==
Date: Wed, 25 Sep 2024 10:21:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Hongbo Li <lihongbo22@huawei.com>, tytso@mit.edu, 
	adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, chris.zjh@huawei.com
Subject: Re: [PATCH v2] fs: ext4: support relative path for `journal_path` in
 mount option.
Message-ID: <20240925-jungtier-dagewesen-0040c64576a9@brauner>
References: <20240925015624.3817878-1-lihongbo22@huawei.com>
 <20240925075105.lnssx7gcgfh5s743@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240925075105.lnssx7gcgfh5s743@quack3>

On Wed, Sep 25, 2024 at 09:51:05AM GMT, Jan Kara wrote:
> On Wed 25-09-24 09:56:24, Hongbo Li wrote:
> > The `fs_lookup_param` did not consider the relative path for
> > block device. When we mount ext4 with `journal_path` option using
> > relative path, `param->dirfd` was not set which will cause mounting
> > error.
> > 
> > This can be reproduced easily like this:
> > 
> > mke2fs -F -O journal_dev $JOURNAL_DEV -b 4096 100M
> > mkfs.ext4 -F -J device=$JOURNAL_DEV -b 4096 $FS_DEV
> > cd /dev; mount -t ext4 -o journal_path=`basename $JOURNAL_DEV` $FS_DEV $MNT
> > 
> > Fixes: 461c3af045d3 ("ext4: Change handle_mount_opt() to use fs_parameter")
> > Suggested-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> > ---
> > v2:
> >   - Change the journal_path parameter as string not bdev, and
> >     determine the relative path situation inside fs_lookup_param.
> >   - Add Suggested-by.
> > 
> > v1: https://lore.kernel.org/all/20240527-mahlen-packung-3fe035ab390d@brauner/
> > ---
> >  fs/ext4/super.c | 4 ++--
> >  fs/fs_parser.c  | 3 +++
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 16a4ce704460..cd23536ce46e 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -1744,7 +1744,7 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
> >  	fsparam_u32	("min_batch_time",	Opt_min_batch_time),
> >  	fsparam_u32	("max_batch_time",	Opt_max_batch_time),
> >  	fsparam_u32	("journal_dev",		Opt_journal_dev),
> > -	fsparam_bdev	("journal_path",	Opt_journal_path),
> > +	fsparam_string	("journal_path",	Opt_journal_path),
> 
> Why did you change this? As far as I can see the only effect would be that
> empty path will not be allowed (which makes sense) but that seems like an
> independent change which would deserve a comment in the changelog? Or am I
> missing something?

I'll drop the ext4 bit as that can be done independently drop the
conditional.

