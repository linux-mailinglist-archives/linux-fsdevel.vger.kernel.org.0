Return-Path: <linux-fsdevel+bounces-24104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5B5939676
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 00:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1876B2173B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 22:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3DD4502F;
	Mon, 22 Jul 2024 22:21:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A0C1B960;
	Mon, 22 Jul 2024 22:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721686868; cv=none; b=GujsmdKG2nKfzKgwMrt4DFjAPSVZVsnykgx6IS2iOa1/YUvwLQQ5AwNS7XAsxtXtX9pU83466F9eyIR/Pet9rn8mCB9p5FDGxqrmW3Elca/X6Cggpk1ppQU6umU5Uu1uNql0kcWpkGjDWnWgJEZwJrOb0q9TE37dtYlW8/2PMJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721686868; c=relaxed/simple;
	bh=u34oHSBolYvHu5PbyqOxoctMYJ2hf/tMOZnEAdGNFnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ve6O1Jm4ecJOVNEPOGjeiO7u/7uTxxX9hwnRPZrLpQtSKRNvVLQDuH4Ug8BTFn0WNkhRwrOVlGU5Ntqv5a0zLPyHSDzsrWY1qyyLgI7OYVaUII1zx00M5hefUk140cAsfuAaP0qEVnYEksWZj+9IUk7X/Vpp8+ZsiqiMr3BCNAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46MMKYWb045436;
	Tue, 23 Jul 2024 07:20:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Tue, 23 Jul 2024 07:20:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46MMKY1t045429
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 23 Jul 2024 07:20:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e6e7cb33-f359-43bd-959e-039e82c6915a@I-love.SAKURA.ne.jp>
Date: Tue, 23 Jul 2024 07:20:34 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: tty_io: fix race between tty_fops and
 hung_up_tty_fops
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <a11e31ab-6ffc-453f-ba6a-b7f6e512c55e@I-love.SAKURA.ne.jp>
 <20240722-gehminuten-fichtenwald-9dd5a7e45bc5@brauner>
 <20240722161041.t6vizbeuxy5kj4kz@quack3>
 <2024072238-reversing-despise-b555@gregkh>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <2024072238-reversing-despise-b555@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/07/23 1:24, Greg Kroah-Hartman wrote:
> On Mon, Jul 22, 2024 at 06:10:41PM +0200, Jan Kara wrote:
>> On Mon 22-07-24 16:41:22, Christian Brauner wrote:
>>> On Fri, Jul 19, 2024 at 10:37:47PM GMT, Tetsuo Handa wrote:
>>>> syzbot is reporting data race between __tty_hangup() and __fput(), and
>>>> Dmitry Vyukov mentioned that this race has possibility of NULL pointer
>>>> dereference, for tty_fops implements e.g. splice_read callback whereas
>>>> hung_up_tty_fops does not.
>>>>
>>>>   CPU0                                  CPU1
>>>>   ----                                  ----
>>>>   do_splice_read() {
>>>>                                         __tty_hangup() {
>>>>     // f_op->splice_read was copy_splice_read
>>>>     if (unlikely(!in->f_op->splice_read))
>>>>       return warn_unsupported(in, "read");
>>>>                                           filp->f_op = &hung_up_tty_fops;
>>>>     // f_op->splice_read is now NULL
>>>>     return in->f_op->splice_read(in, ppos, pipe, len, flags);
>>>>                                         }
>>>>   }
>>>>
>>>> Fix possibility of NULL pointer dereference by implementing missing
>>>> callbacks, and suppress KCSAN messages by adding __data_racy qualifier
>>>> to "struct file"->f_op .
>>>
>>> This f_op replacing without synchronization seems really iffy imho.
>>
>> Yeah, when I saw this I was also going "ouch". I was just waiting whether a
>> tty maintainer will comment ;)
> 
> I really didn't want to :)
> 
>> Anyway this replacement of ops in file /
>> inode has proven problematic in almost every single case where it was used
>> leading to subtle issues.
> 
> Yeah, let's not do this.

https://lkml.kernel.org/r/18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp was a patch
that does not replace f_op, and
https://lkml.kernel.org/r/CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com
was a comment from Linus.

> 
> Let me dig after -rc1 is out and see if there's a better way to handle
> this contrived race condition...
> 
> thanks,
> 
> greg k-h


