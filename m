Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF0D7218EC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jun 2023 19:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjFDRzv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 13:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDRzu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 13:55:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2762BC;
        Sun,  4 Jun 2023 10:55:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 662AB60D32;
        Sun,  4 Jun 2023 17:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB96AC433EF;
        Sun,  4 Jun 2023 17:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685901348;
        bh=Fw7qmVrNg43DGtGBefRNuqSd6Ph80/p5EHgHUEbZI3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DfkluhMJBhmlgGvLfz4SQxAvixYdAGsjzQ7VXXeRPKgYvo4XXMdhfcZrihXHTKrY6
         vUym/3KOWUIb5KbZMPxc/OsBIDCEx54AsbH9CrMlo9R7tKfLJOFkYOxwdYp3mjeOeT
         VPvKICT41+0G/jA512Uy+vEUEcuJGzTaNLb81uxAdpUcEj8MzSP2kH+BxX+9d0Xb49
         ygZxb82w2mcUw6Wct+KdM92a7MJ3skiSlQHLF+Oz2Kj+RaHBKCr3Hg78Ry+UCrquO5
         9EqSPwMYVtDkB+XL89BjCPk+Y4IKBKjVjgjpLueg04fo7g752foS0GHiel5Z/a8hA8
         DJcCf9GGUwULQ==
Date:   Sun, 4 Jun 2023 10:55:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 2/7] doc: Correct the description of ->release_folio
Message-ID: <20230604175548.GA72241@frogsfrogsfrogs>
References: <20230602222445.2284892-1-willy@infradead.org>
 <20230602222445.2284892-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602222445.2284892-3-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 02, 2023 at 11:24:39PM +0100, Matthew Wilcox (Oracle) wrote:
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
> ---
>  Documentation/filesystems/locking.rst | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index aa1a233b0fa8..91dc9d5bc602 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -374,10 +374,16 @@ invalidate_lock before invalidating page cache in truncate / hole punch
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
> +is locked and not under writeback.  It may be dirty.  The gfp parameter is
> +not usually used for allocation, but rather to indicate what the filesystem
> +may do to attempt to free the private data.  The filesystem may
> +return false to indicate that the folio's private data cannot be freed.
> +If it returns true, it should have already removed the private data from
> +the folio.  If a filesystem does not provide a ->release_folio method,
> +the kernel will call try_to_free_buffers().

the MM?  Since you changed that above... :)

With that nit fixed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  
>  ->free_folio() is called when the kernel has dropped the folio
>  from the page cache.
> -- 
> 2.39.2
> 
