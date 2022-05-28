Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4B6536A28
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 04:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352404AbiE1CQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 22:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiE1CQF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 22:16:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8765FF3E
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 19:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SyeNBUfPcaeHo7VtweigGBLJbW/NG3Q0PDwuVn2bi8g=; b=MrxDDijaML8YZj58J2v+6UElBt
        ognuK/xhJpN5Z9UlAM1mAPurPX20WaLlN6uD74nc/vPVPML5UljiAThylWRdjWR0Zl1Ix2SUNQx1K
        RCR2vDyMTijFJQBCox0voP+rr6rP7FPZS/iL9TRSJ4DzS+yi715WrdeUGEySuJsSXyDmhAVYPkcl9
        6dJMBR1PEX0bXKroUeM/QHHpVSNGZgCF8s01jhDIfysFyMtHeh+ZK74hUA0UoJaxuH0IXBnV7durF
        V7wNAW4IbAcikjOdAhgp+bwmx4Ntt/NqX1SGvezydp9f//IKCqtmDhrYHt2lMcE2RyYq0YCdzli7/
        pkuJUImQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nulzh-002XgC-UH; Sat, 28 May 2022 02:15:58 +0000
Date:   Sat, 28 May 2022 03:15:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [RFC PATCH 0/9] Convert JFS to use iomap
Message-ID: <YpGF3ceSLt7J/UKn@casper.infradead.org>
References: <20220526192910.357055-1-willy@infradead.org>
 <20220528000216.GG3923443@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220528000216.GG3923443@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 28, 2022 at 10:02:16AM +1000, Dave Chinner wrote:
> On Thu, May 26, 2022 at 08:29:01PM +0100, Matthew Wilcox (Oracle) wrote:
> > This patchset does not work.  It will eat your filesystem.  Do not apply.
> > 
> > The bug starts to show up with the fourth patch ("Convert direct_IO write
> > support to use iomap").  generic/013 creates a corrupt filesystem and
> > fsck fails to fix it, which shows all kinds of fun places in xfstests
> > where we neglect to check that 'mount' actually mounted the filesystem.
> > set -x or die.
> > 
> > I'm hoping one of the people who knows iomap better than I do can just
> > point at the bug and say "Duh, it doesn't work like that".
> > 
> > It's safe to say that every patch after patch 6 is untested.  I'm not
> > convinced that I really tested patch 6 either.
> 
> So the question I have to ask here is "why even bother?".
> 
> JFS is a legacy filesystem, and the risk of breaking stuff or
> corrupting data and nobody noticing is really quite high.
> 
> We recently deprecated reiserfs and scheduled it's removal because
> of the burden of keeping it up to date with VFS changes, what makes
> JFS any different in this regard?

Deprecating and scheduling removal is all well and good (and yes,
we should probably have a serious conversation about when we should
remove JFS), but JFS is one of the two users of the nobh infrastructure.
If we want to get rid of the nobh infrastructure (which I do), we need
to transition JFS to some other infrastructure.

We also need to convert more filesystems to use iomap.  I really wanted
to NAK the ntfs3 submission on the basis that it was still BH based,
but with so many existing filesystems using the BH infrastructure,
that's not a credible thing to require.

So JFS stood out to me as a filesystem which uses infrastructure that we
can remove fairly easily, one which doesn't get a whole lot of patches,
one that doesn't really use a lot of the BH infrastructure anyway and
one which can serve as an example for more ... relevant filesystems.

