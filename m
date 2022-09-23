Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62EC5E75EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 10:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiIWIjs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 04:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiIWIjq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:39:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44D82C669;
        Fri, 23 Sep 2022 01:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V1rRq3lqNoW5TcE/xufv462Ekykzam6103C+3ht2Ez0=; b=nJejs3bRso0/zXedtRupWJU72A
        D3mRvV1bNdE2jDqNQcPlaka+ZwzpBWGS5HALHhg96r/Xp9OkKYfxPZYX4J3P+AbEbEuE2fbiu5w2q
        OswO4Rg7IAV6ekjzj5XIhzHzkgwzwTDKamCK8uJ1uCrwR//u5idtB2/UT1b11j2E7/5jb61SIPgEt
        fMKj4ZhqXR7WVWpg8ZeafRMkrxjAbjvm21zfVvJTbzz1AsoVx7wjyA79kn1mhGhQPBjPgOEOc4tKM
        kOVN+tMXAAJ30PeiPypcGFxGeX+CNxeYmzxe6HJiJe6T7SD4E1F1E45QfBGkRMXYGwstHf7BwLD7F
        Oa6WIohQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obeDT-0030o0-Un; Fri, 23 Sep 2022 08:39:23 +0000
Date:   Fri, 23 Sep 2022 01:39:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
Message-ID: <Yy1wu9tKo/sbsi1N@infradead.org>
References: <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3>
 <YyIEgD8ksSZTsUdJ@ZenIV>
 <20220915081625.6a72nza6yq4l5etp@quack3>
 <YyvG+Oih2A37Grcf@ZenIV>
 <a6f95605-c2d5-6ec5-b85c-d1f3f8664646@nvidia.com>
 <20220922112935.pep45vfqfw5766gq@quack3>
 <Yy0lztxfwfGXFme4@ZenIV>
 <7e652ba4-8b03-59e0-a9ef-1118c4bbd492@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e652ba4-8b03-59e0-a9ef-1118c4bbd492@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 09:05:16PM -0700, John Hubbard wrote:
> I certainly hope not. And in fact, we should really just say that that's
> a rule: the whole time the page is pinned, it simply must remain dirty
> and writable, at least with the way things are right now.

Yes, if we can stick to that rule and make sure shared pagecache is
never dirtied through get_user_pags anywhere that will allow us to
fix a lot of mess

> To fix those cases, IIUC, the answer is: you must make the page dirty
> properly, with page_mkwrite(), not just with set_page_dirty_lock(). And
> that has to be done probably a lot earlier, for reasons that I'm still
> vague on. But perhaps right after pinning the page. (Assuming that we
> hold off writeback while the page is pinned.)

I think we need to hold off the writeback for it to work properly.
The big question is, is if there are callers that do expect data
to be written back on mappings that are longterm pinned.  RDMA or
vfio would come to mind.
