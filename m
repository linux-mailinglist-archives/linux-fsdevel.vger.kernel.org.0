Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA35759BD4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 12:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiHVKEh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 06:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiHVKEg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:04:36 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D8526AE3;
        Mon, 22 Aug 2022 03:04:34 -0700 (PDT)
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 27MA3hbQ048033;
        Mon, 22 Aug 2022 19:03:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Mon, 22 Aug 2022 19:03:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 27MA3hAc048029
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 Aug 2022 19:03:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <07bc89cf-643b-9aa8-5683-a181d049ab85@I-love.SAKURA.ne.jp>
Date:   Mon, 22 Aug 2022 19:03:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in
 __access_remote_vm
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <0000000000003e678705e6d0ce67@google.com>
Cc:     syzbot <syzbot+5fb61eb0bea5eab81137@syzkaller.appspotmail.com>,
        xu.xin16@zte.com.cn, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        chengzhihao1@huawei.com, brauner@kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000003e678705e6d0ce67@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Caused by commit 38a12ad69d86f801 ("lib/dump_stack: add dump_stack_print_cmdline()
and wire up in dump_stack_print_info()"). You can't call get_task_cmdline_kernel()
 from dump_stack() due to printk_cpu_sync_get_irqsave(flags) from dump_stack_lvl().

Andrew, please drop that patch.

On 2022/08/22 18:09, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8755ae45a9e8 Add linux-next specific files for 20220819
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14c3b6eb080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ead6107a3bbe3c62
> dashboard link: https://syzkaller.appspot.com/bug?extid=5fb61eb0bea5eab81137
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166bdb3d080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16298e5b080000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5fb61eb0bea5eab81137@syzkaller.appspotmail.com
> 

