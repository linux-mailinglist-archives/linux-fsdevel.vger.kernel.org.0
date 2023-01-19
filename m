Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB44C673153
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 06:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjASFpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 00:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjASFpY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:45:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3965326B1;
        Wed, 18 Jan 2023 21:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QITZ88AgXcdCKct06AIDiTL/k+DvSMv66J7JO9ddocs=; b=lUhKPsLfI6IKmrYDGvWsHItWHq
        dnR0Pbz06nIyE2nMTRDnmJD1MYmJAwaNQL7vQaRkHGsJ9hOYsfV76Mw5uI1I+/u1UsuxJWVhPCHhC
        tG1wxmUYWGtRqPqDBf7p9prNoFPpJ4y6KYQkIp7HiQV1xzeDiZS1BF+nah/5TMX2xbb5ZjKMJH9TL
        EU14jkdRB0I1WW6KviaRSHiix5ImvjejaBuT7CATpEKiglig4i8G9Zx1eBN8mQbCmi0Rq1oCkiq/8
        DPATqLdffwo19V8eSTvOn/CQtgVhZ8idIuuFdCJKuUDZpyawQBk72gZ4Clrxd/ddVluy9BdlhDHAv
        neG04+QA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pINje-003h6t-6m; Thu, 19 Jan 2023 05:45:14 +0000
Date:   Wed, 18 Jan 2023 21:45:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/34] iov_iter: Use the direction in the iterator
 functions
Message-ID: <Y8jY6pCN73rwfcXq@infradead.org>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391052497.2311931.9463379582932734164.stgit@warthog.procyon.org.uk>
 <Y8ZVGEvbVsf4eDNU@infradead.org>
 <Y8hyjEw94LIZ84xo@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8hyjEw94LIZ84xo@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_ABUSE_SURBL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:28:28PM +0000, Al Viro wrote:
> On Mon, Jan 16, 2023 at 11:58:16PM -0800, Christoph Hellwig wrote:
> > On Mon, Jan 16, 2023 at 11:08:44PM +0000, David Howells wrote:
> > > Use the direction in the iterator functions rather than READ/WRITE.
> > 
> > I don't think we need the direction at all as nothing uses it any more.
> 
> ... except for checks in copy_from_iter() et.al.

Debug checks, yes.
