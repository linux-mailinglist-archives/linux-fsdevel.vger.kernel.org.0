Return-Path: <linux-fsdevel+bounces-8836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D5E83B7A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 04:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7E51C2455B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 03:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E158163D1;
	Thu, 25 Jan 2024 03:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A00aORVz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC4A1FB2;
	Thu, 25 Jan 2024 03:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152374; cv=none; b=F6CNIEqrzfAdKKSl9ZXYtMgdU2wqBBRxPkoa6P09885JxjzoeRDJZWCAxC59zLrDGlnzy3BIzmCwiyurPdlQolUA/009HCOKEG5oyQSb+Rl4sUU1Lcch6xtr8r37H0DEsI+AXRAZoomc5HxPiPfubZvRz1bH0A8x4QneXwz9ZUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152374; c=relaxed/simple;
	bh=fRk1oYOWwebE3Gwdrh/Tnqsxt6v+AVSd7r7lMjh5y1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xy1r2LpZgJlf58eVxpfnyEq6WAJrTMVSHQ4x1V2qd55d77xpokl9xMzYdO+YKY5Ei57TvDcRF0OVp99s99y8hxjswD9jbcTxFEWfL/TxUAIc/txpUN6Tj/EwsRpTTTQlasSVckTDBzzbYqKh1LRVJgcJu8EkfEdfZnPP0MxpGek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A00aORVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763FBC433C7;
	Thu, 25 Jan 2024 03:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706152373;
	bh=fRk1oYOWwebE3Gwdrh/Tnqsxt6v+AVSd7r7lMjh5y1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A00aORVzedzHs30RWLFcTiWlC03VdaDvQqDuKIAniFdAVLKuMFWQwxb59IXtBz2js
	 biOOHxBJXNbV378sLsEZGXvS6lPyMptuibzGnJvQkqseD6lrRtyTeMKtB8mXtpbXSx
	 4Pv1Ln6RLbqUw4p/jGh/OIqpEAo8vZua8MzySaGj2g6Rn+HM8ilr3C649ktYm+KQxq
	 WhkYcxMLZRZcUiTXCT0TRYg30Qym+0RffALXDgmH3PKCar90DVOLimPGCPIgo7pfcf
	 YTEAglBkTetGeXVcp+JEsx32RwjkZVRMtm6LCS7LJyGymi76fkcv/tS/ve/NGo1uxA
	 +/ugfqmnbe8Cw==
Date: Wed, 24 Jan 2024 19:12:51 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com
Subject: Re: [PATCH v3 04/10] fscrypt: Drop d_revalidate once the key is added
Message-ID: <20240125031251.GC52073@sol.localdomain>
References: <20240119184742.31088-1-krisman@suse.de>
 <20240119184742.31088-5-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119184742.31088-5-krisman@suse.de>

On Fri, Jan 19, 2024 at 03:47:36PM -0300, Gabriel Krisman Bertazi wrote:
> /*
>  * When d_splice_alias() moves a directory's no-key alias to its plaintext alias
>  * as a result of the encryption key being added, DCACHE_NOKEY_NAME must be
>  * cleared.  Note that we don't have to support arbitrary moves of this flag
>  * because fscrypt doesn't allow no-key names to be the source or target of a
>  * rename().
>  */
>  static inline void fscrypt_handle_d_move(struct dentry *dentry)
>  {
>  	dentry->d_flags &= ~DCACHE_NOKEY_NAME;
> +
> +	/*
> +	 * Save the d_revalidate call cost during VFS operations.  We
> +	 * can do it because, when the key is available, the dentry
> +	 * can't go stale and the key won't go away without eviction.
> +	 */
> +	if (dentry->d_op && dentry->d_op->d_revalidate == fscrypt_d_revalidate)
> +		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
>  }

Is there any way to optimize this further for the case where fscrypt is not
being used?  This is called unconditionally from d_move().  I've generally been
trying to avoid things like this where the fscrypt support slows things down for
everyone even when they're not using the feature.

In any case, as always please don't let function comments get outdated.  Since
it now seems to just describe the DCACHE_NOKEY_NAME clearing and not the whole
function, maybe it should be moved to above that line.

- Eric

