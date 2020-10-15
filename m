Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BEB28F917
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 21:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391400AbgJOTDQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 15:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbgJOTDP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 15:03:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F31BC061755;
        Thu, 15 Oct 2020 12:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oNJXIe6ApwnR4LV/FIl4/BNaWNi8NSTj4mgOrmFnzuk=; b=NX+4sGxWbcObdfGwkGyOjAO42I
        RwmquKATXBHbPE8QSMBRvqg3SOeDdcTChlMCCwoXnLis0DLRnkhZ9SBCeMdxlmrOEU5T31XnSKdna
        8BJnB9a8evpDeuTlBno2NyNtBFQ3rhK5+DQAIo0aSwxVOlbPXbe1xBNJP+/BLP07zrDu8t86RMeAH
        /PjljktE1B37EED9rYHkhPumMrgN299CGCffnkM19ZidMR2ViOe3nCfbLb380F9gIBfoc1CJNWBEM
        pVilSrRr9k6B9lRS2zCnqwquGo2pBX6mLt0eMBFVmNSqr+ihKMHE6zdFkrlbS40ju3J1wa+nt0m9O
        xHvnTZKg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kT8Wu-00055X-Dw; Thu, 15 Oct 2020 19:03:12 +0000
Date:   Thu, 15 Oct 2020 20:03:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
        Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 16/16] iomap: Make readpage synchronous
Message-ID: <20201015190312.GB20115@casper.infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201009143104.22673-17-willy@infradead.org>
 <20201015094203.GA21420@infradead.org>
 <20201015164333.GA20115@casper.infradead.org>
 <20201015175848.GA4145@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015175848.GA4145@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 15, 2020 at 06:58:48PM +0100, Christoph Hellwig wrote:
> On Thu, Oct 15, 2020 at 05:43:33PM +0100, Matthew Wilcox wrote:
> > I prefer assigning ctx conditionally to propagating the knowledge
> > that !rac means synchronous.  I've gone with this:
> 
> And I really hate these kinds of conditional assignments.  If the
> ->rac check is too raw please just add an explicit
> 
> 	bool synchronous : 1;
> 
> flag.

I honestly don't see the problem.  We have to assign the status
conditionally anyway so we don't overwrite an error with a subsequent
success.

> True.  I'd still prefer the AOP_UPDATED_PAGE as the fallthrough case
> and an explicit goto out_unlock, though.

So this?

        if (ctx.bio) {
                submit_bio(ctx.bio);
                wait_for_completion(&ctx.done);
                if (ret < 0)
                        goto err;
                ret = blk_status_to_errno(ctx.status);
        }

        if (ret < 0)
                goto err;
        return AOP_UPDATED_PAGE;
err:
        unlock_page(page);
        return ret;

