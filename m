Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBD258F76E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 08:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiHKGCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 02:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiHKGCW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:02:22 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8296F6BD6B
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Aug 2022 23:02:19 -0700 (PDT)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 27B61Nmu069124;
        Thu, 11 Aug 2022 15:01:23 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Thu, 11 Aug 2022 15:01:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 27B61NJB069121
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Aug 2022 15:01:23 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f00146b5-0a14-ac24-3d7b-3d4deeb96359@I-love.SAKURA.ne.jp>
Date:   Thu, 11 Aug 2022 15:01:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: INFO: task hung in iterate_supers
Content-Language: en-US
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
References: <000000000000da8a9b0570a29c01@google.com>
Cc:     linux-fsdevel@vger.kernel.org,
        syzbot <syzbot+2349f5067b1772c1d8a5@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000da8a9b0570a29c01@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello.

https://syzkaller.appspot.com/text?tag=CrashReport&x=154869fd080000
suggests that p9_client_rpc() is trapped at infinite retry loop

----------
again:
        /* Wait for the response */
        err = wait_event_killable(req->wq, req->status >= REQ_STATUS_RCVD);

        /* Make sure our req is coherent with regard to updates in other
         * threads - echoes to wmb() in the callback
         */
        smp_rmb();

        if (err == -ERESTARTSYS && c->status == Connected &&
            type == P9_TFLUSH) {
                sigpending = 1;
                clear_thread_flag(TIF_SIGPENDING);
                goto again;
        }
----------

which I guess that net/9p/trans_fd.c is failing to call p9_client_cb()
in order to update req->status and wake up req->wq.

But why does p9 think that Flush operation worth retrying forever?

The peer side should be able to detect close of file descriptor on local
side due to process termination via SIGKILL, and the peer side should be
able to perform appropriate recovery operation even if local side cannot
receive response for Flush operation.

Thus, why not to give up upon SIGKILL?


On 2018/07/10 19:30, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    d00d6d9a339d Add linux-next specific files for 20180709
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=111179b2400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=94fe2b586beccacd
> dashboard link: https://syzkaller.appspot.com/bug?extid=2349f5067b1772c1d8a5
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=174329b2400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11229044400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2349f5067b1772c1d8a5@syzkaller.appspotmail.com
> 

