Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC71EEB9AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 23:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbfJaWZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 18:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387442AbfJaWZG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 18:25:06 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E73562080F;
        Thu, 31 Oct 2019 22:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572560705;
        bh=ftYhWj4O4+ImXsZ36eQsPiXlqWILGWsZJF3VA/2bPe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lxrpMWOZi/jca6U4O0ffuqvB0mi6Hjw9uCnz33WOlQcUfN2d++AGFEaDrQv6W8FkU
         kKJpvd5fHygSqAPexEN/vOxQnp+sb1OHcalAvJOW2V+chhq+UrBufMHIOJkKNDCzuz
         XpNn9I+zWcBk3MwpOZndqUfdhbhYyMt4lgDpWtys=
Date:   Thu, 31 Oct 2019 15:25:03 -0700
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
Message-ID: <20191031222500.GB111219@gmail.com>
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
 <20191031202125.GA111219@gmail.com>
 <20191031212103.GA6244@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031212103.GA6244@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 31, 2019 at 02:21:03PM -0700, Christoph Hellwig wrote:
> On Thu, Oct 31, 2019 at 01:21:26PM -0700, Eric Biggers wrote:
> > > > +	/* The file must need contents encryption, not filenames encryption */
> > > > +	if (!S_ISREG(inode->i_mode))
> > > > +		return false;
> > > 
> > > But that isn't really what the check checks for..
> > 
> > This is how fscrypt has always worked.  The type of encryption to do is
> > determined as follows:
> > 
> > S_ISREG() => contents encryption
> > S_ISDIR() || S_ISLNK() => filenames encryption
> > 
> > See e.g. select_encryption_mode(), and similar checks elsewhere in
> > fs/{crypto,ext4,f2fs}/.
> > 
> > Do you have a suggestion to make it clearer?
> 
> Maybe have a fscrypt_content_encryption helper that currently
> evaluates to S_ISREG(inode->i_mode) as that documents the intent?

It's more important to clean up the IS_ENCRYPTED(inode) &&
S_ISREG(inode->i_mode) checks that are duplicated in fs/{ext4,f2fs}/, so I've
been thinking of adding a helper:

static inline bool fscrypt_needs_contents_encryption(const struct inode *inode)
{
        return IS_ENABLED(CONFIG_FS_ENCRYPTION) && IS_ENCRYPTED(inode) &&
               S_ISREG(inode->i_mode);
}

It could be used here too, though only S_ISREG() is actually needed here, so it
wouldn't be as good of a fit.

Anyway, this will need to be a separate cleanup.

> 
> > > > +	/* The filesystem must be mounted with -o inlinecrypt */
> > > > +	if (!sb->s_cop->inline_crypt_enabled ||
> > > > +	    !sb->s_cop->inline_crypt_enabled(sb))
> > > > +		return false;
> > > 
> > > So please add a SB_* flag for that option instead of the weird
> > > indirection.
> > 
> > IMO it's not really "weird" given that the point of the fscrypt_operations is to
> > expose filesystem-specific stuff to fs/crypto/.  But yes, using one of the SB_*
> > bits would make it simpler, so if people are fine with that we'll do that.
> 
> I think that is much simpler.  Additionally it could also replace the
> need for the has_stable_inodes and get_ino_and_lblk_bits methods, which
> are pretty weird.  Instead just document the requirements for the
> SB_INLINE_CRYPT flag and handle the rest in the file system.  That is
> for f2f always set it, and for ext4 set it based on s_inodes_count.
> Which brings me to:
> 

I don't think combining these things is a good idea because it would restrict
the use of inline encryption to filesystems that allow IV_INO_LBLK_64 encryption
policies, i.e. filesystems that have stable inode numbers, 32-bit inodes, and
32-bit file logical block numbers.

The on-disk format (i.e. the type of encryption policy chosen) and the
implementation (inline or filesystem-layer crypto) are really two separate
things.  This was one of the changes in v4 => v5 of this patchset; these two
things used to be conflated but now they are separate.  Now you can use inline
encryption with the existing fscrypt policies too.

We could use two separate SB_* flags, like SB_INLINE_CRYPT and
SB_IV_INO_LBLK_64_SUPPORT.  However, the ->has_stable_inodes() and
->get_ino_and_lblk_bits() methods are nice because they separate the filesystem
properties from the question of "is this encryption policy supported".
Declaring the filesystem properties is easier to do because it doesn't require
any fscrypt-specific knowledge.  Also, fs/crypto/ could use these properties in
different ways in the future, e.g. if another IV generation scheme is added.

> > > 
> > > Btw, I'm not happy about the 8-byte IV assumptions everywhere here.
> > > That really should be a parameter, not hardcoded.
> > 
> > To be clear, the 8-byte IV assumption doesn't really come from fs/crypto/, but
> > rather in what the blk-crypto API provides.  If blk-crypto were to provide
> > longer IV support, fs/crypto/ would pretty easily be able to make use of it.
> 
> That's what I meant - we hardcode the value in fscrypt.  Instead we need
> to expose the size from blk-crypt and check for it.
> 

If we add variable-length IV support, I think it should be handled in the same
way as crypto algorithms.  The current model is that the bio submitter doesn't
need to check whether the crypto algorithm is supported by the device, because
blk-crypto will fall back to the crypto API if needed.  Unsupported IV lengths
could be handled in the same way.

- Eric
