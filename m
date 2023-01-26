Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B50067CF8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 16:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjAZPOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 10:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjAZPO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:14:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B36E36680;
        Thu, 26 Jan 2023 07:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jf0GYlkID4WfHzv9bLTw/+0umA4SZs7LmCsUqDXilJ4=; b=QgrN4+6HqfZ8xoumbUmAGVXdqP
        V3/DBO2YX15rUYgjoN9DvriVOWX8B2PmIyJfWF0wqWOACDGuzhIaiCdG7smMtUVOpqxuTlGzfSF9j
        bQjRvgwp6NB4YTYWEoVD6RIvW5t3SrmaNTZlJqmMNEpVJeTTklB9uABrJ2uZ8FOZReb8VYR2/ruEH
        YMvzWw8+ERFV6N3HrgVHiItcJsgstfLipVb+fKQGgVgRsYQe4sWg0cBx1/bHcfh9z9UduSSaGHlOx
        lMPtv2QaRcACKRFrqseKdsE1JTvaVCz74i84qn533KpeJ9hthmSpCZX7Uh1tV8V+NYeE9apl2BoBi
        2QcL+v/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL3xA-00BRFc-Mn; Thu, 26 Jan 2023 15:14:16 +0000
Date:   Thu, 26 Jan 2023 07:14:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v10 5/8] block: Replace BIO_NO_PAGE_REF with
 BIO_PAGE_REFFED with inverted logic
Message-ID: <Y9KYyPvFsGgZe4Gd@infradead.org>
References: <f70c9b67-5284-cd6a-7360-92a883bf9bb5@redhat.com>
 <20230125210657.2335748-1-dhowells@redhat.com>
 <20230125210657.2335748-6-dhowells@redhat.com>
 <2642148.1674732850@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2642148.1674732850@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 11:34:10AM +0000, David Howells wrote:
> David Hildenbrand <david@redhat.com> wrote:
> 
> > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > > cc: Al Viro <viro@zeniv.linux.org.uk>
> > > cc: Jens Axboe <axboe@kernel.dk>
> > > cc: Jan Kara <jack@suse.cz>
> > > cc: Matthew Wilcox <willy@infradead.org>
> > > cc: Logan Gunthorpe <logang@deltatee.com>
> > > cc: linux-block@vger.kernel.org
> > > ---
> > 
> > Oh, and I agree with a previous comment that this patch should also hold a
> > Signed-off-by from Christoph above your Signed-off-by, if he is mentioned as
> > the author via "From:".
> 
> I think that was actually in reference to patch 3, but yes - and possibly a
> Co-developed-by tag.  Christoph?

As I said feel free to add a co-developed by if you want.  But more
importantly restore my signoff from here:

http://git.infradead.org/users/hch/misc.git/commitdiff/37ea178d5d95166196112905aa75d85cb0416d49
