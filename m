Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299B1694224
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 10:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjBMJ7b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 04:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBMJ7a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:59:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81ACBDCF;
        Mon, 13 Feb 2023 01:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G6mJNTFdXCBiSQbKIesKHVwFHut27KlLdMYFyWKHjLI=; b=GFsr9EP5SXoHm3PT01WesMHX47
        dG7OFQDnqoDEG0bMvJ2a8doyk45mGQU++SFLVLIMis489aYd9Z0G5fcpCKbCghC03r+yBUxJkeScx
        1BoEhQmkMYZQ/P145XmBtEi5Hf9PdqTT434vCiaiNGnp2SORq5Ss5UoXfedn9hApm1+yBOANC9SaS
        x7G24MuY3jgBc13MBEEw0brXC1bMCNIaz56stDgVpBIsaGkMjydvkHkSzSg/2U0jO7dLECe14mE7k
        iHQ9gJqOAJP/n6NAD+mjWKK+mw23d5f3CMgMGvhvkX7yF17UalRr6XH5uC4k2BG6DSZekej1805EE
        RGxF4g2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRVcO-00E0EX-DP; Mon, 13 Feb 2023 09:59:28 +0000
Date:   Mon, 13 Feb 2023 01:59:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/5] block: Add support for bouncing pinned pages
Message-ID: <Y+oKAB/epmJNyDbQ@infradead.org>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209123206.3548-4-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eww.  The block bounc code really needs to go away, so a new user
makes me very unhappy.

But independent of that I don't think this is enough anyway.  Just
copying the data out into a new page in the block layer doesn't solve
the problem that this page needs to be tracked as dirtied for fs
accounting.  e.g. every time we write this copy it needs space allocated
for COW file systems.

Which brings me back to if and when we do writeback for pinned page.
I don't think doing any I/O for short term pins like direct I/O
make sense.  These pins are defined to be unpinned after I/O
completes, so we might as well just wait for the unpin instead of doing
anything complicated.

Long term pins are more troublesome, but I really wonder what the
defined semantics for data integrity writeback like fsync on them
is to start with as the content is very much undefined.  Should
an fsync on a (partially) long term pinned file simplfy fail?  It's
not like we can win in that scenario.
