Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8824967DB30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 02:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjA0BVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 20:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjA0BVj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 20:21:39 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8F535A0;
        Thu, 26 Jan 2023 17:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gGNanL8G46JGgYjtUJ5J91o83MW/C/5JbHk+TwYeTLQ=; b=mGr5dbjFv4xfJzCUtrL6A294u+
        crMLLWhQQIUNYOiH+99G8D5hSKWsdbGz5HOJVp7VoOChiYlgUkvQ3BK8lQ4N/+hEqE45u4SYRJ1va
        I9OyAYHqd1rTi5wDFRQXQva5ewmDnCH4qaNBzRE+de5gsUiSVZiSlZgEDwnBl2fkM+f4Z5BfFGuY+
        qxH8oQ/S+cnhjMaYbkpK5CAAqLbMV2i1JpU1oOYIbU058EvBiIRbMBxROyYCtUrwlA2kVcmsTyZYw
        PhXoBdMOGViiaMJl7fGInATqIXvP80AgytCYFBfEt6dEPROroH+OxdzVkMDA+jNu+RYSc0Ree+Dsx
        3Ed3fM6A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pLDQk-004M0M-30;
        Fri, 27 Jan 2023 01:21:27 +0000
Date:   Fri, 27 Jan 2023 01:21:26 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v11 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Message-ID: <Y9MnFjvaXK8abDqD@ZenIV>
References: <ba3adce1-ddea-98e0-fc3a-1cb660edae4c@redhat.com>
 <20230126141626.2809643-1-dhowells@redhat.com>
 <20230126141626.2809643-3-dhowells@redhat.com>
 <Y9L3yA+B1rrnrGK8@ZenIV>
 <Y9MAbYt6DIRFm954@ZenIV>
 <2907150.1674777410@warthog.procyon.org.uk>
 <Y9MgVsrMdgGsxNHC@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9MgVsrMdgGsxNHC@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 27, 2023 at 12:52:38AM +0000, Al Viro wrote:
> On Thu, Jan 26, 2023 at 11:56:50PM +0000, David Howells wrote:
> > Al says that pinning a page (ie. FOLL_PIN) could cause a deadlock if a page is
> > vmspliced into a pipe with the pipe holding a pin on it because pinned pages
> > are removed from all page tables.  Is this actually the case?  I can't see
> > offhand where in mm/gup.c it does this.
> 
> It doesn't; sorry, really confused memories of what's going on, took a while
> to sort them out (FWIW, writeback is where we unmap and check if page is
> pinned, while pin_user_pages running into an unmapped page will end up
> with handle_mm_fault() (->fault(), actually) try to get the sucker locked
> and block on that until the writeback is over).

Umm...  OK, I really need to reread that area.  Hopefully will be done with
that by tomorrow...
