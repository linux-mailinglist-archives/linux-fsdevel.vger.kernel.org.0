Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531B167E58C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 13:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbjA0Mje (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 07:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbjA0MjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:39:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675EE74A63;
        Fri, 27 Jan 2023 04:38:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 191481FEC1;
        Fri, 27 Jan 2023 12:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674823093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zFTeq0Ir3N0EQQDMB0lGOwLZFNJenO+6frYOzCsuQKs=;
        b=jCP327G2dfrI2QqS8DkXJJpArCLMvNvuEfU8Ewt1Uhmy0Kb0xGllkzkgC22K2pWQlOmfMD
        4kGWg2Rrm7MiaRAoRvF6COqldN+34BS4lxlqdicszAUnAZjf9sKAEKSc704MViQht8nNl9
        7mw+T5A3gPoWHWrh48v4ZDRRmM4LJUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674823093;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zFTeq0Ir3N0EQQDMB0lGOwLZFNJenO+6frYOzCsuQKs=;
        b=54sm+x/VqYq1b99FVNZ6kbI0fjZp3HiJ+ifLGBybOL1CSDsvofjo0hQHokdR38PbQ6VFNr
        OCgoKYXa5FSjmMCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02A961336F;
        Fri, 27 Jan 2023 12:38:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l3KmALXF02MdBwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 27 Jan 2023 12:38:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 77ED2A06B4; Fri, 27 Jan 2023 13:38:12 +0100 (CET)
Date:   Fri, 27 Jan 2023 13:38:12 +0100
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>,
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
Message-ID: <20230127123812.qj2v5mtjllutawcq@quack3>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 27-01-23 00:52:38, Al Viro wrote:
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
> 
> Said that, I still think that pinned pages (arbitrary pagecache ones,
> at that) ending up in a pipe is a seriously bad idea.  It's trivial to
> arrange for them to stay that way indefinitely - no priveleges needed,
> very few limits, etc.

I tend to agree but is there a big difference compared to normal page
references? There's no difference for memory usage, pages still can be
truncated from the file and disk space reclaimed (this is where DAX has
problems...) so standard file operations won't notice. The only difference
is that they could stay permanently dirty (we don't know whether the pin
owner copies data to or from the page) so it could cause trouble with dirty
throttling - and it is really only the throttling itself - page reclaim
will have the same troubles with both pins and ordinary page references...
Am I missing something?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
