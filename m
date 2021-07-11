Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8F83C3E82
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jul 2021 19:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbhGKRrf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 13:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232999AbhGKRrd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 13:47:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CAFD61153;
        Sun, 11 Jul 2021 17:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626025486;
        bh=AunWFpEBTvppLmOE8HRvKrazR9bLTM9rMms+fo8lf5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMOXvMsNFASFp+m49G6NkcW/xN86yHCUBIoCL4OZFHcKFk4VcSVQqDfAey9k+xpNE
         dfReM1wY9RNgloRj1VJ9UHOxz0nZB7HCGTmTeBVKTk4wbWWOKXgkxa3/mez88nu7Au
         0JWZMsW/nd+K4qabVTVaYz42wdomiyFlIs2AI53jNMM2JmmyW2WPCYumCUHv0A7T83
         rw6GXxAXHq2RB0FKkfkx5aVDtHkaUYvVvgHtFTHMCkmSJQuHdzNCux4mnp16P1+jCd
         VVf+2EKZ3tPti/cfY5Moz6mZ8C5NB0P+N8/nr2QY6uiBGB5yMi9dGAa/vRTAHQRSza
         5gEO7U4+7f5BQ==
Date:   Sun, 11 Jul 2021 12:44:43 -0500
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Subject: Re: [RFC PATCH v7 04/24] fscrypt: add fscrypt_context_for_new_inode
Message-ID: <YOsuC9qGRyUTb4qh@quark.localdomain>
References: <20210625135834.12934-1-jlayton@kernel.org>
 <20210625135834.12934-5-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625135834.12934-5-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 25, 2021 at 09:58:14AM -0400, Jeff Layton wrote:
> Most filesystems just call fscrypt_set_context on new inodes, which
> usually causes a setxattr. That's a bit late for ceph, which can send
> along a full set of attributes with the create request.
> 
> Doing so allows it to avoid race windows that where the new inode could
> be seen by other clients without the crypto context attached. It also
> avoids the separate round trip to the server.
> 
> Refactor the fscrypt code a bit to allow us to create a new crypto
> context, attach it to the inode, and write it to the buffer, but without
> calling set_context on it. ceph can later use this to marshal the
> context into the attributes we send along with the create request.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/crypto/policy.c      | 34 ++++++++++++++++++++++++++++------
>  include/linux/fscrypt.h |  1 +
>  2 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
> index ed3d623724cd..6a895a31560f 100644
> --- a/fs/crypto/policy.c
> +++ b/fs/crypto/policy.c
> @@ -664,6 +664,31 @@ const union fscrypt_policy *fscrypt_policy_to_inherit(struct inode *dir)
>  	return fscrypt_get_dummy_policy(dir->i_sb);
>  }
>  
> +/**
> + * fscrypt_context_for_new_inode() - create an encryption context for a new inode
> + * @ctx: where context should be written
> + * @inode: inode from which to fetch policy and nonce
> + *
> + * Given an in-core "prepared" (via fscrypt_prepare_new_inode) inode,
> + * generate a new context and write it to ctx. ctx _must_ be at least
> + * FSCRYPT_SET_CONTEXT_MAX_SIZE bytes.
> + *
> + * Returns size of the resulting context or a negative error code.
> + */
> +int fscrypt_context_for_new_inode(void *ctx, struct inode *inode)

This generates a kerneldoc warning because "Returns" should be "Return:".

- Eric
