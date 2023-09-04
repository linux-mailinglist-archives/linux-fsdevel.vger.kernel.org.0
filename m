Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00116791065
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 05:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbjIDD10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Sep 2023 23:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjIDD1Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Sep 2023 23:27:25 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31863BF
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 Sep 2023 20:27:21 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-73.bstnma.fios.verizon.net [173.48.116.73])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3843QwSA015276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 3 Sep 2023 23:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1693798021; bh=rkbpgkYC4jb0fCkXOsy0wxyXQNhK/Ytcz9Jdb2AKGa4=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=m5/geuHtX6zIYvlw4QQeq3Hwr3/5EQEjCeLuobQX/JLKigD7+gU4k/ENkKy+P0G4u
         dvsi0mXvo6yAEMm9g1WO9D/huSK5TnY2eAkapw9OfYiFj49Gxev2c+A6Da6+e/Z31Q
         AkDSqA4WsTziMNG2VuuxMAR8k5cwlFGnO3TxODyTDqoO1AM/ky0GLIgw5lWU+YsZax
         9wOgUYzGcEW8dvy4KKpR3WKEFmtFEvQdxX/DjxyAOdPQEFdQwNf7vIWFHKw2NHV7PK
         UyIuGe5GnLbAIAgM3NkFmNhG0oFzJQJg2Eh5cLmIWtucbFMgLYA8Dlo2w6mug03yIf
         trVKcU6ObmdMg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4A22215C023F; Sun,  3 Sep 2023 23:26:58 -0400 (EDT)
Date:   Sun, 3 Sep 2023 23:26:58 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Mateusz Guzik <mjguzik@gmail.com>,
        syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>,
        brauner@kernel.org, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Subject: Re: [syzbot] [xfs?] INFO: task hung in __fdget_pos (4)
Message-ID: <20230904032658.GA701295@mit.edu>
References: <000000000000e6432a06046c96a5@google.com>
 <ZPQYyMBFmqrfqafL@dread.disaster.area>
 <20230903083357.75mq5l43gakuc2z7@f>
 <ZPUIQzsCSNlnBFHB@dread.disaster.area>
 <20230903231338.GN3390869@ZenIV>
 <ZPU2n48GoSRMBc7j@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPU2n48GoSRMBc7j@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 04, 2023 at 11:45:03AM +1000, Dave Chinner wrote:
> Entirely possible - this is syzbot we are talking about here.
> Especially if reiser or ntfs has been tested back before the logs we
> have start, as both are known to corrupt memory and/or leak locks
> when trying to parse corrupt filesystem images that syzbot feeds
> them.  That's why we largely ignore syzbot reports that involve
> those filesystems...
> 
> Unfortunately, the logs from what was being done around when the
> tasks actually hung are long gone (seems like only the last 20-30s
> of log activity is reported) so when the hung task timer goes off
> at 143s, there is nothing left to tell us what might have caused it.
> 
> IOWs, it's entirely possible that it is a memory corruption that
> has resulted in a leaked lock somewhere...

... and this is why I ignore any syzbot report that doesn't have a C
reproducer.  Life is too short to waste time with what is very likely
syzbot noise....  And I'd much rather opt out of the gamification of
syzbot dashboards designed to use dark patterns to guilt developers to
work on "issues" that very likely have no real impact on real life
actual user impact, if it might cause developers and maintainers to
burn out and quit.

Basically, if syzbot won't prioritize things for us, it's encumbent on
us to prioritize things for our own mental health.  And so syzbot
issues without a real reproducer are very low on my priority list; I
have things I can work on that are much more likely to make real world
impact.  Even ones that have a real reproducer, there are certain
classes of bugs (e.g., "locking bugs" that require a badly corrupted
file system, or things that are just denial of service attacks if
you're too stupid to insert a USB thumb drive found in a parking lock
--- made worse by GNOME who has decided to default mount any random
USB thumb drive inserted into a system, even a server system that has
GNOME installed, thanks to some idiotic decision made by some random
Red Hat product manager), that I just ignore because I don't have
infinite amounts of time to coddle stupid Red Hat distro tricks.

						- Ted
