Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA6F58F767
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 07:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiHKF6T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 01:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiHKF6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 01:58:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795F879A63;
        Wed, 10 Aug 2022 22:58:16 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2AF2968AA6; Thu, 11 Aug 2022 07:58:12 +0200 (CEST)
Date:   Thu, 11 Aug 2022 07:58:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@lst.de>, Mel Gorman <mgorman@suse.de>,
        Jan Kara <jack@suse.cz>, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: remove iomap_writepage v2
Message-ID: <20220811055811.GA12359@lst.de>
References: <20220719041311.709250-1-hch@lst.de> <20220728111016.uwbaywprzkzne7ib@quack3> <20220729092216.GE3493@suse.de> <20220729141145.GA31605@lst.de> <Yufx5jpyJ+zcSJ4e@cmpxchg.org> <YvQYjpDHH5KckCrw@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvQYjpDHH5KckCrw@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 10, 2022 at 09:43:58PM +0100, Matthew Wilcox wrote:
> To avoid duplicating work with you or Christoph ... it seems like the
> plan is to kill ->writepage entirely soon, so there's no point in me
> doing a sweep of all the filesystems to convert ->writepage to
> ->write_folio, correct?

While I won't commit to concrete definition of "soon" I think that is
the general plan, and I don't think converting ->writepage to
->write_folio is needed.

> I assume the plan for filesystems which have a writepage but don't have
> a ->writepages (9p, adfs, affs, bfs, ecryptfs, gfs2, hostfs, jfs, minix,
> nilfs2, ntfs, ocfs2, reiserfs, sysv, ubifs, udf, ufs, vboxsf) is to give
> them a writepages,

and  ->migrate_folio if missing, yes.

> modelled on iomap_writepages().  Seems that adding
> a block_writepages() might be a useful thing for me to do?

We have mpage_writepages which basically is the ->writepages counterpart
to block_write_full_page.  The only caveat is of course that it can
use multi-block mappings from the get_bock callback, so we need to make
sure the file systems don't do anything stupid there.
