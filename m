Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 941F316895B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 22:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgBUVbI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 16:31:08 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43657 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgBUVbI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:31:08 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so3023216oif.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2020 13:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CGRGyvmgrURrZb8JP76tjcYyGmXD/dSyGlZGFapcV9E=;
        b=p2wH0VlZHb0hY0YAMV5ZCw9oPkdufeKtNrAUgvtZjG6mv7jwORM2aOQx2CWJrMQayQ
         DAjUCeTnywJdnDCRYWwle2FWJxkeoSil8ebNwEfDXXJbLRcs0Cg4u3TVLDt/TeGjpUJV
         QhgNG8JRD3BM4aw2KYmP41ZNJv7I0qi6NeMqfRb1+DP7kdCpbVIm/UcjB+aJEzaBbHMe
         kd05SmT9mWcWBF9jIZkQOg3uP/TwGT9XyvwY6VA5xf7xno/eRdIgi74zWSKHJLWqyQMB
         TpRN9l6yjk98TP9neoPEE4Qxtim/srSV3p6FG/wfWKbDJLytuNHRVQL+S5K3xbydsXUd
         Doww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGRGyvmgrURrZb8JP76tjcYyGmXD/dSyGlZGFapcV9E=;
        b=gV5sKJnrlHwbTwfDJVnYE144JG+TIGY6LTmJYkMps0O3l0U8/3JNXTeOsFNF3KyC23
         RibVWBQigCu1Uy7c+7SaoVMdg09smULuIsyflLjGMhopsorBmMaQCBny7eDoTDHxEiNp
         A4tozH2Ym+VeV/YN17QfukVsKwbIdefB7hNCRtr5nqYSBCORWEh/3I//nmMEzmAlsRAL
         4V9nrtkOwTIc4ooFDoEZvKxqhu016uTc1K9pHyaXvz6FKcfde+iCCiiHHTrZnLWoGdnD
         Imy/LfZroBeV75ny+MIMA+2i4jEU9ApWwUrMXSe04YCacL4hJXcpyF8If5T6Rnp81ShH
         hVqQ==
X-Gm-Message-State: APjAAAX/MV0JC29GqAgg0937sZdzxiuhX7Ciqs4M9XSKtNCrCM9wAHsx
        fiGdaz9NVl25Kj7owMrKyBG7OSQPtrO93xJqXAcZJg==
X-Google-Smtp-Source: APXvYqzwgROo2U/pxVS1cKTSLnTsAFtRvHb1ZffYyzADG/jhKo8J5sdfjvLjWmiXOTRlHzvw+Yt2nVnFYHzxgBiVEkI=
X-Received: by 2002:a54:4791:: with SMTP id o17mr3613643oic.70.1582320667197;
 Fri, 21 Feb 2020 13:31:07 -0800 (PST)
MIME-Version: 1.0
References: <20200218214841.10076-1-vgoyal@redhat.com> <20200218214841.10076-3-vgoyal@redhat.com>
 <x49lfoxj622.fsf@segfault.boston.devel.redhat.com> <20200220215707.GC10816@redhat.com>
 <x498skv3i5r.fsf@segfault.boston.devel.redhat.com> <20200221201759.GF25974@redhat.com>
 <CAPcyv4j3BPGvrhuVaQZgvZ0i+M+i-Ab0BH+mAjR_aZzu4_kidQ@mail.gmail.com> <20200221212449.GG25974@redhat.com>
