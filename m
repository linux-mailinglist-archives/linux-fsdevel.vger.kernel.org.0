Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D0067AA54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 07:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjAYGaj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 01:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbjAYGai (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 01:30:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC063C29E;
        Tue, 24 Jan 2023 22:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r0FuSmIbgkYy4WewyKyVPD9wcDWCGfj1WkmqOviCddk=; b=ihARzO3OK8WC8X+vTJmE+5otl8
        LZP1ZuRMG3qrzWCWLr4tH9hnsQeyWtOrepDcCtrtfxAZxnvpvzVfhAMtzCO/DX7pYsT464vkm5oYm
        C5r4hEewgpigvEvUYkh2MDp2gWbcd3Jn75drGz1IIataCn30kMqVUrpu/gVcb7+rvch02c9A++JZ4
        YhAEPHpLEYDPuz4mFdAAOh4CyY/qe9UuUm/aNKAQlOxaTLGCP5wt6ji7eKAU4FyvHr5ZmfzNiwrk2
        /wOeqaX3hMpc/jJRBpO2Qy5YOda7852iLJmNMucamNSA+W80370DYMZiU3oar3x8PcOqa4/6d40cL
        sGRYk8ig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKZIi-0067v4-MS; Wed, 25 Jan 2023 06:30:28 +0000
Date:   Tue, 24 Jan 2023 22:30:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v9 6/8] block: Switch to pinning pages.
Message-ID: <Y9DMhJ4NczaA6HGL@infradead.org>
References: <Y9ArYfXEix7t3gVI@infradead.org>
 <20230124170108.1070389-1-dhowells@redhat.com>
 <20230124170108.1070389-7-dhowells@redhat.com>
 <1297804.1674593951@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1297804.1674593951@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 08:59:11PM +0000, David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > > Add BIO_PAGE_PINNED to indicate that the pages in a bio are pinned
> > > (FOLL_PIN) and that the pin will need removing.
> > 
> > The subject is odd when this doesn't actually switch anything,
> > but just adds the infrastructure to unpin pages.
> 
> How about:
> 
> 	block: Add BIO_PAGE_PINNED and associated infrastructure

sounds good.
