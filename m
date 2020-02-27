Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D65CD172786
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 19:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbgB0SZp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 13:25:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:48138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729504AbgB0SZp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:25:45 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92AA12469C;
        Thu, 27 Feb 2020 18:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582827944;
        bh=ppmsgmJewgic6G8TyCPg5XN+BbEH2w+mIirTlE881lU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rv/J+aex7sJzrVtxikFTce8cCr8/2At1pTM6DS4zoQmnPK6LdfBrO3VcaDBml1o8j
         uZlALOG7V9KujDvjy4l3Yzoe2v9e4amlZ1g7tPPyYoCDeWkO3x8y/pZMpA/jHoajC5
         fNsOS3mWSF3O1iNaWOlI5CNtSb+C4H/O2cjhJHGE=
Date:   Thu, 27 Feb 2020 10:25:43 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v7 2/9] block: Inline encryption support for blk-mq
Message-ID: <20200227182543.GC877@sol.localdomain>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-3-satyat@google.com>
 <20200221172205.GB438@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221172205.GB438@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 09:22:05AM -0800, Christoph Hellwig wrote:
> > +int blk_crypto_evict_key(struct request_queue *q,
> > +			 const struct blk_crypto_key *key)
> > +{
> > +	if (q->ksm && blk_ksm_crypto_mode_supported(q->ksm, key))
> > +		return blk_ksm_evict_key(q->ksm, key);
> > +
> > +	return 0;
> > +}
> 
> Is there any point in this wrapper that just has a single caller?
> Als why doesn't blk_ksm_evict_key have the blk_ksm_crypto_mode_supported
> sanity check itself?

Later in the series it's changed to:

int blk_crypto_evict_key(struct request_queue *q,
                         const struct blk_crypto_key *key)
{
        if (q->ksm && blk_ksm_crypto_mode_supported(q->ksm, key))
                return blk_ksm_evict_key(q->ksm, key);

        return blk_crypto_fallback_evict_key(key);
}

I.e. if the encryption mode is using hardware, then the key needs to be evicted
from q->ksm.  Otherwise the key needs to be evicted from the fallback.

Also keep in mind that our goal is to define a clean API for any user of the
block layer to use encryption, not just fs/crypto/.  That API includes:

	blk_crypto_init_key()
	blk_crypto_start_using_key()
	bio_crypt_set_ctx()
	blk_crypto_evict_key()

If anyone else decides to use inline encryption (e.g., if inline encryption
support were added to dm-crypt or another device-mapper target), they'll use
these same functions.

So IMO it's important to define a clean API that won't need to be refactored as
soon as anyone else starts using it, and not e.g. micro-optimize for code length
based on there currently being only one user.

- Eric
