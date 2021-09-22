Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A985415163
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 22:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbhIVU2g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 16:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbhIVU2g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:28:36 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7519C061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 13:27:05 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e7so4007091pgk.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 13:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7B4Op7jxUlLVva1iz44pF/hK7De7vsXXP5PesX0X2Q=;
        b=b7N5Ex30Cv4q+WMABFbt2GD823yZYE1yCO+IWqtkdCuFr8PiQnuLUnlsD+lW58qZgY
         Iz56sfrm27QwPIHkuaODUTAGg892LRl0+jY3ubsyWnqth93LaBv06cht9p3O4AYueyg7
         R2BLnpcUQHu/Z6JPvnqRnTr9nMUvGDRRPK4MEiUlvINNv2nsaqSQl9fxSjet3gChtaqI
         fs0Vgju2kmKfooEISsAWCYoyJtjaww/qVwLHWRN5gIn49BIr2hSe4QiXoI2Hh0IH57cu
         NwZy1+9th0sRpJFxYW0kWFVlWedBppj8jbAyeEK4j1iLzqrsUtsOPwmg4GZKxVr5qEKN
         cOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7B4Op7jxUlLVva1iz44pF/hK7De7vsXXP5PesX0X2Q=;
        b=vTf8xFHRGPhBF8I7hNSIKFXVCOiaGDOqqr1k86UQq5rSrEvFGplhM8BNZdOWAS36gi
         byGu3dR7V2Ps1lLqh82UE14urEEAzJt53936LOTyjRN85gRjE3HB3WhDHVaJhKsrv5iN
         iAI6qzttZjM/xrQ0yErFywK4E8emr7JEHTPQOwvrPEjp4QmzTQsfHsuVBiUTZHf7YeR8
         3GkyLBD3YM3eMeQS2XkSx0nyfeWl6mS3qNAPNq5Vogt9BPexd6tLToFklvKGKdAZvR+M
         AoXzzEJ3pYYaWmZrGyZmHZRcMSNeyzhgqz8x/cePl9RVZKzWzipyBqRFWpYT29lz0Mdi
         E6+g==
X-Gm-Message-State: AOAM532yWwWhKHbAbBOuudMlej9GepbQs5Q3ST6bUk+MF3Sy9KnOVjUL
        GolDQJfdV9fwJgMqRkApsifNBdZtVblh135TZbvfsQ==
X-Google-Smtp-Source: ABdhPJyuDHAkKuwK0QN430F33N+99p9Vhf/jnqueqby8Lbqd2MmB68lW2/3XLrOqyt9IzAM1A4MSEcYu0LJrdwU3Gck=
X-Received: by 2002:a62:7f87:0:b0:444:b077:51ef with SMTP id
 a129-20020a627f87000000b00444b07751efmr850946pfd.61.1632342425287; Wed, 22
 Sep 2021 13:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192865031.417973.8372869475521627214.stgit@magnolia> <20210918165408.ivsue463wpiitzjw@riteshh-domain>
 <20210920172225.GA570615@magnolia> <20210921040708.ojbbbt6i524wgsaj@riteshh-domain>
 <20210922182642.GJ570615@magnolia>
