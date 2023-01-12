Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264EE667508
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 15:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbjALORP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 09:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbjALOQN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:16:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9757455878;
        Thu, 12 Jan 2023 06:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FkB/gFOcG5Pqv2OovO6QG5NeQJyO7VnpkEiyzK71KNM=; b=iqxJLhoRUS9SDfYu7zkgVeqiF1
        hSsTY22/joMJuqE0JVxXU5Hq0Eeuv44KqhPBfr899GUMd3IwzWAWer4d+SOYOBtwH1vCLINFXEEh2
        EpVw+CeUuM2sEjDTu103Vj2yvnPMR7kwMx/sVkGpltaK1c6YC4yM10t5ALcQSpPNcq0bs+8ye8z8+
        637afNlqlviQdCDNTkSpP1BavBor520z0W6Ke27MWKFowgMECSK+dRstSqLunliazRUGeDbBU7kTV
        JP0XJSmwxNcb30J1+pRH+eZkTq9+SH8TN2IqjWvEG/7F1sEL2oKsNxY14hhTc4rRm+0BiUVqsJd+e
        ONrDHtCQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFyFa-00FJWp-6u; Thu, 12 Jan 2023 14:08:14 +0000
Date:   Thu, 12 Jan 2023 06:08:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/9] iov_iter: Use IOCB/IOMAP_WRITE if available
 rather than iterator direction
Message-ID: <Y8AUTlRibL+pGDJN@infradead.org>
References: <Y7+8r1IYQS3sbbVz@infradead.org>
 <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
 <167344727810.2425628.4715663653893036683.stgit@warthog.procyon.org.uk>
 <15330.1673519461@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15330.1673519461@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:31:01AM +0000, David Howells wrote:
> > And use the information in the request for this one (see patch below),
> > and then move this patch first in the series, add an explicit direction
> > parameter in the gup_flags to the get/pin helper and drop iov_iter_rw
> > and the whole confusing source/dest information in the iov_iter entirely,
> > which is a really nice big tree wide cleanup that remove redundant
> > information.
> 
> Fine by me, but Al might object as I think he wanted the internal checks.  Al?

I'm happy to have another discussion, but the fact the information in
the iov_iter is 98% redundant and various callers got it wrong and
away is a pretty good sign that we should drop this information.  It
also nicely simplified the API.
