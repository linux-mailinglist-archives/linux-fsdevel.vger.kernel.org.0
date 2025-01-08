Return-Path: <linux-fsdevel+bounces-38664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEDFA06331
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 18:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4554A167E94
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 17:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152D51FFC58;
	Wed,  8 Jan 2025 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6K5j9yD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBA81F63CC;
	Wed,  8 Jan 2025 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736356828; cv=none; b=lYk1SRNXY4mm0S9knpYWGk76w8j6VJa5lgdVLjGYrUO/8073kPuArFz+jGVdYooGg2s3Wifoo7n9kGjXkNs7wZM3Tye4cIZCVd9YYm/MYUCn+Qj2wJ55MBx8tT9MjLnYWjpiOj2QGZHXYWV03rRZDFisidm1O3MdTBwEqt7RGwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736356828; c=relaxed/simple;
	bh=Re4dzPasLWB1SUuTe94rYkoL4rgd3JES/Bz4FL/MXXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPgo+8YfF9RBfnUIgD38kdRa3/H47BA3VyPW+/a0XDB6s6oO4+RCzJxJAIeu5fwwGBU6r8Fi0Yqt5H6U14f8qShLVJJPLoSMTm+7TMYZEqlqypojczwEj/cvf4P/OrV0C7/jcyx6rJBTyfsXzyl/8OTcbiE7iVPm2GN+5ZUSV6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6K5j9yD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F77C4CED3;
	Wed,  8 Jan 2025 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736356827;
	bh=Re4dzPasLWB1SUuTe94rYkoL4rgd3JES/Bz4FL/MXXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F6K5j9yDJ3PDCqd3ownPLPIVQHW2AyV6Wq+zSPq5+4RXm/g593LsgHcAgqX/G/Bcg
	 0Xq76yxyguJBI0WJoapFL1LPCA6mLElsMSjV7E5SVMfVBUHptHvleY0921E30uimCE
	 BtghKhH+FFf3aFu+IXVT+4XY20HVrwcOnlDHgL0iQGXTx1CA0ProVfgT9Z8ObeWLP9
	 89iWNUwwcYrEofP8Jf9+++MBDnmB4f8LUD1ZuVl9cPWiarmdZdteb+sU3HGcpZLqVv
	 FlqXwE3QNALpUH/nvOq0Ed1pjd8gBhUCrdVwpN/pgB62bnQTIWPXpvJnBpQ8sv3EQU
	 e1Gtw6oSf/8/A==
Date: Wed, 8 Jan 2025 09:20:27 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/5] xfs: report the correct read/write dio alignment for
 reflinked inodes
Message-ID: <20250108172027.GF1306365@frogsfrogsfrogs>
References: <20250108085549.1296733-1-hch@lst.de>
 <20250108085549.1296733-5-hch@lst.de>
 <571d96ad-d9fe-4c76-8f05-1e487244b388@oracle.com>
 <20250108151827.GA24499@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108151827.GA24499@lst.de>

On Wed, Jan 08, 2025 at 04:18:27PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 08, 2025 at 10:13:02AM +0000, John Garry wrote:
> > On 08/01/2025 08:55, Christoph Hellwig wrote:
> >> @@ -580,9 +580,24 @@ xfs_report_dioalign(
> >>   	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> >>   	struct block_device	*bdev = target->bt_bdev;
> >>   -	stat->result_mask |= STATX_DIOALIGN;
> >> +	stat->result_mask |= STATX_DIOALIGN | STATX_DIO_READ_ALIGN;
> >
> > BTW, it would be a crappy userspace which can't handle fields which it did 
> > not ask for, e.g. asked for STATX_DIOALIGN, but got  STATX_DIOALIGN and 
> > STATX_DIO_READ_ALIGN
> 
> Well, the space is marked for extension.  I don't think there ever
> was a requirement only fields asked for are reported, but if that
> feels safer I could switch to that.

From the "Returned information" section of the statx manpage:

"It should be noted that the kernel may return fields that weren't
requested and may fail to return fields that were requested, depending
on what the backing filesystem supports.  (Fields that are given values
despite being unrequested can just be ignored.)  In either case,
stx_mask will not be equal mask.

<snip>

"A filesystem may also fill in fields that the caller didn't ask for if
it has values for them available and the information is available at no
extra cost.  If this happens,  the corresponding bits will be set in
stx_mask."

In other words, the kernel is allowed to return information/flags that
weren't requested, and userspace can ignore it.

--D

