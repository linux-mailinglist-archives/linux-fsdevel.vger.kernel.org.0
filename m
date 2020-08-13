Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA34243CB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 17:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgHMPlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 11:41:21 -0400
Received: from verein.lst.de ([213.95.11.211]:46775 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgHMPlU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:41:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 402BC68AFE; Thu, 13 Aug 2020 17:41:18 +0200 (CEST)
Date:   Thu, 13 Aug 2020 17:41:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@lst.de>, viro@ZenIV.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com, willy@infradead.org
Subject: Re: [PATCH][v2] proc: use vmalloc for our kernel buffer
Message-ID: <20200813154117.GA14149@lst.de>
References: <20200813145305.805730-1-josef@toxicpanda.com> <20200813153356.857625-1-josef@toxicpanda.com> <20200813153722.GA13844@lst.de> <974e469e-e73d-6c3e-9167-fad003f1dfb9@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <974e469e-e73d-6c3e-9167-fad003f1dfb9@toxicpanda.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 11:40:00AM -0400, Josef Bacik wrote:
> On 8/13/20 11:37 AM, Christoph Hellwig wrote:
>> On Thu, Aug 13, 2020 at 11:33:56AM -0400, Josef Bacik wrote:
>>> Since
>>>
>>>    sysctl: pass kernel pointers to ->proc_handler
>>>
>>> we have been pre-allocating a buffer to copy the data from the proc
>>> handlers into, and then copying that to userspace.  The problem is this
>>> just blind kmalloc()'s the buffer size passed in from the read, which in
>>> the case of our 'cat' binary was 64kib.  Order-4 allocations are not
>>> awesome, and since we can potentially allocate up to our maximum order,
>>> use vmalloc for these buffers.
>>>
>>> Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>> v1->v2:
>>> - Make vmemdup_user_nul actually do the right thing...sorry about that.
>>>
>>>   fs/proc/proc_sysctl.c  |  6 +++---
>>>   include/linux/string.h |  1 +
>>>   mm/util.c              | 27 +++++++++++++++++++++++++++
>>>   3 files changed, 31 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>>> index 6c1166ccdaea..207ac6e6e028 100644
>>> --- a/fs/proc/proc_sysctl.c
>>> +++ b/fs/proc/proc_sysctl.c
>>> @@ -571,13 +571,13 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
>>>   		goto out;
>>>     	if (write) {
>>> -		kbuf = memdup_user_nul(ubuf, count);
>>> +		kbuf = vmemdup_user_nul(ubuf, count);
>>
>> Given that this can also do a kmalloc and thus needs to be paired
>> with kvfree shouldn't it be kvmemdup_user_nul?
>>
>
> There's an existing vmemdup_user that does kvmalloc, so I followed the 
> existing naming convention.  Do you want me to change them both?  Thanks,

I personally would, and given that it only has a few users it might
even be feasible.
