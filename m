Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314C966D87A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 09:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbjAQIpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 03:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbjAQIov (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:44:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63312CFD0;
        Tue, 17 Jan 2023 00:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B78y0VpcNvaNsUxIiihgFPrvqCbss5Z11dzMWjX4LvA=; b=rfYsJlEozbyBZuSblQN507XRqm
        DRWDdxv5x1kqdV9WC8xnqWa2pPT/7YeYN8mVG36tuua/QNFFtl9BpY4DjQP7D+nwWrEslHS7ETTO9
        Gr59jLK5bp6lLBdHPQozGA62c/yyLthADMEA4ep9cbFmWL29oBouWOUAk2oCJb2VmLTNj1ZmMkJel
        OSlCSnLfEiD2NxmvVhhyoFzk2INF1yZmg14JZFxRQl0pz3iXLffiI06e49ekYEBvvyJof2kcZtRB1
        mlY8Jn5kHSRovvNc7qrkhZUU30SSeVoVOyrU3GjFhMYtu5t3ybcenG6rimkGDNkeyWeWEVFAkOxdU
        ICLfiW9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHhaE-00DMe7-M0; Tue, 17 Jan 2023 08:44:42 +0000
Date:   Tue, 17 Jan 2023 00:44:42 -0800
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
Subject: Re: [PATCH v6 11/34] iov_iter, block: Make bio structs pin pages
 rather than ref'ing if appropriate
Message-ID: <Y8Zf+gooUKwAZC7J@infradead.org>
References: <Y8ZXQArEsIRNO9k/@infradead.org>
 <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391056047.2311931.6772604381276147664.stgit@warthog.procyon.org.uk>
 <2330754.1673943968@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2330754.1673943968@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 17, 2023 at 08:26:08AM +0000, David Howells wrote:
> Um... With these patches, BIO_PAGE_REFFED is set by default when the bio is
> initialised otherwise every user of struct bio that currently adds pages
> directly (assuming there are any) rather than going through
> bio_iov_iter_get_pages() will have to set the flag, hence the need to clear
> it.

I think we need to fix that (in the patch inverting the polarity) and
only set the flag where it is needed.

All eventually calls come from the direct I/O code in the block layer,
iomap, legacy generic and zonefs, and they release pages that came
from some form of hup.  So we can just set BIO_PAGE_REFFED in
bio_iov_iter_get_pages and dio_refill_pages.
