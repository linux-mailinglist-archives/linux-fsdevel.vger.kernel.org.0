Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D04F14106D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 19:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgAQSLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 13:11:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34706 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726603AbgAQSLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579284673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUtVwDqnuDn/t5tUW8sUkWv84d3FlHqi58OEIXe+Yqw=;
        b=EsaOs8ZTSbFnW0FppqzlaWoCZwp3rGho+yaNbjzkKgYSP7zX5DxFKbsX/rpfVMnQ7q4VX/
        lHyApkhppZwPmenzf3/9nZBjbUrcpkoIlae9UlN6Lxv6wRdhlwPOCzMT2BJ2E0hfFnZ2Ox
        HprftXMDokyXMK0B4AbfGvWeItW+03M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-zYkDQlh8NU-813ws2COrgA-1; Fri, 17 Jan 2020 13:11:09 -0500
X-MC-Unique: zYkDQlh8NU-813ws2COrgA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D871100551C;
        Fri, 17 Jan 2020 18:11:08 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B55DD5D9CD;
        Fri, 17 Jan 2020 18:11:07 +0000 (UTC)
Subject: Re: Performance regression introduced by commit b667b8673443 ("pipe:
 Advance tail pointer inside of wait spinlock in pipe_read()")
From:   Waiman Long <longman@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <c6ed1ca0-3e39-714c-9590-54e13695b9b9@redhat.com>
 <CAHk-=wink2z6EtvhKfhSvfC2hKBseVU8UWsM+HLsQP9x3mD7Xw@mail.gmail.com>
 <5c184396-7cc8-ee72-2335-dce9a977c8d4@redhat.com>
Organization: Red Hat
Message-ID: <b70a0334-63be-b3a5-6f8a-714fbe4637c7@redhat.com>
Date:   Fri, 17 Jan 2020 13:11:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5c184396-7cc8-ee72-2335-dce9a977c8d4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/17/20 12:29 PM, Waiman Long wrote:
> On 1/17/20 12:05 PM, Linus Torvalds wrote:
>> [ on mobile, sorry for html crud ]
>>
>> On Fri, Jan 17, 2020, 08:53 Waiman Long <longman@redhat.com
>> <mailto:longman@redhat.com>> wrote:
>>
>>
>>     I had found that parallel kernel build became much slower when a
>>     5.5-based kernel is used. On a 2-socket 96-thread x86-64 system, t=
he
>>     "make -j88" time increased from less than 3 minutes with the 5.4
>>     kernel
>>     to more than double with the 5.5 kernel.
>>
>>
>> I suspect you may have hit the same bug in the GNU make jobserver
>> that I did.
>>
>> It's timing-sensitive, and under the right circumstances the make
>> jobserver loses job tickets to other jobservers that have a child
>> that died, but they are blocked waiting for a new ticket, so they
>> aren't releasing (or re-using) the one that the child death would
>> free up.
>>
>> End result: a big lack of parallelism, and a much slower build.
>>
>> GNU make v4.2.1 is buggy. The fix was done over two years ago, but
>> there hasn't been a new release since then, so a lot of distributions
>> have the buggy version..
>>
>> The fix is commit=C2=A0b552b05 ("[SV 51159] Use a non-blocking read wi=
th
>> pselect to avoid hangs.") In the make the git tree.
>>
>>
>> =C2=A0 =C2=A0 =C2=A0Linus
>
> Thanks for the information.
>
> Yes, I did use make v4.2.1 which is the version that is shipped in
> RHEL8. I will build new make and try it.
>
> Thanks,
> Longman
>
I built a make with the lastest make git tree and the problem was gone
with the new make. So it was a bug in make not the kernel. Sorry for the
noise.

Cheers,
Longman

