Return-Path: <linux-fsdevel+bounces-6529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0368193EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 23:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E84E1F27346
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 22:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AB73D0BD;
	Tue, 19 Dec 2023 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaB2a4GW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030903B195;
	Tue, 19 Dec 2023 22:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4BFC433C7;
	Tue, 19 Dec 2023 22:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703026571;
	bh=1KsVpI26Wy0emSPFohmEhY9TLu8feCCZJtIibblPW04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RaB2a4GW2tUetf4bOxFILnQyWYM33jV3DBMa354fhOl6Z3uVP5FGxm2oMt0P669Rx
	 KhlHLCVk2012BYjCdKhL12/gdt/fFQDdNb4dUtKAlU1zTFYkfoeMen9/J7mLn/e4uy
	 FSBd03r1T+IEST4c6dmc+ptQFP+bqhjRl3I3zHOnFzJIoKuXZoR2rNL2p4niND4jn9
	 8A/wpofnnPdEx6z50q8pG+HQGPxmf2jevYxgkGMB15dcPQ27JUExUqiZPOfH3+jTm1
	 mwPD3Yq80OQiodZMbXzAHQwfwuAq7wD6rUfIvt+l5wVw3HjrHiABX4zqUYRTRRUl20
	 Nd6BtGxeO7Wtw==
Date: Tue, 19 Dec 2023 15:56:09 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] libfs: Expose generic_ci_dentry_ops outside of
 libfs
Message-ID: <20231219225609.GF38652@quark.localdomain>
References: <20231215211608.6449-1-krisman@suse.de>
 <20231215211608.6449-5-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215211608.6449-5-krisman@suse.de>

On Fri, Dec 15, 2023 at 04:16:04PM -0500, Gabriel Krisman Bertazi wrote:
> In preparation to allow filesystems to set this through sb->s_d_op,
> expose the symbol directly to the filesystems.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> ---
>  fs/libfs.c         | 2 +-
>  include/linux/fs.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 52c944173e57..b8ecada3a5b2 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1765,7 +1765,7 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
>  	return 0;
>  }
>  
> -static const struct dentry_operations generic_ci_dentry_ops = {
> +const struct dentry_operations generic_ci_dentry_ops = {
>  	.d_hash = generic_ci_d_hash,
>  	.d_compare = generic_ci_d_compare,

This needs an EXPORT_SYMBOL_GPL(), since the filesystems that will use this can
be loadable modules.

- Eric

