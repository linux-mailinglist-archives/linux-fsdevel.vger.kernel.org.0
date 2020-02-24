Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA8F7169B40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 01:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgBXAkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 19:40:53 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42428 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBXAkx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:40:53 -0500
Received: by mail-oi1-f196.google.com with SMTP id j132so7406253oih.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2020 16:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fWYYQZ1tUAo30vrwKRme2xC0z7VIUZp9g41h1//e/o=;
        b=WLRjQ0eyFKzsOa97x37vwYC4JCVblsUAEaOFOHkNbJ7sXhCoTayazSDFNNH+Wn5CSc
         jlSwUn8u1cCowXWer4TGls3dNbkd8Wl0yFBkpnLKDD3Uvj5nzZ65Ca26aGAwbcSEiLEY
         a+u/a7VbNJIK3yrdhHx4m5YET/DFdOSIKIuTuMZr7Db2WSfQgNzEEpfjOBR6IW+bKWH8
         uQwvTyouue5J+jZz2/lZwW/PgG74G8U1klJM3ccqtm/NesLGWX5gHbet38H35FQtai/P
         f9fAvBa9Zgzqn2K7pYPLGVpHqZ2wpCqn4OvgZdUIOUP38zTtT5tIyFOiaPtKMwlJ+Bmq
         D8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fWYYQZ1tUAo30vrwKRme2xC0z7VIUZp9g41h1//e/o=;
        b=mqttmr5gKvmJrxtLEmFeZtwjTASPbIs1RUWQitSoMrK41EKS7lguBWNawIfJ/tcgpl
         J6mNU16vMZa2lkP+6EU74Tve97xjc+InUariIs1nJ8jLvJ0LfpI5dc3bTCXp5sMpmA5W
         MpQXbPRdufOjUBlf+Z5cS7znPg0EL0xPh7e0MY08oJ2+2mytJ+AdQxs+8O7T7UfzEX07
         w+Y6PyPrqRXjmOHzlZfnUjg4j5DqFkaoB0snLfrnFdk3ingMlwrQPRby5xPyUcqxf0Vz
         kxMnaCa83KgrUt9IVIU76bZCZgNJB9L7Y1+0arn3ji6LIAdYHvhzASR48tlCiBBeptQy
         rY4A==
X-Gm-Message-State: APjAAAXFCWoLXljk0wgdsl5YqgjEF4hJji/fryFrPrJc0VJxczuTe5oo
        yDFRGzSUa6IrQ5jS+0IUTlptLUOQKIQHf22w5OUR7Q==
X-Google-Smtp-Source: APXvYqwrH1BeHXIjpPFXOS9J7oM8tzow/HkEMYsIW3IDVepJp41zLBuZXXglRgycv6nOwaG/2wuAr/itaObiTZGZwRY=
X-Received: by 2002:aca:3f54:: with SMTP id m81mr10454580oia.73.1582504851476;
 Sun, 23 Feb 2020 16:40:51 -0800 (PST)
MIME-Version: 1.0
References: <20200218214841.10076-1-vgoyal@redhat.com> <20200218214841.10076-3-vgoyal@redhat.com>
 <x49lfoxj622.fsf@segfault.boston.devel.redhat.com> <20200220215707.GC10816@redhat.com>
 <x498skv3i5r.fsf@segfault.boston.devel.redhat.com> <20200221201759.GF25974@redhat.com>
 <20200223230330.GE10737@dread.disaster.area>
