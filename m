Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0347711BAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 02:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjEZAul (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 20:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjEZAuk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 20:50:40 -0400
Received: from out-9.mta1.migadu.com (out-9.mta1.migadu.com [IPv6:2001:41d0:203:375::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C02F194
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 17:50:39 -0700 (PDT)
Date:   Thu, 25 May 2023 20:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685062237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XccFcqhRV9oVZ2BhjoWlowoz0O43NBdleRYrqpo+tGk=;
        b=te1MA/PDmp4dIRH1TY49m1pWccvyo+kxGKHIAX3+k8t98qQbEiPCWJYi4Gkczlt1aIn7En
        cHq/akYRgnPKxFNi2vHECVpzXGpjZ3XraNt/Yalda8BuacVJcdSo4hYF5j3kzlTDgdIB0w
        GQUPt6jslW3+faac2EkPdAimK2RxUyY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 5/7] block: Rework bio_for_each_folio_all()
Message-ID: <ZHACWWNIUR6Ohh/8@moria.home.lan>
References: <20230525214822.2725616-1-kent.overstreet@linux.dev>
 <20230525214822.2725616-6-kent.overstreet@linux.dev>
 <ZG/+88/G+hX5DyCX@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG/+88/G+hX5DyCX@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 10:36:03AM +1000, Dave Chinner wrote:
> On Thu, May 25, 2023 at 05:48:20PM -0400, Kent Overstreet wrote:
> > This reimplements bio_for_each_folio_all() on top of the newly-reworked
> > bvec_iter_all, and since it's now trivial we also provide
> > bio_for_each_folio.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: linux-block@vger.kernel.org
> > ---
> >  fs/crypto/bio.c        |  9 +++--
> >  fs/iomap/buffered-io.c | 14 ++++---
> >  fs/verity/verify.c     |  9 +++--
> >  include/linux/bio.h    | 91 +++++++++++++++++++++---------------------
> >  include/linux/bvec.h   | 15 +++++--
> >  5 files changed, 75 insertions(+), 63 deletions(-)
> ....
> > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > index f86c7190c3..7ced281734 100644
> > --- a/include/linux/bio.h
> > +++ b/include/linux/bio.h
> > @@ -169,6 +169,42 @@ static inline void bio_advance(struct bio *bio, unsigned int nbytes)
> >  #define bio_for_each_segment(bvl, bio, iter)				\
> >  	__bio_for_each_segment(bvl, bio, iter, (bio)->bi_iter)
> >  
> > +struct folio_vec {
> > +	struct folio	*fv_folio;
> > +	size_t		fv_offset;
> > +	size_t		fv_len;
> > +};
> 
> Can we drop the "fv_" variable prefix here? It's just unnecessary
> verbosity when we know we have a folio_vec structure. i.e fv->folio
> is easier to read and type than fv->fv_folio...

That's actually one of the things I like about bio/biovec, it's been
handy in the past for grepping and block layer refactorings...

(I would _kill_ for a tool that let me do that kind of type-aware grep.
ctags can in theory produce that kind of an index but I never figured
out how to get vim to use it properly. I believe the lsp-server stuff
that uses the compiler as a backend can do it; I've started using that
stuff for Rust coding and it works amazingly, don't think I've tried it
for struct members - I wonder if that stuff works at all on a codebase
the size of the kernel or just dies...)

> Hmmm, this is probably not a good name considering "struct pagevec" is
> something completely different - the equivalent is "struct
> folio_batch" but I can see this being confusing for people who
> largely expect some symmetry between page<->folio naming
> conventions...

Yeah, good point. folio_seg, perhaps?

(I think Matthew may have already made that suggestion...)

> Also, why is this in bio.h and not in a mm/folio related header
> file?

Is it worth moving it there considering it's only used in bio.h/bvec.h?
Perhaps we could keep it where it's used for now and move it if it gains
more users?
