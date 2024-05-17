Return-Path: <linux-fsdevel+bounces-19690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 037158C8AC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 19:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA2E1F25174
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 17:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BA413DBBE;
	Fri, 17 May 2024 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuLT3Isq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6AB13DB83;
	Fri, 17 May 2024 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966242; cv=none; b=Tf42k9D537g8GAee+x2PFjxrItVaJsIPiMzm1AP7wXFNEsuj4YyZIPJVqksRAOeU9Xk8I4IoMZhw/Vs4lGvLJw80lFsF89o0BporOzdGTDe0TuGvpyerr1VjFwjNc5Q/RkTLfmpq1RYLRn15lzYP7Ry7NC6OgV4tPXdp3BBNUIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966242; c=relaxed/simple;
	bh=kuXbjsBIjFBldlivZBrKJlUteBHLDKXPu1KqkN8bBgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPNewZs4Iwdqr+4K7l8CF5hqsZ89w9/4eqgkHMOnVmKQSgkEvS+nKzLynHuQ2jnR/XJFSH5bD0wMqiDc+G9U3LJxdXVqADeMMc7lHhproCkS1rSeHiTJ5IKAZcDRuNsGpttRjFAnjRQGMXvOJAhxpvTLC82BKAHyjD9Lx5dwruM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuLT3Isq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CB1C2BD10;
	Fri, 17 May 2024 17:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715966241;
	bh=kuXbjsBIjFBldlivZBrKJlUteBHLDKXPu1KqkN8bBgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MuLT3IsqZvlqm2U4XAeWdUsrV6RSwzdQLnMG7oJItAfDkVcWbNpYi6Br8igDt0UTy
	 kUh5BndYj0hs36GIGHiPV7leUEMRSTe8ZSQfm2JXRyJnTDkNudWUyMeBymdMzxQwTK
	 pUb+9VjyrJu+1n1guH6OFmR2aNIm26r1Y+inJTSdgsX5D3fr/XXmBfv6elT2/V8jBI
	 mJZi0CUrq54DxQVkQiAp9JtS/96aql79122Ciijg1dNNT/7ig3Eew8tz9kJYNBpU/8
	 6PADXedbAjONc408OGT186spxqusS6jC/OWlyOP+TWUFN3UaUiri+D49NQyUXguy6S
	 SZmZw2K6oFoug==
Date: Fri, 17 May 2024 10:17:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] xfs: use merkle tree offset as attr hash
Message-ID: <20240517171720.GA360919@frogsfrogsfrogs>
References: <171444680671.957659.2149857258719599236.stgit@frogsfrogsfrogs>
 <ZjHmzBRVc3HcyX7-@infradead.org>
 <ZjHt1pSy4FqGWAB6@infradead.org>
 <20240507212454.GX360919@frogsfrogsfrogs>
 <ZjtmVIST_ujh_ld6@infradead.org>
 <20240508202603.GC360919@frogsfrogsfrogs>
 <ZjxY_LbTOhv1i24m@infradead.org>
 <20240509200250.GQ360919@frogsfrogsfrogs>
 <Zj2r0Ewrn-MqNKwc@infradead.org>
 <Zj28oXB6leJGem-9@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj28oXB6leJGem-9@infradead.org>

On Thu, May 09, 2024 at 11:20:17PM -0700, Christoph Hellwig wrote:
> FYI, I spent some time looking over the core verity and ext4 code,
> and I can't find anything enforcing any kind of size limit.  Of course
> testing that is kinda hard without taking sparseness into account.
> 
> Eric, should fsverity or the fs backend check for a max size instead
> od trying to build the merkle tree and evnetually failing to write it
> out?
> 
> An interesting note I found in the ext4 code is:
> 
>   Note that the verity metadata *must* be encrypted when the file is,
>   since it contains hashes of the plaintext data.

Refresh my memory of fscrypt -- does it encrypt directory names, xattr
names, and xattr values too?  Or does it only do that to file data?

> While xfs doesn't currently support fscrypyt it would actually be very
> useful feature, so we're locking us into encrypting attrs or at least
> magic attr fork data if we do our own non-standard fsverity storage.
> I'm getting less and less happy with not just doing the normal post
> i_size storage.  Yes, it's not pretty (so isn't the whole fsverity idea
> of shoehorning the hashes into file systems not built for it), but it
> avoid adding tons of code and beeing very different.

And if we copy the ext4 method of putting the merkle data after eof and
loading it into the pagecache, how much of the generic fs/verity cleanup
patches do we really need?

--D

