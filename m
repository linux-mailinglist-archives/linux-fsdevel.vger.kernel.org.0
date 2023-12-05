Return-Path: <linux-fsdevel+bounces-4839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A6A804A33
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 07:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017F81C20D49
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6229712E62
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbFmMCU4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E7F8F6B;
	Tue,  5 Dec 2023 05:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91712C433C8;
	Tue,  5 Dec 2023 05:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701753755;
	bh=W0MqYHnYXOVVDBXS1yfTCAUfAHD1WDSI3lkYsOly5II=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dbFmMCU4ruYQbdbQKzC/Z5uXVylZCH/S+wMl6d/GbSxMkEk5YqA4+PRslEmuNs1G1
	 asntUfWQVpBvW5KExT564/b9SD+YEs2nc4PVUg+pPYY39z+FGNAM/s1S+fJTV5xHp3
	 PO9UXdNVOHAV9mnW4sUBax9Hs7RF/bvuqnofPWBUmvpS7qLZqipmHmYcgWJGcoVHeb
	 RlPNmNWE0W+9a9OR5P4QFizFTg/2bRq3lXBeKtM9mzF3cMGWKG6kFNqH88oOtuFwYH
	 TBdewpFJeXzxLXFh9SNR4EJZrhxNhOkTawtBIGC99Cw8cB8kQ6I93La8JgUhetzgFu
	 fwdlTE5eV6NsA==
Date: Mon, 4 Dec 2023 21:22:34 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, Omar Sandoval <osandov@osandov.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH v4 12/46] btrfs: add inode encryption contexts
Message-ID: <20231205052234.GK1168@sol.localdomain>
References: <cover.1701468305.git.josef@toxicpanda.com>
 <a8ca3ba1888f9d116be9d7fec921b6f4bfa881d6.1701468306.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8ca3ba1888f9d116be9d7fec921b6f4bfa881d6.1701468306.git.josef@toxicpanda.com>

On Fri, Dec 01, 2023 at 05:11:09PM -0500, Josef Bacik wrote:
> From: Omar Sandoval <osandov@osandov.com>
> 
> In order to store encryption information for directories, symlinks,
> etc., fscrypt stores a context item with each encrypted non-regular
> inode. fscrypt provides an arbitrary blob for the filesystem to store,
> and it does not clearly fit into an existing structure, so this goes in
> a new item type.
> 

It's actually regular files too, right?

> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index d24e8e121507..08f561da33cd 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -164,6 +164,8 @@
>  #define BTRFS_VERITY_DESC_ITEM_KEY	36
>  #define BTRFS_VERITY_MERKLE_ITEM_KEY	37
>  
> +#define BTRFS_FSCRYPT_CTX_ITEM_KEY	41

Maybe call this BTRFS_FSCRYPT_INODE_CTX_ITEM_KEY?

- Eric

