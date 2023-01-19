Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FF66731B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 07:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjASGWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 01:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjASGWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 01:22:17 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA30AE3;
        Wed, 18 Jan 2023 22:22:16 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6466367373; Thu, 19 Jan 2023 07:22:13 +0100 (CET)
Date:   Thu, 19 Jan 2023 07:22:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Bob Peterson <rpeterso@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] gfs2: stop using generic_writepages in
 gfs2_ail1_start_one
Message-ID: <20230119062213.GA17855@lst.de>
References: <20220719041311.709250-1-hch@lst.de> <20220719041311.709250-2-hch@lst.de> <CAHc6FU5A71L0r2k5z7QoBZe3pO+5G1nMNvKfGmJzprQWFyDCog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU5A71L0r2k5z7QoBZe3pO+5G1nMNvKfGmJzprQWFyDCog@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:22:20PM +0100, Andreas Gruenbacher wrote:
> The above change means that instead of calling generic_writepages(),
> we end up calling filemap_fdatawrite_wbc() -> do_writepages() ->
> mapping->a_ops->writepages(). But that's something completely
> different; the writepages address space operation operates is outward
> facing, while we really only want to write out the dirty buffers /
> pages in the underlying address space. In case of journaled data
> inodes, gfs2_jdata_writepages() actually ends up trying to create a
> filesystem transaction, which immediately hangs because we're in the
> middle of a log flush.
> 
> So I'm tempted to revert the following two of your commits; luckily
> that's independent from the iomap_writepage() removal:
> 
>   d3d71901b1ea ("gfs2: remove ->writepage")
>   b2b0a5e97855 ("gfs2: stop using generic_writepages in gfs2_ail1_start_one")

generic_writepages is gone in linux-next, and I'd really like to keep
it that way.  So if you have to do this, please open code it
using write_cache_pages and a direct call to the writepage method of
choice.

> I think we could go through iomap_writepages() instead of
> generic_writepages() here as well,  but that's for another day.

Well, that would obviously be much better, and actually help with the
goal of removing ->writepage.
