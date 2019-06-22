Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3E164F8B1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2019 00:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfFVWoC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jun 2019 18:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfFVWoB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jun 2019 18:44:01 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 997D32084E;
        Sat, 22 Jun 2019 22:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561243440;
        bh=iYQDhANCCK0G30rvhkm7fehvp1qj9IVh4v7axFSmMDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v9rm9f4UnXG+IojsZCZMQscfYooXc2HeSrZMJbIbGXrZyS/a1XJ6VTTDKpvfOnwns
         Lo520pl0gERcKUUoy99M9nG6hAJQeL2sjSizQbFjzqRtTlq7tIJNAaeU/O6WmhbU3n
         cGGui0kXq2U+i05PpLOii8UzoX3BBopulnSWFURc=
Date:   Sat, 22 Jun 2019 15:44:00 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 12/16] fs-verity: add SHA-512 support
Message-ID: <20190622224400.GL19686@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190620205043.64350-1-ebiggers@kernel.org>
 <20190620205043.64350-13-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620205043.64350-13-ebiggers@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/20, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add SHA-512 support to fs-verity.  This is primarily a demonstration of
> the trivial changes needed to support a new hash algorithm in fs-verity;
> most users will still use SHA-256, due to the smaller space required to
> store the hashes.  But some users may prefer SHA-512.
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>

> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/verity/fsverity_private.h  | 2 +-
>  fs/verity/hash_algs.c         | 5 +++++
>  include/uapi/linux/fsverity.h | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> index eaa2b3b93bbf6b..02a547f0667c13 100644
> --- a/fs/verity/fsverity_private.h
> +++ b/fs/verity/fsverity_private.h
> @@ -29,7 +29,7 @@ struct ahash_request;
>   * Largest digest size among all hash algorithms supported by fs-verity.
>   * Currently assumed to be <= size of fsverity_descriptor::root_hash.
>   */
> -#define FS_VERITY_MAX_DIGEST_SIZE	SHA256_DIGEST_SIZE
> +#define FS_VERITY_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
>  
>  /* A hash algorithm supported by fs-verity */
>  struct fsverity_hash_alg {
> diff --git a/fs/verity/hash_algs.c b/fs/verity/hash_algs.c
> index 46df17094fc252..e0462a010cabfb 100644
> --- a/fs/verity/hash_algs.c
> +++ b/fs/verity/hash_algs.c
> @@ -17,6 +17,11 @@ struct fsverity_hash_alg fsverity_hash_algs[] = {
>  		.digest_size = SHA256_DIGEST_SIZE,
>  		.block_size = SHA256_BLOCK_SIZE,
>  	},
> +	[FS_VERITY_HASH_ALG_SHA512] = {
> +		.name = "sha512",
> +		.digest_size = SHA512_DIGEST_SIZE,
> +		.block_size = SHA512_BLOCK_SIZE,
> +	},
>  };
>  
>  /**
> diff --git a/include/uapi/linux/fsverity.h b/include/uapi/linux/fsverity.h
> index 57d1d7fc0c345a..da0daf6c193b4b 100644
> --- a/include/uapi/linux/fsverity.h
> +++ b/include/uapi/linux/fsverity.h
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  
>  #define FS_VERITY_HASH_ALG_SHA256	1
> +#define FS_VERITY_HASH_ALG_SHA512	2
>  
>  struct fsverity_enable_arg {
>  	__u32 version;
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
