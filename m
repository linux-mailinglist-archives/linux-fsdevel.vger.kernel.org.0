Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D51047C402
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 17:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239956AbhLUQlh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 11:41:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239950AbhLUQlg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640104895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ElFYDTfqtVS9AbMiX7GjxVwW3BhW7qK1g9VgLu9frpo=;
        b=F2HFuVoGeIqmkor/Q5vh91s+YeN9TjObPpSIgrSiNM+HMMJYKPC6BjqIWmULCSRrkgFgWM
        iF8l9DcHeSNtRcV9QcPZama4fGlb2IDSWrtdqWv5UNho/MZc8dh/Y91MKk7vjS8BKFRw6Y
        Y9nWHsWjEWAL4o1zq+d+hucQlZIsGIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-QX0IpJNRNQWAy9uhjQGsQQ-1; Tue, 21 Dec 2021 11:41:30 -0500
X-MC-Unique: QX0IpJNRNQWAy9uhjQGsQQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE985100C609;
        Tue, 21 Dec 2021 16:41:28 +0000 (UTC)
Received: from [10.22.9.221] (unknown [10.22.9.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8ED8C60BD8;
        Tue, 21 Dec 2021 16:41:27 +0000 (UTC)
Message-ID: <4f67dc4c-7038-7dde-cad9-4feeaa6bc71b@redhat.com>
Date:   Tue, 21 Dec 2021 11:41:27 -0500
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
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>
References: <20211221021744.864115-1-longman@redhat.com>
 <87lf0e7y0k.fsf@email.froward.int.ebiederm.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <87lf0e7y0k.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 12/21/21 10:55, Eric W. Biederman wrote:
> Waiman Long <longman@redhat.com> writes:
>
>> The begin_new_exec() function checks for SUID or SGID binaries by
>> comparing effective uid and gid against real uid and gid and using
>> the suid_dumpable sysctl parameter setting only if either one of them
>> differs.
>>
>> In the special case that the uid and/or gid of the SUID/SGID binaries
>> matches the id's of the user invoking it, the suid_dumpable is not
>> used and SUID_DUMP_USER will be used instead. The documentation for the
>> suid_dumpable sysctl parameter does not include that exception and so
>> this will be an undocumented behavior.
>>
>> Eliminate this undocumented behavior by adding a flag in the linux_binprm
>> structure to designate a SUID/SGID binary and use it for determining
>> if the suid_dumpable setting should be applied or not.
> I see that you are making the code match the documentation.
> What harm/problems does this mismatch cause in practice?
> What is the motivation for this change?
>
> I am trying to see the motivation but all I can see is that
> in the case where suid and sgid do nothing in practice the code
> does not change dumpable.  The point of dumpable is to refuse to
> core dump when it is not safe.  In this case since nothing happened
> in practice it is safe.
>
> So how does this matter in practice.  If there isn't a good
> motivation my feel is that it is the documentation that needs to be
> updated rather than the code.
>
> There are a lot of warts to the suid/sgid handling during exec.  This
> just doesn't look like one of them

This patch is a minor mitigation in response to the security 
vulnerability as posted in 
https://www.openwall.com/lists/oss-security/2021/10/20/2 (aka 
CVE-2021-3864). In particular, the Su PoC (tested on CentOS 7) showing 
that the su invokes /usr/sbin/unix_chkpwd which is also a SUID binary. 
The initial su invocation won't generate a core dump because the real 
uid and euid differs, but the second unix_chkpwd invocation will. This 
patch eliminates this hole by making sure that all SUID binaries follow 
suid_dumpable setting.

Cheers,
Longman


