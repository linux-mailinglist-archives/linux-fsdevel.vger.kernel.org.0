Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA35468F310
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 17:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjBHQUP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 11:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBHQUN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:20:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A520C10EC;
        Wed,  8 Feb 2023 08:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LdWmKE8iSIX1JlD2STqVG0cGUOnOBTQ2AvkgJAV1Ucw=; b=mzpUA3HNhoAPzog8HOG696touj
        O4bPToePR6BJZyqSoKQZwpXI3Sr/Aa/CM+ph4rCpAdCGtSo/xwCaX3Uv+A7K/BqUmm1J9kiW9vYLv
        5vkbTBCBhEbhqkIBAW3P5qFZ1qioHcDKFj4IxB02xSbP0r41dIndR94DuXY43KOnM5ztcmz3+a1oz
        xeA1ETJl8rK5BGdIbdtE7fs2iIBY0YOiQD6QoRArx69tYSAdfUTli5YiIP5HNZrZ2pDOJqgSh+nPY
        wnbdumaj4MLlobdcYTMAHbGVXdZzwvuKoB6dBKSBiBh9EMoJragF8nZxpQ4zFqKW4tR0wOpMBCLgV
        /EnT95QQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPnAq-00GEkU-2z; Wed, 08 Feb 2023 16:19:56 +0000
Date:   Wed, 8 Feb 2023 08:19:56 -0800
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
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v12 01/10] vfs, iomap: Fix generic_file_splice_read() to
 avoid reversion of ITER_PIPE
Message-ID: <Y+PLrOM05FMCiTIg@infradead.org>
References: <Y+MydH2HZ7ihITli@infradead.org>
 <20230207171305.3716974-1-dhowells@redhat.com>
 <20230207171305.3716974-2-dhowells@redhat.com>
 <176199.1675872591@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176199.1675872591@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 08, 2023 at 04:09:51PM +0000, David Howells wrote:
> How about one of two different solutions?
> 
>  (1) Repurpose the function I proposed for generic_file_splice_read() but only
>      for splicing from O_DIRECT files; reading from non-O_DIRECT files would
>      use an ITER_PIPE as upstream.

Given the amounts of problems we had with O_DIRECT vs splice, and the
fact that even doing this is a bit pointless that seems sensible to me.

>      for splicing from O_DIRECT files, as (1), but also replace the splice
>      from a buffered file with something like the patch below.  This uses
>      filemap_get_pages() to do the reading and to get a bunch of folios from
>      the pagecache that we can then splice into the pipe directly.

I defintively like the idea of killing ITER_PIPE.  Isn't the 16
folios in a folio tree often much less than what we could fit into
a single pipe buf?  Unless you have a file system that can use
huge folios for buffered I/O and actually does this might significantly
limit performance.

With that in mind I'll try to find some time to review your actual
patch, but I'm a little busy at the moment.
