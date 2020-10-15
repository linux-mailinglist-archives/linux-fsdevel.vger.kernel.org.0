Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E785428F800
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 19:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732170AbgJOR6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 13:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732156AbgJOR6u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:58:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A34C061755;
        Thu, 15 Oct 2020 10:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x+XQ7VEyYNfvRvizRGPoAdTEAMGVk8qPQWatjzYSgQw=; b=m21slifxK1bGUo9NkuLnasLmGW
        W7j1mSzLsl8lqkNcmNBEmyamMl2n/iSza8Fv9vJdGtVQIw2/kDlRcMmM4PWbe5eP6FTvI4xm0WOWP
        4Adx+LchNEcYX2u8R/hnI8+L4xfRz5R7/ZW9gYaZ59Wva288nDtTL0QGvEDQcyQNBdTqXo87Bl3HW
        E62GWuauRw2KoIGK3HW5V9LXG8lMy3MQUVaq3gY0yr4/hMeSjIpZfqFbIV5olX2c1do/vAiTNpYlO
        890vukb4WHYvxnqK7wVoxPPIDsWceSIRHULvymZsZRjmZLVpToKJoS//KCJAy1r/TgDXANhlomCkj
        PpgfwI1A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kT7Wa-00018B-31; Thu, 15 Oct 2020 17:58:48 +0000
Date:   Thu, 15 Oct 2020 18:58:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
        Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 16/16] iomap: Make readpage synchronous
Message-ID: <20201015175848.GA4145@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201009143104.22673-17-willy@infradead.org>
 <20201015094203.GA21420@infradead.org>
 <20201015164333.GA20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015164333.GA20115@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 15, 2020 at 05:43:33PM +0100, Matthew Wilcox wrote:
> On Thu, Oct 15, 2020 at 10:42:03AM +0100, Christoph Hellwig wrote:
> > > +static void iomap_read_page_end_io(struct bio_vec *bvec,
> > > +		struct completion *done, bool error)
> > 
> > I really don't like the parameters here.  Part of the problem is
> > that ctx is only assigned to bi_private conditionally, which can
> > easily be fixed.  The other part is the strange bool error when
> > we can just pass on bi_stats.  See the patch at the end of what
> > I'd do intead.
> 
> I prefer assigning ctx conditionally to propagating the knowledge
> that !rac means synchronous.  I've gone with this:

And I really hate these kinds of conditional assignments.  If the
->rac check is too raw please just add an explicit

	bool synchronous : 1;

flag.

> @@ -340,16 +335,12 @@ iomap_readpage(struct page *page, const struct iomap_ops *
> ops)
>  
>         if (ctx.bio) {
>                 submit_bio(ctx.bio);
> +               if (ret > 0)
> +                       ret = blk_status_to_errno(ctx.status);
>         }
>  
> -       wait_for_completion(&ctx.done);
>         if (ret >= 0)
> -               ret = blk_status_to_errno(ctx.status);
> -       if (ret == 0)
>                 return AOP_UPDATED_PAGE;
>         unlock_page(page);
>         return ret;
> 
> 
> ... there's no need to call blk_status_to_errno if we never submitted a bio.

True.  I'd still prefer the AOP_UPDATED_PAGE as the fallthrough case
and an explicit goto out_unlock, though.
