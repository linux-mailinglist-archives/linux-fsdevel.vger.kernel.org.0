Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47940519219
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 01:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243940AbiECXGC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 19:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbiECXGB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 19:06:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C49E18B26;
        Tue,  3 May 2022 16:02:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41317617A5;
        Tue,  3 May 2022 23:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97614C385A9;
        Tue,  3 May 2022 23:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651618946;
        bh=Q+/rvuXBMm1KamhQq3MGjxX7Fy8lT12St/684FQ3cZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q75q3sIdwwb2zvsZxa4A4T5WtgAF8qDm1lFQ5UoJA1n9hpOsy9jDPLuLz2S3JeC6z
         rCV/k5evtxlK83YKAcm/SLjZOodbdR/z0YyFtpQlJTDYJquwo37bj6rXSurxpAnzDW
         gtxRjb+oek1WoDl54AztxlLhCdyN2B130xwEu9N/Z0oumkov/25K4WIVC+DyjjWtbt
         47AgBW07rq56mxbz3hRrtS9Yjj5NR6bMuQGWP1FD60LcVo/CXq+aH1Zw3pICo1CDEY
         c4lLUVMnJ410eep/FqM9sC51BgWumms+8gtrrayP4Z2UkSIDF1M5umvYjcY2uf+0qS
         XhvPXpMkKK6Pw==
Date:   Tue, 3 May 2022 16:02:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] iomap: iomap_write_end cleanup
Message-ID: <20220503230226.GK8265@magnolia>
References: <20220503213727.3273873-1-agruenba@redhat.com>
 <YnGkO9zpuzahiI0F@casper.infradead.org>
 <CAHc6FU5_JTi+RJxYwa+CLc9tx_3_CS8_r8DjkEiYRhyjUvbFww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU5_JTi+RJxYwa+CLc9tx_3_CS8_r8DjkEiYRhyjUvbFww@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 04, 2022 at 12:15:45AM +0200, Andreas Gruenbacher wrote:
> On Tue, May 3, 2022 at 11:53 PM Matthew Wilcox <willy@infradead.org> wrote:
> > On Tue, May 03, 2022 at 11:37:27PM +0200, Andreas Gruenbacher wrote:
> > > In iomap_write_end(), only call iomap_write_failed() on the byte range
> > > that has failed.  This should improve code readability, but doesn't fix
> > > an actual bug because iomap_write_failed() is called after updating the
> > > file size here and it only affects the memory beyond the end of the
> > > file.
> >
> > I can't find a way to set 'ret' to anything other than 0 or len.  I know
> > the code is written to make it look like we can return a short write,
> > but I can't see a way to do it.
> 
> Good point, but that doesn't make the code any less confusing in my eyes.

Not to mention it leaves a logic bomb if we ever /do/ start returning
0 < ret < len.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> Thanks,
> Andreas
> 
> > > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > > ---
> > >  fs/iomap/buffered-io.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index 358ee1fb6f0d..8fb9b2797fc5 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -734,7 +734,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
> > >       folio_put(folio);
> > >
> > >       if (ret < len)
> > > -             iomap_write_failed(iter->inode, pos, len);
> > > +             iomap_write_failed(iter->inode, pos + ret, len - ret);
> > >       return ret;
> > >  }
> > >
> > > --
> > > 2.35.1
> > >
> >
> 
