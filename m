Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F35563EAE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Jul 2022 07:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiGBFgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Jul 2022 01:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBFgL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Jul 2022 01:36:11 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B79B26AC1
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 22:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5FE3LsF/DEUJMyOYSyHIieSj47E1K4rb1WlzsgU7Hpw=; b=ZqkAA2Jgw2qm5gTHrEne895/oD
        uUhVNVC1u/vARGCZdwReJItLvzNXNqFh2rR1tnsNzIa5je0/T/jo5Ep7m24TzX7G3KY6bijs8AQXr
        mNQbHD2q5g60KieQqKkSfMVFcDKfpMTO+TKMBeDjpE2SqQLGhNV5wNwEGkiEW4BP0IPZSbfDZBQlt
        R1cZDCgDZ7ld6/uSXhqxRouEEIwy9s3iQ9oXWfpIJCsKczMiQU+ZPXgxm16gUgPd3d8/q3SXhb/+U
        hJX6VSU+14HGZVUV39xv5/gNyMTWl+iG6sjQF5hpVgofGVUTmUcSmAz7razpFh3lA52VVl0m+6PAD
        aw/XFPPQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o7VnS-007ESr-9M;
        Sat, 02 Jul 2022 05:35:58 +0000
Date:   Sat, 2 Jul 2022 06:35:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [block.git conflicts] Re: [PATCH 37/44] block: convert to
 advancing variants of iov_iter_get_pages{,_alloc}()
Message-ID: <Yr/ZPpai40fgEFfk@ZenIV>
References: <Yr5W3G19zUQuCA7R@kbusch-mbp.dhcp.thefacebook.com>
 <Yr8xmNMEOJke6NOx@ZenIV>
 <Yr80qNeRhFtPb/f3@kbusch-mbp.dhcp.thefacebook.com>
 <Yr838ci8FUsiZlSW@ZenIV>
 <Yr85AaNqNAEr+5ve@ZenIV>
 <Yr8/LLXaEIa7KPDT@kbusch-mbp.dhcp.thefacebook.com>
 <Yr9GNfmeO/xCjzD4@ZenIV>
 <Yr9KzV6u2iTPPQmq@kbusch-mbp.dhcp.thefacebook.com>
 <Yr9OZJ9Usn24XYFG@ZenIV>
 <Yr9Rhem4LH3i978m@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr9Rhem4LH3i978m@kbusch-mbp.dhcp.thefacebook.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 01, 2022 at 01:56:53PM -0600, Keith Busch wrote:

> Validating user requests gets really messy if we allow arbitrary segment
> lengths. This particular patch just enables arbitrary address alignment, but
> segment size is still required to be a block size. You found the commit that
> enforces that earlier, "iov: introduce iov_iter_aligned", two commits prior.

BTW, where do you check it for this caller?
	fs/zonefs/super.c:786:  ret = bio_iov_iter_get_pages(bio, from);
Incidentally, we have an incorrect use of iov_iter_truncate() in that one (compare
with iomap case, where we reexpand it afterwards)...

I still don't get the logics of those round-downs.  You've *already* verified
that each segment is a multiple of logical block size.  And you are stuffing
as much as you can into bio, covering the data for as many segments as you
can.  Sure, you might end up e.g. running into an unmapped page at wrong
offset (since your requirements for initial offsets might be milder than
logical block size).  Or you might run out of pages bio would take.  Either
might put the end of bio at the wrong offset.

So why not trim it down *after* you are done adding pages into it?  And do it
once, outside of the loop.  IDGI...  Validation is already done; I'm not
suggesting to allow weird segment lengths or to change behaviour of your
iov_iter_is_aligned() in any other way.

Put it another way, is there any possibility for __bio_iov_iter_get_pages() to
do a non-trivial round-down on anything other than the last iteration of that
loop?
