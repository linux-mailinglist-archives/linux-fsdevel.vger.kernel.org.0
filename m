Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0B95A3A48
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 00:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiH0Wqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 18:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiH0Wqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 18:46:47 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B3B564F3;
        Sat, 27 Aug 2022 15:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0srbmE7se1/webIbEP76hB4Oq2UTvYv6BWdCYbpFU1w=; b=ChDOfgcKFvPYIRhfHui9MjUP9k
        RKbrn5/23LmkrN9ofk4yMTpEJ7O5fD+5LbBnj5hayWnVAqOKqWGhOiHQtZwCWCVJeWJ9ekR3Odr9H
        B7mMfOuabOUAvhnUxuQ11Br4WHZIHTUfZ4meQSFtYN578VaGPUjbh3tZd+eY8P5AMeKHYdkDd4taw
        MorgpTVfleTS5qWole4hAx4v8Thfy0WwnZYXxV1nHOfwYNLzUua+ilCjhJBlofvMABugWOyF7omkh
        /ahBbStJVf6abaPUDR9k6G0IP+naRoptJNem2u3ep8iMGiRayxIM66YvOg1QENbpi7gaH2oC0AX6V
        q6juhXXw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oS4ZQ-0097ix-6e;
        Sat, 27 Aug 2022 22:46:28 +0000
Date:   Sat, 27 Aug 2022 23:46:28 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] iov_iter: new iov_iter_pin_pages*() routines
Message-ID: <YwqexJOL9GcOKRg1@ZenIV>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
 <20220827083607.2345453-4-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827083607.2345453-4-jhubbard@nvidia.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 27, 2022 at 01:36:04AM -0700, John Hubbard wrote:
> Provide two new wrapper routines that are intended for user space pages
> only:
> 
>     iov_iter_pin_pages()
>     iov_iter_pin_pages_alloc()
> 
> Internally, these routines call pin_user_pages_fast(), instead of
> get_user_pages_fast().
> 
> As always, callers must use unpin_user_pages() or a suitable FOLL_PIN
> variant, to release the pages, if they actually were acquired via
> pin_user_pages_fast().
> 
> This is a prerequisite to converting bio/block layers over to use
> pin_user_pages_fast().

You do realize that O_DIRECT on ITER_BVEC is possible, right?
