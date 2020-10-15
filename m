Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE55628F18E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 13:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgJOLyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 07:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgJOLtx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:49:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703C7C061755;
        Thu, 15 Oct 2020 04:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XLRuihqm3fAlHyAROY0lvBAgKqxOu9ggAgyL2LNoHgw=; b=VixR6nbubUCnsr4ZO2wy9wuxCn
        lduZ4bu+AY2nVEOKTBe3JvtWf0PlYzWVbpiellQE6WWeKJ46G0qRMjoBJK9Zqxld+20RhqXCyTXW8
        iIJ7jl6BzmDlIQEHhkYHBhTOphSFccJhtJ7PpwARQc60tLRYyOXI9J4I06bLQgXnncAM+vpCMN1TW
        moWLhI0VJd33AOfpSmp24xN24NWqTOcT4f7uyXVJtcRgmtAdi8WW/5Tj8q5TbdPOmTEfJAcHjHHpN
        vx2Me/S+s+qLI0dsDRm2ZiSRjkSNyE2miUVgJCU5cSIyqF0lNfp5SeuzMdGwwLIvbsLqhY94JNLFJ
        JtXRqa5w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kT1lV-0004fH-KR; Thu, 15 Oct 2020 11:49:49 +0000
Date:   Thu, 15 Oct 2020 12:49:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
        Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 00/16] Allow readpage to return a locked page
Message-ID: <20201015114949.GY20115@casper.infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201015090242.GA12879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015090242.GA12879@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 15, 2020 at 10:02:42AM +0100, Christoph Hellwig wrote:
> On Fri, Oct 09, 2020 at 03:30:48PM +0100, Matthew Wilcox (Oracle) wrote:
> > Ideally all filesystems would return from ->readpage with the page
> > Uptodate and Locked, but it's a bit painful to convert all the
> > asynchronous readpage implementations to synchronous.  The first 14
> > filesystems converted are already synchronous.  The last two patches
> > convert iomap to synchronous readpage.
> 
> Is it really that bad?  It seems like a lot of the remainig file systems
> use the generic mpage/buffer/nobh helpers.
> 
> But I guess this series is a good first step.

I'm just testing a patch to mpage_readpage():

+++ b/fs/mpage.c
@@ -406,11 +406,17 @@ int mpage_readpage(struct page *page, get_block_t get_block)
                .nr_pages = 1,
                .get_block = get_block,
        };
+       int err;
 
        args.bio = do_mpage_readpage(&args);
-       if (args.bio)
-               mpage_bio_submit(REQ_OP_READ, 0, args.bio);
-       return 0;
+       if (!args.bio)
+               return 0;
+       bio_set_op_attrs(args.bio, REQ_OP_READ, 0);
+       guard_bio_eod(args.bio);
+       err = submit_bio_wait(args.bio);
+       if (!err)
+               err = AOP_UPDATED_PAGE;
+       return err;
 }
 EXPORT_SYMBOL(mpage_readpage);
 

but I'm not looking forward to block_read_full_page().
