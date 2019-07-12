Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 100BB6752E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 20:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfGLSnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 14:43:05 -0400
Received: from bran.ispras.ru ([83.149.199.196]:19157 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727053AbfGLSnF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 14:43:05 -0400
Received: from [10.10.3.112] (starling.intra.ispras.ru [10.10.3.112])
        by smtp.ispras.ru (Postfix) with ESMTP id 284A8201D0;
        Fri, 12 Jul 2019 21:43:03 +0300 (MSK)
Subject: Re: [PATCH] proc: Fix uninitialized byte read in get_mm_cmdline()
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        security@kernel.org
References: <20190712160913.17727-1-izbyshev@ispras.ru>
 <20190712163625.GF21989@redhat.com> <20190712174632.GA3175@avx2>
From:   Alexey Izbyshev <izbyshev@ispras.ru>
Message-ID: <3de2d71b-37be-6238-7fd8-0a40c9b94a98@ispras.ru>
Date:   Fri, 12 Jul 2019 21:43:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190712174632.GA3175@avx2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/12/19 8:46 PM, Alexey Dobriyan wrote:
> On Fri, Jul 12, 2019 at 06:36:26PM +0200, Oleg Nesterov wrote:
>> On 07/12, Alexey Izbyshev wrote:
>>>
>>> --- a/fs/proc/base.c
>>> +++ b/fs/proc/base.c
>>> @@ -275,6 +275,8 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
>>>  		if (got <= offset)
>>>  			break;
>>>  		got -= offset;
>>> +		if (got < size)
>>> +			size = got;
>>
>> Acked-by: Oleg Nesterov <oleg@redhat.com>
> 
> The proper fix to all /proc/*/cmdline problems is to revert
> 
> 	f5b65348fd77839b50e79bc0a5e536832ea52d8d
> 	proc: fix missing final NUL in get_mm_cmdline() rewrite
> 
> 	5ab8271899658042fabc5ae7e6a99066a210bc0e
> 	fs/proc: simplify and clarify get_mm_cmdline() function
> 
Should this be interpreted as an actual suggestion to revert the patches,
fix the conflicts, test and submit them, or is this more like thinking out
loud? In the former case, will it be OK for long term branches?

get_mm_cmdline() does seem easier to read for me before 5ab8271899658042.
But it also has different semantics in corner cases, for example:

- If there is no NUL at arg_end-1, it reads only the first string in
the combined arg/env block, and doesn't terminate it with NUL.

- If there is any problem with access_remote_vm() or copy_to_user(),
it returns -EFAULT even if some data were copied to userspace.

On the other hand, 5ab8271899658042 was merged not too long ago (about a year),
so it's possible that the current semantics isn't heavily relied upon.

Alexey
