Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83D17A6D18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 23:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjISVrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 17:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjISVrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:47:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F9FB3;
        Tue, 19 Sep 2023 14:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=OfltgZCqgs8MKY2Ik0pJznlTGh3QDwezyPAsC9bskLQ=; b=xsrTNQVmaeNsIPIzTh1iJZjUz7
        KSqGhVEa2eNcD844y8hm2Z3XmYuAkDfXQWVQzeGLrJw557n4LSqw20j3ZrFmns8vy08xNfzVB0+Vi
        BkWPLTuncAFG9kaViqJsh8FZJakIObIs4wghKYHz7ivOO2WxkNCo/9uScME0+/lIsjZimhmX5TrUJ
        jByErSGcdhV5yKGRqn1zT6UcKmeo5rDg5hrLXhJ27G+5DCdio/JZkz/qbHlXImp5ElHChquGZRFgc
        pSLaR1CYouOPBcIKM5UA2zI4MOH3G4XtjbthpMoJLTFFdLyHcTeF21Ey4xH/3PZ1i9gpcoDu6qIOM
        ROzU472A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qiiYa-001JIQ-0d;
        Tue, 19 Sep 2023 21:46:56 +0000
Date:   Tue, 19 Sep 2023 14:46:56 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Daniel Gomez <da.gomez@samsung.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 6/6] shmem: add large folios support to the write path
Message-ID: <ZQoW0MVh/esJkU6H@bombadil.infradead.org>
References: <CGME20230915095133eucas1p267bade2888b7fcd2e1ea8e13e21c495f@eucas1p2.samsung.com>
 <20230915095042.1320180-1-da.gomez@samsung.com>
 <20230915095042.1320180-7-da.gomez@samsung.com>
 <CAJD7tkbU20tyGxtdL-cqJxrjf38ObG_dUttZdLstH3O2sUTKzw@mail.gmail.com>
 <20230918075758.vlufrhq22es2dhuu@sarkhan>
 <CAJD7tkZSST8Kc6duUWt6a9igrsn=ucUPSVPWWGDWEUxBs3b4bg@mail.gmail.com>
 <20230919132633.v2mvuaxp2w76zoed@sarkhan>
 <CAJD7tkaELyZXsUP+c=DKg9k-FeFTTRS+_9diK5fyTNdfDAykmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaELyZXsUP+c=DKg9k-FeFTTRS+_9diK5fyTNdfDAykmQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 09:00:16AM -0700, Yosry Ahmed wrote:
> On Tue, Sep 19, 2023 at 6:27 AM Daniel Gomez <da.gomez@samsung.com> wrote:
> >
> > On Mon, Sep 18, 2023 at 11:55:34AM -0700, Yosry Ahmed wrote:
> > > On Mon, Sep 18, 2023 at 1:00 AM Daniel Gomez <da.gomez@samsung.com> wrote:
> > > >
> > > > On Fri, Sep 15, 2023 at 11:26:37AM -0700, Yosry Ahmed wrote:
> > > > > On Fri, Sep 15, 2023 at 2:51 AM Daniel Gomez <da.gomez@samsung.com> wrote:
> > > > > >
> > > > > > Add large folio support for shmem write path matching the same high
> > > > > > order preference mechanism used for iomap buffered IO path as used in
> > > > > > __filemap_get_folio().
> > > > > >
> > > > > > Use the __folio_get_max_order to get a hint for the order of the folio
> > > > > > based on file size which takes care of the mapping requirements.
> > > > > >
> > > > > > Swap does not support high order folios for now, so make it order 0 in
> > > > > > case swap is enabled.
> > > > >
> > > > > I didn't take a close look at the series, but I am not sure I
> > > > > understand the rationale here. Reclaim will split high order shmem
> > > > > folios anyway, right?
> > > >
> > > > For context, this is part of the enablement of large block sizes (LBS)
> > > > effort [1][2][3], so the assumption here is that the kernel will
> > > > reclaim memory with the same (large) block sizes that were written to
> > > > the device.
> > > >
> > > > I'll add more context in the V2.
> > > >
> > > > [1] https://protect2.fireeye.com/v1/url?k=a80aab33-c981be05-a80b207c-000babff9b5d-b656d8860b04562f&q=1&e=46666acf-d70d-4e8d-8d00-b027808ae400&u=https%3A%2F%2Fkernelnewbies.org%2FKernelProjects%2Flarge-block-size
> > > > [2] https://protect2.fireeye.com/v1/url?k=3f753ca2-5efe2994-3f74b7ed-000babff9b5d-e678f885471555e3&q=1&e=46666acf-d70d-4e8d-8d00-b027808ae400&u=https%3A%2F%2Fdocs.google.com%2Fspreadsheets%2Fd%2Fe%2F2PACX-1vS7sQfw90S00l2rfOKm83Jlg0px8KxMQE4HHp_DKRGbAGcAV-xu6LITHBEc4xzVh9wLH6WM2lR0cZS8%2Fpubhtml%23
> > > > [3] https://lore.kernel.org/all/ZQfbHloBUpDh+zCg@dread.disaster.area/
> > > > >
> > > > > It seems like we only enable high order folios if the "noswap" mount
> > > > > option is used, which is fairly recent. I doubt it is widely used.
> > > >
> > > > For now, I skipped the swap path as it currently lacks support for
> > > > high order folios. But I'm currently looking into it as part of the LBS
> > > > effort (please check spreadsheet at [2] for that).
> > >
> > > Thanks for the context, but I am not sure I understand.
> > >
> > > IIUC we are skipping allocating large folios in shmem if swap is
> > > enabled in this patch. Swap does not support swapping out large folios
> > > as a whole (except THPs), but page reclaim will split those large
> > > folios and swap them out as order-0 pages anyway. So I am not sure I
> > > understand why we need to skip allocating large folios if swap is
> > > enabled.
> >
> > I lifted noswap condition and retested it again on top of 230918 and
> > there is some regression. So, based on the results I guess the initial
> > requirement may be the way to go. But what do you think?
> >
> > Here the logs:
> > * shmem-large-folios-swap: https://gitlab.com/-/snippets/3600360
> > * shmem-baseline-swap : https://gitlab.com/-/snippets/3600362
> >
> > -Failures: generic/080 generic/126 generic/193 generic/633 generic/689
> > -Failed 5 of 730 tests
> > \ No newline at end of file
> > +Failures: generic/080 generic/103 generic/126 generic/193 generic/285 generic/436 generic/619 generic/633 generic/689
> > +Failed 9 of 730 tests
> > \ No newline at end of file
> > >
> 
> I am not really familiar with these tests so I cannot really tell
> what's going on. I can see "swapfiles are not supported" in the logs
> though, so it seems like we are seeing extra failures by just lifting
> "noswap" even without actually swapping. I am curious if this is just
> hiding a different issue, I would at least try to understand what's
> happening.
> 
> Anyway, I don't have enough context here to be useful. I was just
> making an observation about reclaim splitting shmem folios to swap
> them out as order-0 pages, and asking why this is needed based on
> that. I will leave it up to you and the reviewers to decide if there's
> anything interesting here.

The tests which are failing seem be related to permissions, I could not
immediate decipher why, because as you suggest we'd just be doing the
silly thing of splitting large folios on writepage.

I'd prefer we don't require swap until those regressions would be fixed.

Note that part of the rationale to enable this work is to eventually
also extend swap code to support large order folios, so it is not like
this would be left as-is. It is just that it may take time to resolve
the kinks with swap.

So I'd stick to nowap for now.

The above tests also don't stress swap too, and if we do that I would
imagine we might see some other undesirable failures.

 Luis
