Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1CD64BCA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 20:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbiLMTDh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 14:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbiLMTDJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:03:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CE363DE;
        Tue, 13 Dec 2022 11:03:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CD97616F0;
        Tue, 13 Dec 2022 19:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA98C433D2;
        Tue, 13 Dec 2022 19:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670958180;
        bh=nWhP5FoHVl6aZrBIi+mQqhY5QE2Qis1zzn7AI1RiCJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NYMXkbp/F/HrEoKWqswY8dul3FfLEZxMBaVI/Bwxf3GgqQ5QDx5LXrMUqBzYM2R3G
         Y/X1kFwDyZU1Yi6UHnST8BGVXoKOzMf5+BLSiZSXkwZxrDCxRGyT0JutE6nv1YFGVi
         ah6BtjgVYIRxWrRCCwuJQkKqYOKz/UEK/RUu9Uq4sT6Lg0HzFL63bnZGjsSz27GQ/0
         glgyd00N2ynhDcAqrugIddmik6sAvWtpC/4oKb1tt2V6EZKlSppaWi0bI4j4JScHXQ
         XxJUDbOS/HhtJUa8lyyuEeTEreiQ1ZoI50JHmTcDPxyZtaqZhAWHpSopJu5XSve7B4
         3Q6WkuWRpNXww==
Date:   Tue, 13 Dec 2022 11:02:59 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 09/11] iomap: fs-verity verification on page read
Message-ID: <Y5jMYxgFARhStFrb@sol.localdomain>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-10-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213172935.680971-10-aalbersh@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 06:29:33PM +0100, Andrey Albershteyn wrote:
> Add fs-verity page verification in read IO path. The verification
> itself is offloaded into workqueue (provided by fs-verity).
> 
> The work_struct items are allocated from bioset side by side with
> bio being processed.
> 
> As inodes with fs-verity doesn't use large folios we check only
> first page of the folio for errors (set by fs-verity if verification
> failed).
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 80 +++++++++++++++++++++++++++++++++++++++---
>  include/linux/iomap.h  |  5 +++
>  2 files changed, 81 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 91ee0b308e13d..b7abc2f806cfc 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -17,6 +17,7 @@
>  #include <linux/bio.h>
>  #include <linux/sched/signal.h>
>  #include <linux/migrate.h>
> +#include <linux/fsverity.h>
>  #include "trace.h"
>  
>  #include "../internal.h"
> @@ -42,6 +43,7 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
>  }
>  
>  static struct bio_set iomap_ioend_bioset;
> +static struct bio_set iomap_readend_bioset;
>  
>  static struct iomap_page *
>  iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
> @@ -189,9 +191,39 @@ static void iomap_read_end_io(struct bio *bio)
>  	int error = blk_status_to_errno(bio->bi_status);
>  	struct folio_iter fi;
>  
> -	bio_for_each_folio_all(fi, bio)
> +	bio_for_each_folio_all(fi, bio) {
> +		/*
> +		 * As fs-verity doesn't work with multi-page folios, verity
> +		 * inodes have large folios disabled (only single page folios
> +		 * are used)
> +		 */
> +		if (!error)
> +			error = PageError(folio_page(fi.folio, 0));
> +
>  		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
> +	}

fs/verity/ no longer uses PG_error to report errors.  See upstream commit
98dc08bae678 ("fsverity: stop using PG_error to track error status").

- Eric
