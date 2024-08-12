Return-Path: <linux-fsdevel+bounces-25661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C36E294E9D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 11:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC651F22491
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 09:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B80C16D9C7;
	Mon, 12 Aug 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOTmfMC1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01B01876
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455032; cv=none; b=fCwM4ZjXKnJTxIiBviFOdYBbpfO+BQkL54mi8+MM0yfsZlPOZUypidjiprpO62Q0/jcNbrUG+xiXa0lZdjGTUBVfc4M0ezNnDO2sxLmYighB4g7v4YVTNShZm208Xn6TlO9Fe18DXTtaeGuGGqdI5bF65ZBzrq54tigrJ77O2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455032; c=relaxed/simple;
	bh=Ac8IPtFjK8lLZIB6FLKD0wwO6tir6zgXcW8VFHCgPtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ra9j+Uy+FUEbCzs1Ex1BMEJr+BDQ5yXx0IlEOFsB2XVQyLSJgzBOtMo10dkLbz907I9SFQEasJsMQuDWCcsB4oDFA1tb3IeeGFnkWh3klBNs6SY8akGuDN9UL1hdCgBMtWokm1Frs+EBdJKLQQSfZPRWJTscDapEKnizTFxkHo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOTmfMC1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A211C4AF10;
	Mon, 12 Aug 2024 09:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723455032;
	bh=Ac8IPtFjK8lLZIB6FLKD0wwO6tir6zgXcW8VFHCgPtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tOTmfMC1uWS0ok8X5P20hjY0CsheZ8VPHZ4H9YHL5RM+6CCkPzlLJZvpXdizrHM6Q
	 Lwy1V7w0BeDacuUxF7w8ZjcXNzBSLwiUS8jZ7z4K758LaxQynFyXZNsbb4j0DNY+uu
	 9spb+s9oBkd2kpIaBKTwyzuyBxLcvo9Sm68RFhHhyPqi3fFqkJHGhzQbqZASnGgMDw
	 J0IrZERaqwNd3g5Q4ZET13FyUocgWShixh4Kn3uc3XFxNwsEtH8LS3qGnHj1n+hg+X
	 yZYuo6TsXhKnRNn4otIKUK0zq6neDAk0UctANgkugxVM/ek7W0I1XW6zJdZMMHNUE5
	 pSX+Dl65AKHyw==
Date: Mon, 12 Aug 2024 11:30:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/11] sane_fdtable_size(): don't bother looking at
 descriptors we are not going to copy
Message-ID: <20240812-ausbilden-hinreichend-135feb7b9efc@brauner>
References: <20240812064214.GH13701@ZenIV>
 <20240812064427.240190-1-viro@zeniv.linux.org.uk>
 <20240812064427.240190-6-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240812064427.240190-6-viro@zeniv.linux.org.uk>

On Mon, Aug 12, 2024 at 07:44:22AM GMT, Al Viro wrote:
> when given a max_fds argument lower than that current size (that
> can happen when called from close_range(..., CLOSE_RANGE_UNSHARE)),
> we can ignore all descriptors >= max_fds.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

