Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED5F1C0DDC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 07:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgEAFo2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 01:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgEAFo2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 01:44:28 -0400
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEAF820731;
        Fri,  1 May 2020 05:44:20 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem
 properly in there
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jann Horn <jannh@google.com>, Nicolas Pitre <nico@fluxnic.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
 <87imhgyeqt.fsf@x220.int.ebiederm.org>
Message-ID: <9dd76936-0009-31e4-d869-f64d01886642@linux-m68k.org>
Date:   Fri, 1 May 2020 15:44:03 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87imhgyeqt.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 1/5/20 5:07 am, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
>> On Thu, Apr 30, 2020 at 7:10 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> 
>>>> Most of that file goes back to pre-git days. And most of the commits
>>>> since are not so much about binfmt_flat, as they are about cleanups or
>>>> changes elsewhere where binfmt_flat was just a victim.
>>>
>>> I'll have a look at this.
>>
>> Thanks.
>>
>>> Quick hack test shows moving setup_new_exec(bprm) to be just before
>>> install_exec_creds(bprm) works fine for the static binaries case.
>>> Doing the flush_old_exec(bprm) there too crashed out - I'll need to
>>> dig into that to see why.
>>
>> Just moving setup_new_exec() would at least allow us to then join the
>> two together, and just say "setup_new_exec() does the credential
>> installation too".
> 
> But it is only half a help if we allow failure points between
> flush_old_exec and install_exec_creds.
> 
> Greg do things work acceptably if install_exec_creds is moved to right
> after setup_new_exec? (patch below)

Yes, confirmed. Worked fine with that patch applied.


> Looking at the code in load_flat_file after setup_new_exec it looks like
> the kinds of things that in binfmt_elf.c we do after install_exec_creds
> (aka vm_map).  So I think we want install_exec_creds sooner, instead
> of setup_new_exec later.
> 
>> But if it's true that nobody really uses the odd flat library support
>> any more and there are no testers, maybe we should consider ripping it
>> out...
> 
> I looked a little deeper and there is another reason to think about
> ripping out the flat library loader.  The code is recursive, and
> supports a maximum of 4 shared libraries in the entire system.
> 
> load_flat_binary
> 	load_flat_file
>          	calc_reloc
>                  	load_flat_shared_libary
>                          	load_flat_file
>                                  	....
> 
> I am mystified with what kind of system can survive with a grand total
> of 4 shared libaries.  I think my a.out slackware system that I ran on
> my i486 had more shared libraries.

The kind of embedded systems that were built with this stuff 20 years
ago didn't have lots of applications and libraries. I think we found
back then that most of your savings were from making libc shared.
Less significant gains from making other libraries shared. And there
was a bit of extra pain in setting them up with the shared library
code generation options (that had to be unique for each one).

The whole mechanism is a bit of hack, and there was a few other
limitations with the way it worked (I don't recall what they were
right now).

I am definitely in favor of removing it.

Regards
Greg



> Having read just a bit more it is definitely guaranteed (by the code)
> that the first time load_flat_file is called id 0 will be used (aka id 0
> is guaranteed to be the binary), and the ids 1, 2, 3 and 4 will only be
> used if a relocation includes that id to reference an external shared
> library.  That part of the code is drop dead simple.
> 
> ---
> 
> This is what I was thinking about applying.
> 
> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> index 831a2b25ba79..1a1d1fcb893f 100644
> --- a/fs/binfmt_flat.c
> +++ b/fs/binfmt_flat.c
> @@ -541,6 +541,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>   		/* OK, This is the point of no return */
>   		set_personality(PER_LINUX_32BIT);
>   		setup_new_exec(bprm);
> +		install_exec_creds(bprm);
>   	}
>   
>   	/*
> @@ -963,8 +964,6 @@ static int load_flat_binary(struct linux_binprm *bprm)
>   		}
>   	}
>   
> -	install_exec_creds(bprm);
> -
>   	set_binfmt(&flat_format);
>   
>   #ifdef CONFIG_MMU
> 
> 
