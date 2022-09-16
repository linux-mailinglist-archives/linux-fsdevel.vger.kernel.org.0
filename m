Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9495BB078
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 17:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiIPPn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 11:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiIPPnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:43:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB01B07C7;
        Fri, 16 Sep 2022 08:43:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3932DB81D5E;
        Fri, 16 Sep 2022 15:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8EAC433D6;
        Fri, 16 Sep 2022 15:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663343013;
        bh=YNSjP/LiCCx3Suc7zoGweqKnIGX37rmyAojFu4j9Jpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pveEJvBs5oLqN97djCT3lNEcGo8sygvspthc3T6FPX2c2JBTSgbmWcnPOA0T1UIMC
         2oLag7mwCeBb4PdOrgGOaDexLa5ClhsPeLFvUUGzXxsDv3ij8xkOwPa0I6wrOpJakE
         WT/WjagmVY+3qiWPEOlUXrqc6z+f5hRbc0ZnVPASXv7+Gu2tjB8aiq7hCNaFe94TqD
         WtGSJVDLPk5h025tMLlKPQRiqMqZUtqLNPAShKqCqxbbeUoT/0V/H6Pv8PJvbG/rQ+
         cXsNbBYF0XOwGDG3hD1rNhuuGjGl9Z6QyjWZt1hjzXBf58O5Oo0Sb7SnoOO9D18Mcx
         dTkz/XIdsFrwg==
Date:   Fri, 16 Sep 2022 08:43:33 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, jane.chu@oracle.com
Subject: Re: [PATCH v8 0/3] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Message-ID: <YySZpaX6NU6aSdke@magnolia>
References: <9e9521a4-6e07-e226-2814-b78a2451656b@fujitsu.com>
 <1662114961-66-1-git-send-email-ruansy.fnst@fujitsu.com>
 <bf68da75-5b05-5376-c306-24f9d2b92e80@fujitsu.com>
 <YyIY0+8AzTIDKMVy@magnolia>
 <YyIaVZ36biogzQU3@magnolia>
 <d3b5ce9e-dcdf-26b1-cdea-712d7e1be1f6@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3b5ce9e-dcdf-26b1-cdea-712d7e1be1f6@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 15, 2022 at 10:56:09AM +0800, Shiyang Ruan wrote:
> 
> 
> 在 2022/9/15 2:15, Darrick J. Wong 写道:
> > On Wed, Sep 14, 2022 at 11:09:23AM -0700, Darrick J. Wong wrote:
> > > On Wed, Sep 07, 2022 at 05:46:00PM +0800, Shiyang Ruan wrote:
> > > > ping
> > > > 
> > > > 在 2022/9/2 18:35, Shiyang Ruan 写道:
> > > > > Changes since v7:
> > > > >     1. Add P1 to fix calculation mistake
> > > > >     2. Add P2 to move drop_pagecache_sb() to super.c for xfs to use
> > > > >     3. P3: Add invalidate all mappings after sync.
> > > > >     4. P3: Set offset&len to be start&length of device when it is to be removed.
> > > > >     5. Rebase on 6.0-rc3 + Darrick's patch[1] + Dan's patch[2].
> > > > > 
> > > > > Changes since v6:
> > > > >     1. Rebase on 6.0-rc2 and Darrick's patch[1].
> > > > > 
> > > > > [1]: https://lore.kernel.org/linux-xfs/Yv5wIa2crHioYeRr@magnolia/
> > > > > [2]: https://lore.kernel.org/linux-xfs/166153426798.2758201.15108211981034512993.stgit@dwillia2-xfh.jf.intel.com/
> > > 
> > > Just out of curiosity, is it your (or djbw's) intent to send all these
> > > as bugfixes for 6.0 via akpm like all the other dax fixen?
> > 
> > Aha, this is 6.1 stuff, please ignore this question.
> 
> Actually I hope these patches can be merged ASAP. (But it seems a bit late
> for 6.0 now.)
> 
> And do you know which/whose branch has picked up your patch[1]?  I cannot
> find it.

It's not upstream, though the maintainer (Dave currently) reviewed it.
I don't know if he hasn't had time to put together a fixes branch or if
he's simply punting all the queued up stuff to 6.1.

(Dave?)

--D

> 
> --
> Thanks,
> Ruan.
> 
> > 
> > --D
> > 
> > > --D
> > > 
> > > > > 
> > > > > Shiyang Ruan (3):
> > > > >     xfs: fix the calculation of length and end
> > > > >     fs: move drop_pagecache_sb() for others to use
> > > > >     mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
> > > > > 
> > > > >    drivers/dax/super.c         |  3 ++-
> > > > >    fs/drop_caches.c            | 33 ---------------------------------
> > > > >    fs/super.c                  | 34 ++++++++++++++++++++++++++++++++++
> > > > >    fs/xfs/xfs_notify_failure.c | 31 +++++++++++++++++++++++++++----
> > > > >    include/linux/fs.h          |  1 +
> > > > >    include/linux/mm.h          |  1 +
> > > > >    6 files changed, 65 insertions(+), 38 deletions(-)
> > > > > 
