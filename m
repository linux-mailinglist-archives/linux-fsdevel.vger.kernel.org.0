Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3358816B11D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 21:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgBXUss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 15:48:48 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45862 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgBXUss (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:48:48 -0500
Received: by mail-oi1-f194.google.com with SMTP id v19so10294421oic.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2020 12:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SgZHYl1BMtpAqpoWbYdfREDy18hvizQvMzzZmZXu1S8=;
        b=RDNV0BCtv8X72S4incNPcfopr9SVv+eEySHGoaDB4wwQKlYlqr6Uu/ZQGDgMq7Yejy
         wD4d8//2T7iR4nsdjMpbVugFA3zz2GQSsTeyK5rhcNDepImfqmM5YnAfSlp4iGRCFfBc
         lhCphhViLhdiHomDh8i2+TBj4N1LLutd6CkpeZo0kMBOxZZfGEjHAjVvkl1uUi7A5keT
         0hTnZqqAwQ1xWOgJjdiGGQFPAgHXodCpiPNazn1N/FAYujxFQXmy3uO5qJg9cmYnKRyh
         go/rDPaADhn7uKFjvPy7DTALvOr4KlB8L3nThyLHs65xH9I0s6B3apnWfBs4qRCs/YQp
         Zubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SgZHYl1BMtpAqpoWbYdfREDy18hvizQvMzzZmZXu1S8=;
        b=RObq0nMo2pR/Z4la5a+Qf9swtKgQzRohdmHkjrekNd9JBej2BYYfhS8M9MZaZMs5wj
         tgVJIsQCFQOZgXtN6mfD2BpTSLOkIqPidhzlEoCQufeu+mxXt9qqVYQnYl2CF3tGr+Qf
         CaS0PfpoOESvd2sGzL8TQXOhQeNom2FYvpzkIM71aWFXGThJ3rp+OIFCeo/OQ30uk8r1
         jdgSOVFegvC71UJGA1HZBohLs0gLSGTXR4QqeOVsox0OAarLpqbjr/w2M00z6bEJa4pl
         WwrSVDWqs92A/VZknCyv35lOoBacfYEpiCQdrPd87ASUD9YzcbIp5/KswHJwe8B6BxxC
         DbOw==
X-Gm-Message-State: APjAAAX2HdHpdzgpjPKhS67deOq9KGCyWc8HcfhD7CwRwYpLYxiYvhlZ
        wjTuJNj2ymVriQ7oskyTSKlm1iacu3EcitTcA2WsrA==
X-Google-Smtp-Source: APXvYqxrYIrrrwPEBB6Lwnzh035Wdyj3hLwBuVTxDgyCd2qJfvdgrLSkIdtqIDtiMk2epXPnZjZMsEdgwQiXqGN6fIg=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr814153oij.0.1582577326496;
 Mon, 24 Feb 2020 12:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20200218214841.10076-1-vgoyal@redhat.com> <20200218214841.10076-3-vgoyal@redhat.com>
 <x49lfoxj622.fsf@segfault.boston.devel.redhat.com> <20200220215707.GC10816@redhat.com>
 <x498skv3i5r.fsf@segfault.boston.devel.redhat.com> <20200221201759.GF25974@redhat.com>
 <20200223230330.GE10737@dread.disaster.area> <CAPcyv4ghusuMsAq8gSLJKh1fiKjwa8R_-ojVgjsttoPRqBd_Sg@mail.gmail.com>
 <x49blpop00m.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49blpop00m.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 24 Feb 2020 12:48:35 -0800
Message-ID: <CAPcyv4gCA_oR8_8+zhAhMnqOga9GcpMX97S+x8_UD6zLEQ0Cew@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 24, 2020 at 5:50 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Sun, Feb 23, 2020 at 3:03 PM Dave Chinner <david@fromorbit.com> wrote:
> >>
> >> On Fri, Feb 21, 2020 at 03:17:59PM -0500, Vivek Goyal wrote:
> >> > On Fri, Feb 21, 2020 at 01:32:48PM -0500, Jeff Moyer wrote:
> >> > > Vivek Goyal <vgoyal@redhat.com> writes:
> >> > >
> >> > > > On Thu, Feb 20, 2020 at 04:35:17PM -0500, Jeff Moyer wrote:
> >> > > >> Vivek Goyal <vgoyal@redhat.com> writes:
> >> > > >>
> >> > > >> > Currently pmem_clear_poison() expects offset and len to be sector aligned.
> >> > > >> > Atleast that seems to be the assumption with which code has been written.
> >> > > >> > It is called only from pmem_do_bvec() which is called only from pmem_rw_page()
> >> > > >> > and pmem_make_request() which will only passe sector aligned offset and len.
> >> > > >> >
> >> > > >> > Soon we want use this function from dax_zero_page_range() code path which
> >> > > >> > can try to zero arbitrary range of memory with-in a page. So update this
> >> > > >> > function to assume that offset and length can be arbitrary and do the
> >> > > >> > necessary alignments as needed.
> >> > > >>
> >> > > >> What caller will try to zero a range that is smaller than a sector?
> >> > > >
> >> > > > Hi Jeff,
> >> > > >
> >> > > > New dax zeroing interface (dax_zero_page_range()) can technically pass
> >> > > > a range which is less than a sector. Or which is bigger than a sector
> >> > > > but start and end are not aligned on sector boundaries.
> >> > >
> >> > > Sure, but who will call it with misaligned ranges?
> >> >
> >> > create a file foo.txt of size 4K and then truncate it.
> >> >
> >> > "truncate -s 23 foo.txt". Filesystems try to zero the bytes from 24 to
> >> > 4095.
> >>
> >> This should fail with EIO. Only full page writes should clear the
> >> bad page state, and partial writes should therefore fail because
> >> they do not guarantee the data in the filesystem block is all good.
> >>
> >> If this zeroing was a buffered write to an address with a bad
> >> sector, then the writeback will fail and the user will (eventually)
> >> get an EIO on the file.
> >>
> >> DAX should do the same thing, except because the zeroing is
> >> synchronous (i.e. done directly by the truncate syscall) we can -
> >> and should - return EIO immediately.
> >>
> >> Indeed, with your code, if we then extend the file by truncating up
> >> back to 4k, then the range between 23 and 512 is still bad, even
> >> though we've successfully zeroed it and the user knows it. An
> >> attempt to read anywhere in this range (e.g. 10 bytes at offset 100)
> >> will fail with EIO, but reading 10 bytes at offset 2000 will
> >> succeed.
> >>
> >> That's *awful* behaviour to expose to userspace, especially when
> >> they look at the fs config and see that it's using both 4kB block
> >> and sector sizes...
> >>
> >> The only thing that makes sense from a filesystem perspective is
> >> clearing bad page state when entire filesystem blocks are
> >> overwritten. The data in a filesystem block is either good or bad,
> >> and it doesn't matter how many internal (kernel or device) sectors
> >> it has.
> >>
> >> > > And what happens to the rest?  The caller is left to trip over the
> >> > > errors?  That sounds pretty terrible.  I really think there needs to be
> >> > > an explicit contract here.
> >> >
> >> > Ok, I think is is the contentious bit. Current interface
> >> > (__dax_zero_page_range()) either clears the poison (if I/O is aligned to
> >> > sector) or expects page to be free of poison.
> >> >
> >> > So in above example, of "truncate -s 23 foo.txt", currently I get an error
> >> > because range being zeroed is not sector aligned. So
> >> > __dax_zero_page_range() falls back to calling direct_access(). Which
> >> > fails because there are poisoned sectors in the page.
> >> >
> >> > With my patches, dax_zero_page_range(), clears the poison from sector 1 to
> >> > 7 but leaves sector 0 untouched and just writes zeroes from byte 0 to 511
> >> > and returns success.
> >>
> >> Ok, kernel sectors are not the unit of granularity bad page state
> >> should be managed at. They don't match page state granularity, and
> >> they don't match filesystem block granularity, and the whacky
> >> "partial writes silently succeed, reads fail unpredictably"
> >> assymetry it leads to will just cause problems for users.
> >>
> >> > So question is, is this better behavior or worse behavior. If sector 0
> >> > was poisoned, it will continue to remain poisoned and caller will come
> >> > to know about it on next read and then it should try to truncate file
> >> > to length 0 or unlink file or restore that file to get rid of poison.
> >>
> >> Worse, because the filesystem can't track what sub-parts of the
> >> block are bad and that leads to inconsistent data integrity status
> >> being exposed to userspace.
> >
> > The driver can't track it either. Latent poison isn't know until it is
> > consumed, and writes to latent poison are not guaranteed to clear it.
>
> I believe we're discussing the case where we know there is a bad block.
> Obviously we can't know about latent errors.
>
> >> > IOW, if a partial block is being zeroed and if it is poisoned, caller
> >> > will not be return an error and poison will not be cleared and memory
> >> > will be zeroed. What do we expect in such cases.
> >> >
> >> > Do we expect an interface where if there are any bad blocks in the range
> >> > being zeroed, then they all should be cleared (and hence all I/O should
> >> > be aligned) otherwise error is returned. If yes, I could make that
> >> > change.
> >> >
> >> > Downside of current interface is that it will clear as many blocks as
> >> > possible in the given range and leave starting and end blocks poisoned
> >> > (if it is unaligned) and not return error. That means a reader will
> >> > get error on these blocks again and they will have to try to clear it
> >> > again.
> >>
> >> Which is solved by having partial page writes always EIO on poisoned
> >> memory.
> >
> > The problem with the above is that partial page writes can not be
> > guaranteed to return EIO. Poison is only detected on consumed reads,
> > or a periodic scrub, not writes. IFF poison detection was always
> > synchronous with poison creation then the above makes sense. However,
> > with asynchronous signaling, it's fundamentally a false security
> > blanket to assume even full block writes will clear poison unless a
> > callback to firmware is made for every block.
>
> Let's just focus on reporting errors when we know we have them.

That's the problem in my eyes. If software needs to contend with
latent error reporting then it should always contend otherwise
software has multiple error models to wrangle.

Setting that aside we can start with just treating zeroing the same as
the copy_from_iter() case and fail the I/O at the dax_direct_access()
step.

I'd rather have a separate op that filesystems can use to clear errors
at block allocation time that can be enforced to have the correct
alignment.
