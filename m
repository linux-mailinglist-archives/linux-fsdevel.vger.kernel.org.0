Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9851C0DF0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 08:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgEAGAg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 02:00:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgEAGAg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 02:00:36 -0400
Received: from [192.168.0.106] (unknown [202.53.39.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE2482070B;
        Fri,  1 May 2020 06:00:30 +0000 (UTC)
Subject: Re: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem
 properly in there
To:     Rich Felker <dalias@libc.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
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
        Linux-sh list <linux-sh@vger.kernel.org>
References: <20200429214954.44866-1-jannh@google.com>
 <20200429215620.GM1551@shell.armlinux.org.uk>
 <CAHk-=wgpoEr33NJwQ+hqK1dz3Rs9jSw+BGotsSdt2Kb3HqLV7A@mail.gmail.com>
 <31196268-2ff4-7a1d-e9df-6116e92d2190@linux-m68k.org>
 <20200430145123.GE21576@brightrain.aerifal.cx>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <6dd187b4-1958-fc40-73c4-3de53ed69a1e@linux-m68k.org>
Date:   Fri, 1 May 2020 16:00:28 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430145123.GE21576@brightrain.aerifal.cx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 1/5/20 12:51 am, Rich Felker wrote:
> On Fri, May 01, 2020 at 12:10:05AM +1000, Greg Ungerer wrote:
>>
>>
>> On 30/4/20 9:03 am, Linus Torvalds wrote:
>>> On Wed, Apr 29, 2020 at 2:57 PM Russell King - ARM Linux admin
>>> <linux@armlinux.org.uk> wrote:
>>>>
>>>> I've never had any reason to use FDPIC, and I don't have any binaries
>>>> that would use it.  Nicolas Pitre added ARM support, so I guess he
>>>> would be the one to talk to about it.  (Added Nicolas.)
>>>
>>> While we're at it, is there anybody who knows binfmt_flat?
>>>
>>> It might be Nicolas too.
>>>
>>> binfmt_flat doesn't do core-dumping, but it has some other oddities.
>>> In particular, I'd like to bring sanity to the installation of the new
>>> creds, and all the _normal_ binfmt cases do it largely close together
>>> with setup_new_exec().
>>>
>>> binfmt_flat is doing odd things. It's doing this:
>>>
>>>          /* Flush all traces of the currently running executable */
>>>          if (id == 0) {
>>>                  ret = flush_old_exec(bprm);
>>>                  if (ret)
>>>                          goto err;
>>>
>>>                  /* OK, This is the point of no return */
>>>                  set_personality(PER_LINUX_32BIT);
>>>                  setup_new_exec(bprm);
>>>          }
>>>
>>> in load_flat_file() - which is also used to loading _libraries_. Where
>>> it makes no sense at all.
>>
>> I haven't looked at the shared lib support in there for a long time,
>> but I thought that "id" is only 0 for the actual final program.
>> Libraries have a slot or id number associated with them.
> 
> This sounds correct. My understanding of FLAT shared library support
> is that it's really bad and based on having preassigned slot indices
> for each library on the system, and a global array per-process to give
> to data base address for each library. Libraries are compiled to know
> their own slot numbers so that they just load from fixed_reg[slot_id]
> to get what's effectively their GOT pointer.
> 
> I'm not sure if anybody has actually used this in over a decade. Last
> time I looked the tooling appeared broken, but in this domain lots of
> users have forked private tooling that's not publicly available or at
> least not publicly indexed, so it's hard to say for sure.

Be at least 12 or 13 years since I last had a working shared library
build for m68knommu. I have not bothered with it since then, not that I
even used it much when it worked. Seemed more pain than it was worth.

Regards
Greg


