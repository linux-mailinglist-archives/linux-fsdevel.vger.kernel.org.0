Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801D21C0E83
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 09:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgEAHOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 03:14:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbgEAHOv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 03:14:51 -0400
Received: from [192.168.0.106] (unknown [202.53.39.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 752A5208C3;
        Fri,  1 May 2020 07:14:46 +0000 (UTC)
Subject: Re: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem
 properly in there
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jann Horn <jannh@google.com>, Nicolas Pitre <nico@fluxnic.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <20200429214954.44866-1-jannh@google.com>
 <20200429215620.GM1551@shell.armlinux.org.uk>
 <CAHk-=wgpoEr33NJwQ+hqK1dz3Rs9jSw+BGotsSdt2Kb3HqLV7A@mail.gmail.com>
 <31196268-2ff4-7a1d-e9df-6116e92d2190@linux-m68k.org>
 <CAHk-=wjau_zmdLaFDLcY3xnqiFaC7VZDXnnzFG9QDHL4kqStYQ@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <9d4a2520-f41c-aed1-4ce0-274370eb4503@linux-m68k.org>
Date:   Fri, 1 May 2020 17:14:43 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjau_zmdLaFDLcY3xnqiFaC7VZDXnnzFG9QDHL4kqStYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 1/5/20 2:54 am, Linus Torvalds wrote:
> On Thu, Apr 30, 2020 at 7:10 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>>
>>> in load_flat_file() - which is also used to loading _libraries_. Where
>>> it makes no sense at all.
>>
>> I haven't looked at the shared lib support in there for a long time,
>> but I thought that "id" is only 0 for the actual final program.
>> Libraries have a slot or id number associated with them.
> 
> Yes, that was my assumption, but looking at the code, it really isn't
> obvious that that is the case at all.
> 
> 'id' gets calculated from fields that very much look like they could
> be zero (eg by taking the top bits from another random field).
> 
>>> Most of that file goes back to pre-git days. And most of the commits
>>> since are not so much about binfmt_flat, as they are about cleanups or
>>> changes elsewhere where binfmt_flat was just a victim.
>>
>> I'll have a look at this.
> 
> Thanks.
> 
>> Quick hack test shows moving setup_new_exec(bprm) to be just before
>> install_exec_creds(bprm) works fine for the static binaries case.
>> Doing the flush_old_exec(bprm) there too crashed out - I'll need to
>> dig into that to see why.
> 
> Just moving setup_new_exec() would at least allow us to then join the
> two together, and just say "setup_new_exec() does the credential
> installation too".
> 
> So to some degree, that's the important one.
> 
> But that flush_old_exec() does look odd in load_flat_file(). It's not
> like anything but executing a binary should flush the old exec.
> Certainly not loading a library, however odd that flat library code
> is.
> 
> My _guess_ is that the reason for this is that "load_flat_file()" also
> does a lot of verification of the file and does that whole "return
> -ENOEXEC if the file format isn't right". So we don't want to flush
> the old exec before that is done, but we obviously also don't want to
> flush the old exec after we've actually loaded the new one into
> memory..

Yeah, that is what it looks like. Looking at the history, the introduction
of setup_new_exec() [in commit 221af7f87b974] was probably just
added where the the existing flush_old_exec() was.


> So the location of flush_old_exec() makes that kind of sense, but it
> would have made it better if that flat file support had a clear
> separation of "check the file" from "load the file".
> 
> Oh well. As mentioned, the whole "at least put setup_new_exec() and
> install_exec_creds() together" is the bigger thing.
> 
> But if it's true that nobody really uses the odd flat library support
> any more and there are no testers, maybe we should consider ripping it
> out...

I am for that. If nobody pipes up and complains I'll look at taking it out.

Regards
Greg

