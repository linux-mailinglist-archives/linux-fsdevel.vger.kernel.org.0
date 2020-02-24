Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEF3716A79B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 14:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgBXNur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 08:50:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34242 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727393AbgBXNur (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582552244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xw1s4eAvDEkCvmMHhprnxPdzxw0KXN4xwLXUP2toBwc=;
        b=JVV6Err7krX5XsW0fzwPkMVcnd5+CgbKAmmfms1at8mg5w1O/bfsiBDH27XK/hDn6IuGip
        w85R2CItMi5BbZZhPvetwJvpAhKz7MkXNw1aQLq3Nrv1d1hlGu2+lVkGTjT4mLcuAEEUbM
        2ecLjSiirK4RTdi/pBY3HtLHTYNrZaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-8tDGoePRPOqSGJvJABgB3A-1; Mon, 24 Feb 2020 08:50:41 -0500
X-MC-Unique: 8tDGoePRPOqSGJvJABgB3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7668A0CBF;
        Mon, 24 Feb 2020 13:50:39 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FF4F9183D;
        Mon, 24 Feb 2020 13:50:33 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept arbitrary offset and len
References: <20200218214841.10076-1-vgoyal@redhat.com>
        <20200218214841.10076-3-vgoyal@redhat.com>
        <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
        <20200220215707.GC10816@redhat.com>
        <x498skv3i5r.fsf@segfault.boston.devel.redhat.com>
        <20200221201759.GF25974@redhat.com>
        <20200223230330.GE10737@dread.disaster.area>
        <CAPcyv4ghusuMsAq8gSLJKh1fiKjwa8R_-ojVgjsttoPRqBd_Sg@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Mon, 24 Feb 2020 08:50:33 -0500
In-Reply-To: <CAPcyv4ghusuMsAq8gSLJKh1fiKjwa8R_-ojVgjsttoPRqBd_Sg@mail.gmail.com>
        (Dan Williams's message of "Sun, 23 Feb 2020 16:40:40 -0800")
Message-ID: <x49blpop00m.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> On Sun, Feb 23, 2020 at 3:03 PM Dave Chinner <david@fromorbit.com> wrote:
>>
>> On Fri, Feb 21, 2020 at 03:17:59PM -0500, Vivek Goyal wrote:
>> > On Fri, Feb 21, 2020 at 01:32:48PM -0500, Jeff Moyer wrote:
>> > > Vivek Goyal <vgoyal@redhat.com> writes:
>> > >
>> > > > On Thu, Feb 20, 2020 at 04:35:17PM -0500, Jeff Moyer wrote:
>> > > >> Vivek Goyal <vgoyal@redhat.com> writes:
>> > > >>
>> > > >> > Currently pmem_clear_poison() expects offset and len to be sector aligned.
>> > > >> > Atleast that seems to be the assumption with which code has been written.
>> > > >> > It is called only from pmem_do_bvec() which is called only from pmem_rw_page()
>> > > >> > and pmem_make_request() which will only passe sector aligned offset and len.
>> > > >> >
>> > > >> > Soon we want use this function from dax_zero_page_range() code path which
>> > > >> > can try to zero arbitrary range of memory with-in a page. So update this
>> > > >> > function to assume that offset and length can be arbitrary and do the
>> > > >> > necessary alignments as needed.
>> > > >>
>> > > >> What caller will try to zero a range that is smaller than a sector?
>> > > >
>> > > > Hi Jeff,
>> > > >
>> > > > New dax zeroing interface (dax_zero_page_range()) can technically pass
>> > > > a range which is less than a sector. Or which is bigger than a sector
>> > > > but start and end are not aligned on sector boundaries.
>> > >
>> > > Sure, but who will call it with misaligned ranges?
>> >
>> > create a file foo.txt of size 4K and then truncate it.
>> >
>> > "truncate -s 23 foo.txt". Filesystems try to zero the bytes from 24 to
>> > 4095.
>>
>> This should fail with EIO. Only full page writes should clear the
>> bad page state, and partial writes should therefore fail because
>> they do not guarantee the data in the filesystem block is all good.
>>
>> If this zeroing was a buffered write to an address with a bad
>> sector, then the writeback will fail and the user will (eventually)
>> get an EIO on the file.
>>
>> DAX should do the same thing, except because the zeroing is
>> synchronous (i.e. done directly by the truncate syscall) we can -
>> and should - return EIO immediately.
>>
>> Indeed, with your code, if we then extend the file by truncating up
>> back to 4k, then the range between 23 and 512 is still bad, even
>> though we've successfully zeroed it and the user knows it. An
>> attempt to read anywhere in this range (e.g. 10 bytes at offset 100)
>> will fail with EIO, but reading 10 bytes at offset 2000 will
>> succeed.
>>
>> That's *awful* behaviour to expose to userspace, especially when
>> they look at the fs config and see that it's using both 4kB block
>> and sector sizes...
>>
>> The only thing that makes sense from a filesystem perspective is
>> clearing bad page state when entire filesystem blocks are
>> overwritten. The data in a filesystem block is either good or bad,
>> and it doesn't matter how many internal (kernel or device) sectors
>> it has.
>>
>> > > And what happens to the rest?  The caller is left to trip over the
>> > > errors?  That sounds pretty terrible.  I really think there needs to be
>> > > an explicit contract here.
>> >
>> > Ok, I think is is the contentious bit. Current interface
>> > (__dax_zero_page_range()) either clears the poison (if I/O is aligned to
>> > sector) or expects page to be free of poison.
>> >
>> > So in above example, of "truncate -s 23 foo.txt", currently I get an error
>> > because range being zeroed is not sector aligned. So
>> > __dax_zero_page_range() falls back to calling direct_access(). Which
>> > fails because there are poisoned sectors in the page.
>> >
>> > With my patches, dax_zero_page_range(), clears the poison from sector 1 to
>> > 7 but leaves sector 0 untouched and just writes zeroes from byte 0 to 511
>> > and returns success.
>>
>> Ok, kernel sectors are not the unit of granularity bad page state
>> should be managed at. They don't match page state granularity, and
>> they don't match filesystem block granularity, and the whacky
>> "partial writes silently succeed, reads fail unpredictably"
>> assymetry it leads to will just cause problems for users.
>>
>> > So question is, is this better behavior or worse behavior. If sector 0
>> > was poisoned, it will continue to remain poisoned and caller will come
>> > to know about it on next read and then it should try to truncate file
>> > to length 0 or unlink file or restore that file to get rid of poison.
>>
>> Worse, because the filesystem can't track what sub-parts of the
>> block are bad and that leads to inconsistent data integrity status
>> being exposed to userspace.
>
> The driver can't track it either. Latent poison isn't know until it is
> consumed, and writes to latent poison are not guaranteed to clear it.

I believe we're discussing the case where we know there is a bad block.
Obviously we can't know about latent errors.

>> > IOW, if a partial block is being zeroed and if it is poisoned, caller
>> > will not be return an error and poison will not be cleared and memory
>> > will be zeroed. What do we expect in such cases.
>> >
>> > Do we expect an interface where if there are any bad blocks in the range
>> > being zeroed, then they all should be cleared (and hence all I/O should
>> > be aligned) otherwise error is returned. If yes, I could make that
>> > change.
>> >
>> > Downside of current interface is that it will clear as many blocks as
>> > possible in the given range and leave starting and end blocks poisoned
>> > (if it is unaligned) and not return error. That means a reader will
>> > get error on these blocks again and they will have to try to clear it
>> > again.
>>
>> Which is solved by having partial page writes always EIO on poisoned
>> memory.
>
> The problem with the above is that partial page writes can not be
> guaranteed to return EIO. Poison is only detected on consumed reads,
> or a periodic scrub, not writes. IFF poison detection was always
> synchronous with poison creation then the above makes sense. However,
> with asynchronous signaling, it's fundamentally a false security
> blanket to assume even full block writes will clear poison unless a
> callback to firmware is made for every block.

Let's just focus on reporting errors when we know we have them.

-Jeff

