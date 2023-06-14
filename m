Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FA372F2DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 04:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjFNC5t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 22:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjFNC5s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:57:48 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2189C10C2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 19:57:48 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-50-124.bstnma.fios.verizon.net [108.7.50.124])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35E2v7wg001107
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 22:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686711430; bh=o+siL7mO6d4HbHE/YemwrmObXrYPBI9d0hd+VStp+vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=BPHxycFdvuthb7BAAa6rdRy2cxRVrFcfu3BRddmQsFnwSU00KT67RXFUU+wMVAx2p
         DSVhH7+I7BK5Ut4d/+3DgBJknQuGkY6MSaLSi2qaqE97EOfaC97p08CTJC9FEi3D+R
         FCdDRmLYRmfHea96UfSNJgCLQHeszTkeqa1dsNyKp89lIhNU6PVoxv30QJY53W49c2
         62mOskBufI+VVmbDQd4VHJIOg0chOileNySp9VYKmWL0qb4Rdu+VKh9kfvZVaXZju/
         mvTqjH1b8Oxrhu7C3/2X2ulOH+yyrO/+cLRp67Q+l+ikL+z0XgRF5CwjYFBgk51/5D
         v3iUYM2v+O0wA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9871A15C00B0; Tue, 13 Jun 2023 22:57:07 -0400 (EDT)
Date:   Tue, 13 Jun 2023 22:57:07 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        yebin <yebin@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <20230614025707.GA48153@mit.edu>
References: <20230612161614.10302-1-jack@suse.cz>
 <CACT4Y+aEScXmq2F1-vqAfr-b2w-xyOohN+FZxorW1YuRvKDLNQ@mail.gmail.com>
 <20230614020412.GB11423@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614020412.GB11423@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 07:04:12PM -0700, Darrick J. Wong wrote:
> 
> Well in that case, post a patchset adding "depends on INSECURE" for
> every subsystem that syzbot files bugs against, if the maintainers do
> not immediately drop what they're doing to resolve the bug.
> 
> Google extracts a bunch more unpaid labor from society to make its
> owners richer, and everyone else on the planet suffers for it, just like
> you all have done for the past 25 years.  That's the definition of
> Googley!!

To be fair, I don't think this is the official position of Google, but
rather Dmitry's personal security ideology (as Dave put it).

Dmitry, tell you what.  If you can find a vice president inside Google
who thinks this that preventing an attacker who has the ability to
modify a block device while it is mounted, while running code under
the control of the attacker, from being to potentially trigger the
ability to run ring 0 code --- and who believes it enough to actually
**fund** a headcount to actually work these syzbot reports --- I'll
gladly help to supervise that person and mentor their ability to work
these ext4 syzbot reports.

But I think you will find that the VP's will believe that this is not
a threat that has a genuine business case which is important enough
that they are willing to fund it.  And I'm saying as an upstream
developer, *other* syzbot reports are higher priority, because in my
judgement, they are much more willing to impact real users, and are
more likely to be issues that management chain would consider higher
priority.  (Never mind that *all* of my syzbot work has been done on
my own time.)

For those of us who are working with limited resources, and doing this
work out of the kindness of our hearts, it would be nice to filter out
those syzbot reports that in our best judgement, constitute **noise**.
If there is not a good way to filter out the noise, it is likely that
upstream developers will choose to use their time working with other
tools that are better suited to getting our job done as we understand
it.

So far, there is been a lot work done by folks on your team which has
made syzbot easier for us to use, and for that, I thank you.  But your
position on forcing your ideology of which security bugs I should fix
on my own time is.... annoying.  And if others feel the same way, your
attitude is going to be counter-productive towards the goals you have
towards making Linux more secure.

Sometimes, the "best" is the enemy is the "good enough".  And in this
era of Google's "sharpened focus" or Facebook's "year of efficiency",
very often, "good enough" is all the vice presidents are willing to
fund.

Best regards,

						- Ted
