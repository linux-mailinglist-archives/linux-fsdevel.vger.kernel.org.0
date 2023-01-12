Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E555667520
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 15:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbjALOS0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 09:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjALORn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:17:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0D45D6AB;
        Thu, 12 Jan 2023 06:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bKGMxni74NIQWcLxdMx7LjTU35Ny9uTXPPIcgMMePS4=; b=tVSRG1l26gYhR1GaVDkeu4d3DZ
        IFVRzb+wRm6elL3g7lXRzNKgG7scS+gQPbNhtgi26D0uDT0q9KEsrFAB8oip16RZvDXvArB5ESmPv
        tr6g28Iq44Pi0BWL98vV55ZguG8eO8YtyS9zhuNixIeVoyBAkbB35FRA9D2Vom40g3XVcH7rQO7hy
        5xYCaOTIuK/ZZ20i9hcawiubCay1F+uvWFpnk9McmaYG93EVeuS7cGDf7cIdM+wBncMp2aDPouYlL
        Ag63jXIUMllnb3BNdfJgnCx3QJbyVV04Jtz6o0ZfZzJ2WiRWSZvOvyoJ5gncx7DK5BKWP/v9W4Jmx
        mC+hOq+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFyGa-00FJmh-9C; Thu, 12 Jan 2023 14:09:16 +0000
Date:   Thu, 12 Jan 2023 06:09:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 8/9] iov_iter, block: Make bio structs pin pages
 rather than ref'ing if appropriate
Message-ID: <Y8AUjB5hxkwxhnGK@infradead.org>
References: <Y7+6YVkhZsvdW+Hr@infradead.org>
 <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
 <167344731521.2425628.5403113335062567245.stgit@warthog.procyon.org.uk>
 <15237.1673519321@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15237.1673519321@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:28:41AM +0000, David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > 	if (cleanup_mode & FOLL_GET) {
> > 		WARN_ON_ONCE(bio_test_flag(bio, BIO_PAGE_PINNED));
> > 		bio_set_flag(bio, BIO_PAGE_REFFED);
> > 	}
> > 	if (cleanup_mode & FOLL_PIN) {
> > 		WARN_ON_ONCE(bio_test_flag(bio, BIO_PAGE_REFFED));
> > 		bio_set_flag(bio, BIO_PAGE_PINNED);
> > 	}
> 
> That won't necessarily work as you might get back cleanup_mode == 0, in which
> case both flags are cleared - and neither warning will trip on the next
> addition.

Well, it will work for the intended use case even with
cleanup_mode == 0, we just won't get the debug check.  Or am I missing
something fundamental?
