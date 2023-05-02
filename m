Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5476F40D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjEBKOc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbjEBKO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:14:28 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3994C2123;
        Tue,  2 May 2023 03:14:24 -0700 (PDT)
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 342ADoYD095814;
        Tue, 2 May 2023 19:13:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Tue, 02 May 2023 19:13:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 342ADig8095778
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 May 2023 19:13:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <237a9064-78bb-1fe9-4293-1409a705d2d1@I-love.SAKURA.ne.jp>
Date:   Tue, 2 May 2023 19:13:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod
 (2)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <0000000000007337c705fa1060e2@google.com>
 <CACT4Y+a=xWkNGw_iKibRp4ivSE8OJkWWT0VPQ4N4d1+vj0FMdg@mail.gmail.com>
 <bdb1fe2d-f904-78f0-d287-5e601f789862@I-love.SAKURA.ne.jp>
 <a2c2308a-729a-ec18-18e7-36d00b25207d@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <a2c2308a-729a-ec18-18e7-36d00b25207d@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/05/01 23:05, Tetsuo Handa wrote:
>> Also, there was a similar report on updating i_{ctime,mtime} to current_time()
>> which means that i_size is not the only field that is causing data race.
>> https://syzkaller.appspot.com/bug?id=067d40ab9ab23a6fa0a8156857ed54e295062a29
> 
> Do we want to as well wrap i_{ctime,mtime} using data_race() ?
> 

I think we need to use inode_lock_shared()/inode_unlock_shared() when calling
generic_fillattr(), for i_{ctime,mtime} (128bits) are too large to copy atomically.

Is it safe to call inode_lock_shared()/inode_unlock_shared() from generic_fillattr()?
Is some filesystem already holding inode lock before calling generic_fillattr()?

