Return-Path: <linux-fsdevel+bounces-58393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9F2B2E0E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 17:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9913B65601
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 15:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2314B32276A;
	Wed, 20 Aug 2025 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deLAxzjE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838B93218C0
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702980; cv=none; b=MP7OXBCmSKBx8iK0kE3BIF7JuVqJ53J/0YrhW9N3764r5Li0FRHxIrava7EOuN7RBVaXQ/aNkBZXZ0EEiat29+PolXz6YJiM5UnpCr0unoFCgiojKpk6vjABUcwcukJqT7yP6iK5CX8euWHrOkriToP7X5Qvphj4BoLnQbJ65ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702980; c=relaxed/simple;
	bh=t7TNgjvU/HZO0yVK4arfTwAt0t7yflV/PoKx5MHxdjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQtGW39kJ0fEQ8WxUWHCMugSuaAM8DGc/yZfNdvZttwc6Ihn79NCVGo5cgbTGieGCgMVZcHeoanWJRuLhad4Cjc2jXVPfMR0eBNS6T2iDSgi2rPjylMfyBDcya3oidLdc/UQZFUgb4frnL9K4eL+GdUpItNsOnzIiEoJpM2xNLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deLAxzjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B3EC4CEE7;
	Wed, 20 Aug 2025 15:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755702980;
	bh=t7TNgjvU/HZO0yVK4arfTwAt0t7yflV/PoKx5MHxdjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=deLAxzjEp1BXMlBpjbA542tSIl9H+B0ZAYPFhmWSb+6Cy7yKzQ4jgDNiZRTiN6oLO
	 iUMefgOcPRPjdalvtNdEREuBBXbcjdNkFF37hID2+yTXeOLXtqZHeg5Qu8n+0nacHA
	 DuUSgikAzo2GLurr5pBh8ic/0JivqbRJUXqdCKjfQV4Kug5p3D4JC7gcvjE1fQuN4c
	 yBY4Gk8LnimZcEJKkhLEOF+TlWgRXvpDFynSDyH9boiX0NqDr0MuMt+lnMk0Gk7+7k
	 MgGPHeOiZWv5MemGNkgZ9oxZanofYK0LQKjrh3V2fZNjX6iNuyLNaQXnwXdFKw01cR
	 HOKcxANZtkL8A==
Date: Wed, 20 Aug 2025 08:16:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
	bernd@bsbernd.com, joannelkoong@gmail.com
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
Message-ID: <20250820151619.GL7981@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449542.710975.4026114067817403606.stgit@frogsfrogsfrogs>
 <CAJfpegvwGw_y1rXZtmMf_8xJ9S6D7OUeN7YK-RU5mSaOtMciqA@mail.gmail.com>
 <20250818200155.GA7942@frogsfrogsfrogs>
 <CAJfpegtC4Ry0FeZb_13DJuTWWezFuqR=B8s=Y7GogLLj-=k4Sg@mail.gmail.com>
 <20250819225127.GI7981@frogsfrogsfrogs>
 <CAJfpegt38osEYbDYUP64+qY5j_y9EZBeYFixHgc=TDn=2n7D4w@mail.gmail.com>
 <CAJfpegv4RJqpFC0K5SVi6vhTMGpxrd672qbPE4zbe0nO-=2SqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv4RJqpFC0K5SVi6vhTMGpxrd672qbPE4zbe0nO-=2SqQ@mail.gmail.com>

On Wed, Aug 20, 2025 at 11:40:50AM +0200, Miklos Szeredi wrote:
> On Wed, 20 Aug 2025 at 11:16, Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> > As an optimization of the above, the filesystem clearing the
> > request_mask for these uncached attributes means that that attribute
> > is not supported by the filesystem and that *can* be cheaply cached
> > (e.g. clearing fi->inval_mask).
> 
> Even better: add sx_supported to fuse_init_out, so that unsupported
> ones don't generate unnecessary requests.

That would work better -- if the fuse server knows it'll never respond
to STX_SUBVOL then we could obliterate it from all the statx queries.

How does one add a new field to struct fuse_init_out without breaking
old libfuse / fuse servers which still have the old fuse_init_out?
AFAICT, fuse_send_init sets out_argvar, so fuse_copy_out_args will
handle a short reply from old libfuse.  But a new libfuse running on an
old kernel can't send the kernel what it will think is an oversized
init reply, right?

So I think we end up having to declare a new flags bit for struct
fuse_init_in, and the kernel sets the bit unconditionally.  libfuse
sends the larger fuse_init_out reply if the new flag bit is set, or the
old size if it isn't.  Does that sound correct?

--D

