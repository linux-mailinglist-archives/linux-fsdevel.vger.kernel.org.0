Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD3D72AAD0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 12:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjFJKLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 06:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFJKLX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 06:11:23 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF5B30D7;
        Sat, 10 Jun 2023 03:11:22 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 35AAAgjH002919;
        Sat, 10 Jun 2023 19:10:42 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Sat, 10 Jun 2023 19:10:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 35AA9QW1002648
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 10 Jun 2023 19:09:27 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b45fa2fd-a19d-7507-726c-66a47f532bf4@I-love.SAKURA.ne.jp>
Date:   Sat, 10 Jun 2023 19:09:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [syzbot] [tomoyo?] [fs?] INFO: rcu detected stall in newfstatat
 (3)
Content-Language: en-US
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
References: <0000000000009752a005fdc2d114@google.com>
Cc:     linux-usb@vger.kernel.org,
        syzbot <syzbot+96127c74434e19e4609d@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000009752a005fdc2d114@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Regarding drivers/media/rc/ directory, igorplugusb_callback() and irtoy_in_callback() and
mceusb_dev_recv() are handling -EPROTO error, by calling usb_unlink_urb() and returning
instead of calling usb_submit_urb() again. This indicates that lack of -EPROTO (and some
other error codes) handling in usb_rx_callback_intf0() is causing infinite resubmit loop.
So, which error codes does usb_rx_callback_intf0() need to handle?

static void usb_rx_callback_intf0(struct urb *urb)
{
	dev_warn(ictx->dev, "imon %s: status(%d): ignored\n",
		__func__, urb->status);
	usb_submit_urb(ictx->rx_urb_intf0, GFP_ATOMIC);
}

#syz set subsystems: usb

On 2023/06/10 18:07, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d37537a1f7cf Merge 6.4-rc5 into usb-next
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=15d9b771280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9e12d6d7f5296037
> dashboard link: https://syzkaller.appspot.com/bug?extid=96127c74434e19e4609d
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153d7959280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bcb6b5280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/752b1860c3b6/disk-d37537a1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6f9c9f2751b2/vmlinux-d37537a1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/bf7433b7dd12/bzImage-d37537a1.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+96127c74434e19e4609d@syzkaller.appspotmail.com

