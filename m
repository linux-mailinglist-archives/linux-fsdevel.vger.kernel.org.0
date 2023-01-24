Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75D3679C9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbjAXOyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbjAXOyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:54:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DD845F75;
        Tue, 24 Jan 2023 06:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GHCwlLF7wa3yuDKNbyAKB1+xPsU+XQeBpEiRl/4dAmg=; b=thE9gt5GWJRi8DSGQFxSuVj2XN
        wQ9x+oLubqqxo/bSLujOGaKIpLqmokTx8uhCTlBg5VLn+3zDVhw4QHINCvUmwNaKznolkrU+UeiJ5
        hHv/h9KzIGll9nN2GB4YfqzgZKt8kCmG+t1M52MpIyNqVHHN1Pw2krrPFqFS3EOTTLPOfOTxJxO7+
        UHZPBAxnV1s4CiLP6C9HLlorUFSgHqSelmYI5amb1J4BcnIj5M3nbQQXUQxPFq8cMft0HPtQAWb5b
        WmNu1LS432m7zgldrqwXmGhePg/uKXH5HCusSJ5pmjvwRgjVfKsNevkXy6f3dNw+SDjz07dL7hb/7
        oRaB866g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKKgM-004QVO-CE; Tue, 24 Jan 2023 14:53:54 +0000
Date:   Tue, 24 Jan 2023 06:53:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 07/10] block: Switch to pinning pages.
Message-ID: <Y8/xApRVtqK7IlYT@infradead.org>
References: <2431ffa0-4a37-56a2-17fa-74a5f681bcb8@redhat.com>
 <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-8-dhowells@redhat.com>
 <874829.1674571671@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874829.1674571671@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:47:51PM +0000, David Howells wrote:
> > > +static inline void bio_set_cleanup_mode(struct bio *bio, struct iov_iter *iter)
> > > +{
> > > +	unsigned int cleanup_mode = iov_iter_extract_mode(iter);
> > > +
> > > +	if (cleanup_mode & FOLL_GET)
> > > +		bio_set_flag(bio, BIO_PAGE_REFFED);
> > > +	if (cleanup_mode & FOLL_PIN)
> > > +		bio_set_flag(bio, BIO_PAGE_PINNED);
> > 
> > Can FOLL_GET ever happen?
> 
> Yes - unless patches 8 and 9 are merged.  I had them as one, but Christoph
> split them up.

It can't.  Per your latest branch:

#define iov_iter_extract_mode(iter) (user_backed_iter(iter) ? FOLL_PIN : 0)
