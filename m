Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112AA5673FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 18:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiGEQPB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 12:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiGEQPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:15:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944631D0C8;
        Tue,  5 Jul 2022 09:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57666B817FD;
        Tue,  5 Jul 2022 16:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0A4C341C7;
        Tue,  5 Jul 2022 16:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657037696;
        bh=jNGEpTpeSmqKpSVd5WTsEpzVFmUn2heCACZwWdaIfgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6h6ccuuC/xuEPVerNLuBvvQicBkvX0E4bSEFrA7DZEq5CRrk4dD/7aHX4vzxnqql
         HzGqwhMRniS+90r8IHAlRWYuHdG6Yzb2GI8GekG4B6gHJpd0d5wfTj+LQqGoJwtMc2
         ruSOdsjh9VE8RrhN6qP4UiPZN/SOi2bhylzvt3tDkH4Jl7RDg1g+9+j5JVzBTo00RA
         86Z1E6LYe4xKeO8ij9D3N6H7rMNOZj9sncCixEhy+BQJD6H+mlTY7fRFCkJgAbCe1s
         gSiDDTrMrtrt2c7ug10M138EOnPjaEyDbc0VrfjRC8r/5oqEYMOuUoq2U3cts99jhQ
         eQ0/nwNXEsecw==
Date:   Tue, 5 Jul 2022 10:14:53 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] block: fix leaking page ref on truncated direct io
Message-ID: <YsRjfWadmLrc4h7Y@kbusch-mbp.dhcp.thefacebook.com>
References: <20220705154506.2993693-1-kbusch@fb.com>
 <20220705154506.2993693-3-kbusch@fb.com>
 <YsReqmngB2MLvYrC@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsReqmngB2MLvYrC@ZenIV>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 05, 2022 at 04:54:18PM +0100, Al Viro wrote:
> On Tue, Jul 05, 2022 at 08:45:06AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The size being added to a bio from an iov is aligned to a block size
> > after the pages were gotten. If the new aligned size truncates the last
> > page, its reference was being leaked. Ensure all pages that were not
> > added to the bio have their reference released.
> > 
> > Since this essentially requires doing the same that bio_put_pages(), and
> > there was only one caller for that function, this patch makes the
> > put_page() loop common for everyone.
> > 
> > Fixes: b1a000d3b8ec5 ("block: relax direct io memory alignment")
> > Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> 
> I still very much dislike this.  Background: iov_iter_get_pages should
> advance the fucking iterator by the amount it has grabbed.  It's
> really much cleaner that way.  So your round-down-then-fuck-off-if-zero
> is going to be a clumsy.

I currently don't see a better way to do it, but I'll be happy if you come up
with something.

> Whatever; I can deal with that on top of your patch.  Where would you
> have it go wrt tree?  Could you do a branch based at the last of your
> original series, so that both Jens and I could pull from it?

Branch pushed here:

https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/log/?h=alignment-fixes-rebased
 
> One thing I would really like to avoid is having the entire #for-5.20/block
> in ancestors of those commits; that would make for a monumental headache
> with iov_iter series ;-/

I'm sorry this is clashing with your work. Please let me know if there's
anything else I can do to help.
