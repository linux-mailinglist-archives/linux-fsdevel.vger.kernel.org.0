Return-Path: <linux-fsdevel+bounces-4847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 726BB804A45
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 07:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6501F21456
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9135C12E5F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jbrrt8bm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0636CD28B;
	Tue,  5 Dec 2023 05:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5AEC433C7;
	Tue,  5 Dec 2023 05:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701755681;
	bh=2sgftbqbAfkigqri4VIdWIpZUTDqlQL8Lt67PkAsZFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jbrrt8bm/XGC3K82fxJ9vtlZxFBWBhjmUxz3y7tUeTPQ+rXO+qRFQEu+pf/+yIxtt
	 AnEXxkXtc8UCc35foFnD2nKGVm+UQUG5BdGtHWjkrP/Mj/KdldWVR+dlJ0aHF/uNTC
	 XjSkQbnW/5VxbMTacXLnmY0vi54BQiY5VeYIMD5u06In0YjTVT8Je1yRZtitTsoB6f
	 OMNV/2tZVb7VcBXV2qUVosEjn3y6p1XRmY/Sz8kQWTH8M+BH3Nc56P6N0UAJqBOlGe
	 ZzyYXW98dhGAXOaKi64nLuVcaOu2sBK+6yHNBSus6MP/oD0Sw98v0tRyR+wC2USa6x
	 C7cHuzzb7UNng==
Date: Mon, 4 Dec 2023 21:54:39 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 46/46] btrfs: load the inode context before sending
 writes
Message-ID: <20231205055439.GO1168@sol.localdomain>
References: <cover.1701468305.git.josef@toxicpanda.com>
 <99694dd7249ea1edefcf13b9842447e530fc3f6f.1701468306.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99694dd7249ea1edefcf13b9842447e530fc3f6f.1701468306.git.josef@toxicpanda.com>

On Fri, Dec 01, 2023 at 05:11:43PM -0500, Josef Bacik wrote:
> For send we will read the pages and copy them into our buffer.  Use the
> fscrypt_inode_open helper to make sure the key is loaded properly before
> trying to read from the inode so the contents are properly decrypted.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/send.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index de77321777f4..3475b4cea09d 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -5392,6 +5392,37 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
>  	return ret;
>  }
>  
> +static int load_fscrypt_context(struct send_ctx *sctx)
> +{
> +	struct btrfs_root *root = sctx->send_root;
> +	struct name_cache_entry *nce;
> +	struct inode *dir;
> +	int ret;
> +
> +	if (!IS_ENCRYPTED(sctx->cur_inode))
> +		return 0;
> +
> +	/*
> +	 * We're encrypted, we need to load the parent inode in order to make
> +	 * sure the encryption context is loaded, we use this after calling
> +	 * get_cur_path() so our nce for the current inode should be here.  If
> +	 * not handle it, but ASSERT() for developers.
> +	 */
> +	nce = name_cache_search(sctx, sctx->cur_ino, sctx->cur_inode_gen);
> +	if (!nce) {
> +		ASSERT(nce);
> +		return -EINVAL;
> +	}
> +
> +	dir = btrfs_iget(root->fs_info->sb, nce->parent_ino, root);
> +	if (IS_ERR(dir))
> +		return PTR_ERR(dir);
> +
> +	ret = fscrypt_inode_open(dir, sctx->cur_inode);
> +	iput(dir);
> +	return ret;

fscrypt_file_open() is called even on unencrypted files, which results in strong
enforcement that encrypted directories don't contain unencrypted files.

The code above doesn't do that with fscrypt_inode_open().  That seems like a
bug; the rules for "send" internally "opening" a file should be the same as a
standard open, right?  Or did you do it this way intentionally?

- Eric

