Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06D46AB832
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 09:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCFI1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 03:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCFI1S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:27:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E082A1CF65;
        Mon,  6 Mar 2023 00:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IJK+aGxPgAk3yHqfOryl7qeDFkEH8zBvuP5FaeaSDuo=; b=TV8Rtu1NcJH1Ge4E/X4xuYz3Yv
        Ag0R/4gfqjJp/tSekenaf2C49k6WqvbHQ6TK/OZSoedY21D9N+gfhE89lAkdGGbODoQccTFq2k2W5
        EoO57+gUqSN/I5VCzGcwB5EA0pY48rTOQHlnvinlsdOBdjvUdrSMXmNEnRLrZPvBUpkm92Y+JX5Zg
        MrXwsJ0QA09qc/0eFIedZJ13kOY3kX768hTHAB9Puz5oiR+KCYHU8zTALPHSUGfyKgnsmYqt6YzIa
        giOFELt69DY9BJHAhP/HvdoU5e3XXI07fmig6HxnlCwOSp9hB3d4xjFKyOv0p+n5AItLlLU3H4+jk
        LTZpwI+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZ6Bc-005AUM-Rb; Mon, 06 Mar 2023 08:27:12 +0000
Date:   Mon, 6 Mar 2023 08:27:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 25/31] ext4: Convert ext4_block_write_begin() to take a
 folio
Message-ID: <ZAWj4FHczOQwwEbK@casper.infradead.org>
References: <20230126202415.1682629-26-willy@infradead.org>
 <87wn3u1iez.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn3u1iez.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 06, 2023 at 12:21:48PM +0530, Ritesh Harjani wrote:
> "Matthew Wilcox (Oracle)" <willy@infradead.org> writes:
> 
> > All the callers now have a folio, so pass that in and operate on folios.
> > Removes four calls to compound_head().
> 
> Why do you say four? Isn't it 3 calls of PageUptodate(page) which
> removes calls to compound_head()? Which one did I miss?
>
> > -	BUG_ON(!PageLocked(page));
> > +	BUG_ON(!folio_test_locked(folio));

That one ;-)

> >  	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
> >  		for (i = 0; i < nr_wait; i++) {
> >  			int err2;
> >
> > -			err2 = fscrypt_decrypt_pagecache_blocks(page, blocksize,
> > -								bh_offset(wait[i]));
> > +			err2 = fscrypt_decrypt_pagecache_blocks(&folio->page,
> > +						blocksize, bh_offset(wait[i]));
> 
> folio_decrypt_pagecache_blocks() takes folio as it's argument now.
> 
> Other than that it looks good to me. Please feel free to add -
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks.  I'll refresh this patchset next week.

