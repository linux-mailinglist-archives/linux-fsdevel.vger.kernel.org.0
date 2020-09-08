Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C825E2622AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 00:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgIHWfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 18:35:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgIHWfA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 18:35:00 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 921C2207DE;
        Tue,  8 Sep 2020 22:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599604499;
        bh=lVsKOtch9mY+HCVYlRRdxSCyM2BapBvFafMfcW6y4q4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2NLI4tu+8t9tV8GHj96HZaC7IMsBkuv9CQVDRSM6v9yINyYA4QX7H7rVm9OTrtwEf
         7X1sHoGrlMKid6nzcwMKQNhsiAZPcN7a8ACiPzAdQsGMj4ZvqhQoUAkif9cbFCjMVV
         sK5XxPJmTfFJSb6G9dJ+1aTqv+5/KcObLM9cU2UM=
Date:   Tue, 8 Sep 2020 15:34:58 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v2 04/18] fscrypt: add fscrypt_new_context_from_inode
Message-ID: <20200908223458.GB3760467@gmail.com>
References: <20200904160537.76663-1-jlayton@kernel.org>
 <20200904160537.76663-5-jlayton@kernel.org>
 <20200908034830.GE68127@sol.localdomain>
 <0e850768fe5e6cbf985dce5943dbccb1c8c777a8.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e850768fe5e6cbf985dce5943dbccb1c8c777a8.camel@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 08, 2020 at 08:29:52AM -0400, Jeff Layton wrote:
> > > + *
> > > + * Returns size of the context.
> > > + */
> > > +int fscrypt_new_context_from_inode(union fscrypt_context *ctx, struct inode *inode)
> > > +{
> > > +	struct fscrypt_info *ci = inode->i_crypt_info;
> > > +
> > > +	BUILD_BUG_ON(sizeof(*ctx) != FSCRYPT_SET_CONTEXT_MAX_SIZE);
> > > +
> > > +	return fscrypt_new_context_from_policy(ctx, &ci->ci_policy, ci->ci_nonce);
> > > +}
> > > +EXPORT_SYMBOL_GPL(fscrypt_new_context_from_inode);
> > 
> > fscrypt_set_context() should be changed to call this, instead of duplicating the
> > same logic.  As part of that, the WARN_ON_ONCE(!ci) that's currently in
> > fscrypt_set_context() should go in here instead.
> > 
> 
> Note that we can't just move that WARN_ON_ONCE. If we do that, then
> fscrypt_set_context will dereference ci before that check can occur, so
> we'd be trading a warning and -ENOKEY for a NULL pointer dereference. I
> think we'll have to duplicate that in both functions.

You could just make fscrypt_set_context() call fscrypt_new_context_from_inode()
first, before the fscrypt_hash_inode_number() stuff.

- Eric
