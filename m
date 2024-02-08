Return-Path: <linux-fsdevel+bounces-10765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E68E84DDD9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 11:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EFDC1C26BE9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D546D1C6;
	Thu,  8 Feb 2024 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SC3zz5X+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C2F6A8A1;
	Thu,  8 Feb 2024 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386995; cv=none; b=g2nDSn9/6VIhm4swdfJguIimPvs8px78oEQ3IRuzfDp1OU17r6CNjuUwbYwVymT7z+16RmZllMKLGRNkgRzGlFm5aFRjvggqq2H8OevEs5YgHDZ3x1wv3ktxS+eXwpay6n1AV9wVz4FfysViaqVWw5kSF3bioFP8eL7w/1Jjdf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386995; c=relaxed/simple;
	bh=JjcLOCZ1/hKYgkTG+RntIVSor55UEbfbS9kEcWK2aeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCN1BwmRFcJPqEnHk8H66GcGLTVtVkoeh75zdRqr8YE7soEKWTiJ89c8GV7Kfp+xje8PEKiqTddhJLU4zP7+poObu+bx8P7NLB7xWRpPi5whBqFLXTkeHnSFKupen4WKgxVXm2R7kIb65xKWE1SQXCCwwEeuXxb45uRAqgZQrPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SC3zz5X+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81835C433C7;
	Thu,  8 Feb 2024 10:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707386994;
	bh=JjcLOCZ1/hKYgkTG+RntIVSor55UEbfbS9kEcWK2aeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SC3zz5X+EUKAUwB0jtoTDIpUJ64+2OR6jJAYcpTuyN1iG7bARyVNPo/sqraaxEDHx
	 5dzGoCREXmgRKwUdpIOnW3pnizTT0fhvmOv4sYy/AD6Ef+OKEVh4Oz8VVLdrzusrrT
	 gcNgs5R5/YGvq/CqzM78zeLG5hTrGj7IbiJuD788rXsXd0brse8Q52f+xCRkGu103a
	 WVsO9GHbyH4nq4lKtSqudRnGoCGoGtzEiALDIIDOrF5+WTxG5ZSmLHzK7NqjsfgjoZ
	 TOzlqTADHN4shDvpheSxkD9qjEUpc9BBaXKllzoMbYxjWABmVbezrKW506x6EWhpET
	 YwKVqaOwCQ2BA==
Date: Thu, 8 Feb 2024 11:09:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 5/7] fs: FS_IOC_GETSYSFSNAME
Message-ID: <20240208-holzarbeiten-beleben-faf145faa713@brauner>
References: <20240207025624.1019754-1-kent.overstreet@linux.dev>
 <20240207025624.1019754-6-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240207025624.1019754-6-kent.overstreet@linux.dev>

On Tue, Feb 06, 2024 at 09:56:19PM -0500, Kent Overstreet wrote:
> Add a new ioctl for getting the sysfs name of a filesystem - the path
> under /sys/fs.
> 
> This is going to let us standardize exporting data from sysfs across
> filesystems, e.g. time stats.
> 
> The returned path will always be of the form "$FSTYP/$SYSFS_IDENTIFIER",
> where the sysfs identifier may be a UUID (for bcachefs) or a device name
> (xfs).
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---

The ioctl is called FS_IOC_GETFSSYSFSPATH but commit message states
FS_IOC_GETSYSFSNAME. Similar for the following commits. I fixed this up
but please try to make sure that this matches.

It would also be really nice to see some additional ACKs from other fs
maintainers for this ioctl.

