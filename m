Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E28770BEFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjEVNBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjEVNBp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:01:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6997C4;
        Mon, 22 May 2023 06:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C2F4618EC;
        Mon, 22 May 2023 13:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E353C433D2;
        Mon, 22 May 2023 13:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684760498;
        bh=E3lNBnfQQ0cZMPe43F7eKjkBfPR7qOeiV12BO5T01Gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=te41SV04IwsyyG1SeyvxB0eL5FzgZLgThpom66Fd+b8BF0nEniWU0YbrmsQD2VwD0
         P2SEnECVqlh0Pc4EOnLS+kF7XYNQ0VJUUlaHHR7LKUpJwntwC2aWS5kqNGk9mx07uu
         r2JZWWRjJ7RnPRihj+uHZo0wrXSl9BFqEbGbWsxzx1snLuHP6uqzVr3WrU+pDo0gwq
         eLNx8+Dxrr2PEOCCtWUxniF5+EzBo6GWYhLLKvptb36EjEfQiZ3uhqp/jVRrbvq+Po
         AYn0gTZP9yu+i2OAtyPvYlfpjyiiebuHS76/DZ0n2kl2S28mtaxSWrlN0We2oc33Rz
         rjNuQ7cju+BCQ==
Date:   Mon, 22 May 2023 15:01:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+24d1639a31b024b125bd@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] [usb?] INFO: rcu detected stall in vfs_readlink
Message-ID: <20230522-antennen-eislauf-4b5a69a167e3@brauner>
References: <000000000000c9c7fa05fc177edf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000c9c7fa05fc177edf@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 08:18:45PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a4422ff22142 usb: typec: qcom: Add Qualcomm PMIC Type-C dr..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=10ce218e280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2414a945e4542ec1
> dashboard link: https://syzkaller.appspot.com/bug?extid=24d1639a31b024b125bd
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137d4c06280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b758a1280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/414817142fb7/disk-a4422ff2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/448dba0d344e/vmlinux-a4422ff2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d0ad9fe848e2/bzImage-a4422ff2.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+24d1639a31b024b125bd@syzkaller.appspotmail.com
> 
> imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored

I have the strong suspicion that the usb drive is removed or some such
nonsense. Doesn't seem an fs bug.