In-Reply-To: <20210922182642.GJ570615@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 22 Sep 2021 13:26:54 -0700
Message-ID: <CAPcyv4iDSk+-azs52cw-Aqs7yn0_hifqNgKtM1c68Wu_xam8RQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] dax: prepare pmem for use by zero-initializing
 contents and clearing poisons
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     riteshh <riteshh@linux.ibm.com>, Jane Chu <jane.chu@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 11:27 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Tue, Sep 21, 2021 at 09:37:08AM +0530, riteshh wrote:
> > On 21/09/20 10:22AM, Darrick J. Wong wrote:
> > > On Sat, Sep 18, 2021 at 10:24:08PM +0530, riteshh wrote:
> > > > On 21/09/17 06:30PM, Darrick J. Wong wrote:
> > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > >
> > > > > Our current "advice" to people using persistent memory and FSDAX who
> > > > > wish to recover upon receipt of a media error (aka 'hwpoison') event
> > > > > from ACPI is to punch-hole that part of the file and then pwrite it,
> > > > > which will magically cause the pmem to be reinitialized and the poison
> > > > > to be cleared.
> > > > >
> > > > > Punching doesn't make any sense at all -- the (re)allocation on pwrite
> > > > > does not permit the caller to specify where to find blocks, which means
> > > > > that we might not get the same pmem back.  This pushes the user farther
> > > > > away from the goal of reinitializing poisoned memory and leads to
> > > > > complaints about unnecessary file fragmentation.
> > > > >
> > > > > AFAICT, the only reason why the "punch and write" dance works at all is
> > > > > that the XFS and ext4 currently call blkdev_issue_zeroout when
> > > > > allocating pmem ahead of a write call.  Even a regular overwrite won't
> > > > > clear the poison, because dax_direct_access is smart enough to bail out
> > > > > on poisoned pmem, but not smart enough to clear it.  To be fair, that
> > > > > function maps pages and has no idea what kinds of reads and writes the
> > > > > caller might want to perform.
> > > > >
> > > > > Therefore, create a dax_zeroinit_range function that filesystems can to
> > > > > reset the pmem contents to zero and clear hardware media error flags.
> > > > > This uses the dax page zeroing helper function, which should ensure that
> > > > > subsequent accesses will not trip over any pre-existing media errors.
> > > >
> > > > Thanks Darrick for such clear explaination of the problem and your solution.
> > > > As I see from this thread [1], it looks like we are heading in this direction,
> > > > so I thought of why not review this RFC patch series :)
> > > >
> > > > [1]: https://lore.kernel.org/all/CAPcyv4iAr_Vwwgqw+4wz0RQUXhUUJGGz7_T+p+W6tC4T+k+zNw@mail.gmail.com/
> > > >
> > > > >
> > > > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > > > ---
> > > > >  fs/dax.c            |   93 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  include/linux/dax.h |    7 ++++
> > > > >  2 files changed, 100 insertions(+)
> > > > >
> > > > >
> > > > > diff --git a/fs/dax.c b/fs/dax.c
> > > > > index 4e3e5a283a91..765b80d08605 100644
> > > > > --- a/fs/dax.c
> > > > > +++ b/fs/dax.c
> > > > > @@ -1714,3 +1714,96 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
> > > > >         return dax_insert_pfn_mkwrite(vmf, pfn, order);
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(dax_finish_sync_fault);
> > > > > +
> > > > > +static loff_t
> > > > > +dax_zeroinit_iter(struct iomap_iter *iter)
> > > > > +{
> > > > > +       struct iomap *iomap = &iter->iomap;
> > > > > +       const struct iomap *srcmap = iomap_iter_srcmap(iter);
> > > > > +       const u64 start = iomap->addr + iter->pos - iomap->offset;
> > > > > +       const u64 nr_bytes = iomap_length(iter);
> > > > > +       u64 start_page = start >> PAGE_SHIFT;
> > > > > +       u64 nr_pages = nr_bytes >> PAGE_SHIFT;
> > > > > +       int ret;
> > > > > +
> > > > > +       if (!iomap->dax_dev)
> > > > > +               return -ECANCELED;
> > > > > +
> > > > > +       /*
> > > > > +        * The physical extent must be page aligned because that's what the dax
> > > > > +        * function requires.
> > > > > +        */
> > > > > +       if (!PAGE_ALIGNED(start | nr_bytes))
> > > > > +               return -ECANCELED;
> > > > > +
> > > > > +       /*
> > > > > +        * The dax function, by using pgoff_t, is stuck with unsigned long, so
> > > > > +        * we must check for overflows.
> > > > > +        */
> > > > > +       if (start_page >= ULONG_MAX || start_page + nr_pages > ULONG_MAX)
> > > > > +               return -ECANCELED;
> > > > > +
> > > > > +       /* Must be able to zero storage directly without fs intervention. */
> > > > > +       if (iomap->flags & IOMAP_F_SHARED)
> > > > > +               return -ECANCELED;
> > > > > +       if (srcmap != iomap)
> > > > > +               return -ECANCELED;
> > > > > +
> > > > > +       switch (iomap->type) {
> > > > > +       case IOMAP_MAPPED:
> > > > > +               while (nr_pages > 0) {
> > > > > +                       /* XXX function only supports one page at a time?! */
> > > > > +                       ret = dax_zero_page_range(iomap->dax_dev, start_page,
> > > > > +                                       1);
> > > > > +                       if (ret)
> > > > > +                               return ret;
> > > > > +                       start_page++;
> > > > > +                       nr_pages--;
> > > > > +               }
> > > > > +
> > > > > +               fallthrough;
> > > > > +       case IOMAP_UNWRITTEN:
> > > > > +               return nr_bytes;
> > > > > +       }
> > > > > +
> > > > > +       /* Reject holes, inline data, or delalloc extents. */
> > > > > +       return -ECANCELED;
> > > >
> > > > We reject holes here, but the other vfs plumbing patch [2] mentions
> > > > "Holes and unwritten extents are left untouched.".
> > > > Shouldn't we just return nr_bytes for IOMAP_HOLE case as well?
> > >
> > > I'm not entirely sure what we should do for holes and unwritten extents,
> > > as you can tell from the gross inconsistency between the comment and the
> > > code. :/
> > >
> > > On block devices, I think we rely on the behavior that writing to disk
> > > will clear the device's error state (via LBA remapping or some other
> > > strategy).  I think this means iomap_zeroinit can skip unwritten extents
> > > because reads and read faults will be satisfied from the zero page and
> > > writeback (or direct writes) will trigger the drive firmware.
> > >
> > > On FSDAX devices, reads are fulfilled by zeroing the user buffer, and
> > > read faults with the (dax) zero page.  Writes and write faults won't
> > > clear the poison (unlike disks).  So I guess this means that
> > > dax_zeroinit *does* have to act on unwritten areas.
>
> I was confused when I wrote this -- before writing, dax filesystems are
> required to allocate written zeroed extents and/or zero unwritten
> extents and mark them written.  So we don't actually need to zero
> unwritten extents.
>
> > >
> > > Ok.  I'll make those changes.
> >
> > Yes, I guess unwritten extents still have extents blocks allocated with
> > generally a bit marked (to mark it as unwritten). So there could still be
> > a need to clear the poison for this in case of DAX.
> >
> > >
> > > As for holes -- on the one hand, one could argue that zero-initializing
> > > a hole makes no sense and should be an error.  OTOH one could make an
> > > equally compelling argument that it's merely a nop.  Thoughts?
> >
> > So in case of holes consider this case (please correct if any of my
> > understanding below is wrong/incomplete).
> > If we have a large hole and if someone tries to do write to that area.
> > 1. Then from what I understood from the code FS will try and allocate some disk
> >    blocks (could these blocks be marked with HWpoison as FS has no way of
> >    knowing it?).
>
> Freshly allocated extents are zeroed via blkdev_issue_zeroout before
> being mapped into the file, which will clear the poison.  That last bit
> is only the reason why the punch-and-rewrite dance ever worked at all.
>
> We'll have to make sure this poison clearing still happens even after
> the dax/block layer divorce.
>
> > 2. If yes, then after allocating those blocks dax_direct_access will fail (as
> >    you had mentioned above). But it won't clear the HWposion.
> > 3. Then the user again will have to clear using this API. But that is only for
> >    a given extent which is some part of the hole which FS allocated.
> > Now above could be repeated until the entire hole range is covered.
> > Is that above understanding correct?
> >
> > If yes, then maybe it all depends on what sort of gurantee the API is providing.
> > If using the API on the given range guarantees that the entire file range will
> > not have any blocks with HWpoison then I guess we may have to cover the
> > IOMAP_HOLE case as well?
> > If not, then maybe we could explicitly mentioned this in the API documentation.
>
> Ok.  The short version is that zeroinit will ensure that subsequent
> reads, writes, or faults to allocated file ranges won't have problems
> with pre-existing poison flags.

s/won't/likely won't/

s/pre-existing/known pre-existing/

i.e. the guarantees of this interface is that it will have tried its
best to clean up media errors, and that may only be possible for pmem
if latent poison has been previously notified to the driver, and if
the driver supports error clearing. For example, if you're using
memmap=ss!nn to emulate PMEM with a DRAM range with poison I expect
that this routine will succeed even though no poison is corrected.
