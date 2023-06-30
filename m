Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD546743E7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 17:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjF3PS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 11:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjF3PSH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:18:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806AA4481;
        Fri, 30 Jun 2023 08:17:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B2F861782;
        Fri, 30 Jun 2023 15:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C26AC433C0;
        Fri, 30 Jun 2023 15:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688138218;
        bh=qe0xHIkPct8RIYm3UcNCeaQ58UYIh6kE56YDl8eC1Og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BxQh7oQzoJhXiPMbjEKynnEptPn9WIEBf9QA+AnsIlsxCOJ+I66FAZvGRSsal+rIf
         n+CrtWzjeDwcTVuGLgl/3e7025zwoi98yERxVKJXF/8DNM5uhahg82aICpME1036s2
         EnXPNsHE+dCoM/VwiWLC60S3S5wn5cgume3YqUpd1pICPc04aqIjELd4ItDJJPOfD9
         H2gyJ4YNwEc5NvE4uvB/feXcFYV5wrGccrEeecEYEPCUYQDfULwqCJ3jPzfqNhoA8H
         5JhZN9Dwu4WLEdwLHdS9axtXZ8eq438MlGweaCGf+kRzUiF+rViKx/+DF32lp9milg
         r73bA3lnH+qQw==
Date:   Fri, 30 Jun 2023 08:16:57 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ignat Korchagin <ignat@cloudflare.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Dao <dqminh@cloudflare.com>,
        Dave Chinner <david@fromorbit.com>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-fsdevel@vger.kernel.org,
        Chandan Babu R <chandanrlinux@gmail.com>,
        Leah Rumancik <lrumancik@google.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: Backporting of series xfs/iomap: fix data corruption due to
 stale cached iomap
Message-ID: <20230630151657.GJ11441@frogsfrogsfrogs>
References: <CA+wXwBRdcjHW2zxDABdFU3c26mc1u+g6iWG7HrXJRL7Po3Qp0w@mail.gmail.com>
 <ZJ2yeJR5TB4AyQIn@casper.infradead.org>
 <20230629181408.GM11467@frogsfrogsfrogs>
 <CALrw=nFwbp06M7LB_Z0eFVPe29uFFUxAhKQ841GSDMtjP-JdXA@mail.gmail.com>
 <CAOQ4uxiD6a9GmKwagRpUWBPRWCczB52Tsu5m6_igDzTQSLcs0w@mail.gmail.com>
 <CALrw=nHH2u=+utzy8NfP6+fM6kOgtW0hdUHwK9-BWdYq+t-UoA@mail.gmail.com>
 <CAOQ4uxju10zrQhVDA5WS+vTSbuW17vOD6EGBBJUmZg8c95vsrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxju10zrQhVDA5WS+vTSbuW17vOD6EGBBJUmZg8c95vsrA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 30, 2023 at 04:05:36PM +0300, Amir Goldstein wrote:
> On Fri, Jun 30, 2023 at 3:30 PM Ignat Korchagin <ignat@cloudflare.com> wrote:
> >
> > On Fri, Jun 30, 2023 at 11:39 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Thu, Jun 29, 2023 at 10:31 PM Ignat Korchagin <ignat@cloudflare.com> wrote:
> > > >
> > > > On Thu, Jun 29, 2023 at 7:14 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > >
> > > > > [add the xfs lts maintainers]
> > > > >
> > > > > On Thu, Jun 29, 2023 at 05:34:00PM +0100, Matthew Wilcox wrote:
> > > > > > On Thu, Jun 29, 2023 at 05:09:41PM +0100, Daniel Dao wrote:
> > > > > > > Hi Dave and Derrick,
> > > > > > >
> > > > > > > We are tracking down some corruptions on xfs for our rocksdb workload,
> > > > > > > running on kernel 6.1.25. The corruptions were
> > > > > > > detected by rocksdb block checksum. The workload seems to share some
> > > > > > > similarities
> > > > > > > with the multi-threaded write workload described in
> > > > > > > https://lore.kernel.org/linux-fsdevel/20221129001632.GX3600936@dread.disaster.area/
> > > > > > >
> > > > > > > Can we backport the patch series to stable since it seemed to fix data
> > > > > > > corruptions ?
> > > > > >
> > > > > > For clarity, are you asking for permission or advice about doing this
> > > > > > yourself, or are you asking somebody else to do the backport for you?
> > > > >
> > > > > Nobody's officially committed to backporting and testing patches for
> > > > > 6.1; are you (Cloudflare) volunteering?
> > > >
> > > > Yes, we have applied them on top of 6.1.36, will be gradually
> > > > releasing to our servers and will report back if we see the issues go
> > > > away
> > > >
> > >
> > > Getting feedback back from Cloudflare production servers is awesome
> > > but it's not enough.
> > >
> > > The standard for getting xfs LTS backports approved is:
> > > 1. Test the backports against regressions with several rounds of fstests
> > >     check -g auto on selected xfs configurations [1]
> > > 2. Post the backport series to xfs list and get an ACK from upstream
> > >     xfs maintainers
> > >
> > > We have volunteers doing this work for 5.4.y, 5.10.y and 5.15.y.
> > > We do not yet have a volunteer to do that work for 6.1.y.
> > >
> > > The question is whether you (or your team) are volunteering to
> > > do that work for 6.1.y xfs backports to help share the load?
> >
> > We are not a big team and apart from other internal project work our
> > efforts are focused on fixing this issue in production, because it
> > affects many teams and workloads. If we confirm that these patches fix
> > the issue in production, we will definitely consider dedicating some
> > work to ensure they are officially backported. But if not - we would
> > be required to search for a fix first before we can commit to any
> > work.
> >
> > So, IOW - can we come back to you a bit later on this after we get the
> > feedback from production?
> >
> 
> Of course.
> The volunteering question for 6.1.y is independent.
> 
> When you decide that you have a series of backports
> that proves to fix a real bug in production,
> a way to test the series will be worked out.

/me notes that xfs/558 and xfs/559 (in fstests) are the functional tests
for these patches that you're backporting; it would be useful to have a
third party (i.e. not just the reporter and the author) confirm that the
two fstests pass when real workloads are fixed.

--D

> Thanks,
> Amir.
