Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7528222FE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 11:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbfETJKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 05:10:53 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37235 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfETJKx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 05:10:53 -0400
Received: by mail-yw1-f66.google.com with SMTP id 186so5573443ywo.4;
        Mon, 20 May 2019 02:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WO0nb0i3TlfUEi3Ta1dEHoPzpd1bYnb4mrBSpQaLWfM=;
        b=Xv0hYodwAou2zdmZxFJFkZxUeVf2epBSGZOWi2TyQkrLXK8DUAYF+ifb6tHe6uP1uJ
         WpIFKZqzTWDvwDlxDgVUR8RUElqV6b5mzhbhGUonKzOHzxIGbAfME2G07FUKU2zb8XCl
         kT1nIN4zh1LvcCTOmQeYmbJG6jMj8IX+OyaJ8uYq9msIUvr1n6BVU/Sg7iEt7A4rJZP6
         l26TIYtOAS+ByK2yoLoRUFW6ywzCkUOPdHMh3A2VoVhAUIp59Ikd0eZefAk8OcUUmC+J
         3YaaybhHqRgI1WA7XetpaCtWYUokDERoaOGtAXYMBoxHzFRbsI9JbgMJv2bUzKnpSM0z
         P/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WO0nb0i3TlfUEi3Ta1dEHoPzpd1bYnb4mrBSpQaLWfM=;
        b=eYOrWPR030iZWhZsRO0nHPUDOy0pzDriqNlX+sKWBZby3Ji9YGGc87StT9RnAQ/TXO
         AagjbZVMpq26aOytdZYrIc7WuZ0WdocDRLEFkCqyC7kXZfR+Oh0jZhOlMfknZEmujUO0
         kJA63vcExrdeQqXHTykQK6sis2Oh3sgIKvm8u8mOPelb8/vI0xfbhu2Z5+0uW7mKmAxI
         Hm/vmTIHzDXVibEGk1n6ufvEMwuwr70B9q5kK8YsKNy1KutuQM8TaCTpgOs++Ohur4v2
         R8AZNt7cXviajV4v3ilLFMJZYUtSn5cM2TYfEbq8RRk/JXFpuw51pmYPAQpF+XGQ+QlA
         QsKA==
X-Gm-Message-State: APjAAAWDxyTf561eOQec2t30li/AH1aVq3RHTkjaqjfTQV8KpfSwcfcG
        G3MmSfn7vxLwSDhD2eCoQFldiaHjGjR9oxu2QalVkUpS
X-Google-Smtp-Source: APXvYqx9mTAu+qQpn6hP0ibWMhR1UvqszSsJ9fuDVbqrSlIwIjiQ3UEY9jsYVs6CD9h8EHaHcN+sZy7TcOhwoQejgec=
X-Received: by 2002:a81:3344:: with SMTP id z65mr2829786ywz.294.1558343451573;
 Mon, 20 May 2019 02:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181203083416.28978-1-david@fromorbit.com> <20181203083416.28978-2-david@fromorbit.com>
 <CAOQ4uxhOQY8M5rbgHKREN5qpeDGHv0-xK3r37Lj6XfqFoE4qjg@mail.gmail.com>
 <20181204151332.GA32245@infradead.org> <20181204212948.GO6311@dastard>
 <CAN-5tyGU=y5JO5UNcmn3rX1gRyK_UxjQvQ+kCsP34_NT2-mQ_A@mail.gmail.com> <20181204223102.GR6311@dastard>
