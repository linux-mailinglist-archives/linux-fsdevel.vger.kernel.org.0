Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC23770AC70
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 07:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjEUFFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 01:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUFFO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 01:05:14 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1069A116;
        Sat, 20 May 2023 22:05:11 -0700 (PDT)
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 34L545Vo045924;
        Sun, 21 May 2023 14:04:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Sun, 21 May 2023 14:04:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 34L545uK045921
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 21 May 2023 14:04:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <680fe81d-6d33-ef0a-95d2-0bb79430019d@I-love.SAKURA.ne.jp>
Date:   Sun, 21 May 2023 14:04:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [syzbot] [fs?] INFO: task hung in synchronize_rcu (4)
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        syzbot <syzbot+222aa26d0a5dbc2e84fe@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Cc:     amir73il@gmail.com, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        jack@suse.cz, kuba@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, peterz@infradead.org,
        torvalds@linux-foundation.org, willemdebruijn.kernel@gmail.com
References: <000000000000baea9905fc275a49@google.com>
 <048219d7-2403-b898-129f-a0f85512cdf5@linux.dev>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <048219d7-2403-b898-129f-a0f85512cdf5@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/05/21 11:26, Martin KaFai Lau wrote:
> On 5/20/23 3:13 PM, syzbot wrote:
>> syzbot has found a reproducer for the following issue on:
>>
>> HEAD commit:    dcbe4ea1985d Merge branch '1GbE' of git://git.kernel.org/p..
>> git tree:       net-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=123ebd91280000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f20b05fe035db814
>> dashboard link: https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1495596a280000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1529326a280000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/41b9dda0e686/disk-dcbe4ea1.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/64d9bece8f89/vmlinux-dcbe4ea1.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/42429896dca0/bzImage-dcbe4ea1.xz
>>
>> The issue was bisected to:
>>
>> commit 3b5d4ddf8fe1f60082513f94bae586ac80188a03
>> Author: Martin KaFai Lau <kafai@fb.com>
>> Date:   Wed Mar 9 09:04:50 2022 +0000
>>
>>      bpf: net: Remove TC_AT_INGRESS_OFFSET and SKB_MONO_DELIVERY_TIME_OFFSET macro
> 
> I am afraid this bisect is incorrect. The commit removed a redundant macro and is a no-op change.
> 
> 

But the reproducer is heavily calling bpf() syscall.

void execute_call(int call)
{
  switch (call) {
  case 0:
    NONFAILING(*(uint32_t*)0x200027c0 = 3);
    NONFAILING(*(uint32_t*)0x200027c4 = 4);
    NONFAILING(*(uint32_t*)0x200027c8 = 4);
    NONFAILING(*(uint32_t*)0x200027cc = 0x10001);
    NONFAILING(*(uint32_t*)0x200027d0 = 0);
    NONFAILING(*(uint32_t*)0x200027d4 = -1);
    NONFAILING(*(uint32_t*)0x200027d8 = 0);
    NONFAILING(memset((void*)0x200027dc, 0, 16));
    NONFAILING(*(uint32_t*)0x200027ec = 0);
    NONFAILING(*(uint32_t*)0x200027f0 = -1);
    NONFAILING(*(uint32_t*)0x200027f4 = 0);
    NONFAILING(*(uint32_t*)0x200027f8 = 0);
    NONFAILING(*(uint32_t*)0x200027fc = 0);
    NONFAILING(*(uint64_t*)0x20002800 = 0);
    syscall(__NR_bpf, 0ul, 0x200027c0ul, 0x48ul);
    break;
  }
}

Something caused infinite loop or too heavy stress to survive?
The first report was 7d31677bb7b1.
Rechecking or running the reproducer on commits shown by
"git log 7d31677bb7b1 net/bpf" might help.


