Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F40322F967
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 21:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgG0TrD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 15:47:03 -0400
Received: from smtp-8fa9.mail.infomaniak.ch ([83.166.143.169]:46041 "EHLO
        smtp-8fa9.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728990AbgG0TrD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:47:03 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4BFr1022KyzlhTrH;
        Mon, 27 Jul 2020 21:47:00 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4BFr0w2zRPzlh8T4;
        Mon, 27 Jul 2020 21:46:56 +0200 (CEST)
Subject: Re: [PATCH v7 4/7] fs: Introduce O_MAYEXEC flag for openat2(2)
To:     Florian Weimer <fweimer@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
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
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
References: <20200723171227.446711-1-mic@digikod.net>
 <20200723171227.446711-5-mic@digikod.net>
 <20200727042106.GB794331@ZenIV.linux.org.uk>
 <87y2n55xzv.fsf@oldenburg2.str.redhat.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <eaf5bc42-e086-740b-a90c-93e67c535eee@digikod.net>
Date:   Mon, 27 Jul 2020 21:46:55 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <87y2n55xzv.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 27/07/2020 07:27, Florian Weimer wrote:
> * Al Viro:
> 
>> On Thu, Jul 23, 2020 at 07:12:24PM +0200, MickaÃ«l SalaÃ¼n wrote:
>>> When the O_MAYEXEC flag is passed, openat2(2) may be subject to
>>> additional restrictions depending on a security policy managed by the
>>> kernel through a sysctl or implemented by an LSM thanks to the
>>> inode_permission hook.  This new flag is ignored by open(2) and
>>> openat(2) because of their unspecified flags handling.  When used with
>>> openat2(2), the default behavior is only to forbid to open a directory.
>>
>> Correct me if I'm wrong, but it looks like you are introducing a magical
>> flag that would mean "let the Linux S&M take an extra special whip
>> for this open()".

There is nothing magic, it doesn't only work with the LSM framework, and
there is nothing painful nor humiliating here (except maybe this language).

>>
>> Why is it done during open?  If the caller is passing it deliberately,
>> why not have an explicit request to apply given torture device to an
>> already opened file?  Why not sys_masochism(int fd, char *hurt_flavour),
>> for that matter?
> 
> While I do not think this is appropriate language for a workplace, Al
> has a point: If the auditing event can be generated on an already-open
> descriptor, it would also cover scenarios like this one:
> 
>   perl < /path/to/script
> 
> Where the process that opens the file does not (and cannot) know that it
> will be used for execution purposes.

The check is done during open because the goal of this patch series is
to address the problem of script execution when opening a script in well
controlled systems (e.g. to enforce a "write xor execute" policy, to do
an atomic integrity check [1], to check specific execute/read
permissions, etc.). As discussed multiple times, controlling other means
to interpret commands (stdin, environment variables, etc.) is out of
scope and should be handled by interpreters (in userspace). Someone
could still extend fcntl(2) to enable to check file descriptors, but it
is an independent change not required for now.
Specific audit features are also out of scope for now [2].

[1] https://lore.kernel.org/lkml/1544699060.6703.11.camel@linux.ibm.com/
[2] https://lore.kernel.org/lkml/202007160822.CCDB5478@keescook/
