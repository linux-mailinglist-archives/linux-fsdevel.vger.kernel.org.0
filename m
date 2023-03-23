Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99596C6B92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 15:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjCWOvx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 10:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjCWOvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:51:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1203AEFA8;
        Thu, 23 Mar 2023 07:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B3506277C;
        Thu, 23 Mar 2023 14:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59447C433D2;
        Thu, 23 Mar 2023 14:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679583070;
        bh=BeVDhTGiIgig9r6zgcWWACDJTJQsieohN3u1+udvr4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EvSDVKmaRP2hOQQZgVTETO8M7gK7tQu3hLC6odeY4jxOqIyqO+Kti1oz8IQVNIg11
         sGODTtCQpDy1cjUtsPUngGa26pR1AnIoK+EETfCayMY94TtFtt/r5fzAWT4D4OOqJB
         Xn7CS/RfLdGA1MBmIjXg/m7R6PFOPMGnQvdGSg+eINMZVyWliVrDGhqPm0X+7x95sB
         +KfXx1IYJ5fxLuyo010Ye6lrvbfFUJyMUFTLwanbKPnnMRfLl1G+sGFNebT5pPZ2eJ
         pMeWlXyfx6v1ig5oj1N+EHuqF/cYGqeynz/nLf4D4Cck/CmHhECww3vBZbccXlxpwd
         i90Gtl0y4xicw==
Date:   Thu, 23 Mar 2023 07:51:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/31] ext4: Convert ext4_finish_bio() to use folios
Message-ID: <20230323145109.GA466457@frogsfrogsfrogs>
References: <20230126202415.1682629-5-willy@infradead.org>
 <87ttyy1bz4.fsf@doe.com>
 <ZBvG8xbGHwQ+PPQa@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBvG8xbGHwQ+PPQa@casper.infradead.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 23, 2023 at 03:26:43AM +0000, Matthew Wilcox wrote:
> On Mon, Mar 06, 2023 at 02:40:55PM +0530, Ritesh Harjani wrote:
> > "Matthew Wilcox (Oracle)" <willy@infradead.org> writes:
> > 
> > > Prepare ext4 to support large folios in the page writeback path.
> > 
> > Sure. I am guessing for ext4 to completely support large folio
> > requires more work like fscrypt bounce page handling doesn't
> > yet support folios right?
> > 
> > Could you please give a little background on what all would be required
> > to add large folio support in ext4 buffered I/O path?
> > (I mean ofcourse other than saying move ext4 to iomap ;))
> > 
> > What I was interested in was, what other components in particular for
> > e.g. fscrypt, fsverity, ext4's xyz component needs large folio support?
> > 
> > And how should one go about in adding this support? So can we move
> > ext4's read path to have large folio support to get started?
> > Have you already identified what all is missing from this path to
> > convert it?
> 
> Honestly, I don't know what else needs to be done beyond this patch
> series.  I can point at some stuff and say "This doesn't work", but in
> general, you have to just enable it and see what breaks.  A lot of the
> buffer_head code is not large-folio safe right now, so that's somewhere
> to go and look.  Or maybe we "just" convert to iomap, and never bother
> fixing the bufferhead code for large folios.

Yes.  Let's leave bufferheads in the legacy doo-doo-dooooo basement
instead of wasting more time on them.  Ideally we'd someday run all the
filesystems through:

bufferheads -> iomap with bufferheads -> iomap with folios -> iomap with
large folios -> retire to somewhere cheaper than Hawaii

--D

> > > Also set the actual error in the mapping, not just -EIO.
> > 
> > Right. I looked at the history and I think it always just had EIO.
> > I think setting the actual err in mapping_set_error() is the right thing
> > to do here.
> > 
> > >
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > w.r.t this patch series. I reviewed the mechanical changes & error paths
> > which converts ext4 ext4_finish_bio() to use folio.
> > 
> > The changes looks good to me from that perspective. Feel free to add -
> > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> Thanks!
