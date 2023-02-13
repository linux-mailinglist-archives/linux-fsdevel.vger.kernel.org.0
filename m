Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F25E69487E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 15:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjBMOr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 09:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBMOrZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:47:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F081C30E;
        Mon, 13 Feb 2023 06:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GwM3qx/DdQS9UgXafWzl7uUJSiwXYXjhkusEvVBw2js=; b=2wnEBTPxhSR9eYVZ7ZHOQwtJIN
        qDwh6bKhXxqJxckVIO2zKnC+8aw+293kn1GyYh/GtHy7hr+26kjcUtFIRf25AX35jUhXKFrCpKNJg
        0V+XUchr7YNsWZIitq8wCtUsFwCd+H1xU3o+/lr5JLCfR+D2JgLQtWZnK+yXN70uik/g3zvKZKpUU
        VI/+fLoRYUxe+S4VjUh/2kTR1Fklvg2ZEQ7QXmvHZ9l10W7TDLR5Rnck7GdCqutHOxATRWjFgumyr
        g7ZsKinFc0zK0xXnFwsMM3X59uh6ygTlgndGCBDbOtOGOcN+hnLiaByw7eV4fFdVfgIH9Nu5Z8g+9
        kryy04RA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRa6d-00F28T-N7; Mon, 13 Feb 2023 14:46:59 +0000
Date:   Mon, 13 Feb 2023 06:46:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 3/4] splice: Use init_sync_kiocb() in
 filemap_splice_read()
Message-ID: <Y+pNY691LAgqBbyy@infradead.org>
References: <20230213134619.2198965-1-dhowells@redhat.com>
 <20230213134619.2198965-4-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213134619.2198965-4-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 13, 2023 at 01:46:18PM +0000, David Howells wrote:
> +	init_sync_kiocb(&iocb, in);
> +	iocb.ki_pos = *ppos;
> +	iocb.ki_flags &= IOCB_NOWAIT;

This clears everything but IOCB_NOWAIT.  But even IOCB_NOWAIT should
not be cleared here as far as I can tell.
