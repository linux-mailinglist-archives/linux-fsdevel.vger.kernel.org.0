Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AB46F7BB5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 05:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjEED7c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 23:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEED7a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 23:59:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DDE1208F;
        Thu,  4 May 2023 20:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pel369hJJIUdEpZU2uAmRJT9uQI7mEATcuj1AkNPhQg=; b=M9kn7OgyMBhzRycQnUQfiJJ+Cs
        q7y3p9qwoVlukkXerCudWnoruWBk/S5p8fU0yQ4MSBHVpDIjfJ3G1TxxrUN49OGrs6UHe3JSufZdq
        HOxvW44NOcM3KqQ6FYtxMChjW6NqWmAEr05N61KuV19h2gkhoXyUcXdLC+OYXFYP5yCGDsM3K4Ee/
        /b3GuKplL6pBER80nqLvt13Ql9pEaDPTkUPtMrtExBxRy0B+jMI4PdZyI5Go5x759fGLVU5fQukDK
        4kgLOb9ENbX0L3tlFy42gMsCS8e513lMC6VvCZUyvIqfnBt93Ocnx9tlXJ4IxgLh/r8GdKiiAJfX5
        mkvZQAog==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pumbK-00BDF3-26; Fri, 05 May 2023 03:59:22 +0000
Date:   Fri, 5 May 2023 04:59:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv4 3/3] iomap: Support subpage size dirty tracking to
 improve write performance
Message-ID: <ZFR/GuVca5nFlLYF@casper.infradead.org>
References: <ZFPJGDqfcUtI4ptO@casper.infradead.org>
 <87zg6j1mpy.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zg6j1mpy.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 08:57:53AM +0530, Ritesh Harjani wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> > "per-filesystem"?  I think you mean "per-block (uptodate|block) state".

(s/|block/|dirty/, sorry)

> > Using "per-block" naming throughout this patchset might help readability.
> > It's currently an awkward mix of "subpage", "sub-page" and "sub-folio".
> and subfolio to add.
> 
> Yes, I agree it got all mixed up in the comments.
> Let me stick to sub-folio (which was what we were using earlier [1])

I think per-block is better?  sub-folio might be at almost any
granularity, but per-block is specific.

> >> +static void iomap_iop_set_range(struct folio *folio, struct iomap_page *iop,
> >> +		size_t off, size_t len, enum iop_state state)
> >
> > I can't believe this is what Dave wanted you to do.  iomap_iop_set_range()
> > should be the low-level helper called by iop_set_range_uptodate() and
> > iop_set_range_dirty(), not the other way around.
> 
> Ok, I see the confusion, I think if we make
> iomap_iop_set_range() to iomap_set_range(), then that should be good.
> Then it becomes iomap_set_range() calling
> iop_set_range_update() & iop_set_range_dirty() as the lower level helper routines.
> 
> Based on the the existing code, I believe this ^^^^ is how the heirarchy
> should look like. Does it look good then? If yes, I will simply drop the
> "_iop" part in the next rev.

I don't think that's what I'm saying.  The next version
should not have enum iop_state in it.

ie it looks something like:

iomap_set_range()
{
	bitmap_set(...);
}

iomap_set_range_uptodate()
{
	iomap_set_range(...);
}

iomap_set_range_dirty()
{
	iomap_set_range(...);
}

> <Relevant function list>
>     iop_set_range_uptodate
>     iop_clear_range_uptodate
>     iop_test_uptodate
>     iop_uptodate_full
>     iop_set_range_dirty
>     iop_clear_range_dirty
>     iop_test_dirty
>     iomap_page_create
>     iomap_page_release
>     iomap_iop_set_range -> iomap_set_range()
>     iomap_iop_clear_range  -> iomap_clear_range()
> 
> -ritesh
