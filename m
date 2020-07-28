Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5894F231531
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 23:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgG1Vuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 17:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgG1Vuo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 17:50:44 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90B1F2070A;
        Tue, 28 Jul 2020 21:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595973043;
        bh=CMGacDVfTN94BI5w3YcmjNfFox9Yr7ccfGOB0osi8HA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TF27vO0vUnRyvzaVF2d1RKzKyj5K+a7CKnkLShPaAUfVdKqUPTLoQVe43ypffe+ix
         Z9/VC9KciOR5TDGgWp6o35wQt1vueBvy+totihjiP8TbxHXPOkzOoTrdjUxUrCBT62
         IMuIyAUjPjSe2iBHeebnRuZzCT4zdQMC/oS9ud7s=
Date:   Tue, 28 Jul 2020 14:50:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Deven Bowers <deven.desai@linux.microsoft.com>
Cc:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        viro@zeniv.linux.org.uk, paul@paul-moore.com, eparis@redhat.com,
        jannh@google.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-audit@redhat.com, tyhicks@linux.microsoft.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, mdsakib@microsoft.com,
        nramas@linux.microsoft.com, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH v5 06/11] dm-verity: move signature check after tree
 validation
Message-ID: <20200728215041.GF4053562@gmail.com>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
 <20200728213614.586312-7-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728213614.586312-7-deven.desai@linux.microsoft.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 28, 2020 at 02:36:06PM -0700, Deven Bowers wrote:
> The CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG introduced by Jaskaran was
> intended to be used to allow an LSM to enforce verifications for all
> dm-verity volumes.
> 
> However, with it's current implementation, this signature verification
> occurs after the merkel-tree is validated, as a result the signature can
> pass initial verification by passing a matching root-hash and signature.
> This results in an unreadable block_device, but that has passed signature
> validation (and subsequently, would be marked as verified).
> 
> This change moves the signature verification to after the merkel-tree has
> finished validation.
> 
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> ---
>  drivers/md/dm-verity-target.c     |  44 ++++------
>  drivers/md/dm-verity-verify-sig.c | 140 ++++++++++++++++++++++--------
>  drivers/md/dm-verity-verify-sig.h |  24 +++--
>  drivers/md/dm-verity.h            |   2 +-
>  4 files changed, 134 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index eec9f252e935..fabc173aa7b3 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -471,9 +471,9 @@ static int verity_verify_io(struct dm_verity_io *io)
>  	struct bvec_iter start;
>  	unsigned b;
>  	struct crypto_wait wait;
> +	int r;
>  
>  	for (b = 0; b < io->n_blocks; b++) {
> -		int r;
>  		sector_t cur_block = io->block + b;
>  		struct ahash_request *req = verity_io_hash_req(v, io);
>  
> @@ -530,6 +530,16 @@ static int verity_verify_io(struct dm_verity_io *io)
>  			return -EIO;
>  	}
>  
> +	/*
> +	 * At this point, the merkel tree has finished validating.
> +	 * if signature was specified, validate the signature here.
> +	 */
> +	r = verity_verify_root_hash(v);
> +	if (r < 0) {
> +		DMERR_LIMIT("signature mismatch");
> +		return r;
> +	}
> +
>  	return 0;
>  }

This doesn't make any sense.

This just moves the signature verification to some random I/O.

The whole point of dm-verity is that data is verified on demand.  You can't know
whether any particular data or hash block is consistent with the root hash or
not until it is read and verified.

When the first I/O completes it might have just checked one block of a billion.

Not to mention that you didn't consider locking at all.

- Eric
