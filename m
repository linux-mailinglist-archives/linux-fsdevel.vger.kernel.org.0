Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2156679090
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 06:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjAXF7t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 00:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjAXF7s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 00:59:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6264C114;
        Mon, 23 Jan 2023 21:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EH0gbMQQbpYhXsQxva6uNWXuCWtzbNxtrfyoO5FErmE=; b=bpg5Z6Trw7FvNm8T1j3M2+cDUr
        QWSfKBzVTsso6OP+/YqBbI8sL+swEkdU1JlJDhybXenBheYR+NCAm2hmP8uOfemeSJarqbzYkmZQr
        B/XMuTQETB1D3W6OFsffYqDId5/c92WwAI8cYNqUhCzJ8jcJ1b1APPaRorSFe6k67lAWT+nDH64K+
        /vpadADQfhDBgAX5xRdtWAuEIg34RHVk7kjPWZjYSh2Q50PnmS8n2su8AqUvKK4s+WWOaQ53lkBSM
        LFW8Dh+urmyXhdUBCkYtBBvn0IcyYEHFdcQVw+kPPnM9lG251TmasPH4c3jQ0S+VsAJ2eBkNA67k5
        VXAXXtpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKCLK-002TJR-En; Tue, 24 Jan 2023 05:59:38 +0000
Date:   Mon, 23 Jan 2023 21:59:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 04/10] iomap: don't get an reference on ZERO_PAGE for
 direct I/O block zeroing
Message-ID: <Y89zypNE5z7rgdtX@infradead.org>
References: <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-5-dhowells@redhat.com>
 <eb1f8849-f0d8-9d3d-d80d-7fe8487a15f4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb1f8849-f0d8-9d3d-d80d-7fe8487a15f4@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 06:42:28PM -0800, John Hubbard wrote:
> > @@ -202,7 +202,7 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
> >   	bio->bi_private = dio;
> >   	bio->bi_end_io = iomap_dio_bio_end_io;
> > -	get_page(page);
> > +	bio_set_flag(bio, BIO_NO_PAGE_REF);
> 
> ...is it accurate to assume that the entire bio is pointing to the zero
> page? I recall working through this area earlier last year, and ended up
> just letting the zero page get pinned, and then unpinning upon release,
> which is harmless.

Yes, the bio is built 4 lines above what is quoted here, and submitted
right after it.  It only contains the ZERO_PAGE.
