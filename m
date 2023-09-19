Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20567A5950
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 07:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjISFYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 01:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjISFYl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:24:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E6FFC;
        Mon, 18 Sep 2023 22:24:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE3FC433C7;
        Tue, 19 Sep 2023 05:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695101075;
        bh=CVx+g8d8hoeM7KDO7RwL3UJHnMXwhd46Mp6LAAYw9rE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kq9RIri+jligTmtIRuodku+XsyyjdzW5Y2E+QJ7d7dJ8OfvLyDY74/+SgjioFFnvi
         rQ7Q6E2GWh/WyKX5LyecTFZ1LLNbypoEfrHBqXbLdmXUNFyND6dzAhmoqy35rWefQh
         m1VOwffH3kBDUVHJUK3vpfE535wYFn5UZFtgBYIw8a79PFGPzkxULDOlSBoPiq8pAw
         IIFCnUX4hBHzckS8fWtz3LNqcJMq0m7dRfRbgq/apX98l8h/0T6LgQYEjsbsGJRyrD
         +s8viGtnJSl7JhFqMoBS3tyIieloDQA1X9VKxetKT8u9xawHLpFlgxY4YI791WGdmc
         nF+7IWXNGodSg==
Date:   Mon, 18 Sep 2023 22:24:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: don't skip reading in !uptodate folios when
 unsharing a range
Message-ID: <20230919052434.GG348018@frogsfrogsfrogs>
References: <169507872536.772278.18183365318216726644.stgit@frogsfrogsfrogs>
 <87o7hy7nhp.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7hy7nhp.fsf@doe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 10:44:58AM +0530, Ritesh Harjani wrote:
> "Darrick J. Wong" <djwong@kernel.org> writes:
> 
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Prior to commit a01b8f225248e, we would always read in the contents of a
> > !uptodate folio prior to writing userspace data into the folio,
> > allocated a folio state object, etc.  Ritesh introduced an optimization
> > that skips all of that if the write would cover the entire folio.
> >
> > Unfortunately, the optimization misses the unshare case, where we always
> > have to read in the folio contents since there isn't a data buffer
> > supplied by userspace.  This can result in stale kernel memory exposure
> > if userspace issues a FALLOC_FL_UNSHARE_RANGE call on part of a shared
> > file that isn't already cached.
> >
> > This was caught by observing fstests regressions in the "unshare around"
> > mechanism that is used for unaligned writes to a reflinked realtime
> > volume when the realtime extent size is larger than 1FSB,
> 
> I was wondering what is testcase that you are referring here to? 
> Can you please tell the testcase no. and the mkfs / mount config options
> which I can use to observe the regression please?

https://lore.kernel.org/linux-fsdevel/169507871947.772278.5767091361086740046.stgit@frogsfrogsfrogs/T/#m8081f74f4f1fcb862399aa1544be082aabe56765

(any xfs config with reflink enabled)

--D

> > though I think it applies to any shared file.
> >
> > Cc: ritesh.list@gmail.com, willy@infradead.org
> > Fixes: a01b8f225248e ("iomap: Allocate ifs in ->write_begin() early")
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/iomap/buffered-io.c |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index ae8673ce08b1..0350830fc989 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -640,11 +640,13 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
> >  	size_t poff, plen;
> >  
> >  	/*
> > -	 * If the write completely overlaps the current folio, then
> > +	 * If the write or zeroing completely overlaps the current folio, then
> >  	 * entire folio will be dirtied so there is no need for
> >  	 * per-block state tracking structures to be attached to this folio.
> > +	 * For the unshare case, we must read in the ondisk contents because we
> > +	 * are not changing pagecache contents.
> >  	 */
> > -	if (pos <= folio_pos(folio) &&
> > +	if (!(iter->flags & IOMAP_UNSHARE) && pos <= folio_pos(folio) &&
> >  	    pos + len >= folio_pos(folio) + folio_size(folio))
> >  		return 0;
> >  
