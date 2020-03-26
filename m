Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE626193814
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 06:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgCZFpj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 01:45:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgCZFpj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 01:45:39 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BD722070A;
        Thu, 26 Mar 2020 05:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585201538;
        bh=YSqEiV8Q0V/gweaU5BWxLVtMdrabOmhnkS6bhf78yJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RPY4OHuDLW8zJQHKTlA+e6EKMRnhN4YdbX1yCtrF70JzGjUeavucVWe5Z66JFcmcf
         IG/D2dv9WHdysNOPX0U9tTAu5sced/R0W0jXjk8eSoodeyTQSTpn2MBQ3MM6bJ+5ZQ
         9pOAVQflwj7dde/PKK4vYjBZ+2dULFF5I7aYdVrE=
Date:   Wed, 25 Mar 2020 22:45:36 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v9 09/11] fscrypt: add inline encryption support
Message-ID: <20200326054536.GD858@sol.localdomain>
References: <20200326030702.223233-1-satyat@google.com>
 <20200326030702.223233-10-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326030702.223233-10-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 08:07:00PM -0700, Satya Tangirala wrote:
> +/* Enable inline encryption for this file if supported. */
> +void fscrypt_select_encryption_impl(struct fscrypt_info *ci)
> +{
> +	const struct inode *inode = ci->ci_inode;
> +	struct super_block *sb = inode->i_sb;
> +
> +	/* The file must need contents encryption, not filenames encryption */
> +	if (!fscrypt_needs_contents_encryption(inode))
> +		return;
> +
> +	/* blk-crypto must implement the needed encryption algorithm */
> +	if (ci->ci_mode->blk_crypto_mode == BLK_ENCRYPTION_MODE_INVALID)
> +		return;
> +
> +	/* The filesystem must be mounted with -o inlinecrypt */
> +	if (!(sb->s_flags & SB_INLINECRYPT))
> +		return;
> +
> +	ci->ci_inlinecrypt = true;
> +}

A bug I came across last week when writing a new test is that '-o inlinecrypt'
can break some fscrypt settings because it enables blk-crypto even when
CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is unset and the hardware doesn't support
the algorithm.  For example, adding '-o inlinecrypt' can make Adiantum-encrypted
files stop working, due to the hardware only supporting AES-XTS.

That's undesirable.  Adding '-o inlinecrypt' should just make inline encryption
be used where it can, and not break anything.

To fix this, we should make fscrypt_select_encryption_impl() only set
->ci_inlinecrypt if either blk-crypto-fallback is enabled or if all the
filesystem's devices support the algorithm.

In v7+ of this patchset, this is a bit tricky because now
blk_ksm_crypto_key_supported() takes in a 'struct blk_crypto_key', which
fscrypt_select_encryption_impl() doesn't have available yet.  Perhaps make
blk_ksm_crypto_key_supported() a wrapper around a function like
blk_ksm_crypto_setting_supported() that takes a new struct:

	struct blk_crypto_setting {
	        enum blk_crypto_mode_num crypto_mode;
		unsigned int data_unit_size;
		unsigned int dun_bytes;
	};

Then maybe add blk_crypto_setting_supported() which returns true if either
blk_ksm_crypto_key_supported() *or* blk-crypto-fallback is enabled.

- Eric
