Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34367EB8D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 22:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbfJaVVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 17:21:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfJaVVE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 17:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TRZ+nTg/oBAxQOyMgulFSF0uTIrqlXXuEUAWLYjYp6Q=; b=C32SpKuxySxEeI5or3GY09+IG
        Ykcm2m1sSvMQQNPubmhrBYcD+aJ4810Jl/59sm7P/pHN1RpIdqQi7lSHLNc17qVdCfNGbNKJW7NDq
        cliqM6glMTyF6yIvMfzHclmo9CFUyLzhbr5cT8D9iKSzkjFTxrzVHcmULQs4+Yp7Fp5C7IxGt9Yje
        x9/GoOmHikPm2M/1LP0KSYfzOPa4GYz7qZLpRMwnrwwwTk9garomR5i7qqxo6NGGkoxLcHaBfe+I4
        IDaJnQ6TGUeikahzJ5XoLUc378+gd/JDDymwVtJ67mLIILUZ9eIw4U4IXbGjYXAsOX4vtSG4zzUby
        tfkO7Guow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQHsN-0008J2-Tj; Thu, 31 Oct 2019 21:21:03 +0000
Date:   Thu, 31 Oct 2019 14:21:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>,
        Satya Tangirala <satyat@google.com>,
        linux-scsi@vger.kernel.org, Kim Boojin <boojin.kim@samsung.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 7/9] fscrypt: add inline encryption support
Message-ID: <20191031212103.GA6244@infradead.org>
References: <20191028072032.6911-1-satyat@google.com>
 <20191028072032.6911-8-satyat@google.com>
 <20191031183217.GF23601@infradead.org>
 <20191031202125.GA111219@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031202125.GA111219@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 31, 2019 at 01:21:26PM -0700, Eric Biggers wrote:
> > > +	/* The file must need contents encryption, not filenames encryption */
> > > +	if (!S_ISREG(inode->i_mode))
> > > +		return false;
> > 
> > But that isn't really what the check checks for..
> 
> This is how fscrypt has always worked.  The type of encryption to do is
> determined as follows:
> 
> S_ISREG() => contents encryption
> S_ISDIR() || S_ISLNK() => filenames encryption
> 
> See e.g. select_encryption_mode(), and similar checks elsewhere in
> fs/{crypto,ext4,f2fs}/.
> 
> Do you have a suggestion to make it clearer?

Maybe have a fscrypt_content_encryption helper that currently
evaluates to S_ISREG(inode->i_mode) as that documents the intent?

> > > +	/* The filesystem must be mounted with -o inlinecrypt */
> > > +	if (!sb->s_cop->inline_crypt_enabled ||
> > > +	    !sb->s_cop->inline_crypt_enabled(sb))
> > > +		return false;
> > 
> > So please add a SB_* flag for that option instead of the weird
> > indirection.
> 
> IMO it's not really "weird" given that the point of the fscrypt_operations is to
> expose filesystem-specific stuff to fs/crypto/.  But yes, using one of the SB_*
> bits would make it simpler, so if people are fine with that we'll do that.

I think that is much simpler.  Additionally it could also replace the
need for the has_stable_inodes and get_ino_and_lblk_bits methods, which
are pretty weird.  Instead just document the requirements for the
SB_INLINE_CRYPT flag and handle the rest in the file system.  That is
for f2f always set it, and for ext4 set it based on s_inodes_count.
Which brings me to:

> > 
> > Btw, I'm not happy about the 8-byte IV assumptions everywhere here.
> > That really should be a parameter, not hardcoded.
> 
> To be clear, the 8-byte IV assumption doesn't really come from fs/crypto/, but
> rather in what the blk-crypto API provides.  If blk-crypto were to provide
> longer IV support, fs/crypto/ would pretty easily be able to make use of it.

That's what I meant - we hardcode the value in fscrypt.  Instead we need
to expose the size from blk-crypt and check for it.

> 
> (And if IVs >= 24 bytes were supported and we added AES-128-CBC-ESSIV and
> Adiantum support to blk-crypto.c, then inline encryption would be able to do
> everything that the existing filesystem-layer contents encryption can do.)
> 
> Do you have anything in mind for how to make the API support longer IVs in a
> clean way?  Are you thinking of something like:
> 
> 	#define BLK_CRYPTO_MAX_DUN_SIZE	24
> 
> 	u8 dun[BLK_CRYPTO_MAX_DUN_SIZE];
> 	int dun_size;
> 
> We do have to perform arithmetic operations on it, so a byte array would make it
> ugly and slower, but it should be possible...

Well, we could make it an array of u64s, which means we can do all the
useful arithmetics on components on one of them.  But I see the point,
this adds significant complexity for no real short term gain, and we
should probably postponed it until needed.  Maybe just document the
assumptions a little better.
