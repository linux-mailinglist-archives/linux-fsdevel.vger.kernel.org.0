Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2CE6619FA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 22:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbjAHVbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 16:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbjAHVbd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:31:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401C7BD2;
        Sun,  8 Jan 2023 13:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=++R3apswKn917ceG4txQXiZ1LJjLtj+nBEmEVXkWhS8=; b=dm/cLFNaKZAOrFlytHsOvTk2Jr
        ez8yteUWEcM+9Gvjd7lmrZYc8XtHwp9CxOiARQuiTXyFgAsjzy3BvOKdi6Oqkw4uYoM5bx9Zhquvd
        CfqTrxz9e1zrOlo3uKseyW7BDZTUKqM93uHTKqr+TKAQdIWYJ1GpWrZKrdQzGnvUt1TA+wb8u28/V
        qfs/1IGoaHoVjwdS40H5YXZN03jNyFQ5Ct+IpTy9QHadGXXKZIlrIjyAJVKd/VvXA+Njjonyf3h/h
        mavaFrnmkentZmOxii9RnnHf+WPa18T290G6Rs7XdgCFtfqKtR3EsibJzFKgmY2YydLv7S0chGUn7
        WdsGGqeA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEdGM-001l4v-H0; Sun, 08 Jan 2023 21:31:30 +0000
Date:   Sun, 8 Jan 2023 21:31:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        linux-btrfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: remove write_one_page / folio_write_one
Message-ID: <Y7s2Mo+XR4YJUfoH@casper.infradead.org>
References: <20230108165645.381077-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108165645.381077-1-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 08, 2023 at 05:56:38PM +0100, Christoph Hellwig wrote:
> this series removes the write_one_page API, and it's folioized
> implementation as folio_write_one.  These helpers internally call
> ->writepage which we are gradually removing from the kernel.
> 
> For most callers there are better APIs to use, and this cleans them up.
> The big questionmark is jfs, where the metapage abstraction uses the
> pagecache in a bit of an odd way, and which would probably benefit from
> not using the page cache at all like the XFS buffer cache, but given
> that jfs has been in minimum maintaince mode for a long time that might
> not be worth it.  So for now it just moves the implementation of
> write_one_page into jfs instead.

Thanks.  This totally wrecks a patchset I was working on, but it's
definitely the right thing to do, and I'll rebase on top of it once
it's in.  Looking forward to v2 with my niggles fixed ;-)
