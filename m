Return-Path: <linux-fsdevel+bounces-9590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC418431CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 01:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0059FB24BE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 00:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016384C90;
	Wed, 31 Jan 2024 00:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDTNjGjy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605934C6F;
	Wed, 31 Jan 2024 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706660581; cv=none; b=hewC3G0sssuubHhHYQUYn2eniKIBVwoRBl2L1kH4zCZIrjdXET2GvM2SoPtfhsznzMM9ajCPIqkNW+xAc+yMMVzyC0BF2E1m8vW7ena5iYDWC+w1zzABzunl7UEJXczE3OAQ+Ub4HsF/TtT0RKElvdgZwxveHKpc40TIlx0V+5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706660581; c=relaxed/simple;
	bh=ZHcmK97bEwj2r3qzU94neICtQokjkJ+hHC+srZkKdz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/OuBG6bai6tae1YoFzYZiTsywrdNluxxnCiwCdOknUpaYBp/pNYzAsYvD2Hv14xytNA04tM3VwNOnWA3n9aW4SPl8kIbVV1QM5FD6awRDDV1n4/c3VI2ExHHuduMIf/+KWgqpk1YPFYJDQmPDjVlbCsVkSRy4qqB2cnvC5xcnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDTNjGjy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D3CC433F1;
	Wed, 31 Jan 2024 00:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706660580;
	bh=ZHcmK97bEwj2r3qzU94neICtQokjkJ+hHC+srZkKdz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDTNjGjypkWJm6CTVfPNj3ZBHYWA9TADsGf+ary7R9O5cPhHWun/I+BStulvVfXtW
	 2U8o2IOFEkvbyEKBSV4rcnqvG3DXCGrWzPeutmmYgQQGW0oHtqwoNUgmLWAAwtyz88
	 sWtr7nggk9zY/yDLPe9NBRALy2O6cc9OJW2Q+wm58C6shrPDs1aCrEIX3K33tpeT2W
	 f2A6U8T8XU7Mz/I9D/P9CC6UA51duIvSCNHg94zj6xwo7pDlw9UzWRlgsdybfp7vd7
	 laIj59dS6GVYbPxaGgZmkNGRYXUwaAzpJ6zElEPG9N52waM7TN/UFOs4ibFjUq4Erd
	 uDgCv/MmLnbaQ==
Date: Tue, 30 Jan 2024 16:22:58 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	amir73il@gmail.com, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 01/12] ovl: Reject mounting over case-insensitive
 directories
Message-ID: <20240131002258.GA2020@sol.localdomain>
References: <20240129204330.32346-1-krisman@suse.de>
 <20240129204330.32346-2-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129204330.32346-2-krisman@suse.de>

On Mon, Jan 29, 2024 at 05:43:19PM -0300, Gabriel Krisman Bertazi wrote:
> ovl: Reject mounting over case-insensitive directories

Maybe:

    ovl: Reject mounting over rootdir of case-insensitive capable FS

or:

    ovl: Always reject mounting over case-insensitive directories

... since as your commit message explains, overlayfs already does reject
mounting over case-insensitive directories, just not in all cases.

> Since commit bb9cd9106b22 ("fscrypt: Have filesystems handle their
> d_ops"), we set ->d_op through a hook in ->d_lookup, which
> means the root dentry won't have them, causing the mount to accidentally
> succeed.

But this series changes that.  Doesn't that make this overlayfs fix redundant?
It does improve the error message, which is helpful, but your commit message
makes it sound like it's an actual fix, not just an error message improvement.

- Eric

