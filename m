Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570FE70D41B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 08:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjEWGkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 02:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEWGkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 02:40:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30EC119;
        Mon, 22 May 2023 23:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mhb2D8wxaUdoso9990IdDeANdXYgpQ6YKPHN0xOlZJI=; b=VajJCGfSR+AMMCU+kW3mWkdTex
        PDTINv6I14VakgdsK3oi8rd8/pOgiQyDnEKAdnmFM+rJfuD7iPd1MV5kBsEZFb89GTYSk/YBr8NwP
        2sHVcrDi3gvQlOJU2b6PZ3pFE+ZUDnblCuhSvIN+P/vJcE0x/D3XUzYvAdw0xT8IY5B/gs9ILXKyM
        e4lmExxZOQXK2uHpddjK8X0F0W+LYs6KCveZ8cnkiTgoIkHBOl/B8XoN+u5KD7777UVAuVnvLtjGk
        DUseUSJC9jwdHO+SlOiMmPmFbRKnaLphaekqtwqKm3QXPfdYoLXgsj+NS69JNua4FhardcqypLLlI
        pZB31X3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1LgK-0096BI-31;
        Tue, 23 May 2023 06:39:40 +0000
Date:   Mon, 22 May 2023 23:39:40 -0700
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
Subject: Re: [PATCH v21 0/6] block: Use page pinning
Message-ID: <ZGxfrOLZ4aN9/MvE@infradead.org>
References: <20230522205744.2825689-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522205744.2825689-1-dhowells@redhat.com>
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

On Mon, May 22, 2023 at 09:57:38PM +0100, David Howells wrote:
> Hi Jens, Al, Christoph,
> 
> This patchset rolls page-pinning out to the bio struct and the block layer,
> using iov_iter_extract_pages() to get pages and noting with BIO_PAGE_PINNED
> if the data pages attached to a bio are pinned.  If the data pages come
> from a non-user-backed iterator, then the pages are left unpinned and
> unref'd, relying on whoever set up the I/O to do the retaining.

I think I already review the patches, so nothing new here.  But can
you please also take care of the legacy direct I/O code?  I'd really
hate to leave yet another unfinished transition around.
