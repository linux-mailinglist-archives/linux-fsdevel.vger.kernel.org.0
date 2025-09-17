Return-Path: <linux-fsdevel+bounces-61955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3088B809F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 17:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394C74678CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C81030C0F1;
	Wed, 17 Sep 2025 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JLovH2bH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5F2332A44
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123420; cv=none; b=qdlbBup99Vbyb5Z7mRQU9vd2xUZYXNfahmmTwWij+AKXz7JR8jSOJ6stATLLjdU7C2wtpRHBxmAlhSlHmEaw66opYvJ2dqItzhZtVOYT3qh0vPv2R+AgUFG3jlT8fSzQwxI4p2zqVj+nlONieRZarzyQk9qGFHtofChZpWN8J58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123420; c=relaxed/simple;
	bh=myGW3o3M/TDCcgi5aYyp2YlZu8pa+ZT4Tm6BlcCD64s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VObO64Utk6ahFhHf6jGtzd8dSEm8lvFDJy22TGBWPTG/bG3TumNrElz6flk3LPRRBCOHdSUD/3fTLKyRq/nwLQOwEAx9LD/ff8UMa/qbfBt+zGGUByc3Ke8uA9OQS54ACRoBE12ImT04afGH7UXdnrlitJPXI2VvBExzFwmd/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JLovH2bH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O3qKlV6rW1FmL+0nV0Um+slqHoWPl8h62c60UE8aU84=; b=JLovH2bH42W644tJI+5XwW8VaU
	XnJ6WsC8spxslI4mnOQ10guiyScsHmuBHK2wHrO7j4hyWpr4p1lLWDNpWzgUSDrQYnu3cpVW1EAP9
	f8ZDaYlNotpSBNux6cJhOM9iDMSfucMmCnkEmdGNK10I7U4pWX7bnqiCpLTmzXdVJR9d80IVd9t2i
	TZTkEACMy0TQ5NthRAGeDp+xQ5+xz9Kfd82rFApV3+6Zoct5m8YsjwHYQXkfGxKRcTR7IZg/+/AYO
	OVqzmX2h4wU1ZIsz2+XtHsLjrHYiu2w/I0E0b1O4RS74I2UU5nykS8mWNTsdI6OiY4XGspMexAoAE
	DGCC396w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyuDH-00000002fkG-1azZ;
	Wed, 17 Sep 2025 15:36:55 +0000
Date: Wed, 17 Sep 2025 16:36:55 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, NeilBrown <neil@brown.name>
Subject: Re: [PATCH] fuse: prevent exchange/revalidate races
Message-ID: <20250917153655.GU39973@ZenIV>
References: <20250917153031.371581-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917153031.371581-1-mszeredi@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 17, 2025 at 05:30:24PM +0200, Miklos Szeredi wrote:
> If a path component is revalidated while taking part in a
> rename(RENAME_EXCHANGE) request, userspace might find the already exchanged
> files, while the kernel still has the old ones in dcache.  This mismatch
> will cause the dentry to be invalidated (unhashed), resulting in
> "(deleted)" being appended to proc paths.
> 
> Prevent this by taking the inode lock shared for the dentry being
> revalidated.
> 
> Another race introduced by commit 5be1fa8abd7b ("Pass parent directory
> inode and expected name to ->d_revalidate()") is that the name passed to
> revalidate can be stale (rename succeeded after the dentry was looked up in
> the dcache).
> 
> By checking the name and the parent while the inode is locked, this issue
> can also be solved.
> 
> This doesn't deal with revalidate/d_splice_alias() races, which happens if
> a directory (which is cached) is moved on the server and the new location
> discovered by a lookup.  In this case the inode is not locked during the
> new lookup.

> +		inode_lock_shared(inode);
> +		if (entry->d_parent->d_inode != dir ||
> +		    !d_same_name(entry, entry, name)) {
> +			/* raced with rename, assume revalidated */

... and if the call of ->d_revalidate() had been with parent locked, you've
just got a deadlock in that case.


