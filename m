Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB502262E8B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 14:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgIIMae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 08:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:32920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgIIM3l (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:29:41 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8262321D7E;
        Wed,  9 Sep 2020 12:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599654412;
        bh=rSXLajEEoxXjynEuJxfnZuxSkBT3lHT4JEico+8KXEM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eDBE0Rz7eNsRC6vF++Rr8njnQS6cz3OazZQ199xWcS+6fa+m/ZjqftHM4vUyYraqX
         MAsqpqQZqFgLkwdaNqXKgRb0vp/cJ1+KV24c9+vEu4A6i3gwizX623YGS4p0RUztPa
         U4QaQAVP0tZXgbkYQ+PPk/oRf2GtmIshDgLaLMNs=
Message-ID: <393b410e192986bdf4eb01d4d96a348c7e0e737f.camel@kernel.org>
Subject: Re: [RFC PATCH v2 15/18] ceph: make d_revalidate call fscrypt
 revalidator for encrypted dentries
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Date:   Wed, 09 Sep 2020 08:26:51 -0400
In-Reply-To: <20200908051238.GM68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
         <20200904160537.76663-16-jlayton@kernel.org>
         <20200908051238.GM68127@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-09-07 at 22:12 -0700, Eric Biggers wrote:
> On Fri, Sep 04, 2020 at 12:05:34PM -0400, Jeff Layton wrote:
> > If we have an encrypted dentry, then we need to test whether a new key
> > might have been established or removed. Do that before we test anything
> > else about the dentry.
> 
> A more accurate explanation would be:
> 
> "If we have a dentry which represents a no-key name, then we need to test
>  whether the parent directory's encryption key has since been added."
> 

Can't a key also be removed (e.g. fscrypt lock /path/to/dir)?

Does that result in the dentries below that point being invalidated?

> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ceph/dir.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > index b3f2741becdb..cc85933413b9 100644
> > --- a/fs/ceph/dir.c
> > +++ b/fs/ceph/dir.c
> > @@ -1695,6 +1695,12 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
> >  	dout("d_revalidate %p '%pd' inode %p offset 0x%llx\n", dentry,
> >  	     dentry, inode, ceph_dentry(dentry)->offset);
> >  
> > +	if (IS_ENCRYPTED(dir)) {
> > +		valid = fscrypt_d_revalidate(dentry, flags);
> > +		if (valid <= 0)
> > +			return valid;
> > +	}
> 
> There's no need to check IS_ENCRYPTED(dir) here.
> 

Thanks, fixed in my tree.

-- 
Jeff Layton <jlayton@kernel.org>

