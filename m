Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B318F525A3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 05:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350219AbiEMDjf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 23:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350532AbiEMDjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 23:39:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B65267C1E
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 20:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xN/KS6tsUiz5+LaIG0WIUxRAnt367WcotmYkKHhzHNM=; b=tpT/2MPT69c8LRFm93umO6JcR/
        Olgy+ubwHWA5e95mSxgzmc8jNPN4rvCM84TUqxLd3J3JidB3EjFx2NHCfSVVo/OsoP3t5wX5Bb61k
        FoYc9ISXU4tCHZU0H/RnQwJ4Q1sml3x9dOE7SGqhDwT2glm5obSfHaEGFth5uNy1vF/6SaD2j5Sjz
        02Ldzmwd6lex6IkvEySelFpVUiGlqzV7cKd5MWJ5Q6HPWAMRMCAr4+6g0holGZxvl6MbixcWgwZtC
        h6VMVBWMZME2GU+Gm/gir8p5BiWEHUYZA0FmP63MDUmNg0Gc05khIEQGTUXvX7zInmQ7XoDVdvN4Y
        +XtB6FTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npM9I-0070o3-Js; Fri, 13 May 2022 03:39:28 +0000
Date:   Fri, 13 May 2022 04:39:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Freeing page flags
Message-ID: <Yn3S8A9I/G5F4u80@casper.infradead.org>
References: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
 <Yn3FZSZbEDssbRnk@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn3FZSZbEDssbRnk@localhost.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 12, 2022 at 10:41:41PM -0400, Josef Bacik wrote:
> On Thu, May 12, 2022 at 09:54:59PM +0100, Matthew Wilcox wrote:
> > The LWN writeup [1] on merging the MGLRU reminded me that I need to send
> > out a plan for removing page flags that we can do without.
> > 
> > 1. PG_error.  It's basically useless.  If the page was read successfully,
> > PG_uptodate is set.  If not, PG_uptodate is clear.  The page cache
> > doesn't use PG_error.  Some filesystems do, and we need to transition
> > them away from using it.
> >
> 
> What about writes?  A cursory look shows we don't clear Uptodate if we fail to
> write, which is correct I think.  The only way to indicate we had a write error
> to check later is the page error.

On encountering a write error, we're supposed to call mapping_set_error(),
not SetPageError().

> > 2. PG_private.  This tells us whether we have anything stored at
> > page->private.  We can just check if page->private is NULL or not.
> > No need to have this extra bit.  Again, there may be some filesystems
> > that are a bit wonky here, but I'm sure they're fixable.
> > 
> 
> At least for Btrfs we serialize the page->private with the private_lock, so we
> could probably just drop PG_private, but it's kind of nice to check first before
> we have to take the spin lock.  I suppose we can just do
> 
> if (page->private)
> 	// do lock and check thingy

That's my hope!  I think btrfs is already using folio_attach_private() /
attach_page_private(), which makes everything easier.  Some filesystems
still manipulate page->private and PagePrivate by hand.
