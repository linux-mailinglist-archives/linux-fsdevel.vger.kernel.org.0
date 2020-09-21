Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747EE272C4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 18:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgIUQ3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 12:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgIUQ3w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:29:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53693C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2020 09:29:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e22so13447051edq.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2020 09:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZaQa7Abtd+8UEp0nRWic7q85wZ9hYgwWkThXnfGTs2A=;
        b=MLvu1XiM37JMQAK8mcEAQHS7riWkwtKaVBpKVAYWsDADTla2z7wxFBQoQoZCPCosWu
         k/xyc4pdz/9ctIx9GtYlGlNWsy/Pq594BO8Ux18yfFhw4E6jW0wTKVu7AKILG67S52RN
         GGvi49YkmH7M1+9Fakpl6Bb+YwZKsK6ZKAikMWXr6j7rkLmxEkc25JkOME2lEo+9Ms2O
         QoqS6rQwQOk2h7O09zMq9bzGo/ZBnyBFwdtXBH7y/JJmm+olQLKajFFxIb2p2diy4C8c
         9YMzMAlsTE2VcjvWm1xEqIOQL/Vf82jNw41tlOlf8z4RH5kZrZQitdWYhrgAFokomH7+
         wa+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZaQa7Abtd+8UEp0nRWic7q85wZ9hYgwWkThXnfGTs2A=;
        b=H2EimZkUd6liHwO96GfMF76H/V0rWOKkC2s/GtGW50QravRUmeHmTNLYi0ptdlIGJd
         DxQKDCz1G+cLMEIiObmnix0+3iIAEXXc+U5JndM35sBHAhHwzJ9Sd13NqZCJ8OPJUMzZ
         e2YEuCidTT7XIRthBHqa2D+u+Llw/L9qAw15+YiaE7UHd/UenwPApHgcgfaVpe9Exv99
         UePVdv14r+pWZ1Xi2IkeUvtQIKj/y5PRbg18Z6evVBz5S+EmaEyhA3Akpm9wYNQjfb86
         uqeNbG7P/NbskX7U4fzBebf3CYVihhhepEEf5gxPS7QeTMmvbVLlp4bVaQZfgU0zPGnU
         4VKg==
X-Gm-Message-State: AOAM531ovE9GvsW9aTvQg6whvrGet2yNuFwhE/HDZsy2ezV4PwONLsno
        IOWLWHvlEx+uOcTOmHLrFRt8coBAGStbfcD0gwicYg==
X-Google-Smtp-Source: ABdhPJwheY2Lh1Ak+5XOojdS0UI6tT1hZiNEqs83oA0r33KKqLLs9hbC0JRM9HMp7eSFZRFsaag+Z+HNQGPl7N6O5UQ=
X-Received: by 2002:aa7:c511:: with SMTP id o17mr500351edq.300.1600705790950;
 Mon, 21 Sep 2020 09:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com> <alpine.LRH.2.02.2009211133190.15623@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2009211133190.15623@file01.intranet.prod.int.rdu2.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 21 Sep 2020 09:29:39 -0700
Message-ID: <CAPcyv4iys4xDnDyuzo4yj1MvOWXkQ_NgPfupB=btZt_kzi29Ug@mail.gmail.com>
Subject: Re: [RFC] nvfs: a filesystem for persistent memory
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" 
        <rajesh.tadakamadla@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 21, 2020 at 9:19 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Tue, 15 Sep 2020, Dan Williams wrote:
>
> > > TODO:
> > >
> > > - programs run approximately 4% slower when running from Optane-based
> > > persistent memory. Therefore, programs and libraries should use page cache
> > > and not DAX mapping.
> >
> > This needs to be based on platform firmware data f(ACPI HMAT) for the
> > relative performance of a PMEM range vs DRAM. For example, this
> > tradeoff should not exist with battery backed DRAM, or virtio-pmem.
>
> Hi
>
> I have implemented this functionality - if we mmap a file with
> (vma->vm_flags & VM_DENYWRITE), then it is assumed that this is executable
> file mapping - the flag S_DAX on the inode is cleared on and the inode
> will use normal page cache.
>
> Is there some way how to test if we are using Optane-based module (where
> this optimization should be applied) or battery backed DRAM (where it
> should not)?

No, there's no direct reliable type information. Instead the firmware
on ACPI platforms provides the HMAT table which provides performance
details of system-memory ranges.
