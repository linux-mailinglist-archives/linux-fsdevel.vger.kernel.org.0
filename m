Return-Path: <linux-fsdevel+bounces-16146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BABEB899365
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 04:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF001F224BF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 02:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D725517753;
	Fri,  5 Apr 2024 02:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdX/LMYJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6E1134A9;
	Fri,  5 Apr 2024 02:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285448; cv=none; b=f30jATIQK7B+A/LSEh1gXVQJY1UBEdpvcn7R9/V3mMs14PfLlODHih5oGAbqwgUPVvlqoTSMg5vQTpGQ/vwNHJdqtoGE/2cb0R/XNNts0/rBFch4hctSIhIl4GGHiltc6gqLE0LfpYkOycqHL1s+EGmv4RbUMsUk0E8HWX5CmHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285448; c=relaxed/simple;
	bh=m/o+EJXoyOzIuEZt0HywzSCVWNc37Pwrz2BSCqh8JcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iieLXR3POFRl7AOdTpO7H3WusApRH9TNfYRHqscpSLpVlsdSLMFnPiqnpIjaogBwUNWiYqvLDAyJv2Vl0zkLcadwcy6IcHp+PABg86iACcLOtbC2dYY4iwO+pRBiQ4I3oRl4TJ77CvbSFZy4h7XQMickEc1Wq1+kqdfb2y2B7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdX/LMYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F23C433C7;
	Fri,  5 Apr 2024 02:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712285447;
	bh=m/o+EJXoyOzIuEZt0HywzSCVWNc37Pwrz2BSCqh8JcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZdX/LMYJQ6de1qB3pXTq62bQOm9zqHvG747pdcRg4OXqfD/F/Xuh/JFNy6RGoKbz9
	 wGKec1Ey7GRoFkcuaYLq9SxAvqAkKebyjzuLT2yOgEZPuf3OAnci9Yo5JEX7yn2lp+
	 7r5Dr1TteiUEY41UM03webSZED9Ypp6k0/DIqeq1f5yhd/Nx8coe/6Dp9RRp2BmKob
	 5BRRtRjWOp27WSseqAW8vOeQ2vqDx4s/Htwz8eKeNbT2C7C5LcbWWS5NSW1FZYGNWC
	 NJNShryYuQUCKfx2JTezouwuUROybzrxHdPDpDpmEppOMgZGA+JPCf5/aBlzbimFcA
	 h+piaaHnwHetQ==
Date: Thu, 4 Apr 2024 22:50:45 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 08/13] fsverity: expose merkle tree geometry to callers
Message-ID: <20240405025045.GF1958@quark.localdomain>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175867998.1987804.8334701724660862039.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175867998.1987804.8334701724660862039.stgit@frogsfrogsfrogs>

On Fri, Mar 29, 2024 at 05:34:45PM -0700, Darrick J. Wong wrote:
> +/**
> + * fsverity_merkle_tree_geometry() - return Merkle tree geometry
> + * @inode: the inode for which the Merkle tree is being built

This function is actually for inodes that already have fsverity enabled.  So the
above comment is misleading.

> +int fsverity_merkle_tree_geometry(struct inode *inode, unsigned int *block_size,
> +				  u64 *tree_size)
> +{
> +	struct fsverity_info *vi;
> +	int error;
> +
> +	if (!IS_VERITY(inode))
> +		return -EOPNOTSUPP;

Maybe use ENODATA, similar to fsverity_ioctl_measure() and
bpf_get_fsverity_digest().

> +
> +	error = ensure_verity_info(inode);
> +	if (error)
> +		return error;
> +
> +	vi = fsverity_get_info(inode);

This can just use 'vi = inode->i_verity_info', since ensure_verity_info() was
called.

It should also be documented that an open need not have been done on the file
yet, as this behavior differs from functions like fsverity_get_digest() that
require that an open was done first.

- Eric

