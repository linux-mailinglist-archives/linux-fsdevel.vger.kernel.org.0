Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D094E7E72
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 02:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiCZBnX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 21:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiCZBnW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 21:43:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6A12DC0;
        Fri, 25 Mar 2022 18:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96F0361917;
        Sat, 26 Mar 2022 01:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6BAC004DD;
        Sat, 26 Mar 2022 01:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648258906;
        bh=jGW6PmBImEhptd1gLKtaCQuGjGNEySz4ZTmfr35uDDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOoSOxA7eJ5a2mSatazhUFrvSoihLmhSyReNqGit9f/GcWRVva/v1hsFislZCcvHm
         tuYJnVgbexMaxODUx+v+5uweMEVu2bZDL2gP037u7297bkqVtGEY7SabVtrIhWlnid
         g8MrsWm0ZrMlp2k1DIYsQZDSbRWurNMLwe3+mvJwV5eQ3tiDi0DRweNgkX8iTLf9f2
         J7IQ+QpAjHVU+p8o5EoiZGj/lKd5yG/BznDQ//S7FRNEblI19fOZrlgVMT9lwsf0pw
         LDCsP2DwPAYQL0bc2HrPafUGlnLySv6lO7dhqiUEPOybIWjg5fZHOrfzANR9YGSZTs
         Z0cPEpuIq7hAg==
Date:   Fri, 25 Mar 2022 18:41:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] fs/iomap: Fix buffered write page prefaulting
Message-ID: <20220326014145.GE8182@magnolia>
References: <20220325143701.144731-1-agruenba@redhat.com>
 <20220326000337.GD8182@magnolia>
 <CAHc6FU6ys6gQjqpT-p0b+9pRzQPGemvviAMJNgBvmXaM27k7jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU6ys6gQjqpT-p0b+9pRzQPGemvviAMJNgBvmXaM27k7jA@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 26, 2022 at 01:22:17AM +0100, Andreas Gruenbacher wrote:
> On Sat, Mar 26, 2022 at 1:03 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > On Fri, Mar 25, 2022 at 03:37:01PM +0100, Andreas Gruenbacher wrote:
> > > Hello Linus,
> > >
> > > please consider pulling the following fix, which I've forgotten to send
> > > in the previous merge window.  I've only improved the patch description
> > > since.
> > >
> > > Thank you very much,
> > > Andreas
> > >
> > > The following changes since commit 42eb8fdac2fc5d62392dcfcf0253753e821a97b0:
> > >
> > >   Merge tag 'gfs2-v5.16-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2021-11-17 15:55:07 -0800)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/write-page-prefaulting
> > >
> > > for you to fetch changes up to 631f871f071746789e9242e514ab0f49067fa97a:
> > >
> > >   fs/iomap: Fix buffered write page prefaulting (2022-03-25 15:14:03 +0100)
> >
> > When was this sent to fsdevel for public consideration?  The last time I
> > saw any patches related to prefaulting in iomap was November.
> 
> On November 23, exact same patch:
> 
> https://lore.kernel.org/linux-fsdevel/20211123151812.361624-1-agruenba@redhat.com/

Ah, ok, so I just missed it then.  Sorry about that, I seem to suck as
maintainer more and more by the day. :( :(

(Hey, at least you got the other maintainer to RVB it...)

--D

> Andreas
> 
