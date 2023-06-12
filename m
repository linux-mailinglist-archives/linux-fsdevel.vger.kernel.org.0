Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F308C72C94C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 17:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbjFLPF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 11:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239144AbjFLPFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:05:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5891112A;
        Mon, 12 Jun 2023 08:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7175620BD;
        Mon, 12 Jun 2023 15:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF1CC433EF;
        Mon, 12 Jun 2023 15:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686582321;
        bh=893yqsGcbaFfrryMUIMGGssEE09mFNs/uqWMAlQ3g1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F7OxZ+/XFzGfJ2xJE8eb57mZ+LtpyiQMYxj7yV5OYGiBB/elSTwCRr8MgkBD2G6W9
         HaSsNETYblGCE+XASpY+odL8AceXmL61zKBOCXon5ucsFE5do4AQi+IJJTrAEkz+u2
         UyJp5qPXw6sn1pApWkBWgjMvmQGH3ApIR5tsWScHLuqPEknSS/YZqsiBz4xWxHc86j
         IW+A9plfzL5nTUUEAd4JNtsVFZAcrZP5G4Z/uEQWs9F8xkA3OzbLt9SKJGiIjFOfCi
         9w8fbvYM4cDPKuDDm0yzeQo9807+y7AJTqNVB9LS261bfSAlgFCb44GOWm5Oql5RL3
         9XHV1DxNO3r/w==
Date:   Mon, 12 Jun 2023 08:05:20 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 1/6] iomap: Rename iomap_page to iomap_folio_state and
 others
Message-ID: <20230612150520.GA11467@frogsfrogsfrogs>
References: <ZIa51URaIVjjG35D@infradead.org>
 <87wn09ghqh.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn09ghqh.fsf@doe.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 02:49:50PM +0530, Ritesh Harjani wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 
> > On Sun, Jun 11, 2023 at 11:21:48PM -0700, Christoph Hellwig wrote:
> >> Looks good:
> >>
> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Thanks!
> 
> >
> > Actually, coming back to this:
> >
> > -to_iomap_page(struct folio *folio)
> > +static inline struct iomap_folio_state *iomap_get_ifs
> >
> > I find the to_* naming much more descriptive for derving the
> > private data.  get tends to imply grabbing a refcount.
> 
> Not always. That would be iomap_ifs_get(ifs)/iomap_ifs_put(ifs).
> 
> See this -
> 
> static inline void *folio_get_private(struct folio *folio)
> {
> 	return folio->private;
> }
> 
> So, is it ok if we hear from others too on iomap_get_ifs() function
> name?

It's a static inline, no need for namespacing in the name.  And hch is
right, _get/_put often imply receiving and returning some active
refcount.  That (IMO) makes folio_get_private the odd one out, since
pages don't refcount the private pointer.

I think of this more as a C(rap)-style type conversion function for a
generic object that can get touched by many subsystems (and hence we
cannot do the embed-parent-in-child-object thing).

So.

static inline struct iomap_folio_state *
to_folio_state(struct folio *folio)
{
	return folio->private;
}

is fine with me.  Can we go with this, and not make Ritesh run around
renaming and rebasing beyond v10?

[08:02] <willy> honestly, I think even having the abstraction was a
mistake.  just use folio->private

--D

> -ritesh
