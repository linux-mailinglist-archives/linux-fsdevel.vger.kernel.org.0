Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28F751897
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 18:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfFXQZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 12:25:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:53858 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbfFXQZy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:25:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0AF07ADDA;
        Mon, 24 Jun 2019 16:25:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Jun 2019 18:25:52 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 13/14] epoll: implement epoll_create2() syscall
In-Reply-To: <CAK8P3a3YgKZbF=nx4nsbj5mvgcSk8OfjU1HNvSjC19RPsyVMsQ@mail.gmail.com>
References: <20190624144151.22688-1-rpenyaev@suse.de>
 <20190624144151.22688-14-rpenyaev@suse.de>
 <CAK8P3a3YgKZbF=nx4nsbj5mvgcSk8OfjU1HNvSjC19RPsyVMsQ@mail.gmail.com>
Message-ID: <d1603e27672acbc72c20bd2b03b80f9c@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-06-24 18:14, Arnd Bergmann wrote:
> On Mon, Jun 24, 2019 at 4:42 PM Roman Penyaev <rpenyaev@suse.de> wrote:
>> 
>> epoll_create2() is needed to accept EPOLL_USERPOLL flags
>> and size, i.e. this patch wires up polling from userspace.
> 
> Can you explain in the patch description more what it's needed for?

Sure. Will update on next iteration.

> 
> The man page only states that "Since Linux 2.6.8, the size argument
> is ignored", so your description above does not explain why you need
> to add the size argument back.
> 
>> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl 
>> b/arch/alpha/kernel/syscalls/syscall.tbl
>> index 1db9bbcfb84e..a1d7b695063d 100644
>> --- a/arch/alpha/kernel/syscalls/syscall.tbl
>> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
>> @@ -474,3 +474,5 @@
>>  542    common  fsmount                         sys_fsmount
>>  543    common  fspick                          sys_fspick
>>  544    common  pidfd_open                      sys_pidfd_open
>> +# 546  common  clone3                  sys_clone3
>> +547    common  epoll_create2                   sys_epoll_create2
>> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
>> index ff45d8807cb8..1497f3c87d54 100644
>> --- a/arch/arm/tools/syscall.tbl
>> +++ b/arch/arm/tools/syscall.tbl
>> @@ -449,3 +449,4 @@
>>  433    common  fspick                          sys_fspick
>>  434    common  pidfd_open                      sys_pidfd_open
>>  436    common  clone3                          sys_clone3
>> +437    common  epoll_create2                   sys_epoll_create2
> 
> The table changes all look correct and complete, provided we
> don't get another patch picking the same number.

Good.  I had doubts, because on some archs there is a gap,
(sys_clone3 was missing).  So I left a placeholder, so
can be uncommented when sys_clone3 is implemented.

--
Roman

