Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB465B97A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 11:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIOJmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 05:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIOJmM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:42:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63846CF4E;
        Thu, 15 Sep 2022 02:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kmV+bjuBIbb/1Zd/POYrIraBtwwr2RAc0pWgW32GYaw=; b=pxDLm4xC98kMchQ2l7sCCX9ypx
        yEG1CA9vqMQoSnRfymGegTpnD7aWpNAjR0io9BXKkCJUlaeaImBb5HPHQvpaIEcn7gQlp9MdmyA2u
        ud5HTkIA99OGEQgFFW00Oi3IvT4qXbgu2Bly55ijYDeIKcHa+uDrleY8qQACq9sLyqYqbhy+sCJH4
        axR2Ss+V5nYbvPWnt8c5pCYa2CwDlUHh5DRfgqzyo3K3adLgRqRVBQ+5PhnjU33dzwau//LcLchDQ
        LXMHkjhT2m0c8ylR37ue/UV76hsx/rcvJDhVPj7laWTuXEbPHAhw2KB8FvSSN9CFC6h/aXAQCyCVD
        pkhNmU4Q==;
Received: from [185.122.133.20] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYlNi-005auV-92; Thu, 15 Sep 2022 09:42:02 +0000
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
Subject: improve pagecache PSI annotations v2
Date:   Thu, 15 Sep 2022 10:41:55 +0100
Message-Id: <20220915094200.139713-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes since v1:
 - fix a logic error in ra_alloc_folio
 - drop a unlikely()
 - spell a comment in the weird way preferred by btrfs maintainers

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
