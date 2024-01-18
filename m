Return-Path: <linux-fsdevel+bounces-8224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1D38311E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 04:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8CC1C21148
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 03:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A140B6132;
	Thu, 18 Jan 2024 03:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnf26cbb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F76D6104
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 03:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705549856; cv=none; b=Es6IPG6KgekI0YA+sJatbBecvazH42RlsXuxBFrBImzgmIyWbdfKdQSL1F5/RNcHGSErXDtmYtxPXAhHntWlTqfhTM2uU8XyYDhgg6zVdydbxt4FvOBY9RjmcmPHYZpixdeCchiEFfquy7qi64kpNhuzBSxu+4Mo08rRumNBizs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705549856; c=relaxed/simple;
	bh=K5Sr4Y7Sd/aOVnM7BwjskqtkzMGLyttgvv+UBZSu94E=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=HnIYIONLNtIs2WlfeRkLnBfLKb/EI6kEpEL4n2bt3bg/eqWfL7QRmoWI4eZp1C2DGqJmFj8apNLuymfVnOWSWjuU4Dcp6IsKLC5sYvBFcquZaVihG30LoauizyEkHwODdARMgBT/ZCJjAtcytNEKrO8rSGoqAGLm1NJSlsp//V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnf26cbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47580C433F1;
	Thu, 18 Jan 2024 03:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705549855;
	bh=K5Sr4Y7Sd/aOVnM7BwjskqtkzMGLyttgvv+UBZSu94E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnf26cbb/VL43U63jP3CE5r4CVevL6XjQmiXYgULSaVrfIzpnLxfylT8ukhcYyrBB
	 wrTak0wyMcewq4rQLq3Hfj3+pDHZ+HWY3znIRtR1Mo4vZiBn66I2nTF73Ji2eshLoN
	 IPlBhfu4aaI8QtmNMWiTib4aof+2B5Y6J1ry5OkXiQIh0RigYP/G5jnYyIqK8tBndm
	 USLfpkfyzNZm8QR8oZyRN7m6YB46nxsNgIBewCWbYikeURXwYopdUDv+ydXHZuk0xi
	 kLaC83Wk+vXWpkOfxYfI/di0f4Jdz9kZIGjSOACt7kTFmjjE7Jb+83osJXARBsqn/Y
	 Jt7+qX2fE8Ybw==
Date: Wed, 17 Jan 2024 19:50:53 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: tytso@mit.edu, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	jaegeuk@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] libfs: Attempt exact-match comparison first during
 casefold lookup
Message-ID: <20240118035053.GB1103@sol.localdomain>
References: <20240118004618.19707-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118004618.19707-1-krisman@suse.de>

On Wed, Jan 17, 2024 at 09:46:18PM -0300, Gabriel Krisman Bertazi wrote:
> Note that, for strict mode, generic_ci_d_compare used to reject an
> invalid UTF-8 string, which would now be considered valid if it
> exact-matches the disk-name.  But, if that is the case, the filesystem
> is corrupt.  More than that, it really doesn't matter in practice,
> because the name-under-lookup will have already been rejected by
> generic_ci_d_hash and we won't even get here.

Can you make the code comment explain this, please?

> +	/*
> +	 * Attempt a case-sensitive match first. It is cheaper and
> +	 * should cover most lookups, including all the sane
> +	 * applications that expect a case-sensitive filesystem.
> +	 */
> +	if (len == name->len && !memcmp(str, name->name, len))
> +		return 0;

Is the memcmp() safe, considering that the 'str' can be concurrently modified?

The default dentry name comparison uses dentry_string_cmp().  Would using
dentry_string_cmp() be a better choice here?

- Eric

