Return-Path: <linux-fsdevel+bounces-60175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3668B426DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 18:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967851897C0A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 16:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA032E5429;
	Wed,  3 Sep 2025 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS883tnO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEAC2D63E4
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916860; cv=none; b=t6TAD0ELj8hwbw2Wx/cep2tn7AdvG/7Jl+x2YYfRdj3kfvlx/PPBw4kTalJCAaJZiDRig9Wuh1C/ah3O1KKlW6x2jBXKCX5sqjHv/OfSRByE4TGTTJDtuFtZWIo+hlTrYpIQDdX98M05UkyZ7rX7kTN5B+Z7y9Tv+42zdV0NtQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916860; c=relaxed/simple;
	bh=OH3nW+PjC3lZosIYqWoSXG6PUKEEzgo0VxFFrTfyR7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s64kSQTjCbatRT420I9v1k/BoWjVkzHvc659oUEfM3WeHjAKaJJNZr3qJwDD9lhvkjkebN8D0QejD0vtpiBs91dZe9AmfDL9psjLzDV62ASnv6d/38m5tnob8Hva3qLa9UwK93jqVQN5l+y+nj9IyKxvelfnwvBOdSWpzrek6GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS883tnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6B3C4CEE7;
	Wed,  3 Sep 2025 16:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756916859;
	bh=OH3nW+PjC3lZosIYqWoSXG6PUKEEzgo0VxFFrTfyR7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IS883tnOAI7hGXa6MbCmKHVGel7MsUG86Syi5yLZ4s7cEG6PV2AR2s953hELSf1Fn
	 nqh+ZYlxD13xfzzgAs45vG73AUHCrSfyIgugbuUPU1E+1KITbaxpUnwfX0zuyiyCc/
	 370g1mfhqdGHfsyed7M25iBCubjtn4iO3N2O1KnFfD2uMkiHDp3KWTF0HWUSM2hDMa
	 2aoZbKb1B20eTVFnT8Ke2Yz3xPriI/P2KdJg/H2MXWoUgwqaLcteCqILnFdkjddDqD
	 7v3CFTpEo/BR713ZNnx1fX6ZHoEmPOjNTUJ/Dxis6mHsZw1TTncOQauMBFVF/Pqdh+
	 dt9ltlrLmiO6A==
Date: Wed, 3 Sep 2025 09:27:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Subject: Re: [PATCH 6/7] fuse: propagate default and file acls on creation
Message-ID: <20250903162739.GM8117@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708671.15537.10523102978043581580.stgit@frogsfrogsfrogs>
 <CAJfpegvmXnZc=nC4UGw5Gya2cAr-kR0s=WNecnMhdTM_mGyuUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvmXnZc=nC4UGw5Gya2cAr-kR0s=WNecnMhdTM_mGyuUg@mail.gmail.com>

On Wed, Sep 03, 2025 at 06:15:30PM +0200, Miklos Szeredi wrote:
> On Thu, 21 Aug 2025 at 02:52, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Propagate the default and file access ACLs to new children when creating
> > them, just like the other kernel filesystems.
> 
> Another problem of this and the previous patch is being racy.  Not
> "real" filesystems like fuse2fs, but this is going to trip network fs
> up badly, where such races would be really difficult to test.

Ahh, right -- I neglected that the fuse interface is more or less what
you'd need for a client node of a network/cluster filesystem.

> We could add a new feature flag, but we seem to have proliferation of
> this sort.  We have default_permissions, then handle_killpriv, then
> handle_killpriv_v2.  Seems like we need a flag to tell the kernel to
> treat this as a local fs, where it can do all the local fs'y things
> without fear of breaking remote fs.
> 
> Does that make sense?

Yeah.

How about I hide the functionality of this ACL patch and the previous
one behind (fc->iomap || sb->s_bdev != NULL)?  The iomap functionality
that I'm working on is only useful for filesystems that want to behave
like a local fs, including all the "I went out to lunch DoS" warts.
AFAICT the other fuse developers seem to accept that fuseblk servers can
do that too.  Does that sound ok?

If anyone ever wanted to use fuse+iomap for a cluster fs, I guess I'd
have to go back to issuing FUSE_READ/WRITE requests to userspace for
permission checking and resource acquisition.  But so far no cluster
filesystems use fs/iomap/ so it's just unsupported.

(And to make this explicit to anyone watching on the list -- all of my
work is completely separate from Joanne's efforts to adapt fuse to use
iomap for tracking pagecache dirty state.)

--D

> Thanks,
> Miklos

