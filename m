Return-Path: <linux-fsdevel+bounces-12535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613078609D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 05:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CAAB1C22833
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 04:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED27D10A2B;
	Fri, 23 Feb 2024 04:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb3X3mKM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441FE1097D;
	Fri, 23 Feb 2024 04:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708662419; cv=none; b=ANyRDPdSTH1FwmANphPivUZbma4nQybHmHC2djLJjaJ2pjbJGCwF4TETWF936WsgHTXztLSWUkwImEjVujaxClyvaAEx48Ocw/8aqdSI54S0hEZKqOWowIH/qQhN2eYqmo0HiUyRKn1nrVUlGunjWlTMNnhPSi4ahYCRMNbAxdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708662419; c=relaxed/simple;
	bh=gJwJm5b0wNqyzUONKTm6BhlBmk+WHnsxUmzLF29r9/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNix6kZ7OUF9Naubp1KuuVG7zsNa0Ks0wZfMlG1GOPTO8Qu1trKO/Fe54zh/kEJCEbpBNHJxKXRk9gYq8fd25ZeoKf6awqBuI238tsfCLMmYOwZSI0DdAhXNkNQdQiwJZT/1D+4a/Qc13lwCKYYVaaZ57HbTWWIMvy58LfSqfEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb3X3mKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A80DC433C7;
	Fri, 23 Feb 2024 04:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708662418;
	bh=gJwJm5b0wNqyzUONKTm6BhlBmk+WHnsxUmzLF29r9/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mb3X3mKMANBJpKJpxkNCoqC7UhDEhNkmvkgUTe7KdlbKl++8qfxfjGJ9K4DB9wkFG
	 tDxIJEVTni0g8VCGZluaSNcExMXcDdQx6M025rKkEZ5B2o9VLhJE3SfqsWiHZvT+Zi
	 8UVT/y/0XPLgQv6W27bT1e1YNHhqM1y+qwkN4BSlEqSGWdW5KQ4UgiYGIbQ9AMKJXe
	 /I8p0MPZDhli9uTGlvdqr5HyHoyHbapZe7bbbZLIrJL/HsumRVsW8zK/SBWVeAx7aY
	 G/rbAjNtUrfPcUSt6ltavPXgwTJ+TH+4xIbZIkhR/5RY2YFVbt3bajTBJmTX5Syph7
	 OIm1DjR2wtTQg==
Date: Thu, 22 Feb 2024 20:26:56 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org
Subject: Re: [PATCH v4 06/25] fsverity: pass log_blocksize to
 end_enable_verity()
Message-ID: <20240223042656.GB25631@sol.localdomain>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
 <20240212165821.1901300-7-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212165821.1901300-7-aalbersh@redhat.com>

On Mon, Feb 12, 2024 at 05:58:03PM +0100, Andrey Albershteyn wrote:
> XFS will need to know log_blocksize to remove the tree in case of an

tree_blocksize

> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index 1eb7eae580be..ab7b0772899b 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -51,6 +51,7 @@ struct fsverity_operations {
>  	 * @desc: the verity descriptor to write, or NULL on failure
>  	 * @desc_size: size of verity descriptor, or 0 on failure
>  	 * @merkle_tree_size: total bytes the Merkle tree took up
> +	 * @tree_blocksize: size of the Merkle tree block

There may be many Merkle tree blocks, so it doesn't really make sense to write
"the Merkle tree block".  Maybe write "the Merkle tree block size".

Likewise in fs/btrfs/verity.c.

- Eric

