Return-Path: <linux-fsdevel+bounces-59527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FFDB3AD47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 00:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9FA1C859A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 22:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD112C1597;
	Thu, 28 Aug 2025 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0JBcJ5T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F5D196C7C;
	Thu, 28 Aug 2025 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756418890; cv=none; b=TfhRvPFSLKyJ49SWH3FhmB1jqQmLxnw84W08HpkI5P/zxOvBRMQpaOj3rnq/mx1svEh5hZ+ggZ786voCaYytgNSCfbzMsqXYu/hdWVGxb5Ukv6Z8hnKq0S95TkkXqhzhj6rT4xjFDy0z2hxgel+s+3ui1ztdabtSFd8dnqjqxgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756418890; c=relaxed/simple;
	bh=7s7wCnA+kaDdW6PH7rDjRbKOID+Hf4L9ZgpKnKqV3C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itb0A3HfvqsTD+4Vxid28XETjHyolC5ZJRP21X8x6p1iebMdtRldFAnYY3aZAbA2RYHtIqJIeNazPAnD0PBP7HYmZXcFerzNomFzRZHGD8nAaSooz4rH3soHuhw9ooG4Dqq1TQqBwgV/aUhMiu0qYi+Ljps7mnZscGWwA5yj64U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0JBcJ5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6F0C4CEEB;
	Thu, 28 Aug 2025 22:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756418888;
	bh=7s7wCnA+kaDdW6PH7rDjRbKOID+Hf4L9ZgpKnKqV3C8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q0JBcJ5Tj4+bseq4+c+hSjVG3T3y0ZPFRadY3GucNDCYlzXq1LJT4TTKyXVy6GD1v
	 eNQq5xgKX7dRzoxiDm3B5bEImjVo4a+RjCBlJZ45QzoWu0sbokWIvaK4qrR0Myf1bt
	 zyOMXyZgnWqnUws6jFiAt/8I6RfGX/KiUVwVfWyELXO3W5qQcTQf7db+9UUw5CLkkm
	 BDx6ybjbnTgnhiSr81h3GzSwPzQ0eDoVWimEKsUhvVeZ0qRQrvF7AOLcE28aPwnUJf
	 iSPQKwBDnmLGHGb3woHO0x5hv46h42kGe9+GJMm+JmziAATZQkWRxzgJ7R2+jzZxX3
	 8DkUGOXgtNsmQ==
Date: Thu, 28 Aug 2025 22:08:06 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 23/54] fs: use refcount_inc_not_zero in igrab
Message-ID: <20250828220806.GA2077538@google.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <d40a41e428c07f88ea011fbf191bd8efac94c523.1756222465.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d40a41e428c07f88ea011fbf191bd8efac94c523.1756222465.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:23AM -0400, Josef Bacik wrote:
> +static inline struct inode *inode_tryget(struct inode *inode)
> +{
> +	/*
> +	 * We are using inode_tryget() because we're interested in getting a
> +	 * live reference to the inode, which is ->i_count. Normally we would
> +	 * grab i_obj_count first, as it is the higher priority reference.
> +	 * However we're only interested in making sure we have a live inode,
> +	 * and we know that if we get a reference for i_count then we can safely
> +	 * acquire i_obj_count because we always drop i_obj_count after dropping
> +	 * an i_count reference.
> +	 *
> +	 * This is meant to be used either in a place where we have an existing
> +	 * i_obj_count reference on the inode, or under rcu_read_lock() so we
> +	 * know we're safe in accessing this inode still.
> +	 */
> +	VFS_WARN_ON_ONCE(!iobj_count_read(inode) && !rcu_read_lock_held());
> +
> +	if (refcount_inc_not_zero(&inode->i_count)) {
> +		iobj_get(inode);
> +		return inode;
> +	}
> +
> +	/*
> +	 * If we failed to increment the reference count, then the
> +	 * inode is being freed or has been freed.  We return NULL
> +	 * in this case.
> +	 */
> +	return NULL;

Is there a reason to take one i_obj_count reference per i_count
reference, instead of a single i_obj_count reference associated with
i_count being nonzero?  With a single reference owned by i_count != 0,
it wouldn't be necessary to touch i_obj_count when i_count is changed,
except when i_count reaches zero.  That would be more efficient.

BTW, fscrypt_master_key::mk_active_refs and
fscrypt_master_key::mk_struct_refs use that solution.  For
mk_active_refs != 0, one reference in mk_struct_refs is held.

- Eric

