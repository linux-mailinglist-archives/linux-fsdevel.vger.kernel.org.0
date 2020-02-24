Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE6C116B286
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 22:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgBXVdK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 16:33:10 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32935 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBXVdK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:33:10 -0500
Received: by mail-oi1-f196.google.com with SMTP id q81so10473483oig.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2020 13:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pt2WYxNRJOsL4hlormJuVSQ3w0yKBF2J5mdw/g31G5k=;
        b=pTe3VBg53ATzrZ+lFupbYg1iILQr2ZPlYsIuws9EgiqaJb+p5T1R2vCT5NUWMrDnoF
         kj3IE2WccOk62bK4MQbRLlVd4l7Ch9utvkJ+uwQYcTXVisXM6e52QeSwtQoWpSdPWYgU
         Rb4GsiMNc9Qm7dBjSHaSCW5lz3frWIbPfG9ANkkvCWokgPc/Qi5yvTPFUcOEWgudZ27k
         GP+7bB5ppkVt1GPHd0EAZTkfVHJCeZ8Z4lUkq5/yRHI1mtGp/Aoi3DqPv1dXXuADnwXd
         mFqntdaaCKv5NlWvG58qxJBS6ICny/VA0yaOgmrZaP4pXEdh6MtP+KPJ4QzgqeKApH/4
         YrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pt2WYxNRJOsL4hlormJuVSQ3w0yKBF2J5mdw/g31G5k=;
        b=MaVRU42qOfwxv/T0PvMQUBTH+orpOHpraJ3EgSIA9G/gkHXI/6JrVvsC6+uXexgXxl
         FPqBpp6kwaFHp2QXdio7tjR2BeuvsvVBUnv3TXIdGu2cV7NebvEVcNc/EZ44keTyZWQ1
         WKmnFJpakqG8effhByzqjnvBRQLpq8fpwWAM21g7Gd8x8rOf7GAknw5Il+zLRjoSPo1l
         ongst5y5YjH/kG7SFCQe7MUClwaUYXZU5YnHgMslOV9o+s92CsKCh55qTByWx/IL3gtF
         +lNYB+BK1992kGZeGXNd8x23RfbelMHyzcANxHhy78ZV8LSkEcdy4cijBNRAyMgFQF0N
         jnxQ==
X-Gm-Message-State: APjAAAWrsmtjJfMzb9oGr5vsBJBfZfQMeWoTP6p/gZY8brhnoANHsXEx
        UuU+6AvtGE+Jwuczy8Fbq2o2+OI9d6FZl6EvaC5XKg==
X-Google-Smtp-Source: APXvYqz4ixyy85iPHFhq/aU98L3qzceU0IsFaFBjoKqwqyPG/rWypa1d1pPxnhjryOsNJ5remecfeRDeGVC9oMW8vHI=
X-Received: by 2002:aca:aa0e:: with SMTP id t14mr883019oie.149.1582579989362;
 Mon, 24 Feb 2020 13:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20200218214841.10076-1-vgoyal@redhat.com> <20200218214841.10076-3-vgoyal@redhat.com>
 <x49lfoxj622.fsf@segfault.boston.devel.redhat.com> <20200220215707.GC10816@redhat.com>
 <x498skv3i5r.fsf@segfault.boston.devel.redhat.com> <20200221201759.GF25974@redhat.com>
 <20200223230330.GE10737@dread.disaster.area> <20200224201346.GC14651@redhat.com>
 <CAPcyv4gGrimesjZ=OKRaYTDd5dUVz+U9aPeBMh_H3_YCz4FOEQ@mail.gmail.com> <20200224211553.GD14651@redhat.com>
