Return-Path: <linux-fsdevel+bounces-13677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E2F872E23
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 05:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151A52881B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 04:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67747179B5;
	Wed,  6 Mar 2024 04:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs2nJo+f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAC95381;
	Wed,  6 Mar 2024 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709700945; cv=none; b=DTM3tHPy2F/oac24NBwU+nBTTe4UZoC1Qn9TWOEOv+Ae9jtY512HGl0Gkq+fA4NURMfPisAXJFa0RVXg2lkzRbQsLKrBLgaRTY3NpWZFoqQdoqS8tF2GQYaj1wE4Xp5jSgXVGadBPuprxlOltid7LxwtxvHLftRua0VMN0c7iL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709700945; c=relaxed/simple;
	bh=bLS/2YmDiBKieGAl7eWNm92KseLkvKzZk8QaUGF1/BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tv8NPvAosk4O4xyfQBIJbyKsT1AJ9YvywSwrNrj6ldGURKn0p9/0bfdu220P0QheWarf5BVDZZQgES9riVOZzUMFlZ8pTU95Hqgt0ISfi6/SScrpYgCS7BP5Bnjb48SvUAecKdC2qKXA4X/lPJu4IcONF1drnMvQ+eMsQwG6FNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs2nJo+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1797BC433F1;
	Wed,  6 Mar 2024 04:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709700945;
	bh=bLS/2YmDiBKieGAl7eWNm92KseLkvKzZk8QaUGF1/BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cs2nJo+fvJ0EgNd9xj98MZeVbWKUhTzOQCw42OEsdILdHAte3QgZna+kdq9sbB1or
	 UMbC/QzdT9na6/ateNtf1fxR4RUlZPlOanV6wqrezBBo2Zqe/37xhl/Q9g03WckKo1
	 XXArCSKjTJPfmVg0mnIxj9zTTwj/fyvY70yXbaw0sS9siYNPW7IoD/WYra1GKupt4w
	 c98VyLthx0NrRoFnX5dHzpTBA5bnomnHYuvFEQn/AVfO3YjGnDCTRk/Z8/Kl6R3D0B
	 lUUoIZ9ZsdQRiqpXLoHSuLzZXzMiGLoT9TDVgHMMx65atxZiu6Ul5CbFqovRCu8bUS
	 Bli+9Yyq/G99w==
Date: Tue, 5 Mar 2024 20:55:43 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org
Subject: Re: [PATCH v5 21/24] xfs: add fs-verity support
Message-ID: <20240306045543.GC68962@sol.localdomain>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-23-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304191046.157464-23-aalbersh@redhat.com>

On Mon, Mar 04, 2024 at 08:10:44PM +0100, Andrey Albershteyn wrote:
> +static void
> +xfs_verity_put_listent(
> +	struct xfs_attr_list_context	*context,
> +	int				flags,
> +	unsigned char			*name,
> +	int				namelen,
> +	int				valuelen)
> +{
> +	struct fsverity_blockbuf	block = {
> +		.offset = xfs_fsverity_name_to_block_offset(name),
> +		.size = valuelen,
> +	};
> +	/*
> +	 * Verity descriptor is smaller than 1024; verity block min size is
> +	 * 1024. Exclude verity descriptor
> +	 */
> +	if (valuelen < 1024)
> +		return;
> +

Is there no way to directly check whether it's the verity descriptor?  The
'valuelen < 1024' check is fragile because it will break if support for smaller
Merkle tree block sizes is ever added.  (Silently, because this is doing
invalidation which is hard to test and we need to be super careful with.)

If you really must introduce the assumption that the Merkle tree block size is
at least 1024, this needs to be documented in the comment in
fsverity_init_merkle_tree_params() that explains the reasoning behind the
current restrictions on the Merkle tree block size.

- Eric

