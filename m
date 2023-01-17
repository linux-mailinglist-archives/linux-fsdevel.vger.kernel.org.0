Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E43A66D750
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 08:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbjAQHzQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 02:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjAQHzP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:55:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE9F12F10;
        Mon, 16 Jan 2023 23:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tgCjPXZFRRY4U5M39+VA82RbzFcfXvKIe9LgETkZp/M=; b=daFNcSbOIYK0jdtwJF4dvqi+Cz
        sq9lGDnRVCMCvOT3snc5ultyZrXmRkgdSjpdIj0V+kMSUYaWkrYS3cb9cnAbi9sYygG9tBS2Hqeoc
        PWDEvYLF0sFdxN+9hB0Ujnk4jrZOYPA2V5QhZSg8D00FOiDlKdqr5lXo75Qs4m7hW1Gh1Eeku44KZ
        zsB0RQ3ahRJq7JAEIeMb06dppOTAziVrldpKAALG8/7R+0z4anqO1z/0jlU7PFIpqiIbDRY5yjxY7
        doEQeKgw/QMF8lU8yHyEEWiXzVHYKcbAgKIjbY9GxorO8Qg6VNwZotrPgkzIEkARRB50nzhDS8Z3M
        Qca2vnYg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHgoG-00DFpG-R7; Tue, 17 Jan 2023 07:55:08 +0000
Date:   Mon, 16 Jan 2023 23:55:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/34] iov_iter: Use IOCB/IOMAP_WRITE/op_is_write
 rather than iterator direction
Message-ID: <Y8ZUXEB/W+K0Jt6k@infradead.org>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391049698.2311931.13641162904441620555.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167391049698.2311931.13641162904441620555.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:08:17PM +0000, David Howells wrote:
> Use information other than the iterator direction to determine the
> direction of the I/O:
> 
>  (*) If a kiocb is available, use the IOCB_WRITE flag.
> 
>  (*) If an iomap_iter is available, use the IOMAP_WRITE flag.
> 
>  (*) If a request is available, use op_is_write().

The really should be three independent patches.  Plus another one
to drop the debug checks in cifs.

The changes themselves look good to me.

>  
> +static unsigned char iov_iter_rw(const struct iov_iter *i)
> +{
> +	return i->data_source ? WRITE : READ;
> +}

It might as well make sense to just open code this in the only
caller as well (yet another patch).
