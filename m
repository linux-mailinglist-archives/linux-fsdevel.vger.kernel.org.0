Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879675A89E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 02:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiIAAnA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 20:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIAAm7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:42:59 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33645E0976;
        Wed, 31 Aug 2022 17:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C7e5gupx7uxhb230xCd10coToUBiCKDWQPIlevGdY80=; b=hOmLMP+ugUyeMF+6QA09PjcGfu
        0tRtPHTBgl7z0s+0RBcR5HuECX6vysi72oyqb9nKg5wfcAeYH/E5qvTZmEwzNP02MAz3qPXJ2urMq
        QOEo7VxYgfOzukB5+Q1xXyGnNcYh1a5f1Ccjj4umz03kPQ8jMURb+pUCnQE0CQCv6lLQOzQmYKqLs
        Wjx2NxdOHt3j+kmpXPmv2ZJZKZWFhn7QqvE02d6Oenv6a0u53D681c/AL6Ll/H2pW8+77KFGmiFSo
        uefabYiIChsmUAUy82RL56+vUhGqlH10rlzlzMZwSYk+7CP8NtmpA4CSnqdXla4EwnXtAff+Ztcj8
        HY+Qicmw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oTYIA-00AnSf-7D;
        Thu, 01 Sep 2022 00:42:46 +0000
Date:   Thu, 1 Sep 2022 01:42:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
Message-ID: <YxAABm0BljO0aP2h@ZenIV>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <20220831041843.973026-5-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831041843.973026-5-jhubbard@nvidia.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:18:40PM -0700, John Hubbard wrote:
> Provide two new wrapper routines that are intended for user space pages
> only:
> 
>     iov_iter_pin_pages()
>     iov_iter_pin_pages_alloc()
> 
> Internally, these routines call pin_user_pages_fast(), instead of
> get_user_pages_fast(), for user_backed_iter(i) and iov_iter_bvec(i)
> cases.
> 
> As always, callers must use unpin_user_pages() or a suitable FOLL_PIN
> variant, to release the pages, if they actually were acquired via
> pin_user_pages_fast().
> 
> This is a prerequisite to converting bio/block layers over to use
> pin_user_pages_fast().

What of ITER_PIPE (splice from O_DIRECT fd to a to pipe, for filesystem
that uses generic_file_splice_read())?
