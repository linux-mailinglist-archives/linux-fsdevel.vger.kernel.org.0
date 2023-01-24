Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CB8679C97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjAXOxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbjAXOxN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:53:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFB52126;
        Tue, 24 Jan 2023 06:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HlxO/ih5kKpQ090HZsMiu8xqao4TSbrCxWBxIkEv8rw=; b=XdNW0Fhs0ElZ3hlOb19ZbXNqNq
        m1D95Gyk1XM3hLiOSk6l3Oxh6IKVac757NWWnzo46edcGjy3nbnydIesEjVhK6FihmUBb73PzDTvv
        Q9gKr+rLPkbB6vJXegnCUF9bYNocKqHa6/BvKC71DBAzhqeaZpZcc8Yvziy+XTGlCm9rLY29FWIZM
        Lg/WJquY9I2k4P7nJ1ggpjgr2Gd1Hnfu0CpqWXHKsv/KShHMLtkr7nug5HMNJzM52leN7ASOo5efP
        mv0LrmtHILL4AAzcgM0q7LUbqafujXs00MvH9NSQRT8Zi9iK0EQ8rz2Fd16/VQkP7tHb/C2wkFgNu
        7Ill09lQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKKfL-004QIg-QR; Tue, 24 Jan 2023 14:52:51 +0000
Date:   Tue, 24 Jan 2023 06:52:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 03/10] mm: Provide a helper to drop a pin/ref on a page
Message-ID: <Y8/wwy6OJEqjzRfZ@infradead.org>
References: <fc18c4c9-09f2-0ca1-8525-5ce671db36c5@redhat.com>
 <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-4-dhowells@redhat.com>
 <874546.1674571293@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874546.1674571293@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:41:33PM +0000, David Howells wrote:
> Yes.  Christoph insisted that the bio conversion patch be split up.  That
> means there's an interval where you can get FOLL_GET from that.

The only place where we have both is in the block layer.  It never gets
set by bio_set_cleanup_mode.

Instead we can just keep using put_page dirctly for the BIO_PAGE_REFFED
case in the callers of bio_release_page and in bio_release_pages itself,
and then do away with bio_to_gup_flags and bio_release_page entirely.
