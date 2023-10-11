Return-Path: <linux-fsdevel+bounces-29-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BF97C485F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 05:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6891C20ECE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 03:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D182DC8F4;
	Wed, 11 Oct 2023 03:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ6dri7p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE3C2DF;
	Wed, 11 Oct 2023 03:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5971FC433C8;
	Wed, 11 Oct 2023 03:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696994348;
	bh=Kb2JHzlzl5FfsYaSgSAxUDUj44BcxpRhMaaJ6Tt9wF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZ6dri7p+wIgYcOjmnzJlNuCoQoKuWUAwzHN4SCaGUGM//h9klGKn/nJR9IWN8cuB
	 UEvSqedJ+9bPSuLuVrQraRUP8rtrBrH+MEErqbB6jcQk3pFJBX0ckgYJU1RY8HRQ+Q
	 yv7Mz88JDsNV0jorMk1JQHT4xtVHIinilrneumk6OggFEHNhNz9xsxuXjweP6VNRqS
	 NVSUgJ9C6TNjeLp2DdA6U2jG5RpefS80uls6VDz387j4M/2U/jhMtRwDg54iMujWMa
	 eYK9VbL3SEYEVqSKC6L0Zd3ALSYiZfvxkQVYcENS7sGgL7u45M9pwM7eo3VcWiBWqc
	 JyDDcwLpO4mkA==
Date: Tue, 10 Oct 2023 20:19:06 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, djwong@kernel.org, david@fromorbit.com,
	dchinner@redhat.com
Subject: Re: [PATCH v3 09/28] fsverity: pass log_blocksize to
 end_enable_verity()
Message-ID: <20231011031906.GD1185@sol.localdomain>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-10-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006184922.252188-10-aalbersh@redhat.com>

On Fri, Oct 06, 2023 at 08:49:03PM +0200, Andrey Albershteyn wrote:
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index 252b2668894c..cac012d4c86a 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -51,6 +51,7 @@ struct fsverity_operations {
>  	 * @desc: the verity descriptor to write, or NULL on failure
>  	 * @desc_size: size of verity descriptor, or 0 on failure
>  	 * @merkle_tree_size: total bytes the Merkle tree took up
> +	 * @log_blocksize: log size of the Merkle tree block
>  	 *
>  	 * If desc == NULL, then enabling verity failed and the filesystem only
>  	 * must do any necessary cleanups.  Else, it must also store the given
> @@ -65,7 +66,8 @@ struct fsverity_operations {
>  	 * Return: 0 on success, -errno on failure
>  	 */
>  	int (*end_enable_verity)(struct file *filp, const void *desc,
> -				 size_t desc_size, u64 merkle_tree_size);
> +				 size_t desc_size, u64 merkle_tree_size,
> +				 u8 log_blocksize);

Maybe just pass the block_size itself instead of log2(block_size)?

- Eric

