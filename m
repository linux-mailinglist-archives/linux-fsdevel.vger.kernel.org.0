Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7CD5B8D0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 18:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiINQaT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 12:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiINQ3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:29:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87B5844F4;
        Wed, 14 Sep 2022 09:28:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75343B8171B;
        Wed, 14 Sep 2022 16:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE64C433D7;
        Wed, 14 Sep 2022 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663172913;
        bh=gDxM+S092LlNnnNChSxCoMsXY2G5IgcT89F8QnyFbu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=urDFRWS+xAAvRnRIuH6YprPix4N88yxNN1jBRkcwXf/AYlrDNpfKuDvX7QjnnfSdI
         3/p77+Vc5Uf8GC8KyCyOu2mRjLKwYBmoJy/Ud2nEFJPu2EHEU/oT1gh/KlaqUbW1qO
         fPk6gNKiE5vqpgbTXKqHfFULqK4riGnlLlREVZf7jxAxYAXyqO+Hup90dVv6jfaF6Y
         goc+24pqcUO4geb+EVUXAGZKri/ShdPT3kX0uHQig4xjTFeee7A3XdSaBF1puAeK/8
         63D6iBRfXPg1tPbNHvmE5v3g8Jfk3DHCBWQjHgk9VU8H5gMIWFxGPt0C7MHkgSF7Qx
         HOxi4rpZ5w+WA==
Date:   Wed, 14 Sep 2022 09:28:32 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     =?utf-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>,
        =?utf-8?B?UnVhbiwgU2hpeWFuZy/pmK4g5LiW6Ziz?= 
        <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Message-ID: <YyIBMJzmbZsUBHpy@magnolia>
References: <Ytl7yJJL1fdC006S@magnolia>
 <7fde89dc-2e8f-967b-d342-eb334e80255c@fujitsu.com>
 <YuNn9NkUFofmrXRG@magnolia>
 <0ea1cbe1-79d7-c22b-58bf-5860a961b680@fujitsu.com>
 <YusYDMXLYxzqMENY@magnolia>
 <dd363bd8-2dbd-5d9c-0406-380b60c5f510@fujitsu.com>
 <Yxs5Jb7Yt2c6R6eW@bfoster>
 <7fdc9e88-f255-6edb-7964-a5a82e9b1292@fujitsu.com>
 <76ea04b4-bad7-8cb3-d2c6-4ad49def4e05@fujitsu.com>
 <YyHKUhOgHdTKPQXL@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyHKUhOgHdTKPQXL@bfoster>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 14, 2022 at 08:34:26AM -0400, Brian Foster wrote:
> On Wed, Sep 14, 2022 at 05:38:02PM +0800, Yang, Xiao/杨 晓 wrote:
> > On 2022/9/14 14:44, Yang, Xiao/杨 晓 wrote:
> > > On 2022/9/9 21:01, Brian Foster wrote:
> > > > Yes.. I don't recall all the internals of the tools and test, but IIRC
> > > > it relied on discard to perform zeroing between checkpoints or some such
> > > > and avoid spurious failures. The purpose of running on dm-thin was
> > > > merely to provide reliable discard zeroing behavior on the target device
> > > > and thus to allow the test to run reliably.
> > > Hi Brian,
> > > 
> > > As far as I know, generic/470 was original designed to verify
> > > mmap(MAP_SYNC) on the dm-log-writes device enabling DAX. Due to the
> > > reason, we need to ensure that all underlying devices under
> > > dm-log-writes device support DAX. However dm-thin device never supports
> > > DAX so
> > > running generic/470 with dm-thin device always returns "not run".
> > > 
> > > Please see the difference between old and new logic:
> > > 
> > >            old logic                          new logic
> > > ---------------------------------------------------------------
> > > log-writes device(DAX)                 log-writes device(DAX)
> > >              |                                       |
> > > PMEM0(DAX) + PMEM1(DAX)       Thin device(non-DAX) + PMEM1(DAX)
> > >                                            |
> > >                                          PMEM0(DAX)
> > > ---------------------------------------------------------------
> > > 
> > > We think dm-thin device is not a good solution for generic/470, is there
> > > any other solution to support both discard zero and DAX?
> > 
> > Hi Brian,
> > 
> > I have sent a patch[1] to revert your fix because I think it's not good for
> > generic/470 to use thin volume as my revert patch[1] describes:
> > [1] https://lore.kernel.org/fstests/20220914090625.32207-1-yangx.jy@fujitsu.com/T/#u
> > 
> 
> I think the history here is that generic/482 was changed over first in
> commit 65cc9a235919 ("generic/482: use thin volume as data device"), and
> then sometime later we realized generic/455,457,470 had the same general
> flaw and were switched over. The dm/dax compatibility thing was probably
> just an oversight, but I am a little curious about that because it should

It's not an oversight -- it used to work (albeit with EXPERIMENTAL
tags), and now we've broken it on fsdax as the pmem/blockdev divorce
progresses.

> have been obvious that the change caused the test to no longer run. Did
> something change after that to trigger that change in behavior?
> 
> > With the revert, generic/470 can always run successfully on my environment
> > so I wonder how to reproduce the out-of-order replay issue on XFS v5
> > filesystem?
> > 
> 
> I don't quite recall the characteristics of the failures beyond that we
> were seeing spurious test failures with generic/482 that were due to
> essentially putting the fs/log back in time in a way that wasn't quite
> accurate due to the clearing by the logwrites tool not taking place. If
> you wanted to reproduce in order to revisit that, perhaps start with
> generic/482 and let it run in a loop for a while and see if it
> eventually triggers a failure/corruption..?
> 
> > PS: I want to reproduce the issue and try to find a better solution to fix
> > it.
> > 
> 
> It's been a while since I looked at any of this tooling to semi-grok how
> it works.

I /think/ this was the crux of the problem, back in 2019?
https://lore.kernel.org/fstests/20190227061529.GF16436@dastard/

> Perhaps it could learn to rely on something more explicit like
> zero range (instead of discard?) or fall back to manual zeroing?

AFAICT src/log-writes/ actually /can/ do zeroing, but (a) it probably
ought to be adapted to call BLKZEROOUT and (b) in the worst case it
writes zeroes to the entire device, which is/can be slow.

For a (crass) example, one of my cloudy test VMs uses 34GB partitions,
and for cost optimization purposes we're only "paying" for the cheapest
tier.  Weirdly that maps to an upper limit of 6500 write iops and
48MB/s(!) but that would take about 20 minutes to zero the entire
device if the dm-thin hack wasn't in place.  Frustratingly, it doesn't
support discard or write-zeroes.

> If the
> eventual solution is simple and low enough overhead, it might make some
> sense to replace the dmthin hack across the set of tests mentioned
> above.

That said, for a *pmem* test you'd expect it to be faster than that...

--D

> Brian
> 
> > Best Regards,
> > Xiao Yang
> > 
> > > 
> > > BTW, only log-writes, stripe and linear support DAX for now.
> > 
> 
