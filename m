Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288654D3951
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 19:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbiCIS6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 13:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbiCIS6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:58:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B096597
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 10:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=380l+Gu5qIiiXNX/ArbUGoUCh7yNUhAFRcWP2zrXEf4=; b=vG5NBLGQlonAUGXQ+V6WFpLZzZ
        F/H+zyPQgIw3L58tjvbZqOTSlL322PzxhXKS0XvXj34q+K9+R0xzt5VMQn6WJqLAzDj1crIUur0cn
        yfK95xYdRyhTXWAqjhxC52UEuWSFDaZ9tYDu3W+CTrx029fOiNvsgiuPivqxqN0TEUVtQvGIVYs5Z
        rYt8K9xuoFiq9/kdGA1aN4Er/lg8Trxp/Isp4inP78UNy+BBJf9okAjHC4Xw97tnFH3aHaRqHVd/H
        XqbnbKXQrRSQr0NeGWfuc3Atw+TbcS8cNcAR7D9nBpKKxoSXb8RlQWmMYhE2bxpJMvdzXv+d2eDnO
        TT4ebcBQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nS1Uy-00AA89-Ag; Wed, 09 Mar 2022 18:57:24 +0000
Date:   Wed, 9 Mar 2022 10:57:24 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <Yij4lD19KGloWPJw@bombadil.infradead.org>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <CAOQ4uxjjdFgdMxEOq7aW-nLZFf-S99CC93Ycg1CcMUBiRAYTQQ@mail.gmail.com>
 <YiepUS/bDKTNA5El@sashalap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiepUS/bDKTNA5El@sashalap>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 08, 2022 at 02:06:57PM -0500, Sasha Levin wrote:
> What we can't do is invest significant time into doing the testing work
> ourselves for each and every subsystem in the kernel.

I think this experience helps though, it gives you I think a better
appreciation for what concerns we have to merge any fix and the effort
and dilligence required to ensure we don't regress. I think the
kernel-ci steady state goal takes this a bit further.

> The testing rig I had is expensive, not even just time-wise but also
> w.r.t the compute resources it required to operate, I suspect that most
> of the bots that are running around won't dedicate that much resources
> to each filesystem on a voluntary basis.

Precicely because of the above is *why* one of *my* requirements for
building a kernel-ci system was to be able to ensure I can run my tests
regardless of what employer I am at, and easily ramp up. So I can use
local virtualized solutions (KVM or virtualbox), or *any* cloud solution
at will (AWS, GCE, Azure, OpenStack). And so kdevops enables all this
using the same commands I posted before, using simple make target
commands.

Perhaps the one area that might interest folks is the test setup,
using loopback drives and truncated files, if you find holes in
this please let me know:

https://github.com/mcgrof/kdevops/blob/master/docs/testing-with-loopback.md

In my experience this setup just finds *more* issues, rather than less,
and in my experience as well none of these issues found were bogus, they
always lead to real bugs:

https://github.com/mcgrof/kdevops/blob/master/docs/seeing-more-issues.md

A test rig for a high kernel-ci steady state goal does require
resources, time and effort. Fortunately I am now confident in the
architecture behind the tests / automation though. So all that is
really needed now is just a dedicated system to run these, agree what
configs we'd test (I have some well defined and documented for XFS on
kdevops through Kconfig, based on conversations we last had about stable
testing), work with a public baseline to reflect this setup (I have
public baselines already published for tons of kernels and for different
filesystems), and then test candidate fixes. This later effort is still
time consuming too. But with a proper ongoing rig running a kernel-ci,
this becomes much easier and it is a much smoother sailing process.

> I can comment on what I'm seeing with Google's COS distro: it's a
> chicken-and-egg problem. It's hard to offer commercial support with the
> current state of xfs, but on the other hand it's hard to improve the
> state of xfs without a commercial party that would invest more
> significant resources into it.

This is the non-Enterprise argument to it.

And yes. I agree, but it doesn't mean we can't resolve it. I think we
just need to agree to a a dedicated test rig, test setup, and a public
baseline might be a good next step.

> Luckily there is an individual in Google who has picked up this work and
> hopefully we will see something coming out of it very soon, but honestly
> - we just got lucky.

Groovy.

  Luis
