Return-Path: <linux-fsdevel+bounces-6531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD34819445
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 00:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C550B1F22B2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 23:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BD33D0BD;
	Tue, 19 Dec 2023 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NICUtxZI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB95340BE1;
	Tue, 19 Dec 2023 23:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAC7C433C8;
	Tue, 19 Dec 2023 23:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703027010;
	bh=LNmSsgchdIM5Serkn5TMo0rc39sfS64h30ok6s8DlJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NICUtxZIkUjCtz5zbDbYueae5fCt5NL880XbS5YavoRvFdNWiL6bGngTArDmwxWwg
	 IW1R3j2Mzz7JPoB02rKLhy0jgO1P2/b/TDwx/OdODB3PX8Q/Rsi8JOz0d6Xua3gVnV
	 8Yljsnztq9AZ50G/4/AGIvtKsVn+IImctooi5Ijh7vCXvZz1tV0Rg71sDr3vYINfpx
	 uqekrEQOnjA+AxHoSeh843klIcTqFxExNYi1tifGx+nzFg1hQG6Zn0vjrdgWGstHcb
	 IQnn80cxiXcPBKllqA+ttY/KpZgsAkmgmb4oo3L8MDMMwga8+W0Q55E3x5/QczkXMW
	 lUSZD7Ejk4l4A==
Date: Tue, 19 Dec 2023 16:03:28 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] fscrypt: Move d_revalidate configuration back
 into fscrypt
Message-ID: <20231219230328.GH38652@quark.localdomain>
References: <20231215211608.6449-1-krisman@suse.de>
 <20231215211608.6449-9-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215211608.6449-9-krisman@suse.de>

On Fri, Dec 15, 2023 at 04:16:08PM -0500, Gabriel Krisman Bertazi wrote:
>  int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
>  			     struct fscrypt_name *fname)
>  {
> @@ -106,6 +110,10 @@ int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
>  		spin_lock(&dentry->d_lock);
>  		dentry->d_flags |= DCACHE_NOKEY_NAME;
>  		spin_unlock(&dentry->d_lock);
> +
> +		/* Give preference to the filesystem hooks, if any. */
> +		if (!dentry->d_op)
> +			d_set_d_op(dentry, &fscrypt_dentry_ops);

I think that fscrypt_prepare_lookup_partial() should get this too, since it sets
DCACHE_NOKEY_NAME too (though currently the only filesystem that calls it has
its own d_revalidate anyway).

- Eric

