Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD16D724766
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 17:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbjFFPQu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 11:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjFFPQt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:16:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E94C12D;
        Tue,  6 Jun 2023 08:16:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BF5663080;
        Tue,  6 Jun 2023 15:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71061C433D2;
        Tue,  6 Jun 2023 15:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686064607;
        bh=DX7PUnqthe10zmITomytmvAUBJ0OtwMWhA+TOmWDBxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vQBbRbOj3VHAiMaOBB74GYpbgFpss+QEHmgJ5GHX0+Delk0Wo0snRjWLkZoFZ3qQU
         es1JKnGnQInMjk8LPr+lknLalfrrthFjROb17ep03IkHDue3rrRLTAp5PjM2mbz6Cj
         9b90hSuYqYCIfCy3UBhVe79YioKBqokVX+aRJFvzQS8hX+YFxaqPnu4zKIoOpgyqsL
         XEcE8/njuptLrson7LCQWJ0qzUHbr45453m1PQ0j79C/9+bvNlp0kLQcqLUXrIz8qA
         gLYuZ0Rr+aUIM8BEhO9xhQZyULBlhyShHZjbpb15j8yf552RRWKrS7H5nnbMbEFVIz
         EzPrlBtRFdgrA==
Date:   Tue, 6 Jun 2023 08:16:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv8 0/5] iomap: Add support for per-block dirty state to
 improve write performance
Message-ID: <20230606151646.GN1325469@frogsfrogsfrogs>
References: <ZH8onIAH8xcrWKE+@casper.infradead.org>
 <87bkhskaoc.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkhskaoc.fsf@doe.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 06:30:35PM +0530, Ritesh Harjani wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Tue, Jun 06, 2023 at 05:13:47PM +0530, Ritesh Harjani (IBM) wrote:
> >> Hello All,
> >> 
> >> Please find PATCHv8 which adds per-block dirty tracking to iomap.
> >> As discussed earlier this is required to improve write performance and reduce
> >> write amplification for cases where either blocksize is less than pagesize (such
> >> as Power platform with 64k pagesize) or when we have a large folio (such as xfs
> >> which currently supports large folio).
> >
> > You're moving too fast.  Please, allow at least a few hours between
> > getting review comments and sending a new version.
> >
> 
> Sorry about that. I felt those were mainly only mechanical conversion
> changes. Will keep in mind.
> 
> >> v7 -> v8
> >> ==========
> >> 1. Renamed iomap_page -> iomap_folio & iop -> iof in Patch-1 itself.
> >
> > I don't think iomap_folio is the right name.  Indeed, I did not believe
> > that iomap_page was the right name.  As I said on #xfs recently ...
> >
> > <willy> i'm still not crazy about iomap_page as the name of that
> >    data structure.  and calling the variable 'iop' just seems doomed
> >    to be trouble.  how do people feel about either iomap_block_state or
> >    folio_block_state ... or even just calling it block_state since it's
> >    local to iomap/buffered-io.c
> > <willy> we'd then call the variable either ibs or fbs, both of which
> >    have some collisions in the kernel, but none in filesystems
> > <dchinner> willy - sounds reasonable
> 
> Both seems equally reasonable to me. If others are equally ok with both,
> then shall we go with iomap_block_state and ibs? 

I've a slight preference for struct folio_block_state/folio_bs/fbs.

Or even struct iomap_folio_state/iofs/ifs.

IBS is an acronym for a rather uncomfortable medical condition... ;)

--D

> I see that as "iomap_block_state" which is local to iomap buffered-io
> layer to track per-block state within a folio and gets attached to
> folio->private.
> 
> -ritesh
