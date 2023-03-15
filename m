Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC9B6BB6C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 15:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjCOO54 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 10:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjCOO5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:57:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE5425948;
        Wed, 15 Mar 2023 07:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NtGVTT0RE5iHf8BDlNnJJTmqknLyFuFovkq+NsrgLe4=; b=PiUZ5d9s1025RuKr4ecGq9sArC
        v2VR2D3pHXH/amZGn6D1lD6vqM5Q6MKJ+O0jzI3lm5p4zSfr+CaXeZEWzGkwhdH5oL2f3vQ+1PRKr
        XWE3xORmmUTQzRCIe/Ld9xRWfOKkgPiPn76MIdw3IPtqfMg8w6RLpMDGCc3SwI0U4fS0yOCLGAoKJ
        UH1IbfqoDsFCA3AelyRBAXKTzhCoZPNWjKSMOjvxJS1hts1kazbIti2grOrPssBOPJAUk410i1pyd
        A9B/Gw8gGSqj4qSh+zmFT5AK2yUl6d2Ge/M0xXZlezoUqkwhBH8NX2IAew9BWt+V7S8o7Bwh5szem
        c21/Ugbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcSYB-00Dhrz-0d;
        Wed, 15 Mar 2023 14:56:23 +0000
Date:   Wed, 15 Mar 2023 07:56:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     hubcap@omnibond.com, senozhatsky@chromium.org, martin@omnibond.com,
        willy@infradead.org, minchan@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, axboe@kernel.dk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        gost.dev@samsung.com, mcgrof@kernel.org, devel@lists.orangefs.org
Subject: Re: [RFC PATCH 1/3] filemap: convert page_endio to folio_endio
Message-ID: <ZBHcl8Pz2ULb4RGD@infradead.org>
References: <20230315123233.121593-1-p.raghav@samsung.com>
 <CGME20230315123234eucas1p2503d83ad0180cecde02e924d7b143535@eucas1p2.samsung.com>
 <20230315123233.121593-2-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315123233.121593-2-p.raghav@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Can we take a step back and figure out if page_endio is a good
idea to start with?

The zram usage seems clearly wrong to me.  zram is a block driver
and does not own the pages, so it shouldn't touch any of the page
state.  It seems like this mostly operates on it's own
pages allocated using alloc_page so the harm might not be horrible
at least.

orangefs uses it on readahead pages, with ret known for the whole
iteration.  So one quick loop for the success and one for the
failure case would look simpler an more obvious.

mpage really should use separate end_io handler for read vs write
as well like most other aops do.

So overall I'd be happier to just kill the helper.
