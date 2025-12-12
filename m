Return-Path: <linux-fsdevel+bounces-71186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6399ECB8088
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 07:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B0DB3056554
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 06:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7669930EF62;
	Fri, 12 Dec 2025 06:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qh1LX372"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FBD2882B7;
	Fri, 12 Dec 2025 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765521005; cv=none; b=BmAuSyKtf/1Xov9L1eYU3E+8QEo5FUle9TFhWN1JF0tdoMCVv2ZFIJowW0kE3fPXPWoXyjb/0PYQENSYvjj1eAoTQQD2hcP5wS6/6yvYm75PndkHrP+drlFSPytqxXs8yc6xo7f8nMkRg6pIAq4icsWyC2nBx7cgrDDCfv6GFYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765521005; c=relaxed/simple;
	bh=FmXWqJTvzZzDwcB2Hgp7efmrhe7MS20aqHn7bxeizdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=En78Qr2jko/6yJQBFUdoYJmKODZRCKaTaPvosD3qKx1DdTlgnsAHJ2UhIGLAoL7YVgdV34t2ksA15ZGgs+5oYkayHFOMbdFXouRoUySvvZZWkaksXOX8/t2Zvi1Rn9nJNPVBe+B4+xXqCpnQY4ygQ49tckBkeizDUxVzz2Ea8qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qh1LX372; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K/5oi+83CBKKaWTURWV0mnEWv5TIfLfBd+3xTzWf0Jg=; b=qh1LX372w0ta30pPX89JVFqobP
	O1t2/Y4PZA1ZCLgQnQa4/W37TZW42KS3Jjs7Mm90yoCoMCisImxQYTjXq/fdBtq3n8q0WCoQlHoOn
	Q3JfCaRGMv8x6JwRs1b5xRaGDS9ABdVf980pFA27H0ADCnyvhBkdin8gm1Yl6WcUdU2/zU+gkXDJv
	yma/qp8aj6D2XNJ+ugqhG5AwOOrEH77PCpHxVP+GavJdFKVSZHS79p6cXVwtN5zkHxvOxghkp36zB
	oMdIgMsgJzIl/+RRLdREpDNHUFa49ilJPsRoFLwNiOiQviVdMQtA8Jum9PM+Vjx0EafaxqEl0RKU1
	+iaiEWow==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vTwfa-0000000BlXc-1NdW;
	Fri, 12 Dec 2025 06:30:26 +0000
Date: Fri, 12 Dec 2025 06:30:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Hugh Dickins <hughd@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: 6.19 tmpfs __d_lookup() lockup
Message-ID: <20251212063026.GF1712166@ZenIV>
References: <47e9d03c-7a50-2c7d-247d-36f95a5329ed@google.com>
 <20251212050225.GD1712166@ZenIV>
 <20251212053452.GE1712166@ZenIV>
 <8ab63110-38b2-2188-91c5-909addfc9b23@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ab63110-38b2-2188-91c5-909addfc9b23@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Dec 11, 2025 at 09:57:15PM -0800, Hugh Dickins wrote:

> No, sad to say, CONFIG_UNICODE is not set.
> 
> (I see why you're asking, I did notice from the diff that the
> case-folding stuff in shmem.c used to do something different but
> now the same in several places; but the case-folding people will
> have to look out for themselves, it's beyond me.)
> 
> (And yes, I was being stupid in my previous response: once I looked
> at how simple d_in_lookup() is, I understood your "hitting"; but at
> least I gave the right answer, no, that warning does not show up.)

A few more things to check:

1) do we, by any chance, ever see dentry_free() called with
dentry->d_flags & DCACHE_PERSISTENT?

2) does d_make_persistent() ever call __d_rehash() when called with
dentry->d_sb->s_magic == TMPFS_MAGIC?

3) is shmem_whiteout() ever called?  If that's the case, could you try
to remove that d_rehash() call in it and see what happens?  Because
that's another place where shmem is playing odd games...

