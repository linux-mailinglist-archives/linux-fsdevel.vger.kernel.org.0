Return-Path: <linux-fsdevel+bounces-16143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68746899342
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 04:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00001F2294F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 02:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A5B175AA;
	Fri,  5 Apr 2024 02:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDnz1m2B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5DA171AA;
	Fri,  5 Apr 2024 02:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712284935; cv=none; b=d1eeTRsP30+ie+qKJY5Lkj6Bo8cVqB/EQadDB5uvhlM79pRlhxLkB2mzfFemg36hlv85Czmx773nwoumYo+NHTEpgqYtPUcsDFSoePji6mK6YOvLVbzufImGQxeBz8xp3ubLoNvZXN3yG1plHXgWHO84P/wpMCWM6SXa3yBG/oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712284935; c=relaxed/simple;
	bh=d53/LKoru6gSZuBHm3s/aQcfyEAiYQQy8rSogjX99bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3WH/qIG2+bORIoQeaEM5cOaIORoX0LHRCaRlifT3co65kSD2TrL3Ma415AR9VmzP0gJtae/YxJv/6bnFusX/ccvRbtFfGBLelmnTubs2Q0UArMFkPVNIfAgaWdm7YwqMJPNJCS+z/BoSNbwfXwHtcnZ1YImd5NekB96ftVCiyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDnz1m2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D6CC433C7;
	Fri,  5 Apr 2024 02:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712284935;
	bh=d53/LKoru6gSZuBHm3s/aQcfyEAiYQQy8rSogjX99bM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDnz1m2BMFaNhlUJqO+zVKyFsH3PUSoWegi/BPsEnhkUm7K67gLabaXbylVwAU8DE
	 HWKhreJP1TFij4CzYUIUwvl2BFZF36IssWBnBCyctkFMCYphF6/10Yf6yP8Yalle2D
	 v0PytbblzfgPjEWB4QHRRCeCvWLy25Y8/4UwextCijvxliNj7US/dNbhgbCJ/tNIY/
	 A3KY5Um8uvvbxJFVGCB2UNT3opHKh+6B5MGb5z3XCklAUcA6Xs9Lxi5pldLkb20Y4A
	 9kli9EeMSUuXL8WKtPtZ+JS3Gn0Qr8yyj+Hs02JdPQDBpivKDNmTxXR6qjJ0vU2D7V
	 3lAy+4n48w9RQ==
Date: Thu, 4 Apr 2024 22:42:12 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 06/13] fsverity: send the level of the merkle tree block
 to ->read_merkle_tree_block
Message-ID: <20240405024212.GD1958@quark.localdomain>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175867965.1987804.16949621858616176182.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175867965.1987804.16949621858616176182.stgit@frogsfrogsfrogs>

On Fri, Mar 29, 2024 at 05:34:14PM -0700, Darrick J. Wong wrote:
> +/**
> + * struct fsverity_readmerkle - Request to read a Merkle Tree block buffer
> + * @inode: the inode to read
> + * @level: expected level of the block; level 0 are the leaves, -1 means a
> + * streaming read
> + * @num_levels: number of levels in the tree total
> + * @log_blocksize: log2 of the size of the expected block
> + * @ra_bytes: The number of bytes that should be prefetched starting at pos
> + *		if the page at @block->offset isn't already cached.
> + *		Implementations may ignore this argument; it's only a
> + *		performance optimization.
> + */
> +struct fsverity_readmerkle {
> +	struct inode *inode;
> +	unsigned long ra_bytes;
> +	int level;
> +	int num_levels;
> +	u8 log_blocksize;
> +};

This struct should be introduced in the patch that adds ->read_merkle_tree_block
originally.

- Eric

