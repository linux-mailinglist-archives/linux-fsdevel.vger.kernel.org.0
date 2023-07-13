Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65AF7517A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 06:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjGMEnq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 00:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjGMEn3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:43:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BBA210C;
        Wed, 12 Jul 2023 21:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BC5D61A00;
        Thu, 13 Jul 2023 04:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EA5C433C8;
        Thu, 13 Jul 2023 04:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689223407;
        bh=LU6/MdAoU2AqKG/qVGvlUiGgOQ0byZ7nHcg1wmJ+lGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8k2ztwdkFCuMphEAd14rWqqijZZd67akEUj125BajQMHCGn5w2oF8wMaMI3XU9L0
         ZgFP5fwTh9k8BA70je+S7/cF8Bas+wsiSZzGJT9PjJlrclhyZPV9XGafnHVRqjFHeD
         ukUI8MBMqvflSqR8K4wnz2gd29WE3loFlSyfMsmy/HvyRZcCxAuOvTjn5/LIsE+flC
         WhZLtboFm1XqVdsH7j8Edv+EFGLL6pL1WTpmXfBuDt8FkKH96EApcvNyPwpnTMK64Y
         TNLQVswycsoVEBMToySvbL+pDgGOP+gQtX7rNpj8F82J3Ae8f0t9m+PWMQo0nmj8Cb
         sLqbkLxPx9p4g==
Date:   Wed, 12 Jul 2023 21:43:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 4/9] doc: Correct the description of ->release_folio
Message-ID: <20230713044326.GI108251@frogsfrogsfrogs>
References: <20230710130253.3484695-1-willy@infradead.org>
 <20230710130253.3484695-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710130253.3484695-5-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 02:02:48PM +0100, Matthew Wilcox (Oracle) wrote:
> The filesystem ->release_folio method is called under more circumstances
> now than when the documentation was written.  The second sentence
> describing the interpretation of the return value is the wrong polarity
> (false indicates failure, not success).  And the third sentence is also
> wrong (the kernel calls try_to_free_buffers() instead).
> 
> So replace the entire paragraph with a detailed description of what the
> state of the folio may be, the meaning of the gfp parameter, why the
> method is being called and what the filesystem is expected to do.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thank you!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  Documentation/filesystems/locking.rst | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index ed148919e11a..ca3d24becbf5 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -374,10 +374,17 @@ invalidate_lock before invalidating page cache in truncate / hole punch
>  path (and thus calling into ->invalidate_folio) to block races between page
>  cache invalidation and page cache filling functions (fault, read, ...).
>  
> -->release_folio() is called when the kernel is about to try to drop the
> -buffers from the folio in preparation for freeing it.  It returns false to
> -indicate that the buffers are (or may be) freeable.  If ->release_folio is
> -NULL, the kernel assumes that the fs has no private interest in the buffers.
> +->release_folio() is called when the MM wants to make a change to the
> +folio that would invalidate the filesystem's private data.  For example,
> +it may be about to be removed from the address_space or split.  The folio
> +is locked and not under writeback.  It may be dirty.  The gfp parameter
> +is not usually used for allocation, but rather to indicate what the
> +filesystem may do to attempt to free the private data.  The filesystem may
> +return false to indicate that the folio's private data cannot be freed.
> +If it returns true, it should have already removed the private data from
> +the folio.  If a filesystem does not provide a ->release_folio method,
> +the pagecache will assume that private data is buffer_heads and call
> +try_to_free_buffers().
>  
>  ->free_folio() is called when the kernel has dropped the folio
>  from the page cache.
> -- 
> 2.39.2
> 
