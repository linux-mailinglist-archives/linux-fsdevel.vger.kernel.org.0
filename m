Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5025C660FC8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jan 2023 16:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjAGPG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Jan 2023 10:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAGPGZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Jan 2023 10:06:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC5E63F61;
        Sat,  7 Jan 2023 07:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FSFM4yR4blaFSxBzfnWN4hnvh0AQgFE6Wy1RI039p5g=; b=jMzef1yLFSyGPSDvT0zTsJnJLd
        jVFKm63WTul1j9a2Hixsj029wDInokmlFGWT0TUL4M6pxQJQELy5UHFflzNSXG4BQejzDN/DM8CfU
        JAGbwFHAr3VVnjFLBqM51AwLMSZPZOiup1A2i2YYOnmsvC5JpJYhHYEFn/bgaIigNxXwgmMhowtMO
        cKK4m2y7lDCYmZW5V55/9UZg+8eHRTTSkq4lPD7dVYjotH0nmZZDQCcHoYsIW+taaamRAIH/z3Rz0
        dw5IuX/yZZPQAmSfFWpEoS+RnfURgU1PHQ1mOOY8hUdreXoSf7vnD6npmHxNgF0f7Gz36dhMMwTKP
        v01R9DGA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEAly-000dbw-DB; Sat, 07 Jan 2023 15:06:14 +0000
Date:   Sat, 7 Jan 2023 15:06:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
        linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>,
        linux-erofs@lists.ozlabs.org, linux-ext4@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] mm: Make filemap_release_folio() better inform
 shrink_folio_list()
Message-ID: <Y7mKZj/RnD2aW5jU@casper.infradead.org>
References: <167172131368.2334525.8569808925687731937.stgit@warthog.procyon.org.uk>
 <167172134962.2334525.570622889806603086.stgit@warthog.procyon.org.uk>
 <Y6XJwvjKyTgRIiI3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6XJwvjKyTgRIiI3@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 23, 2022 at 07:31:14AM -0800, Christoph Hellwig wrote:
> On Thu, Dec 22, 2022 at 03:02:29PM +0000, David Howells wrote:
> > Make filemap_release_folio() return one of three values:
> > 
> >  (0) FILEMAP_CANT_RELEASE_FOLIO
> > 
> >      Couldn't release the folio's private data, so the folio can't itself
> >      be released.
> > 
> >  (1) FILEMAP_RELEASED_FOLIO
> > 
> >      The private data on the folio was released and the folio can be
> >      released.
> > 
> >  (2) FILEMAP_FOLIO_HAD_NO_PRIVATE
> 
> These names read really odd, due to the different placementments
> of FOLIO, the present vs past tense and the fact that 2 also released
> the folio, and the reliance of callers that one value of an enum
> must be 0, while no unprecedented, is a bit ugly.

Agreed.  The thing is that it's not the filemap that's being released,
it's the folio.  So these should be:

	FOLIO_RELEASE_SUCCESS
	FOLIO_RELEASE_FAILED
	FOLIO_RELEASE_NO_PRIVATE

... but of course, NO_PRIVATE is also a success.  So it's a really weird
thing to be reporting.  I'm with you on the latter half of this email:

> But do we even need them?  What abut just open coding
> filemap_release_folio (which is a mostly trivial function) in
> shrink_folio_list, which is the only place that cares?
> 
> 	if (folio_has_private(folio) && folio_needs_release(folio)) {
> 		if (folio_test_writeback(folio))
> 			goto activate_locked;
> 
> 		if (mapping && mapping->a_ops->release_folio) {
> 			if (!mapping->a_ops->release_folio(folio, gfp))
> 				goto activate_locked;
> 		} else {
> 			if (!try_to_free_buffers(folio))
> 				goto activate_locked;
> 		}
> 
> 		if (!mapping && folio_ref_count(folio) == 1) {
> 			...
> 
> alternatively just keep using filemap_release_folio and just add the
> folio_needs_release in the first branch.  That duplicates the test,
> but makes the change a one-liner.

Or just drop patch 3 entirely?
