Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28314263C6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 07:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgIJF0w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 01:26:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57796 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgIJF0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:26:52 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 08A5QomU024629;
        Thu, 10 Sep 2020 14:26:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp);
 Thu, 10 Sep 2020 14:26:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 08A5Qnfj024624
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 10 Sep 2020 14:26:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] fput: Allow calling __fput_sync() from !PF_KTHREAD
 thread.
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org
References: <20200708142409.8965-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <1596027885-4730-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200910035750.GX1236603@ZenIV.linux.org.uk>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <dae15011-24b0-b382-218a-c988b435fb5c@i-love.sakura.ne.jp>
Date:   Thu, 10 Sep 2020 14:26:46 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200910035750.GX1236603@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/09/10 12:57, Al Viro wrote:
> On Wed, Jul 29, 2020 at 10:04:45PM +0900, Tetsuo Handa wrote:
>> __fput_sync() was introduced by commit 4a9d4b024a3102fc ("switch fput to
>> task_work_add") with BUG_ON(!(current->flags & PF_KTHREAD)) check, and
>> the only user of __fput_sync() was introduced by commit 17c0a5aaffa63da6
>> ("make acct_kill() wait for file closing."). However, the latter commit is
>> effectively calling __fput_sync() from !PF_KTHREAD thread because of
>> schedule_work() call followed by immediate wait_for_completion() call.
>> That is, there is no need to defer close_work() to a WQ context. I guess
>> that the reason to defer was nothing but to bypass this BUG_ON() check.
>> While we need to remain careful about calling __fput_sync(), we can remove
>> bypassable BUG_ON() check from __fput_sync().
>>
>> If this change is accepted, racy fput()+flush_delayed_fput() introduced
>> by commit e2dc9bf3f5275ca3 ("umd: Transform fork_usermode_blob into
>> fork_usermode_driver") will be replaced by this raceless __fput_sync().

Thank you for responding. I'm also waiting for your response on
"[RFC PATCH] pipe: make pipe_release() deferrable." at 
https://lore.kernel.org/linux-fsdevel/7ba35ca4-13c1-caa3-0655-50d328304462@i-love.sakura.ne.jp/
and "[PATCH] splice: fix premature end of input detection" at 
https://lore.kernel.org/linux-block/cf26a57e-01f4-32a9-0b2c-9102bffe76b2@i-love.sakura.ne.jp/ .

> 
> NAK.  The reason to defer is *NOT* to bypass that BUG_ON() - we really do not
> want that thing done on anything other than extremely shallow stack.
> Incidentally, why is that thing ever done _not_ in a kernel thread context?

What does "that thing" refer to? acct_pin_kill() ? blob_to_mnt() ?
I don't know the reason because I'm not the author of these functions.
