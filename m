Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E92C2B83DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 19:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgKRScF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 13:32:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbgKRScF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 13:32:05 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C14482076E;
        Wed, 18 Nov 2020 18:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605724324;
        bh=SF6czFyUVoCSbzDlPAUCgmPSS0JKy3lsEIQaFy7Bvvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMbgFoelI/TNirFp3bkkrWuOteC8rAKh1UcHpWZpjLMHq1i5ckHRjkE+oZlAjYvGC
         T/CRAZSXjsOjXTXPvrGWFb+PrT8dGRlcIirZsaZf55RaV+bviSwA0v7iYfL7x9tdfR
         tjIJPtI19BkRgjL0oDtuukfMOhO/99K8DTIP3qv8=
Date:   Wed, 18 Nov 2020 10:32:02 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v3 1/3] libfs: Add generic function for setting dentry_ops
Message-ID: <X7VooviygzLQoprL@sol.localdomain>
References: <20201118064245.265117-1-drosen@google.com>
 <20201118064245.265117-2-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118064245.265117-2-drosen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 06:42:43AM +0000, Daniel Rosenberg wrote:
> +#if IS_ENABLED(CONFIG_UNICODE) && IS_ENABLED(CONFIG_FS_ENCRYPTION)
> +static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
> +	.d_hash = generic_ci_d_hash,
> +	.d_compare = generic_ci_d_compare,
> +	.d_revalidate = fscrypt_d_revalidate,
> +};
> +#endif

One nit: it would be good to change the #if condition above to:

	#if defined(CONFIG_FS_ENCRYPTION) && defined(CONFIG_UNICODE)

... to make it identical to the #if condition later on:

> +#if defined(CONFIG_FS_ENCRYPTION) && defined(CONFIG_UNICODE)
> +	if (needs_encrypt_ops && needs_ci_ops) {
> +		d_set_d_op(dentry, &generic_encrypted_ci_dentry_ops);
> +		return;
> +	}
>  #endif

It doesn't actually matter, but it's nice to keep things consistent.

Otherwise, please feel free to add:

	Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
