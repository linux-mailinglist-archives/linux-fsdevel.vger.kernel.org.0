Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7469A777CBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 17:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbjHJPwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 11:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjHJPw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:52:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F6C19F;
        Thu, 10 Aug 2023 08:52:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0AF5B67373; Thu, 10 Aug 2023 17:52:26 +0200 (CEST)
Date:   Thu, 10 Aug 2023 17:52:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 07/13] xfs: document the invalidate_bdev call in
 invalidate_bdev
Message-ID: <20230810155225.GD28000@lst.de>
References: <20230809220545.1308228-1-hch@lst.de> <20230809220545.1308228-8-hch@lst.de> <ZNUAp8FJIKU1/sTn@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNUAp8FJIKU1/sTn@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 04:22:15PM +0100, Matthew Wilcox wrote:
> >  		blkdev_issue_flush(mp->m_logdev_targp->bt_bdev);
> >  		invalidate_bdev(mp->m_logdev_targp->bt_bdev);
> 
> While I have no complaints with this as a commit message, it's just too
> verbose for an inline comment, IMO.  Something pithier and more generic
> would seem appropriate.  How about:
> 
> 	/*
> 	 * Prevent userspace (eg blkid or xfs_db) from seeing stale data.
> 	 * XFS is not coherent with the bdev's page cache.
> 	 */

Well, this completely misses the point.  The point is that XFS should
never have to invalidate the page cache because it's not using it,
but it has to due to weird races.  I tried to condese the message but
I could not come up with a good one that's not losing information.
