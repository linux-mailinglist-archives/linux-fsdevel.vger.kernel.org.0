Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81426BA372
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 00:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCNXNB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 19:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCNXNA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 19:13:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6345474FE;
        Tue, 14 Mar 2023 16:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1557B61A4D;
        Tue, 14 Mar 2023 23:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AEBC433D2;
        Tue, 14 Mar 2023 23:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678835570;
        bh=Wj4gHmPwkXdtZztjlVodNO5zU/0vOg2VfG43ne0Wez0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fg+QgVcL0SgDOBlAotWFWMF4WKYxoUli1gCK2JAO7aieN2aT8khRYYFDxkyLf3vOe
         YtEYH7KWJm6sMpgXGDGqM7YcxNdjWq2WGeKSyaa23SSwECFv6CJ/Y4bsf6E7ZX/l9b
         DSX5TgKfR5ryUEkpyy6SvmRQh7LXttvy6ZI2o5+b8ngd3eR3rmGpNpGFWRnWl69w6K
         kjKdeT1YmjhlDT9RRsc9mkLtOUKzYcnsbQI2yfSWnqXpVhyMvlxCQ/uhXkNbzWR9zE
         baSIyQLO7jEWDxtPYZnUCgsEv8+VA5jrRny7/VoAr58Qz2KSGj9CEqWwCyqpcNn3sO
         SRqh4b0bL84XQ==
Date:   Tue, 14 Mar 2023 16:12:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/31] fscrypt: Add some folio helper functions
Message-ID: <ZBD/Z5Yvs0LavNms@sol.localdomain>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-3-willy@infradead.org>
 <Y9M+tl5CcNfRScds@sol.localdomain>
 <Y9P4MYXE9NcC8+gv@casper.infradead.org>
 <20230314220551.GQ860405@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314220551.GQ860405@mit.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 14, 2023 at 06:05:51PM -0400, Theodore Ts'o wrote:
> On Fri, Jan 27, 2023 at 04:13:37PM +0000, Matthew Wilcox wrote:
> > 
> > It's out of scope for _this_ patchset.  I think it's a patchset that
> > could come either before or after, and is needed to support large folios
> > with ext4.  The biggest problem with doing that conversion is that
> > bounce pages are allocated from a mempool which obviously only allocates
> > order-0 folios.  I don't know what to do about that.  Have a mempool
> > for each order of folio that the filesystem supports?  Try to allocate
> > folios without a mempool and then split the folio if allocation fails?
> > Have a mempool containing PMD-order pages and split them ourselves if
> > we need to allocate from the mempool?
> > 
> > Nothing's really standing out to me as the perfect answer.  There are
> > probably other alternatives.
> 
> Hmm.... should we have some kind of check in case a large folio is
> passed to these fscrypt functions?  (e.g., some kind of BUG_ON, or
> WARN_ON?)
> 
> Or do we just rely on people remembering that when we start trying to
> support large folios for ext4, it will probably have to be the easy
> cases first (e.g., no fscrypt, no fsverity, block size == page size)?
> 

I think large folio support for fscrypt and fsverity is not that far away.  I
already made the following changes in 6.3:

    51e4e3153ebc ("fscrypt: support decrypting data from large folios")
    5d0f0e57ed90 ("fsverity: support verifying data from large folios")

AFAICT, absent actual testing of course, the only major thing that's still
needed is that fscrypt_encrypt_pagecache_blocks() needs to support large folios.
I'm not sure how it should work, exactly.  Matthew gave a couple options.
Another option is to just continue to use bounce *pages*, and keep track of all
the bounce pages for each folio.

We could certainly make fscrypt_encrypt_pagecache_blocks() WARN when given a
large folio for now, if we aren't going to update it properly anytime soon.

By the way, fscrypt_encrypt_pagecache_blocks() is only used by the fs-layer file
contents encryption, not inline encryption.  Even without changing it, we could
support large folios on encrypted files when inline encryption is being used.

(A smaller thing, which I think I missed in "fsverity: support verifying data
from large folios", is that fsverity_verify_bio() still uses
bio_first_page_all(bio)->mapping->host to get the bio's inode.  Perhaps there
needs to be a page_folio() in there for the ->mapping to be valid?)

- Eric
