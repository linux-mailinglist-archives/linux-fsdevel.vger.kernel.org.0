Return-Path: <linux-fsdevel+bounces-43878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4D6A5EE01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 09:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585E51694E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 08:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7901A41C6A;
	Thu, 13 Mar 2025 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJStTGOz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C80260A30
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854500; cv=none; b=C6yLHxfpApHxQd9viUYvjtou1/6fZngZXMbg9f+2WW9POibutr36w8rV9g8RXZjgeC9FKbyTuki2jNzr9H1RR/XwGbs9npdQoSCxJJ8F36I1Go3IpEIl8ryedIk+ikCchjtC49R/0Wvr61WNfCU9zXW41HAw0vAl7SvJrves7qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854500; c=relaxed/simple;
	bh=DAX95E8dRRp3Vn7GvTsb/Qtinub6DX3AThaLwxvmN+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drGoCP+bHCCn7IOVMu1VeyLMvJklk2dh1ZPbzmcUo+/gcLB3MP437gg7WjypF/fnRI7pN9S58lxOsHgMH7x529ybxvCVFGgO6NH0oj5+hb7YSyizALluFelUHeyev0GtZYGy48DKlZec9y7ladK1kis99Go0eCtqJuOJ70Ys7Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJStTGOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E363BC4CEDD;
	Thu, 13 Mar 2025 08:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741854500;
	bh=DAX95E8dRRp3Vn7GvTsb/Qtinub6DX3AThaLwxvmN+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nJStTGOz+8qCd6/5/X7ary1f750sVjJHuVYuuX8VD/tY+SqBr4OZB/2ZvktXNFKgI
	 0GXLyh1IoSfDyGNXKoFWgSrtzBBnSO/l1+od7KVeciHg93IUcBgKZgxuLmyrIGy3+O
	 CsAKdzReP8eLuztKBZJknocy9PKmZhxKYcaM5QJnqqqeWAh/seDJ6mFEfbsoIbTHp0
	 C0Z5IIrfY3xYU9BK0FR23sBBM4sdYUOePE7aNXy9nsEUjmCfPNsqnx7SwKOnbzJonF
	 YWA3CiCkOGdEy4aaCMyJSHZyciu9I4BcVtacNgn4oTqarirUiP6WsetSnK4d4Tx0jD
	 kLOyZOrDkT9oQ==
Date: Thu, 13 Mar 2025 09:28:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/4] spufs: fix gang directory lifetimes
Message-ID: <20250313-lakai-halbjahr-d302c0e6108b@brauner>
References: <20250313042702.GU2023217@ZenIV>
 <20250313042901.GB2123707@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250313042901.GB2123707@ZenIV>

On Thu, Mar 13, 2025 at 04:29:01AM +0000, Al Viro wrote:
> prior to "[POWERPC] spufs: Fix gang destroy leaks" we used to have
> a problem with gang lifetimes - creation of a gang returns opened
> gang directory, which normally gets removed when that gets closed,
> but if somebody has created a context belonging to that gang and
> kept it alive until the gang got closed, removal failed and we
> ended up with a leak.
> 
> Unfortunately, it had been fixed the wrong way.  Dentry of gang
> directory was no longer pinned, and rmdir on close was gone.
> One problem was that failure of open kept calling simple_rmdir()
> as cleanup, which meant an unbalanced dput().  Another bug was
> in the success case - gang creation incremented link count on
> root directory, but that was no longer undone when gang got
> destroyed.
> 
> Fix consists of
> 	* reverting the commit in question
> 	* adding a counter to gang, protected by ->i_rwsem
> of gang directory inode.
> 	* having it set to 1 at creation time, dropped
> in both spufs_dir_close() and spufs_gang_close() and bumped
> in spufs_create_context(), provided that it's not 0.
> 	* using simple_recursive_removal() to take the gang
> directory out when counter reaches zero.
> 
> Fixes: 877907d37da9 "[POWERPC] spufs: Fix gang destroy leaks"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

