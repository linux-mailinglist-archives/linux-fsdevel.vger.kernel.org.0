Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBE0694B0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 16:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjBMPZ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 10:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjBMPZT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:25:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7012558E;
        Mon, 13 Feb 2023 07:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=is2NWtV2VTNxnUCu5cWYDtgITYpFKETTOtG4XpHoOLE=; b=j+65y77VNVY+M53FFuWII8CE4C
        DGghunoeQbW1eo7fDwF07WCCdeeNhsTZRhelfjn7o9kkrXUi2WRvBK38IN/YIvgHjlNGvTFkSTkTd
        ADv9oo1MZ2P5HXu5rab6FYWS+ILR6JjQ5s/AWhw3hLuC4fNmX+bsoYIJwX832i+Vu8cxLMWCdCQrW
        wsaVBIFYKl7DwNTvKSeifxwOF3svaLT5rBnPbOouSsLcZaGhmUAKHnvuJZkdxFYZcrm+fQ04JWhMS
        S30idVBg+xaoUvVr8YCB9NbLtZI42Ge2WoPf/zsrranEiQGvRMYl1odRMM07aYzSP8CILWXJi5tJw
        a9EbcAfw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRahL-005seU-PI; Mon, 13 Feb 2023 15:24:55 +0000
Date:   Mon, 13 Feb 2023 15:24:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
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
Message-ID: <Y+pWRx2ly/qdFq9k@casper.infradead.org>
References: <20230213134619.2198965-1-dhowells@redhat.com>
 <20230213134619.2198965-4-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213134619.2198965-4-dhowells@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 13, 2023 at 01:46:18PM +0000, David Howells wrote:
> Use init_sync_kiocb() in filemap_splice_read() rather than open coding it
> and filter out IOCB_NOWAIT since the splice is synchronous.

If the user has asked for NOWAIT and the splice is going to be
synchronous, shouldn't we rather return -EWOULDBLOCK here?  Or
does this not block?

IOW, this either does the wrong thing, or it does something that's
irrelevant.

