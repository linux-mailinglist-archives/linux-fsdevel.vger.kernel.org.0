Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAD25EFF3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 23:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiI2V1W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 17:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiI2V1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:27:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6716F14328B;
        Thu, 29 Sep 2022 14:27:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 003796115C;
        Thu, 29 Sep 2022 21:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C4FC433D6;
        Thu, 29 Sep 2022 21:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664486838;
        bh=7Kf4cZBrQwRHfxU4QnRfVt8FihSv/LmgjgkwL6PBRSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JV5mYqZU7yA4ixMOufMkZLAQqPpuHYigoBX8sXR6CQb1WUy1c6PqIReeInkKZmACG
         WLmqLEgLgB7H3LHGoznuBQodgNNrFFIpM7QZa3h4iXWLcRVyQtLmnL3kOlBfzYx3vW
         VLYzCtOHbvX/SyIYQ598aJDmOAJ/hjPvYyHQLrzGAONBWbg1BD2ahJj6XPiW5ZLto5
         64w/r3pTuFOteVLWVO+nPBPtZknXDdI2owy0DO6wpIeprnJL+YQT5WGuhAysh16jOV
         0BxHROU7DGRSavhiHOfhV3b1v1iea7dfphqLaqHF3hgooNMCyebDO7jk3I8333KgHU
         JT+Sqtp5JPAoA==
Date:   Thu, 29 Sep 2022 14:27:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: fix memory corruption when recording errors
 during writeback
Message-ID: <YzYNtYgU1ckryg4Q@magnolia>
References: <YzXnoR0UMBVfoaOf@magnolia>
 <YzXy8lJGMRUbEdsM@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzXy8lJGMRUbEdsM@casper.infradead.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 08:33:06PM +0100, Matthew Wilcox wrote:
> On Thu, Sep 29, 2022 at 11:44:49AM -0700, Darrick J. Wong wrote:
> > Fixes: e735c0079465 ("iomap: Convert iomap_add_to_ioend() to take a folio")
> > Probably-Fixes: 598ecfbaa742 ("iomap: lift the xfs writeback code to iomap")
> 
> I think this is a misuse of Fixes.  As I understand it, Fixes: is "Here's
> the commit that introduced the bug", not "This is the most recent change
> after which this patch will still apply".  e735c0079465 only changed
> s/page/folio/ in this line of code, so clearly didn't introduce the bug.
> 
> Any kernel containing 598ecfbaa742 has this same bug, so that should be
> the Fixes: line.  As you say though, 598ecfbaa742 merely moved the code
> from xfs_writepage_map().  bfce7d2e2d5e moved it from xfs_do_writepage(),
> but 150d5be09ce4 introduced it.  Six years ago!  Good find.  So how about:
> 
> Fixes: 150d5be09ce4 ("xfs: remove xfs_cancel_ioend")

Sounds fine to me, though if I hear complaints from AUTOSEL about how
the patch does not directly apply to old kernels, I'll forward them to
you, because that's what I do now to avoid getting even /more/ email.

> Also,
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

However, thank you for the quick review. :)

--D

> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/iomap/buffered-io.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index ca5c62901541..77d59c159248 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1421,7 +1421,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >  	if (!count)
> >  		folio_end_writeback(folio);
> >  done:
> > -	mapping_set_error(folio->mapping, error);
> > +	mapping_set_error(inode->i_mapping, error);
> >  	return error;
> >  }
> >  
