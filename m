Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9885526C982
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 21:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgIPTMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 15:12:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbgIPRkk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:40:40 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4A8722228;
        Wed, 16 Sep 2020 12:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600258712;
        bh=dIAu59T4SYU/adnWE9ylH53MOsWZJPlPNzf33P+w0G8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=itdFKVte18xxHKQKEGBDOuEd+lfcVV0N1Kwkm+BDnOizG2ZdjWdfrsEcVVm4wOrFI
         GI4GMX2aRnIM0XULDX2My5Tbsk+KZwQn1De6LJED4xg3DI4Z4H0+VUE2afO1KWYTyX
         FuGV10umftDikdoyL2ZgI5TwZ/I6odqKK0QQbG+k=
Message-ID: <6889fd7528052f014b4c7fe5b3ac0d0e22fa8cc0.camel@kernel.org>
Subject: Re: [RFC PATCH v3 10/16] ceph: add routine to create context prior
 to RPC
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 16 Sep 2020 08:18:30 -0400
In-Reply-To: <20200915013724.GJ899@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
         <20200914191707.380444-11-jlayton@kernel.org>
         <20200915013724.GJ899@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-09-14 at 18:37 -0700, Eric Biggers wrote:
> On Mon, Sep 14, 2020 at 03:17:01PM -0400, Jeff Layton wrote:
> > diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> > index b5f38ee80553..c1b6ec4b2961 100644
> > --- a/fs/ceph/crypto.h
> > +++ b/fs/ceph/crypto.h
> > @@ -11,6 +11,8 @@
> >  #define	CEPH_XATTR_NAME_ENCRYPTION_CONTEXT	"encryption.ctx"
> >  
> >  void ceph_fscrypt_set_ops(struct super_block *sb);
> > +int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
> > +				 struct ceph_acl_sec_ctx *as);
> >  
> >  #else /* CONFIG_FS_ENCRYPTION */
> >  
> > @@ -19,6 +21,12 @@ static inline int ceph_fscrypt_set_ops(struct super_block *sb)
> >  	return 0;
> >  }
> >  
> > +static inline int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
> > +						struct ceph_acl_sec_ctx *as)
> > +{
> > +	return 0;
> > +}
> > +
> >  #endif /* CONFIG_FS_ENCRYPTION */
> 
> Seems there should at least be something that prevents you from creating a file
> in an encrypted directory when !CONFIG_FS_ENCRYPTION.
> 
> The other filesystems use fscrypt_prepare_new_inode() for this; it returns
> EOPNOTSUPP when IS_ENCRYPTED(dir).
> 

Once we have the MDS support done, we should be able to make it reject
create requests from clients that don't support the new feature flag,
but denying it on the client is more efficient. Fixed in my tree.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

