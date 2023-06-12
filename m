Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CB672CB41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 18:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjFLQQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 12:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFLQQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:16:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B95122;
        Mon, 12 Jun 2023 09:16:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B254260F29;
        Mon, 12 Jun 2023 16:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A999C433EF;
        Mon, 12 Jun 2023 16:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686586578;
        bh=Y9iBs2y4Wmod+DqdmH2uAhJF9aIx0VwtBTisiBbrDRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ChM84pQDHcmKpDTsYBubNLOHLzbVZER9UgCi/SeBPQWSX/rF6kvqu6JuEwZKuj6p6
         ABXb0rU0JAfwSMMeyFdO6zH2tLJkgSyAyAfZdhLK8yiUc+qVgS1OQMG38DFIPzcTT+
         i8Qt5RAHe0z5lAichcW6Dk6B5QTEMsUsxW0cHTo3GPSSUasgAXcSc9XYuTkwGpj4k8
         gfKqRDd06twca1GrZ2BUVgt0G27nV2cFDmhVBEt8aXafL+quRju47m2yr1kbprGLF0
         RX39uxbtoAiscEeXRXei5cqLu00hQm6gdl8fTaPVg3F0jSJsCthtK+GruyTD4Ia8A3
         xlRu6b2MhEp8w==
Date:   Mon, 12 Jun 2023 09:16:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 3/6] iomap: Add some uptodate state handling helpers
 for ifs state bitmap
Message-ID: <20230612161617.GE11441@frogsfrogsfrogs>
References: <CAHc6FU7Hv71ujeb9oEVOD+bpddMMT0KY+KKUp881Am15u-OVvg@mail.gmail.com>
 <87ilbshf56.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ilbshf56.fsf@doe.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 09:00:29PM +0530, Ritesh Harjani wrote:
> Andreas Gruenbacher <agruenba@redhat.com> writes:
> 
> > On Sat, Jun 10, 2023 at 1:39 PM Ritesh Harjani (IBM)
> > <ritesh.list@gmail.com> wrote:
> >> This patch adds two of the helper routines iomap_ifs_is_fully_uptodate()
> >> and iomap_ifs_is_block_uptodate() for managing uptodate state of
> >> ifs state bitmap.
> >>
> >> In later patches ifs state bitmap array will also handle dirty state of all
> >> blocks of a folio. Hence this patch adds some helper routines for handling
> >> uptodate state of the ifs state bitmap.
> >>
> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >> ---
> >>  fs/iomap/buffered-io.c | 28 ++++++++++++++++++++--------
> >>  1 file changed, 20 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> >> index e237f2b786bc..206808f6e818 100644
> >> --- a/fs/iomap/buffered-io.c
> >> +++ b/fs/iomap/buffered-io.c
> >> @@ -43,6 +43,20 @@ static inline struct iomap_folio_state *iomap_get_ifs(struct folio *folio)
> >>
> >>  static struct bio_set iomap_ioend_bioset;
> >>
> >> +static inline bool iomap_ifs_is_fully_uptodate(struct folio *folio,
> >> +                                              struct iomap_folio_state *ifs)
> >> +{
> >> +       struct inode *inode = folio->mapping->host;
> >> +
> >> +       return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
> >
> > This should be written as something like:
> >
> > unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> > return bitmap_full(ifs->state + IOMAP_ST_UPTODATE * blks_per_folio,
> > blks_per_folio);
> >
> 
> Nah, I feel it is not required... It make sense when we have the same
> function getting use for both "uptodate" and "dirty" state.
> Here the function anyways operates on uptodate state.
> Hence I feel it is not required.

Honestly I thought that enum-for-bits thing was excessive considering
that ifs has only two state bits.  But, since you included it, it
doesn't make much sense /not/ to use it here.

OTOH, if you disassemble the object code and discover that the compiler
*isn't* using constant propagation to simplify the object code, then
yes, that would be a good reason to get rid of it.

--D

> >> +}
> >> +
> >> +static inline bool iomap_ifs_is_block_uptodate(struct iomap_folio_state *ifs,
> >> +                                              unsigned int block)
> >> +{
> >> +       return test_bit(block, ifs->state);
> >
> > This function should be called iomap_ifs_block_is_uptodate(), and
> > probably be written as follows, passing in the folio as well (this
> > will optimize out, anyway):
> >
> > struct inode *inode = folio->mapping->host;
> > unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> > return test_bit(block, ifs->state + IOMAP_ST_UPTODATE * blks_per_folio);
> >
> 
> Same here.
> 
> -ritesh
