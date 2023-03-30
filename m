Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6656D0B7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 18:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjC3QkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 12:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjC3QkO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:40:14 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BBECA1D
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:40:12 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32UGdrd0012965
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 12:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1680194396; bh=TmdJ3Ctrw4/ojcylHzQYk755j2Wu/hluUv3wA77EZeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Ktq6V9tWe4TqDMX/MinQwxFA/NtZclG17xxuHpfi1pV2vaBcvI08BNGEyu/KQuq+L
         yNAPMYYbTN/H7dlRySKeY6mtuPc5eD7Pa/6MXcodw5r3FfNvkQ7mr8BwNiguWyLZ2C
         zUzudu/rQnINub7+buvnhozkJys+ZrcUhkETjEU3A1zAxrTcZJWeoToh2GDbtwVuUL
         xm9RRrvZEtukgbDGsFISNUIhYfV/A7VCwWTftD4hxCgaZ6TrgSHaiSX0Y/Km/B/it2
         SHy1Owj4nr41+8Iek2AK6hrqkFSKGsf1k7UUAh/kqArmsZ7ndsJoAvpPgGGlMy/qRS
         uiM3CJcIdvHqw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C341015C4930; Thu, 30 Mar 2023 12:39:53 -0400 (EDT)
Date:   Thu, 30 Mar 2023 12:39:53 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        syzbot <syzbot+0c383e46e9b4827b01b1@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] WARNING in xfs_bmap_extents_to_btree
Message-ID: <20230330163953.GB629182@mit.edu>
References: <0000000000003da76805f8021fb5@google.com>
 <20230330012750.GF3223426@dread.disaster.area>
 <CANp29Y6XNE_wxx1Osa+RrfqOUP9PZhScGnMUDgQ-qqHzYe9KFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANp29Y6XNE_wxx1Osa+RrfqOUP9PZhScGnMUDgQ-qqHzYe9KFg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 30, 2023 at 10:52:37AM +0200, Aleksandr Nogikh wrote:
> > Given this is a maliciously corrupted filesystem image, this sort of
> > warning is expected and there's probably nothing we can do to avoid
> > it short of a full filesystem verification pass during mount.
> > That's not a viable solution, so I think we should just ignore
> > syzbot when it generates this sort of warning....
> 
> If it's not a warning about a kernel bug, then WARN_ON should probably
> be replaced by some more suitable reporting mechanism. Kernel coding
> style document explicitly says:
> 
> "WARN*() must not be used for a condition that is expected to trigger
> easily, for example, by user space actions. pr_warn_once() is a
> possible alternative, if you need to notify the user of a problem."
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=1e760fa3596e8c7f08412712c168288b79670d78#n1223
>

Well, the question is wether a maliciously corrupted file system is a
condition which is "triggered easily".  Note that it requries root
privileges to be able to mount a malciously corrupted file system,
and given that root can do all sorts of thigns that can crash the
system (example: kexec a maliciously created "kernel image" or
creating a high-priority real-time thread which starves kernel
threads), this is actually a much closer call.

					- Ted
