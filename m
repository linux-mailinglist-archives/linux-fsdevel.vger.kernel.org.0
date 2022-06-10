Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498ED545E14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 10:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347114AbiFJIBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 04:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346628AbiFJIBB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:01:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D31220BE16;
        Fri, 10 Jun 2022 01:01:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7CBAE68AA6; Fri, 10 Jun 2022 10:00:58 +0200 (CEST)
Date:   Fri, 10 Jun 2022 10:00:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH 4/5] fs: don't call ->writepage from __mpage_writepage
Message-ID: <20220610080058.GB29310@lst.de>
References: <20220608150451.1432388-1-hch@lst.de> <20220608150451.1432388-5-hch@lst.de> <20220609173119.b34yp6ey6ybokfdl@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609173119.b34yp6ey6ybokfdl@quack3.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 09, 2022 at 07:31:19PM +0200, Jan Kara wrote:
> On Wed 08-06-22 17:04:50, Christoph Hellwig wrote:
> > All callers of mpage_writepage use block_write_full_page as their
> > ->writepage implementation, so hard code that.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Similarly here NTFS (fs/ntfs3/) seems to have some non-trivial stuff besides
> block_write_full_page()...

Indeed, ntfs3 will need a prep patch to unwind this mess.  Thanks
for catching this!
