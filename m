Return-Path: <linux-fsdevel+bounces-20231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F299A8D0006
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 14:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78E91F235F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 12:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF9515E5B6;
	Mon, 27 May 2024 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NK53lCa6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E221581E2;
	Mon, 27 May 2024 12:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812949; cv=none; b=gOM4LO6LKcNsCzNI+mHALYIRewyWzV4UORiEwI9JclF7JBPzszFqaYYpd77BqhgELvewEBP035OrmNvB0A8LuJaJsCNGkc3lMsZrgHXz48u2kc0WkRWFkH9p2gJkL/3NYZ7XDqrZlc7eUdkLq+HEBEl4BcqCsUCnUdK1Jjp1DzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812949; c=relaxed/simple;
	bh=tjvtAIJXWm20T+mGM7vsATeimzw31eut/UyatyIrsoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pptXKHl/62JOMooRPtu1ikR7ZRQ1D9iy+ds1BScwz9+036/H5HuOEqHjQR/oCcRcFmRq5gCkpQ8cD6HamGP4jCpZpGWeev+WigjsHap3mdIQOABvUi4uGxiC0rybO3kIV+cUDJiNQk5F+Gad+65BMd/8ZSmrtrGAPa60PWQ8xXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NK53lCa6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8C4C2BBFC;
	Mon, 27 May 2024 12:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716812948;
	bh=tjvtAIJXWm20T+mGM7vsATeimzw31eut/UyatyIrsoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NK53lCa6WM6ArMzjNGHzERvdmx3V5wpFDOMpAWjptfLLF7t3XUh+U4oByIOKr8I3+
	 JPNvKleNc/6bJGuoIhdx2tbR4E5XF8NcXRmhnvHx0Q1BTSCKCKz9QRr836h6JpOFRd
	 sA+eyZyhLxG9dUNv4NSR/U5nbgFCnz4GKayN3O4vniNJuDBhXMJXAbf1AZcARzbdg0
	 auowumcTOLtNoqoCqJW055EaWjpUw8SMu4+tNzelkPSI8OjYt3x0fiCfclDX/57DTn
	 mLBOVYfahi9I2LZ5GYrDamvXwaTV5v6Xm5DHgVBJyZ0OwexeuaXwacdNl3jAqraBS8
	 wMkvK8SXhdlyw==
Date: Mon, 27 May 2024 14:29:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <20240527-hagel-thunfisch-75781b0cf75d@brauner>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <20240526.184753-detached.length.shallow.contents-jWkMukeD7VAC@cyphar.com>
 <ZlRy7EBaV04F2UaI@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlRy7EBaV04F2UaI@infradead.org>

On Mon, May 27, 2024 at 04:47:56AM -0700, Christoph Hellwig wrote:
> On Sun, May 26, 2024 at 12:01:08PM -0700, Aleksa Sarai wrote:
> > The existing interface already provides a mount ID which is not even
> > safe without rebooting.
> 
> And that seems to be a big part of the problem where the Linux by handle
> syscall API deviated from all know precedence for no good reason.  NFS
> file handles which were the start of this do (and have to) encode a
> persistent file system identifier.  As do the xfs handles (although they
> do the decoding in the userspace library on Linux for historic reasons),
> as do the FreeBSD equivalents to these syscalls.
> 
> > An alternative would be to return something unique to the filesystem
> > superblock, but as far as I can tell there is no guarantee that every
> > Linux filesystem's fsid is sufficiently unique to act as a globally
> > unique identifier. At least with a 64-bit mount ID and statmount(2),
> > userspace can decide what information is needed to get sufficiently
> > unique information about the source filesystem.
> 
> Well, every file system that supports export ops already needs a
> globally unique ID for NFS to work properly.  We might not have good
> enough interfaces for that, but that shouldn't be too hard.

I see not inherent problem with exposing the 64 bit mount id through
name_to_handle_at() as we already to expose the old one anyway.

But I agree that it is useful if we had the guarantee that file handles
are unique in the way you describe. As it currently stands that doesn't
seem to be the case and userspace doesn't seem to have a way of figuring
out if the handle provided by name_to_handle_at() is indeed unique as
you describe and can be reliably passed to open_by_handle_at().

Yes, we should fix it but that's really orthogonal to the mount id. It
is separately useful and we already do expose it anyway.

