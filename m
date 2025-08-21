Return-Path: <linux-fsdevel+bounces-58700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 384FFB3092F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54FCC5868F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D380D2E173F;
	Thu, 21 Aug 2025 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtKafQ2l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCEC21765B
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755815292; cv=none; b=BWT9LUZ9GFfT1Y7FsAaD1zalV7VG3GhzXG4+jp+rpEE17zQRrAepxpL4UUv8FaGtGEzzFtWg+dkbMInmltiqiabCu4Rbj4T2FDYu2PNe/uQKuMVJAMnjMY4Jel/LMfspFJ1OBogvuuzi99o2sP1r38teV577pzkl4zwQkJICCuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755815292; c=relaxed/simple;
	bh=oZstoAzAW9KWaUp3r/p0Jl2hU6seXgOW0mmSmDTao9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrTJccBjTwfkDn0RdKV/8aL52Ghmo3CmPmaxa4hDr52Lo/UumOtLZ8P70y2hTX0+nbvhkHbqOpVN80fr0eDYS+kAe/1LE6zXwmuXnm8wZRHUhtyZCEZ2ItKfU5hcZyHaIBEAz1EwT9+qV9VXnxY9WAt3G0nb/AEyXTK1efRqkHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtKafQ2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B644DC4CEEB;
	Thu, 21 Aug 2025 22:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755815291;
	bh=oZstoAzAW9KWaUp3r/p0Jl2hU6seXgOW0mmSmDTao9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BtKafQ2lQKS1V72OWfRD8HhH1Rs64D77qgHTrnEoP/dS0gcwPGdNtZ3KNfWv2cWl2
	 ojqa1DEcEQElg/uH3PaWRslsAkWB+VwG1fYNLzqgF+PemIWi8Zmi7MkERdT39lQ8v9
	 jGjCF7+wnMxBkcQsk32OzK5efbTSCxYyLI4wIJfI6aAeoeD/pJvHsy/4Sx+V5Fy9nD
	 0YGKEBMsE9lnTazbd/UYL1YVVXndJwttFUtByE1TFlP+k7TQeQGlkQWqsNRu+4kLEj
	 clbYhSMHCHFxTIDD3S3xd/YAubpqettD21dzI7Bwe7j4jVKRiuAqJd8ktji1KqPGw0
	 kYMG9w8rUjCuQ==
Date: Thu, 21 Aug 2025 15:28:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/7] fuse: enable FUSE_SYNCFS for all servers
Message-ID: <20250821222811.GQ7981@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708692.15537.2841393845132319610.stgit@frogsfrogsfrogs>
 <CAJnrk1Z3JpJM-hO7Hw9_KUN26PHLnoYdiw1BBNMTfwPGJKFiZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Z3JpJM-hO7Hw9_KUN26PHLnoYdiw1BBNMTfwPGJKFiZQ@mail.gmail.com>

On Thu, Aug 21, 2025 at 03:18:11PM -0700, Joanne Koong wrote:
> On Wed, Aug 20, 2025 at 5:52 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Turn on syncfs for all fuse servers so that the ones in the know can
> > flush cached intermediate data and logs to disk.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/inode.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> >
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 463879830ecf34..b05510799f93e1 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1814,6 +1814,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
> >                 if (!sb_set_blocksize(sb, ctx->blksize))
> >                         goto err;
> >  #endif
> > +               fc->sync_fs = 1;
> 
> AFAICT, this enables syncfs only for fuseblk servers. Is this what you
> intended?

I meant to say for all fuseblk servers, but TBH I can't see why you
wouldn't want to enable it for non-fuseblk servers too?

(Maybe I was being overly cautious ;))

--D

> 
> Thanks,
> Joanne
> >         } else {
> >                 sb->s_blocksize = PAGE_SIZE;
> >                 sb->s_blocksize_bits = PAGE_SHIFT;
> >

