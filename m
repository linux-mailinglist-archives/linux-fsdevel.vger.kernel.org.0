Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6495D70A54A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 06:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjETESF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 00:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjETERz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 00:17:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3681C137;
        Fri, 19 May 2023 21:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dsyjoGECg28DSVqb1cNtIsHN/IJsbEQcxsUvVj7A8EI=; b=sTcrSxZYlWK3Y/NgXpynqtVLXh
        to0rnGVN3Ln9J04YoqNw98DR3Tn94U/XUFBGGljJJWBjZa7LH01Od/86j9HV1/invC+x8vDdBfFFA
        YK5J7T1yqfrNknelINVye+ufub827/voITPOwyWzW/TBWVvd07oAOGDAF/lN/HsDtXLG7X+IrLl5F
        wlSFXNRgGK+J/QqmJrneHhpTNcjpYwu10v8FcpSCpXsNJWBsmMvTY8uSruqCOmWvBvdw+ErOE49EE
        YGgjAvPwkmFY47vKY1fJXW59JBCso09XnoXAywA6A6WHwU/gunckEHFpFAG4uxa//Ao0KChJiRRK0
        XdGrXhyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q0E2K-000eBj-04;
        Sat, 20 May 2023 04:17:44 +0000
Date:   Fri, 19 May 2023 21:17:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v20 29/32] block: Replace BIO_NO_PAGE_REF with
 BIO_PAGE_REFFED with inverted logic
Message-ID: <ZGhJ526fahFHi4WA@infradead.org>
References: <20230519074047.1739879-1-dhowells@redhat.com>
 <20230519074047.1739879-30-dhowells@redhat.com>
 <ZGghr0/lFRKmaoAX@moria.home.lan>
 <ZGhFCCBdlSWWcG1G@infradead.org>
 <ZGhI/V573cMDhII5@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGhI/V573cMDhII5@moria.home.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 20, 2023 at 12:13:49AM -0400, Kent Overstreet wrote:
> I suppose this way setting it can be done in bio_iov_iter_get_pages() -
> ok yeah, that makes sense.
> 
> But it seems like it should be set in bio_iov_iter_get_pages() though,
> and I'm not seeing that?

It is set in bio_iov_iter_get_pages in this patch.  The later gets
replaced with the pinned flag when we bio_iov_iter_get_pages is
changed to pin pages instead.
