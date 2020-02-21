Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8829A1686B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 19:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgBUSdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 13:33:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52434 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726066AbgBUSdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:33:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582309978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1v386c33OCfoWq5rdrSRVkV3V8KG82wJZIl0LzRYsP4=;
        b=K4xVyhOxsxLVihcMjrOJkHN3SEIatb1Sv8YaWcTTzWp+PBUtok0QJhkNWZcZlExsq/7CJ2
        FM/syJw23aYHUnC0NxHph8zm+iA5A2pEAsw8DUEFfeE5xpQiVe2TPx4UYiTS+6br8umDoD
        AZMd/gdkkMbEkUOKjJAqe5KiCAvEh6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-CXKSf2MjPw61ydoOohx6uA-1; Fri, 21 Feb 2020 13:32:54 -0500
X-MC-Unique: CXKSf2MjPw61ydoOohx6uA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 493801137867;
        Fri, 21 Feb 2020 18:32:53 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 548D85D9C5;
        Fri, 21 Feb 2020 18:32:49 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com, dm-devel@redhat.com
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept arbitrary offset and len
References: <20200218214841.10076-1-vgoyal@redhat.com>
        <20200218214841.10076-3-vgoyal@redhat.com>
        <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
        <20200220215707.GC10816@redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 21 Feb 2020 13:32:48 -0500
Message-ID: <x498skv3i5r.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Thu, Feb 20, 2020 at 04:35:17PM -0500, Jeff Moyer wrote:
>> Vivek Goyal <vgoyal@redhat.com> writes:
>> 
>> > Currently pmem_clear_poison() expects offset and len to be sector aligned.
>> > Atleast that seems to be the assumption with which code has been written.
>> > It is called only from pmem_do_bvec() which is called only from pmem_rw_page()
>> > and pmem_make_request() which will only passe sector aligned offset and len.
>> >
>> > Soon we want use this function from dax_zero_page_range() code path which
>> > can try to zero arbitrary range of memory with-in a page. So update this
>> > function to assume that offset and length can be arbitrary and do the
>> > necessary alignments as needed.
>> 
>> What caller will try to zero a range that is smaller than a sector?
>
> Hi Jeff,
>
> New dax zeroing interface (dax_zero_page_range()) can technically pass
> a range which is less than a sector. Or which is bigger than a sector
> but start and end are not aligned on sector boundaries.

Sure, but who will call it with misaligned ranges?

> At this point of time, all I care about is that case of an arbitrary
> range is handeled well. So if a caller passes a range in, we figure
> out subrange which is sector aligned in terms of start and end, and
> clear poison on those sectors and ignore rest of the range. And
> this itself will be an improvement over current behavior where 
> nothing is cleared if I/O is not sector aligned.

I don't think this makes sense.  The caller needs to know about the
blast radius of errors.  This is why I asked for a concrete example.
It might make more sense, for example, to return an error if not all of
the errors could be cleared.

>> > nvdimm_clear_poison() seems to assume offset and len to be aligned to
>> > clear_err_unit boundary. But this is currently internal detail and is
>> > not exported for others to use. So for now, continue to align offset and
>> > length to SECTOR_SIZE boundary. Improving it further and to align it
>> > to clear_err_unit boundary is a TODO item for future.
>> 
>> When there is a poisoned range of persistent memory, it is recorded by
>> the badblocks infrastructure, which currently operates on sectors.  So,
>> no matter what the error unit is for the hardware, we currently can't
>> record/report to userspace anything smaller than a sector, and so that
>> is what we expect when clearing errors.
>> 
>> Continuing on for completeness, we will currently not map a page with
>> badblocks into a process' address space.  So, let's say you have 256
>> bytes of bad pmem, we will tell you we've lost 512 bytes, and even if
>> you access a valid mmap()d address in the same page as the poisoned
>> memory, you will get a segfault.
>> 
>> Userspace can fix up the error by calling write(2) and friends to
>> provide new data, or by punching a hole and writing new data to the hole
>> (which may result in getting a new block, or reallocating the old block
>> and zeroing it, which will clear the error).
>
> Fair enough. I do not need poison clearing at finer granularity. It might
> be needed once dev_dax path wants to clear poison. Not sure how exactly
> that works.

It doesn't.  :)

>> > +	/*
>> > +	 * Callers can pass arbitrary offset and len. But nvdimm_clear_poison()
>> > +	 * expects memory offset and length to meet certain alignment
>> > +	 * restrction (clear_err_unit). Currently nvdimm does not export
>>                                                   ^^^^^^^^^^^^^^^^^^^^^^
>> > +	 * required alignment. So align offset and length to sector boundary
>> 
>> What is "nvdimm" in that sentence?  Because the nvdimm most certainly
>> does export the required alignment.  Perhaps you meant libnvdimm?
>
> I meant nvdimm_clear_poison() function in drivers/nvdimm/bus.c. Whatever
> it is called. It first queries alignement required (clear_err_unit) and
> then makes sure range passed in meets that alignment requirement.

My point was your comment is misleading.

>> We could potentially support clearing less than a sector, but I'd have
>> to understand the use cases better before offerring implementation
>> suggestions.
>
> I don't need clearing less than a secotr. Once somebody needs it they
> can implement it. All I am doing is making sure current logic is not
> broken when dax_zero_page_range() starts using this logic and passes
> an arbitrary range. We need to make sure we internally align I/O 

An arbitrary range is the same thing as less than a sector.  :)  Do you
know of an instance where the range will not be sector-aligned and sized?

> and carve out an aligned sub-range and pass that subrange to
> nvdimm_clear_poison().

And what happens to the rest?  The caller is left to trip over the
errors?  That sounds pretty terrible.  I really think there needs to be
an explicit contract here.

> So if you can make sure I am not breaking things and new interface
> will continue to clear poison on sector boundary, that will be great.

I think allowing arbitrary ranges /could/ break things.  How it breaks
things depends on what the caller is doing.

If ther eare no callers using the interface in this way, then I see no
need to relax the restriction.  I do think we could document it better.

-Jeff

