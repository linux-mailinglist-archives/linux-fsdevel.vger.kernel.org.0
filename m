Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E1916FE63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 12:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgBZL4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 06:56:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31600 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726778AbgBZL4j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582718196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kes1Xqw+1cWrJLQG0qYyTWlY5Y7hTOalTGh/2tQIWrw=;
        b=iuRisaG0xBxBJb3LjcnE3SM4nSQgPjpW+2t8t7GRGKIObVFxCwEjjqeue6zUBvVDtV/zA2
        VWIowZIAPsB+BLwLpSo03DRrPWmqhWTIQKwy31/qyHRM0Rva6kKX7SQRmEzFQhn+XHkk5B
        3d+8zSFdNppTXVMwf65BX1FwPhken+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-sDzgd2KaPoCrKXXKjP6e-w-1; Wed, 26 Feb 2020 06:56:35 -0500
X-MC-Unique: sDzgd2KaPoCrKXXKjP6e-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1816418FE860;
        Wed, 26 Feb 2020 11:56:33 +0000 (UTC)
Received: from mohegan.the-transcend.com (unknown [10.36.118.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6453B10027AE;
        Wed, 26 Feb 2020 11:56:30 +0000 (UTC)
Subject: Re: [PATCH V4 07/13] fs: Add locking for a dynamic address space
 operations state
To:     Jan Kara <jack@suse.cz>
Cc:     Jeff Moyer <jmoyer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>, ira.weiny@intel.com,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200221004134.30599-1-ira.weiny@intel.com>
 <20200221004134.30599-8-ira.weiny@intel.com> <20200221174449.GB11378@lst.de>
 <20200221224419.GW10776@dread.disaster.area> <20200224175603.GE7771@lst.de>
 <20200225000937.GA10776@dread.disaster.area> <20200225173633.GA30843@lst.de>
 <x49fteyh313.fsf@segfault.boston.devel.redhat.com>
 <a126276c-d252-6050-b6ee-4d6448d45fac@redhat.com>
 <20200226113130.GG10728@quack2.suse.cz>
From:   Jonathan Halliday <jonathan.halliday@redhat.com>
Message-ID: <95f5eaab-d961-bab6-e9c4-a14282f7f378@redhat.com>
Date:   Wed, 26 Feb 2020 11:56:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226113130.GG10728@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 26/02/2020 11:31, Jan Kara wrote:
> Hello,
> 
> On Wed 26-02-20 09:28:57, Jonathan Halliday wrote:
>> I'm a middleware developer, focused on how Java (JVM) workloads can benefit
>> from app-direct mode pmem. Initially the target is apps that need a fast
>> binary log for fault tolerance: the classic database WAL use case;
>> transaction coordination systems; enterprise message bus persistence and
>> suchlike. Critically, there are cases where we use log based storage, i.e.
>> it's not the strict 'read rarely, only on recovery' model that a classic db
>> may have, but more of a 'append only, read many times' event stream model.
>>
>> Think of the log oriented data storage as having logical segments (let's
>> implement them as files), of which the most recent is being appended to
>> (read_write) and the remaining N-1 older segments are full and sealed, so
>> effectively immutable (read_only) until discarded. The tail segment needs to
>> be in DAX mode for optimal write performance, as the size of the append may
>> be sub-block and we don't want the overhead of the kernel call anyhow. So
>> that's clearly a good fit for putting on a DAX fs mount and using mmap with
>> MAP_SYNC.
>>
>> However, we want fast read access into the segments, to retrieve stored
>> records. The small access index can be built in volatile RAM (assuming we're
>> willing to take the startup overhead of a full file scan at recovery time)
>> but the data itself is big and we don't want to move it all off pmem. Which
>> means the requirements are now different: we want the O/S cache to pull hot
>> data into fast volatile RAM for us, which DAX explicitly won't do.
>> Effectively a poor man's 'memory mode' pmem, rather than app-direct mode,
>> except here we're using the O/S rather than the hardware memory controller
>> to do the cache management for us.
>>
>> Currently this requires closing the full (read_write) file, then copying it
>> to a non-DAX device and reopening it (read_only) there. Clearly that's
>> expensive and rather tedious. Instead, I'd like to close the MAP_SYNC mmap,
>> then, leaving the file where it is, reopen it in a mode that will instead go
>> via the O/S cache in the traditional manner. Bonus points if I can do it
>> over non-overlapping ranges in a file without closing the DAX mode mmap,
>> since then the segments are entirely logical instead of needing separate
>> physical files.
>>
>> I note a comment below regarding a per-directly setting, but don't have the
>> background to fully understand what's being suggested. However, I'll note
>> here that I can live with a per-directory granularity, as relinking a file
>> into a new dir is a constant time operation, whilst the move described above
>> isn't. So if a per-directory granularity is easier than a per-file one
>> that's fine, though as a person with only passing knowledge of filesystem
>> design I don't see how having multiple links to a file can work cleanly in
>> that case.
> 
> Well, with per-directory setting, relinking the file will not magically
> make it stop using DAX. So your situation would be very similar to the
> current one, except "copy to non-DAX device" can be replaced by "copy to
> non-DAX directory". Maybe the "copy" part could be actually reflink which
> would make it faster.

Indeed. The requirement is for 'change mode in constant time' rather 
than the current 'change mode in time proportional to file size'. That 
seems to imply requiring the approach to just change fs metadata, 
without relocating the file data bytes. Beyond that I'm largely 
indifferent to the implementation details.

>> P.S. I'll cheekily take the opportunity of having your attention to tack on
>> one minor gripe about the current system: The only way to know if a mmap
>> with MAP_SYNC will work is to try it and catch the error. Which would be
>> reasonable if it were free of side effects.  However, the process requires
>> first expanding the file to at least the size of the desired map, which is
>> done non-atomically i.e. is user visible. There are thus nasty race
>> conditions in the cleanup, where after a failed mmap attempt (e.g the device
>> doesn't support DAX), we try to shrink the file back to its original size,
>> but something else has already opened it at its new, larger size. This is
>> not theoretical: I got caught by it whilst adapting some of our middleware
>> to use pmem.  Therefore, some way to probe the file path for its capability
>> would be nice, much the same as I can e.g. inspect file permissions to (more
>> or less) evaluate if I can write it without actually mutating it.  Thanks!
> 
> Well, reporting error on mmap(2) is the only way how to avoid
> time-to-check-time-to-use races. And these are very important when we are
> speaking about data integrity guarantees. So that's not going to change.
> But with Ira's patches you could use statx(2) to check whether file at
> least supports DAX and so avoid doing mmap check with the side effects in
> the common case where it's hopeless... I'd also think that you could
> currently do mmap check with the current file size and if it succeeds,
> expand the file to the desired size and mmap again. It's not ideal but it
> should work.

Sure. Best effort is fine here, just as with looking at the permission 
bits on a file example - even in the absence of racing permission 
changes it's not definitive because of additional quota or selinux 
checks, but it's a reasonable approximation. That's a sufficiently 
useful improvement for my purposes, given the impractical nature of a 
100% solution.

Jonathan


-- 
Registered in England and Wales under Company Registration No. 03798903 
Directors: Michael Cunningham, Michael ("Mike") O'Neill, Eric Shander

