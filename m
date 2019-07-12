Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABC3567686
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2019 00:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfGLW3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 18:29:53 -0400
Received: from bran.ispras.ru ([83.149.199.196]:26789 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727245AbfGLW3x (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 18:29:53 -0400
Received: from [10.10.3.112] (starling.intra.ispras.ru [10.10.3.112])
        by smtp.ispras.ru (Postfix) with ESMTP id 38328201D0;
        Sat, 13 Jul 2019 01:29:50 +0300 (MSK)
Subject: Re: [PATCH] proc: Fix uninitialized byte read in get_mm_cmdline()
To:     Jakub Jankowski <shasta@toxcorp.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        security@kernel.org
References: <20190712160913.17727-1-izbyshev@ispras.ru>
 <20190712163625.GF21989@redhat.com> <20190712174632.GA3175@avx2>
 <3de2d71b-37be-6238-7fd8-0a40c9b94a98@ispras.ru>
 <alpine.LNX.2.21.1907122312190.8869@kich.toxcorp.com>
From:   Alexey Izbyshev <izbyshev@ispras.ru>
Message-ID: <4f729521-7c34-251b-3939-dfcdc96aa50a@ispras.ru>
Date:   Sat, 13 Jul 2019 01:29:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1907122312190.8869@kich.toxcorp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/13/19 12:17 AM, Jakub Jankowski wrote:
> On 2019-07-12, Alexey Izbyshev wrote:
> 
>> On 7/12/19 8:46 PM, Alexey Dobriyan wrote:
>>> The proper fix to all /proc/*/cmdline problems is to revert
>>>
>>>     f5b65348fd77839b50e79bc0a5e536832ea52d8d
>>>     proc: fix missing final NUL in get_mm_cmdline() rewrite
>>>
>>>     5ab8271899658042fabc5ae7e6a99066a210bc0e
>>>     fs/proc: simplify and clarify get_mm_cmdline() function
>>>
>> Should this be interpreted as an actual suggestion to revert the patches,
>> fix the conflicts, test and submit them, or is this more like thinking out
>> loud? In the former case, will it be OK for long term branches?
>>
>> get_mm_cmdline() does seem easier to read for me before 5ab8271899658042.
>> But it also has different semantics in corner cases, for example:
>>
>> - If there is no NUL at arg_end-1, it reads only the first string in
>> the combined arg/env block, and doesn't terminate it with NUL.
>>
>> - If there is any problem with access_remote_vm() or copy_to_user(),
>> it returns -EFAULT even if some data were copied to userspace.
>>
>> On the other hand, 5ab8271899658042 was merged not too long ago (about a year),
>> so it's possible that the current semantics isn't heavily relied upon.
> 
> I posted this (corner?) case ~3 months ago, unfortunately it wasn't picked up by anyone: https://lkml.org/lkml/2019/4/5/825
> You can treat it as another datapoint in this discussion.
> 
Thanks, this is interesting. Perl explicitly relies on special treatment of
non-NUL at arg_end-1 in pre-5ab8271899658042: on argv0 replace, it fills
everything after the new argv0 in the combined argv/env block with spaces [1,2].

While personally I don't approve what Perl does here, 5ab8271899658042
did change the user-visible behavior in this case.

[1] https://perl5.git.perl.org/perl.git/blob/86b50d930caa:/mg.c#l2733
[2] https://perl5.git.perl.org/perl.git/blob/86b50d930caa:/perl.c#l1698

Alexey
> 
> Regards,
>  Jakub
> 

