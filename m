Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B2D266412
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 18:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgIKQai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 12:30:38 -0400
Received: from mxout04.lancloud.ru ([89.108.124.63]:48782 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIKPTe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:19:34 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 27D1B20A0DEC
Received: from LanCloud
Received: from LanCloud
Subject: Re: [RFC PATCH v9 0/3] Add introspect_access(2) (was O_MAYEXEC)
To:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        <kernel-hardening@lists.openwall.com>, <linux-api@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20200910164612.114215-1-mic@digikod.net>
 <20200910170424.GU6583@casper.infradead.org>
 <f6e2358c-8e5e-e688-3e66-2cdd943e360e@digikod.net>
 <a48145770780d36e90f28f1526805a7292eb74f6.camel@linux.ibm.com>
 <880bb4ee-89a2-b9b0-747b-0f779ceda995@digikod.net>
 <20200910184033.GX6583@casper.infradead.org>
 <20200910200010.GF1236603@ZenIV.linux.org.uk>
 <20200910200543.GY6583@casper.infradead.org>
From:   Igor Zhbanov <i.zhbanov@omprussia.ru>
Message-ID: <c77abad8-55a6-d66a-8d4d-dfc598fe5251@omprussia.ru>
Date:   Fri, 11 Sep 2020 17:15:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200910200543.GY6583@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: ru-RU
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.179.245.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To LFEX15.lancloud.ru
 (fd00:f066::45)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10.09.2020 23:05, Matthew Wilcox wrote:
> On Thu, Sep 10, 2020 at 09:00:10PM +0100, Al Viro wrote:
>> On Thu, Sep 10, 2020 at 07:40:33PM +0100, Matthew Wilcox wrote:
>>> On Thu, Sep 10, 2020 at 08:38:21PM +0200, Mickaël Salaün wrote:
>>>> There is also the use case of noexec mounts and file permissions. From
>>>> user space point of view, it doesn't matter which kernel component is in
>>>> charge of defining the policy. The syscall should then not be tied with
>>>> a verification/integrity/signature/appraisal vocabulary, but simply an
>>>> access control one.
>>>
>>> permission()?
>>
>> int lsm(int fd, const char *how, char *error, int size);
>>
>> Seriously, this is "ask LSM to apply special policy to file"; let's
>> _not_ mess with flags, etc. for that; give it decent bandwidth
>> and since it's completely opaque for the rest of the kernel,
>> just a pass a string to be parsed by LSM as it sees fit.
> 
> Hang on, it does have some things which aren't BD^W^WLSM.  It lets
> the interpreter honour the mount -o noexec option.  I presume it's
> not easily defeated by
> 	cat /home/salaun/bin/bad.pl | perl -

Hi!

It could be bypassed this way. There are several ways of executing some
script:

1) /unsigned.sh (Already handled by IMA)
2) bash /unsigned.sh (Not handled. Works even with "-o noexec" mount)
3) bash < /unsigned.sh (Not handled. Works even with "-o noexec" mount)
4) cat /unsigned.sh | bash (Not handled. Works even with "-o noexec" mount)

AFAIK, the proposed syscall solves #2 and may be #3. As for #4 in security
critical environments there should be system-wide options to disable
interpreting scripts from the standard input. I suppose, executing commands
from the stdin is a rare case, and could be avoided entirely in security
critical environments. And yes, some help from the interpreters is needed
for that.

As for the usage of the system call, I have a proposal to extend its usage
to validate systemd unit files. Because a unit file could specify what UID
to use for a service, also it contains ExecStartPre which is actually a script
and is running as root (for the system session services).

For the syscall name it could be:
- trusted_file()
- trusted_file_content()
- valid_file()
- file_integrity()
because what we are checking here is the file content integrity (IMA) and
may be file permissions/attrs integrity (EVM).
