Return-Path: <linux-fsdevel+bounces-73226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 432DED12A8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E0CE300DB19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 13:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1FC330339;
	Mon, 12 Jan 2026 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCF4mtiy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D26150097B
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222863; cv=none; b=g3srIv0Aqtxub3w2N9rjf7XS3EOmaDO4d+wWmcrJE1ADkVn9OSt5OGyD8YQqpDJPov/dhBjDefJaecBguvYvVkIjXidKxo2xEurID3bQzVm9wUYJlDUbA7k59rHRbnH44dPGxTbq/jyDJATpQEEGrkLirxids3fWEKBHQ4hDyAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222863; c=relaxed/simple;
	bh=b0w/0aBR/s5UMTeewdBfA0SEisJGyB4ic6hLbRwCAK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2Bg0HcKgVjM8pTzP78iGEqQzI/5HxKl4km2grgsAcveL5d72T4FjRAAwGmJD1HJUK+14xhqxFkEnN9U8fryIoeFc5gVZjC+4DeUaTQN7bODiqCBbpfls6ejJRmSrayAsiuSfpFhxkz5JV0sm6NJOWqnW7ZJlQTLv2Lt7ve6Ee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCF4mtiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72495C19422;
	Mon, 12 Jan 2026 13:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768222863;
	bh=b0w/0aBR/s5UMTeewdBfA0SEisJGyB4ic6hLbRwCAK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qCF4mtiyqAqLa08uKMz55walGRjrCajQm0NaJN2jOkMnZPRIcJhpLzgdHbZYxwUIw
	 Ac0cJQSYs8QysPKAT9AVY830XhWmgbV72x3L9+jfFGPF/0KiihlV4CmXzifdCKuuZS
	 MJLzGv2C05nPaJQAbM5GsZvBCYy3uiICTeGsc01ketaf/fPu066tSosPjWn/trTY6v
	 d7mzQs9fp7iQiBuWZoEv8+jgcda1I6u2nEUpcT5/Z6vuxtWqRZ0Vmcuxhh5kYEoAOs
	 WZn07YyvYXAIjyQXvtshhrRCudhd+rof5Z3a32ek/sPL3nPPSbi4H6cKg7a+Tw6sOi
	 U5tYAJyKtEBGA==
Date: Mon, 12 Jan 2026 14:00:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/2] mount: add OPEN_TREE_NAMESPACE
Message-ID: <20260112-unbeugsam-erbrachten-b86991c19851@brauner>
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
 <20251229-work-empty-namespace-v1-1-bfb24c7b061f@kernel.org>
 <2026-01-07-oldest-grim-captions-spills-ywC2O3@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026-01-07-oldest-grim-captions-spills-ywC2O3@cyphar.com>

> I think there are a few other things I would really like (with my runc
> hat on), such as being able to move_mount(2) into this new kind of
> OPEN_TREE_NAMESPACE handle.

As you know I have outlined multiple ways how we can do it on-list and
then again in Tokyo. There's a ToDo item I'm going to get to soon.
Around end of November someone asked about related changes again. I have
the beginnings for that in a branch. I just need to get to it but I need
to catch up with the list first...

> However, on the whole I think this seems very reasonable and is much
> simpler than I anticipated when we talked about this at LPC. I've just
> taken a general look but feel free to take my
> 
> Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
> 
> and also maybe a
> 
> Suggested-by: Aleksa Sarai <cyphar@cyphar.com>
> 
> If you feel it's appropriate, since we came up with this together at
> LPC? ;)

Eh, well, this rubs me the wrong way a little bit, I have to say. The
idea was basically just "what if we had an empty mount namespace" which
doesn't really work without other work I mentioned there. So to me this
was basically a fragment thrown around that I then turned into the
open_tree() idea that I explained later and which is rather different.
So adding a "Suggested-by" for that kinda makes it sound like I was the
code monkey which I very much disagree with. But I'll give us both a
Suggested-by line which should solve this nicely.

