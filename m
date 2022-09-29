Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652195F0140
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 01:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiI2XKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 19:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiI2XKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:10:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938B5E5FBB;
        Thu, 29 Sep 2022 16:10:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA06E621D7;
        Thu, 29 Sep 2022 23:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC88C433C1;
        Thu, 29 Sep 2022 23:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664493040;
        bh=hRoRhIEa0MS03Dp+yCsbqQyz6eMXg22Q5k3yFvuS9kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WcZdBAYye/vd/whePc5qnF6MtCI/vmvoi3eaRgR+712WKlA+43kpteEI2wtvXfwL7
         mnQ9rba2LXXbTnLI/Jduc7QKO26TPRmDGmCXNDsI/s6ujv6vP0eYzLvjGLYSWYU+ZR
         ZX19TopuwMyIdB0k3cLwehpWhA6yJyJ3xMXnDqkll+v0IH9zN27wTwc0rDL+MdRyZV
         UuhQsy53ITgnqmwdJZ19hiplzBX+jHQcZJq8ecLtGqi2AlwHIz7Nzkstq5qLefLsX7
         4HyefwqSbStXVMSxMfkrVmBbvxiWD/wbx3SlKv0bb/u6OiLIN+Y7qeP4tiD/GLD4ba
         BeWvNxbeynXbQ==
Date:   Thu, 29 Sep 2022 16:10:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: fix memory corruption when recording errors
 during writeback
Message-ID: <YzYl75ZJNymr2bqb@magnolia>
References: <YzXnoR0UMBVfoaOf@magnolia>
 <YzXy8lJGMRUbEdsM@casper.infradead.org>
 <YzYNtYgU1ckryg4Q@magnolia>
 <YzYOU76l/ZqhgFie@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzYOU76l/ZqhgFie@casper.infradead.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 10:29:55PM +0100, Matthew Wilcox wrote:
> On Thu, Sep 29, 2022 at 02:27:17PM -0700, Darrick J. Wong wrote:
> > On Thu, Sep 29, 2022 at 08:33:06PM +0100, Matthew Wilcox wrote:
> > > On Thu, Sep 29, 2022 at 11:44:49AM -0700, Darrick J. Wong wrote:
> > > > Fixes: e735c0079465 ("iomap: Convert iomap_add_to_ioend() to take a folio")
> > > > Probably-Fixes: 598ecfbaa742 ("iomap: lift the xfs writeback code to iomap")
> > > 
> > > I think this is a misuse of Fixes.  As I understand it, Fixes: is "Here's
> > > the commit that introduced the bug", not "This is the most recent change
> > > after which this patch will still apply".  e735c0079465 only changed
> > > s/page/folio/ in this line of code, so clearly didn't introduce the bug.
> > > 
> > > Any kernel containing 598ecfbaa742 has this same bug, so that should be
> > > the Fixes: line.  As you say though, 598ecfbaa742 merely moved the code
> > > from xfs_writepage_map().  bfce7d2e2d5e moved it from xfs_do_writepage(),
> > > but 150d5be09ce4 introduced it.  Six years ago!  Good find.  So how about:
> > > 
> > > Fixes: 150d5be09ce4 ("xfs: remove xfs_cancel_ioend")
> > 
> > Sounds fine to me, though if I hear complaints from AUTOSEL about how
> > the patch does not directly apply to old kernels, I'll forward them to
> > you, because that's what I do now to avoid getting even /more/ email.
> 
> Well, autosel is right to complain ... there's a fix which doesn't
> apply magically to every still-supported kernel containing the bug.
> I'm happy to own backporting this one as far as necessary.

Are you sure?  You're volunteering yourself for 7 LTS backports
5.19, 5.15, 5.10, 5.4, 4.19, 4.14, and 4.9.

--D

> > > Also,
> > > 
> > > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > However, thank you for the quick review. :)
> > 
> > --D
> > 
> > > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > > ---
> > > >  fs/iomap/buffered-io.c |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > > index ca5c62901541..77d59c159248 100644
> > > > --- a/fs/iomap/buffered-io.c
> > > > +++ b/fs/iomap/buffered-io.c
> > > > @@ -1421,7 +1421,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> > > >  	if (!count)
> > > >  		folio_end_writeback(folio);
> > > >  done:
> > > > -	mapping_set_error(folio->mapping, error);
> > > > +	mapping_set_error(inode->i_mapping, error);
> > > >  	return error;
> > > >  }
> > > >  
