Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DE95A3A3B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 00:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiH0W1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 18:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiH0W1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 18:27:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620B642AEC;
        Sat, 27 Aug 2022 15:27:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEB6F60EB5;
        Sat, 27 Aug 2022 22:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCCAC433D7;
        Sat, 27 Aug 2022 22:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661639267;
        bh=mP4LJW5/Ex8VVFzSK0tQqGy9Pf6M8NRGpWXThg5YJsY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fPCCHHBOCVt1Xlfm2Z5i/Pjl8wfTghEDGD0JFOt4WwDmgOEkru94oGjVnHGqnx/ch
         gQUe2uK6/r2IS2bj5FoIuojGJWJ0Ygto2fKaREz/DqcTJmhucEE0ruirhkci7F9fps
         g2F/It6cmXai1gbLalpP+edxEzs+snNPwjjIR5co=
Date:   Sat, 27 Aug 2022 15:27:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] block: add dio_w_*() wrappers for pin, unpin user
 pages
Message-Id: <20220827152745.3dcd05e98b3a4383af650a72@linux-foundation.org>
In-Reply-To: <20220827083607.2345453-3-jhubbard@nvidia.com>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
        <20220827083607.2345453-3-jhubbard@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 27 Aug 2022 01:36:03 -0700 John Hubbard <jhubbard@nvidia.com> wrote:

> Background: The Direct IO part of the block infrastructure is being
> changed to use pin_user_page*() and unpin_user_page*() calls, in place
> of a mix of get_user_pages_fast(), get_page(), and put_page(). These
> have to be changed over all at the same time, for block, bio, and all
> filesystems. However, most filesystems can be changed via iomap and core
> filesystem routines, so let's get that in place, and then continue on
> with converting the remaining filesystems (9P, CIFS) and anything else
> that feeds pages into bio that ultimately get released via
> bio_release_pages().
> 
> Add a new config parameter, CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO, and
> dio_w_*() wrapper functions. The dio_w_ prefix was chosen for
> uniqueness, so as to ease a subsequent kernel-wide rename via
> search-and-replace. Together, these allow the developer to choose
> between these sets of routines, for Direct IO code paths:
> 
> a) pin_user_pages_fast()
>     pin_user_page()
>     unpin_user_page()
> 
> b) get_user_pages_fast()
>     get_page()
>     put_page()
> 
> CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO is a temporary setting, and may
> be deleted once the conversion is complete. In the meantime, developers
> can enable this in order to try out each filesystem.
> 
> Please remember that these /proc/vmstat items (below) should normally
> contain the same values as each other, except during the middle of
> pin/unpin operations. As such, they can be helpful when monitoring test
> runs:
> 
>     nr_foll_pin_acquired
>     nr_foll_pin_released
> 
> ...
>
> +static inline void dio_w_unpin_user_pages(struct page **pages,
> +					  unsigned long npages)
> +{
> +	unsigned long i;
> +
> +	for (i = 0; i < npages; i++)
> +		put_page(pages[i]);
> +}

release_pages()?  Might be faster if many of the pages are page_count()==1.

(release_pages() was almost as simple as the above when I added it a
million years ago.  But then progress happened).

