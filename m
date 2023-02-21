Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB5A69DA15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 05:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjBUEas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 23:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBUEar (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 23:30:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FB91E284;
        Mon, 20 Feb 2023 20:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+u/miBoug4QTbhiGHD6FmosTdDbAhFm94BlTs2Y7b+c=; b=RAL4vNnwqq5aaav2Bkc4FeBq6Y
        Qink9PpxIQTa6jHErtw10m8Pwoc4rKNZdl7VVkWn6NbERrFnrY8yX41htKdALXAV7oriOA+fn58HI
        SInd4J2U311dsVXsUh7KI/Nz+af+LULSUtyFIeLTVvZiDppPybe6QJo2wvwoflglwo0fEQdHkzYBI
        fWfCoMqrpJ9f+9Xp1hbeLy2tMr6gIKN36LDg/+UfFNoKyScaoi+srqOBnN+hJqjFX4Ni6UTcGDyT3
        11tRm3LGMS1M/dJsBBhXLR7IAjMQE8b0BeHDzNbClZKGMba7ZJTzLGESp5c3M8HcMJXo8FG43kH4K
        N5r2I6VQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUKIM-00CIgE-55; Tue, 21 Feb 2023 04:30:26 +0000
Date:   Tue, 21 Feb 2023 04:30:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefan Roesch <shr@devkernel.io>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -v5 0/9] migrate_pages(): batch TLB flushing
Message-ID: <Y/RI4s45PZ6Bv2ZR@casper.infradead.org>
References: <20230213123444.155149-1-ying.huang@intel.com>
 <87a6c8c-c5c1-67dc-1e32-eb30831d6e3d@google.com>
 <874jrg7kke.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <2ab4b33e-f570-a6ff-6315-7d5a4614a7bd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ab4b33e-f570-a6ff-6315-7d5a4614a7bd@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 20, 2023 at 06:48:38PM -0800, Hugh Dickins wrote:
> Yes, that's a good principle, that we should avoid to lock/wait
> synchronously once we have locked one folio (hmm, above you say
> "more than one": I think we mean the same thing, we're just
> stating it differently, given how the code runs at present).

I suspect the migrate page code is disobeying the locking ordering
rules for multiple folios.  if two folios belong to the same file,
they must be locked by folio->index order, low to high.  If two folios
belong to different files, they must be ordered by folio->mapping, the
mapping lowest in memory first.  You can see this locking rule embedded
in vfs_lock_two_folios() in fs/remap_range.c.

I don't know what the locking rules are for two folios which are not file
folios, or for two folios when one is anonymous and the other belongs
to a file.  Maybe it's the same; you can lock them ordered by ->mapping
first, then by ->index.

Or you can just trylock multiple folios and skip the ones that don't work.
