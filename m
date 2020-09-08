Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD3F2616C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 19:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgIHRSi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 13:18:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731746AbgIHQSD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:18:03 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D6A322286;
        Tue,  8 Sep 2020 12:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599569676;
        bh=qHsmub80VG9U4Q5DCqgTf92EnAVS6x/iPsVvMSuowDc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kLcTHSTJsgVnkEU6SCWDTpda+yCxf298ICsxvcnq5N1l2jBiJ8CwsQm3LPZ+jzTKk
         2rS8i0qQ46sLpqNCdIGPYlZb7m0sHDnqhyI+kvRmxJ/f8GWkT6f6+qul5BSvjXiMg2
         YUo8ZfQZBQ4y2G7NrMiuSXuBVwEsE1WPWkjY5vIU=
Message-ID: <448f739e1a23a3a275f36b36043a79930727e3c0.camel@kernel.org>
Subject: Re: [RFC PATCH v2 05/18] fscrypt: don't balk when inode is already
 marked encrypted
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Date:   Tue, 08 Sep 2020 08:54:35 -0400
In-Reply-To: <20200908035233.GF68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
         <20200904160537.76663-6-jlayton@kernel.org>
         <20200908035233.GF68127@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-09-07 at 20:52 -0700, Eric Biggers wrote:
> On Fri, Sep 04, 2020 at 12:05:24PM -0400, Jeff Layton wrote:
> > Cephfs (currently) sets this flag early and only fetches the context
> > later. Eventually we may not need this, but for now it prevents this
> > warning from popping.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/crypto/keysetup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
> > index ad64525ec680..3b4ec16fc528 100644
> > --- a/fs/crypto/keysetup.c
> > +++ b/fs/crypto/keysetup.c
> > @@ -567,7 +567,7 @@ int fscrypt_get_encryption_info(struct inode *inode)
> >  		const union fscrypt_context *dummy_ctx =
> >  			fscrypt_get_dummy_context(inode->i_sb);
> >  
> > -		if (IS_ENCRYPTED(inode) || !dummy_ctx) {
> > +		if (!dummy_ctx) {
> >  			fscrypt_warn(inode,
> >  				     "Error %d getting encryption context",
> >  				     res);
> 
> This makes errors reading the encryption xattr of an encrypted inode be ignored
> when the filesystem is mounted with test_dummy_encryption.  That's undesirable.
> 
> Isn't this change actually no longer needed, now that new inodes will use
> fscrypt_prepare_new_inode() instead of fscrypt_get_encryption_info()?

No. This is really for when we're reading in a new inode from the MDS.
We can tell that there is a context present in some of those cases, but
may not be able to read it yet. That said, it may be possible to pull in
the context at the point where we set S_ENCRYPTED. I'll take a look.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

