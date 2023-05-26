Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFD5712226
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 10:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242323AbjEZI0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 04:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjEZI0M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 04:26:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEA7D8;
        Fri, 26 May 2023 01:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z0fK4mm2FXMJr87PqpFQg/otvRM35WQQChLJtGkFULo=; b=snRLEoo+C6lUyaPMnG6OQwFJQv
        aXzI9MFe8MXCqXRNCOaOTrbhJ49b2cTR8pjMQuwCPEdp9Tixb3bC3ApDBc9RbwAXmiFqa2zqpF8E4
        w7m0lSQWnlqjMYeTtfSZPDkO2yzQisapVSs6SMg/7kdXvdjbEGcAGBMaNDI3OF8GibRO7d713ocL3
        Rv4DdXy81PkM9H3CO3h1znvZuAybWZy4w/Yz5z6g2gFuHOediaVT8p66rZeq813viQzhYE5R+X7EO
        Or67cCPgG0BdOSIkOp5EX/OFATiR4PJo+W+DpebrLYhc7KRSQlXFXNE9kdaSvJJtWKDa2EZaDaLXH
        hX6eDANw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2Sls-001bLV-2l;
        Fri, 26 May 2023 08:26:00 +0000
Date:   Fri, 26 May 2023 01:26:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v2 3/3] block: Use iov_iter_extract_pages() and page
 pinning in direct-io.c
Message-ID: <ZHBtGJ3SzJtr5HZP@infradead.org>
References: <20230525223953.225496-1-dhowells@redhat.com>
 <20230525223953.225496-4-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525223953.225496-4-dhowells@redhat.com>
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

On Thu, May 25, 2023 at 11:39:53PM +0100, David Howells wrote:
> Change the old block-based direct-I/O code to use iov_iter_extract_pages()
> to pin user pages or leave kernel pages unpinned rather than taking refs
> when submitting bios.
> 
> This makes use of the preceding patches to not take pins on the zero page
> (thereby allowing insertion of zero pages in with pinned pages) and to get
> additional pins on pages, allowing an extracted page to be used in multiple
> bios without having to re-extract it.

I'm not seeing where we skip the unpin of the zero page, as commented
in patch 1 (but maybe I'm not reviewing carefully enough as I'm at a
conference right now).

Otherwise my only rather cosmetic comment right now is that I'd called
the "need_unpin" member is_pinned.

