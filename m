Return-Path: <linux-fsdevel+bounces-8447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D99836B25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 17:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92E71F25BF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 16:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CC514DB7B;
	Mon, 22 Jan 2024 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF9eAoxR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B241B14DB5D;
	Mon, 22 Jan 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936687; cv=none; b=qY2+g5yX+8NF0R0IdBb3I5Ern+35h6I+aEaWtdLT23t8Ti1MB8L1e4NPokDLHOUHRH5Y/8Xo7o9Wu/ywzAOBYnzdtkDn+vdizkJ1PXIrHb2XS+zzD5oXJp/7PFZaIs1gk4BJEZvY377T3YV+xYQx7My1RpKDB+QVUEBeV4tRf7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936687; c=relaxed/simple;
	bh=UQJgDJ1jQGsA5dFTTO+ji4AWSQKmt22PQx0vxvlz2bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fU2ejLPfI0tVEx918kYMmwCXOlb/3rBsOYIsQFf1DKz1oMprpf3aszk47gWw2Ni/uNMByg6m2x7mGLxz2W243kqjOgOQenuyGEhld5XrZLFcEX4MakTAwsNuhDCm+1V0JoIycKsc1ARIAeQ2BfKt5qO7c9A2ArARepteN4Gmh1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF9eAoxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816C1C4166A;
	Mon, 22 Jan 2024 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936687;
	bh=UQJgDJ1jQGsA5dFTTO+ji4AWSQKmt22PQx0vxvlz2bA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eF9eAoxRJf/brDqvElgArHmgdPeNAo8ieOCn2xi4ufFMxorFWtZ69VUCmexzh/sTP
	 +BUe+qq0YinH8u65eRct5dmhzAWFFKqlNJaJq3gORFxSLqWHaK8bmTm7uGQKDIW2iI
	 BieFkdBIEZ3SEyP0Q+8D/ZiNvX3lytbJYySqYooKSLLOUvw4G1RmIOTPeoEcZGNtiJ
	 A97D5pgdGQt06pSe+FpwzwaOzXbKSAnn7bA+4Rf6cYXtmesshM9PUMKkTZOUiNwyI8
	 ApQJ9IXiznE6UZvl7XLRgjAysbckvDqpYHK+EfVEDTPw5+WgadpXzK1+9wg+AQRyM9
	 wZsFayL+0k0lw==
Date: Mon, 22 Jan 2024 16:18:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, 
	Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] netfs, afs, cifs, cachefiles, erofs: Miscellaneous
 fixes
Message-ID: <20240122-bezwingen-kanister-b56f5bc1bc84@brauner>
References: <20240122123845.3822570-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240122123845.3822570-1-dhowells@redhat.com>

On Mon, Jan 22, 2024 at 12:38:33PM +0000, David Howells wrote:
> Hi Christian,
> 
> Here are some miscellaneous fixes for netfslib and a number of filesystems:
> 
>  (1) Replace folio_index() with folio->index in netfs, afs and cifs.
> 
>  (2) Fix an oops in fscache_put_cache().
> 
>  (3) Fix error handling in netfs_perform_write().
> 
>  (4) Fix an oops in cachefiles when not using erofs ondemand mode.
> 
>  (5) In afs, hide silly-rename files from getdents() to avoid problems with
>      tar and suchlike.
> 
>  (6) In afs, fix error handling in lookup with a bulk status fetch.
> 
>  (7) In afs, afs_dynroot_d_revalidate() is redundant, so remove it.
> 
>  (8) In afs, fix the RCU unlocking in afs_proc_addr_prefs_show().
> 
> The patches can also be found here:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thank you! I can pull this in right and will send a pr together with the
other changes around Wednesday/Thursday for -rc2. So reviews before that
would be nice.

