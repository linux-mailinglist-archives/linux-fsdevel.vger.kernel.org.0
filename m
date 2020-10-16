Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFBC28FE62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 08:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394268AbgJPGfu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 02:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394251AbgJPGft (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 02:35:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642FAC061755;
        Thu, 15 Oct 2020 23:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eAA1eJndUJazjd9wD1gXENLx75tdwnXKcLKd7pL1gTU=; b=SBWbXHnwsC7WyfY9k/gweEYk5A
        p+2fGdIWIVbT7n9C1xTGSaGtmyZHzjIApovUpFs3FufX4XdbGFnHU75YYi+FL0hcvw3i3u16C115J
        vBIBNtCO07eyGfiLvCyk/WBfHjfSjVgCLpEOQ7wnWZ8GEoyBAj9psYz6+FTNojyIXPKbj6fBUPuk0
        zVWH6r2qB41hpph2TFteLdPL3avD3zzvX1Xi6yRJXcEccBlOV0jh+OOtS58d2jEesSCt4agpAfL7C
        KsoAEaxAJk/5vbf1akWUscAxYxQjQY3spErwPnoC4n1qtlyzfcn0RaaErSNQgIVsGk30H4ziVJgZ0
        Cv2kunvQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTJL8-0001O0-W2; Fri, 16 Oct 2020 06:35:47 +0000
Date:   Fri, 16 Oct 2020 07:35:46 +0100
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
Message-ID: <20201016063546.GA4808@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201009143104.22673-17-willy@infradead.org>
 <20201015094203.GA21420@infradead.org>
 <20201015164333.GA20115@casper.infradead.org>
 <20201015175848.GA4145@infradead.org>
 <20201015190312.GB20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015190312.GB20115@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 15, 2020 at 08:03:12PM +0100, Matthew Wilcox wrote:
> I honestly don't see the problem.  We have to assign the status
> conditionally anyway so we don't overwrite an error with a subsequent
> success.

Yes, but having a potential NULL pointer to a common structure is just
waiting for trouble.

> 
> > True.  I'd still prefer the AOP_UPDATED_PAGE as the fallthrough case
> > and an explicit goto out_unlock, though.
> 
> So this?
> 
>         if (ctx.bio) {
>                 submit_bio(ctx.bio);
>                 wait_for_completion(&ctx.done);
>                 if (ret < 0)
>                         goto err;
>                 ret = blk_status_to_errno(ctx.status);
>         }
> 
>         if (ret < 0)
>                 goto err;
>         return AOP_UPDATED_PAGE;
> err:
>         unlock_page(page);
>         return ret;
> 

Looks good.
