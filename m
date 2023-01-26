Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3570D67D83F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 23:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjAZWPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 17:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjAZWPY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:15:24 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B591D42DD5;
        Thu, 26 Jan 2023 14:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jd/5WIrcHcZzAYHPugOmZ9o+ttQGJRTdajMdq6eexVQ=; b=poCgIh0b2tUBO/p9HbXoT9N6pJ
        zx+i2ZI4FFh50Ucj8MSNsEEJO+ir8dAn3D9mfCbSJ9/hghKTWm+vntEsb7hSTR4ZC+k59zRY/3bHA
        Jvs3efe71mZtbyvytGsKHk4Gah85oxCcnzMlmy2a0Vipjz/0LXhXLHFxEP0jLg5Pj7bwnutTI+Bsr
        klni0UFu3h603jdMcn+xvTdmOG4Y9x7/NZJJ0FK+42PBt+LcjHCqy8nchhFPYVNi+6PFTrbkaG77u
        zkRxfm+dNHWlGVSfeunz2AczKYTDikGJPapL9hwGHHk6SzhXMnGiRPsQHaUhB/rYixXLWyNBGIa01
        aKIUcTcQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pLAWX-004KFl-0g;
        Thu, 26 Jan 2023 22:15:13 +0000
Date:   Thu, 26 Jan 2023 22:15:13 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Hildenbrand <david@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Message-ID: <Y9L7cRFFZh9A7kZY@ZenIV>
References: <7bbcccc9-6ebf-ffab-7425-2a12f217ba15@redhat.com>
 <246ba813-698b-8696-7f4d-400034a3380b@redhat.com>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-3-dhowells@redhat.com>
 <3814749.1674474663@warthog.procyon.org.uk>
 <3903251.1674479992@warthog.procyon.org.uk>
 <c742e47b-dcc0-1fef-dc8c-3bf85d26b046@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c742e47b-dcc0-1fef-dc8c-3bf85d26b046@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 02:24:13PM +0100, David Hildenbrand wrote:
> On 23.01.23 14:19, David Howells wrote:
> > David Hildenbrand <david@redhat.com> wrote:
> > 
> > > Switching from FOLL_GET to FOLL_PIN was in the works by John H. Not sure what
> > > the status is. Interestingly, Documentation/core-api/pin_user_pages.rst
> > > already documents that "CASE 1: Direct IO (DIO)" uses FOLL_PIN ... which does,
> > > unfortunately, no reflect reality yet.
> > 
> > Yeah - I just came across that.
> > 
> > Should iov_iter.c then switch entirely to using pin_user_pages(), rather than
> > get_user_pages()?  In which case my patches only need keep track of
> > pinned/not-pinned and never "got".
> 
> That would be the ideal case: whenever intending to access page content, use
> FOLL_PIN instead of FOLL_GET.
> 
> The issue that John was trying to sort out was that there are plenty of
> callsites that do a simple put_page() instead of calling unpin_user_page().
> IIRC, handling that correctly in existing code -- what was pinned must be
> released via unpin_user_page() -- was the biggest workitem.
> 
> Not sure how that relates to your work here (that's why I was asking): if
> you could avoid FOLL_GET, that would be great :)

Take a good look at iter_to_pipe().  It does *not* need to pin anything
(we have an ITER_SOURCE there); with this approach it will.  And it
will stuff those pinned references into a pipe, where they can sit
indefinitely.

IOW, I don't believe it's a usable approach.
