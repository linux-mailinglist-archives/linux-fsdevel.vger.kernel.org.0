Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38517671F82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 15:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjAROZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 09:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjAROZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:25:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E923D8B303;
        Wed, 18 Jan 2023 06:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MFcR0OGBOZF6nFAA9jXYIyh+Hu0YfDAUMAAwjfRCkqc=; b=3SD7Vdt5AdW0YvzZzC12FMR9aL
        W9WO1g7u7H/F/QxKA94pPX4KgPaws20mnQRb9EWhS61g3sN+SkwoJNIApn55lUy+3+rwB1CfjS10z
        rUdZ4zwzUYCfdxtc36QlvXCRBE5ze8P3CniwiDeoU5yAFhtanBI30KfBwMSN1YGPtqlUAmO416saT
        tctAs+YVGlvg9RsOb/6dtOVKnuJPD+NXC+2sewv4aTXnZND9MFqgCwy2HHGlE4BNSn5rtJiOFakcJ
        ix7/T8E6dBA/F6hiLhPZcDu701pHd2DriNYKHCiWtW35N+VL5Jdwz1quemNt9yDeCbx6mzsc2PpBj
        DlBYgbjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pI985-001HFU-3c; Wed, 18 Jan 2023 14:09:29 +0000
Date:   Wed, 18 Jan 2023 06:09:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/34] bio: Rename BIO_NO_PAGE_REF to BIO_PAGE_REFFED
 and invert the meaning
Message-ID: <Y8f9mSt+QuxuHOm9@infradead.org>
References: <167391054631.2311931.7588488803802952158.stgit@warthog.procyon.org.uk>
 <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <2673696.1674050454@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2673696.1674050454@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 02:00:54PM +0000, David Howells wrote:
> Actually, should I make it so that the bottom two bits of bi_flags are a
> four-state variable and make it such that bio_release_page() gives a warning
> if the state is 0 - ie. unset?
> 
> The states would then be, say:
> 
> 	0	WARN(), do no cleanup
> 	1	FOLL_GET
> 	2	FOLL_PUT
> 	3	do no cleanup
> 
> This should help debug any places, such as iomap_dio_zero() that I just found,
> that add pages with refs without calling iov_iter_extract_pages().

I don't really see a point.  The fundamental use case of the bio itself
isn't really to this at all.  So we're stealing one, or in the future
two bits mostly to optimize some direct I/O use cases.  In fact I
wonder if instead we should just drop this micro-optimization entirely
an just add a member for the foll flags to the direct I/O container
structures (struct blkdev_dio, strut iomap_dio, struct dio, or just on
stack for __blkdev_direct_IO_simple and zonefs_file_dio_append) and
pass that to bio_release_pages.
