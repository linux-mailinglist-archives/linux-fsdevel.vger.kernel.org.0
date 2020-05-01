Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736931C0DD4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 07:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgEAFjL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 01:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgEAFjK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 01:39:10 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EB8F2073E;
        Fri,  1 May 2020 05:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588311549;
        bh=EmHczoYX1gH+WJOEfLomOHaDIvsOJKfq7lv+knH4aj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kpjhOY8nWbejt3yw6PAEswI/MenT6OCoaSS/I4K2EfaSeVjPzSy0OtWr9DzEqHvO9
         PAScSPEh0I5Ud4bdntPCcyHVUrNOq1jDuapUJoUDJQxWzWjaAJrgTA8Y5woYqGrX+8
         v3KK860ubuW1fSoVKE4/UT+Dw4e87u8f2xIx5AHY=
Date:   Thu, 30 Apr 2020 22:39:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
Message-ID: <20200501053908.GC1003@sol.localdomain>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428105859.4719-2-jth@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 12:58:58PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Add authentication support for a BTRFS file-system.
> 
> This works, because in BTRFS every meta-data block as well as every
> data-block has a own checksum. For meta-data the checksum is in the
> meta-data node itself. For data blocks, the checksums are stored in the
> checksum tree.
> 
> When replacing the checksum algorithm with a keyed hash, like HMAC(SHA256),
> a key is needed to mount a verified file-system. This key also needs to be
> used at file-system creation time.
> 
> We have to used a keyed hash scheme, in contrast to doing a normal
> cryptographic hash, to guarantee integrity of the file system, as a
> potential attacker could just replay file-system operations and the
> changes would go unnoticed.
> 
> Having a keyed hash only on the topmost Node of a tree or even just in the
> super-block and using cryptographic hashes on the normal meta-data nodes
> and checksum tree entries doesn't work either, as the BTRFS B-Tree's Nodes
> do not include the checksums of their respective child nodes, but only the
> block pointers and offsets where to find them on disk.
> 
> Also note, we do not need a incompat R/O flag for this, because if an old
> kernel tries to mount an authenticated file-system it will fail the
> initial checksum type verification and thus refuses to mount.
> 
> The key has to be supplied by the kernel's keyring and the method of
> getting the key securely into the kernel is not subject of this patch.

This is a good idea, but can you explain exactly what security properties you
aim to achieve?

As far as I can tell, btrfs hashes each data block individually.  There's no
contextual information about where eaech block is located or which file(s) it
belongs to.  So, with this proposal, an attacker can still replace any data
block with any other data block.  Is that what you have in mind?  Have you
considered including contextual information in the hashes, to prevent this?

What about metadata blocks -- how well are they authenticated?  Can they be
moved around?  And does this proposal authenticate *everything* on the
filesystem, or is there any part that is missed?  What about the superblock?

You also mentioned preventing replay of filesystem operations, which suggests
you're trying to achieve rollback protection.  But actually this scheme doesn't
provide rollback protection.  For one, an attacker can always just rollback the
entire filesystem to a previous state.

This feature would still be useful even with the above limitations.  But what is
your goal exactly?  Can this be made better?

> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index d10c7be10f3b..fe403fb62178 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -17,6 +17,7 @@
>  #include <linux/error-injection.h>
>  #include <linux/crc32c.h>
>  #include <linux/sched/mm.h>
> +#include <keys/user-type.h>
>  #include <asm/unaligned.h>
>  #include <crypto/hash.h>
>  #include "ctree.h"
> @@ -339,6 +340,7 @@ static bool btrfs_supported_super_csum(u16 csum_type)
>  	case BTRFS_CSUM_TYPE_XXHASH:
>  	case BTRFS_CSUM_TYPE_SHA256:
>  	case BTRFS_CSUM_TYPE_BLAKE2:
> +	case BTRFS_CSUM_TYPE_HMAC_SHA256:
>  		return true;
>  	default:
>  		return false;
> @@ -2187,6 +2189,9 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
>  {
>  	struct crypto_shash *csum_shash;
>  	const char *csum_driver = btrfs_super_csum_driver(csum_type);
> +	struct key *key;
> +	const struct user_key_payload *ukp;
> +	int err = 0;
>  
>  	csum_shash = crypto_alloc_shash(csum_driver, 0, 0);
>  
> @@ -2198,7 +2203,53 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
>  
>  	fs_info->csum_shash = csum_shash;
>  
> -	return 0;
> +	/*
> +	 * if we're not doing authentication, we're done by now. Still we have
> +	 * to validate the possible combinations of BTRFS_MOUNT_AUTH_KEY and
> +	 * keyed hashes.
> +	 */
> +	if (csum_type == BTRFS_CSUM_TYPE_HMAC_SHA256 &&
> +	    !btrfs_test_opt(fs_info, AUTH_KEY)) {
> +		crypto_free_shash(fs_info->csum_shash);
> +		return -EINVAL;

Seems there should be an error message here that says that a key is needed.

> +	} else if (btrfs_test_opt(fs_info, AUTH_KEY)
> +		   && csum_type != BTRFS_CSUM_TYPE_HMAC_SHA256) {
> +		crypto_free_shash(fs_info->csum_shash);
> +		return -EINVAL;

The hash algorithm needs to be passed as a mount option.  Otherwise the attacker
gets to choose it for you among all the supported keyed hash algorithms, as soon
as support for a second one is added.  Maybe use 'auth_hash_name' like UBIFS
does?

> +	} else if (!btrfs_test_opt(fs_info, AUTH_KEY)) {
> +		/*
> +		 * This is the normal case, if noone want's authentication and
> +		 * doesn't have a keyed hash, we're done.
> +		 */
> +		return 0;
> +	}
> +
> +	key = request_key(&key_type_logon, fs_info->auth_key_name, NULL);
> +	if (IS_ERR(key))
> +		return PTR_ERR(key);

Seems this should print an error message if the key can't be found.

Also, this should enforce that the key description uses a service prefix by
formatting it as kasprintf("btrfs:%s", fs_info->auth_key_name).  Otherwise
people can abuse this feature to use keys that were added for other kernel
features.  (This already got screwed up elsewhere, which makes the "logon" key
type a bit of a disaster.  But there's no need to make it worse.)

- Eric
