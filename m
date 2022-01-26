Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C81F49D1DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 19:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiAZSi7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 13:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiAZSi7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:38:59 -0500
Received: from mx1.mailbun.net (unknown [IPv6:2602:fd37:1::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF1DC06161C;
        Wed, 26 Jan 2022 10:38:58 -0800 (PST)
Received: from [2607:fb90:d98b:8818:5079:94eb:24d5:e5c3] (unknown [172.58.104.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ariadne@dereferenced.org)
        by mx1.mailbun.net (Postfix) with ESMTPSA id EF06C11A7C8;
        Wed, 26 Jan 2022 18:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dereferenced.org;
        s=mailbun; t=1643222338;
        bh=RXsSVCy4v5MpoLZDK+6HWpdTcWfXR+/KqheWg5ZsQs0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=TCqU+V5Uqr5xiwFc2j/zUn99Kj9DK8LK7Uqv3rNZU12sYl3PzAkFqTzgGpFJbHLbq
         Z9GUIPBIK8WI1xJyHpxC0FPNlIzw4nz18mO3lexnDCnRKMddZJBUye+a4ogwtUEUyT
         qx6o/Q1Ctay+ao7NxxDskvIX3rKerJiHku9wZ9M69pBk6HwcdaSk+aKJHGZ5Jkl8TN
         /A5BHD0AG7qtB+B5qoS2p9EVUFVKrezIOZwpPf8QKq6yseo5WJsHBfqEJepPxCGqSh
         ZICrbYsWIzdZCb6VWx9GaRl0l8qJPUB6NtC8PjTaESVml+TwN3Kckja56Ld17MMT+9
         vrW7cr0OLOK1Q==
Date:   Wed, 26 Jan 2022 12:38:50 -0600 (CST)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     Matthew Wilcox <willy@infradead.org>
cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ariadne Conill <ariadne@dereferenced.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs/exec: require argv[0] presence in
 do_execveat_common()
In-Reply-To: <YfGNBz0gigWwNnHn@casper.infradead.org>
Message-ID: <cd808fc1-ec7a-31d-217e-fbc55f7912a3@dereferenced.org>
References: <20220126114447.25776-1-ariadne@dereferenced.org> <YfFh6O2JS6MybamT@casper.infradead.org> <877damwi2u.fsf@email.froward.int.ebiederm.org> <YfGNBz0gigWwNnHn@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Wed, 26 Jan 2022, Matthew Wilcox wrote:

> On Wed, Jan 26, 2022 at 10:57:29AM -0600, Eric W. Biederman wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>>
>>> On Wed, Jan 26, 2022 at 11:44:47AM +0000, Ariadne Conill wrote:
>>>> Interestingly, Michael Kerrisk opened an issue about this in 2008[1],
>>>> but there was no consensus to support fixing this issue then.
>>>> Hopefully now that CVE-2021-4034 shows practical exploitative use
>>>> of this bug in a shellcode, we can reconsider.
>>>>
>>>> [0]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/exec.html
>>>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=8408
>>>
>>> Having now read 8408 ... if ABI change is a concern (and I really doubt
>>> it is), we could treat calling execve() with a NULL argv as if the
>>> caller had passed an array of length 1 with the first element set to
>>> NULL.  Just like we reopen fds 0,1,2 for suid execs if they were
>>> closed.
>>
>> Where do we reopen fds 0,1,2 for suid execs?  I feel silly but I looked
>> through the code fs/exec.c quickly and I could not see it.
>
> I'm wondering if I misremembered and it's being done in ld.so
> rather than in the kernel?  That might be the right place to put
> this fix too.
>
>> I am attracted to the notion of converting an empty argv array passed
>> to the kernel into something we can safely pass to userspace.
>>
>> I think it would need to be having the first entry point to "" instead
>> of the first entry being NULL.  That would maintain the invariant that you
>> can always dereference a pointer in the argv array.
>
> Yes, I like that better than NULL.

If we are doing {"", NULL}, then I think it makes sense that we could just 
say argc == 1 at that point, which probably sidesteps the concern Jann 
raised with the {NULL, NULL} patch, no?

Ariadne