In-Reply-To: <20181204223102.GR6311@dastard>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 20 May 2019 12:10:39 +0300
Message-ID: <CAOQ4uxhPoJ2vOwGN7PFWkD6+_zdTeMAhT4KphnyktaQ23zqvBw@mail.gmail.com>
Subject: Re: [PATCH 01/11] vfs: copy_file_range source range over EOF should fail
To:     Dave Chinner <david@fromorbit.com>
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        ceph-devel@vger.kernel.org, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 5, 2018 at 12:31 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Dec 04, 2018 at 04:47:18PM -0500, Olga Kornievskaia wrote:
> > On Tue, Dec 4, 2018 at 4:35 PM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Tue, Dec 04, 2018 at 07:13:32AM -0800, Christoph Hellwig wrote:
> > > > On Mon, Dec 03, 2018 at 02:46:20PM +0200, Amir Goldstein wrote:
> > > > > > From: Dave Chinner <dchinner@redhat.com>
> > > > > >
> > > > > > The man page says:
> > > > > >
> > > > > > EINVAL Requested range extends beyond the end of the source file
> > > > > >
> > > > > > But the current behaviour is that copy_file_range does a short
> > > > > > copy up to the source file EOF. Fix the kernel behaviour to match
> > > > > > the behaviour described in the man page.
> > > >
> > > > I think the behavior implemented is a lot more useful than the one
> > > > documented..
> > >
> > > The current behaviour is really nasty. Because copy_file_range() can
> > > return short copies, the caller has to implement a loop to ensure
> > > the range hey want get copied.  When the source range you are
> > > trying to copy overlaps source EOF, this loop:
> > >
> > >         while (len > 0) {
> > >                 ret = copy_file_range(... len ...)
> > >                 ...
> > >                 off_in += ret;
> > >                 off_out += ret;
> > >                 len -= ret;
> > >         }
> > >
> > > Currently the fallback code copies up to the end of the source file
> > > on the first copy and then fails the second copy with EINVAL because
> > > the source range is now completely beyond EOF.
> > >
> > > So, from an application perspective, did the copy succeed or did it
> > > fail?
> > >
> > > Existing tools that exercise copy_file_range (like xfs_io) consider
> > > this a failure, because the second copy_file_range() call returns
> > > EINVAL and not some "there is no more to copy" marker like read()
> > > returning 0 bytes when attempting to read beyond EOF.
> > >
> > > IOWs, we cannot tell the difference between a real error and a short
> > > copy because the input range spans EOF and it was silently
> > > shortened. That's the API problem we need to fix here - the existing
> > > behaviour is really crappy for applications. Erroring out
> > > immmediately is one solution, and it's what the man page says should
> > > happen so that is what I implemented.
> > >
> > > Realistically, though, I think an attempt to read beyond EOF for the
> > > copy should result in behaviour like read() (i.e. return 0 bytes),
> > > not EINVAL. The existing behaviour needs to change, though.
> >
> > There are two checks to consider
> > 1. pos_in >= EOF should return EINVAL
> > 2. however what's perhaps should be relaxed is pos_in+len >= EOF
> > should return a short copy.
> >
> > Having check#1 enforced allows to us to differentiate between a real
> > error and a short copy.
>
> That's what the code does right now and *exactly what I'm trying to
> fix* because it EINVAL is ambiguous and not an indicator that we've
> reached the end of the source file. EINVAL can indicate several
> different errors, so it really has to be treated as a "copy failed"
> error by applications.
>
> Have a look at read/pread() - they return 0 in this case to indicate
> a short read, and the value of zero is explicitly defined as meaning
> "read position is beyond EOF".  Applications know straight away that
> there is no more data to be read and there was no error, so can
> terminate on a successful short read.
>
> We need to allow applications to terminate copy loops on a
> successful short copy. IOWs, applications need to either:
>
>         - get an immediate error saying the range is invalid rather
>           than doing a short copy (as per the man page); or
>         - have an explicit marker to say "no more data to be copied"
>
> Applications need the "no more data to copy" case to be explicit and
> unambiguous so they can make sane decisions about whether a short
> copy was successful because the file was shorter than expected or
> whether a short copy was a result of a real error being encountered.
> The current behaviour is largely unusable for applications because
> they have to guess at the reason for EINVAL part way through a
> copy....
>

Dave,

I went a head and implemented the desired behavior.
However, while testing I observed that the desired behavior is already
the existing behavior. For example, trying to copy 10 bytes from a 2 bytes file,
xfs_io copy loop ends as expected:
copy_file_range(4, [0], 3, [0], 10, 0)  = 2
copy_file_range(4, [2], 3, [2], 8, 0)   = 0

This was tested on ext4 and xfs with reflink on recent kernel as well as on
v4.20-rc1 (era of original patch set).

Where and how did you observe the EINVAL behavior described above?
(besides man page that is). There are even xfstests (which you modified)
that verify the return 0 for past EOF behavior.

For now, I am just dropping this patch from the patch series.
Let me know if I am missing something.

Thanks,
Amir.
