Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB235B884C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 14:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiINMem (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 08:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiINMeg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87839DF3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 05:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663158872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0WuM4/y8wFci5Yb9BetZR1iZBMrvylQvcf2F8aOMYug=;
        b=PG+VxQZ4qmaBwKFAThufYz8hGowxNj4H98LnzhNebHEy23vKIi/QkJszVj++euEBBxGKJx
        Zn/0eM6iug97VQ05X6Gr3rsQwgryZw8Jx3cSVAdE9+uj5kWkuUfEqDUMRyVhDAu5f48QmY
        OWvvh4cwYS/BQ6/Z2NkFz3kQp/hGLeU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-b3yoS3bUNrSm2oZRTUtJqA-1; Wed, 14 Sep 2022 08:34:31 -0400
X-MC-Unique: b3yoS3bUNrSm2oZRTUtJqA-1
Received: by mail-qv1-f72.google.com with SMTP id n15-20020ad444af000000b004a2a341ad71so10309828qvt.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 05:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0WuM4/y8wFci5Yb9BetZR1iZBMrvylQvcf2F8aOMYug=;
        b=ltfa3eaZAlZfz6YsLD9vQeTTAFAoAx494vDw/MEF2T4H4sEt/qjzwMVg5MMg/GNJLu
         KKYgLx7g+9eHrkVYUDJgJzfJEsa9uW95SxR/sDjzikX2slu+XBiifAXk282h/LKN4LAm
         v84VZf76otEdIR/ZT4AwfuCHEiBYTnL9a4F5hWWX1srdzxdZIPF7CM8Td7Ibq+gEHYp2
         V1C5+1DFui2SuHNfl0rHVnyR4E47Jvicya2HmYyJGjPXhbQ6bmBzfDJ5RAfwuaFg2eLT
         JvaaS1dpGRd6uDtcQs+djfCRwnleD9gqCfrK/8B2tZNOulypL5/brqdZt+iXq5Yupkyk
         tM6w==
X-Gm-Message-State: ACgBeo0rIhGZmUb8f+HVOZN6MEwquOOCYHY5UB3T1bIy/zJwt7x0Xm2F
        Tj59C5fOt0c3ijhI3hZRPoU3u4cN+VM86Sc6s2/9ZksygCBZDSAx74OdfNs/+XLRPr3SMqrffPR
        WVrMFlCSbZuLMpcXqWusSq5tpOQ==
X-Received: by 2002:ae9:ef4f:0:b0:6cb:d294:3333 with SMTP id d76-20020ae9ef4f000000b006cbd2943333mr21462389qkg.511.1663158871079;
        Wed, 14 Sep 2022 05:34:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7+6bExWI+uWylwesVJstucAaJ7UtNHMvbmYB8afATxXLCYgE2pRAXKONekZ9BBOAOgRjMg6g==
X-Received: by 2002:ae9:ef4f:0:b0:6cb:d294:3333 with SMTP id d76-20020ae9ef4f000000b006cbd2943333mr21462371qkg.511.1663158870858;
        Wed, 14 Sep 2022 05:34:30 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id b3-20020a05620a118300b006b8f4ade2c9sm1650081qkk.19.2022.09.14.05.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 05:34:29 -0700 (PDT)
Date:   Wed, 14 Sep 2022 08:34:26 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     =?utf-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
Cc:     =?utf-8?B?UnVhbiwgU2hpeWFuZy/pmK4g5LiW6Ziz?= 
        <ruansy.fnst@fujitsu.com>, "Darrick J. Wong" <djwong@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Message-ID: <YyHKUhOgHdTKPQXL@bfoster>
References: <74b0a034-8c77-5136-3fbd-4affb841edcb@fujitsu.com>
 <Ytl7yJJL1fdC006S@magnolia>
 <7fde89dc-2e8f-967b-d342-eb334e80255c@fujitsu.com>
 <YuNn9NkUFofmrXRG@magnolia>
 <0ea1cbe1-79d7-c22b-58bf-5860a961b680@fujitsu.com>
 <YusYDMXLYxzqMENY@magnolia>
 <dd363bd8-2dbd-5d9c-0406-380b60c5f510@fujitsu.com>
 <Yxs5Jb7Yt2c6R6eW@bfoster>
 <7fdc9e88-f255-6edb-7964-a5a82e9b1292@fujitsu.com>
 <76ea04b4-bad7-8cb3-d2c6-4ad49def4e05@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76ea04b4-bad7-8cb3-d2c6-4ad49def4e05@fujitsu.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 14, 2022 at 05:38:02PM +0800, Yang, Xiao/杨 晓 wrote:
> On 2022/9/14 14:44, Yang, Xiao/杨 晓 wrote:
> > On 2022/9/9 21:01, Brian Foster wrote:
> > > Yes.. I don't recall all the internals of the tools and test, but IIRC
> > > it relied on discard to perform zeroing between checkpoints or some such
> > > and avoid spurious failures. The purpose of running on dm-thin was
> > > merely to provide reliable discard zeroing behavior on the target device
> > > and thus to allow the test to run reliably.
> > Hi Brian,
> > 
> > As far as I know, generic/470 was original designed to verify
> > mmap(MAP_SYNC) on the dm-log-writes device enabling DAX. Due to the
> > reason, we need to ensure that all underlying devices under
> > dm-log-writes device support DAX. However dm-thin device never supports
> > DAX so
> > running generic/470 with dm-thin device always returns "not run".
> > 
> > Please see the difference between old and new logic:
> > 
> >            old logic                          new logic
> > ---------------------------------------------------------------
> > log-writes device(DAX)                 log-writes device(DAX)
> >              |                                       |
> > PMEM0(DAX) + PMEM1(DAX)       Thin device(non-DAX) + PMEM1(DAX)
> >                                            |
> >                                          PMEM0(DAX)
> > ---------------------------------------------------------------
> > 
> > We think dm-thin device is not a good solution for generic/470, is there
> > any other solution to support both discard zero and DAX?
> 
> Hi Brian,
> 
> I have sent a patch[1] to revert your fix because I think it's not good for
> generic/470 to use thin volume as my revert patch[1] describes:
> [1] https://lore.kernel.org/fstests/20220914090625.32207-1-yangx.jy@fujitsu.com/T/#u
> 

I think the history here is that generic/482 was changed over first in
commit 65cc9a235919 ("generic/482: use thin volume as data device"), and
then sometime later we realized generic/455,457,470 had the same general
flaw and were switched over. The dm/dax compatibility thing was probably
just an oversight, but I am a little curious about that because it should
have been obvious that the change caused the test to no longer run. Did
something change after that to trigger that change in behavior?

> With the revert, generic/470 can always run successfully on my environment
> so I wonder how to reproduce the out-of-order replay issue on XFS v5
> filesystem?
> 

I don't quite recall the characteristics of the failures beyond that we
were seeing spurious test failures with generic/482 that were due to
essentially putting the fs/log back in time in a way that wasn't quite
accurate due to the clearing by the logwrites tool not taking place. If
you wanted to reproduce in order to revisit that, perhaps start with
generic/482 and let it run in a loop for a while and see if it
eventually triggers a failure/corruption..?

> PS: I want to reproduce the issue and try to find a better solution to fix
> it.
> 

It's been a while since I looked at any of this tooling to semi-grok how
it works. Perhaps it could learn to rely on something more explicit like
zero range (instead of discard?) or fall back to manual zeroing? If the
eventual solution is simple and low enough overhead, it might make some
sense to replace the dmthin hack across the set of tests mentioned
above.

Brian

> Best Regards,
> Xiao Yang
> 
> > 
> > BTW, only log-writes, stripe and linear support DAX for now.
> 

