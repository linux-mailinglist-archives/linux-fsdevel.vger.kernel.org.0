Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1A25B44C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Sep 2022 08:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiIJGvU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Sep 2022 02:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIJGvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Sep 2022 02:51:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E062B18F;
        Fri,  9 Sep 2022 23:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=5boGn7vQhK1/qyQ9CrG6mQXzf4WCqUbSGuj00WF3en4=; b=GJmfyYiSjVHZYw5b9vVusVFTJt
        0PSWAGmPJboxa1YQqL5UH68Ksc+TeI9ogIFTsYh+fzj77xXzUEnAUEKXJjUy4pHujRM5ZRP9JXgdC
        7k7z+FVbg+sn2ZDxX9yRO5VKSjwvR3h21uqvVq8qDBCl8lxf1TL6tQIVuc+dRWQNDRQSNItRDrU5C
        C8/67qIXRinUlBjrmE9fRTTmYP0f+2rhs7rOxts84LIB3Hx8yX6GrxJnDnRHaannnal3fweRkxY2j
        vTW8FnRKjlw+Bqvq4H5tMP3x/cYsjXdtnGnXghp9lRL7bdMuTuln7DQ7JH2AT/hxr3YVD+2zgluAt
        /UC45XtQ==;
Received: from [2001:4bb8:198:38af:e8dc:dbbd:a9d:5c54] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWuKX-006pZ6-Rp; Sat, 10 Sep 2022 06:51:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-mm@kvack.org
Subject: improve pagecache PSI annotations
Date:   Sat, 10 Sep 2022 08:50:53 +0200
Message-Id: <20220910065058.3303831-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

currently the VM tries to abuse the block layer submission path for
the page cache PSI annotations.  This series instead annotates the
->read_folio and ->readahead calls in the core VM code, and then
only deals with the odd direct add_to_page_cache_lru calls manually.

Diffstat:
 block/bio.c               |    8 --------
 block/blk-core.c          |   17 -----------------
 fs/btrfs/compression.c    |   14 ++++++++++++--
 fs/direct-io.c            |    2 --
 fs/erofs/zdata.c          |   13 ++++++++++++-
 include/linux/blk_types.h |    1 -
 include/linux/pagemap.h   |    2 ++
 kernel/sched/psi.c        |    2 ++
 mm/filemap.c              |    7 +++++++
 mm/readahead.c            |   22 ++++++++++++++++++----
 10 files changed, 53 insertions(+), 35 deletions(-)