In-Reply-To: <20200224211553.GD14651@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 24 Feb 2020 13:32:58 -0800
Message-ID: <CAPcyv4gX8p0YuMg3=r9DtPAO3Lz-96nuNyXbK1X5-cyVzNrDTA@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 24, 2020 at 1:17 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Feb 24, 2020 at 12:52:13PM -0800, Dan Williams wrote:
> > On Mon, Feb 24, 2020 at 12:13 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Mon, Feb 24, 2020 at 10:03:30AM +1100, Dave Chinner wrote:
> > > > On Fri, Feb 21, 2020 at 03:17:59PM -0500, Vivek Goyal wrote:
> > > > > On Fri, Feb 21, 2020 at 01:32:48PM -0500, Jeff Moyer wrote:
> > > > > > Vivek Goyal <vgoyal@redhat.com> writes:
> > > > > >
> > > > > > > On Thu, Feb 20, 2020 at 04:35:17PM -0500, Jeff Moyer wrote:
> > > > > > >> Vivek Goyal <vgoyal@redhat.com> writes:
> > > > > > >>
> > > > > > >> > Currently pmem_clear_poison() expects offset and len to be sector aligned.
> > > > > > >> > Atleast that seems to be the assumption with which code has been written.
> > > > > > >> > It is called only from pmem_do_bvec() which is called only from pmem_rw_page()
> > > > > > >> > and pmem_make_request() which will only passe sector aligned offset and len.
> > > > > > >> >
> > > > > > >> > Soon we want use this function from dax_zero_page_range() code path which
> > > > > > >> > can try to zero arbitrary range of memory with-in a page. So update this
> > > > > > >> > function to assume that offset and length can be arbitrary and do the
> > > > > > >> > necessary alignments as needed.
> > > > > > >>
> > > > > > >> What caller will try to zero a range that is smaller than a sector?
> > > > > > >
> > > > > > > Hi Jeff,
> > > > > > >
> > > > > > > New dax zeroing interface (dax_zero_page_range()) can technically pass
> > > > > > > a range which is less than a sector. Or which is bigger than a sector
> > > > > > > but start and end are not aligned on sector boundaries.
> > > > > >
> > > > > > Sure, but who will call it with misaligned ranges?
> > > > >
> > > > > create a file foo.txt of size 4K and then truncate it.
> > > > >
> > > > > "truncate -s 23 foo.txt". Filesystems try to zero the bytes from 24 to
> > > > > 4095.
> > > >
> > > > This should fail with EIO. Only full page writes should clear the
> > > > bad page state, and partial writes should therefore fail because
> > > > they do not guarantee the data in the filesystem block is all good.
> > > >
> > > > If this zeroing was a buffered write to an address with a bad
> > > > sector, then the writeback will fail and the user will (eventually)
> > > > get an EIO on the file.
> > > >
> > > > DAX should do the same thing, except because the zeroing is
> > > > synchronous (i.e. done directly by the truncate syscall) we can -
> > > > and should - return EIO immediately.
> > > >
> > > > Indeed, with your code, if we then extend the file by truncating up
> > > > back to 4k, then the range between 23 and 512 is still bad, even
> > > > though we've successfully zeroed it and the user knows it. An
> > > > attempt to read anywhere in this range (e.g. 10 bytes at offset 100)
> > > > will fail with EIO, but reading 10 bytes at offset 2000 will
> > > > succeed.
> > > >
> > > > That's *awful* behaviour to expose to userspace, especially when
> > > > they look at the fs config and see that it's using both 4kB block
> > > > and sector sizes...
> > > >
> > > > The only thing that makes sense from a filesystem perspective is
> > > > clearing bad page state when entire filesystem blocks are
> > > > overwritten. The data in a filesystem block is either good or bad,
> > > > and it doesn't matter how many internal (kernel or device) sectors
> > > > it has.
> > > >
> > > > > > And what happens to the rest?  The caller is left to trip over the
> > > > > > errors?  That sounds pretty terrible.  I really think there needs to be
> > > > > > an explicit contract here.
> > > > >
> > > > > Ok, I think is is the contentious bit. Current interface
> > > > > (__dax_zero_page_range()) either clears the poison (if I/O is aligned to
> > > > > sector) or expects page to be free of poison.
> > > > >
> > > > > So in above example, of "truncate -s 23 foo.txt", currently I get an error
> > > > > because range being zeroed is not sector aligned. So
> > > > > __dax_zero_page_range() falls back to calling direct_access(). Which
> > > > > fails because there are poisoned sectors in the page.
> > > > >
> > > > > With my patches, dax_zero_page_range(), clears the poison from sector 1 to
> > > > > 7 but leaves sector 0 untouched and just writes zeroes from byte 0 to 511
> > > > > and returns success.
> > > >
> > > > Ok, kernel sectors are not the unit of granularity bad page state
> > > > should be managed at. They don't match page state granularity, and
> > > > they don't match filesystem block granularity, and the whacky
> > > > "partial writes silently succeed, reads fail unpredictably"
> > > > assymetry it leads to will just cause problems for users.
> > > >
> > > > > So question is, is this better behavior or worse behavior. If sector 0
> > > > > was poisoned, it will continue to remain poisoned and caller will come
> > > > > to know about it on next read and then it should try to truncate file
> > > > > to length 0 or unlink file or restore that file to get rid of poison.
> > > >
> > > > Worse, because the filesystem can't track what sub-parts of the
> > > > block are bad and that leads to inconsistent data integrity status
> > > > being exposed to userspace.
> > > >
> > > >
> > > > > IOW, if a partial block is being zeroed and if it is poisoned, caller
> > > > > will not be return an error and poison will not be cleared and memory
> > > > > will be zeroed. What do we expect in such cases.
> > > > >
> > > > > Do we expect an interface where if there are any bad blocks in the range
> > > > > being zeroed, then they all should be cleared (and hence all I/O should
> > > > > be aligned) otherwise error is returned. If yes, I could make that
> > > > > change.
> > > > >
> > > > > Downside of current interface is that it will clear as many blocks as
> > > > > possible in the given range and leave starting and end blocks poisoned
> > > > > (if it is unaligned) and not return error. That means a reader will
> > > > > get error on these blocks again and they will have to try to clear it
> > > > > again.
> > > >
> > > > Which is solved by having partial page writes always EIO on poisoned
> > > > memory.
> > >
> > > Ok, how about if I add one more patch to the series which will check
> > > if unwritten portion of the page has known poison. If it has, then
> > > -EIO is returned.
> > >
> > >
> > > Subject: pmem: zero page range return error if poisoned memory in unwritten area
> > >
> > > Filesystems call into pmem_dax_zero_page_range() to zero partial page upon
> > > truncate. If partial page is being zeroed, then at the end of operation
> > > file systems expect that there is no poison in the whole page (atleast
> > > known poison).
> > >
> > > So make sure part of the partial page which is not being written, does not
> > > have poison. If it does, return error. If there is poison in area of page
> > > being written, it will be cleared.
> >
> > No, I don't like that the zero operation is special cased compared to
> > the write case. I'd say let's make them identical for now. I.e. fail
> > the I/O at dax_direct_access() time.
>
> So basically __dax_zero_page_range() will only write zeros (and not
> try to clear any poison). Right?

