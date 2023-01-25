Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002CF67AA51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 07:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjAYGaT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 01:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjAYGaS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 01:30:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BB32FCEF;
        Tue, 24 Jan 2023 22:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1mLNmezIgSTpYg5+zojMIZAmFtYPS82rFw2cxZKdKLg=; b=S2jOPmP5zmWE26Hv43S8OlSgUc
        EcJc//M02IXqz5WNTml1JCcdZHtX9L8f3xv/NVyStFmkMKS04rrVXEZgtWbvEXE7X4r8EpdODMXa8
        m+efRkX/miTMf7BJcvJEGc6EjuDuw9vz9jdSYCMTJdgbBaFc8cDoKQjhBje2EBYCUhR1SzLtTaaON
        uO+C6U/GqPAmboBOLZe3iNeIemXy5QUWPwW6VsRZ0szTpzw+80HpfTINEfKWxpfBEVYrm3U8TFnLR
        WgusGjSGd+m4dDSIokx0JxIv65aJq9kiM9JFvskV4x6a7a9tM9W5vxVidZi86ButZZ2Hw9D40oG9z
        nvBeg3sg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKZIP-0067rs-3U; Wed, 25 Jan 2023 06:30:09 +0000
Date:   Tue, 24 Jan 2023 22:30:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v9 5/8] block: Replace BIO_NO_PAGE_REF with
 BIO_PAGE_REFFED with inverted logic
Message-ID: <Y9DMcThwiDnbVpQe@infradead.org>
References: <b7833fd7-eb7d-2365-083d-5a01b9fee464@nvidia.com>
 <20230124170108.1070389-1-dhowells@redhat.com>
 <20230124170108.1070389-6-dhowells@redhat.com>
 <1353771.1674595077@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1353771.1674595077@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 09:17:57PM +0000, David Howells wrote:
> John Hubbard <jhubbard@nvidia.com> wrote:
> 
> > > +	/* for now require references for all pages */
> > 
> > Maybe just delete this comment?
> 
> Christoph added that.  Presumably because this really should move to pinning
> or be replaced with iomap, but it's not straightforward either way.  Christoph?

Mostly because it adds the flag when allocating the bio, and not where
doing the gup.  If John thinks it adds more confusion than it helps, we
can drop the comment.

That being said you had a conversion in an earlier version of the
series, and once the current batch of patches is in we should
resurrected it ASAP as that will allow us to kill BIO_FLAG_REFFED.


