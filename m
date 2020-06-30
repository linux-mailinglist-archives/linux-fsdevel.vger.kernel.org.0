Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98FA20FFA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 23:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgF3Vz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 17:55:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60078 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbgF3Vz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:55:57 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 05ULscxI032871;
        Wed, 1 Jul 2020 06:54:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp);
 Wed, 01 Jul 2020 06:54:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 05ULsbqs032867
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 1 Jul 2020 06:54:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 00/14] Make the user mode driver code a better citizen
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
 <40720db5-92f0-4b5b-3d8a-beb78464a57f@i-love.sakura.ne.jp>
 <87366g8y1e.fsf@x220.int.ebiederm.org>
 <aa737d87-cf38-55d6-32f1-2d989a5412ea@i-love.sakura.ne.jp>
 <20200628194440.puzh7nhdnk6i4rqj@ast-mbp.dhcp.thefacebook.com>
 <c99d0cfc-8526-0daf-90b5-33e560efdede@i-love.sakura.ne.jp>
 <874kqt39qo.fsf@x220.int.ebiederm.org>
 <6a9dd8be-333a-fd21-d125-ec20fb7c81df@i-love.sakura.ne.jp>
 <20200630164817.txa2jewfvk4stajy@ast-mbp.dhcp.thefacebook.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c7d4df91-d78e-5134-2161-192426fc51cd@i-love.sakura.ne.jp>
Date:   Wed, 1 Jul 2020 06:54:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630164817.txa2jewfvk4stajy@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/07/01 1:48, Alexei Starovoitov wrote:
> On Tue, Jun 30, 2020 at 03:28:49PM +0900, Tetsuo Handa wrote:
>> On 2020/06/30 5:19, Eric W. Biederman wrote:
>>> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:
>>>
>>>> On 2020/06/29 4:44, Alexei Starovoitov wrote:
>>>>> But all the defensive programming kinda goes against general kernel style.
>>>>> I wouldn't do it. Especially pr_info() ?!
>>>>> Though I don't feel strongly about it.
>>>>
>>>> Honestly speaking, caller should check for errors and print appropriate
>>>> messages. info->wd.mnt->mnt_root != info->wd.dentry indicates that something
>>>> went wrong (maybe memory corruption). But other conditions are not fatal.
>>>> That is, I consider even pr_info() here should be unnecessary.
>>>
>>> They were all should never happen cases.  Which is why my patches do:
>>> if (WARN_ON_ONCE(...))
>>
>> No. Fuzz testing (which uses panic_on_warn=1) will trivially hit them.
> 
> I don't believe that's true.
> Please show fuzzing stack trace to prove your point.
> 

Please find links containing "WARNING" from https://syzkaller.appspot.com/upstream . ;-)
