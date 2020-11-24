Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966EF2C34C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 00:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389283AbgKXXpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 18:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389255AbgKXXpJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 18:45:09 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC13CC0613D6;
        Tue, 24 Nov 2020 15:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Tkitja/Eoegmpeva7rYWnAKrxKN18IlHRbTdli2tIQs=; b=DWNAujBGt91TCkwpe1ZmzKjyFt
        hxR1cPGJ5Yf4BdO+jSBONh+Y1FbZyAFW1lTq1JDpuQjvYvACCTLl7nTKntYes8DoDOiiwu5zOb7zI
        7NMOQkskk7DrLKqBfg+jJ5ioW/UUDlXqO2HBXLh1n/bJJqwNJBs1lNCSxhLdIVC572hC3rNQJMnEr
        2JGukhY0lqbrZBofTU7x/4ONPZmjCHetDS/qNY8tb0M4keiUPVwBfT1U8vYCccxjqFkNhFJDvS6hN
        ShctBBeQfZylaxCvXjU4P0RoVFisPlkjUCFyjXvraFqB1v7YPzxtvh/xYX6hHlCcWHbwMcGXtMa8W
        zB54F0Ng==;
Received: from [2602:306:c5a2:a380:9e7b:efff:fe40:2b26]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khhzY-0007Ab-F6; Tue, 24 Nov 2020 23:45:01 +0000
Subject: Re: [PATCH v2 02/24] exec: Simplify unshare_files
To:     Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
 <20201120231441.29911-2-ebiederm@xmission.com>
 <20201123175052.GA20279@redhat.com>
 <CAHk-=wj2OnjWr696z4yzDO9_mF44ND60qBHPvi1i9DBrjdLvUw@mail.gmail.com>
 <87im9vx08i.fsf@x220.int.ebiederm.org> <87pn42r0n7.fsf@x220.int.ebiederm.org>
 <CAHk-=wi-h8y5MK83DA6Vz2TDSQf4eEadddhWLTT_94bP996=Ug@mail.gmail.com>
 <CAK8P3a3z1tZSSSyK=tZOkUTqXvewJgd6ntHMysY0gGQ7hPWwfw@mail.gmail.com>
From:   Geoff Levand <geoff@infradead.org>
Message-ID: <ed83033f-80af-5be0-ecbe-f2bf5c2075e9@infradead.org>
Date:   Tue, 24 Nov 2020 15:44:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3z1tZSSSyK=tZOkUTqXvewJgd6ntHMysY0gGQ7hPWwfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/24/20 12:14 PM, Arnd Bergmann wrote:
> On Tue, Nov 24, 2020 at 8:58 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Tue, Nov 24, 2020 at 11:55 AM Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>>>
>>> If cell happens to be dead we can remove a fair amount of generic kernel
>>> code that only exists to support cell.
>>
>> Even if some people might still use cell (which sounds unlikely), I
>> think we can remove the spu core dumping code.
> 
> The Cell blade hardware (arch/powerpc/platforms/cell/) that I'm listed
> as a maintainer for is very much dead, but there is apparently still some
> activity on the Playstation 3 that Geoff Levand maintains.
> 
> Eric correctly points out that the PS3 firmware no longer boots
> Linux (OtherOS), but AFAIK there are both users with old firmware
> and those that use a firmware exploit to run homebrew code including
> Linux.
> 
> I would assume they still use the SPU and might also use the core
> dump code in particular. Let's see what Geoff thinks.

There are still PS3-Linux users out there.  They use 'Homebrew' firmware
released through 'Hacker' forums that allow them to run Linux on
non-supported systems.  They are generally hobbies who don't post to
Linux kernel mailing lists.  I get direct inquiries regularly asking
about how to update to a recent kernel.  One of the things that attract
them to the PS3 is the Cell processor and either using or programming
the SPUs.

It is difficult to judge how much use the SPU core dump support gets,
but if it is not a cause of major problems I feel we should consider
keeping it.

-Geoff

