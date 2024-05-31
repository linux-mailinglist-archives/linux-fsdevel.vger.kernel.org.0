Return-Path: <linux-fsdevel+bounces-20631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD1A8D640E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0373428F9CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3744F16936E;
	Fri, 31 May 2024 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHCGEIFO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF021E492;
	Fri, 31 May 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164601; cv=none; b=Dmg9U3Dh4TNL/kxGh38dm+XpiqgbjwMuC0ibSqAM/U+ZNa9W7g8UGcHEWxKi8TTAcRh5NMQ+ki8j4030fG3jwTwCWvXMyEVOE+0idP2lT+idHMNDoP7NcL3esiyCGJJPQKyvZGi4+wx6MfdWlUHkq8D1RvUYqQ+8Jp3hFdNekLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164601; c=relaxed/simple;
	bh=6+bnziXgxwqhoOY1VvRRs5lGYHQ7FbFZYIANGvO6r24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEYIOuIL1QcfPgxrvr53IXgt5eVmOINBwws4rElQ7rGd9NhCxyRA1uS+MGyHGAe1bykw+Mq9oVF23NTxKtWgVKDnGOsw23ulisYAuDIwQ9Ca3jVDhRpcPcCfYb6hHfs2zk78rKFCBUuUnenCfHmXsL77KqejruLj0XMJ7jzkQbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHCGEIFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11902C116B1;
	Fri, 31 May 2024 14:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717164601;
	bh=6+bnziXgxwqhoOY1VvRRs5lGYHQ7FbFZYIANGvO6r24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHCGEIFOz4I2/6WrL6ELPQdxd5jko0EOlBJFWfb5W4ZFEpUE+TaUHQ+mRh0tmJ22i
	 7dP4R0TRtqPzRXAmuWNv9Iuc82Clm3TddeBYWHJzEuqtFHfelXxW2G6uWmGZbPrze1
	 bhj7rZT5NNYTtUaVrfKyJLw1xVhCIXWLBWwxurU6rIACfZmrjH3u018xj9IR883O+q
	 k1j3+aD1JRuUKKMFkFaUqCQnnLpoDze28e7SNpQ+2JbN/E17UCeKcjV90mkRBkUo4a
	 ESyDoEbgDDwNWHsyyTvCnTSZkKa7uqXQgHoIEW7vL4beeN79amXgDncFO38BIviXDy
	 /kxPObN06vJAg==
Date: Fri, 31 May 2024 07:10:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 7/8] xfs: reserve blocks for truncating realtime
 inode
Message-ID: <20240531141000.GH52987@frogsfrogsfrogs>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-8-yi.zhang@huaweicloud.com>
 <ZlnFvWsvfrR1HBZW@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlnFvWsvfrR1HBZW@infradead.org>

On Fri, May 31, 2024 at 05:42:37AM -0700, Christoph Hellwig wrote:
> > -	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
> > +	resblks = XFS_IS_REALTIME_INODE(ip) ? XFS_DIOSTRAT_SPACE_RES(mp, 0) : 0;
> 
> This probably wants a comment explaining that we need the block
> reservation for bmap btree block allocations / splits that can happen
> because we can split a written extent into one written and one
> unwritten, while for the data fork we'll always just shorten or
> remove extents.

"for the data fork"? <confused>

This always runs on the data fork.  Did you mean "for files with alloc
unit > 1 fsblock"?

> I'd also find this more readable if resblks was initialized to 0,
> and this became a:
> 
> 	if (XFS_IS_REALTIME_INODE(ip))
> 		resblks = XFS_DIOSTRAT_SPACE_RES(mp, 0);

Agreed.

--D

