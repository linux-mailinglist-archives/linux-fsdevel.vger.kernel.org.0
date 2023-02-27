Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836A06A4C38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 21:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjB0UZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 15:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjB0UY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:24:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53752333B
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 12:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jsu++lcHYzuet/KiQ3YlPNZNjeeuY0q0dMt84g4AOO4=; b=pF/JXdmLH+qUkvD7NBgSSAXU48
        ouw1p3TSniwljGe7vrzt0qcN1vzSumtdLK+U418cBgNZW6eC0h2WcKJuN2qXOzNCE1PlyyMyJKvss
        Ai219Ccgx1/Xj8dXRsKSwk0vipETwwYIzf5hgrfopqqt/GTxIb9sG/dXV8TyswnLCH9RWNc2XmqgI
        564FBdWxiTjuH8+kTiIRoIX2xVIMjOpqtSZjTHRvCTwdFUJSs7hp6IvBGp9oOahSpXwTrK8wMhBky
        fCf3caB0aeF0vC1klHy+lkEhEKB+dC6XKDmrvRivtJ6IekFbyiyGgI24i7exoqtO4v7mbJtR+T/vX
        H9sok0og==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWk3H-00B9g1-Ps; Mon, 27 Feb 2023 20:24:51 +0000
Date:   Mon, 27 Feb 2023 12:24:51 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "kbus >> Keith Busch" <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: LSF/MM/BPF 2023 IOMAP conversion status update
Message-ID: <Y/0RkzEv8ysuXntk@bombadil.infradead.org>
References: <20230129044645.3cb2ayyxwxvxzhah@garbanzo>
 <Y9X+5wu8AjjPYxTC@casper.infradead.org>
 <Y/0IzG4S2l52oC7R@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/0IzG4S2l52oC7R@magnolia>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 11:47:24AM -0800, Darrick J. Wong wrote:
> OTOH, it also means that we've learned the hard way that pagecache
> operations need a means to revalidate mappings to avoid write races.
> This applies both to the initial pagecache write and to scheduling
> writeback, but the mechanisms for each were developed separately and
> years apart.  See iomap::validity_cookie and
> xfs_writepage_ctx::{data,cow}_seq for what I'm talking about.
> We (xfs developers) ought to figure out if these two mechanisms should
> be merged before more filesystems start using iomap for buffered io.

That puts a good yield notice to some conversion efforts, thanks, this
already alone is very useulf.

> I'd like to have a discussion about how to clean up and clarify the
> iomap interfaces, and a separate one about how to port the remaining 35+
> filesystems.  I don't know how exactly to split this into LSF sessions,
> other than to suggest at least two.

From a conversion perspective, ideally if it was obvious I think we
should be able to do some of it ala coccinelle, but I have yet to see
any remotely obvious pattern. And it makes me wonder, should we strive
to make the conversion as painless / obvious ? Is that a good litmus
for when we should be ready to start converting other filesystems?

> If hch or dchinner show up, I also want to drag them into this. :)

And here I've been thinking I had to go to Australia to see you all together.

  Luis
