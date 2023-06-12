Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D2E72CADA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 18:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbjFLP73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 11:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237673AbjFLP7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:59:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA24FDB;
        Mon, 12 Jun 2023 08:59:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86F5E61E99;
        Mon, 12 Jun 2023 15:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE236C433D2;
        Mon, 12 Jun 2023 15:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686585551;
        bh=36KsyzwyP/ldtOMsKAdGVJSyZ+hNY+AKM4sN/Dwk46g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hNhjAZj1HQGs4UAAw1AkqIVE2sMZyvcY8zuB0UyBRsL5a6TjoeamvI4ASBQ2JdjW0
         SeYI8NYIivFspjls8ATAnB6aFZb5bAtDmw4WQzHEXJRXznyUE06D0ijT00yNDjcu/o
         8J5O5VowotW8puXpA9+DIcOCU5E8TwQjwD6VHOdGhPW1sN+b5nK6X1kCvfwoE8zGNc
         86p0wYHv0AlEBYl4Fl1gLW15YIBI7VEH2XvHAxlJYDtLOTgxC9Q3jkqKy2w8JKbV7a
         NVtVIutDLn9wcaXQR6wFqScjTJnS6ZMgzjvlqy4ZNAZpZ7uYKDG0CEnvvEzXqv/jiS
         RszuRQcv3NzVA==
Date:   Mon, 12 Jun 2023 08:59:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 1/6] iomap: Rename iomap_page to iomap_folio_state and
 others
Message-ID: <20230612155911.GC11441@frogsfrogsfrogs>
References: <ZIa51URaIVjjG35D@infradead.org>
 <87wn09ghqh.fsf@doe.com>
 <20230612150520.GA11467@frogsfrogsfrogs>
 <ZIc1A5uMthrT1hya@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIc1A5uMthrT1hya@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 04:08:51PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 12, 2023 at 08:05:20AM -0700, Darrick J. Wong wrote:
> > static inline struct iomap_folio_state *
> > to_folio_state(struct folio *folio)
> > {
> > 	return folio->private;
> > }
> 
> I'd reformat it to not-XFS-style:
> 
> static inline struct iomap_folio_state *to_folio_state(struct folio *folio)
> {
> 	return folio->private;
> }
> 
> But other than that, I approve.  Unless you just want to do without it
> entirely and do
> 
> 	struct iomap_folio_state *state = folio->private;
> 
> instead of
> 
> 	struct iomap_folio_state *state = to_folio_state(folio);
> 
> I'm having a hard time caring between the two.

Either's fine with me too.  I'm getting tired of reading this series
over and over again.

Ritesh: Please pick whichever variant you like, and that's it, no more
discussion.

--D
