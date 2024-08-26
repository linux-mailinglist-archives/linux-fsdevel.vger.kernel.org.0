Return-Path: <linux-fsdevel+bounces-27137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDE095EE8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4BA281AD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C814C14A4FB;
	Mon, 26 Aug 2024 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbCZY2I4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262E32CCC2;
	Mon, 26 Aug 2024 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724668619; cv=none; b=d5SpxXEfdWDTRbc/FXqhtd7b+Qh8YbQP8tzBMKbJiaBHNlNF52StDF3ruBKwwOlmrXJt4H7Mxc9/dOlvXOXHAV8H4axl/ZgR22ExUQe45AB0W/QYXr2hnfinOjal0889pdMGObH4E8Y78o2LjKey1hekw6t5G+ZceNmWQqDboB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724668619; c=relaxed/simple;
	bh=d7XS6v/xUVOxqins+CAVtnFhKUBTlNoaFQ9JS3SBlkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToHLBJ0PEhe+D031xaETz3PFF/IQWgmgF3ZFnjhgxbjHqJbPUQwOPlash+pSrHKkA5cLVCmhJL1fzhP5xshOXZbwV/9dkVUaQyFMhQDkUMYdZLxdyetKR0ROomWm3KwPVAskIGeuqP3/OS+F4ASOYPsALdJrDlc5scp4kr02STk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbCZY2I4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8751C51406;
	Mon, 26 Aug 2024 10:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724668618;
	bh=d7XS6v/xUVOxqins+CAVtnFhKUBTlNoaFQ9JS3SBlkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EbCZY2I4RpKwh8fTBiTbqYMhVo4lK3lsUXFT2PRhhdIrJDcKBr2xv8WREkE6pzLac
	 1TBKz5CTCQz+X2waD+0o1Ig2nIlQcxYJEx6UzJkhg8Y+FSSY32Nuh8SnQuhio+TlsR
	 tf1zJeNNMBZSB9G2AOEJX82T9slMJToHE0D8QhR+75TkiGiB3AP0Q9Sxj3NQ044Wzc
	 2w+U/P93m3wPFTwrlZ3s5n9VosQ21l48zyDqidpIB/x0n+xC31Vywc6qx34LkaYb+L
	 3WD3N1zO/uoDMS5e/g50ihM0OkZZWBX6D42cvBd/0VLv7kAGRfA34/PcLp5AFGv2AR
	 YXQVtDgqpuy9A==
Date: Mon, 26 Aug 2024 12:36:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/nfsd: fix update of inode attrs in CB_GETATTR
Message-ID: <20240826-liest-pusten-70d5645c9959@brauner>
References: <20240824-nfsd-fixes-v1-1-c7208502492e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240824-nfsd-fixes-v1-1-c7208502492e@kernel.org>

On Sat, Aug 24, 2024 at 08:46:18AM GMT, Jeff Layton wrote:
> Currently, we copy the mtime and ctime to the in-core inode and then
> mark the inode dirty. This is fine for certain types of filesystems, but
> not all. Some require a real setattr to properly change these values
> (e.g. ceph or reexported NFS).
> 
> Fix this code to call notify_change() instead, which is the proper way
> to effect a setattr. There is one problem though:
> 
> In this case, the client is holding a write delegation and has sent us
> attributes to update our cache. We don't want to break the delegation
> for this since that would defeat the purpose. Add a new ATTR_DELEG flag
> that makes notify_change bypass the try_break_deleg call.
> 
> Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> One more CB_GETATTR fix. This one involves a little change at the VFS
> layer to avoid breaking the delegation.
> 
> Christian, unless you have objections, this should probably go in
> via Chuck's tree as this patch depends on a nfsd patch [1] that I sent
> yesterday. An A-b or R-b would be welcome though.

Fwiw, 

#define ATTR_DELEG	(1 << 18) /* Delegated attrs (don't break) */

is a bit sparse of a comment for anyone not familiar with leases imo. So
I would update this to say something similar to what what you say in the
commit message: "Don't break write delegation while we're updating the
cache because of the write." or something similar/less clunky.

Reviewed-by: Christian Brauner <brauner@kernel.org>

