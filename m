Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0D6677E5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 15:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjAWOte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 09:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjAWOtc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:49:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B44CDD0;
        Mon, 23 Jan 2023 06:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z11i+llmbjgD7cbFbLlQsJ9ixdAy5+4hRBMo2u2DGEw=; b=qlzRk3JIzqNYzOMGddXhs7a7Bc
        wecSP3xqjry+0odJFYKHt81zx29My16+nwZ9uPdz+oxpAU+dFHD7hhSDu7KVTpjpqXH87PsP4Rb3p
        bVXVmREdHoNfhebejQH03Zie4QFQPWqx56Iiq4+Ig3MdqlRszGXEk2tPZzcHA3ijuroPt0ipVPkmg
        RLWygV4sf1+RRR5RGrwocSn2NS66qsmSxjs49r+KrRzS91hecRgWeLROStWXk3NX7Wj6YTJ2hoTY7
        MAD6D29oXBP5fICUHUEjAFdS/93kQhLKVeAhlGIMjtsel83o74xn4stIl/8CSUgKeTwWM9K0BPI+M
        MPS9jiHg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJy8P-0001xS-6J; Mon, 23 Jan 2023 14:49:21 +0000
Date:   Mon, 23 Jan 2023 06:49:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 6/8] block: Make bio structs pin pages rather than
 ref'ing if appropriate
Message-ID: <Y86ecQ6EAr5BDvw+@infradead.org>
References: <Y8vjlH+w1sNBPJjU@infradead.org>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-7-dhowells@redhat.com>
 <3813654.1674473320@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3813654.1674473320@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 11:28:40AM +0000, David Howells wrote:
> 	void __bio_release_pages(struct bio *bio, bool mark_dirty)
> 	{
> 		unsigned int gup_flags = bio_to_gup_flags(bio);
> 		struct bvec_iter_all iter_all;
> 		struct bio_vec *bvec;
> 
> 		bio_for_each_segment_all(bvec, bio, iter_all) {
> 			if (mark_dirty && !PageCompound(bvec->bv_page))
> 				set_page_dirty_lock(bvec->bv_page);
> 	>>>>		page_put_unpin(bvec->bv_page, gup_flags);
> 		}
> 	}
> 
> that ought to be a call to bio_release_page(), but the optimiser doesn't want
> to inline it:-/

Why?  __bio_release_pages is the fast path, no need to force using
bio_relese_page which is otherwise only used for error cleanup.
