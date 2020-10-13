Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE8D28D6A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 00:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgJMWpI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 18:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728686AbgJMWpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 18:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602629105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eL27MHQVYn4ElBKK1XQ1LogMRdkFND/1MAckF558KzI=;
        b=Za+EAKP/Imh9W8UvYkMmVs3ZpSUoRVZxMOExz1z0iz9+OMEksgoMcU0UVTSJtFH4Mr6GYr
        /lvfmwXeVID3+EwBcdvHTXu7IhoKGgCPAZ66RdC+5f/v5w8DOmDEn07mveVD+S8rDDnGtI
        MfwFu5wQO0Dshkf6R/ooyq0uHnHf5Gc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-kP5hsnsGMxK64HuHe2ZLyA-1; Tue, 13 Oct 2020 18:45:04 -0400
X-MC-Unique: kP5hsnsGMxK64HuHe2ZLyA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B9C5107AD91;
        Tue, 13 Oct 2020 22:45:02 +0000 (UTC)
Received: from localhost (ovpn-112-103.ams2.redhat.com [10.36.112.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28DD25D9CD;
        Tue, 13 Oct 2020 22:45:01 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] fs, close_range: add flag CLOSE_RANGE_CLOEXEC
References: <20201013140609.2269319-1-gscrivan@redhat.com>
        <20201013140609.2269319-2-gscrivan@redhat.com>
        <20201013205427.clvqno24ctwxbuyv@wittgenstein>
Date:   Wed, 14 Oct 2020 00:45:00 +0200
In-Reply-To: <20201013205427.clvqno24ctwxbuyv@wittgenstein> (Christian
        Brauner's message of "Tue, 13 Oct 2020 22:54:27 +0200")
Message-ID: <87imbdrbir.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Tue, Oct 13, 2020 at 04:06:08PM +0200, Giuseppe Scrivano wrote:
>
> Hey Guiseppe,
>
> Thanks for the patch!
>
>> When the flag CLOSE_RANGE_CLOEXEC is set, close_range doesn't
>> immediately close the files but it sets the close-on-exec bit.
>
> Hm, please expand on the use-cases a little here so people know where
> and how this is useful. Keeping the rationale for a change in the commit
> log is really important.
>
>> 
>> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
>> ---
>
>>  fs/file.c                        | 56 ++++++++++++++++++++++----------
>>  include/uapi/linux/close_range.h |  3 ++
>>  2 files changed, 42 insertions(+), 17 deletions(-)
>> 
>> diff --git a/fs/file.c b/fs/file.c
>> index 21c0893f2f1d..ad4ebee41e09 100644
>> --- a/fs/file.c
>> +++ b/fs/file.c
>> @@ -672,6 +672,17 @@ int __close_fd(struct files_struct *files, unsigned fd)
>>  }
>>  EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
>>  
>> +static unsigned int __get_max_fds(struct files_struct *cur_fds)
>> +{
>> +	unsigned int max_fds;
>> +
>> +	rcu_read_lock();
>> +	/* cap to last valid index into fdtable */
>> +	max_fds = files_fdtable(cur_fds)->max_fds;
>> +	rcu_read_unlock();
>> +	return max_fds;
>> +}
>> +
>>  /**
>>   * __close_range() - Close all file descriptors in a given range.
>>   *
>> @@ -683,27 +694,23 @@ EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
>>   */
>>  int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
>>  {
>> -	unsigned int cur_max;
>> +	unsigned int cur_max = UINT_MAX;
>>  	struct task_struct *me = current;
>>  	struct files_struct *cur_fds = me->files, *fds = NULL;
>>  
>> -	if (flags & ~CLOSE_RANGE_UNSHARE)
>> +	if (flags & ~(CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC))
>>  		return -EINVAL;
>>  
>>  	if (fd > max_fd)
>>  		return -EINVAL;
>>  
>> -	rcu_read_lock();
>> -	cur_max = files_fdtable(cur_fds)->max_fds;
>> -	rcu_read_unlock();
>> -
>> -	/* cap to last valid index into fdtable */
>> -	cur_max--;
>> -
>>  	if (flags & CLOSE_RANGE_UNSHARE) {
>>  		int ret;
>>  		unsigned int max_unshare_fds = NR_OPEN_MAX;
>>  
>> +		/* cap to last valid index into fdtable */
>> +		cur_max = __get_max_fds(cur_fds) - 1;
>> +
>>  		/*
>>  		 * If the requested range is greater than the current maximum,
>>  		 * we're closing everything so only copy all file descriptors
>> @@ -724,16 +731,31 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
>>  			swap(cur_fds, fds);
>>  	}
>>  
>> -	max_fd = min(max_fd, cur_max);
>> -	while (fd <= max_fd) {
>> -		struct file *file;
>> +	if (flags & CLOSE_RANGE_CLOEXEC) {
>> +		struct fdtable *fdt;
>>  
>> -		file = pick_file(cur_fds, fd++);
>> -		if (!file)
>> -			continue;
>> +		spin_lock(&cur_fds->file_lock);
>> +		fdt = files_fdtable(cur_fds);
>> +		cur_max = fdt->max_fds - 1;
>> +		max_fd = min(max_fd, cur_max);
>> +		while (fd <= max_fd)
>> +			__set_close_on_exec(fd++, fdt);
>> +		spin_unlock(&cur_fds->file_lock);
>> +	} else {
>> +		/* Initialize cur_max if needed.  */
>> +		if (cur_max == UINT_MAX)
>> +			cur_max = __get_max_fds(cur_fds) - 1;
>
> The separation between how cur_fd is retrieved in the two branches makes
> the code more difficult to follow imho. Unless there's a clear reason
> why you've done it that way I would think that something like the patch
> I appended below might be a little clearer and easier to maintain(?).

Thanks for the review!

I've opted for this version as in the flags=CLOSE_RANGE_CLOEXEC case we
can read max_fds directly from the fds table and avoid doing it from the
RCU critical section as well.  I'll change it in favor of more readable
code.

Giuseppe

