Return-Path: <linux-fsdevel+bounces-25786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5029505C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 14:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7685C1F2197B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 12:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D88719AD6E;
	Tue, 13 Aug 2024 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I93K+48q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDDF19306B
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553965; cv=none; b=GOkAWef+K5utJTr8HShQwN9cRKUO2DC7GqZuK5CNw+yCMCjVs2vGcKJ73QbTZQnSWyHDL1jLE9xEL/5nX9fjjNSwayrCC7JkSLYrF9/Rk/ycE2SgPXj7/3pZi3NwBKZA+Apdxi0QcTdM5yL+PUC0N79qPvhvbY/Jg/3BzTCzWQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553965; c=relaxed/simple;
	bh=M5oDPd2Z1ASuoz5a1CiOka1SY4tGMRqJk+1ad4e4hvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYjSjpogl3rkoz2VvUc9yH44xfD1sBOLAsMYmIsqkqRcZAOq/0+spYjjsKSvYTVpePFIKCWKibSxFWlrh4DPcyiQyEOGRG1Lmel2CtW/pDjjwVxKQHjJeOfGIyYyORpCmlgYfGoycJ4345NR2nxAh6weNQaxmSW0oIK00qA4eAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I93K+48q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C19C4AF09;
	Tue, 13 Aug 2024 12:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723553965;
	bh=M5oDPd2Z1ASuoz5a1CiOka1SY4tGMRqJk+1ad4e4hvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I93K+48qIULeLmZghDD7aKueRyBFdQhWaOficc+c0m5DaPQ0iB5ZNBFqetYVKQMsp
	 gGAQjksUwE08TGbGt3dceXFJsbL9GXtCfL4f7BHNmcff6rBRr0g1MgYvnmGEbergNQ
	 6kxrC3uZ+Sft13tSIG6GaKazRZQV1bLLEcX1XB292p3J+dlt777DfshHrxfeIc1uvw
	 sujfL+oauJSNnp2q8M1y65GGSNzCUZqdx9zo+TlVRcE3fj8HxVR0NCEdEk6w3ZnSVU
	 KyGbawS7CUSeGHcY4WwVjZMHuFBIkuSO50z/WVhEJsvjv15yeorOyFQ3QIpAy7rZIk
	 1xPh6bc8JlFLA==
Date: Tue, 13 Aug 2024 14:59:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [DRAFT RFC]: file: reclaim 24 bytes from f_owner
Message-ID: <20240813-pathetisch-zahntechnik-4a20f57253b9@brauner>
References: <20240809-koriander-biobauer-6237cbc106f3@brauner>
 <20240809232140.GA13701@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240809232140.GA13701@ZenIV>

> One general note: IMO you are far too optimistic about the use of __cleanup
> extensions; it's _not_ something that we want blindly used all over
> the place.  In some cases it's fine, but I'm very nervous about the
> possibility of people starting to cargo-cult it all over the place.

I kept thinking about this a bit as I always value your input on such
design decisions. In general I'm very supportive of the cleanup stuff. I
know it has its warts and I know that some people really hate it. But I
think in general they are an improvement in a lot of scenarios
specifically in easing control-flow.

Do we run the risk of overuse? Certainly! Will we learn suprising new
facts about how broken they may be in some compiler versions? Most
likely. Will this mean that we will end up writing some helpers
differently so they're easier to use with all that new jazz? Probably.
But that's the case with a lot of new things we try.

I agree that here using the __free(kfree) annotations was too much but
mostly because it could all be done without relying on them. But here it
was really just about proving that the idea works so I took a lot of
stylistic liberties.

