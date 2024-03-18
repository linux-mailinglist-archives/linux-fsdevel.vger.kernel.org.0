Return-Path: <linux-fsdevel+bounces-14750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2725E87EDAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 17:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B79B20FC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38106548F6;
	Mon, 18 Mar 2024 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMX6cmvs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D1618029;
	Mon, 18 Mar 2024 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779929; cv=none; b=jZuOUi+22u45X1pKP+lsrvMn3eHBDTUwqhEcjs6x2LCP+HHbqOtqwdh8OyFVT9y4eWvEUytEyLjJ+K0JspDZvn/67K/t1En68WjXwSv13dLZ/PMfhTCvpuYvN1Az/d5/WEmVjvxGHVdGhHylBY+sS0iCDlQcOP+bpMXjEYz8SFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779929; c=relaxed/simple;
	bh=r/w0MpoYhI2VjKsZ/a7mRRzQ3HdE2iGjNIEVyNYpnSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEzx88gSdTP1+sA4MjajFXsodDi70RiiX9rNBUfkEyup70HQU2q3pGjt+Fq2yhfDXI8Dbw6hRgnT4/+m0Pg0xOJWgSOWF9WlFeSPqo6qiqVsvrBChhUCj9Obu+0A3Xw3r8mFaQxD47tGcBuAYq4W/EG/nmOWpjngpvk9YfEzog0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMX6cmvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AD8C433C7;
	Mon, 18 Mar 2024 16:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710779929;
	bh=r/w0MpoYhI2VjKsZ/a7mRRzQ3HdE2iGjNIEVyNYpnSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qMX6cmvsaBaskapC6MxYeGaNtUIK/9qC6GhAtEkvrd8NXm57Y21GQE7XuAgt1FUbr
	 GjEoao0gZUoOPKBGdiT5HlSlrBagZfvgH94q1s6a49HxxxBM3se4C2C7nq6aLthmth
	 1xWqkzSBytVjpT0u/JmUhCAJaHcuvlKAdujC7pXfVxuS6XBcOfX2WEQyVYcOBeouPC
	 kzFhX22DACkMN4RqGkp2n4v6hwk4J0lH+oxjOE3OW+ImC/9TTuKnpO69DvAbzOMqgy
	 PSrv3/F64nh3n+nSZxMhUB10xfXcRCa0GmENxcTFHot9aTNyAX8FFhbvB+h/Xt7I9X
	 7WhK0ydxy1UEQ==
Date: Mon, 18 Mar 2024 09:38:47 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 16/40] fsverity: pass the zero-hash value to the
 implementation
Message-ID: <20240318163847.GC1185@sol.localdomain>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
 <171069246170.2684506.16175333193381403848.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171069246170.2684506.16175333193381403848.stgit@frogsfrogsfrogs>

On Sun, Mar 17, 2024 at 09:27:34AM -0700, Darrick J. Wong wrote:
> diff --git a/fs/verity/open.c b/fs/verity/open.c
> index 7a86407732c4..433a70eeca55 100644
> --- a/fs/verity/open.c
> +++ b/fs/verity/open.c
> @@ -144,6 +144,13 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
>  		goto out_err;
>  	}
>  
> +	err = fsverity_hash_buffer(params->hash_alg, page_address(ZERO_PAGE(0)),
> +				   i_blocksize(inode), params->zero_digest);
> +	if (err) {
> +		fsverity_err(inode, "Error %d computing zero digest", err);
> +		goto out_err;
> +	}

This doesn't take the salt into account.  Also it's using the wrong block size
(filesystem block size instead of Merkle tree block size).

How about using fsverity_hash_block()?

- Eric

