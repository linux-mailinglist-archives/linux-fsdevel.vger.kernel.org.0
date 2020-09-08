Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97354261608
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 19:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731869AbgIHRAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 13:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731846AbgIHQUH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:20:07 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 698D221D47;
        Tue,  8 Sep 2020 12:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599568193;
        bh=k2WCSGzu9o0YL2Fumrmv/f8wnwWybYCP9fQIMb0Uz6U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QtKYy7zaUFECccYNwXAXtOplQfSZjq8NB3pKfFKe47z/lTKzHxufee827EKNLCRz3
         HWf9I5CStm0T3yCIFzStBaZn+5l1jCH5POAStn7QV681O8BYX8ZE43lgQByZ0FBMf6
         jyflmYxfBEqi1ymlPqBOI+F1VvzkiyCZMbTkmKNs=
Message-ID: <0e850768fe5e6cbf985dce5943dbccb1c8c777a8.camel@kernel.org>
Subject: Re: [RFC PATCH v2 04/18] fscrypt: add fscrypt_new_context_from_inode
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Date:   Tue, 08 Sep 2020 08:29:52 -0400
In-Reply-To: <20200908034830.GE68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
         <20200904160537.76663-5-jlayton@kernel.org>
         <20200908034830.GE68127@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-09-07 at 20:48 -0700, Eric Biggers wrote:
> On Fri, Sep 04, 2020 at 12:05:23PM -0400, Jeff Layton wrote:
> > CephFS will need to be able to generate a context for a new "prepared"
> > inode. Add a new routine for getting the context out of an in-core
> > inode.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/crypto/policy.c      | 20 ++++++++++++++++++++
> >  include/linux/fscrypt.h |  1 +
> >  2 files changed, 21 insertions(+)
> > 
> > diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
> > index c56ad886f7d7..10eddd113a21 100644
> > --- a/fs/crypto/policy.c
> > +++ b/fs/crypto/policy.c
> > @@ -670,6 +670,26 @@ int fscrypt_set_context(struct inode *inode, void *fs_data)
> >  }
> >  EXPORT_SYMBOL_GPL(fscrypt_set_context);
> >  
> > +/**
> > + * fscrypt_context_from_inode() - fetch the encryption context out of in-core inode
> 
> Comment doesn't match the function name.
> 
> Also, the name isn't very clear.  How about calling this
> fscrypt_context_for_new_inode()?
> 
> BTW, I might rename fscrypt_new_context_from_policy() to
> fscrypt_context_from_policy() in my patchset.  Since it now makes the caller
> provide the nonce, technically it's no longer limited to "new" contexts.
> 
> > + * @ctx: where context should be written
> > + * @inode: inode from which to fetch context
> > + *
> > + * Given an in-core prepared, but not-necessarily fully-instantiated inode,
> > + * generate an encryption context from its policy and write it to ctx.
> 
> Clarify what is meant by "prepared" (fscrypt_prepare_new_inode() was called)
> vs. "instantiated".
> 
> > + *
> > + * Returns size of the context.
> > + */
> > +int fscrypt_new_context_from_inode(union fscrypt_context *ctx, struct inode *inode)
> > +{
> > +	struct fscrypt_info *ci = inode->i_crypt_info;
> > +
> > +	BUILD_BUG_ON(sizeof(*ctx) != FSCRYPT_SET_CONTEXT_MAX_SIZE);
> > +
> > +	return fscrypt_new_context_from_policy(ctx, &ci->ci_policy, ci->ci_nonce);
> > +}
> > +EXPORT_SYMBOL_GPL(fscrypt_new_context_from_inode);
> 
> fscrypt_set_context() should be changed to call this, instead of duplicating the
> same logic.  As part of that, the WARN_ON_ONCE(!ci) that's currently in
> fscrypt_set_context() should go in here instead.
> 

Note that we can't just move that WARN_ON_ONCE. If we do that, then
fscrypt_set_context will dereference ci before that check can occur, so
we'd be trading a warning and -ENOKEY for a NULL pointer dereference. I
think we'll have to duplicate that in both functions.

-- 
Jeff Layton <jlayton@kernel.org>

