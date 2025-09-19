Return-Path: <linux-fsdevel+bounces-62252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2B4B8ACC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 19:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88C11C26C37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 17:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE60322A19;
	Fri, 19 Sep 2025 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDRO1lXY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4523218C8;
	Fri, 19 Sep 2025 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303828; cv=none; b=L1sq14zwiEg6E1/yEhnbSR2zqlMXfzjZfgAimFE/Sh8AZ9ykBX1a/GECh6D0DoB0IlzUxF/Xh4p/tsXAKUlXtU/a6cKsniOszv4C/fALMz3f9Oas+pXsOV6zdmdjwR7ErxHdF5DmyDm5EnEBhLTEibletxbUrOtiIArjBl1XlWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303828; c=relaxed/simple;
	bh=bqgyIdxjXD+QIUZqOSV6a+jb9kGwtRcGAEPm8yadJiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3Ck4hAlcbciDdaNP1T6vN0c8GSj78l1haT2J6SmV9Z4OY50jO4Rmgo+VJCYpKqDd0KHNuMCXRWld8vxvbnJYw1YLKINfB73p9gzoHjOwk6rko1ozCCvVs3F3y70KUawqsihgJbSXEuuzQ7ve6QhQOExi+Gt60Ofv/e2JQIZcqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDRO1lXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E30C4CEF0;
	Fri, 19 Sep 2025 17:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758303828;
	bh=bqgyIdxjXD+QIUZqOSV6a+jb9kGwtRcGAEPm8yadJiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDRO1lXYclTwrCe7pS8+pHkp/F7GNVPCfQkNcMy//ouaoq9MN7YFwMG6XdTEzo/35
	 0r1EXs6bh2jwKYKV6prKY6c4BLl0omriIJ1qGS+cXd0b2IR4lA+pAz3bZBxLGpg5DA
	 BfpT8MLECPUZcKjuhO1zKzAu/8h9tm4mVeTihKdB1v5/BxPRcFwsBOGpK4h+EB4g3b
	 BCThC9+kxlNN5fsGqn0aGzbTxJh9RDTCm6CRe2WJsE9Oq3D55EJIF/rdOXVXVNsAnX
	 PjCCFpXBrDIHVAoUcVe1nBYYNAkZqlALPT5qQWkWNSijhHkV//G4fa6+BzVnwTNeP0
	 iegogrihDPNQQ==
Date: Fri, 19 Sep 2025 10:43:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, bernd@bsbernd.com,
	linux-xfs@vger.kernel.org, John@groves.net,
	linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	joannelkoong@gmail.com
Subject: Re: [PATCH 3/5] fuse: move the passthrough-specific code back to
 passthrough.c
Message-ID: <20250919174347.GF8117@frogsfrogsfrogs>
References: <175798150680.382479.9087542564560468560.stgit@frogsfrogsfrogs>
 <175798150773.382479.13993075040890328659.stgit@frogsfrogsfrogs>
 <CAOQ4uxigBL4pCDXjRYX0ftCMyQibRPuRJP7+KhC7Jr=yEM=DUw@mail.gmail.com>
 <20250918180226.GZ8117@frogsfrogsfrogs>
 <CAJfpegsN32gJohjiqdqKqLqwnu7BOchfqrjJEKVo33M1gMgmgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsN32gJohjiqdqKqLqwnu7BOchfqrjJEKVo33M1gMgmgg@mail.gmail.com>

On Fri, Sep 19, 2025 at 09:34:06AM +0200, Miklos Szeredi wrote:
> On Thu, 18 Sept 2025 at 20:02, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Sep 17, 2025 at 04:47:19AM +0200, Amir Goldstein wrote:
> 
> > > I think at this point in time FUSE_PASSTHROUGH and
> > > FUSE_IOMAP should be mutually exclusive and
> > > fuse_backing_ops could be set at fc level.
> > > If we want to move them for per fuse_backing later
> > > we can always do that when the use cases and tests arrive.
> >
> > With Miklos' ok I'll constrain fuse not to allow passthrough and iomap
> > files on the same filesystem, but as it is now there's no technical
> > reason to make it so that they can't coexist.
> 
> Is there a good reason to add the restriction?   If restricting it
> doesn't simplify anything or even makes it more complex, then I'd opt
> for leaving it more general, even if it doesn't seem to make sense.

I don't have a good reason to add a restriction; it's entirely Amir's
concern about testing the two together.

--D

> Thanks,
> Miklos

