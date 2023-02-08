Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C202568F451
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 18:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjBHRWG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 12:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjBHRV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:21:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C442AD3D;
        Wed,  8 Feb 2023 09:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hW5i73pe8pnUfUYDL1bt63KL1qTJ5SbNKkdlGg3uo4g=; b=tSIp+M+Dh97ieUihW36Xe3Tg1N
        czULo45mLjiF0C6oMWsgo7vv2TYg6wM7AtlLz3Y8XwQRHFzA2AIPQXD5NniJDOYcPWmDHyzVxuFQo
        Ux0ioFgtU7MetMymkrkZ7y9pXX3vb2wXN+QZlAcy1a4ybiaOZfQsqSKj5/2K077o/Wx4j8Q06alP2
        UWsNMf6LWKGpw/esuaGwaOx69uVMTn6CNA6WbXTY2wYLw2HjTIpDuoqqr0hBqlwnTmZz266TRcPak
        sEML8oQe5uhLP2bymeBTf776sY4Ev/QyK3Y/r0g4Wt0+ByW1qjuaxYjSQCsoJy6/hNo/sX3RWbzeU
        nm4gXSJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPo8O-001PQr-0w; Wed, 08 Feb 2023 17:21:28 +0000
Date:   Wed, 8 Feb 2023 17:21:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
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
Message-ID: <Y+PaF7q10xSoqynj@casper.infradead.org>
References: <Y+MydH2HZ7ihITli@infradead.org>
 <20230207171305.3716974-1-dhowells@redhat.com>
 <20230207171305.3716974-2-dhowells@redhat.com>
 <176199.1675872591@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176199.1675872591@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 08, 2023 at 04:09:51PM +0000, David Howells wrote:
> @@ -2688,7 +2689,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>  		if (unlikely(iocb->ki_pos >= i_size_read(inode)))
>  			break;
>  
> -		error = filemap_get_pages(iocb, iter, &fbatch);
> +		error = filemap_get_pages(iocb, iov_iter_count(iter), &fbatch);

What's the point in iov_iter_count() anyway?  It's more characters
than iter->count, so why not use it directly?
