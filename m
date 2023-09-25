Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F21F7AD8B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 15:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjIYNOp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 09:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjIYNOl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:14:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE4983;
        Mon, 25 Sep 2023 06:14:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D99AC433C7;
        Mon, 25 Sep 2023 13:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695647674;
        bh=BQ4g/Wj+xZ88lUHX2e0MEdWfVFrj8gWigGSQws/C+OE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iq0IBIuacuNvbGcGb9Ti0CcEvr6Sp0QYbEStx/bZp4GhzR5lIwfu7/m0Vtmu1kmtW
         TTVFo8Hq2EWgLpdbbwDFahZIQ8spoHhbXpPtfedcTP1qWsrmB6YQSKQsGemDxYzHI9
         aZq7HgQTKnlOiLT4TE0iKWHSjb4DgssAEowLF212RDgO8jhD3U/1OZPjNfVZ2DSgai
         1N6V2LVFVArDnOL1BAOBsIwZCmrDbdrxYfI7JG1FKjLRFwondlKvRVklhGw48oZ8wN
         eQVtV8dnYI21hoHd+nOzXhREe/LIyJ2xOdbvdASLEZP6xJQLOE7Ule7iO8JVspq58X
         W4OZ7tpdr+YwA==
Date:   Mon, 25 Sep 2023 15:14:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+2751da923b5eb8307b0b@syzkaller.appspotmail.com>
Cc:     anton@tuxera.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux@roeck-us.net,
        phil@philpotter.co.uk, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Subject: Re: [syzbot] [ntfs?] KASAN: use-after-free Read in ntfs_test_inode
Message-ID: <20230925-mitangeklagt-kranz-992ed028ecdf@brauner>
References: <000000000000b782b505c2847180@google.com>
 <000000000000a27dcc060624b16e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000a27dcc060624b16e@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 24, 2023 at 06:15:29PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 78a06688a4d40d9bb6138e2b9ad3353d7bf0157a
> Author: Christian Brauner <brauner@kernel.org>
> Date:   Thu Sep 7 16:03:40 2023 +0000
> 
>     ntfs3: drop inode references in ntfs_put_super()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1674a5c1680000
> start commit:   3aba70aed91f Merge tag 'gpio-fixes-for-v6.6-rc3' of git://..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1574a5c1680000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1174a5c1680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e4ca82a1bedd37e4
> dashboard link: https://syzkaller.appspot.com/bug?extid=2751da923b5eb8307b0b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136b4412680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aec0dc680000
> 
> Reported-by: syzbot+2751da923b5eb8307b0b@syzkaller.appspotmail.com
> Fixes: 78a06688a4d4 ("ntfs3: drop inode references in ntfs_put_super()")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz test: https://gitlab.com/brauner/linux.git 493c71926c20309226b6d73f6b661a9813de5f0b
