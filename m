Return-Path: <linux-fsdevel+bounces-17814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779198B27B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 19:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D7CB246E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 17:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ECD14EC5C;
	Thu, 25 Apr 2024 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpCaPtHp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3548114E2FA;
	Thu, 25 Apr 2024 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714067255; cv=none; b=G5NeiZzzIf6bLca52NwWq+BoviAfX+UawbR9uXCbcmpAGVFmxVJd6cszljgmxk02tK36OAElCzMDBy0J7bW+xgyp8uB/vYZEgsczwrB3jaE0gqHDfr6iyiYV4u2e1p3r+2sGFhesPKgFUGtg1qNnq2ti3j152FJKnFVBHSbv0+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714067255; c=relaxed/simple;
	bh=BCcJL4EYGgNvGOmYP2zHLkNwqcWvBvq44rPg2J54MjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+1h3g5E6Z6JBA49MP2c2NzSlljCvJ4TTrh+DQJ+qZkJc2sv5x9AWYdg5SEPId1VFJaKYDz1EhR4j2rIX7YBVhIFUeFC0Th38E96ku+BMT0aaDkxvEE8hr4CIDIqAXODrkZrudqPDF/x24tAkbSdtYRy6eKDIkXU2TIamM6ikYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpCaPtHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9363C113CC;
	Thu, 25 Apr 2024 17:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714067254;
	bh=BCcJL4EYGgNvGOmYP2zHLkNwqcWvBvq44rPg2J54MjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JpCaPtHpcA9wnwNWxeBgTi2UfOmjEcDJD7emFgUmRckg1E0bVvYne5Kdt8ZHTdjxr
	 cEAbNpKw1TpsCo2jn8HuHrwhA7R8t+tuMq1FLisbxAbeN2wYxdjegc0XDenkPcLHlw
	 g49Jf9Rvqls+1eM9flBnsB9MkoGiXq2Rfx+vrJKH336ln4DZpXCdhuTqxajD7/A/DL
	 4YvSITqRDmdH6OSONWSRAqAJLGbeG6zpezCoh2cNgP9stxejVmNB2vNbX3XrVhAjxS
	 d+2q3ePXhbTE7gII29FWsvx5nW7Ghc8CzOscb0AZ0fNuOpK9a6CrK33nGrWWFf//Pr
	 zFb8BIs8ml19Q==
Date: Thu, 25 Apr 2024 10:47:32 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Christian Brauner <brauner@kernel.org>, amir73il@gmail.com,
	hu1.chen@intel.com, miklos@szeredi.hu, malini.bhandaru@intel.com,
	tim.c.chen@intel.com, mikko.ylinen@intel.com, lizhen.you@intel.com,
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v1 0/3] overlayfs: Optimize override/revert creds
Message-ID: <20240425174732.GA270911@dev-arch.thelio-3990X>
References: <20240403021808.309900-1-vinicius.gomes@intel.com>
 <20240424-befund-unantastbar-9b0154bec6e7@brauner>
 <87a5liy3le.fsf@intel.com>
 <20240425-nullnummer-pastinaken-c8cf2f7c41f3@brauner>
 <87y191wem5.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y191wem5.fsf@intel.com>

On Thu, Apr 25, 2024 at 10:12:34AM -0700, Vinicius Costa Gomes wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > On Wed, Apr 24, 2024 at 12:15:25PM -0700, Vinicius Costa Gomes wrote:
> >> I believe the crash and clang 17 compilation error point to the same
> >> problem, that in ovl_rename() some 'goto' skips the declaration of the
> >> (implicit) variable that the guard() macro generates. And it ends up
> >> doing a revert_creds_light() on garbage memory when ovl_rename()
> >> returns.
> >
> > If this is a compiler bug this warrants at least a comment in the commit
> > message because right now people will be wondering why that place
> > doesn't use a guard. Ideally we can just use guards everywhere though
> > and report this as a bug against clang, I think.
> >
> 
> I am seeing this like a bug/mising feature in gcc (at least in the
> version I was using), as clang (correctly) refuses to compile the buggy
> code (I agree with the error).

Indeed, your description of the issue and the fact clang refuses to
compile the problematic code makes me think that
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91951 is the relevant GCC
issue.

As an aside, just in case it comes up in the future, there is a
potential issue in clang's scope checking where it would attempt to
validate all labels in a function as potential destinations of 'asm
goto()' instances in that same function, rather than just the labels
that the 'asm goto()' could jump to, which can lead to false positive
errors about jumping past the initialization of a variable declared with
cleanup.

https://github.com/ClangBuiltLinux/linux/issues/1886
https://github.com/ClangBuiltLinux/linux/issues/2003

Cheers,
Nathan

