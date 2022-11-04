Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5671E61A1DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 21:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiKDUG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 16:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiKDUGz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:06:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3A623C;
        Fri,  4 Nov 2022 13:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s2O/qvDFRXf6wsYKSZLjcNGb+D8yn522RgYWCb7F9IA=; b=GtnDjMYQ5z4Z0YK9fPQqghVAUu
        S1NnClGtXQ3weaDOyQ9V0+0Pia32moBZqAjUYqkInOBGfZeixA7s3fZHLaEqsaXw7xHFxvuj7Bk2D
        NGp2vaLcYpNUIXvducZ7V1dGW0tYCtdUikNkvwwd0nwwxQ2w6UAsvh2cvrULg6KAH8QmFp7WA2c2t
        AZc9EHn3KODznyd/NQ3mZ8pYJ2EjOwTOoAkuCzZ9oZmGEy5PBpIJLR/l0lQMr9fYyRC55QvSOvYxC
        AH/s8bS6XlEJM43lfJ6ozC36C89WNlhsRSaVoZT4F4UNLptNZsF/H6SfN7ucyrFXy4U6Q8jCS/It+
        hkGNj1Ng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1or2xl-007dIx-Tf; Fri, 04 Nov 2022 20:06:49 +0000
Date:   Fri, 4 Nov 2022 20:06:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Vishal Moola <vishal.moola@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 04/23] page-writeback: Convert write_cache_pages() to use
 filemap_get_folios_tag()
Message-ID: <Y2Vw2UBkti7MeG5U@casper.infradead.org>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
 <20220901220138.182896-5-vishal.moola@gmail.com>
 <20221018210152.GH2703033@dread.disaster.area>
 <Y2RAdUtJrOJmYU4L@fedora>
 <20221104003235.GZ2703033@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104003235.GZ2703033@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 04, 2022 at 11:32:35AM +1100, Dave Chinner wrote:
> At minimum, it needs to be documented, though I'd much prefer that
> we explicitly duplicate write_cache_pages() as write_cache_folios()
> with a callback that takes a folio and change the code to be fully
> multi-page folio safe. Then filesystems that support folios (and
> large folios) natively can be passed folios without going through
> this crappy "folio->page, page->folio" dance because the writepage
> APIs are unaware of multi-page folio constructs.

There are a lot of places which go through the folio->page->folio
dance, and this one wasn't even close to the top of my list.  That
said, it has a fairly small number of callers -- ext4, fuse, iomap,
mpage, nfs, orangefs.  So Vishal, this seems like a good project for you
to take on next -- convert write_cache_pages() to write_cache_folios()
and writepage_t to write_folio_t.
