Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4478F21004C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 01:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgF3W77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 18:59:59 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51934 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgF3W77 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 18:59:59 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 05UMx2ox072030;
        Wed, 1 Jul 2020 07:59:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp);
 Wed, 01 Jul 2020 07:59:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 05UMx1ds071983
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 1 Jul 2020 07:59:02 +0900 (JST)
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
 <c7d4df91-d78e-5134-2161-192426fc51cd@i-love.sakura.ne.jp>
 <CAADnVQKrRpjQpc9-xMizCPr1E12_jXrvH-kaKwxBmvQ03n_uiw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <12eba0ed-c345-b564-9b99-883615dd89f3@i-love.sakura.ne.jp>
Date:   Wed, 1 Jul 2020 07:58:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQKrRpjQpc9-xMizCPr1E12_jXrvH-kaKwxBmvQ03n_uiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/07/01 6:57, Alexei Starovoitov wrote:
>>>>> They were all should never happen cases.  Which is why my patches do:
>>>>> if (WARN_ON_ONCE(...))
>>>>
>>>> No. Fuzz testing (which uses panic_on_warn=1) will trivially hit them.
>>>
>>> I don't believe that's true.
>>> Please show fuzzing stack trace to prove your point.
>>>
>>
>> Please find links containing "WARNING" from https://syzkaller.appspot.com/upstream . ;-)
> 
> Is it a joke? Do you understand how syzbot works?
> If so, please explain how it can invoke umd_* interface.
> 

Currently syzkaller can't invoke umd_* interface because this interface is used by only
bpfilter_umh module. But I can imagine that someone starts using this interface in a way
syzkaller can somehow invoke. Thus, how can it be a joke? I don't understand your question.
