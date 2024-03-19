Return-Path: <linux-fsdevel+bounces-14818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6F3880094
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 16:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCBD7B20F5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E232657B8;
	Tue, 19 Mar 2024 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGw6kJcR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827624B33;
	Tue, 19 Mar 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862171; cv=none; b=LutWX6g1DX35NqBNieMkQVYgPKF9G4/GY6xlSNbuXxjh0NRQisncBCZ6iO3usC8uUA6FDmQ8xELt5W8O9fvZ2nE6E9AotqH6QV70tUM4W6YaeQINS0lUBAepNsf3pNmeaRJ0e+fZTAsp78EgEehWvSegn170+mDLPqOFI3ur+7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862171; c=relaxed/simple;
	bh=VgLcP2hyQd2I/2FSYrwfNZkMKXumyqi2w8XTycPbpnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWbXXQ+fBJNKyHRL7jViiH3yV6A1t4wGztB/RN3wFGXHTQ7T6bAiPRIBl7pu43nIz2bZGNPyB/YINBbzeq7Zq7i9TicjgmFWZZ35K+uQtpuLCDNK1DK+fcRk7/whir9ymU5ZtUkfKLXJTs9jtbU318WvmaRWQxGYbDyBwszTwCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGw6kJcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB880C433C7;
	Tue, 19 Mar 2024 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710862170;
	bh=VgLcP2hyQd2I/2FSYrwfNZkMKXumyqi2w8XTycPbpnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGw6kJcRiQqyqHz8N1GAr4dPVuIhAWUJ5XRkb4JoyqvJ3XDGxNKCTAvmfXvOoVZ5J
	 mQDeMHLHGgShzcwAslHrZLIR8E09XOJP2FLShfOa+KnfBnkk5TBznSfjQweQBoAZbG
	 bqUkL3pQ97ybYLwsNzmfCUIx9BPeyyLfHlagqQytZ7QIjYvfBDuoTGnkt086Ke0rqw
	 V0EhtrPvn1nEnb5WyuiWAk0LSR1oiJ6SewSu6/Y7Y9lsmAbGO7yZRtJVlAflRksmgf
	 g94V2v0fKoQPxnAitc5FRmWjTGo3YpJvUVEyQnJ9suk2VbljPOSdPPZ1chc1ax5TQ7
	 IW0FdVqlhXl2w==
Date: Tue, 19 Mar 2024 16:29:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] ntfs3: remove atomic_open
Message-ID: <20240319-hoffen-fasten-66e583a0d595@brauner>
References: <20240318-ntfs3-atomic-open-v1-1-57afed48fe86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240318-ntfs3-atomic-open-v1-1-57afed48fe86@kernel.org>

On Mon, Mar 18, 2024 at 02:28:50PM -0400, Jeff Layton wrote:
> atomic_open is an optional VFS operation, and is primarily for network
> filesystems. NFS (for instance) can just send an open call for the last
> path component rather than doing a lookup and then having to follow that
> up with an open when it doesn't have a dentry in cache.
> 
> ntfs3 is a local filesystem however, and its atomic_open just does a
> typical lookup + open, but in a convoluted way. atomic_open will also
> make directory leases more difficult to implement on the filesystem.
> 
> Remove ntfs_atomic_open.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Am I missing something about why ntfs3 requires an atomic_open op? In
> any case, this is only lightly tested, but it seems to work.

Seems we should just remove it.

