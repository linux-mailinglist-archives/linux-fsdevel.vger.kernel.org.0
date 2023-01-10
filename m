Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE0F664E5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 22:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjAJV4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 16:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjAJV4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:56:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E4011A06;
        Tue, 10 Jan 2023 13:56:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C9AB618E5;
        Tue, 10 Jan 2023 21:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B15CC433D2;
        Tue, 10 Jan 2023 21:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673387804;
        bh=QFvU724dQekZNqvjWFmNHGn15TBg7ISixIdd6G6hClc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVnrD/kTYdayTgwe/1H43W81w96fKOK6bErqbIdCGUr17/9dgx0KC497wMp9335mc
         W5J4wpnTlb6R+HAusXzCQChobUBQ7cVm5GQ40CXtCd2jisaw02gGfOOVWhWVPy7GXk
         Zxsep668qJJdYIgI1Lx4d2ceOj9mVi3kWrLSpZKeP+w9um01g1288gZ/ODcAeqLcIk
         cg8Qegj+PzxYyptfFIx2F6KESaP9IWr9drC9irN5aJiteTLZ9ijww8GSYU1ukYALEr
         0UAWoHEXge9BLcKTMY07FBG8kH33Eu8zCbY/E+pcjlCKAnwGM2v47UQG9Ma5VbOR8+
         UD0RYV3d+7BpA==
Date:   Tue, 10 Jan 2023 13:56:44 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH v5 7/9] iomap/xfs: Eliminate the iomap_valid handler
Message-ID: <Y73fHN4aDfbo6e1z@magnolia>
References: <20221231150919.659533-1-agruenba@redhat.com>
 <20221231150919.659533-8-agruenba@redhat.com>
 <Y7W9Dfub1WeTvG8G@magnolia>
 <Y7XOoZNxZCpjCJLH@casper.infradead.org>
 <Y7r+NkbfDqat9uHA@infradead.org>
 <CAHc6FU40OYCpRjnitmKn6s9LOZCy4O=4XobHdcUeFc=k=x5cGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU40OYCpRjnitmKn6s9LOZCy4O=4XobHdcUeFc=k=x5cGg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 08, 2023 at 07:50:01PM +0100, Andreas Gruenbacher wrote:
> On Sun, Jan 8, 2023 at 6:32 PM Christoph Hellwig <hch@infradead.org> wrote:
> > On Wed, Jan 04, 2023 at 07:08:17PM +0000, Matthew Wilcox wrote:
> > > On Wed, Jan 04, 2023 at 09:53:17AM -0800, Darrick J. Wong wrote:
> > > > I wonder if this should be reworked a bit to reduce indenting:
> > > >
> > > >     if (PTR_ERR(folio) == -ESTALE) {
> > >
> > > FYI this is a bad habit to be in.  The compiler can optimise
> > >
> > >       if (folio == ERR_PTR(-ESTALE))
> > >
> > > better than it can optimise the other way around.
> >
> > Yes.  I think doing the recording that Darrick suggested combined
> > with this style would be best:
> >
> >         if (folio == ERR_PTR(-ESTALE)) {
> >                 iter->iomap.flags |= IOMAP_F_STALE;
> >                 return 0;
> >         }
> >         if (IS_ERR(folio))
> >                 return PTR_ERR(folio);
> 
> Again, I've implemented this as a nested if because the -ESTALE case
> should be pretty rare, and if we unnest, we end up with an additional
> check on the main code path. To be specific, the "before" code here on
> my current system is this:
> 
> ------------------------------------
>         if (IS_ERR(folio)) {
>     22ad:       48 81 fd 00 f0 ff ff    cmp    $0xfffffffffffff000,%rbp
>     22b4:       0f 87 bf 03 00 00       ja     2679 <iomap_write_begin+0x499>
>                         return 0;
>                 }
>                 return PTR_ERR(folio);
>         }
> [...]
>     2679:       89 e8                   mov    %ebp,%eax
>                 if (folio == ERR_PTR(-ESTALE)) {
>     267b:       48 83 fd 8c             cmp    $0xffffffffffffff8c,%rbp
>     267f:       0f 85 b7 fc ff ff       jne    233c <iomap_write_begin+0x15c>
>                         iter->iomap.flags |= IOMAP_F_STALE;
>     2685:       66 81 4b 42 00 02       orw    $0x200,0x42(%rbx)
>                         return 0;
>     268b:       e9 aa fc ff ff          jmp    233a <iomap_write_begin+0x15a>
> ------------------------------------
> 
> While the "after" code is this:
> 
> ------------------------------------
>         if (folio == ERR_PTR(-ESTALE)) {
>     22ad:       48 83 fd 8c             cmp    $0xffffffffffffff8c,%rbp
>     22b1:       0f 84 bc 00 00 00       je     2373 <iomap_write_begin+0x193>
>                 iter->iomap.flags |= IOMAP_F_STALE;
>                 return 0;
>         }
>         if (IS_ERR(folio))
>                 return PTR_ERR(folio);
>     22b7:       89 e8                   mov    %ebp,%eax
>         if (IS_ERR(folio))
>     22b9:       48 81 fd 00 f0 ff ff    cmp    $0xfffffffffffff000,%rbp
>     22c0:       0f 87 82 00 00 00       ja     2348 <iomap_write_begin+0x168>
> ------------------------------------
> 
> The compiler isn't smart enough to re-nest the ifs by recognizing that
> folio == ERR_PTR(-ESTALE) is a subset of IS_ERR(folio).
> 
> So do you still insist on that un-nesting even though it produces worse code?

Me?  Not anymore. :)

--D

> Thanks,
> Andreas
> 
