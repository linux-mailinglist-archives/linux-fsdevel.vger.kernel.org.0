Return-Path: <linux-fsdevel+bounces-20226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D975E8CFF44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 13:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AA81C219D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 11:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C656515E5C6;
	Mon, 27 May 2024 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DqGCY/hL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0EE1581E2;
	Mon, 27 May 2024 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810483; cv=none; b=bJtW+JE5UDUBE8Dv04mE6FjZ2Z61GY4RiVu0SCqzhZ5nv/Aa82yFzrQljGFUCJAiDlSaQoaH8GJxzs03VPejEXwVFxNxn+nwcMima5sUqtTD/E+WOCvyeEB5jKIl2pB8pNbGbk8dC7Wh26JMwGEEdrqRe2/2s7uJEC57+AdsrNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810483; c=relaxed/simple;
	bh=Xi54afU0dRqoCutzzQ1x9zNEqkgWSsCL5ib1ypoy3ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxB1s7QzdPQaMiHo5ifTgC3kITZG1Vt5JQCjPlyLbnmk+4V1z9pkQZQmCYQzVEy9NLsS67W21ga2fYXaZCKpgW71dgnvjrp/LZIMFAhaZoj8G9sll1lSzscLzlLZv0cTN4THAWqwIjr5QQaXfvQv657OwvNAZnIBSGxFvddQDtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DqGCY/hL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2iRQNARYz6TUh7I9OHQgqaA8lNEZzq7pUVB+8f4qGN4=; b=DqGCY/hL/0v4+ZNJS7sSHJagi8
	oZVPqgNF/00HXA745NxhP4BaRThnL5JZpYyz5qG3Dfgag4MWoutaQBQv+9ZH7FzRYe6lMguZCdxE4
	fs/abRl28V5+/10XFpBn8pLZH6w464YsE4cIRiurnyZJ78wezBYtzgh3zDgN1+wHKo9lZVA9YCicg
	38tSg4lFKZly7B3RPJwAOTjWqkKBV2l64rOpBvPFBLQ1Nx4lPke/2zxidK6ARkANVo127qwbbXthp
	lPsQfeN3tZiUujm2xVdSG8Mcx2JGGivYojdgjv6GZfruQWwudJQ/Y9dX/rsvKXk6gzI2geUnFXlpQ
	BkNDiedg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBYpY-0000000Ejny-3eAr;
	Mon, 27 May 2024 11:47:56 +0000
Date: Mon, 27 May 2024 04:47:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <ZlRy7EBaV04F2UaI@infradead.org>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <20240526.184753-detached.length.shallow.contents-jWkMukeD7VAC@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526.184753-detached.length.shallow.contents-jWkMukeD7VAC@cyphar.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, May 26, 2024 at 12:01:08PM -0700, Aleksa Sarai wrote:
> The existing interface already provides a mount ID which is not even
> safe without rebooting.

And that seems to be a big part of the problem where the Linux by handle
syscall API deviated from all know precedence for no good reason.  NFS
file handles which were the start of this do (and have to) encode a
persistent file system identifier.  As do the xfs handles (although they
do the decoding in the userspace library on Linux for historic reasons),
as do the FreeBSD equivalents to these syscalls.

> An alternative would be to return something unique to the filesystem
> superblock, but as far as I can tell there is no guarantee that every
> Linux filesystem's fsid is sufficiently unique to act as a globally
> unique identifier. At least with a 64-bit mount ID and statmount(2),
> userspace can decide what information is needed to get sufficiently
> unique information about the source filesystem.

Well, every file system that supports export ops already needs a
globally unique ID for NFS to work properly.  We might not have good
enough interfaces for that, but that shouldn't be too hard.

