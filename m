Return-Path: <linux-fsdevel+bounces-35040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F149D04B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 17:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711CAB21F37
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 16:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9F81DA631;
	Sun, 17 Nov 2024 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Z6XhuvOw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEEA7DA68;
	Sun, 17 Nov 2024 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731862546; cv=none; b=ObvNVwiJxG2ppzwPfEvp2oqXfF5SMsTgDscQlrxYWMan7lx+2l0r+Ryu8r5PehlYg+QUE6NYDeOlCAl7MYxxM8OXPKi6PkW7SZ87C1U+bNqmLT47j1nBoTeSCmV6cF7MN3XNof+5/DtwWyY2UtSH1QmU52eTAwW3NHO4ocNwT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731862546; c=relaxed/simple;
	bh=zqrBOGxmlr3m1LZas0bxuYjIJojhoqrvpTpD+FMzFbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLU4/njN7qMdTeZ1SxJjVElPu7k5hlGGUFRfvmPUIYiQDYdL9tc2jGuPciyCuYnPxRNDMr6uDABz7ExYyvdWi/+NDTH6BeUfOgyuZy3BC/MLFYahS7b4cnYw/5Kz7+vrKnkJHktzG3Wn4N8Ep8UZ5NwseRjkrI9ecbpgaD2f1sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Z6XhuvOw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TFW4OVWgse3VEZmUCrGZeS2fzZTd1dS/v0LDv9d0mnw=; b=Z6XhuvOwq9hD0SLUNvMX5I+xrH
	8UP2Nbg6OQS8unq2EPM/WyXgeUUEhFPIbmRNXjNcLrETWA2sn4kLB39v+oLEAZPJz96l5LvfqRUEv
	1lrKYMJtuAntJtk/HmAWPhRyq/Zi7Z/pcLu4fIL0N/O8Z1YPIGOUHdF4DCkn9IIPu2uetCYIQ9zvg
	U29Ei/RHuS7UmuYTUus0xCV9i/Hhken6llo2jw0jivxO18UJEBYVLOLcNKhxFhLouIPrHKt7hNlkv
	N11kGsZ263OKRMwut4VICI+JvKc+M5vCrxVaawcm47OFPQxN7XoksNnx2qVkBQUsTkW0gvnHNdnmT
	mUaPcgJQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tCiYm-0000000G7uA-2znr;
	Sun, 17 Nov 2024 16:55:40 +0000
Date: Sun, 17 Nov 2024 16:55:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeongjun Park <aha310510@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs: prevent data-race due to missing inode_lock when
 calling vfs_getattr
Message-ID: <20241117165540.GF3387508@ZenIV>
References: <20241117163719.39750-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117163719.39750-1-aha310510@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 18, 2024 at 01:37:19AM +0900, Jeongjun Park wrote:
> Many filesystems lock inodes before calling vfs_getattr, so there is no
> data-race for inodes. However, some functions in fs/stat.c that call
> vfs_getattr do not lock inodes, so the data-race occurs.
> 
> Therefore, we need to apply a patch to remove the long-standing data-race
> for inodes in some functions that do not lock inodes.

Why do we care?  Slapping even a shared lock on a _very_ hot path, with
possible considerable latency, would need more than "theoretically it's
a data race".

