Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D075867314C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 06:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjASFlv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 00:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjASFlu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:41:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB55C2;
        Wed, 18 Jan 2023 21:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y5Xh8bYwZMY5HwN/M4TXkwN4g2K6OlG75bQso9HEXNw=; b=o30pbyX48tfAIROLtLS+b0a6i2
        KjJXgkQq9natV56aPqro1wnQIz/NgCFWgh94PHYTPZrqLH9KrBNKj9mWGcv8/77Tsvqd+V2kBLD/1
        OpA1EJEoKFjLG4y4++CHxasA7BEcohxGyqNnJngGeXUk1SVXArpf6x5qcNiEHer5UiaQin6t2FlFW
        tJyebRFJm7UjOCebh46G/KWSWocuzJ+Y9WHZy2M9i4WVkKXEz82wBB0+892hdZP4ZteqpjwdF8e36
        4Pb5N4O8rG8CENA3HtLf+/Aq+o5w7guTGiUqCuM6IaFoYEJaiLTZO1gfp9WMGK3i/JnRlGiGNR0DZ
        EvCEF31w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pINg8-003gwp-Bm; Thu, 19 Jan 2023 05:41:36 +0000
Date:   Wed, 18 Jan 2023 21:41:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/34] vfs: Unconditionally set IOCB_WRITE in
 call_write_iter()
Message-ID: <Y8jYEGtp796H1Zro@infradead.org>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391048988.2311931.1567396746365286847.stgit@warthog.procyon.org.uk>
 <Y8htMvG33I73oG9z@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8htMvG33I73oG9z@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:05:38PM +0000, Al Viro wrote:
> __kernel_write_iter() is one such; for less obvious specimen see
> drivers/nvme/target/io-cmd-file.c:nvmet_file_submit_bvec() - there
> we have iocb coming from the caller and *not* fed to init_sync_kiocb(),
> so Christoph's suggestion doesn't work either.  Sure, we could take
> care of that by adding ki_flags |= IOCB_WRITE in there, but...

None of the asyc users of iocbs currently uses init_sync_kiocb.  My
suggestion is to use it everywhere - we have less than a dozen of
these that I all listed.
