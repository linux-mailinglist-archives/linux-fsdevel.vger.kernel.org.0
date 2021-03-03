Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E01532C566
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378786AbhCDAU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:27 -0500
Received: from p3plsmtpa11-01.prod.phx3.secureserver.net ([68.178.252.102]:47951
        "EHLO p3plsmtpa11-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345824AbhCCQtV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:49:21 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id HUfnl7NQZSxgqHUfnldpJt; Wed, 03 Mar 2021 09:48:32 -0700
X-CMAE-Analysis: v=2.4 cv=I6mg+Psg c=1 sm=1 tr=0 ts=603fbde0
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=R9wNnC8WphZdeWqDHgIA:9 a=QEXdDO2ut3YA:10
 a=5oRCH6oROnRZc2VpWJZ3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [man-pages][PATCH v1] flock.2: add CIFS details
To:     =?UTF-8?Q?Aur=c3=a9lien_Aptel?= <aaptel@suse.com>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, mtk.manpages@gmail.com
Cc:     smfrench@gmail.com
References: <20210302154831.17000-1-aaptel@suse.com>
 <5ae02f1f-af45-25aa-71b1-4f8782286158@talpey.com> <8735xcxkv5.fsf@suse.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <f1beb7c8-1f73-0ea7-7052-13b6516b5f6c@talpey.com>
Date:   Wed, 3 Mar 2021 11:48:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <8735xcxkv5.fsf@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfN5rmYoyEDnx2/zSPynjbOxJQYd2U7FH43IND3I/VDTIheFLSznK43J9czidwtdtdri/83IXjS+pC/RslNwoQSp6tx65noOO+He70kZQMT5hLiBmyKgS
 /A3rHGf7yuCNJQihKflCIHW4qD6jX1YZ+qTZOedvixHJeJbwKh9lTSD+hbCssh/EkrJ/C2Cxlw7ilmTV0sDodFOrBbEF3Zdg8s6RmCdFzTRuXov70HwIo69I
 L6iyfWHWBkekKy9VM11yzDhV1E2+42hyopbkmmcsO7Eq2PpcBJA7E/JKWp7t6KP9o0giiACTT0m/tM8gXoI4mspxY/R2RlexY88HIiTH/AjVZ9IMOBoMYTk4
 +/dP/fHy
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/3/2021 11:28 AM, Aurélien Aptel wrote:
> Hi Tom,
> 
> Thanks for taking a look.
> 
> Tom Talpey <tom@talpey.com> writes:
>> On 3/2/2021 10:48 AM, Aurélien Aptel wrote:
>> I'd suggest removing this sentence. It doesn't really add anything to
>> the definition.
> 
> OK.
> 
>> This is discussing the scenario where a process on the server performs
>> an flock(), right? That's perhaps confusingly special. How about
> 
> This is about clients. Let's say the same app is running on 2 different
> Linux system that have the same Windows Server share mounted.
> 
> The scenario is those 2 app instances use the same file on the share and
> are trying to synchronize access using flock().
> 
> Pre-5.5, CIFS flock() is using the generic flock() implementation from
> the Linux VFS layer which only knows about syscall made by local apps
> and isn't aware that the file can be accessed under its feet from the
> network.

I don't fully understand your response. What does "knows about syscall
from local apps" mean, from a practical perspective? That it never
forwards any flock() call to the server? Or that it somehow caches
the flock() results, and never checks if the server has a conflict
from another client?

> In 5.5 and above, CIFS flock() is implemented using SMB locks, which
> have different semantics than what POSIX defines, i.e. you cannot ignore
> the locks and write, write() will fail with EPERM. So this version can
> be used for file sync with other clients but works slightly
> differently. It is a best-effort attempt.

I think we're agreeing here. Let's figure out the other question before
deciding.

Bottom line, I think it's important to avoid statements like "same" or
"different". Say what it does or does not do, and leave such questions
to other sources.

Tom.


> Does this clarification changes anything to your suggestions?
> 
>> "In Linux kernels up to 5.4, flock() is not propagated over SMB. A file
>> with such locks will not appear locked for remote clients."
> 
> 
>> "protocol, which provides mandatory locking semantics."
> 
> OK. As it turns out, there is actually a 'nobrl' mount option to get back
> pre-5.5 behavior. I'll mention it and use your suggestions in v2.
> 
> Cheers,
> 
