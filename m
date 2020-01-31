Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6936614F537
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 00:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgAaXcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 18:32:10 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42663 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgAaXcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 18:32:10 -0500
Received: by mail-oi1-f195.google.com with SMTP id j132so8965179oih.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2020 15:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbvzdoNUIaDNq+3zk83a56z2N8LGBGLQ9n7er2/J/Fc=;
        b=NobVDx/gd01Sll6Fd/Vcv5vLnnh9IpBkdCmAUSz+yxvtMkHRMHoT9UMW822cJqyfga
         IHhGXKPGIRoOs25ZUB4eR/Osb3Lj7veVqz4eBrV6NTfFdwPGdbDFL1Gx0LuUcJEplq1G
         ryuCo3IVpjtG3VW4thw9RUwAHcdBaJ0EZEF9/9WLWkBtA8iBqS/s4WSuXpgPSO+i1HA7
         4rRNghurksWFslBIYgRFflg4fnpqhmuadmeFDordOb0IH3RrElAQJ8a1ppu6cqkxI7VF
         P0OKh4QM1DB9ljpJiXpSuOJcVCBbFV+urrSvpDAF2s7NoogkKKDdf5k4/w1YUOc7O0NI
         RTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbvzdoNUIaDNq+3zk83a56z2N8LGBGLQ9n7er2/J/Fc=;
        b=s1enhFHASWOKdiuvbSzt+2PNLLeSad+VASVUotbFyJn7ftwTw0y4JM4KF3dOcs6oud
         W+l8qkp65iTs5u1xb9ReKrr2eFNKxjeos31u38GqDT3SkS8sMnsBMHNsHLTv5egKgvOA
         VjYjl8gDal0zIuA6DpCvuYnkRE+5G52CLYrIy5Cv+RLL9FLldV/8QGIQoMJQvTjEn2Zc
         pwyqbHCUqygIZFt2AjRiFoavSQaoj1Sn/VC9wnwGXtyz7Eg/AKXhqNtYzwEUxRd5lcrt
         qSpcpYH6K8ECbBjFjkWCvXjScjIjC6a4bOkgXmfduEIaENQ9QX4SK1Zmu4iaMLxPdedu
         0aoA==
X-Gm-Message-State: APjAAAV56h549Tv73/uBTcS17oIQJZiCFblb48EtYk+u1l1G+nPs9WSk
        O/8bPLUEeb+jyf6cYfANPsDdPwcLr/4I9foXlDrmk3JE
X-Google-Smtp-Source: APXvYqzy4XwNMjBVemev+5VjKUaUiGQr17Dr+lTA27hy9UvwPh/URJrCK0yRVnuVEljIQo3bIk2HK2DGzmqVBHngv+4=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr8258617oij.0.1580513529312;
 Fri, 31 Jan 2020 15:32:09 -0800 (PST)
MIME-Version: 1.0
References: <20200123165249.GA7664@redhat.com> <20200123190103.GB8236@magnolia>
In-Reply-To: <20200123190103.GB8236@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 31 Jan 2020 15:31:58 -0800
Message-ID: <CAPcyv4jT3py4gtdJo84i8gPnJo5MO4uGaaO=+fuuAjXQ0gQsHA@mail.gmail.com>
Subject: Re: [RFC] dax,pmem: Provide a dax operation to zero range of memory
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 11:07 AM Darrick J. Wong
<darrick.wong@oracle.com> wrote:
>
> On Thu, Jan 23, 2020 at 11:52:49AM -0500, Vivek Goyal wrote:
> > Hi,
> >
> > This is an RFC patch to provide a dax operation to zero a range of memory.
> > It will also clear poison in the process. This is primarily compile tested
> > patch. I don't have real hardware to test the poison logic. I am posting
> > this to figure out if this is the right direction or not.
> >
> > Motivation from this patch comes from Christoph's feedback that he will
> > rather prefer a dax way to zero a range instead of relying on having to
> > call blkdev_issue_zeroout() in __dax_zero_page_range().
> >
> > https://lkml.org/lkml/2019/8/26/361
> >
> > My motivation for this change is virtiofs DAX support. There we use DAX
> > but we don't have a block device. So any dax code which has the assumption
> > that there is always a block device associated is a problem. So this
> > is more of a cleanup of one of the places where dax has this dependency
> > on block device and if we add a dax operation for zeroing a range, it
> > can help with not having to call blkdev_issue_zeroout() in dax path.
> >
> > I have yet to take care of stacked block drivers (dm/md).
> >
> > Current poison clearing logic is primarily written with assumption that
> > I/O is sector aligned. With this new method, this assumption is broken
> > and one can pass any range of memory to zero. I have fixed few places
> > in existing logic to be able to handle an arbitrary start/end. I am
> > not sure are there other dependencies which might need fixing or
> > prohibit us from providing this method.
> >
> > Any feedback or comment is welcome.
>
> So who gest to use this? :)
>
> Should we (XFS) make fallocate(ZERO_RANGE) detect when it's operating on
> a written extent in a DAX file and call this instead of what it does now
> (punch range and reallocate unwritten)?

If it eliminates more block assumptions, then yes. In general I think
there are opportunities to use "native" direct_access instead of
block-i/o for other areas too, like metadata i/o.

> Is this the kind of thing XFS should just do on its own when DAX us that
> some range of pmem has gone bad and now we need to (a) race with the
> userland programs to write /something/ to the range to prevent a machine
> check (b) whack all the programs that think they have a mapping to
> their data, (c) see if we have a DRAM copy and just write that back, (d)
> set wb_err so fsyncs fail, and/or (e) regenerate metadata as necessary?

(a), (b) duplicate what memory error handling already does. So yes,
could be done but it only helps if machine check handling is broken or
missing.

(c) what DRAM copy in the DAX case?

(d) dax fsync is just cache flush, so it can't fail, or are you
talking about errors in metadata?

(e) I thought our solution for dax metadata redundancy is to use a
realtime data device and raid mirror for the metadata device.

> <cough> Will XFS ever get that "your storage went bad" hook that was
> promised ages ago?

pmem developers don't scale?

> Though I guess it only does this a single page at a time, which won't be
> awesome if we're trying to zero (say) 100GB of pmem.  I was expecting to
> see one big memset() call to zero the entire range followed by
> pmem_clear_poison() on the entire range, but I guess you did tag this
> RFC. :)

Until movdir64b is available the only way to clear poison is by making
a call to the BIOS. The BIOS may not be efficient at bulk clearing.
