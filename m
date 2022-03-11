Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D7B4D611D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 13:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348423AbiCKMB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 07:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239962AbiCKMB4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:01:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB301AA4A2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Mar 2022 04:00:53 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BAE8821122;
        Fri, 11 Mar 2022 12:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647000051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LBM7PKTQzVngD0p/atQ+nUkUST2YqDMLYQkw77rN+Fc=;
        b=FtySAEVrjRdKGovyjK/Ka+PwOMGAHzEcRIY54V634elUZUH+z56FBvyhveOmKaugNCVKBO
        aSEEOWAim2zzgaFiWOAjcA7LlcEOxWuhakqvw0cCiqgSTSpwSlyMl/BhFa+qgk+vu5cSVY
        fvwQOLoy8o1qJUoS9dAU4jV1f3Xcm9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647000051;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LBM7PKTQzVngD0p/atQ+nUkUST2YqDMLYQkw77rN+Fc=;
        b=kVYDgIutpHclV0WeDP4qhErH09nxVSZ4qvrbhH8aCDq1TJ6eBPf4+E4Yl7IvAesqUGlq4z
        onRGfDk+yLEJXaBw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A0175A3B93;
        Fri, 11 Mar 2022 12:00:51 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 540C8A0611; Fri, 11 Mar 2022 13:00:51 +0100 (CET)
Date:   Fri, 11 Mar 2022 13:00:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <20220311120051.fa4yhyw3vwghgxgx@quack3.lan>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <CAOQ4uxjjdFgdMxEOq7aW-nLZFf-S99CC93Ycg1CcMUBiRAYTQQ@mail.gmail.com>
 <YiepUS/bDKTNA5El@sashalap>
 <Yij4lD19KGloWPJw@bombadil.infradead.org>
 <Yirc69JyH5N/pXKJ@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yirc69JyH5N/pXKJ@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 11-03-22 00:23:55, Theodore Ts'o wrote:
> On Wed, Mar 09, 2022 at 10:57:24AM -0800, Luis Chamberlain wrote:
> > On Tue, Mar 08, 2022 at 02:06:57PM -0500, Sasha Levin wrote:
> > > What we can't do is invest significant time into doing the testing work
> > > ourselves for each and every subsystem in the kernel.
> > 
> > I think this experience helps though, it gives you I think a better
> > appreciation for what concerns we have to merge any fix and the effort
> > and dilligence required to ensure we don't regress. I think the
> > kernel-ci steady state goal takes this a bit further.
> 
> Different communities seem to have different goals that they believe
> the stable kernels should be aiming for.  Sure, if you never merge any
> fix, you can guarantee that there will be no regressions.  However,
> the question is whether the result is a better quality kernel.  For
> example, there is a recent change to XFS which fixes a security bug
> which allows an attacker to gain access to deleted data.  How do you
> balance the tradeoff of "no regressions, ever", versus, "we'll leave a
> security bug in XFS which is fixed in mainline linux, but we fear
> regressions so much that we won't even backport a single-line fix to
> the stable kernel?"
> 
> In my view, the service which Greg, Sasha and the other stable
> maintainers provide is super-valuable, and I am happy that ext4
> changes are automatically cherry-picked into the stable kernel.  Have
> there been times when this has resulted in regressions in ext4 for the
> stable kernel?  Sure!  It's only been a handful of a times, though,
> and the number of bug fixes that users using stable kernels have _not_
> seen *far* outweighs the downsides of the occasional regressions
> (which gets found and then reverted).

Yes, I completely agree it is tradeoff between how many fixes you backport
and the risk of regressions. As I wrote distro people (like RHEL or SLES)
have infrastructure and do backport sizable chunk of fixes flowing into
stable kernels anyway but we leave out some for which we deem the ratio fix
value / regression risk is bad for us. Also testing for distro people is
somewhat more difficult because we don't have the comfort of testing on the
HW & various combinations of setup and workload the customer is going to
use. So we do some testing on our HW, default configs, and common workloads
and put more effort into patch selection & review to reduce chances of
regressions on customers' systems. Overall, the tradeoff simply works out a
bit differently for distro people than say for Android and I don't think
there's a silver bullet for all...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
