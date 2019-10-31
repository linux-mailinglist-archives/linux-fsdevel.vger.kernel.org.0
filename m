Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE94AEB6F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 19:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfJaScS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 14:32:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbfJaScS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YIQLgr0QUAjT6Vgld7VuI1RjHuqXoPLbB+Fldq3S0no=; b=G8td/5PdYCmMPCVqretMWZK8u
        +NOlob8H3V+ZEijNBXQr15G3BinlVG62wuWilKFiioqO4lLBa7NxGPDGRfdST3yi7vuy7InWswN/f
        Gy6LNoT1HE9+mMpMOOJZ7bik4frb9b4B5Okmrx3VzrgOscl6IYSNhluH68VOVm4PLKMstAXRFzRfi
        K9+dPh8sBiCN6Nm/Gx62HkvJk96cBW5HfE8LIUKYlnsms3rpdldOYhwRpEOWU67rnfIKXb5qdHTeH
        7wi1VrrfIT2yYUT2pUVCiSFZq4BhuZl0KVHWrsMubjDVyuqUNE7fua2xqjCUMq1CsSqzZaAxwvYxM
        sbAMZAXuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQFF3-0004yA-S3; Thu, 31 Oct 2019 18:32:17 +0000
Date:   Thu, 31 Oct 2019 11:32:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v5 7/9] fscrypt: add inline encryption support
Message-ID: <20191031183217.GF23601@infradead.org>
References: <20191028072032.6911-1-satyat@google.com>
 <20191028072032.6911-8-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028072032.6911-8-satyat@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> index 1f4b8a277060..956798debf71 100644
> --- a/fs/crypto/bio.c
> +++ b/fs/crypto/bio.c
> @@ -46,26 +46,38 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
>  {
>  	const unsigned int blockbits = inode->i_blkbits;
>  	const unsigned int blocksize = 1 << blockbits;
> +	const bool inlinecrypt = fscrypt_inode_uses_inline_crypto(inode);
>  	struct page *ciphertext_page;
>  	struct bio *bio;
>  	int ret, err = 0;
>  
> -	ciphertext_page = fscrypt_alloc_bounce_page(GFP_NOWAIT);
> -	if (!ciphertext_page)
> -		return -ENOMEM;
> +	if (inlinecrypt) {
> +		ciphertext_page = ZERO_PAGE(0);
> +	} else {
> +		ciphertext_page = fscrypt_alloc_bounce_page(GFP_NOWAIT);
> +		if (!ciphertext_page)
> +			return -ENOMEM;

I think you just want to split this into two functions for the
inline crypto vs not cases.

> @@ -391,6 +450,16 @@ struct fscrypt_master_key {
>  	 */
>  	struct crypto_skcipher	*mk_iv_ino_lblk_64_tfms[__FSCRYPT_MODE_MAX + 1];
>  
> +#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
> +	/* Raw keys for IV_INO_LBLK_64 policies, allocated on-demand */
> +	u8			*mk_iv_ino_lblk_64_raw_keys[__FSCRYPT_MODE_MAX + 1];
> +
> +	/* The data unit size being used for inline encryption */
> +	unsigned int		mk_data_unit_size;
> +
> +	/* The filesystem's block device */
> +	struct block_device	*mk_bdev;

File systems (including f2fs) can have multiple underlying block
devices.  

> +{
> +	const struct inode *inode = ci->ci_inode;
> +	struct super_block *sb = inode->i_sb;
> +
> +	/* The file must need contents encryption, not filenames encryption */
> +	if (!S_ISREG(inode->i_mode))
> +		return false;

But that isn't really what the check checks for..

> +	/* The filesystem must be mounted with -o inlinecrypt */
> +	if (!sb->s_cop->inline_crypt_enabled ||
> +	    !sb->s_cop->inline_crypt_enabled(sb))
> +		return false;

So please add a SB_* flag for that option instead of the weird
indirection.

> +/**
> + * fscrypt_inode_uses_inline_crypto - test whether an inode uses inline encryption

This adds an overly long line.  This happens many more times in the
patch.

Btw, I'm not happy about the 8-byte IV assumptions everywhere here.
That really should be a parameter, not hardcoded.
