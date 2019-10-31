Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1295EEB857
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 21:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbfJaUVa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 16:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfJaUVa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 16:21:30 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 743B620679;
        Thu, 31 Oct 2019 20:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572553288;
        bh=BSyRUPaH+mXAK4zJdVucB6akTWJfcAfLI9dB8KMYki8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PWsoWa+PQSYr3Krtph+vU2ZTnBmlcdobMyhqQkJBrFDxgk6xryiH1XIPmFbBt2bNu
         aLRYswaCrpoRrfp/NfM0bq8Vo3BBd5DPCx3d6Q6EFc7dq6ZaKpkMRz7iC4kZJ1KV4U
         Gbu+hxesaGzUn0a0sny2EY8oX/U4c0axderSrYps=
Date:   Thu, 31 Oct 2019 13:21:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Satya Tangirala <satyat@google.com>, linux-scsi@vger.kernel.org,
        Kim Boojin <boojin.kim@samsung.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 7/9] fscrypt: add inline encryption support
Message-ID: <20191031202125.GA111219@gmail.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
        Satya Tangirala <satyat@google.com>, linux-scsi@vger.kernel.org,
        Kim Boojin <boojin.kim@samsung.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20191028072032.6911-1-satyat@google.com>
 <20191028072032.6911-8-satyat@google.com>
 <20191031183217.GF23601@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031183217.GF23601@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph, thanks for reviewing this.

On Thu, Oct 31, 2019 at 11:32:17AM -0700, Christoph Hellwig wrote:
> > diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> > index 1f4b8a277060..956798debf71 100644
> > --- a/fs/crypto/bio.c
> > +++ b/fs/crypto/bio.c
> > @@ -46,26 +46,38 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
> >  {
> >  	const unsigned int blockbits = inode->i_blkbits;
> >  	const unsigned int blocksize = 1 << blockbits;
> > +	const bool inlinecrypt = fscrypt_inode_uses_inline_crypto(inode);
> >  	struct page *ciphertext_page;
> >  	struct bio *bio;
> >  	int ret, err = 0;
> >  
> > -	ciphertext_page = fscrypt_alloc_bounce_page(GFP_NOWAIT);
> > -	if (!ciphertext_page)
> > -		return -ENOMEM;
> > +	if (inlinecrypt) {
> > +		ciphertext_page = ZERO_PAGE(0);
> > +	} else {
> > +		ciphertext_page = fscrypt_alloc_bounce_page(GFP_NOWAIT);
> > +		if (!ciphertext_page)
> > +			return -ENOMEM;
> 
> I think you just want to split this into two functions for the
> inline crypto vs not cases.
> 
> > @@ -391,6 +450,16 @@ struct fscrypt_master_key {
> >  	 */
> >  	struct crypto_skcipher	*mk_iv_ino_lblk_64_tfms[__FSCRYPT_MODE_MAX + 1];
> >  
> > +#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
> > +	/* Raw keys for IV_INO_LBLK_64 policies, allocated on-demand */
> > +	u8			*mk_iv_ino_lblk_64_raw_keys[__FSCRYPT_MODE_MAX + 1];
> > +
> > +	/* The data unit size being used for inline encryption */
> > +	unsigned int		mk_data_unit_size;
> > +
> > +	/* The filesystem's block device */
> > +	struct block_device	*mk_bdev;
> 
> File systems (including f2fs) can have multiple underlying block
> devices.  

Yes, this is a bug: it causes the key to be evicted from only one device.

I'm thinking this might point to deeper problems with the inline encryption API
exposed to filesystems being too difficult to use correctly.  We might want to
move to something like:


struct blk_crypto_key_handle *
blk_crypto_prepare_key(struct request_queue *q, const u8 *raw_key,
                       enum blk_crypto_mode_num crypto_mode, unsigned int data_unit_size);

int bio_crypt_set_ctx(struct bio *bio, struct blk_crypto_key_handle *h,
		      u64 dun, gfp_t gfp_mask);

void blk_crypto_destroy_key(struct blk_crypto_key_handle *h);


Each handle would associate a raw_key, mode, and data_unit_size with a specific
keyslot_manager, which would allocate/evict a keyslot as needed for I/O.
blk_crypto_destroy_key() would both evict the keyslot and free the key.

For each key, multi-device filesystems would then need to allocate a handle for
each device.  This would force them to handle key eviction correctly.

Satya, any thoughts on this?

> 
> > +{
> > +	const struct inode *inode = ci->ci_inode;
> > +	struct super_block *sb = inode->i_sb;
> > +
> > +	/* The file must need contents encryption, not filenames encryption */
> > +	if (!S_ISREG(inode->i_mode))
> > +		return false;
> 
> But that isn't really what the check checks for..

This is how fscrypt has always worked.  The type of encryption to do is
determined as follows:

S_ISREG() => contents encryption
S_ISDIR() || S_ISLNK() => filenames encryption

See e.g. select_encryption_mode(), and similar checks elsewhere in
fs/{crypto,ext4,f2fs}/.

Do you have a suggestion to make it clearer?

> 
> > +	/* The filesystem must be mounted with -o inlinecrypt */
> > +	if (!sb->s_cop->inline_crypt_enabled ||
> > +	    !sb->s_cop->inline_crypt_enabled(sb))
> > +		return false;
> 
> So please add a SB_* flag for that option instead of the weird
> indirection.

IMO it's not really "weird" given that the point of the fscrypt_operations is to
expose filesystem-specific stuff to fs/crypto/.  But yes, using one of the SB_*
bits would make it simpler, so if people are fine with that we'll do that.

> 
> > +/**
> > + * fscrypt_inode_uses_inline_crypto - test whether an inode uses inline encryption
> 
> This adds an overly long line.  This happens many more times in the
> patch.

checkpatch reports 4 overly long lines in the patch, 3 of which are the first
line of kerneldoc comments.  For some reason I thought those are recommended to
be one line even if it exceeds 80 characters, but maybe I'm mistaken.

> 
> Btw, I'm not happy about the 8-byte IV assumptions everywhere here.
> That really should be a parameter, not hardcoded.

To be clear, the 8-byte IV assumption doesn't really come from fs/crypto/, but
rather in what the blk-crypto API provides.  If blk-crypto were to provide
longer IV support, fs/crypto/ would pretty easily be able to make use of it.

(And if IVs >= 24 bytes were supported and we added AES-128-CBC-ESSIV and
Adiantum support to blk-crypto.c, then inline encryption would be able to do
everything that the existing filesystem-layer contents encryption can do.)

Do you have anything in mind for how to make the API support longer IVs in a
clean way?  Are you thinking of something like:

	#define BLK_CRYPTO_MAX_DUN_SIZE	24

	u8 dun[BLK_CRYPTO_MAX_DUN_SIZE];
	int dun_size;

We do have to perform arithmetic operations on it, so a byte array would make it
ugly and slower, but it should be possible...

- Eric
