Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8475F5F3A68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 02:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiJDAMr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 20:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJDAMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:12:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19586129;
        Mon,  3 Oct 2022 17:12:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8CD3B817AC;
        Tue,  4 Oct 2022 00:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECDFC433C1;
        Tue,  4 Oct 2022 00:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664842362;
        bh=neIeFY0kzlr6omafVwPaVRWh/sIl8N6ZI5oIXrcn8+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qTdmg6lV+JZMZdS7MFXirDcIpKmpyOIA3n5iHtls5DaUvDrh7ny7V+YdJGN8Aq1Om
         MI+lrw7FwJYJlCNutFIt0GAR/RKnBwa0Ujo8oYyBV005Pyt/mzJ0+BOSkIARjoSUJf
         Ca//+I+DbzkFw0fOjPad+IFu763p2J2talRRpGkx+6kJlnZ04s7M830//v5vqulgo9
         DecJGiCLTM3p6hLJjAH9vpj14baludfQxEIdbId/N2kchk0YBfWBFCpaDRIxTYAcDW
         EVfT41GAWxswuFGUnf7vqc6tpq41fDQAf+ofdswl3Qmz2LLMED2AIoyy0XpV0QgqVZ
         CeXKZ5rw9VQiw==
Date:   Mon, 3 Oct 2022 17:12:41 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     =?utf-8?B?R290b3UsIFlhc3Vub3JpL+S6lOWztiDlurfmloc=?= 
        <y-goto@fujitsu.com>
Cc:     =?utf-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>,
        Brian Foster <bfoster@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        =?utf-8?B?UnVhbiwgU2hpeWFuZy/pmK4g5LiW6Ziz?= 
        <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>, zwisler@kernel.org,
        Jeff Moyer <jmoyer@redhat.com>, dm-devel@redhat.com,
        toshi.kani@hpe.com
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Message-ID: <Yzt6eWLuX/RTjmjj@magnolia>
References: <dd363bd8-2dbd-5d9c-0406-380b60c5f510@fujitsu.com>
 <Yxs5Jb7Yt2c6R6eW@bfoster>
 <7fdc9e88-f255-6edb-7964-a5a82e9b1292@fujitsu.com>
 <76ea04b4-bad7-8cb3-d2c6-4ad49def4e05@fujitsu.com>
 <YyHKUhOgHdTKPQXL@bfoster>
 <YyIBMJzmbZsUBHpy@magnolia>
 <a6e7f4eb-0664-bbe8-98d2-f8386b226113@fujitsu.com>
 <e3d51a6b-12e9-2a19-1280-5fd9dd64117c@fujitsu.com>
 <deb54a77-90d3-df44-1880-61cce6e3f670@fujitsu.com>
 <1444b9b5-363a-163c-0513-55d1ea951799@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1444b9b5-363a-163c-0513-55d1ea951799@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 30, 2022 at 09:56:41AM +0900, Gotou, Yasunori/五島 康文 wrote:
> Hello everyone,
> 
> On 2022/09/20 11:38, Yang, Xiao/杨 晓 wrote:
> > Hi Darrick, Brian and Christoph
> > 
> > Ping. I hope to get your feedback.
> > 
> > 1) I have confirmed that the following patch set did not change the test
> > result of generic/470 with thin-volume. Besides, I didn't see any
> > failure when running generic/470 based on normal PMEM device instaed of
> > thin-volume.
> > https://lore.kernel.org/linux-xfs/20211129102203.2243509-1-hch@lst.de/
> > 
> > 2) I can reproduce the failure of generic/482 without thin-volume.
> > 
> > 3) Is it necessary to make thin-volume support DAX. Is there any use
> > case for the requirement?
> 
> 
> Though I asked other place(*), I really want to know the usecase of
> dm-thin-volume with DAX and reflink.
> 
> 
> In my understanding, dm-thin-volume seems to provide similar feature like
> reflink of xfs. Both feature provide COW update to reduce usage of
> its region, and snapshot feature, right?
> 
> I found that docker seems to select one of them (or other feature which
> supports COW). Then user don't need to use thin-volume and reflink at same
> time.
> 
> Database which uses FS-DAX may want to use snapshot for its data of FS-DAX,
> its user seems to be satisfied with reflink or thin-volume.
> 
> So I could not find on what use-case user would like to use dm-thin-volume
> and reflink at same time.
> 
> The only possibility is that the user has mistakenly configured dm-thinpool
> and reflink to be used at the same time, but if that is the case, it seems
> to be better for the user to disable one or the other.
> 
> I really wander why dm-thin-volume must be used with reflik and FS-DAX.

