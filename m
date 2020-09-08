Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD62262364
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 01:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgIHXIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 19:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbgIHXI2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 19:08:28 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFD2C2080A;
        Tue,  8 Sep 2020 23:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599606508;
        bh=dmlnVU6FdUmf4h4FX8sC3hnzZopv2kRpwI2tLxr7+jY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQ1adQxoUVde9vBweTWkwNga1shGJD0rhKPVthVw9yR9C+xGk4eUt25bQVKgA4z5c
         sL4985n7jJ0tQroTBxzChpQMRbl4W6848fmr4PhoVlWabb3aaD9nah11G5XMN4aObD
         nUWCq5ceSAPTuJDxqCCN2ZcPLEj2uhbIUSYBxUDk=
Date:   Tue, 8 Sep 2020 16:08:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v2 05/18] fscrypt: don't balk when inode is already
 marked encrypted
Message-ID: <20200908230826.GD3760467@gmail.com>
References: <20200904160537.76663-1-jlayton@kernel.org>
 <20200904160537.76663-6-jlayton@kernel.org>
 <20200908035233.GF68127@sol.localdomain>
 <448f739e1a23a3a275f36b36043a79930727e3c0.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448f739e1a23a3a275f36b36043a79930727e3c0.camel@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 08, 2020 at 08:54:35AM -0400, Jeff Layton wrote:
> On Mon, 2020-09-07 at 20:52 -0700, Eric Biggers wrote:
> > On Fri, Sep 04, 2020 at 12:05:24PM -0400, Jeff Layton wrote:
> > > Cephfs (currently) sets this flag early and only fetches the context
> > > later. Eventually we may not need this, but for now it prevents this
> > > warning from popping.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/crypto/keysetup.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
> > > index ad64525ec680..3b4ec16fc528 100644
> > > --- a/fs/crypto/keysetup.c
> > > +++ b/fs/crypto/keysetup.c
> > > @@ -567,7 +567,7 @@ int fscrypt_get_encryption_info(struct inode *inode)
> > >  		const union fscrypt_context *dummy_ctx =
> > >  			fscrypt_get_dummy_context(inode->i_sb);
> > >  
> > > -		if (IS_ENCRYPTED(inode) || !dummy_ctx) {
> > > +		if (!dummy_ctx) {
> > >  			fscrypt_warn(inode,
> > >  				     "Error %d getting encryption context",
> > >  				     res);
> > 
> > This makes errors reading the encryption xattr of an encrypted inode be ignored
> > when the filesystem is mounted with test_dummy_encryption.  That's undesirable.
> > 
> > Isn't this change actually no longer needed, now that new inodes will use
> > fscrypt_prepare_new_inode() instead of fscrypt_get_encryption_info()?
> 
> No. This is really for when we're reading in a new inode from the MDS.
> We can tell that there is a context present in some of those cases, but
> may not be able to read it yet. That said, it may be possible to pull in
> the context at the point where we set S_ENCRYPTED. I'll take a look.

fscrypt_prepare_new_inode() sets ->i_crypt_info on the new inode.
fscrypt_get_encryption_info() isn't needed after that.  If it does get called
anyway, it will be a no-op since it will see fscrypt_has_encryption_key(inode).

And when allocating an in-memory inode for an existing file,
fscrypt_get_encryption_info() shouldn't be called either.  It gets called later
by filesystem operations that need the encryption key, usually ->open().

- Eric