In-Reply-To: <20200221212449.GG25974@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 Feb 2020 13:30:56 -0800
Message-ID: <CAPcyv4gBHuTDW1M-3W=0nuH1v3whChb8TAK1aA0gosBSKpkqcg@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 1:25 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Fri, Feb 21, 2020 at 01:00:29PM -0800, Dan Williams wrote:
> > On Fri, Feb 21, 2020 at 12:18 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Fri, Feb 21, 2020 at 01:32:48PM -0500, Jeff Moyer wrote:
> > > > Vivek Goyal <vgoyal@redhat.com> writes:
> > > >
> > > > > On Thu, Feb 20, 2020 at 04:35:17PM -0500, Jeff Moyer wrote:
> > > > >> Vivek Goyal <vgoyal@redhat.com> writes:
> > > > >>
> > > > >> > Currently pmem_clear_poison() expects offset and len to be sector aligned.
> > > > >> > Atleast that seems to be the assumption with which code has been written.
> > > > >> > It is called only from pmem_do_bvec() which is called only from pmem_rw_page()
> > > > >> > and pmem_make_request() which will only passe sector aligned offset and len.
> > > > >> >
> > > > >> > Soon we want use this function from dax_zero_page_range() code path which
> > > > >> > can try to zero arbitrary range of memory with-in a page. So update this
> > > > >> > function to assume that offset and length can be arbitrary and do the
> > > > >> > necessary alignments as needed.
> > > > >>
> > > > >> What caller will try to zero a range that is smaller than a sector?
> > > > >
> > > > > Hi Jeff,
> > > > >
> > > > > New dax zeroing interface (dax_zero_page_range()) can technically pass
> > > > > a range which is less than a sector. Or which is bigger than a sector
> > > > > but start and end are not aligned on sector boundaries.
> > > >
> > > > Sure, but who will call it with misaligned ranges?
> > >
> > > create a file foo.txt of size 4K and then truncate it.
> > >
> > > "truncate -s 23 foo.txt". Filesystems try to zero the bytes from 24 to
> > > 4095.
> > >
> > > I have also written a test for this.
> > >
> > > https://github.com/rhvgoyal/misc/blob/master/pmem-tests/iomap-range-test.sh#L102
> > >
> > > >
> > > > > At this point of time, all I care about is that case of an arbitrary
> > > > > range is handeled well. So if a caller passes a range in, we figure
> > > > > out subrange which is sector aligned in terms of start and end, and
> > > > > clear poison on those sectors and ignore rest of the range. And
> > > > > this itself will be an improvement over current behavior where
> > > > > nothing is cleared if I/O is not sector aligned.
> > > >
> > > > I don't think this makes sense.  The caller needs to know about the
> > > > blast radius of errors.  This is why I asked for a concrete example.
> > > > It might make more sense, for example, to return an error if not all of
> > > > the errors could be cleared.
> > > >
> > > > >> > nvdimm_clear_poison() seems to assume offset and len to be aligned to
> > > > >> > clear_err_unit boundary. But this is currently internal detail and is
> > > > >> > not exported for others to use. So for now, continue to align offset and
> > > > >> > length to SECTOR_SIZE boundary. Improving it further and to align it
> > > > >> > to clear_err_unit boundary is a TODO item for future.
> > > > >>
> > > > >> When there is a poisoned range of persistent memory, it is recorded by
> > > > >> the badblocks infrastructure, which currently operates on sectors.  So,
> > > > >> no matter what the error unit is for the hardware, we currently can't
> > > > >> record/report to userspace anything smaller than a sector, and so that
> > > > >> is what we expect when clearing errors.
> > > > >>
> > > > >> Continuing on for completeness, we will currently not map a page with
> > > > >> badblocks into a process' address space.  So, let's say you have 256
> > > > >> bytes of bad pmem, we will tell you we've lost 512 bytes, and even if
> > > > >> you access a valid mmap()d address in the same page as the poisoned
> > > > >> memory, you will get a segfault.
> > > > >>
> > > > >> Userspace can fix up the error by calling write(2) and friends to
> > > > >> provide new data, or by punching a hole and writing new data to the hole
> > > > >> (which may result in getting a new block, or reallocating the old block
> > > > >> and zeroing it, which will clear the error).
> > > > >
> > > > > Fair enough. I do not need poison clearing at finer granularity. It might
> > > > > be needed once dev_dax path wants to clear poison. Not sure how exactly
> > > > > that works.
> > > >
> > > > It doesn't.  :)
> > > >
> > > > >> > +        /*
> > > > >> > +         * Callers can pass arbitrary offset and len. But nvdimm_clear_poison()
> > > > >> > +         * expects memory offset and length to meet certain alignment
> > > > >> > +         * restrction (clear_err_unit). Currently nvdimm does not export
> > > > >>                                                   ^^^^^^^^^^^^^^^^^^^^^^
> > > > >> > +         * required alignment. So align offset and length to sector boundary
> > > > >>
> > > > >> What is "nvdimm" in that sentence?  Because the nvdimm most certainly
> > > > >> does export the required alignment.  Perhaps you meant libnvdimm?
> > > > >
> > > > > I meant nvdimm_clear_poison() function in drivers/nvdimm/bus.c. Whatever
> > > > > it is called. It first queries alignement required (clear_err_unit) and
> > > > > then makes sure range passed in meets that alignment requirement.
> > > >
> > > > My point was your comment is misleading.
> > > >
> > > > >> We could potentially support clearing less than a sector, but I'd have
> > > > >> to understand the use cases better before offerring implementation
> > > > >> suggestions.
> > > > >
> > > > > I don't need clearing less than a secotr. Once somebody needs it they
> > > > > can implement it. All I am doing is making sure current logic is not
> > > > > broken when dax_zero_page_range() starts using this logic and passes
> > > > > an arbitrary range. We need to make sure we internally align I/O
> > > >
> > > > An arbitrary range is the same thing as less than a sector.  :)  Do you
> > > > know of an instance where the range will not be sector-aligned and sized?
> > > >
> > > > > and carve out an aligned sub-range and pass that subrange to
> > > > > nvdimm_clear_poison().
> > > >
> > > > And what happens to the rest?  The caller is left to trip over the
> > > > errors?  That sounds pretty terrible.  I really think there needs to be
> > > > an explicit contract here.
> > >
> > > Ok, I think is is the contentious bit. Current interface
> > > (__dax_zero_page_range()) either clears the poison (if I/O is aligned to
> > > sector) or expects page to be free of poison.
> > >
> > > So in above example, of "truncate -s 23 foo.txt", currently I get an error
> > > because range being zeroed is not sector aligned. So
> > > __dax_zero_page_range() falls back to calling direct_access(). Which
> > > fails because there are poisoned sectors in the page.
> > >
> > > With my patches, dax_zero_page_range(), clears the poison from sector 1 to
> > > 7 but leaves sector 0 untouched and just writes zeroes from byte 0 to 511
> > > and returns success.
> > >
> > > So question is, is this better behavior or worse behavior. If sector 0
> > > was poisoned, it will continue to remain poisoned and caller will come
> > > to know about it on next read and then it should try to truncate file
> > > to length 0 or unlink file or restore that file to get rid of poison.
> > >
> > > IOW, if a partial block is being zeroed and if it is poisoned, caller
> > > will not be return an error and poison will not be cleared and memory
> > > will be zeroed. What do we expect in such cases.
> > >
> > > Do we expect an interface where if there are any bad blocks in the range
> > > being zeroed, then they all should be cleared (and hence all I/O should
> > > be aligned) otherwise error is returned. If yes, I could make that
> > > change.
> >
> > This does not strike me as a good idea because it's a false security
> > compared to the latent poison case. If the writes to an unknown
> > poisoned location would otherwise succeed via a different I/O path
> > (dax), it's an unsymmetric surprise to start returning errors just
> > because you wrote zeroes as a side effect of truncate.
> >
> > > Downside of current interface is that it will clear as many blocks as
> > > possible in the given range and leave starting and end blocks poisoned
> > > (if it is unaligned) and not return error. That means a reader will
> > > get error on these blocks again and they will have to try to clear it
> > > again.
> >
> > I think what you have described in your truncate example is an
> > improvement on what we have currently because x86 does not communicate
> > write errors. Specifically, writing zeros via dax from userspace over
> > unknown poison behaves the same as writing unaligned zeros over known
> > poison. In both cases it's a best effort that always succeeds (no cpu
> > exception), and may inadvertently clear poison as a side-effect.
> > Otherwise, an error-block-aligned hole punch is the only way to
> > trigger the kernel to try to clear known poison when the full block is
> > reallocated.
>
> Hi Dan,
>
> Agreed. This new interface works uniformly for both known poison and latent
> poison cases. Existing interface is asymmetric and that means if poison is
> latent, unaligned zero range will succeed but if poison is known, unaligned
> zero range will fail.
>
> >
> > On movdir64b capable cpus the error clearing unit becomes 64-bytes
> > rather than 256-bytes because that allows a cacheline to be written
> > without triggering a line fill read. So the error clearing granularity
> > gets better over time, but unfortunately not synchronous detection in
> > the I/O path.
> >
> > I think a better way to improve poison handling is the long standing
> > idea to integrate the badblock tracking into the filesystem directly.
> > That way driver notifications of poison can be ingested into the
> > filesystem and notifications sent on filenames rather than the current
> > TOCTOU mess of trying to do a reverse lookup of badblock numbers to
> > files. If the application can efficiently list and be notified of
> > poison it can mitigate it immediately rather than trying to rely on
> > write side effects.
>
> Moving badblocks infrastructure in filesystem sounds like a major
> rework which should be taken up in a seprate patch series in future.
>
> For now, can we please take these patches which are an improvement
> over existing interface.

Oh you misunderstood my comment, the "move badblocks to filesystem"
proposal is long term / down the road thing to consider. In the near
term this unaligned block zeroing facility is an improvement.
