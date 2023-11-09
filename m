Return-Path: <linux-fsdevel+bounces-2516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F337E6BD7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 14:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FFA5B20D1F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 13:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809481E526;
	Thu,  9 Nov 2023 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuTPf2zJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F31DFF2
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 13:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E00C433C7;
	Thu,  9 Nov 2023 13:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699538329;
	bh=BUwQrNpMiPucn2SfodQY95mZmaT/cDpj4vJUtTsjZL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IuTPf2zJhhdGJRRBGZlvLY2k0uT/30GYaT5FfiP6+/9NNd/Fg5SZnLmo9p+EXTaZ+
	 w87+s25ttYMigNSjCDGHAbaNWy6wGGru5kfG3PPutIOXQs+h8UblXPcL0qthy15Ei3
	 JXNS8Z1UcsafW2HwKwpgAAIgovfVRyyVeTsXm+746THNc0YSDEcVpP7JahuKHAbg1D
	 EftaZD9Dic7D2IutTYJ2ivaYWDzO3CaZiah6GOX86tt+kDYJep1Qng0FmKit1qUIyh
	 n6LiL/vtjO+77we6fqYPrl0x8wmBFZQsrBDiGiQJdKHfMruF6iLYwBs0hulMivB1pk
	 xT7QwOpI5Ws1Q==
Date: Thu, 9 Nov 2023 14:58:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/22] fast_dput(): having ->d_delete() is not reason to
 delay refcount decrement
Message-ID: <20231109-geduckt-nagen-eb34f88d9163@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-8-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-8-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:42AM +0000, Al Viro wrote:
> ->d_delete() is a way for filesystem to tell that dentry is not worth
> keeping cached.  It is not guaranteed to be called every time a dentry
> has refcount drop down to zero; it is not guaranteed to be called before
> dentry gets evicted.  In other words, it is not suitable for any kind
> of keeping track of dentry state.
> 
> None of the in-tree filesystems attempt to use it that way, fortunately.
> 
> So the contortions done by fast_dput() (as well as dentry_kill()) are
> not warranted.  fast_dput() certainly should treat having ->d_delete()
> instance as "can't assume we'll be keeping it", but that's not different
> from the way we treat e.g. DCACHE_DONTCACHE (which is rather similar
> to making ->d_delete() returns true when called).
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reasoning seems sane to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

