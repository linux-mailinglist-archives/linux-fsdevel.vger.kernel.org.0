Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC955185EB3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 18:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgCORUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 13:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728634AbgCORUJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 13:20:09 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A404206E9;
        Sun, 15 Mar 2020 17:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584292808;
        bh=bAeTblsoxv+HFw200CM9Fo21wbK4gQ0eQ+AlWbrz0/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRv0yGuN17hv3d3+XX/JErNuOlQ9wEp2jXMDSSfAdKpQFimOJFZNYD4p+r7FN4mEh
         5DFaGOTng+jHOnJaslTMvshAzPnWw0R85Z0mtXdrqX1rBpNsOcbSNPgEvw0G6KN5bV
         UK9YdrCVshpeCuEUEdP6m4SiLxIad2uylRMWyEm8=
Date:   Sun, 15 Mar 2020 10:20:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v8 09/11] fscrypt: add inline encryption support
Message-ID: <20200315172006.GB1055@sol.localdomain>
References: <20200312080253.3667-1-satyat@google.com>
 <20200312080253.3667-10-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312080253.3667-10-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 01:02:51AM -0700, Satya Tangirala wrote:
> +int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
> +				     const u8 *raw_key,
> +				     const struct fscrypt_info *ci)
> +{
> +	const struct inode *inode = ci->ci_inode;
> +	struct super_block *sb = inode->i_sb;
> +	enum blk_crypto_mode_num crypto_mode = ci->ci_mode->blk_crypto_mode;
> +	unsigned int blk_crypto_dun_bytes;

'blk_crypto_dun_bytes' is overly verbose.  'dun_bytes' would still be just as
clear.

This comment also applies to the parameter to blk_crypto_init_key().

> +/**
> + * fscrypt_set_bio_crypt_ctx_bh - prepare a file contents bio for inline
> + *				  encryption
> + * @bio: a bio which will eventually be submitted to the file
> + * @first_bh: the first buffer_head for which I/O will be submitted
> + * @gfp_mask: memory allocation flags
> + *
> + * Same as fscrypt_set_bio_crypt_ctx(), except this takes a buffer_head instead
> + * of an inode and block number directly.
> + */
> +void fscrypt_set_bio_crypt_ctx_bh(struct bio *bio,
> +				 const struct buffer_head *first_bh,
> +				 gfp_t gfp_mask)
> +{
> +	const struct inode *inode;
> +	u64 first_lblk;
> +
> +	if (bh_get_inode_and_lblk_num(first_bh, &inode, &first_lblk))
> +		fscrypt_set_bio_crypt_ctx(bio, inode, first_lblk, gfp_mask);
> +}
> +EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx_bh);

Nit: the continuation lines for the function arguments aren't aligned.

- Eric
