Return-Path: <linux-fsdevel+bounces-35372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A939D44D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 01:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06F9281FDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 00:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4FF1C28E;
	Thu, 21 Nov 2024 00:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MgTLeOZ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA04846C;
	Thu, 21 Nov 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732147837; cv=none; b=XVLahBy2ka2kfcaLWIkFRcO9NVAQ5mZPcoemPJw7mGN/qUaCfZoB0Mp7ETz2bB45MIQQKvV+fXOMIZCJRv8MNT2nqW9JIpkWwRanWY0kYg9ahSrEEb/aJd9PXE4mm1q0lSg/dhSnfyMMLUH9HJwBfir7G0eNcXcu71nqsOQoru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732147837; c=relaxed/simple;
	bh=ib64hTV/S9sfhLEnicNuXT07IKzScNUMPYYtcgzyQbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMH7XCrMfxRVszyce/ZoE19nI4QGh5nX7dp8UgBB3/VrjwDcX3V+XPI1GCmZi2tk/DsrECsl9WWACxjRNTrHU/XfoHlHGQ4AyBmjNDwtcEQQyw6CWqProJBBJtcUmLySD+S1TqTxU1QcB6ylbd6l6peZazyiPey6lIQGkCl7JlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MgTLeOZ1; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Nov 2024 19:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732147833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BvGUvvPHTEAKOGb7P1+ozrjOYaiPmM61awo8yb0kUNQ=;
	b=MgTLeOZ1bUIQKcLSwzg9uruYdttWJBlwp+C6jyewYEuqOyMv5gbq0l6qVvO3fFDfJCR1Gc
	R0aLrn08Z/EtKE7Vpn8PLyc47HfCrMCcgWJA3gFWmN7IN4T2yBRNccOQsLtPxhgyVJfWE6
	nHQagbk95P0kS4ON7fKgRqJ93Lsopxg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Michal Hocko <mhocko@suse.com>, 
	Dave Chinner <david@fromorbit.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "conduct@kernel.org" <conduct@kernel.org>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <3ij22qnqpndxyckrdreswyxjaan3zudzdkv62vjeeytsep5bmz@5el2tljyx7wc>
References: <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
 <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
 <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
 <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
 <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
 <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
 <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>
 <v2ur4jcqvjc4cqdbllij5gh6inlsxp3vmyswyhhjiv6m6nerxq@mrekyulqghv2>
 <20241120234759.GA3707860@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120234759.GA3707860@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 20, 2024 at 03:47:59PM -0800, Theodore Ts'o wrote:
> On Wed, Nov 20, 2024 at 05:55:03PM -0500, Kent Overstreet wrote:
> > Shuah, would you be willing to entertain the notion of modifying your...
> 
> Kent, I'd like to gently remind you that Shuah is not speaking in her
> personal capacity, but as a representative of the Code of Conduct
> Committee[1], as she has noted in her signature.  The Code of Conduct
> Committee is appointed by, and reports to, the TAB[2], which is an
> elected body composed of kernel developers and maintainers.
> 
> [1] https://www.kernel.org/code-of-conduct.html
> [2] https://www.kernel.org/doc/html/latest/process/code-of-conduct-interpretation.html
> 
> Speaking purely in a personal capacity, and not as a member of the TAB
> (although I do serve as vice-chair of that body) I am extremely
> grateful of the work of Shuah and her colleages (listed in [1]).  I
> believe that their work is important in terms of establishing guard
> rails regarding the minimum standards of behavior in our community.
> 
> If you look at the git history of the kernel sources, you will see
> that a large number of your fellow maintainers assented to this
> approach --- for example by providing their Acked-by in commit
> 1279dbeed36f ("Code of Conduct Interpretation: Add document explaining
> how the Code of Conduct is to be interpreted").

And Ted, I don't think you realize just how at my limit I am here with
what I'm willing to put up with.

I'm coming off of, what, 6+ months of getting roasted and having my work
quested by Linus every pull request (and he did stop that, but not
before it had done real damage, both completely changing the tone of
public conversations and nearly scaring off people I've been trying to
hire).

It's gotten harder and harder, not easier, for me to get work done in
other parts of the kernel; I gave up long ago in the block layer after
the two people in charge there had repeatedly introduced silent data
corruption bugs into core block layer code that I'd written, without
CCing me, which I then had to debug, which they then ignored or put up
ridiculous fights over when reported, and now have turned petty on
subsequent block layer patches.

Filesystem people have been good to work with, thank god, but now
getting anything done in mm is looking like more and more of what the
block layer has turned into.

And you guys, because the system works for you, keep saying "nah,
everything is fine and this has already been decided, you don't get any
say".

Meanwhile, I'm seeing more and more heisenbugs in the rest of the kernel
as I'm stabilizing bcachefs, and my users are reporting the same - in
compaction, in the block layer, now in the scheduler or locking, I'm not
sure on the last one.

And I'm sitting here wondering how the hell I'm supposed to debug my own
code when I don't even have a stable base to work on anymore.

This is turning into an utter farce.

