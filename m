Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788FB70ED6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 07:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbjEXFzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 01:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbjEXFzk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 01:55:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703C2132;
        Tue, 23 May 2023 22:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jdIJRr6SVbAXSsPF/i2aTGQx/YOfpWz8tHC0SKlBXi4=; b=bhZ/q6+BbvgH//aJqOs/m6J8Iz
        +iluoYt2ZJ8g0cscenhvfA5X65IhkckRAUYzkya87DkwdCo6YdN/coXONlstI7WVrcH5dus57/fiH
        AQTRj4f+Vb6RLA1cThpIX+mFOj5ujUWhXudJ/myZanGPeMkNoZDObVmAa9ltm3JaJbn5FU9gJ4QmT
        DNs8PzSe0nSinW1wti1EPfTh2gjMRRUCm0frJG/MHSioDV6HUIwJp5pBMy27IJjPsvGjOdzbGK0HE
        WSfIn5enW2dqrNATZaCM45sX/ZnHVxMALuPL3qYle7MGsW99GH5SgmSDaybr3b2VwkPMUiZTyqgMD
        Giy06sZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1hT6-00CRbU-25;
        Wed, 24 May 2023 05:55:28 +0000
Date:   Tue, 23 May 2023 22:55:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Extending page pinning into fs/direct-io.c
Message-ID: <ZG2m0PGztI2BZEn9@infradead.org>
References: <ZGxfrOLZ4aN9/MvE@infradead.org>
 <20230522205744.2825689-1-dhowells@redhat.com>
 <3068545.1684872971@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3068545.1684872971@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 09:16:11PM +0100, David Howells wrote:
> I've been poking at it this afternoon, but it doesn't look like it's going to
> be straightforward, unfortunately.  The mm folks have been withdrawing access
> to the pinning API behind the ramparts of the mm/ dir.  Further, the dio code
> will (I think), under some circumstances, arbitrarily insert the zero_page
> into a list of things that are maybe pinned or maybe unpinned, but I can (I
> think) also be given a pinned zero_page from the GUP code if the page tables
> point to one and a DIO-write is requested - so just doing if page == zero_page
> isn't sufficient.

Yes.  I think the proper workaround is to add a MM helper that just
pins a single page and make it available to direct-io.c.  It should not
be exported and clearly marked to not be used in new code.  

> What I'd like to do is to make the GUP code not take a ref on the zero_page
> if, say, FOLL_DONT_PIN_ZEROPAGE is passed in, and then make the bio cleanup
> code always ignore the zero_page.

I don't think that'll work, as we can't mix different pin vs get types
in a bio.  And that's really a good thing.

> Something that I noticed is that the dio code seems to wangle to page bits on
> the target pages for a DIO-read, which seems odd, but I'm not sure I fully
> understand the code yet.

I don't understand this sentence.
