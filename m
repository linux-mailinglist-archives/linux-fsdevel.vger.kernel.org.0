Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EE4787CC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 03:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbjHYBIj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 21:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbjHYBIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:08:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0AE19BB;
        Thu, 24 Aug 2023 18:08:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 299B262EC9;
        Fri, 25 Aug 2023 01:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07376C433C7;
        Fri, 25 Aug 2023 01:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692925712;
        bh=cD8kNYTozm4FuGJASkCTOiGIy89mI5dFCwxsGj6eWRg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=X/w2OvpRG0d2hEVa5GJsOYdO9HO0dZM+351CR1YQawNy+H1cVLe6qfmN4xe7bxD0r
         iE+dMczgtnuj/gLd8ovO17reyq7Sxs8Ni+UrzOpLuWAzFYpOeOFp8C4Dzwxb+dFHv9
         Ekxktp3qRZozdqEKajN57fkPifCV/rmhth4Q8J8YIOBUK7M+k08T2n2+MbHaaAjSws
         hxV/V8czrwT3HURuKsp5rqUXufDOptm5ByF6PW2kn8SfxoTrqUkoZVl9AcxdlGwZ5g
         UaL3TiWJPNLn03Nh/wAIQ7BxPzmhI62HvH8IbPL2B3uut/k4nk5qDI0/0SeC7vQCTW
         /CcPCAWsAC4nA==
Message-ID: <8680b259-528b-32a9-73ee-ce6a6406f13d@kernel.org>
Date:   Fri, 25 Aug 2023 09:08:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_add_inline_entry
To:     syzbot <syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com>,
        hdanton@sina.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000001b658e0603ad424d@google.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <0000000000001b658e0603ad424d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/8/24 23:55, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 5eda1ad1aaffdfebdecf7a164e586060a210f74f
> Author: Jaegeuk Kim <jaegeuk@kernel.org>
> Date:   Wed Jun 28 08:00:56 2023 +0000
> 
>      f2fs: fix deadlock in i_xattr_sem and inode page lock
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=167691b7a80000
> start commit:   cacc6e22932f tpm: Add a helper for checking hwrng enabled
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=157691b7a80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=117691b7a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=171b698bc2e613cf
> dashboard link: https://syzkaller.appspot.com/bug?extid=a4976ce949df66b1ddf1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103c6bb3a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bb51c7a80000
> 
> Reported-by: syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com
> Fixes: 5eda1ad1aaff ("f2fs: fix deadlock in i_xattr_sem and inode page lock")

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev

> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
