Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2591B72CB0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 18:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjFLQKj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 12:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFLQKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:10:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1242719D;
        Mon, 12 Jun 2023 09:10:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82F4A6157C;
        Mon, 12 Jun 2023 16:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCCEC433EF;
        Mon, 12 Jun 2023 16:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686586234;
        bh=GGn76tGN0G7Csher7QvAY1txJfjYU5LivWsNseZsoFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OHPzpMgmndNEDWBSp8E66kgN0j7478UlNcjSt+2VJUlNZwvpMMji7LVDENSEYSSK9
         MIDjsszVFhyePLQDog/lWXBPyH9qLz278/FNlQH29R/WHIx+Bne2prVOsaHb8rYB/f
         8qpW3bFFQ/S/kb7cc9jHuUdvy9uUUyea3wvwDD5uOxZWRMff8SiOwH01rIkxtTQ94O
         NLRrmyeTzDIwFzpjdyhchI/LxJ7lUbnLEqJZZw47Hl6Cmcs+TpoT96gnYhfrVeHJIC
         ZTV+BWHC9ZadWu/KBC6se08URtApnYr+3PHttLX8CNXlnp4X41jv/Yq21FkxGHQ+vK
         ePL79W/zVJGGQ==
Date:   Mon, 12 Jun 2023 09:10:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 3/6] iomap: Add some uptodate state handling helpers
 for ifs state bitmap
Message-ID: <20230612161034.GD11441@frogsfrogsfrogs>
References: <CAHc6FU5xMQfGPuTBDChS=w2+t4KAbu9po7yE+7qGaLTzV-+AFw@mail.gmail.com>
 <87o7lkhfpj.fsf@doe.com>
 <ZIc4ujLJixghk6Zp@casper.infradead.org>
 <CAHc6FU7GnVeKmUC4GkySqE1bV3WgbA_WTuQ3D0dcMyn193M4VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU7GnVeKmUC4GkySqE1bV3WgbA_WTuQ3D0dcMyn193M4VA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 05:57:48PM +0200, Andreas Gruenbacher wrote:
> On Mon, Jun 12, 2023 at 5:24 PM Matthew Wilcox <willy@infradead.org> wrote:
> > On Mon, Jun 12, 2023 at 08:48:16PM +0530, Ritesh Harjani wrote:
> > > > Since we're at the nitpicking, I don't find those names very useful,
> > > > either. How about the following instead?
> > > >
> > > > iomap_ifs_alloc -> iomap_folio_state_alloc
> > > > iomap_ifs_free -> iomap_folio_state_free
> > > > iomap_ifs_calc_range -> iomap_folio_state_calc_range
> > >
> > > First of all I think we need to get used to the name "ifs" like how we
> > > were using "iop" earlier. ifs == iomap_folio_state...
> > >
> > > >
> > > > iomap_ifs_is_fully_uptodate -> iomap_folio_is_fully_uptodate
> > > > iomap_ifs_is_block_uptodate -> iomap_block_is_uptodate
> > > > iomap_ifs_is_block_dirty -> iomap_block_is_dirty
> > > >
> > >
> > > ...if you then look above functions with _ifs_ == _iomap_folio_state_
> > > naming. It will make more sense.
> >
> > Well, it doesn't because it's iomap_iomap_folio_state_is_fully_uptodate.
> 
> Exactly.
> 
> > I don't think there's any need to namespace this so fully.
> > ifs_is_fully_uptodate() is just fine for a static function, IMO.
> 
> I'd be perfectly happy with that kind of naming scheme as well.

Ugh, /another/ round of renaming.

to_folio_state (or just folio->private)

ifs_alloc
ifs_free
ifs_calc_range

ifs_set_range_uptodate
ifs_is_fully_uptodate
ifs_block_is_uptodate

ifs_block_is_dirty
ifs_clear_range_dirty
ifs_set_range_dirty

No more renaming suggestions.  I've reached the point where my eyes and
brain have both glazed over from repeated re-reads of this series such
that I don't see the *bugs* anymore.

Anyone else wanting new naming gets to *send in their own patch*.
Please focus only on finding code defects or friction between iomap and
some other subsystem.

Flame away about my aggressive tone,

~Your burned out and pissed off maintainer~

> Thanks,
> Andreas
> 
