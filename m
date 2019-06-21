Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C31CF4F098
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2019 00:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfFUWAL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 18:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfFUWAK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 18:00:10 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05E6120679;
        Fri, 21 Jun 2019 22:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561154410;
        bh=hUnaoo5Fb3iD0gMCezjWig2sF2hiXRU9hbzHDO5W2lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tSfkN83sBckuomdVEtOy4k3noQiM89Lmivj0BzVuvFLSEdTbiw7IaDsGirwrQerw/
         MW4Dqx+UYmefgeEdCRAP32VCR2cAaFOlIb2y53zDI6KZ6fMGMqL3UjvZ0vDOk6EUWj
         9gQs/C4xiuuXjWZ+2QiLjWqlFcg60PmwhQ8pcMYw=
Date:   Fri, 21 Jun 2019 15:00:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chandan Rajendra <chandan@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V3 3/7] fscrypt: remove struct fscrypt_ctx
Message-ID: <20190621220007.GE167064@gmail.com>
References: <20190616160813.24464-1-chandan@linux.ibm.com>
 <20190616160813.24464-4-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616160813.24464-4-chandan@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 16, 2019 at 09:38:09PM +0530, Chandan Rajendra wrote:
> -/**
> - * fscrypt_get_ctx() - Get a decryption context
> - * @gfp_flags:   The gfp flag for memory allocation
> - *
> - * Allocate and initialize a decryption context.
> - *
> - * Return: A new decryption context on success; an ERR_PTR() otherwise.
> - */
> -struct fscrypt_ctx *fscrypt_get_ctx(gfp_t gfp_flags)
> -{
> -	struct fscrypt_ctx *ctx;
> -	unsigned long flags;
> -
> -	/*
> -	 * First try getting a ctx from the free list so that we don't have to
> -	 * call into the slab allocator.
> -	 */
> -	spin_lock_irqsave(&fscrypt_ctx_lock, flags);
> -	ctx = list_first_entry_or_null(&fscrypt_free_ctxs,
> -					struct fscrypt_ctx, free_list);
> -	if (ctx)
> -		list_del(&ctx->free_list);
> -	spin_unlock_irqrestore(&fscrypt_ctx_lock, flags);
> -	if (!ctx) {
> -		ctx = kmem_cache_zalloc(fscrypt_ctx_cachep, gfp_flags);
> -		if (!ctx)
> -			return ERR_PTR(-ENOMEM);
> -		ctx->flags |= FS_CTX_REQUIRES_FREE_ENCRYPT_FL;
> -	} else {
> -		ctx->flags &= ~FS_CTX_REQUIRES_FREE_ENCRYPT_FL;
> -	}
> -	return ctx;
> -}
> -EXPORT_SYMBOL(fscrypt_get_ctx);

FS_CTX_REQUIRES_FREE_ENCRYPT_FL is no longer used, so should be removed.

- Eric
