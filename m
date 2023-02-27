Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D27C6A4303
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 14:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjB0NhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 08:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjB0NhD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:37:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C1B20555;
        Mon, 27 Feb 2023 05:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ePxJvQ0KvUvm6Gs3BEG2jGn/1JJyaeylcAdC0Se4Ji0=; b=U2/4vAGppTQb5yg/PqcAw3t8X7
        ftdPHbVBPAiuG4E/LOiPNZoOvf6l0815AuKYdGC3QmWjWGctvptLtAsv2S9RxouqY7uFQoPX2ipY7
        iXseEHajV+FeRSf+3M8mejeyW8eZFiMzhVwoILXXaf8WskHNWkx2fNnP3LHxEA2sjJK1j2jtbzoai
        ro1gFu0qDUTlNe1u2bnUc4fEaQgq+F4GkN/LzmKRUUdGC3doMBcKNKbSu/SA/GMvtr4qB/tlTIxKt
        vbOevMLT8VxCtN5I3i/ID3HNnbUAE5OdL8EwS65BgOqIcfqg2vEOGIWzH/AVz6GJzDBLzIObNY0eV
        l6AexNzA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWdfg-009mhW-Ep; Mon, 27 Feb 2023 13:36:04 +0000
Date:   Mon, 27 Feb 2023 05:36:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/5] block: Add support for bouncing pinned pages
Message-ID: <Y/yxxCwGJcPSuA+6@infradead.org>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-4-jack@suse.cz>
 <Y+oKAB/epmJNyDbQ@infradead.org>
 <20230214135604.s5bygnthq7an5eoo@quack3>
 <20230215045952.GF2825702@dread.disaster.area>
 <Y+x6oQkLex8PbfgL@infradead.org>
 <20230216123316.vkmtucazg33vidzg@quack3>
 <Y/MRqLbA2g7I0xgp@infradead.org>
 <20230227113926.jr7wuhmiul7346as@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227113926.jr7wuhmiul7346as@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 12:39:26PM +0100, Jan Kara wrote:
> Do you mean to copy these pages on fsync(2) to newly allocated buffer and
> then submit it via direct IO? That looks sensible to me. We could then make
> writeback path just completely ignore these long term pinned pages and just
> add this copying logic into filemap_fdatawrite() or something like that.

I don't think we'd even have to copy them on fsync.  Just do an in-kernel
ITER_BVEC direct I/O on them.  The only hard part would be to come up
with a way to skip the pagecache invalidation and writeout for these
I/Os.
