Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BAA47C5A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 19:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbhLUSBo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 13:01:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28651 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235961AbhLUSBl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640109698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zdQUxA4IWUHrYu4e+fUkTkyaddFqElt05hSeiqm5Sro=;
        b=QzcTR3LYHViblFPgzl4qRkpk4fZ3eQM+bByigG7rVHaUmexMVrTf47nXOJY7fX18RcC9P+
        3RWJG5766F2GJYYDW7gxH48eGwZmOE5mb84BckYZddrPwmsqbZ9Gkj/3xg9FbjQAIHO6T4
        XEJovVPh0pWPZ3adrMrwZL2+trWNvdo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-RJ2pbKEkNpikbFvNFtmNVw-1; Tue, 21 Dec 2021 13:01:34 -0500
X-MC-Unique: RJ2pbKEkNpikbFvNFtmNVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03DA68042E0;
        Tue, 21 Dec 2021 18:01:32 +0000 (UTC)
Received: from [10.22.33.162] (unknown [10.22.33.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0189B4E2CC;
        Tue, 21 Dec 2021 18:01:29 +0000 (UTC)
Message-ID: <e78085e4-74cd-52e1-bc0e-4709fac4458a@redhat.com>
Date:   Tue, 21 Dec 2021 13:01:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] exec: Make suid_dumpable apply to SUID/SGID binaries
 irrespective of invoking users
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Vivier <laurent@vivier.eu>,
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>,
        Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20211221021744.864115-1-longman@redhat.com>
 <87lf0e7y0k.fsf@email.froward.int.ebiederm.org>
 <4f67dc4c-7038-7dde-cad9-4feeaa6bc71b@redhat.com>
 <87czlp7tdu.fsf@email.froward.int.ebiederm.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <87czlp7tdu.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/21 12:35, Eric W. Biederman wrote:
> Adding a couple of other people who have expressed opinions on how
> to mitigate this issue in the kernel.
>
> Waiman Long <longman@redhat.com> writes:
>
>> On 12/21/21 10:55, Eric W. Biederman wrote:
>>> Waiman Long <longman@redhat.com> writes:
>>>
>>>> The begin_new_exec() function checks for SUID or SGID binaries by
>>>> comparing effective uid and gid against real uid and gid and using
>>>> the suid_dumpable sysctl parameter setting only if either one of them
>>>> differs.
>>>>
>>>> In the special case that the uid and/or gid of the SUID/SGID binaries
>>>> matches the id's of the user invoking it, the suid_dumpable is not
>>>> used and SUID_DUMP_USER will be used instead. The documentation for the
>>>> suid_dumpable sysctl parameter does not include that exception and so
>>>> this will be an undocumented behavior.
>>>>
>>>> Eliminate this undocumented behavior by adding a flag in the linux_binprm
>>>> structure to designate a SUID/SGID binary and use it for determining
>>>> if the suid_dumpable setting should be applied or not.
>>> I see that you are making the code match the documentation.
>>> What harm/problems does this mismatch cause in practice?
>>> What is the motivation for this change?
>>>
>>> I am trying to see the motivation but all I can see is that
>>> in the case where suid and sgid do nothing in practice the code
>>> does not change dumpable.  The point of dumpable is to refuse to
>>> core dump when it is not safe.  In this case since nothing happened
>>> in practice it is safe.
>>>
>>> So how does this matter in practice.  If there isn't a good
>>> motivation my feel is that it is the documentation that needs to be
>>> updated rather than the code.
>>>
>>> There are a lot of warts to the suid/sgid handling during exec.  This
>>> just doesn't look like one of them
>> This patch is a minor mitigation in response to the security
>> vulnerability as posted in
>> https://www.openwall.com/lists/oss-security/2021/10/20/2 (aka
>> CVE-2021-3864). In particular, the Su PoC (tested on CentOS 7) showing
>> that the su invokes /usr/sbin/unix_chkpwd which is also a SUID
>> binary. The initial su invocation won't generate a core dump because
>> the real uid and euid differs, but the second unix_chkpwd invocation
>> will. This patch eliminates this hole by making sure that all SUID
>> binaries follow suid_dumpable setting.
> All that is required to take advantage of this vulnerability is
> for an suid program to exec something that will coredump.  That
> exec resets the dumpability.
>
> While the example exploit is execing a suid program it is not required
> that the exec'd program be suid.
>
> This makes your proposed change is not a particularly effective mitigation.

Yes, I am aware of that. That is why I said it is just a minor 
mitigation. This patch was inspired after investigating this problem, 
but I do think it is good to make the code consistent with the 
documentation. Of course, we can go either way. I prefer my approach to 
use a flag to indicate a suid binary instead of just comparing ruid and 
euid.


>
> The best idea I have seen to mitigate this from the kernel side is:
>
> 1) set RLIMIT_CORE to 0 during an suid exec
> 2) update do_coredump to honor an rlimit of 0 for pipes
>
> Anecdotally this should not effect the common systems that pipe
> coredumps into programs as those programs are reported to honor
> RLIMIT_CORE of 0.  This needs to be verified.
>
> If those programs do honor RLIMIT_CORE of 0 we won't have any user
> visible changes if they never see coredumps from a program with a
> RLIMIT_CORE of 0.
>
>
> I have been meaning to audit userspace and see if the common coredump
> catchers truly honor an RLIMIT_CORE of 0.  Unfortunately I have not
> found time to do that yet.

Default RLIMIT_CORE to 0 will likely mitigate this vulnerability. 
However, there are still some userspace impacts as existing behavior 
will be modified. For instance, we may need to modify su to restore a 
proper value for RLIMIT_CORE after successful authentication.

Cheers,
Longman

