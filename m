Return-Path: <linux-fsdevel+bounces-63010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F703BA8B50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5544189F5D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9C52C2358;
	Mon, 29 Sep 2025 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQlwnpfd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C328152D;
	Mon, 29 Sep 2025 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138952; cv=none; b=jQJDK+qPsDWV5qweW8qUGsWrF+P5Xx5IA/1+xa4M5WPO2+qfZ9FkZfWbSiCA4+ozPh79QoCIGf2eTZunxrkwUKhcds5x5cNqtF4G2hdSoQDi/Jysv9eKQ3+xt6GZvZYMWLzmxwDJq/GGpoWDQYVsNiRJOyVW2GKs4sYQlC3Cu8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138952; c=relaxed/simple;
	bh=Qv26ICdLq9U5gcfQfCKC9j2lUk9PpPgh4O9mv/QG1wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZ31F2VafEDf52DzrM4hRaoanOwXNeuNs5h0nw7/tMlgSr6P/E+2gHBcWinQnrZDFdaPDMwTjTQjQXhY+yofeAy82/TWFtF7BqLtMIMv6SLGO8P1A9ucR/v4KuC4bDkMK0pBdxlPDaUm3JxFSZOFvr46Ahq/sew2nIxBbX7D4P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQlwnpfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C743C4CEF4;
	Mon, 29 Sep 2025 09:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759138951;
	bh=Qv26ICdLq9U5gcfQfCKC9j2lUk9PpPgh4O9mv/QG1wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQlwnpfdR3rthr61jm4Q1E5+ktiBLlgutLJFirTeN0S7+/VvcCF/S29B9RhngDJ9z
	 dI1jKYSJuJ3nnx/0fZTVkVmvGsOgnOVvMjei+cnZM70LRMyflxbC86TKe2owy8ld1P
	 aQP1DmWj/YPlABnQFoy2g6tPan1GKLfu52RqhvQPHvDYT11zWRaZzA+cUtx4TFbvst
	 1qKOp/e5eUBIotdyDGSD5fnoQLM8zCdI1W9moFEypdidnMKsrZh8bhQpOo/jOtovYm
	 WOGydD6irJlbi3ET6uvjP2QCbDie3N9Y4o9Oc8Y87Dhzo0TyEM1jKAvyUE9YUWjCpU
	 7mpv74mxu1VPA==
Date: Mon, 29 Sep 2025 11:42:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: next-20250924: Internal error: Oops: mnt_ns_release
 (fs/namespace.c:148) __arm64_sys_listmount (fs/namespace.c:5936)
Message-ID: <20250929-heldenhaft-kosenamen-fa3be48edae0@brauner>
References: <CA+G9fYueO8kP8mXVNmbHkyrFPKpt-onPfeyNXLuLGGjiO1WFfQ@mail.gmail.com>
 <20250926064801.GE39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250926064801.GE39973@ZenIV>

On Fri, Sep 26, 2025 at 07:48:01AM +0100, Al Viro wrote:
> On Fri, Sep 26, 2025 at 12:00:08AM +0530, Naresh Kamboju wrote:
> 
> [snip]
> 
> With 59bfb6681680 "listmount: don't call path_put() under namespace semaphore"
> we get this:
> 
> static void __free_klistmount_free(const struct klistmount *kls)
> {
> 	path_put(&kls->root);
> 	kvfree(kls->kmnt_ids);
> 	mnt_ns_release(kls->ns);
> }
> 
> ...
> 
> SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
> 		u64 __user *, mnt_ids, size_t, nr_mnt_ids, unsigned int, flags)
> {
> 	struct klistmount kls __free(klistmount_free) = {};
> 	const size_t maxcount = 1000000;
> 	struct mnt_id_req kreq;
> 	ssize_t ret;
> 		   
> 	if (flags & ~LISTMOUNT_REVERSE)
> 		return -EINVAL;
> 
> which will oops if it takes that failure exit - if you are initializing
> something with any kind of cleanup on it, you'd better make sure
> the cleanup will survive being called for the initial value...
> 
> Christian, that's your branch and I don't want to play with rebasing
> it - had it been mine, the fix would be folded into commit in question,
> with the rest of the branch cherry-picked on top of fixed commit,
> but everyone got their own preferences in how to do such stuff.
> 
> Minimal fix would be to make mnt_ns_release(NULL) a no-op.
> 
> BTW, I suspect that one of the sources of confusion had been the fact that
> __free(mnt_ns_release) *does* treat NULL as no-op; in statmount(2) you
> are using that and get away with NULL as initializer.  In listmount(2)),
> OTOH, you are dealing with the function call - same identifier, different
> behaviour...

Ah, fuck me. Thanks for spotting that! I'll take care of it.

