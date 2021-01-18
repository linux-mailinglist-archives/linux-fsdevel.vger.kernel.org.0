Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84C02FA5E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 17:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406074AbhARQR7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 11:17:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406050AbhARP6l (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:58:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EA0922472;
        Mon, 18 Jan 2021 15:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610985477;
        bh=3mL14MhIvJJvxqHYBiUoh/lNf5ixZAZYrFJjpAy7XUA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OaPn0qTXK5ef/EMCR9972JYJl08QlWqmaU8T+MiWWO0blTySDb3N/3NZvjhBO1bga
         wSAGsZAZEXpx/xYufBIZ3+WU/qyGymmVKRF7AiZPGJXKI7ZRT5Eu+ZUhdkCA7j9/px
         6+LkGA+tZd3mazIIxzGK/nlAmHvoJ3Rd4L+zvPu6qRialPJO8RIrYqhpkxGH1Qeobk
         vEmy9vhCuWQdT1lPnEZHX4JMvs/Qh50TUBaP4yA5PDv2tgBrUQjwpkxk+Ly6aWAxZ2
         lpNS3kdjHPdwqQvoXt4YqwTTUX0s01hUa9r79cvV3r9eT4MYDO4FObbrYy76dsovQ8
         Kb+qD46cHylsw==
Subject: Re: [PATCH 1/2] [v2] lib/hexdump: introduce DUMP_PREFIX_UNHASHED for
 unhashed addresses
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-mm <linux-mm@kvack.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <20210116220950.47078-1-timur@kernel.org>
 <20210116220950.47078-2-timur@kernel.org>
 <CAHp75Vdk6y8dGNJOswZwfOeva_sqVcw-f=yYgf_rptjHXxfZvw@mail.gmail.com>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <b39866a4-19cd-879b-1f3e-44126caf9193@kernel.org>
Date:   Mon, 18 Jan 2021 09:57:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vdk6y8dGNJOswZwfOeva_sqVcw-f=yYgf_rptjHXxfZvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/18/21 4:03 AM, Andy Shevchenko wrote:
> On Sun, Jan 17, 2021 at 12:12 AM Timur Tabi <timur@kernel.org> wrote:
> 
> (Hint: -v<n> to the git format-patch will create a versioned subject
> prefix for you automatically)

I like to keep the version in the git repo  itself so that I don't need 
to keep track of it separately, but thanks for the hint.  I might use it 
somewhere else.

>> Hashed addresses are useless in hexdumps unless you're comparing
>> with other hashed addresses, which is unlikely.  However, there's
>> no need to break existing code, so introduce a new prefix type
>> that prints unhashed addresses.
> 
> Any user of this? (For the record, I don't see any other mail except this one)

It's patch #2 of this set.  They were all sent together.

http://lkml.iu.edu/hypermail/linux/kernel/2101.2/00245.html

Let me know what you think.

>>          DUMP_PREFIX_NONE,
>>          DUMP_PREFIX_ADDRESS,
>> -       DUMP_PREFIX_OFFSET
>> +       DUMP_PREFIX_OFFSET,
>> +       DUMP_PREFIX_UNHASHED,
> 
> Since it's an address, I would like to group them together, i.e. put
> after DUMP_PREFIX_ADDRESS.

I didn't want to change the numbering of any existing enums, just in 
case there are users that accidentally hard-code the values.  I'm trying 
to make this patch as unobtrusive as possible.

 > Perhaps even add _ADDRESS to DUMP_PREFIX_UNHASHED, but this maybe too 
long.

I think DUMP_PREFIX_ADDRESS_UNHASHED is too long.

>> + * @prefix_type: controls whether prefix of an offset, hashed address,
>> + *  unhashed address, or none is printed (%DUMP_PREFIX_OFFSET,
>> + *  %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_UNHASHED, %DUMP_PREFIX_NONE)
> 
> Yeah, exactly, here you use different ordering.

That's because it's a comment.

>> + * @prefix_type: controls whether prefix of an offset, hashed address,
>> + *  unhashed address, or none is printed (%DUMP_PREFIX_OFFSET,
>> + *  %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_UNHASHED, %DUMP_PREFIX_NONE)
> 
> In both cases I would rather use colon and list one per line. What do you think?

Hmmmm.... if I'm going to change the patch anyway, sure.

>> +               case DUMP_PREFIX_UNHASHED:
> 
> Here is a third type of ordering, can you please be consistent?
> 
>>                  case DUMP_PREFIX_ADDRESS:

Fair enough.
