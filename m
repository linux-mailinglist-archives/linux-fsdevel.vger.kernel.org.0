Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5FE7A6CCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 23:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjISVPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 17:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjISVPp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:15:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1E8A9;
        Tue, 19 Sep 2023 14:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SoWGV/vSjH+QSAal7RVjoWtaY6GPfVPJsY2HI1Po9NA=; b=boUnKA/KWwv2o53fF2DYhZzJHW
        0f6aI76KTdV20mN53VyMRh3dCbFxTwr5RHi976RJMoVrluOyoyaeMvRTSJaeOHQSVqHO3fxsGIBr/
        ae5hxtKmlTSk/1427oc6gFk5U0uNbFKfMJ322QqhXWMf0tyLUqnjCWzHa0jHypGgOnnmRlMMP2MW9
        7672V8UtKVY6hCn5dhC+ysO2QHjqCfubvuMFx0QIs+0jI3mlwRBjtis0socm0RWiXpXtNjW2RlqqI
        jqCi7+sEIjUq/xl4R2sLRm2BBcpy5rJ9rycLkFNSliv0s4fkNvpbB1+AbkLPNydAD8xvPMlGLvWO6
        hoMXSL8w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qii4E-001HO9-1Y;
        Tue, 19 Sep 2023 21:15:34 +0000
Date:   Tue, 19 Sep 2023 14:15:34 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        Dave Chinner <david@fromorbit.com>,
        Pankaj Raghav <kernel@pankajraghav.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        da.gomez@samsung.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        gost.dev@samsung.com, riteshh@linux.ibm.com
Subject: Re: [RFC 00/23] Enable block size > page size in XFS
Message-ID: <ZQoPdiT1wbPZyRg1@bombadil.infradead.org>
References: <806df723-78cf-c7eb-66a6-1442c02126b3@samsung.com>
 <87a5ti74w3.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5ti74w3.fsf@doe.com>
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

On Tue, Sep 19, 2023 at 05:26:44PM +0530, Ritesh Harjani wrote:
> Pankaj Raghav <p.raghav@samsung.com> writes:
> 
> >>>>
> >>>> As it is, I'd really prefer stuff that adds significant XFS
> >>>> functionality that we need to test to be based on a current Linus
> >>>> TOT kernel so that we can test it without being impacted by all
> >>>> the random unrelated breakages that regularly happen in linux-next
> >>>> kernels....
> >>>
> >>> That's understandable! I just rebased onto Linus' tree, this only
> >>> has the bs > ps support on 4k sector size:
> >>>
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=v6.6-rc2-lbs-nobdev
> >> 
> >
> > I think this tree doesn't have some of the last minute changes I did before I sent the RFC. I will
> > sync with Luis offline regarding that.
> >
> >> 
> >>> I just did a cursory build / boot / fsx with 16k block size / 4k sector size
> >>> test with this tree only. I havne't ran fstests on it.
> >> 
> >> W/ 64k block size, generic/042 fails (maybe just a test block size
> >> thing), generic/091 fails (data corruption on read after ~70 ops)
> >> and then generic/095 hung with a crash in iomap_readpage_iter()
> >> during readahead.
> >> 
> >> Looks like a null folio was passed to ifs_alloc(), which implies the
> >> iomap_readpage_ctx didn't have a folio attached to it. Something
> >> isn't working properly in the readahead code, which would also
> >> explain the quick fsx failure...
> >> 
> >
> > Yeah, I have noticed this as well. This is the main crash scenario I am noticing
> > when I am running xfstests, and hopefully we will be able to fix it soon.
> >
> > In general, we have had better results with 16k block size than 64k block size. I still don't
> > know why, but the ifs_alloc crash happens in generic/451 with 16k block size.
> >
> >
> >>> Just a heads up, using 512 byte sector size will fail for now, it's a
> >>> regression we have to fix. Likewise using block sizes 1k, 2k will also
> >>> regress on fsx right now. These are regressions we are aware of but
> >>> haven't had time yet to bisect / fix.
> >> 
> >> I'm betting that the recently added sub-folio dirty tracking code
> >> got broken by this patchset....
> >> 
> >
> > Hmm, this crossed my mind as well. I am assuming I can really test the sub-folio dirty
> > tracking code on a system which has a page size greater than the block size? Or is there
> > some tests that can already test this? CCing Ritesh as well.
> >
> 
> Sorry I haven't yet looked into this series yet. I will spend sometime
> reading it. Will also give a spin to run the fstests.

Ritesh,

You can save yourself time in not testing the patch series with fstests
for block sizes below ps as we already are aware that a patch in the
series breaks this. We just wanted to get the patch series out early for
review given the progress. There's probably one patch which regresses
this, if each patch regresses this, that's a bigger issue :P

  Luis
