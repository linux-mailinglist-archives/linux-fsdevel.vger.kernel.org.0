Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52657AA362
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 23:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjIUVue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 17:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjIUVuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:50:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258B183331;
        Thu, 21 Sep 2023 10:37:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348ABC116D4;
        Thu, 21 Sep 2023 08:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695286022;
        bh=YrAx0IOimxMinoRfvH9X/BV0qc5xwrL8BUKY0ZLKjMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rwPg638QO2+Noyan8G0ltDwFnFolFtg4oQadiBeTUGMYuQjrPgFqvd9sBhIVGeo+5
         S0si5GD/LrF3y3DiEzoab49//IOo2JcWTo1+ICI5vk1bhxaxSJDjcfVThXlEFYpKkw
         tVTwTjbrTuCsyN0nt+nNrv9Q+kdrFQqVdgeVgebxjJPW8kCUk0Zn+1xSYElRpVK9vE
         DZCarQRNhB52q8dmoCl8U7CEaaS9gxh0VfeOlSWh/WRf0LWvGcBKBZBljLht8zcir4
         r4lvyrwAh7rKIE3DDq/wEWUdMEsuhwI1O60X4lixu79Y8r8LwvrrBdvIzVP1s9OlnQ
         rn0bx/W9GYYAA==
Date:   Thu, 21 Sep 2023 10:46:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+5f1acda7e06a2298fae6@syzkaller.appspotmail.com>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] memory leak in fasync_helper (2)
Message-ID: <20230921-kichern-akrobatisch-3d83edba974a@brauner>
References: <000000000000a3f3d40605d8f0f8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000a3f3d40605d8f0f8@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 11:52:48PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f0b0d403eabb Merge tag 'kbuild-fixes-v6.6' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=144e498c680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=943a94479fa8e863
> dashboard link: https://syzkaller.appspot.com/bug?extid=5f1acda7e06a2298fae6
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161ac702680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16515418680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/47695e593bcd/disk-f0b0d403.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/306f9aca0df9/vmlinux-f0b0d403.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/25549b4deb42/bzImage-f0b0d403.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5f1acda7e06a2298fae6@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff888114ac69c0 (size 48):
>   comm "syz-executor199", pid 5124, jiffies 4294947402 (age 21.830s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
>     00 00 00 00 00 00 00 00 00 81 0f 09 81 88 ff ff  ................
>   backtrace:
>     [<ffffffff816b06bd>] fasync_alloc fs/fcntl.c:892 [inline]
>     [<ffffffff816b06bd>] fasync_add_entry fs/fcntl.c:950 [inline]
>     [<ffffffff816b06bd>] fasync_helper+0x3d/0xc0 fs/fcntl.c:979
>     [<ffffffff83e8f2cb>] sock_fasync+0x4b/0xa0 net/socket.c:1427

#syz set subsystems: net
