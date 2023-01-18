Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499F06727CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 20:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjARTE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 14:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjARTEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:04:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486B823C7A;
        Wed, 18 Jan 2023 11:04:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D89EB619D6;
        Wed, 18 Jan 2023 19:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B06C433EF;
        Wed, 18 Jan 2023 19:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674068652;
        bh=u9TZ1urVqPBdPj7A5reaAt6jEEdIYW9hwuVTIrzzUBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T8vGxMKTSaNnWydCHPV7DTa2lhjwLSxIjjIWeEXAIDxwDdifdJQdRWv4F5INkl91j
         NV33cKeIvOcbnJE9cDx/WXeakPzNWKfRPujj3vRqrGRlJXamKpKURVuPjIUCE8/yvB
         lbvooubFxDtehPLB5J8l8wPOLPCkUcMXUa8lMreniqjzFqmdLEbEotTjZBsW2bqph0
         9isasvIY99b0sQnc8v/ue0UDIUClq3afVMxjUGQvaApAvYgtFnTTZ5egrUtAck+g4R
         9nVD759GAWmIoIVG6V2BPlf+g8XcodJ4J9/OLhNncx8hBQQ0xfhcFf+489BltDZLix
         sY381nJGmd0UQ==
Date:   Wed, 18 Jan 2023 11:04:11 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [RFC v6 08/10] iomap/xfs: Eliminate the iomap_valid handler
Message-ID: <Y8hCq+fIWgHfUufe@magnolia>
References: <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-9-agruenba@redhat.com>
 <20230108215911.GP1971568@dread.disaster.area>
 <CAHc6FU4z1nC8zdM8NvUyMqU29_J7_oNu1pvBHuOvR+M6gq7F0Q@mail.gmail.com>
 <20230109225453.GQ1971568@dread.disaster.area>
 <CAHpGcM+urV5LYpTZQWTRoK6VWaLx0sxk3mDe_kd3VznMY9woVw@mail.gmail.com>
 <Y8Q4FmhYehpQPZ3Z@magnolia>
 <Y8eeAmm1Vutq3Fc9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8eeAmm1Vutq3Fc9@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 17, 2023 at 11:21:38PM -0800, Christoph Hellwig wrote:
> On Sun, Jan 15, 2023 at 09:29:58AM -0800, Darrick J. Wong wrote:
> > I don't have any objections to pulling everything except patches 8 and
> > 10 for testing this week. 
> 
> That would be great.  I now have a series to return the ERR_PTR
> from __filemap_get_folio which will cause a minor conflict, but
> I think that's easy enough for Linux to handle.

Ok, done.

> > 
> > 1. Does zonefs need to revalidate mappings?  The mappings are 1:1 so I
> > don't think it does, but OTOH zone pointer management might complicate
> > that.
> 
> Adding Damien.
> 
> > 2. How about porting the writeback iomap validation to use this
> > mechanism?  (I suspect Dave might already be working on this...)
> 
> What is "this mechanism"?  Do you mean the here removed ->iomap_valid
> ?   writeback calls into ->map_blocks for every block while under the
> folio lock, so the validation can (and for XFS currently is) done
> in that.  Moving it out into a separate method with extra indirect
> functiona call overhead and interactions between the methods seems
> like a retrograde step to me.

Sorry, I should've been more specific -- can xfs writeback use the
validity cookie in struct iomap and thereby get rid of struct
xfs_writepage_ctx entirely?

> > 2. Do we need to revalidate mappings for directio writes?  I think the
> > answer is no (for xfs) because the ->iomap_begin call will allocate
> > whatever blocks are needed and truncate/punch/reflink block on the
> > iolock while the directio writes are pending, so you'll never end up
> > with a stale mapping.
> 
> Yes.

Er... yes as in "Yes, we *do* need to revalidate directio writes", or
"Yes, your reasoning is correct"?

--D
