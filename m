Return-Path: <linux-fsdevel+bounces-6530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDEE81943F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 00:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9FE1C23DB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 23:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959433D0C4;
	Tue, 19 Dec 2023 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1paRRI5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7D273FD;
	Tue, 19 Dec 2023 23:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22131C433C8;
	Tue, 19 Dec 2023 23:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703026841;
	bh=hHJulODtDt71xBDQ4Kigub7raLKaCHtkE0PAl5iwWM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1paRRI5Tq0qTgXygPdUnER2lIsTcDSHZucDxNTTgprXGzrFxtuZXwheJoqsQE/ck
	 JlmlAsbU6ShcUl0ot2RHvMyU7yNp8ESSUj+HWGTbnHmWeY/BB/SIjBY5voUXjdpGJZ
	 Ya0JA5TWQfsVxYVuTGts0QiTbQMxEyjMvvDV5hVslNiGUuS1awPU0Edr9n+FT8wiTY
	 GQamGF11orinqxEa72HXGmSHFecdznNX2svTHt+1umgfV57K+mj3SmECLUz3p4Lk2+
	 ExIfEvAWEOFNT3wdivWuiQ4eh9SvmEhMt5arWLAYhbUIC+TmZv5Hd1dIZVy+lhJP3q
	 oNOj4RoX3BeNg==
Date: Tue, 19 Dec 2023 16:00:29 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] fscrypt: Drop d_revalidate if key is available
Message-ID: <20231219230029.GG38652@quark.localdomain>
References: <20231215211608.6449-1-krisman@suse.de>
 <20231215211608.6449-3-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215211608.6449-3-krisman@suse.de>

On Fri, Dec 15, 2023 at 04:16:02PM -0500, Gabriel Krisman Bertazi wrote:
> fscrypt dentries are always valid once the key is available.  Since the
> key cannot be removed without evicting the dentry, we don't need to keep
> retrying to revalidate it.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

IIUC, this patch minimizes the overhead of fscrypt_d_revalidate() both for
encrypted and unencrypted dentries.  That's what's needed (seeing as this series
makes fscrypt_d_revalidate be installed on unencrypted dentries), but the commit
message only mentions the encrypted case.  It would be helpful to mention both.

> ---
>  fs/crypto/fname.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> index 7b3fc189593a..0457ba2d7d76 100644
> --- a/fs/crypto/fname.c
> +++ b/fs/crypto/fname.c
> @@ -591,8 +591,15 @@ int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
>  	 * reverting to no-key names without evicting the directory's inode
>  	 * -- which implies eviction of the dentries in the directory.
>  	 */
> -	if (!(dentry->d_flags & DCACHE_NOKEY_NAME))
> +	if (!(dentry->d_flags & DCACHE_NOKEY_NAME)) {
> +		/*
> +		 * If fscrypt is the only feature requiring
> +		 * revalidation for this dentry, we can just disable it.
> +		 */
> +		if (dentry->d_op->d_revalidate == &fscrypt_d_revalidate)

No need for the & in &fscrypt_d_revalidate.

- Eric

