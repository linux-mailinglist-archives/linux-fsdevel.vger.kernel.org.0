Return-Path: <linux-fsdevel+bounces-28905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7829703E0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 21:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7DA61F217F6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 19:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B74316086C;
	Sat,  7 Sep 2024 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpkBLZXx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68434F5FB;
	Sat,  7 Sep 2024 19:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725736084; cv=none; b=lVzYc6BArglb+7tRSK7OIadjXAe2T0VHAlAS6tEu6GUNpkDy6Xs2jQGSFX9QDcmGl/bQa8CQtEQAsh8QpKnwTzlNyNGxPqGeVqqbKHYiKgiVk0LVthV57HulfO+e6LWx91DkS4DeDEfyCtFhlPynGcaS+3Cbqpt4lewF6r09l6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725736084; c=relaxed/simple;
	bh=Yg//rdx+arO9wJzw0f1sSxjNdC4DVMoG2gicnEsq0lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoPJmOo714cIsNbghuz0NbO7j4nzJL0/y3+I5p5b8M12IP48g6cplOiZyTfxSIwvhSt5kFynrHji8NB+wBnH/cLn90asWmx200baFF2EMgja5tXDrAhbVW5LgHn1plwVQoBBYBY1PR2bZVgazhmwxFoLBY1oK2atsC81nNTrPQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpkBLZXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3120FC4CEC2;
	Sat,  7 Sep 2024 19:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725736084;
	bh=Yg//rdx+arO9wJzw0f1sSxjNdC4DVMoG2gicnEsq0lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GpkBLZXxZZHTlaq1Ic7h5XBLzxTfzkMitPX/nUkqsPaifFskl1h8J4VRMaQ9w1ZAk
	 KxF1db4nY2rMpJJlvnEW7DQb4VW4QVNAqtSdBmXqXoA4x0Ql2216cKKjL7GJord6H0
	 M7nOC73A0sc29NRqbNJS26ua5KfXl4qeus6oNzeszw7F9lcfLc4VXTpXRFSL9+xzO4
	 YuhmQ7KB/tfyq4wrM57Bzuf51fTxN5kGynwUPtEIaoK/hh6rcb1Y+Z9F8YUfnk8Wf8
	 LXW1vxQOqx+aIiI4kR8U4zYzqLOG0UYGnCRxU8MVH5OlVCKBpS4LZ+6LIGV8W9kLYC
	 rqyGZYhC0D1/w==
Date: Sat, 7 Sep 2024 15:08:03 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
Message-ID: <Ztykk5A0DbN9KK-7@kernel.org>
References: <2D4C95CA-3398-4962-AF14-672DEBADD3EE@oracle.com>
 <172566449714.4433.8514131910352531236@noble.neil.brown.name>
 <Ztxui0j8-naLrbhV@kernel.org>
 <3862AF9C-0FCA-4B54-A911-8D211090E0B4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3862AF9C-0FCA-4B54-A911-8D211090E0B4@oracle.com>

On Sat, Sep 07, 2024 at 04:09:33PM +0000, Chuck Lever III wrote:
> 
> > On Sep 7, 2024, at 11:17 AM, Mike Snitzer <snitzer@kernel.org> wrote:
> > 
> > Rather than have general concern for LOCALIO doing something wrong,
> > we'd do well to make sure there is proper test coverage for required
> > shutdown sequences (completely indepent of LOCALIO, maybe that already
> > exists?).
> 
> That is on the to-do list for the NFSD kdevops CI infrastructure,
> but unfortunately implementation has not been started yet.

Could be a good project for me to help with.  I'm on the fence between
kdevops and ktest, ideally I could come up with something that'd
easily hook into both test harnesses.

Supporting both would be simple if the new tests were added to a
popular testsuite that both can run (e.g. xfstests, or any other
separate nfs/nfsd testsuite you may have?).  Or is "NFSD kdevops CI"
itself what your tests be engineered with?

I can contribute anywhere, would just like to kill multiple birds when
doing so.

Thanks,
Mike

