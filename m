Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C16B1B3B1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 11:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgDVJWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 05:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725924AbgDVJWz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:22:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A91C03C1A8;
        Wed, 22 Apr 2020 02:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LJwNwAXsE+S8zNNlabn/hmZ+oktxf4w2TKCPbz3Xd7Y=; b=FSRMb7ojsDy+kjVHZOZLeU26Hf
        9MCf1WYrctgxy1tuPfJMalhsl6zhO/V1ks4bbCVNwwHNLlr2jh6msWOiiWacT1kQsPEYAu/6kGWMb
        mMxQ8Zu4i1PrJBW9vFNyMWTpN5Lre4ufCpTj3uRHqN0wC2JGN3FonwPzsLmpEd9Tor932GVd0f33N
        rktqnNf+kW3RdvUgMu8GryUSirp+X5+Kwz3b2uQLGpT8DPabJ2LUrNxxSYFLzws1vD5KwGPX6T2RG
        VZJzk7YamFtFdSj9Y/sWS0kGIoyQLjwpuZmX+BuTl3PCVg67Sxts9J/5yjryJJPwe2kEvUDKf+T0o
        PdTaVhrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRBak-0006ab-6i; Wed, 22 Apr 2020 09:22:50 +0000
Date:   Wed, 22 Apr 2020 02:22:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v10 02/12] block: Keyslot Manager for Inline Encryption
Message-ID: <20200422092250.GA12290@infradead.org>
References: <20200408035654.247908-1-satyat@google.com>
 <20200408035654.247908-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408035654.247908-3-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +bool blk_ksm_crypto_cfg_supported(struct blk_keyslot_manager *ksm,
> +				  const struct blk_crypto_config *cfg)
> +{
> +	if (!ksm)
> +		return false;
> +	return (ksm->crypto_modes_supported[cfg->crypto_mode] &
> +		cfg->data_unit_size) &&
> +	       (ksm->max_dun_bytes_supported >= cfg->dun_bytes);

Nit: why not expand this a bit to be more readable:

	if (!(ksm->crypto_modes_supported[cfg->crypto_mode] &
			cfg->data_unit_size))
		return false;
	if (ksm->max_dun_bytes_supported < cfg->dun_bytes)
		return false;
	return true;

> +int blk_ksm_evict_key(struct blk_keyslot_manager *ksm,
> +		      const struct blk_crypto_key *key)
> +{
> +	struct blk_ksm_keyslot *slot;
> +	int err = 0;
> +
> +	blk_ksm_hw_enter(ksm);
> +	slot = blk_ksm_find_keyslot(ksm, key);
> +	if (!slot)
> +		goto out_unlock;
> +
> +	if (atomic_read(&slot->slot_refs) != 0) {
> +		err = -EBUSY;
> +		goto out_unlock;
> +	}

This check looks racy.