Yes, the zero operation would have already failed at the
dax_direct_access() step if there was present poison.

> > I think the error clearing
> > interface should be an explicit / separate op rather than a
> > side-effect. What about an explicit interface for initializing newly
> > allocated blocks, and the only reliable way to destroy poison through
> > the filesystem is to free the block?
>
> Effectively pmem_make_request() is already that interface filesystems
> use to initialize blocks and clear poison. So we don't really have to
> introduce a new interface?

pmem_make_request() is shared with the I/O path and is too low in the
stack to understand intent. DAX intercepts the I/O path closer to the
filesystem and can understand zeroing vs writing today. I'm proposing
we go a step further and make DAX understand free-to-allocated-block
initialization instead of just zeroing. Inject the error clearing into
that initialization interface.

> Or you are suggesting separate dax_zero_page_range() interface which will
> always call into firmware to clear poison. And that will make sure latent
> poison is cleared as well and filesystem should use that for block
> initialization instead?

Yes, except latent poison would not be cleared until the zeroing is
implemented with movdir64b instead of callouts to firmware. It's
otherwise too slow to call out to firmware unconditionally.

> I do like the idea of not having to differentiate
> between known poison and latent poison. Once a block has been initialized
> all poison should be cleared (known/latent). I am worried though that
> on large devices this might slowdown filesystem initialization a lot
> if they are zeroing large range of blocks.
>
> If yes, this sounds like two different patch series. First patch series
> takes care of removing blkdev_issue_zeroout() from
> __dax_zero_page_range() and couple of iomap related cleans christoph
> wanted.
>
> And second patch series for adding new dax operation to zero a range
> and always call info firmware to clear poison and modify filesystems
> accordingly.

Yes, but they may need to be merged together. I don't want to regress
the ability of a block-aligned hole-punch to clear errors.
