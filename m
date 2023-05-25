Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C33B7112EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 19:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjEYR4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 13:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjEYR4C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 13:56:02 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC07B6
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 10:56:00 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34PHtgrh030878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 13:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1685037345; bh=xiWCRO+UU+jaBwoKUVDyePVmv4vtmFED5UhSQvBOlJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=j+rOH9Ry/dKEMXDLWlftMUW2T+fBMFl8Q2xULoLYbWnuSATJk0rDxlndlB7d0OQcq
         KgRsIc5nM7dq7BjLjHNuHy6DO5SuYCNnMTq4uNIsPk78u4lAQpvII1n8M7XjJtIdQl
         XwTc66BjvzusK9yE6l5XZXsIxFW16cKcPe5GAPZvy3RqQgcmkdeK79XksyxE2u8zop
         lsQvkz0n0u9tERvEAnT83eL5txQmKcXnd2meo0PiHv544atdUaMx1TxryXkNA2A6wU
         7VLkYjc8QZActGoTSdP7nTMFZTvf5WCeysl6jG18fWZJFcJh3M8ykeZYbmE80mTVLP
         opUcMDr++KVJg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0D09615C02DC; Thu, 25 May 2023 13:55:42 -0400 (EDT)
Date:   Thu, 25 May 2023 13:55:42 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Pengfei Xu <pengfei.xu@intel.com>,
        Eric Sandeen <sandeen@sandeen.net>, dchinner@redhat.com,
        djwong@kernel.org, heng.su@intel.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, lkp@intel.com,
        Aleksandr Nogikh <nogikh@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [Syzkaller & bisect] There is "soft lockup in __cleanup_mnt" in
 v6.4-rc3 kernel
Message-ID: <20230525175542.GB821358@mit.edu>
References: <ZG7PGdRED5A68Jyh@xpf.sh.intel.com>
 <f723cb17-ca68-4db9-c296-cf33b16c529c@sandeen.net>
 <ZG71v9dlDm0h4idA@xpf.sh.intel.com>
 <ZG785SwJtvR4pO/6@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG785SwJtvR4pO/6@dread.disaster.area>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 04:15:01PM +1000, Dave Chinner wrote:
> Google's syzbot does this now, so your syzkaller bot should also be
> able to do it....
>
> Please go and talk to the syzkaller authors to find out how they
> extract filesystem images from the reproducer, and any other
> information they've also been asked to provide for triage
> purposes.

Pengfei,

What is it that your syzkaller instance doing that Google's upstream
syzkaller instance is not doing?  Google's syzkaller's team is been
very responsive at improving syzkaller's Web UI, including making it
easy to get artifacts from the syzkaller instance, requesting that
their bot to test a particular git tree or patch (since sometimes
reproducer doesn't easily reproduce on KVM, but easily reproduces in
their Google Cloud VM environment).

So if there is some unique feature which you've added to your syzbot
instances, maybe you can contribute that change upstream, so that
everyone can benefit?  From an upstream developer's perspective, it
also means that I can very easily take a look at the currently active
syzbot reports for a particular subsystem --- for example:

       https://syzkaller.appspot.com/upstream/s/ext4

... and I can see how often a particular syzbot issue reproduces, and
it makes it easier for me to prioritize which syzbot report I should
work on next.  If there is a discussion on a particular report, I can
get a link to that discussion on lore.kernel.org; and once a patch has
been submitted, there is an indication on the dashboard that there is
a PATCH associated with that particular report.

For example, take a look at this report:

	https://syzkaller.appspot.com/bug?extid=e44749b6ba4d0434cd47

... and look at the contents under the Discussion section; and then
open up the "Last patch testing requests" collapsible section.

These are some of the reasons why using Google's instance of syzkaller
is a huge value add --- and quite frankly, it means that I will
prioritize looking at syzkaller reports on the syzkaller.appspot.com
dashboard, where I can easily prioritize which reports are most useful
for me to look at next, over those that you and others might forward
from some company's private syzkaller instance.  It's just far more
productive for me as an upstream maintainer.

Bottom line, having various companies run their own private instances
of syzkaller is much less useful for the upstream community.  If Intel
feels that it's useful to run their own instance, maybe there's some
way you can work with Google syzkaller team so you don't have to do
that?

Are there some improvements to the syzkaller code base Intel would be
willing to contribute to the upstream syzkaller code base at
https://github.com/google/syzkaller?  Or is there some other reason
why Intel is running its own syzkaller instance?

Cheers,

						- Ted
