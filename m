Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE2B663BD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 09:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjAJIwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 03:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbjAJIvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:51:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954FE517F9;
        Tue, 10 Jan 2023 00:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nJ61wRnxFVUsYl9SFxC5eY+Tep9Kp5bIVHbU5IX3Up0=; b=iw+pBYNgNcMuf33y1x2rsMBHZP
        Gfm26bygUwVEzoGLuu+KwK5SiXAC1YRVH7F7EQ6L/cKVcC0Ag+H3b96iEqx/h/m6RSUw+FqsNJ9XQ
        cZTjRP0C8+y3IuV2P5tL0Yi9AsXC7/3LefY4PBg2keENGW6a/9MlRiO887Hlh5mymSq1HktbrWadW
        6RJaXNJv+rir/Npk57b58tQmoNdxuw7dkzngCfH/gEzFAYVPlXj6XenRbtnqSmil6qNBlv7TSW2+3
        HfYuib5VpWtKntRFGDHWmtL365sLdJBZLIEdJShV++aUGPOyDAUns0rO8v3QV/MWL/VW7OosfN7Ll
        japyg1xQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFAMD-005vJa-Ql; Tue, 10 Jan 2023 08:51:45 +0000
Date:   Tue, 10 Jan 2023 00:51:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [RFC v6 08/10] iomap/xfs: Eliminate the iomap_valid handler
Message-ID: <Y70nIXBagWukaRVk@infradead.org>
References: <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-9-agruenba@redhat.com>
 <20230108215911.GP1971568@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108215911.GP1971568@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 08:59:11AM +1100, Dave Chinner wrote:
> Indeed, we also have this same "iomap valid check" functionality in the
> writeback code as cached iomaps can become stale due to racing
> writeback, truncated, etc. But you wouldn't know it by looking at the iomap
> writeback code - this is currently hidden by XFS by embedding
> the checks into the iomap writeback ->map_blocks function.

And that's in many ways a good thing, as it avoids various callouts
that are expensive and confusing.  Just like how this patch gets it
right by not having a mess of badly interacting callbacks, but
one that ensures that the page is ready.

> Hence I think removing ->iomap_valid is a big step backwards for the
> iomap core code - the iomap core needs to be able to formally verify
> the iomap is valid at any point in time, not just at the point in
> time a folio in the page cache has been locked...

For using it anywhere else but the buffered write path it is in the
wrong place to start with, and nonwithstanding my above concern I
can't relaly think of a good place and prototype for such a valid
callback to actually cover all use cases.