There isn't a hard requirement between fsdax and dm-thinp.  The /test/
needs dm-logwrites to check that write page faults on a MAP_SYNC
mmapping are persisted directly to disk.  dm-logwrites requires a fast
way to zero an entire device for correct operation of the replay step,
and thinp is the only way to guarantee that.

--D

> If my understanding is something wrong, please correct me.
> 
> (*)https://lore.kernel.org/all/TYWPR01MB1008258F474CA2295B4CD3D9B90549@TYWPR01MB10082.jpnprd01.prod.outlook.com/
> 
> Thanks,
> ---
> Yasunori Goto
> 
> 
> > 
> > Best Regards,
> > Xiao Yang
> > 
> > On 2022/9/16 10:04, Yang, Xiao/杨 晓 wrote:
> > > On 2022/9/15 18:14, Yang, Xiao/杨 晓 wrote:
> > > > On 2022/9/15 0:28, Darrick J. Wong wrote:
> > > > > On Wed, Sep 14, 2022 at 08:34:26AM -0400, Brian Foster wrote:
> > > > > > On Wed, Sep 14, 2022 at 05:38:02PM +0800, Yang, Xiao/杨 晓 wrote:
> > > > > > > On 2022/9/14 14:44, Yang, Xiao/杨 晓 wrote:
> > > > > > > > On 2022/9/9 21:01, Brian Foster wrote:
> > > > > > > > > Yes.. I don't recall all the internals of
> > > > > > > > > the tools and test, but IIRC
> > > > > > > > > it relied on discard to perform zeroing
> > > > > > > > > between checkpoints or some such
> > > > > > > > > and avoid spurious failures. The purpose of running on dm-thin was
> > > > > > > > > merely to provide reliable discard zeroing
> > > > > > > > > behavior on the target device
> > > > > > > > > and thus to allow the test to run reliably.
> > > > > > > > Hi Brian,
> > > > > > > > 
> > > > > > > > As far as I know, generic/470 was original designed to verify
> > > > > > > > mmap(MAP_SYNC) on the dm-log-writes device enabling DAX. Due to the
> > > > > > > > reason, we need to ensure that all underlying devices under
> > > > > > > > dm-log-writes device support DAX. However
> > > > > > > > dm-thin device never supports
> > > > > > > > DAX so
> > > > > > > > running generic/470 with dm-thin device always returns "not run".
> > > > > > > > 
> > > > > > > > Please see the difference between old and new logic:
> > > > > > > > 
> > > > > > > >             old logic                          new logic
> > > > > > > > ---------------------------------------------------------------
> > > > > > > > log-writes device(DAX)                 log-writes device(DAX)
> > > > > > > >               |                                       |
> > > > > > > > PMEM0(DAX) + PMEM1(DAX)       Thin device(non-DAX) + PMEM1(DAX)
> > > > > > > >                                             |
> > > > > > > >                                           PMEM0(DAX)
> > > > > > > > ---------------------------------------------------------------
> > > > > > > > 
> > > > > > > > We think dm-thin device is not a good solution
> > > > > > > > for generic/470, is there
> > > > > > > > any other solution to support both discard zero and DAX?
> > > > > > > 
> > > > > > > Hi Brian,
> > > > > > > 
> > > > > > > I have sent a patch[1] to revert your fix because I
> > > > > > > think it's not good for
> > > > > > > generic/470 to use thin volume as my revert patch[1] describes:
> > > > > > > [1] https://lore.kernel.org/fstests/20220914090625.32207-1-yangx.jy@fujitsu.com/T/#u
> > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > > I think the history here is that generic/482 was changed over first in
> > > > > > commit 65cc9a235919 ("generic/482: use thin volume as
> > > > > > data device"), and
> > > > > > then sometime later we realized generic/455,457,470 had
> > > > > > the same general
> > > > > > flaw and were switched over. The dm/dax compatibility
> > > > > > thing was probably
> > > > > > just an oversight, but I am a little curious about that
> > > > > > because it should
> > > > > 
> > > > > It's not an oversight -- it used to work (albeit with EXPERIMENTAL
> > > > > tags), and now we've broken it on fsdax as the pmem/blockdev divorce
> > > > > progresses.
> > > > Hi
> > > > 
> > > > Do you mean that the following patch set changed the test result
> > > > of generic/470 with thin-volume? (pass => not run/failure)
> > > > https://lore.kernel.org/linux-xfs/20211129102203.2243509-1-hch@lst.de/
> > > > 
> > > > > 
> > > > > > have been obvious that the change caused the test to no
> > > > > > longer run. Did
> > > > > > something change after that to trigger that change in behavior?
> > > > > > 
> > > > > > > With the revert, generic/470 can always run
> > > > > > > successfully on my environment
> > > > > > > so I wonder how to reproduce the out-of-order replay issue on XFS v5
> > > > > > > filesystem?
> > > > > > > 
> > > > > > 
> > > > > > I don't quite recall the characteristics of the failures
> > > > > > beyond that we
> > > > > > were seeing spurious test failures with generic/482 that were due to
> > > > > > essentially putting the fs/log back in time in a way that wasn't quite
> > > > > > accurate due to the clearing by the logwrites tool not
> > > > > > taking place. If
> > > > > > you wanted to reproduce in order to revisit that, perhaps start with
> > > > > > generic/482 and let it run in a loop for a while and see if it
> > > > > > eventually triggers a failure/corruption..?
> > > > > > 
> > > > > > > PS: I want to reproduce the issue and try to find a
> > > > > > > better solution to fix
> > > > > > > it.
> > > > > > > 
> > > > > > 
> > > > > > It's been a while since I looked at any of this tooling
> > > > > > to semi-grok how
> > > > > > it works.
> > > > > 
> > > > > I /think/ this was the crux of the problem, back in 2019?
> > > > > https://lore.kernel.org/fstests/20190227061529.GF16436@dastard/
> > > > 
> > > > Agreed.
> > > > 
> > > > > 
> > > > > > Perhaps it could learn to rely on something more explicit like
> > > > > > zero range (instead of discard?) or fall back to manual zeroing?
> > > > > 
> > > > > AFAICT src/log-writes/ actually /can/ do zeroing, but (a) it probably
> > > > > ought to be adapted to call BLKZEROOUT and (b) in the worst case it
> > > > > writes zeroes to the entire device, which is/can be slow.
> > > > > 
> > > > > For a (crass) example, one of my cloudy test VMs uses 34GB partitions,
> > > > > and for cost optimization purposes we're only "paying" for the cheapest
> > > > > tier.  Weirdly that maps to an upper limit of 6500 write iops and
> > > > > 48MB/s(!) but that would take about 20 minutes to zero the entire
> > > > > device if the dm-thin hack wasn't in place.  Frustratingly, it doesn't
> > > > > support discard or write-zeroes.
> > > > 
> > > > Do you mean that discard zero(BLKDISCARD) is faster than both
> > > > fill zero(BLKZEROOUT) and write zero on user space?
> > > 
> > > Hi Darrick, Brian and Christoph
> > > 
> > > According to the discussion about generic/470. I wonder if it is
> > > necessary to make thin-pool support DAX. Is there any use case for
> > > the requirement?
> > > 
> > > Best Regards,
> > > Xiao Yang
> > > > 
> > > > Best Regards,
> > > > Xiao Yang
> > > > > 
> > > > > > If the
> > > > > > eventual solution is simple and low enough overhead, it
> > > > > > might make some
> > > > > > sense to replace the dmthin hack across the set of tests mentioned
> > > > > > above.
> > > > > 
> > > > > That said, for a *pmem* test you'd expect it to be faster than that...
> > > > > 
> > > > > --D
> > > > > 
> > > > > > Brian
> > > > > > 
> > > > > > > Best Regards,
> > > > > > > Xiao Yang
> > > > > > > 
> > > > > > > > 
> > > > > > > > BTW, only log-writes, stripe and linear support DAX for now.
> > > > > > > 
> > > > > > 
> 
