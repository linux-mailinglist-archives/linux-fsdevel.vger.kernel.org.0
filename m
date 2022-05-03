Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC9051921C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 01:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbiECXGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 19:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiECXGx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 19:06:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C4E18B26;
        Tue,  3 May 2022 16:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D0A46101F;
        Tue,  3 May 2022 23:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2310C385AE;
        Tue,  3 May 2022 23:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651618998;
        bh=jlwf+IIg3B40wdjg00yJJUQCkXo+SaUIfI9GCxnrxwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DPwVJU+rpoAnsBo8X3wbualMXXklXalbLiLit2/mLC7GcvN13uJrqPHalMFiJspzb
         G7ahRkNuLTeMRERwpkkaWGkIBvRohQhQxuUZTQ2a4hLkMC0bhi0G76bZxqq609NyJE
         8S13EL2FHR6lSuqPf15inuEyYxPzFMaOtioGcGCdGEON9tiXr5J2MbCbjGr2lU9/xM
         bxOXzbg63Z9b/UdLMymYfauATuCJWgpw+c72XGk8ev9qondJkn2isL2BHm2QP26rWm
         4DvKYIrMBRiqnrbSWD7exz3SpL/fztR/BDvD3D8c652mAXISdXFeHJdcBorcaB3RBF
         j4J47mCIV4wkw==
Date:   Tue, 3 May 2022 16:03:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: iomap_write_failed fix
Message-ID: <20220503230318.GL8265@magnolia>
References: <20220503213645.3273828-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503213645.3273828-1-agruenba@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 03, 2022 at 11:36:45PM +0200, Andreas Gruenbacher wrote:
> The @lend parameter of truncate_pagecache_range() should be the offset
> of the last byte of the hole, not the first byte beyond it.
> 
> Fixes: ae259a9c8593 ("fs: introduce iomap infrastructure")
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

I'll queue this up for ... 5.19?  Testing infrastructure still sorta
tied up until I get at least two clean runs on 5.18-rcX, which <cough>
still hasn't happened yet.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8ce8720093b9..358ee1fb6f0d 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -531,7 +531,8 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
>  	 * write started inside the existing inode size.
>  	 */
>  	if (pos + len > i_size)
> -		truncate_pagecache_range(inode, max(pos, i_size), pos + len);
> +		truncate_pagecache_range(inode, max(pos, i_size),
> +					 pos + len - 1);
>  }
>  
>  static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
> -- 
> 2.35.1
> 
