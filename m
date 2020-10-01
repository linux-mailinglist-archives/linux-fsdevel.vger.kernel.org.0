Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2AD28086D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 22:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732829AbgJAUZ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 16:25:29 -0400
Received: from smtp-bc08.mail.infomaniak.ch ([45.157.188.8]:34897 "EHLO
        smtp-bc08.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726515AbgJAUYA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:24:00 -0400
X-Greylist: delayed 12062 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Oct 2020 16:23:59 EDT
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4C2PjB3MxpzlhX62;
        Thu,  1 Oct 2020 22:23:58 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4C2Pj72KZtzllmgR;
        Thu,  1 Oct 2020 22:23:55 +0200 (CEST)
Subject: Re: [PATCH v11 2/3] arch: Wire up trusted_for(2)
To:     Tycho Andersen <tycho@tycho.pizza>, Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
References: <20201001170232.522331-1-mic@digikod.net>
 <20201001170232.522331-3-mic@digikod.net> <20201001193306.GE1260245@cisco>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <7ccdf4b0-8158-fb82-fb4f-ad78518dbc30@digikod.net>
Date:   Thu, 1 Oct 2020 22:23:54 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20201001193306.GE1260245@cisco>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 01/10/2020 21:33, Tycho Andersen wrote:
> On Thu, Oct 01, 2020 at 07:02:31PM +0200, Mickaël Salaün wrote:
>> --- a/include/uapi/asm-generic/unistd.h
>> +++ b/include/uapi/asm-generic/unistd.h
>> @@ -859,9 +859,11 @@ __SYSCALL(__NR_openat2, sys_openat2)
>>  __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
>>  #define __NR_faccessat2 439
>>  __SYSCALL(__NR_faccessat2, sys_faccessat2)
>> +#define __NR_trusted_for 443
>> +__SYSCALL(__NR_trusted_for, sys_trusted_for)
>>  
>>  #undef __NR_syscalls
>> -#define __NR_syscalls 440
>> +#define __NR_syscalls 444
> 
> Looks like a rebase problem here?

No, it is a synchronization with the -next tree (cf. changelog) as asked
(and acked for a previous version) by Arnd.
