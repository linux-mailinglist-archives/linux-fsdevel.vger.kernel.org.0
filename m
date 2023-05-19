Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4431870918B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 10:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjESISm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 04:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjESISl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 04:18:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB8EE6;
        Fri, 19 May 2023 01:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BFzUO2iOYxpQ+ci9kXmcQJ5nhyqRwqFMh5f27RJ2EnE=; b=hAZn1zDXW7SqV0VvUeQLCcPL6v
        SJ4rnXkGFdB45EfWLQXqLoXg705MMv+K9t6/IsJkyy8ZfPK8c174f10qmVNS18l4pOHI8L0Q2Ff7C
        xIoqvT5vA6xz+H5LBIEJE9dnvKbXgUbY/awctaAgG5AOxX+IseDCX0fbwXcSAGKuQFwlJ5JogZ8rb
        lxYq/GlXj3p8vCDDuUnBbr8rI7CV61kwR6MSO+1kFcJlB2fKfS70gPiJt16Hp7W6ykWLSjjW4+pBd
        Ac7PVxciNnaTn3uSZTYtbojxi7QSObPYDCy7kNqzIjxf2YGxvSmbFBJrpvQfxGK7UKsFZIZ2rPWsh
        QWBNMBrw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzvJl-00FV3Z-1w;
        Fri, 19 May 2023 08:18:29 +0000
Date:   Fri, 19 May 2023 01:18:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
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
Subject: Re: [PATCH] iov_iter: Add automatic-alloc for ITER_BVEC and use in
 direct_splice_read()
Message-ID: <ZGcw1T9tLX7tZor0@infradead.org>
References: <20230519074047.1739879-1-dhowells@redhat.com>
 <1740264.1684482558@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740264.1684482558@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 08:49:18AM +0100, David Howells wrote:
> direct_splice_read() is then modified to make use of this.  This is less
> efficient if we know in advance that we want to allocate the full buffer as
> we can't so easily use bulk allocation, but it does mean in cases where we
> might not want the full buffer (say we hit a hole in DIO), we don't have to
> allocate it.

Can you eplain the workloads we're trying to optimize for here?

To me splice on O_DIRECT is more of a historic accident than an actually
good use case..
