Return-Path: <linux-fsdevel+bounces-2588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A03267E6E11
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BC37B20C36
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EF020B10;
	Thu,  9 Nov 2023 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbgU+r2H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5396F208B7
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEF6C433C7;
	Thu,  9 Nov 2023 15:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699545190;
	bh=ZovLK9BokJIY/OQS9CQtqsBRidh5TwaxJTJA1U9svEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gbgU+r2HAN9ExKeV2bGRRtsBq+lW1iOMFTiJcD+B5KQp7NTxpRA3x1qvKFssL2HwC
	 nPnPhi+JLxkds6sKik+6D33yMMi8t3BTUbIKQIB7RhBgn2fQTozUtt3wFzspTepBsq
	 ixnvSxbE5Z5iBucAI89GRg1DIj+uBaC//2K1zcshkMi8ezuJ1L5QiLOCQFFOCCyTOa
	 LZ9O3S4i0fTBcMCYuIG71Xm6RF646rHfm77DLeroACtRHBNQO6ErDpe1tRNwPq/0a+
	 8lHuBRfd2s71J/kqL8BgSqtqekUCWPK3om8sS93AqeGPJHL439rk8MIWjaXjTLy81a
	 dvavEthr4a6GA==
Date: Thu, 9 Nov 2023 16:53:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/22] dentry_kill(): don't bother with retain_dentry()
 on slow path
Message-ID: <20231109-lager-oberwasser-268dae3e4e02@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-14-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-14-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:48AM +0000, Al Viro wrote:
> We have already checked it and dentry used to look not worthy
> of keeping.  The only hard obstacle to evicting dentry is
> non-zero refcount; everything else is advisory - e.g. memory
> pressure could evict any dentry found with refcount zero.
> On the slow path in dentry_kill() we had dropped and regained
> ->d_lock; we must recheck the refcount, but everything else
> is not worth bothering with.
> 
> Note that filesystem can not count upon ->d_delete() being
> called for dentry - not even once.  Again, memory pressure
> (as well as d_prune_aliases(), or attempted rmdir() of ancestor,
> or...) will not call ->d_delete() at all.
> 
> So from the correctness point of view we are fine doing the
> check only once.  And it makes things simpler down the road.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Ok, that again relies on earlier patches that ensure that dentry_kill()
isn't called with refcount == 0 afaiu,
Reviewed-by: Christian Brauner <brauner@kernel.org>

