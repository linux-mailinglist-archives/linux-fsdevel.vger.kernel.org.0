Return-Path: <linux-fsdevel+bounces-18200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85128B67CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 04:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25EE31C21FD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 02:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD884C8D7;
	Tue, 30 Apr 2024 02:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gwcG4DSr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44908C10;
	Tue, 30 Apr 2024 02:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714442739; cv=none; b=G24y96J9wWtn6LACc0ljFF/DtZU9h+IhL9/CnxHd5PAS3Ms5NVRBKQhfPabkGXhsbl60GpcNRCzsZHK1Sqvp2tAyPE3ee0GmW5n7ouvWefpsWrFiFByykDGu9+iC6Q2/I2VE2s07bOX/+vmE0GrNTKQ7Whr8qkNsuDMPQXm6Zek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714442739; c=relaxed/simple;
	bh=yD9khRHItcFQizql/jFVfqEvL84PqUgnglzV4mWTdg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAh/mRhDg3rCIPz+Otv/DKOtPslgDchHpjaREgOCPwM2yzGhe1uMxgCsf45rLZZbOWNRva+f1Yknc6OT+WyiUYG6Pt++82KLxHSQcYo4UFv8CzFPRIq6oG+MXZfnvE1rcQDl5geVxqZ5PqmCISwvf80dUbkH5Bm+sJKzCRhQTxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gwcG4DSr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CAUsBKxydrdxQpdVLX2zXheH4gUWpJmbYkKGM7+vAXM=; b=gwcG4DSrqpdoogs5b73ypOVfju
	qnW4TcAaWZvh+2/54T9i81aSTwHc2OIW87G3LrCZYnqjSDH2pwclZxrD4vD144PIFl3GSlSSZ6kQ+
	eiyogGzS2KkRVBqKWrhwO1XfW/Cs9trEmEDkVx3H2IuujAXoapEF8dB4DYFt7cxvRTDAVRPaLBHWC
	PvZaqpYm67eLqcdNGYEOqmnYScrrdiBAYrH2g01hKMZw7ZA0rGMD+KZzz+TUaoikSspt0KZ+xNSf3
	AZrH8gbokd5fPnhDgmuJkys2AekVD7V9ZTpZD7qbkcZXcgZemjxpG1eg+B9+MOb3to4ZGZvtOyzoI
	dUT5x2/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s1cs8-007Qm4-10;
	Tue, 30 Apr 2024 02:05:32 +0000
Date: Tue, 30 Apr 2024 03:05:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Sterba <dsterba@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/7] btrfs_get_dev_args_from_path(): don't call
 set_blocksize()
Message-ID: <20240430020532.GE2118490@ZenIV>
References: <20240427210920.GR2118490@ZenIV>
 <20240427211230.GF1495312@ZenIV>
 <20240429151124.GC2585@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429151124.GC2585@twin.jikos.cz>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 29, 2024 at 05:11:25PM +0200, David Sterba wrote:
> > -	if (ret) {
> > -		fput(*bdev_file);
> > -		goto error;
> > +	if (holder) {
> > +		ret = set_blocksize(bdev, BTRFS_BDEV_BLOCKSIZE);
> 
> The subject mentions a different function, you're removing it from
> btrfs_get_bdev_and_sb() not btrfs_get_dev_args_from_path().

... conditional upon holder being NULL, which happens only when
called by btrfs_get_dev_args_from_path().

