Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C91C5EFDF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 21:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiI2TdK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 15:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiI2TdI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:33:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97647143287;
        Thu, 29 Sep 2022 12:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F8MhXtjM7domsjXj2KOKNSsca0UfmvM1RUZ4Z5z8pe8=; b=VfSLUy9/eYxJXlapUqCVW5e+Ic
        SHaYOMTjNx990Cbu0H1qt2Z9cMY5W2RiAk0IjBpwsADSuk3tKTlmQ1yP6vrwejlScdu+VQdNWgtUG
        vyTymYEUB6DTE2KsfcWaIF32aw8Herh7TWvcgDdZZrbYYTLhOyWzMuJpgzDaQEB6Ur8DkZSXKyz61
        q/R1HertrAlwlsFWZz9JWSaoc0/TyeWTGrGdP6i1Rq91gbV6o1EtA8C6y3mLRqC95Dxo2mjLgq9mT
        ogSVVsBLV52J7pTOSUCPSxBPxVb/8a+pfM9qw4ThUCeQ2frR9vdGtIbsf3ZrpUOv1hgQGjBkTkW2p
        EnbAy3fw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odzHO-00DYEM-8q; Thu, 29 Sep 2022 19:33:06 +0000
Date:   Thu, 29 Sep 2022 20:33:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: fix memory corruption when recording errors
 during writeback
Message-ID: <YzXy8lJGMRUbEdsM@casper.infradead.org>
References: <YzXnoR0UMBVfoaOf@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzXnoR0UMBVfoaOf@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 11:44:49AM -0700, Darrick J. Wong wrote:
> Fixes: e735c0079465 ("iomap: Convert iomap_add_to_ioend() to take a folio")
> Probably-Fixes: 598ecfbaa742 ("iomap: lift the xfs writeback code to iomap")

I think this is a misuse of Fixes.  As I understand it, Fixes: is "Here's
the commit that introduced the bug", not "This is the most recent change
after which this patch will still apply".  e735c0079465 only changed
s/page/folio/ in this line of code, so clearly didn't introduce the bug.

Any kernel containing 598ecfbaa742 has this same bug, so that should be
the Fixes: line.  As you say though, 598ecfbaa742 merely moved the code
from xfs_writepage_map().  bfce7d2e2d5e moved it from xfs_do_writepage(),
but 150d5be09ce4 introduced it.  Six years ago!  Good find.  So how about:

Fixes: 150d5be09ce4 ("xfs: remove xfs_cancel_ioend")

Also,

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/iomap/buffered-io.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ca5c62901541..77d59c159248 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1421,7 +1421,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	if (!count)
>  		folio_end_writeback(folio);
>  done:
> -	mapping_set_error(folio->mapping, error);
> +	mapping_set_error(inode->i_mapping, error);
>  	return error;
>  }
>  
