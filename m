Return-Path: <linux-fsdevel+bounces-34775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF0D9C8948
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 12:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2287284B18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 11:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21851F9431;
	Thu, 14 Nov 2024 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRDgauV3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0621018C02F;
	Thu, 14 Nov 2024 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731585142; cv=none; b=lJJCuaPNAlc8cK7ye8aHp/RAPjFixPY96qhUqnceab4qCHVYeZdmVsFDd8bP1DiP1fTvviz920MwxeAaMh0GkWNhQ5KxtucZ2NsgmLE2tBkx7DqfCUy8/5qtU2xl7uP5QEOkbvs0RB8IKZe0b3FryKoqqAqc2Aq7k3MAnU5FSqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731585142; c=relaxed/simple;
	bh=RTr0wRD7ql1Cqa3uLPfajAtSV+I6Yew2tSlMWIOuaaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4g1gKE8qPyxbHni0vhrVJj1AhTOF8udGGVplLLKFgDOAdpcA595JqEm1ItyqBtTHdUwHqoEin9Fh5oYuqVBQtoY1qDheFrr47h02fYfIdSTLe/OFE7qlvzZ1lcSLLJwGVq8gQi6dljsAfCkksfIqc5uR7Nc8P+sNIDWLn1raAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRDgauV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048D8C4CECD;
	Thu, 14 Nov 2024 11:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731585139;
	bh=RTr0wRD7ql1Cqa3uLPfajAtSV+I6Yew2tSlMWIOuaaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZRDgauV3t+t8LUgpUmVx0d2abVLMjzpdbmodZ8kzjangc+EVTYRwh4kfrRISg6FxN
	 jEdTpTz60dLT2PG0FNiRjavTPnGiBjF5BsrJfDMFpk+juZhlHojrFVqa67yOmwT0II
	 PtxrPaUD3uzDUCWOAC9HkPp0rZO2oLisj1t7Bb7qRlwrynHoFcdJSgmKvRvK8qNW28
	 r3iyJ9Bq2yKvlmoDUUxREA7vAHXloJFSq4BczYJKekpWSULNFM9HL/0JZT6zpXVc4n
	 GFQa5RP3wYxfDfqcv4/iUYSSVaxMw3Zmz8IfuA0Hcx7mCqv3qLdIJXvKEh1pjsIWnG
	 Hd0rSs4cdZvJg==
Date: Thu, 14 Nov 2024 12:52:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH] ovl: pass an explicit reference of creators creds to
 callers
Message-ID: <20241114-unsitte-betrachen-5b19d4faffdd@brauner>
References: <20241114100536.628162-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241114100536.628162-1-amir73il@gmail.com>

On Thu, Nov 14, 2024 at 11:05:36AM +0100, Amir Goldstein wrote:
> ovl_setup_cred_for_create() decrements one refcount of new creds and
> ovl_revert_creds() in callers decrements the last refcount.
> 
> In preparation to revert_creds_light() back to caller creds, pass an
> explicit reference of the creators creds to the callers and drop the
> refcount explicitly in the callers after ovl_revert_creds().
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Miklos, Christian,
> 
> I was chasing a suspect memleak in revert_creds_light() patches.
> This fix is unrelated to memleak but I think it is needed for
> correctness anyway.
> 
> This applies in the middle of the series after adding the
> ovl_revert_creds() helper.

Ok, so you're moving the put_cred() on the cred_for_create creds into
the callers. Tbh, that patch alone here is very confusing because with
the last patch in your tree at 07532f7f8450 you're calling

old_cred = override_creds(override_cred);

which made it buggy. But I see in 3756f22061c2 this is fixed and
correctly uses

old_cred = override_creds_light(override_cred);

as expected. And together with that change your patch here makes perfect
sense. I don't want to complain too much but it would've been nice if
that was spelled out in the commit message. Would've spared me 30
minutes of staring at the code until I refreshed your branch. :)

Reviewed-by: Christian Brauner <brauner@kernel.org>

