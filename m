Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67842676670
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 14:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjAUNK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 08:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjAUNKZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 08:10:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9CC469F;
        Sat, 21 Jan 2023 05:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CQ0i0Hj7VlUtQ3sjNUJquE59U2rg0tg3CNt0ZjaPcD4=; b=P0JjBL0iZFTpwc0lBr7jn3wb3+
        5lh/0DnDG1ZKQ1DsosYVnoOpeU4PMfmTtof4vkRWUNuwWa5ifL1glK5L8aQ1sIn0T5pwEdx9UzBtG
        ErR8OAso3Kw/8/IXPAASlhwl/CqSmupX0cM2zoe2apGQmlGZeUKr70/qLLLeQFCa1vb38+A1fqkWO
        1wJA3/cxglSExyRNAVf7+CKW+oeFDqb0C3UV2BJ6kMOyjnNOOvNmFpqsOOuBsUskWP7anZLVSlCG/
        oPjd2aGkuk1rRvQsgMja+hIn00fDLM6+quLVxzhZNQwBSP1S8hNo+TFXhJvQ3AwmUKYYpMGiHWmdz
        XLzsIjwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJDdS-00Dt8I-ED; Sat, 21 Jan 2023 13:10:18 +0000
Date:   Sat, 21 Jan 2023 05:10:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Message-ID: <Y8vkOk68ZFWPr9vq@infradead.org>
References: <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-3-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120175556.3556978-3-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 05:55:50PM +0000, David Howells wrote:
>  (3) Any other sort of iterator.
> 
>      No refs or pins are obtained on the page, the assumption is made that
>      the caller will manage page retention.  ITER_ALLOW_P2PDMA is not
>      permitted.

The ITER_ALLOW_P2PDMA check here is fundamentally wrong and will
break things like io_uring to fixed buffers on NVMe.  ITER_ALLOW_P2PDMA
should strictly increase the group of acceptable iters, it does must
not restrict anything.
