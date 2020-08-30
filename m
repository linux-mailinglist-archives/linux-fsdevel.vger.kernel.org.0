Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7BE257075
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Aug 2020 22:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgH3URa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Aug 2020 16:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgH3UR3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Aug 2020 16:17:29 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220CDC061573;
        Sun, 30 Aug 2020 13:17:29 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCTlB-007hSE-66; Sun, 30 Aug 2020 20:17:05 +0000
Date:   Sun, 30 Aug 2020 21:17:05 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iov_iter: introduce iov_iter_pin_user_pages*()
 routines
Message-ID: <20200830201705.GV1236603@ZenIV.linux.org.uk>
References: <20200829080853.20337-1-jhubbard@nvidia.com>
 <20200829080853.20337-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829080853.20337-3-jhubbard@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 29, 2020 at 01:08:52AM -0700, John Hubbard wrote:
> The new routines are:
>     iov_iter_pin_user_pages()
>     iov_iter_pin_user_pages_alloc()
> 
> and those correspond to these pre-existing routines:
>     iov_iter_get_pages()
>     iov_iter_get_pages_alloc()
> 
> Also, pipe_get_pages() and related are changed so as to pass
> down a "use_pup" (use pin_user_page() instead of get_page()) bool
> argument.
> 
> Unlike the iov_iter_get_pages*() routines, the
> iov_iter_pin_user_pages*() routines assert that only ITER_IOVEC or
> ITER_PIPE items are passed in. They then call pin_user_page*(), instead
> of get_user_pages_fast() or get_page().
> 
> Why: In order to incrementally change Direct IO callers from calling
> get_user_pages_fast() and put_page(), over to calling
> pin_user_pages_fast() and unpin_user_page(), there need to be mid-level
> routines that specifically call one or the other systems, for both page
> acquisition and page release.

Hmm...  Do you plan to kill iov_iter_get_pages* off, eventually getting
rid of that use_pup argument?
