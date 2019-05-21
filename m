Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5B824FD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 15:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfEUNKs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 09:10:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfEUNKs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 09:10:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A31313086231;
        Tue, 21 May 2019 13:10:24 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-219.str.redhat.com [10.33.192.219])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52692665F4;
        Tue, 21 May 2019 13:10:13 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        jannh@google.com, oleg@redhat.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, arnd@arndb.de, shuah@kernel.org,
        dhowells@redhat.com, tkjos@android.com, ldv@altlinux.org,
        miklos@szeredi.hu, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 1/2] open: add close_range()
References: <20190521113448.20654-1-christian@brauner.io>
        <87tvdoau12.fsf@oldenburg2.str.redhat.com>
        <20190521130438.q3u4wvve7p6md6cm@brauner.io>
Date:   Tue, 21 May 2019 15:10:11 +0200
In-Reply-To: <20190521130438.q3u4wvve7p6md6cm@brauner.io> (Christian Brauner's
        message of "Tue, 21 May 2019 15:04:39 +0200")
Message-ID: <87h89o9cng.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 21 May 2019 13:10:47 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Christian Brauner:

>> Solaris has an fdwalk function:
>> 
>>   <https://docs.oracle.com/cd/E88353_01/html/E37843/closefrom-3c.html>
>> 
>> So a different way to implement this would expose a nextfd system call
>
> Meh. If nextfd() then I would like it to be able to:
> - get the nextfd(fd) >= fd
> - get highest open fd e.g. nextfd(-1)

The highest open descriptor isn't istering for fdwalk because nextfd
would just fail.

> But then I wonder if nextfd() needs to be a syscall and isn't just
> either:
> fcntl(fd, F_GET_NEXT)?
> or
> prctl(PR_GET_NEXT)?

I think the fcntl route is a bit iffy because you might need it to get
the *first* valid descriptor.

>> to userspace, so that we can use that to implement both fdwalk and
>> closefrom.  But maybe fdwalk is just too obscure, given the existence of
>> /proc.
>
> Yeah we probably don't need fdwalk.

Agreed.  Just wanted to bring it up for completeness.  I certainly don't
want to derail the implementation of close_range.

Thanks,
Florian
