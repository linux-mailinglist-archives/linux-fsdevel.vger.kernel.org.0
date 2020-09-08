Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAF4260916
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 05:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgIHDsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 23:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbgIHDsc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 23:48:32 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 201F62080A;
        Tue,  8 Sep 2020 03:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599536912;
        bh=BDt9qw07kkZF1Lcrp4T9HXgGCBMRSO9bfF7nlbDDCew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DFmmr5XJzUfk65i4qjxse91dGexzX+t7PbSCJCi/k/6TPHGiVTAv9jaRiZ1Q4caKv
         4w+1LIP4PcocnGe62NemaTrXWiat9EjVdzMZ1Wq2Or5PhPdJZNULK1/WPXeoajTHQ9
         DzKckFjsy5UhCKmuhj6JUuDgeBmvxUjNealMkSvA=
Date:   Mon, 7 Sep 2020 20:48:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v2 04/18] fscrypt: add fscrypt_new_context_from_inode
Message-ID: <20200908034830.GE68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
 <20200904160537.76663-5-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904160537.76663-5-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 12:05:23PM -0400, Jeff Layton wrote:
> CephFS will need to be able to generate a context for a new "prepared"
> inode. Add a new routine for getting the context out of an in-core
> inode.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/crypto/policy.c      | 20 ++++++++++++++++++++
>  include/linux/fscrypt.h |  1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
> index c56ad886f7d7..10eddd113a21 100644
> --- a/fs/crypto/policy.c
> +++ b/fs/crypto/policy.c
> @@ -670,6 +670,26 @@ int fscrypt_set_context(struct inode *inode, void *fs_data)
>  }
>  EXPORT_SYMBOL_GPL(fscrypt_set_context);
>  
> +/**
> + * fscrypt_context_from_inode() - fetch the encryption context out of in-core inode

Comment doesn't match the function name.

Also, the name isn't very clear.  How about calling this
fscrypt_context_for_new_inode()?

BTW, I might rename fscrypt_new_context_from_policy() to
fscrypt_context_from_policy() in my patchset.  Since it now makes the caller
provide the nonce, technically it's no longer limited to "new" contexts.

> + * @ctx: where context should be written
> + * @inode: inode from which to fetch context
> + *
> + * Given an in-core prepared, but not-necessarily fully-instantiated inode,
> + * generate an encryption context from its policy and write it to ctx.

Clarify what is meant by "prepared" (fscrypt_prepare_new_inode() was called)
vs. "instantiated".

> + *
> + * Returns size of the context.
> + */
> +int fscrypt_new_context_from_inode(union fscrypt_context *ctx, struct inode *inode)
> +{
> +	struct fscrypt_info *ci = inode->i_crypt_info;
> +
> +	BUILD_BUG_ON(sizeof(*ctx) != FSCRYPT_SET_CONTEXT_MAX_SIZE);
> +
> +	return fscrypt_new_context_from_policy(ctx, &ci->ci_policy, ci->ci_nonce);
> +}
> +EXPORT_SYMBOL_GPL(fscrypt_new_context_from_inode);

fscrypt_set_context() should be changed to call this, instead of duplicating the
same logic.  As part of that, the WARN_ON_ONCE(!ci) that's currently in
fscrypt_set_context() should go in here instead.

- Eric
