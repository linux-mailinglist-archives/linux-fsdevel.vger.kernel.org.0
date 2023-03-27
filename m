Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72FF6C9934
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 02:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjC0A5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Mar 2023 20:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjC0A5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Mar 2023 20:57:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0287421B;
        Sun, 26 Mar 2023 17:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y4rrk/BoxyCld1nXBi3duNR/P4tM7eFuoP4ATdtR7tE=; b=BcaysuKG0nAGBS9JX5f7ngckEC
        Wsd6lWflVy5vwZSmvb/uAOaV3NSJ3ZdzuYUAOI7ZcEYNu3S1ZXJKqk609b2hIGSrnIjlTB1pG7JtC
        2gd30KofRBnkcGZpXNGxhHZHWNC6le16zwBonD5JVtF1zpDmRudPPB7FhFlmra+WxrrIwRRZIUZ4/
        YGgOg24lrDHBxbAS76zjax8TWyq7xBcdbgHTLphcUuG65kgQQ6Sh/qu1msMc1l+X1S9aYzmN5FxIU
        U/VEn4oF7zuesvCW4Twk2Qx/oTLo1v9EDwl7Q0kz0McXadbL2RGj/23bko5AJJZ+XRXxnpipWvT+7
        WgYIj5Jw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgbB0-009RIU-04;
        Mon, 27 Mar 2023 00:57:34 +0000
Date:   Sun, 26 Mar 2023 17:57:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/31] ext4: Convert ext4_finish_bio() to use folios
Message-ID: <ZCDp/SaPYkJTmGo8@infradead.org>
References: <20230126202415.1682629-5-willy@infradead.org>
 <87ttyy1bz4.fsf@doe.com>
 <ZBvG8xbGHwQ+PPQa@casper.infradead.org>
 <20230323145109.GA466457@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323145109.GA466457@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 23, 2023 at 07:51:09AM -0700, Darrick J. Wong wrote:
> Yes.  Let's leave bufferheads in the legacy doo-doo-dooooo basement
> instead of wasting more time on them.  Ideally we'd someday run all the
> filesystems through:
> 
> bufferheads -> iomap with bufferheads -> iomap with folios -> iomap with
> large folios -> retire to somewhere cheaper than Hawaii

For a lot of the legacy stuff (and with that I don't mean ext4) we'd
really need volunteers to do any work other than typo fixing and
cosmetic cleanups.  I suspect just dropping many of them is the only
thing we can do long term.

But even if we do the above for the data path for all file systems
remaining in tree, we still have buffer_heads for metadata.  And
I think buffered_heads really are more or less the right abstraction
there anyway.  And for these existing file systems we also do not
care about using large folios for metadata caching anyway.  The
only nasty part is that these buffer_heads use the same mapping
as all block device access, so we'll need to find a way to use
large folios for the block device mapping for the LBA size > page size
case, while supporting buffer heads for those file systems.  Nothing
unsolvable, but a bit tricky.
