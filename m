Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09F7257E65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 18:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHaQNq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 12:13:46 -0400
Received: from sandeen.net ([63.231.237.45]:40924 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728394AbgHaQNo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:13:44 -0400
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 25B693248;
        Mon, 31 Aug 2020 11:13:24 -0500 (CDT)
Subject: Re: [PATCH v2] iomap: Fix WARN_ON_ONCE() from unprivileged users
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Qian Cai <cai@lca.pw>, hch@infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200831014511.17174-1-cai@lca.pw>
 <d34753a2-57bf-8013-015a-adeb3fe9447c@sandeen.net>
 <20200831155652.GE6096@magnolia>
From:   Eric Sandeen <sandeen@sandeen.net>
Message-ID: <01443940-2006-d44e-d4b1-e45852a3c4a5@sandeen.net>
Date:   Mon, 31 Aug 2020 11:13:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.0
MIME-Version: 1.0
In-Reply-To: <20200831155652.GE6096@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/31/20 10:56 AM, Darrick J. Wong wrote:
> On Mon, Aug 31, 2020 at 10:48:59AM -0500, Eric Sandeen wrote:
>> On 8/30/20 8:45 PM, Qian Cai wrote:
>>> It is trivial to trigger a WARN_ON_ONCE(1) in iomap_dio_actor() by
>>> unprivileged users which would taint the kernel, or worse - panic if
>>> panic_on_warn or panic_on_taint is set. Hence, just convert it to
>>> pr_warn_ratelimited() to let users know their workloads are racing.
>>> Thanks Dave Chinner for the initial analysis of the racing reproducers.
>>>
>>> Signed-off-by: Qian Cai <cai@lca.pw>
>>> ---
>>>
>>> v2: Record the path, pid and command as well.
>>>
>>>  fs/iomap/direct-io.c | 17 ++++++++++++++++-
>>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>>> index c1aafb2ab990..66a4502ef675 100644
>>> --- a/fs/iomap/direct-io.c
>>> +++ b/fs/iomap/direct-io.c
>>> @@ -374,6 +374,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
>>>  		void *data, struct iomap *iomap, struct iomap *srcmap)
>>>  {
>>>  	struct iomap_dio *dio = data;
>>> +	char pathname[128], *path;
>>>  
>>>  	switch (iomap->type) {
>>>  	case IOMAP_HOLE:
>>> @@ -389,7 +390,21 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
>>>  	case IOMAP_INLINE:
>>>  		return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
>>>  	default:
>>> -		WARN_ON_ONCE(1);
>>
>> It seems like we should explicitly catch IOMAP_DELALLOC for this case, and leave the
>> default: as a WARN_ON that is not user-triggerable? i.e.
>>
>> case IOMAP_DELALLOC:
>> 	<all the fancy warnings>
>> 	return -EIO;
>> default:
>> 	WARN_ON_ONCE(1);
>> 	return -EIO;
>>
>>> +		/*
>>> +		 * DIO is not serialised against mmap() access at all, and so
>>> +		 * if the page_mkwrite occurs between the writeback and the
>>> +		 * iomap_apply() call in the DIO path, then it will see the
>>> +		 * DELALLOC block that the page-mkwrite allocated.
>>> +		 */
>>> +		path = file_path(dio->iocb->ki_filp, pathname,
>>> +				 sizeof(pathname));
>>> +		if (IS_ERR(path))
>>> +			path = "(unknown)";
>>> +
>>> +		pr_warn_ratelimited("page_mkwrite() is racing with DIO read (iomap->type = %u).\n"
>>> +				    "File: %s PID: %d Comm: %.20s\n",
>>> +				    iomap->type, path, current->pid,
>>> +				    current->comm);
>>
>> This is very specific ...
>>
>> Do we know that mmap/page_mkwrite is (and will always be) the only way to reach this
>> point?
>>
>> It seems to me that this message won't be very useful for the admin; "pg_mkwrite" may
>> mean something to us, but doubtful for the general public.  And "type = 1" won't mean
>> much to the reader, either.
>>
>> Maybe something like:
>>
>> "DIO encountered delayed allocation block, racing buffered+direct? File: %s Comm: %.20s\n"
>>
>> It just seems that a user-facing warning should be something the admin has a chance of
>> acting on without needing to file a bug for analysis by the developers.
>>
>> (though TBH "delayed allocation" probably doesn't mean much to the admin, either)
> 
> /me suggests
> 
> "Direct I/O collision with buffered write!  File: %s..."?

Sure, that sounds good to me.  Terser is better.

> I concede that we ought to leave the nastier WARN for the default
> case since there are no other IOMAP_ types and so any other code is
> a sign of a serious screwup.

*nod* thanks.

-Eric