In-Reply-To: <20200223230330.GE10737@dread.disaster.area>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 23 Feb 2020 16:40:40 -0800
Message-ID: <CAPcyv4ghusuMsAq8gSLJKh1fiKjwa8R_-ojVgjsttoPRqBd_Sg@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
To:     Dave Chinner <david@fromorbit.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 23, 2020 at 3:03 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Fri, Feb 21, 2020 at 03:17:59PM -0500, Vivek Goyal wrote:
> > On Fri, Feb 21, 2020 at 01:32:48PM -0500, Jeff Moyer wrote:
> > > Vivek Goyal <vgoyal@redhat.com> writes:
> > >
> > > > On Thu, Feb 20, 2020 at 04:35:17PM -0500, Jeff Moyer wrote:
> > > >> Vivek Goyal <vgoyal@redhat.com> writes:
> > > >>
> > > >> > Currently pmem_clear_poison() expects offset and len to be sector aligned.
> > > >> > Atleast that seems to be the assumption with which code has been written.
> > > >> > It is called only from pmem_do_bvec() which is called only from pmem_rw_page()
> > > >> > and pmem_make_request() which will only passe sector aligned offset and len.
> > > >> >
> > > >> > Soon we want use this function from dax_zero_page_range() code path which
> > > >> > can try to zero arbitrary range of memory with-in a page. So update this
> > > >> > function to assume that offset and length can be arbitrary and do the
> > > >> > necessary alignments as needed.
> > > >>
> > > >> What caller will try to zero a range that is smaller than a sector?
> > > >
> > > > Hi Jeff,
> > > >
> > > > New dax zeroing interface (dax_zero_page_range()) can technically pass
> > > > a range which is less than a sector. Or which is bigger than a sector
> > > > but start and end are not aligned on sector boundaries.
> > >
> > > Sure, but who will call it with misaligned ranges?
> >
> > create a file foo.txt of size 4K and then truncate it.
> >
> > "truncate -s 23 foo.txt". Filesystems try to zero the bytes from 24 to
> > 4095.
>
> This should fail with EIO. Only full page writes should clear the
> bad page state, and partial writes should therefore fail because
> they do not guarantee the data in the filesystem block is all good.
>
> If this zeroing was a buffered write to an address with a bad
> sector, then the writeback will fail and the user will (eventually)
> get an EIO on the file.
>
> DAX should do the same thing, except because the zeroing is
> synchronous (i.e. done directly by the truncate syscall) we can -
> and should - return EIO immediately.
>
> Indeed, with your code, if we then extend the file by truncating up
> back to 4k, then the range between 23 and 512 is still bad, even
> though we've successfully zeroed it and the user knows it. An
> attempt to read anywhere in this range (e.g. 10 bytes at offset 100)
> will fail with EIO, but reading 10 bytes at offset 2000 will
> succeed.
>
> That's *awful* behaviour to expose to userspace, especially when
> they look at the fs config and see that it's using both 4kB block
> and sector sizes...
>
> The only thing that makes sense from a filesystem perspective is
> clearing bad page state when entire filesystem blocks are
> overwritten. The data in a filesystem block is either good or bad,
> and it doesn't matter how many internal (kernel or device) sectors
> it has.
>
> > > And what happens to the rest?  The caller is left to trip over the
> > > errors?  That sounds pretty terrible.  I really think there needs to be
> > > an explicit contract here.
> >
> > Ok, I think is is the contentious bit. Current interface
> > (__dax_zero_page_range()) either clears the poison (if I/O is aligned to
> > sector) or expects page to be free of poison.
> >
> > So in above example, of "truncate -s 23 foo.txt", currently I get an error
> > because range being zeroed is not sector aligned. So
> > __dax_zero_page_range() falls back to calling direct_access(). Which
> > fails because there are poisoned sectors in the page.
> >
> > With my patches, dax_zero_page_range(), clears the poison from sector 1 to
> > 7 but leaves sector 0 untouched and just writes zeroes from byte 0 to 511
> > and returns success.
>
> Ok, kernel sectors are not the unit of granularity bad page state
> should be managed at. They don't match page state granularity, and
> they don't match filesystem block granularity, and the whacky
> "partial writes silently succeed, reads fail unpredictably"
> assymetry it leads to will just cause problems for users.
>
> > So question is, is this better behavior or worse behavior. If sector 0
> > was poisoned, it will continue to remain poisoned and caller will come
> > to know about it on next read and then it should try to truncate file
> > to length 0 or unlink file or restore that file to get rid of poison.
>
> Worse, because the filesystem can't track what sub-parts of the
> block are bad and that leads to inconsistent data integrity status
> being exposed to userspace.

The driver can't track it either. Latent poison isn't know until it is
consumed, and writes to latent poison are not guaranteed to clear it.

>
>
> > IOW, if a partial block is being zeroed and if it is poisoned, caller
> > will not be return an error and poison will not be cleared and memory
> > will be zeroed. What do we expect in such cases.
> >
> > Do we expect an interface where if there are any bad blocks in the range
> > being zeroed, then they all should be cleared (and hence all I/O should
> > be aligned) otherwise error is returned. If yes, I could make that
> > change.
> >
> > Downside of current interface is that it will clear as many blocks as
> > possible in the given range and leave starting and end blocks poisoned
> > (if it is unaligned) and not return error. That means a reader will
> > get error on these blocks again and they will have to try to clear it
> > again.
>
> Which is solved by having partial page writes always EIO on poisoned
> memory.

The problem with the above is that partial page writes can not be
guaranteed to return EIO. Poison is only detected on consumed reads,
or a periodic scrub, not writes. IFF poison detection was always
synchronous with poison creation then the above makes sense. However,
with asynchronous signaling, it's fundamentally a false security
blanket to assume even full block writes will clear poison unless a
callback to firmware is made for every block.
